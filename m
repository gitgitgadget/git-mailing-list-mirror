Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB311182
	for <git@vger.kernel.org>; Thu, 16 May 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715836125; cv=none; b=aTvehXyEWuCzjY3L5OQRMzC3qLP02PeUe+Lr/vXJ/on5vNYqn5Dd8nhcIdAzrwvi6yLqjZiRoikiz8ucRudJYwMu7hMTvb5oGKNzL9M8n0Jw8PEL/C74k+NNdV3VP8rk/ggY9gsLNunJTe0ub03Yg23jXEbYnRNk80AIpqej7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715836125; c=relaxed/simple;
	bh=9Go0fcVASNJ2p48AqWz0BdrZ0A70MNgXwK5yLQ2ebZY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JlgCGcyWsuReO+vkWwBVYspAuklwKa5ee6ztmbEZ5NQVWVjHYT/7yBA+IIvSI3hlTR0lst/CAud2nasLF0ygJwljHZ9N1mxtRumLMH3vJ9PpIOiwybEcNaCZYvrbW6yOu82LboGzcptLlTjFhjc82HYPcFB/pTiQDpyz0E2A2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjNNXbte; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjNNXbte"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202ca70287so455185e9.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715836122; x=1716440922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nMdBO7SmPY8MBWcqk/BhjRGLLxh8cJwMCx5UYVpcWiA=;
        b=mjNNXbtehfckQ9OEnfA/MXsymJ4BqrueoPLggd4jMlK2oI/jgx3tJHJUHPzTp0IBP8
         oYP2mZ8ZLo1NiKTyyW44+ijMvFhEJpzZAPeW27mxtrjRwVucZRm5nIoaslqrFzQZaDCe
         8zR8+uLvKu7ZHDRaiFffh4jtHB25hzLzibnH2bSKemcMgJHcgF9MGx+OdAQrOmXM1RFD
         rH7OUTzxiOuybsLs3HtqpPatCMynYVjKQ16HaRcvf1xEhhrwqy9/bHReYr9dLOaWN3jx
         Hhsiw76kQn6AJioxdOKG9s08zJ2Uw97G0Cw90OAezc+DQoZpX6Dn7TD47ZOyljytEgHG
         OpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715836122; x=1716440922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMdBO7SmPY8MBWcqk/BhjRGLLxh8cJwMCx5UYVpcWiA=;
        b=D+D2aJJ7AOj+DgQOQdVOVEacKIUnz8p+npK+zrNrQkLkaG99gzwqKAXAm7iF0rhg05
         dLjSXTW8mhEpz7aWDxG4lJKacfRVB6b6MQNvvj24cJ/Let8rWa3yOCMJBkjAw89XneAm
         trvdFVwi17Z+adZS5EfePnbkWGrOd7gdY3/RhSMz605sTB44f6FjSMk+MCo522IdXQVd
         H4bnWKYleKorNwyiPENj3zR5DmCv5t0JnY4qrJi0SXX6UOo+ebhGRAN6wDkArD5oPPKB
         a/BsUMkdfR+Hl+IWzvvfIe4QWs57ceJOlIhHo38w7g8Sfuc9X9b/2Cnimc++E7jnFHSK
         fGjw==
X-Gm-Message-State: AOJu0YxVtjixb1wRnMlwnGXQEBF4VJbfzANDcpGMA+X5OQao0nf66ImV
	ZNa/0sp6tBMBzGTEwXlaWKsW7JyZzo2VQkWFAKoxKWxo1+KbtLfxg5ZeTg==
X-Google-Smtp-Source: AGHT+IENczOsDKuMO0GyR2rVK5IcjVCqVeyLo1S+Mim2EskQ8eoJC6gHc/K/61lbxWNMsoNx48ac8A==
X-Received: by 2002:adf:f590:0:b0:34c:b86a:794c with SMTP id ffacd0b85a97d-3504a96b845mr16818567f8f.70.1715836121837;
        Wed, 15 May 2024 22:08:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7826sm17859133f8f.52.2024.05.15.22.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 22:08:41 -0700 (PDT)
Message-Id: <pull.1731.git.1715836120584.gitgitgadget@gmail.com>
From: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 May 2024 05:08:40 +0000
Subject: [PATCH] merge: avoid write merge state when unable to write index
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
Cc: Kyle Zhao <kylezhao@tencent.com>,
    Kyle Zhao <kylezhao@tencent.com>

From: Kyle Zhao <kylezhao@tencent.com>

Currently, when index.lock exists, if a merge occurs, the merge state
will be written and the index will be unchanged.

If the user exec "git commit" instead of "git merge --abort" after this,
the commit will be successful and all modifications from the source
branch will be lost.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    merge: avoid write merge state when unable to write index
    
    In some of our monorepos, code is sometimes lost after merging.
    
    After investigation, we discovered the problem.
    
    This happens if we perform "git pull" or "git merge" when another git
    process is writing to the index, especially in a monorepo (because its
    index will be larger).
    
    How to reproduce:
    
    git init demo
    cd demo
    touch 1.txt && git add . && git commit -m "1"
    git checkout -b source-branch
    touch 2.txt && git add . && git commit -m "2"
    echo "1" >> 1.txt && git add . && git commit -m "3"
    touch .git/index.lock
    git merge source-branch
    rm .git/index.lock
    git commit -m "4"
    
    
    Then the modifications from the source branch are lost.
    
    Regards, Kyle
    
    cc: Elijah Newren newren@gmail.com cc: Ævar Arnfjörð Bjarmason
    avarab@gmail.com cc: Junio C Hamano gitster@pobox.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1731%2Fkeyu98%2Fkz%2Ffix-merge-when-index-lock-exists-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1731/keyu98/kz/fix-merge-when-index-lock-exists-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1731

 builtin/merge.c  |  6 ++++--
 t/t7600-merge.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6a6d3798858..80e3438be25 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -698,8 +698,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
 					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
-					 NULL) < 0)
-		return error(_("Unable to write index."));
+					 NULL) < 0) {
+		error(_("Unable to write index."));
+		return 2;
+	}
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
 	    !strcmp(strategy, "ort")) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5ff073099a..f03709ea4be 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -236,6 +236,16 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
+test_expect_success 'merge c1 with c2 when index.lock exists' '
+	test_when_finished rm .git/index.lock &&
+	git reset --hard c1 &&
+	touch .git/index.lock &&
+	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_MODE &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_expect_success 'merge --squash c3 with c7' '
 	git reset --hard c3 &&
 	test_must_fail git merge --squash c7 &&

base-commit: 19fe900cfce8096b7645ec9611a0b981f6bbd154
-- 
gitgitgadget
