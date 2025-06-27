# Change to the demo folder
Set-Location Configuration
. "..\..\CISendMessage.ps1"

read-host "Navigate to the Deployments page"
SendMessageToCI "The following demo illustrates various ways to use ConfigMaps and Secrets in Kubernetes." "ConfigMaps and Secrets:" "Info"

read-host "Next Step - Creates initial configuration and deployment"
SendMessageToCI "kubectl apply -f simple-configmap.yaml" "Kubectl command:" "Command"
kubectl apply -f simple-configmap.yaml
SendMessageToCI "kubectl apply -f simple-configmap2.yaml" "Kubectl command:" "Command"
kubectl apply -f simple-configmap2.yaml
SendMessageToCI "kubectl apply -f simple-secret.yaml" "Kubectl command:" "Command"
kubectl apply -f simple-secret.yaml
SendMessageToCI "kubectl apply -f simple-secret2.yaml" "Kubectl command:" "Command"
kubectl apply -f simple-secret2.yaml
SendMessageToCI "kubectl apply -f workload-1-dep.yaml" "Kubectl command:" "Command"
kubectl apply -f workload-1-dep.yaml

read-host "Next Step - Creates file-config and redeploy"
SendMessageToCI "kubectl apply -f file-configmap.yaml" "Kubectl command:" "Command"
kubectl apply -f file-configmap.yaml
SendMessageToCI "kubectl apply -f file-secret.yaml" "Kubectl command:" "Command"
kubectl apply -f file-secret.yaml

read-host "Next Step - Update Deployment to mount configmap/secret as volumes"
SendMessageToCI "volumes:\n- name: configmap-volume\n  configMap:\n    name: file-configmap\n- name: secret-volume\n  secret:\n    secretName: file-secret" "Deployment YAML Changes:" "Code"
SendMessageToCI "containers:\n- name: workload\n  volumeMounts:\n  - name: configmap-volume\n    mountPath: /config-data\n  - name: secret-volume\n    mountPath: /secret-data" "Deployment YAML Changes:" "Code"
SendMessageToCI "kubectl apply -f workload-1-dep-cm-volume.yaml" "Kubectl command:" "Command"
kubectl apply -f workload-1-dep-cm-volume.yaml

read-host "Next Step - Clean up."
SendMessageToCI "kubectl delete deploy workload-1-dep" "Kubectl command:" "Command"
kubectl delete deploy workload-1-dep
SendMessageToCI "kubectl delete configmap -l scope=demo" "Kubectl command:" "Command"
kubectl delete configmap -l scope=demo
SendMessageToCI "kubectl delete secret -l scope=demo" "Kubectl command:" "Command"
kubectl delete secret -l scope=demo
Set-Location ..
