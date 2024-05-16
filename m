Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517B23A6
	for <git@vger.kernel.org>; Thu, 16 May 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715836738; cv=none; b=TUvuK8X7p8dOzmL4yF0nl0pNgBkarra+IErvjUANwmmrtPXcPUveWYFDV+bSKhd4xPOzJuu9G0OHhAYIprQbC+EyQoD0p4OtdCvSoOZ0EmwQm3Jq+zjeEUw8C42ZqF6K/RoXCcz2/MBKceEtSfiJnxA731qK/h7i4g48aL9oydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715836738; c=relaxed/simple;
	bh=Lj8LUdUTUPWFeIWOLKbm0qy92H9ay+JJ2zsgLjbsmVo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V7tc8CWmTW8SnFK9mZtJSZaqvFXMYrauAaDn1YhcXDTnLhozQonUdskmH4/8KN7FMH7ZSPCyI0+SoMHQlTG8oenpy9SynJhbnahhnQQBM4xYJL92BrXiDNNjo5o4WaT6LaiCEuoPZ4Ho8Sjd7Ri84mxkZBRtRrleIQs0SlzqnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW0O5nLR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW0O5nLR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3b1b6e9d1so3747701fa.2
        for <git@vger.kernel.org>; Wed, 15 May 2024 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715836734; x=1716441534; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wa8zsE6g7J90dKJhyohibrvDfc1Jna+AIcUNisCFQ8=;
        b=nW0O5nLRLBNKqS3P87cC5/Av6FnT2CNxuoCfb47WdjcSsqJKr5Ss2rrfxASav+3LGY
         P4FtGLW1AkOoqu+GuAWyuDOVSTsM6ujjwx/H/F51/r0YhNz18ZItb/tJrzPpUzu5ISU9
         AnP/nIO8rbUJoykV/ULdupkumulgbSo/sY9ip0Gus/VuzLCaDLpgr5oxomSKiPzNy8Mz
         FrwHX72QfSROAK9BOXg9Kr6e6w+UYYpk76L6klJvsF47tPMMlVeVDXiOvjnyy10W+y6n
         M4IQFiM8MMPcr7BjKl7QjPKPU/RZdlciDYi/N+2VCB9pLobjC+Z/IQBueF+aYpLOpN+P
         sZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715836734; x=1716441534;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wa8zsE6g7J90dKJhyohibrvDfc1Jna+AIcUNisCFQ8=;
        b=YkLsU2c536B0wN+n7Xatp4I6Z1OGHMd4YbRq7MAKuKNn2BHjxx+gJRfGnHjew1YZFy
         5O6Wflx6D+H8GsD0vq8JTnPx0FMKfXin4CaBVTSZckCAEY8fPpwX3udl8xy3ZVsrrYOi
         bQF8gRzzW74Qul/+GyEaWoJFAjWTEoi4KZ/i1bg1smFj5DnmQNpxYBz+OKVezyouZ0Jf
         ReqHF8+JrsR444xcVVWXLqozQaFgqS6K4FTsoqWyspRXpGE2Q19X0roLxkBaHNkf80Ns
         xPjhFwsnSYL902zGrKAvFDtJtBKKFdsbWnn+ztVtyR35GL5tXE2uOFjYDmnHnfglBSCQ
         C4Iw==
X-Gm-Message-State: AOJu0Yz3G20g6qpHaOIwBHMB9hK4TdaV2Emvu2o59EIndvbk9Vdn0z29
	r8OvH6lakCOsA65qIDe359EC1cw2ie865iEom3GO6IV9BCAleKsaPt6WXA==
X-Google-Smtp-Source: AGHT+IF5dI7UjilXfJORNgZRHT7O3YRfLT62M7Nst2hcCYIAip8JArNA+6v3ntwSBT1l/jW3z3yLtw==
X-Received: by 2002:a05:651c:2227:b0:2d8:da4c:5909 with SMTP id 38308e7fff4ca-2e5205e2994mr148322501fa.51.1715836733346;
        Wed, 15 May 2024 22:18:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1277sm248076415e9.42.2024.05.15.22.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 22:18:52 -0700 (PDT)
Message-Id: <pull.1731.v2.git.1715836731784.gitgitgadget@gmail.com>
In-Reply-To: <pull.1731.git.1715836120584.gitgitgadget@gmail.com>
References: <pull.1731.git.1715836120584.gitgitgadget@gmail.com>
From: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 May 2024 05:18:51 +0000
Subject: [PATCH v2] merge: avoid write merge state when unable to write index
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
a merge commit will be generated and all modifications from the source
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
    git checkout master
    echo "1" >> 1.txt && git add . && git commit -m "3"
    touch .git/index.lock
    git merge source-branch
    rm .git/index.lock
    git commit -m "4"
    
    
    Then the modifications from the source branch are lost.
    
    Regards, Kyle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1731%2Fkeyu98%2Fkz%2Ffix-merge-when-index-lock-exists-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1731/keyu98/kz/fix-merge-when-index-lock-exists-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1731

Range-diff vs v1:

 1:  aab0be55989 ! 1:  86101e5b778 merge: avoid write merge state when unable to write index
     @@ Commit message
          will be written and the index will be unchanged.
      
          If the user exec "git commit" instead of "git merge --abort" after this,
     -    the commit will be successful and all modifications from the source
     +    a merge commit will be generated and all modifications from the source
          branch will be lost.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>


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
