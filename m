Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE33A4F2C
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147793; cv=none; b=F/hhOjt69jS34f1o11nC1q9YxzFSi2BB9CMYBTFoox/Ijbb4SX70Zt5J1t7sYhGcmw8m1IOd99RQNmQjdY2Hu1DRE0Vs8Tpp9vWUQUk5fO7vr3NDdOlyM6BqeZkvDLmRyuntY1VM96z7Eu4nNBsS6s1/QWSHg9DhZQN+q/SvEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147793; c=relaxed/simple;
	bh=jhUncZD3/v2hCN3keR/V9NE2HFZHMAdLaTFWgvzUebk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ijEzhKIL5rSt8OJjPRnQtDHrCUXqDAMEnWZPx7sCLVeC+UbaLWPT2a/lBtHsw4gMjSOWlpQpHpLiIS1GRHpzoy+nlfm/jsN4hgI1C+OAbo9yvcQMPNC0veVIagt3NS94Mzw3o6vkgaKkbxGJRaajyS5zdbAPk1E9ZVNqujl1W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdGR7X5g; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdGR7X5g"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d58c513dbso4469381cf.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147791; x=1775752591; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq5to2v8GVwMu7713BpbM869gsD0uKjodIfcDYVfq/c=;
        b=sdGR7X5g/9TOCf7+02bMFZxAkTtHd2QDuMZ0Z2RiYoUJ5pgO5UG9fcCD7BTB3Cx4oe
         sywZ1/6CH4rIch5UVrBdw8LmPchdtl+zV3ThHCumX8ydddzoiyTcVpBkB9rJ84fwhpv8
         40M3m1hPWiZHnCPo3aPMSXxsRJhiAw2ZAP19TD36nnlyHVTgECuVdHsRu9Xq7Z3UDLjU
         ks7Q2ZNtNhx4/JGlb62IZFXVl0kcg0WJfi8ZtioIb9NE1+tDAYZLQBjp+Lyxo5F6ToNa
         7vRk0oDNGtJUlZbrsoB6AYU+AoJqU8S6tCyQhkcOSD2SFzR9OojqqQFznr8n3o1lWW3l
         +Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147791; x=1775752591;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq5to2v8GVwMu7713BpbM869gsD0uKjodIfcDYVfq/c=;
        b=mmNp4jTlkqk8Cyt1tmJadvD1YZXQYQ1blX8/FZqT/vuMcq9B/PJAqpprUEpNDHIgBj
         WyzI2nFE7jYwEip/GwDmHISwU7cO4gSAPB7s7q7LA7EYXes2rrGbZrJi9KzlNyMQszoi
         gy3kjzRwXKvUh4s9M+BQgx9bjngD0d0/AHS5iuLF2AiVmlFcECJXzo6PeC3Vo/lP7TpG
         /H1iUQVYho+ovgqqTvRY0+517kmQ/xq9wd1q3dZxD4qfo9GVzUgWnTECDD4NmLKuQN7R
         mxygQDNPqsABhh2dKscxRfI8WjtY9SUWmQzHrbhuNFXAtR9Rfz5ru8HMiWu6vh7gH2hO
         5n2Q==
X-Gm-Message-State: AOJu0Yx0sf6GUXeacuftP0zxQ6qZWNjtlksS1XSahvSHt5rp+/nYMFHk
	cmhwl9/SIOfsKGdj3YjjUd+9NU/TeSQsz+u5Y8wQr3Aqq15Y9tzVbJE4gMX1VA==
X-Gm-Gg: AeBDievdvFyTSzGSa5hcWc4CQ1b0LsI6lXzUVQEYTMhmOj7kF5vdykVYAsYvMXBLL0K
	javPu8lQOGuqw8bm51kS+QjneMFFCFL/kVrVzcdiVtcMfl9HbLt/GMvqcTivOHoDBmIMzKZ/263
	RCX1abVTf3RDPDh39OtZwVC5wOmdkxUa0A6BS6/EKuZD/cFseAPyLAWeSS9YiGGQnpJCtCPieYC
	tV3T7wij83YlgaRiWE+vn24bIz/8Sr60f5AndOdmHcL+UllIUjzuRET0HQD0mBf9FtJmc8vrO4p
	ajlXNgFA6rQ5o8Gg+oqGkGD6dX06SUJOQiDOEJXkcFP1ixFBpqaqWvFDkyMfa+3DoiC1z8FB71Q
	czhmImGL06JMgYlYYYqoLPFW0MXy/U7IL1Sn9rzqvpOHw0TSK83Rlj0jJ6nqXcuB5jJ4U9TqMb6
	XsKqaFUUdfygGx/ZA43ZjFriFH3g==
