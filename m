Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66C2D1907
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766936492; cv=none; b=VjHOsO71EImJ3Tjh36i9dkYoEnBoT1wpXxkLzmMAyRPfiF4liFKczPGlvhIEdtqorxOorcWpPOFtbcqZpbOeKF9SbPB4cm+h4ktwTuJhtKpS/3M5DU8Q3zcfUljFsyxdPR3lS9Q8cTGz1L7u/wjs2MwkpTpu4f32WMockT3u1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766936492; c=relaxed/simple;
	bh=i50D801wNcAM73H+cGwfZ8YyrGyIMeph8+vL/sMCWeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=avQLrrnz1dD7yA1Z61gxXJACPPPXlAemwo1yIEUigAf8IjkJHBH/tRoAJjLqXrztXFKYshBGgE4EHFDeErBMu13YJCrEo4qH0d1wndk0bgMsQwnesrDowaKKOwLHlAQVXilJK8yYvjs6rYC9JjNLkViQyrCpZ2IQVAYLE035jVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1+WlL3k; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1+WlL3k"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee05b2b1beso89276891cf.2
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766936489; x=1767541289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYAnL6QO0KYjkCe4e+CJlPfdAbztNYE+2TJeZdmnfmw=;
        b=Z1+WlL3kp5eQQjm7mFd+4vt45dzCjnuTlE6tUp6KwhBMMerIVl8+yIGHfh/es6T3Mc
         qbapv7W/dd0Y9W2+D3SX5v94PcT4+/YKHWeC5qJTaXhJ5vnwuFHnJJMFZGHzGZDntbYA
         SZlqIMy5qIrxvp9HlZB1EAKXXUMQwOCNJUTXbGd0bKdZ6PYkNrkdNzQoSr9ZrPzI76Cw
         KtrhXLNGmMaMToS5MxsXL93Q9zZlMT060nvVv3DA/LDc2xzYIh0jOzuvXKBm517IlvY2
         PqqgyoZUbPYTsPQtuswMnrtmJYCzeqrwJU04UBJVFUL6bgH86L5SEq1VfNTxSTT4YY/0
         u1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766936489; x=1767541289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYAnL6QO0KYjkCe4e+CJlPfdAbztNYE+2TJeZdmnfmw=;
        b=C/tWu1Ds+tNdJg60ohNcfvoSSGBtuEs7Uj1WOZ9DFkSiTwFqcxtGGdkAZceiC7PbqG
         x/GBuEMlcmIuhzKl8cuj/iGyfmNE4kOfi0izRTmR6gPi41ZPKMBEGEXblmzn6mremPOl
         fgoBnxVJ5tTb6RzfICVEELxfeQcLRoxbs5q11+Sdj6eL2r8JZMIo5NRVBZ79N/as+yH9
         Buxks5KYMF5vTmuzfAlFV9w2ggqeRwQsxbbczoAqJzhntY9PFD4P5hKSyNUNz5LJAPQH
         709rU+jluD9TYSlRbs9W4xFTaYSs/PSKGgE2BX9ea08szcfzssxQBlOStHxTQGZMBhCt
         ehyA==
X-Gm-Message-State: AOJu0YwMNrL+e8VHD6c3C/dCwLlVQLQIn+U6lPvg3l1EKIkMAwvPYXAs
	kdv12rPXkc8P/TvrJ45V3/61ME1Po70v9cmyWvXmBkWEo3o/rECl/MBtuEEqAw==
X-Gm-Gg: AY/fxX6qiNVFYwRWK8UMMkQB+zyz3TcZEM9Mm1OQG87MKRgTRIBcZpjfaI54ACsfnDQ
	9YYMdS/5eRx0e53p2oANX2IsZSQsdVqmhChSXsRd4HbGnjJV0plrLyeWyK/Use7675NN1PN9pMq
	cXTg7fJfOdCzThoaT96Mr9xAAWS2muCNjyNzWOR/iCiSkGlzduOgOe/vGko8+Gql3gSLTAG++9J
	+peZdG3sU1wIsaQOqpYJoUBZYPr8s8ooZuJsTxA7ldixz295iwhouhPyx56Zbx6YksSqhpMv3gL
	rEvBA051TgwERLTJDjktERto+gHWVxWV/V/0E/wjz+I3PE3bE8GoPSMPTnHonymciDki9eklQLf
	iKjipda3/eYFaRJFDrORaPkWg3XmNIvxDI0puMoLSBrrXUl/4HTevSY9CbQzf4B985KVmxKhi4a
	DeXzWZYJdOkkU=
