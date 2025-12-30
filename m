Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48331ED76
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110895; cv=none; b=Nu1WMQGLSWwJ1W8Wknf7HAkaCI/akpeNKEXdKSjyv39PB3ZSufBlR2y0WBgIE+I3AuvrrwNCoZd1O1KJq9UhMLZUoOLOcYxr5xDwC17uuPRWzgMJqQyj7yle3HgLc1Pmax2qSaCablllHNie73ew5x+nrAF+E9TqF5ste1w3jBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110895; c=relaxed/simple;
	bh=i50D801wNcAM73H+cGwfZ8YyrGyIMeph8+vL/sMCWeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dm7VZhJ8BWpC7SOOqawSPqqo8isGHHdSjBLvXfX/AE7cQ70XvXXLSMuWUX16uKI2RgIguXrTHURl7cdLy+eyuycSrdbxf3LwuZK6sijaJQT3MLepqC3GouYZLSNHRi5FDRVjdnvg9Hnlwwv51baipeiHHmgsvxgfjCO+AI5euQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5G4Ox55; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5G4Ox55"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so8515962a12.1
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767110892; x=1767715692; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYAnL6QO0KYjkCe4e+CJlPfdAbztNYE+2TJeZdmnfmw=;
        b=d5G4Ox55XHN+9O3INn+3af1nGtvb1ZfAk0sM1RaqB+7Z6OL6GXXj6KIEptBd421hXT
         5iLGZn//amcdiiLZ9+4FshMBQTSWPSRmS8Qj8+3Ob326PrOstw8M5iPEMUkLEPSkmJNY
         lBu2x00VzOgk4bGBYanUyxn89YFo80W0TB3OzkN0p01Rv6148Ht+bPWXXs4EL/nucPXa
         UhOEjf3zJfw3VM0ML+08c103hrOZ4+sWXXt0rwVskkqjJk8iT+iaZudsHafqLSj7C3aJ
         Bt1kJowyAJkcQ99wLzA0RNkhhdOmMzxFi1k3jlM7dWxp8qQp7oc4RI8qLQoajaC+WQGC
         l38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767110893; x=1767715693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYAnL6QO0KYjkCe4e+CJlPfdAbztNYE+2TJeZdmnfmw=;
        b=OFB8CM/M7Dr501hNllOrzX/xkuUNoLxAYOezZ2KQhSdqGtQLEoprhJm07lEQ5ImRZ8
         WAytVo/EhQOjIMuFxPcRdAttRRrkG7MikdEvlKH5z6B8FbbeUxhBAopZKJhH0X6hqylB
         xeMOjbJjNYv65nKYVmuOaTNrMflg4eLVm+kQO7vuGkF6PuZIHQZBsPxj3NVbhUqbfiAK
         O+JOOTbGy40VD4lAe52hL6n/XCULxnVMU+fS7rLiVA4riBphxC2G0gnGtTfqSnk18iU+
         zlqeuStMgXUSj4qwDawEBE+dwZERdd3Coi8jAiOsbsdBU2EPzNl5iA6tcMjRWDmUR6pa
         vsFA==
X-Gm-Message-State: AOJu0Yy0V9BsTDIyWYyROrwwm2eX3IqI1nv7n6uEsFgp1rTkGm3uVAAt
	t80lNvweS79u5Ind22i6VY2t2iUDenj4R8EWKkO4tEIE9A5FabZjln+LI2I1VA==
X-Gm-Gg: AY/fxX7tRkMB51BdUmYwfSHJDnUEr2czxY682PgGUIlq8JSKO8E0m5cSV2CQCwd4+d1
	ygoEn/RxOgsfCy5G3CtPDhRdGIXEMBYDYCiCTB1MW97KUY2EIEq+KgWA1aKUR62WWNwDzAB2B3t
	L8FcTj6jo5QQlQ4XMTYtO8S+tng0GmGFOoS+EoYv1b80aXukatIuD38N4+AMRQXQhMhLsiWUX74
	U3hJJYUsoVRcl7Vn4hbGgqQ0edx/WgLJ8zHBKiLYHVeH6egdug9bdgVuTPvBzcwAzD9omtH6YGP
	0BVt634de0tD5HCCU15uTXCwe0E/tIJBEuGBkSEhm2QOIEGlaTc5crBrlrJ5h9RnFimzO61bgsa
	hhmmtUIDF7nlu3WKWk0YyzxgKZv3qXkteoA7kP8coTPTOFCc7xYio4ielAoOZnZ9MrOkzYlVDY9
	C+/45ypt9+mUP/O61G/XR+DSs39g==
X-Google-Smtp-Source: AGHT+IFiha+hRz8LmWZAruUW+0IIU1U9WcFk8YMtHQ1W490ncbHHr/UNk3LCl/VowlFgTGSSNmrdpg==
X-Received: by 2002:a05:7300:e9d3:20b0:2ae:605b:d52f with SMTP id 5a478bee46e88-2b05ec657afmr24314473eec.39.1767110892241;
        Tue, 30 Dec 2025 08:08:12 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm75718083eec.0.2025.12.30.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:08:11 -0800 (PST)
Message-Id: <e6d24b8b6ac7282638591051cbe4cb60ac57fd58.1767110888.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
References: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
	<pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 16:08:07 +0000
Subject: [PATCH v10 2/3] improve tests
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

