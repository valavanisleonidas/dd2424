% function num_grads = ComputeGradsNum(X, Y, RNN, h)

% for f = fieldnames(RNN)'
%     disp('Computing numerical gradient for')
%     disp(['Field name: ' f{1} ]);
%     num_grads.(f{1}) = ComputeGradNumSlow(X, Y, f{1}, RNN, h);
% end

function grad = ComputeGradNum(X, Y, RNN, h)

f = fieldnames(RNN)';
[~, n] = size(f);
grad = zeros(n, 1);
hprev = zeros(size(RNN.W, 1), 1);
for i=[5 6 8 9 10]
  RNN_try = RNN;
  RNN_try.(f{i}) = RNN.(f{i}) - h;
  l1 = ComputeLoss(X, Y, RNN_try, hprev);
  RNN_try.(f{i}) = RNN.(f{i}) + h;
  l2 = ComputeLoss(X, Y, RNN_try, hprev);
  grad(i) = (l2-l1)/(2*h);
end
