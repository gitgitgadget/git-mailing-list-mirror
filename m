Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2119CC11
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520668; cv=none; b=CHX2pe2O9IHxhSZUiKM1T5SOSvAdvOUgmAIgzMCnZHrEY4H5Z8Odh+q0YZZqxT7NMHNlqGWQJlKxLNuRK7ZfJU/dp3ipuuX9esk3zMc7mUh4ogqTos0+jtoaxHgqcruiLxXWfofz7RGMIO+MjwKRjaGWAhfb0CkhEkqxZPSZi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520668; c=relaxed/simple;
	bh=65MxGKJJHUderKUvm3+P7UtMgCmBMkjzEq7X2CRwMY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+68JiyXRg2uQLGgNcrSPQonkuKgsfTJ52mz/aZXAUlx0bbmFrCEbotYzhxMIwQ4TogUfGYNAPE4xrbCEHdO8U2x+3H1NBVRbOj8O2pvlFgMwBWmz9LbtaPPgTj1BTCQFQD8YnUd2AcjqixPDKUWLLE8cjSCAdLKk7flvdq//0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC8r89eQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC8r89eQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21675fd60feso65703445ad.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734520666; x=1735125466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVEp/I5qtuevILepEXNn2KQhv0b82vEmn868//7YeS4=;
        b=FC8r89eQHuQ2cXl6D0cYUu4VMJv/Y/hUW8+hSlZUCgocJFwrIYcP4++ngS1tbiyF+x
         n03VEdDJy27KkskMG0v7hhRj9kcfxRhxp9G+DcBGj5GY4E/m9bx5+rtdTun66dHdbPyl
         ZlS6qLyKPwvyYQKRomiSJTS8zyeVgvbZBtaasuiPIjus1yMzmweIRS3wSjf1SjDP2WgM
         gMzGtLWZkf4CEXSzbD9fjpFHIfd2yuawcTMXpy6c0JssQljKOncgP3K7TcJql1yS4Cq5
         hr+iDay5L0HhDIgFbc9yrIsXwEfC204HZpdJx7NqFTI+9BVs/QOV773YR8griAfXt63w
         RG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734520666; x=1735125466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVEp/I5qtuevILepEXNn2KQhv0b82vEmn868//7YeS4=;
        b=oDF+yfQBGGIaK2n5p19+eclnltSeirxyYSgaIX6532TINpP47tYwOUzpKEd5pVlIVx
         u7yF/2CARmT968HqakHZrsnr5dzCIHVe2XBZzaDK1iMp1mAPU4JPuu1nz2TQervtzALH
         FJj2RAiCyYdbMFxP8JsLAsJKa/uYbWnmznuma77iv47snbXHrqlB6k0JHC9rUPCa+CV0
         zoPg8YuA3FH/jIkBar0vd2rSy24X7+CbMSW4SgOto7TehoOTEI6BEQpLmMjAO06NHg+Z
         +uGoiYL/ISiwvTfU+KO5m2wc327lb+N39UR5J0eT5FSdB/G2GuEzI0WAbob0YSBNqJBh
         Zvjw==
X-Gm-Message-State: AOJu0YwWKml/Ct4fRfWYYqhGhwooEqHqpzazWdgNdxVXajeji93+jMw4
	jNmeBIs9CjSDJcEk5OCHVW1Tt/3JHapqIOMT+mwQdoyiCdxRVUdAsqdqJr9h
X-Gm-Gg: ASbGncsBankSijjaKJTRaUayyyOgoUks6NAIAD9AKm6dA3BihKIzEl3KGzLXZVDw2Ui
	7dBmvt7i7u0DQ7IpFiPRNG3Iog+QaYBGSMwtTHLt91kskFJ+blZK9TRtIF5J/zQryIxxRvJ5VuK
	yQL4Age85bsA+VpW+kvAL4d0MRbLWTIp0CDP97iissKexIYlkjDgpKPGhWoPtZ975zGgoxbHke0
	B80MCYreAkmBIBvVIF+zTRFELwhDtrOWYbT8uPHTdmpfgmfhb6mcgU=
