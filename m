Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C789167DA0
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173645; cv=none; b=Lz66mrWizXS7INihhdaj1ANEAb0IGSIh9jH9sRFwpemGHpBDr9Su8X6PnsUhHW19xA9EwAwaiaa8fdxM9ValZa/gMHfCJ9FGx7Gam++48Qq/vlfrmT7Yic6NPhfJp+1hAWnJJZAcJM1DdOJCKVkE27OACc6jLBTyah9VCxOunQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173645; c=relaxed/simple;
	bh=YIPIgyNIc+LeNO9YfnREF9wMfAzMlInag+jlclhgzsg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RTqiFwutSP34lw49IPPvZI52itZvUL5eITrv1lxOkMTVJBRUKgDHpr6GbwwC1Gf8+wLESX2yXHayygO34ewsI7sfga0XPwMP2cNBmEvSYYHLhJwrJ3pSL70hz41WbuiQpWsSVgRKUPV81nSrUUhBtiX4O5tA3wE0fWMzezHCKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHgnRx16; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHgnRx16"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42108856c33so2886695e9.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718173642; x=1718778442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkkkJNoH8RoNxrCljtE2o7c3D6vhGV7MqqhfdRNZieI=;
        b=BHgnRx16uM6xoaP7gXxAahSdjkeRHM0gY1I5Mn0HGmEZk3icbf0tKSpxdmpY/AqJOK
         P0/a76tKvKeNyIoKh5OCQXv4mh0fF1RGkq4Yw0U1ClrirNVX23B0bcBbwGFow7/HoN1C
         TQKEpbijF6EFFxim0qQx60EbKgaifRnToNVebf7pfREvQF1irzvp31CuXUVw6RxZUCNI
         o5iQK8u6lokOJmNStXIj38DDiqxIYmrLYg3jqTool9ROYnI5aLmy/2pLa0J/Ze01BMaH
         x1TDvcF4ShDLy0mZY2TRpPLfCMtxi9tlgOiCuAE+Jckln4Q6JvPwunJsZ2wShTpf7tYd
         JvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173642; x=1718778442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkkkJNoH8RoNxrCljtE2o7c3D6vhGV7MqqhfdRNZieI=;
        b=XFAjK+KLRMKMsPwSJYVw9JHnohmMkgyK6ovrkBq/vhVu9mQKM4NV0H00F45f3Z8qYq
         APlQo9wPo/WYdwZlRBilYDG9frU+K86jwKHBU7lj8pftHZFakF6D/WedR1/R1iqeGdQF
         72obxhPv7KO3AXVuYXzriM9drH+DOzkxMUBR3gWWoJGosR/CmEiop3SNDlYP1+8Ftr94
         1Y1rIA50rtOX29kVKW6xz0UmscjqlEUrJHBr1Dhik8nTTO+mehR3bSbQHlWcxnSa1pIw
         L57qaZwe7qMTNRbTzgQzuy0KOHyV38dlawRtiPiYsfW1Dlu0jbaoCGYEpLMqLHirCUqW
         xIpw==
X-Gm-Message-State: AOJu0YxHyPFxQkgy6mi61BMyhMHoDptry4LYftw1lkQU6kvBwtSkJigP
	Uhg+rYFZPU+irqjaWLggu5SDAO+GxrirfR4G21c34wqZXp5ZLp/C3PDulw==
X-Google-Smtp-Source: AGHT+IF91Q9OkZImugXpCnL6uv8ltlBotuVioRbhJNe6qwXKFMaw6QLHvXMmW9uTQqSL2x3f0zVsEQ==
X-Received: by 2002:a5d:584e:0:b0:35f:2ac4:732f with SMTP id ffacd0b85a97d-35f5db92d0bmr1008654f8f.24.1718173641478;
        Tue, 11 Jun 2024 23:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c57bac8sm9626226f8f.83.2024.06.11.23.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:27:20 -0700 (PDT)
Message-Id: <pull.1731.v5.git.1718173639942.gitgitgadget@gmail.com>
In-Reply-To: <pull.1731.v4.git.1715920862420.gitgitgadget@gmail.com>
References: <pull.1731.v4.git.1715920862420.gitgitgadget@gmail.com>
From: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Jun 2024 06:27:19 +0000
Subject: [PATCH v5] merge: avoid write merge state when unable to write index
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

When running a merge while the index is locked (presumably by another
process), the merge state is written, the index is not updated, and then
the merge fails. This might cause unexpected results.

E.g., if another running process is "git commit", MERGE_HEAD and other
state files we write on our side will be taken into account by them and
cause them to record a merge, even though they may have been trying to
record something entirely different.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1731%2Fkeyu98%2Fkz%2Ffix-merge-when-index-lock-exists-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1731/keyu98/kz/fix-merge-when-index-lock-exists-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1731

Range-diff vs v4:

 1:  7055dfb82c7 ! 1:  a5156088514 merge: avoid write merge state when unable to write index
     @@ Commit message
          process), the merge state is written, the index is not updated, and then
          the merge fails. This might cause unexpected results.
      
     -    i.g. if another running process is "git commit", MERGE_HEAD and other state
     -    files we write on our side will be taken into account by them and cause them
     -    to record a merge, even though they may have been trying to record something
     -    entirely different.
     +    E.g., if another running process is "git commit", MERGE_HEAD and other
     +    state files we write on our side will be taken into account by them and
     +    cause them to record a merge, even though they may have been trying to
     +    record something entirely different.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
      


 builtin/merge.c  |  2 +-
 t/t7600-merge.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6a6d3798858..12c1b048fe1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -699,7 +699,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
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

base-commit: 19fe900cfce8096b7645ec9611a0b981f6bbd154
-- 
gitgitgadget
