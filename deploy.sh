docker build -t smett00/multi-client:latest -t smett00/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smett00/multi-server:latest -t smett00/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smett00/multi-worker:latest -t smett00/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push smett00/multi-client:latest
docker push smett00/multi-server:latest
docker push smett00/multi-worker:latest

docker push smett00/multi-client:$SHA
docker push smett00/multi-server:$SHA
docker push smett00/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smett00/multi-server:$SHA
kubectl set image deployments/client-deployment client=smett00/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=smett00/multi-worker:$SHA