X-Received: by 2002:a05:6214:dca:b0:8a1:6509:9cbf with SMTP id 6a1803df08f44-8a43ac4811emr123033196d6.52.1775147790804;
        Thu, 02 Apr 2026 09:36:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.179.93.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03febsm32532136d6.38.2026.04.02.09.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:36:30 -0700 (PDT)
Message-Id: <pull.2248.v2.git.git.1775147789459.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
References: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 16:36:29 +0000
Subject: [PATCH v2] tests: use test_path_is_missing instead of '! test -f'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

Using plain "test" commands in a sequence of checks chained
with `&&` makes it difficult to determine which step failed,
as "test" silently succeeds or fails.

In this case, we expect that `.git/refs/heads/f` no longer
exists. Replacing `! test -f` with `test_path_is_missing`
preserves the expected behavior when the file is absent,
but provides a clearer diagnostic when it unexpectedly
exists, making test failures easier to debug.

Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com]
---
    [GSoC] :pack-refs-tests: fix helper usage
    
    
    High-level (Intent & Context)
    =============================
    
    The test script t/pack-refs-tests.sh has two issues that prevent it from
    running correctly.
    
    It uses: ! test -f .git/refs/heads/f
    
    This is inconsistent with the Git test framework, where helper functions
    such as test_path_is_missing should be used instead of raw test checks.
    
    
    Low-level (Implementation & Justification)
    ==========================================
    
    Without sourcing test-lib.sh, the test framework is not initialized,
    leading to errors such as: test_expect_success: not found
    
    Replaced raw file check with the appropriate helper:
    
    - ! test -f .git/refs/heads/f
    + test_path_is_missing .git/refs/heads/f
    
    
    
    Summary
    =======
    
    Replace test -f with test_path_is_missing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2248%2Fjayesh0104%2Ffix-pack-refs-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2248/jayesh0104/fix-pack-refs-test-v2
Pull-Request: https://github.com/git/git/pull/2248

Range-diff vs v1:

 1:  b6b9d11ed8 ! 1:  82c31d9257 t/pack-refs-tests: drop '-f' from test_path_is_missing
     @@ Metadata
      Author: jayesh0104 <jayeshdaga99@gmail.com>
      
       ## Commit message ##
     -    t/pack-refs-tests: drop '-f' from test_path_is_missing
     +    tests: use test_path_is_missing instead of '! test -f'
      
     -    test_path_is_missing expects exactly one argument: the path to
     -    check for absence. Passing '-f' is incorrect and results in
     -    "bug in the test script: 1 param" during test execution.
     +    Using plain "test" commands in a sequence of checks chained
     +    with `&&` makes it difficult to determine which step failed,
     +    as "test" silently succeeds or fails.
      
     -    The '-f' flag appears to have been carried over from the
     -    equivalent 'test -f' usage, but test_path_is_missing does not
     -    accept such flags.
     +    In this case, we expect that `.git/refs/heads/f` no longer
     +    exists. Replacing `! test -f` with `test_path_is_missing`
     +    preserves the expected behavior when the file is absent,
     +    but provides a clearer diagnostic when it unexpectedly
     +    exists, making test failures easier to debug.
      
     -    Remove the extraneous '-f' to use the helper correctly and
     -    restore proper test behavior.
     -
     -    Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
     +    Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com]
      
       ## t/pack-refs-tests.sh ##
      @@ t/pack-refs-tests.sh: test_expect_success 'see if a branch still exists after git ${pack_refs} --prune


 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..4a85d96c6b 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '

base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
-- 
gitgitgadget
