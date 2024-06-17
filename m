Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FB367
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593723; cv=none; b=ZZRXlugw9JZLTLoQFa6voCu+Nxz56GR1iLYu2WJUHRbBF+yb7BVWrWXB0F3+x+RVEyM7x1G5cBvtA/9jttlREEPIZFVDpJDNpQ8P/6qLLFS25Vjnt9cD5eB0hSilC925tL1w0to5pVza0oPuGiTyuj0HUDPhIgJJG6aCrBI4HG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593723; c=relaxed/simple;
	bh=JS+sFKSxem0uweiH753I+if9XrzhJzUOITyckFmH5hw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rgRBybYRbYNhzDxz8mCpvZCQskjH4itBODg6K78xz76gJ80XEm57uRnAcOPQetRiVUHcJavawCLDftXJpsyqx+Hj7WsGIjY8/51Mv7TPnwE1l4bN/AIXVT6LFvBppLafacxMtYzuQTIP8MiZDoMzTJ2Hw18ruRjYMdmsj6JBekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1EB9tPo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1EB9tPo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42172ed3597so24153475e9.0
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 20:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718593720; x=1719198520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4lxPB/8ZkAMiO1y7issmbE0O1PLjfnwlsS7XVGJQSk=;
        b=A1EB9tPo0JWHHOrYNsKINy+S8Z1PjyKF/dPy77fCf9be4Kh+wv0os+uyZ5hi9xmZJO
         elCO97K9qs7G0hg3BfQie+Lztge7oiF0MaJ7sB1RmQJD8aa18Jwc1LlmZV6lpkoC00GB
         s3iiI28DgNxzQz/ogmzLaAvyg8wvxoZfl2a23rRb89p/ycXOp9dWR+tphYMHd6id4Gh9
         AbTfrNEa6e6Ra0bFqtNEL1K97fhMZdit7avQxYiZhiOuCB0hbo27ei11x9Xf/N5QeKwA
         7xAERpL0UZEqi8CtG5MuuRTQtQy0He3kHMIAOwTYvLweFomMjPK+Y18hpnftbKhb52nK
         fWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718593720; x=1719198520;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4lxPB/8ZkAMiO1y7issmbE0O1PLjfnwlsS7XVGJQSk=;
        b=uxsEgUqmuwpQtjSks/0haHWt74FKEbXXoGe5IhBWaaIzcSkOzrG9WeEPaNoZlVlsKT
         4KeMc+VwuzItKfwEgjTfRMxeBBqiMLofmcLGWgAIb5FPaB7ohQ0vKWtlNtDhoYL19gRT
         XrynKVBhx7figxzZ4ZIYEZNQGHaa2fNHfZ2N2t97GGzftsWhHrIpz4v7QYcrBEaTGYQa
         aIfgngYbJub8jE8oHDh0nY1HRoEsGMJuvVfL8OSVqGUCHsThukPAPn0ZxGg91xkfod0x
         EyyRkb1RFtwDU1D/I5mBVsrnjLIkpHPyTThW6gaX9kUFOoaX66ZVRb+bCRupAgrGuG1P
         fq6g==
X-Gm-Message-State: AOJu0Yy18ZyKrhoTaQwFTRyQm8AdgSeejw2bMEcbOq3HJ+g/NrLiQ8V3
	MfMpTUVM5Crb969mf4mUUJtqkS4vFTM0BciKEaK9f8oks6jvzqEpVJehlg==
X-Google-Smtp-Source: AGHT+IElFmWD6RoP8yO6u6hidfDVzYxbOrq7tuCVL4nyUzgmoQc58HMiFQABUCzHIOTNEQCd0ohlbw==
X-Received: by 2002:a05:600c:1c07:b0:422:eee2:573b with SMTP id 5b1f17b1804b1-423048448a8mr84043055e9.13.1718593719368;
        Sun, 16 Jun 2024 20:08:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e986asm186628165e9.27.2024.06.16.20.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 20:08:38 -0700 (PDT)
Message-Id: <pull.1731.v6.git.1718593717745.gitgitgadget@gmail.com>
In-Reply-To: <pull.1731.v5.git.1718173639942.gitgitgadget@gmail.com>
References: <pull.1731.v5.git.1718173639942.gitgitgadget@gmail.com>
From: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 03:08:37 +0000
Subject: [PATCH v6] merge: avoid write merge state when unable to write index
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

Writing the merge state after the index write fails is meaningless and
could potentially cause Git to lose changes.

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
    git checkout master
    echo "1" >> 1.txt && git add . && git commit -m "3"
    # another git process runnning
    touch .git/index.lock
    git merge source-branch
    # another git process finished
    rm .git/index.lock
    git commit -m "4"
    
    
    Then the modifications from the source branch are lost.
    
    Regards, Kyle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1731%2Fkeyu98%2Fkz%2Ffix-merge-when-index-lock-exists-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1731/keyu98/kz/fix-merge-when-index-lock-exists-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1731

Range-diff vs v5:

 1:  a5156088514 ! 1:  24150cd814a merge: avoid write merge state when unable to write index
     @@ Metadata
       ## Commit message ##
          merge: avoid write merge state when unable to write index
      
     -    When running a merge while the index is locked (presumably by another
     -    process), the merge state is written, the index is not updated, and then
     -    the merge fails. This might cause unexpected results.
     -
     -    E.g., if another running process is "git commit", MERGE_HEAD and other
     -    state files we write on our side will be taken into account by them and
     -    cause them to record a merge, even though they may have been trying to
     -    record something entirely different.
     +    Writing the merge state after the index write fails is meaningless and
     +    could potentially cause Git to lose changes.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
      


 builtin/merge.c  |  2 +-
 t/t7600-merge.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e2..03c405fa5df 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -701,7 +701,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
 					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
 					 NULL) < 0)
-		return error(_("Unable to write index."));
+		die(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
 	    !strcmp(strategy, "ort")) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5ff073099a..ef54cff4faa 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -236,6 +236,16 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
+test_expect_success 'merge c1 with c2 when index.lock exists' '
+	test_when_finished rm .git/index.lock &&
+	git reset --hard c1 &&
+	>.git/index.lock &&
+	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_MODE &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_expect_success 'merge --squash c3 with c7' '
 	git reset --hard c3 &&
 	test_must_fail git merge --squash c7 &&

base-commit: d63586cb314731c851f28e14fc8012988467e2da
-- 
gitgitgadget