X-Google-Smtp-Source: AGHT+IHGXfBSVoZzbV0nRI4Z/Lbp6SFR/blQIaX4AJ7+J+/lq3/4/XxtoBrBFuhN2Qf1EGcUSev24w==
X-Received: by 2002:a05:622a:2505:b0:4f1:e46b:9dc0 with SMTP id d75a77b69052e-4f4abdd683fmr375960101cf.76.1766936489078;
        Sun, 28 Dec 2025 07:41:29 -0800 (PST)
Received: from [127.0.0.1] ([40.76.239.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4da7c31a1sm123787711cf.5.2025.12.28.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 07:41:27 -0800 (PST)
Message-Id: <53bab23737eb0e60e18380f2347a09d613c68a35.1766936483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
References: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
	<pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Dec 2025 15:41:23 +0000
Subject: [PATCH v9 2/2] improve tests
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Simplify tests based on feedback.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/t6040-tracking-info.sh | 249 +++++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 125 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index fe34ddf0ab..a875b4c73b 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -308,45 +308,44 @@ test_expect_success 'setup for ahead of non-main tracking branch' '
 test_expect_success 'status shows ahead of both tracked branch and origin/main' '
 	(
 		cd test &&
-		git checkout work >/dev/null &&
+		git checkout work &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch work
-Your branch is ahead of '\''origin/feature'\'' by 2 commits.
-  (use "git push" to publish your local commits)
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch work
+	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
 
-Ahead of '\''origin/main'\'' by 3 commits.
+	Ahead of ${SQ}origin/main${SQ} by 3 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
 	(
 		cd test &&
-		git checkout main >/dev/null &&
+		git checkout main &&
 		git config status.goalBranch origin/main &&
-		git checkout work 2>&1
-	) >actual &&
-	cat >expect <<-\EOF &&
-Switched to branch '\''work'\''
-Your branch is ahead of '\''origin/feature'\'' by 2 commits.
-  (use "git push" to publish your local commits)
+		git checkout work >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
 
-Ahead of '\''origin/main'\'' by 3 commits.
-EOF
+	Ahead of ${SQ}origin/main${SQ} by 3 commits.
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'status tracking origin/main shows only main' '
 	(
 		cd test &&
-		git checkout b4 >/dev/null &&
-		git status --long -b
-	) >actual &&
+		git checkout b4 &&
+		git status >../actual
+	) &&
 	test_grep "ahead of .origin/main. by 2 commits" actual &&
 	test_grep ! "Ahead of" actual
 '
@@ -369,19 +368,19 @@ test_expect_success 'setup for ahead of tracked but diverged from main' '
 test_expect_success 'status shows ahead of tracked and diverged from origin/main' '
 	(
 		cd test &&
-		git checkout work2 >/dev/null &&
+		git checkout work2 &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch work2
-Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
-  (use "git push" to publish your local commits)
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch work2
+	Your branch is ahead of ${SQ}origin/oldfeature${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
 
-Diverged from '\''origin/main'\'' by 3 commits.
+	Diverged from ${SQ}origin/main${SQ} by 3 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
@@ -401,20 +400,20 @@ test_expect_success 'setup for diverged from tracked but behind main' '
 test_expect_success 'status shows diverged from tracked and behind origin/main' '
 	(
 		cd test &&
-		git checkout work2b >/dev/null &&
+		git checkout work2b &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch work2b
-Your branch and '\''origin/oldfeature'\'' have diverged,
-and have 1 and 1 different commits each, respectively.
-  (use "git pull" if you want to integrate the remote branch with yours)
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch work2b
+	Your branch and ${SQ}origin/oldfeature${SQ} have diverged,
+	and have 1 and 1 different commits each, respectively.
+	  (use "git pull" if you want to integrate the remote branch with yours)
 
-Behind '\''origin/main'\'' by 1 commit.
+	Behind ${SQ}origin/main${SQ} by 1 commit.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
@@ -436,19 +435,19 @@ test_expect_success 'setup for behind tracked but ahead of main' '
 test_expect_success 'status shows behind tracked and ahead of origin/main' '
 	(
 		cd test &&
-		git checkout work3 >/dev/null &&
+		git checkout work3 &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch work3
-Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forwarded.
-  (use "git pull" to update your local branch)
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch work3
+	Your branch is behind ${SQ}origin/feature3${SQ} by 2 commits, and can be fast-forwarded.
+	  (use "git pull" to update your local branch)
 
-Ahead of '\''origin/main'\'' by 1 commit.
+	Ahead of ${SQ}origin/main${SQ} by 1 commit.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
@@ -464,19 +463,19 @@ test_expect_success 'setup upstream remote preference' '
 test_expect_success 'status prefers upstream remote over origin for comparison' '
 	(
 		cd test &&
-		git checkout work >/dev/null &&
+		git checkout work &&
 		git config status.goalBranch upstream/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch work
-Your branch is ahead of '\''origin/feature'\'' by 2 commits.
-  (use "git push" to publish your local commits)
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch work
+	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
 
-Diverged from '\''upstream/main'\'' by 5 commits.
+	Diverged from ${SQ}upstream/main${SQ} by 5 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
@@ -494,18 +493,18 @@ test_expect_success 'setup for up to date with tracked but ahead of default' '
 test_expect_success 'status shows up to date with tracked but diverged from default' '
 	(
 		cd test &&
-		git checkout synced_feature >/dev/null &&
+		git checkout synced_feature &&
 		git config status.goalBranch upstream/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch synced_feature
-Your branch is up to date with '\''origin/feature'\''.
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch synced_feature
+	Your branch is up to date with ${SQ}origin/feature${SQ}.
 
-Diverged from '\''upstream/main'\'' by 3 commits.
+	Diverged from ${SQ}upstream/main${SQ} by 3 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
@@ -524,18 +523,18 @@ test_expect_success 'setup for up to date with tracked but ahead of origin/main'
 test_expect_success 'status shows up to date with tracked but diverged from origin/main' '
 	(
 		cd test &&
-		git checkout synced_feature2 >/dev/null &&
+		git checkout synced_feature2 &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch synced_feature2
-Your branch is up to date with '\''origin/feature'\''.
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch synced_feature2
+	Your branch is up to date with ${SQ}origin/feature${SQ}.
 
-Diverged from '\''origin/main'\'' by 5 commits.
+	Diverged from ${SQ}origin/main${SQ} by 5 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
@@ -550,85 +549,85 @@ test_expect_success 'setup for up to date with tracked but purely ahead of origi
 test_expect_success 'status shows up to date with tracked but shows default branch comparison' '
 	(
 		cd test &&
-		git checkout synced_feature3 >/dev/null &&
+		git checkout synced_feature3 &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch synced_feature3
-Your branch is up to date with '\''origin/feature'\''.
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch synced_feature3
+	Your branch is up to date with ${SQ}origin/feature${SQ}.
 
-Diverged from '\''origin/main'\'' by 5 commits.
+	Diverged from ${SQ}origin/main${SQ} by 5 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'status with status.goalBranch unset shows no default comparison' '
 	(
 		cd test &&
-		git checkout synced_feature3 >/dev/null &&
-		git config --unset status.goalBranch 2>/dev/null || true &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch synced_feature3
-Your branch is up to date with '\''origin/feature'\''.
+		git checkout synced_feature3 &&
+		git config --unset status.goalBranch || true &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch synced_feature3
+	Your branch is up to date with ${SQ}origin/feature${SQ}.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'status with status.goalBranch set uses configured branch' '
 	(
 		cd test &&
-		git checkout synced_feature3 >/dev/null &&
+		git checkout synced_feature3 &&
 		git config status.goalBranch origin/main &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch synced_feature3
-Your branch is up to date with '\''origin/feature'\''.
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch synced_feature3
+	Your branch is up to date with ${SQ}origin/feature${SQ}.
 
-Diverged from '\''origin/main'\'' by 5 commits.
+	Diverged from ${SQ}origin/main${SQ} by 5 commits.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'status with status.goalBranch set to different remote/branch' '
 	(
 		cd test &&
-		git checkout work >/dev/null &&
+		git checkout work &&
 		git config status.goalBranch origin/feature &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch work
-Your branch is ahead of '\''origin/feature'\'' by 2 commits.
-  (use "git push" to publish your local commits)
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch work
+	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'status with status.goalBranch set to non-existent branch' '
 	(
 		cd test &&
-		git checkout synced_feature3 >/dev/null &&
+		git checkout synced_feature3 &&
 		git config status.goalBranch origin/nonexistent &&
-		git status --long -b
-	) >actual &&
-	cat >expect <<-\EOF &&
-On branch synced_feature3
-Your branch is up to date with '\''origin/feature'\''.
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch synced_feature3
+	Your branch is up to date with ${SQ}origin/feature${SQ}.
 
-nothing to commit, working tree clean
-EOF
+	nothing to commit, working tree clean
+	EOF
 	test_cmp expect actual
 '
 
-- 
gitgitgadget
