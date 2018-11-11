docker build -t taman9333/multi-client:latest -t taman9333/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t taman9333/multi-server:latest -t taman9333/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t taman9333/multi-worker:latest -t taman9333/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push taman9333/multi-client:latest
docker push taman9333/multi-server:latest
docker push taman9333/multi-worker:latest

docker push taman9333/multi-client:$SHA
docker push taman9333/multi-server:$SHA
docker push taman9333/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=taman9333/multi-server:$SHA
kubectl set image deployments/client-deployment client=taman9333/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=taman9333/multi-worker:$SHA