X-Google-Smtp-Source: AGHT+IFb7bMn2ZuFkytcMU7am2aPvCPYhuse9ssKGthiWO3gA9jIOMpPU06T+YA3jk9w0vSvec9HZw==
X-Received: by 2002:a17:902:d4cf:b0:215:3661:747e with SMTP id d9443c01a7336-218d6fd6008mr31702765ad.8.1734520665680;
        Wed, 18 Dec 2024 03:17:45 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64672sm73685985ad.216.2024.12.18.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:17:45 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	shyamthakkar001@gmail.com,
	shejialuo@gmail.com,
	chandrapratap3519@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC] [PATCH] t7611: replace test -f with test_path_is* helpers
Date: Wed, 18 Dec 2024 16:47:15 +0530
Message-Id: <20241218111715.1030357-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -f does not provide verbose error message on test failures, so use
test_path_is_file, test_path_is_missing instead.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/t7611-merge-abort.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index d6975ca48d..1a251485e1 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -54,13 +54,13 @@ test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
 '
 
 test_expect_success 'fails without MERGE_HEAD (unstarted merge): .git/MERGE_HEAD sanity' '
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'fails without MERGE_HEAD (completed merge)' '
 	git merge clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	# Merge successfully completed
 	post_merge_head="$(git rev-parse HEAD)" &&
 	test_must_fail git merge --abort 2>output &&
@@ -68,7 +68,7 @@ test_expect_success 'fails without MERGE_HEAD (completed merge)' '
 '
 
 test_expect_success 'fails without MERGE_HEAD (completed merge): .git/MERGE_HEAD sanity' '
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$post_merge_head" = "$(git rev-parse HEAD)"
 '
 
@@ -79,10 +79,10 @@ test_expect_success 'Forget previous merge' '
 test_expect_success 'Abort after --no-commit' '
 	# Redo merge, but stop before creating merge commit
 	git merge --no-commit clean_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort non-conflicting merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	test -z "$(git diff --staged)"
@@ -91,10 +91,10 @@ test_expect_success 'Abort after --no-commit' '
 test_expect_success 'Abort after conflicts' '
 	# Create conflicting merge
 	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort conflicting merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	test -z "$(git diff --staged)"
@@ -105,7 +105,7 @@ test_expect_success 'Clean merge with dirty index fails' '
 	git add foo &&
 	git diff --staged > expect &&
 	test_must_fail git merge clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	git diff --staged > actual &&
@@ -114,7 +114,7 @@ test_expect_success 'Clean merge with dirty index fails' '
 
 test_expect_success 'Conflicting merge with dirty index fails' '
 	test_must_fail git merge conflict_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	git diff --staged > actual &&
@@ -129,10 +129,10 @@ test_expect_success 'Reset index (but preserve worktree changes)' '
 
 test_expect_success 'Abort clean merge with non-conflicting dirty worktree' '
 	git merge --no-commit clean_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -141,10 +141,10 @@ test_expect_success 'Abort clean merge with non-conflicting dirty worktree' '
 
 test_expect_success 'Abort conflicting merge with non-conflicting dirty worktree' '
 	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -159,7 +159,7 @@ test_expect_success 'Fail clean merge with conflicting dirty worktree' '
 	echo xyzzy >> bar &&
 	git diff > expect &&
 	test_must_fail git merge --no-commit clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -168,7 +168,7 @@ test_expect_success 'Fail clean merge with conflicting dirty worktree' '
 
 test_expect_success 'Fail conflicting merge with conflicting dirty worktree' '
 	test_must_fail git merge conflict_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -183,7 +183,7 @@ test_expect_success 'Fail clean merge with matching dirty worktree' '
 	echo bart > bar &&
 	git diff > expect &&
 	test_must_fail git merge --no-commit clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -194,7 +194,7 @@ test_expect_success 'Fail conflicting merge with matching dirty worktree' '
 	echo barf > bar &&
 	git diff > expect &&
 	test_must_fail git merge conflict_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
2.34.1

