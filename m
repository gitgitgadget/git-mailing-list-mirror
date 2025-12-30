Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A6280CC1
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110897; cv=none; b=nLORRC8ypD/WIcfgVCP8AWuDQI9anE0Jq0l5lHoMDzPvkEUAmKt+Ge70y7h1gVHM+wNcn/iy9BTZ9UW6azDzwNjsQMVwudyhhKH3oNX1zvsVR82Fbf+vKE7nb7+9qlIbc18Yky9wN7YZu6+r65FqY4MIkEMPaso9w8dYXyU9INk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110897; c=relaxed/simple;
	bh=G1az9tJFe98HJ7BfSo84hgk6nfCJVT3rpo7lbbmQKFY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k6oP7Ht/AoVkEMvjqYrze3oxB2UdtJggo0k21x4KO9YxjnHpNHoJA3IbkS27+UthdFSy7GaLPp+3yhHUFDmDbSRz+Os+PqNXGZPMk2W217XNf2O3XTQERW9yFrA/YnPC3jQXtxfhNByMGIijZd3gg2yLjPiKd2uNByhmFJTcD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ9MhNv4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ9MhNv4"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c708702dfso10671251a91.1
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767110894; x=1767715694; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNQc0bWlF93p0B/cnENLWCGsnnU6P+yCZuTEpD1TvXM=;
        b=mZ9MhNv4Aaz9buH1P8RT4LSLtDbIbJi7ygrl0zhR73JNDzaSM1dTA9lVU2zZQ+Xzeb
         LF01hb2ktv4cZ1cC8EtbXvQLVJkeCgniiGZKX2VTRxghKowGOeRVA55vSazL4SS+Yy6b
         ACNKCCjm//JT614sY72F5so7r/o6eolkvdbSVmROJui5POMnZeEK7Zxdvo1zf8GgRM0y
         VQ8kl4wbeoX0Mero0ML16N5K/ZFAjR2yfSZeu8Xz/m6WV5j87zJdpJ5faR9rBwBQNmrp
         YXh+IbQCQPT1krqQegmd3H9L7sogyTQMyuMm7R1mw2B9ywRARwxz+PH/6qDNbxZrCMdl
         MHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767110894; x=1767715694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FNQc0bWlF93p0B/cnENLWCGsnnU6P+yCZuTEpD1TvXM=;
        b=ooylN3zHz8lyAElqeP4rrdR94jTLvrOIOK/aQm7TQHoXwix2nHswIyjBRcEUuAP5Lg
         7E8kCGXE2mTnVHHnZPR4MqOU4TF0YJKmKB9nUPpflETgMtel6rCy9aL95SVtyQMo/4Gv
         xMYxjf31m3n4kjHKA35kTlztsZFiAiCS831a1fxAFYbhfGbA9ujNvkweHn3CRFuqsKce
         8lpT/23M+oXuT4zrDxrps74CkKJ/ayW5Bj/Rgb18RHe7jBpUkg42Gff1rcl4uUywMlG3
         DwadRqG4x4A5eK/ZqtqIn1ktUhOicl4VWETA2pkxQc9pj0OyOHGy07TCfi55piWAro+E
         n4xQ==
X-Gm-Message-State: AOJu0Ywby81OlebpEG2czLPaoSVQpE+4BGJaZUd5yptLuPbjWYx6KC/j
	Hiqr6jv0b9mW9ooOtpwV9MyQMuqGCbJnWor7GtS5Oo6o++85rqd+QmyKfiDRLg==
X-Gm-Gg: AY/fxX6QZvQYaMSiZ9c20SA69bXcz3pjx8CYyv8JJh5ivSbzhM/iHoT+DBKMXUk4aaY
	DPs/TOfIrObvX6axBOPLiZCCDlYwrK7SWZf2boQaWCFmab+H1G4Awy3DoJV5WDf3DKfbCECyxrK
	T+6OzTEc+rJeLzxBQ50b1ELjfCfLlSr3z03+qvzjh2dT1KuumM1C6SunQv7QRXC/d4yuQakWlmV
	yjt9WiClo6W8NQk+5JP7pqybjfrurTejIeiE5onsSH36qljK3yq+XlEigibVopttsP6Rrzt7wRK
	SSzrSrtXppPC4WSlo6P+yEgXGqrVDjACDKa2ti0x5Arug3SAgTv7hjXmpSaHfAuAy+3roLpZWhA
	bq93azMiA+DauBbpr3P55y+tNjvgOH7YQqGBzBY2AzG31fuSjTUveG0vrLY1Th/XQG20ojZCczW
	oGFObbxXST7yxb3ps=
X-Google-Smtp-Source: AGHT+IGkJRUuy/2mbQv1QTzVu4NUjh4W9LvcK9AWxSptgVxvLd0N4VUNJMnTxxDE5bU0bx8fXykdzw==
X-Received: by 2002:a05:7022:68a8:b0:119:e56b:957c with SMTP id a92af1059eb24-121722ac7bbmr31975301c88.1.1767110893699;
        Tue, 30 Dec 2025 08:08:13 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfa2csm105902537c88.3.2025.12.30.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:08:13 -0800 (PST)
Message-Id: <13c2a03b0a25054cdaae030a52b1afddebce56a9.1767110888.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
References: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
	<pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 16:08:08 +0000
Subject: [PATCH v10 3/3] use pushRemote and tracking branch
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

Use them for comparisons instead of config variable.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 |  71 +++++-----
 t/t6040-tracking-info.sh | 296 ++++++++-------------------------------
 2 files changed, 96 insertions(+), 271 deletions(-)

diff --git a/remote.c b/remote.c
index 7e13c027b5..2317725f7d 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,31 +2237,22 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-static char *get_goal_branch_ref(char **full_ref_out)
+static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
 {
-	const char *config_value;
+	const char *push_remote;
 	const char *resolved;
 	int flag;
 	struct strbuf ref_buf = STRBUF_INIT;
-	char *slash_pos;
 	char *ret = NULL;
 
-	if (repo_config_get_value(the_repository, "status.goalBranch", &config_value))
-		return NULL;
-
-	if (!config_value || !*config_value)
+	if (!branch)
 		return NULL;
 
-	slash_pos = strchr(config_value, '/');
-	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
-		warning(_("invalid value for status.goalBranch: '%s' (expected format: remote/branch)"),
-			config_value);
+	push_remote = pushremote_for_branch(branch, NULL);
+	if (!push_remote)
 		return NULL;
-	}
 
-	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
-		    (int)(slash_pos - config_value), config_value,
-		    slash_pos + 1);
+	strbuf_addf(&ref_buf, "refs/remotes/%s/%s", push_remote, branch->name);
 
 	resolved = refs_resolve_ref_unsafe(
 		get_main_ref_store(the_repository),
@@ -2280,38 +2271,44 @@ static char *get_goal_branch_ref(char **full_ref_out)
 	return ret;
 }
 
-static void format_goal_branch_comparison(struct strbuf *sb,
+static void format_push_branch_comparison(struct strbuf *sb,
 					     const char *branch_refname,
-					     const char *goal_full,
-					     const char *goal_short,
+					     const char *push_full,
+					     const char *push_short,
 					     enum ahead_behind_flags abf)
 {
-	int goal_ahead = 0, goal_behind = 0;
+	int push_ahead = 0, push_behind = 0;
+	int stat_result;
 
-	if (stat_branch_pair(branch_refname, goal_full,
-			     &goal_ahead, &goal_behind, abf) <= 0)
+	stat_result = stat_branch_pair(branch_refname, push_full,
+				       &push_ahead, &push_behind, abf);
+	if (stat_result < 0)
 		return;
 
 	strbuf_addstr(sb, "\n");
 
-	if (goal_ahead > 0 && goal_behind == 0) {
+	if (stat_result == 0 || (push_ahead == 0 && push_behind == 0)) {
+		strbuf_addf(sb,
+			_("Your branch is up to date with '%s'.\n"),
+			push_short);
+	} else if (push_ahead > 0 && push_behind == 0) {
 		strbuf_addf(sb,
 			Q_("Ahead of '%s' by %d commit.\n",
 			   "Ahead of '%s' by %d commits.\n",
-			   goal_ahead),
-			goal_short, goal_ahead);
-	} else if (goal_behind > 0 && goal_ahead == 0) {
+			   push_ahead),
+			push_short, push_ahead);
+	} else if (push_behind > 0 && push_ahead == 0) {
 		strbuf_addf(sb,
 			Q_("Behind '%s' by %d commit.\n",
 			   "Behind '%s' by %d commits.\n",
-			   goal_behind),
-			goal_short, goal_behind);
-	} else if (goal_ahead > 0 && goal_behind > 0) {
+			   push_behind),
+			push_short, push_behind);
+	} else if (push_ahead > 0 && push_behind > 0) {
 		strbuf_addf(sb,
 			Q_("Diverged from '%s' by %d commit.\n",
 			   "Diverged from '%s' by %d commits.\n",
-			   goal_ahead + goal_behind),
-			goal_short, goal_ahead + goal_behind);
+			   push_ahead + push_behind),
+			push_short, push_ahead + push_behind);
 	}
 }
 
@@ -2392,15 +2389,15 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	}
 
 	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
-		char *goal_full = NULL;
-		char *goal_short = get_goal_branch_ref(&goal_full);
+		char *push_full = NULL;
+		char *push_short = get_remote_push_branch(branch, &push_full);
 
-		if (goal_short && strcmp(base, goal_short))
-			format_goal_branch_comparison(sb, branch->refname, goal_full,
-						     goal_short, abf);
+		if (push_short && strcmp(base, push_short))
+			format_push_branch_comparison(sb, branch->refname, push_full,
+						     push_short, abf);
 
-		free(goal_short);
-		free(goal_full);
+		free(push_short);
+		free(push_full);
 	}
 
 	free(base);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index a875b4c73b..f27ae719ad 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -21,7 +21,6 @@ test_expect_success setup '
 	git clone . test &&
 	(
 		cd test &&
-		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main &&
 		git checkout -b b1 origin &&
 		git reset --hard HEAD^ &&
 		advance d &&
@@ -293,340 +292,169 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for ahead of non-main tracking branch' '
-	(
-		cd test &&
-		git checkout -b feature origin/main &&
-		advance feature1 &&
-		git push origin feature &&
-		git checkout -b work --track origin/feature &&
-		advance work1 &&
-		advance work2
-	)
-'
-
-test_expect_success 'status shows ahead of both tracked branch and origin/main' '
+test_expect_success 'status tracking origin/main shows only main' '
 	(
 		cd test &&
-		git checkout work &&
-		git config status.goalBranch origin/main &&
+		git checkout b4 &&
 		git status >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch work
-	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
+	On branch b4
+	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
 	  (use "git push" to publish your local commits)
 
-	Ahead of ${SQ}origin/main${SQ} by 3 commits.
-
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
-	(
-		cd test &&
-		git checkout main &&
-		git config status.goalBranch origin/main &&
-		git checkout work >../actual
-	) &&
-	cat >expect <<-EOF &&
-	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
-	  (use "git push" to publish your local commits)
-
-	Ahead of ${SQ}origin/main${SQ} by 3 commits.
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'status tracking origin/main shows only main' '
-	(
-		cd test &&
-		git checkout b4 &&
-		git status >../actual
-	) &&
-	test_grep "ahead of .origin/main. by 2 commits" actual &&
-	test_grep ! "Ahead of" actual
-'
-
-test_expect_success 'setup for ahead of tracked but diverged from main' '
-	(
-		cd test &&
-		git checkout origin/main &&
-		git checkout -b oldfeature &&
-		advance oldfeature1 &&
-		git push origin oldfeature &&
-		git checkout origin/main &&
-		advance main_newer &&
-		git push origin HEAD:main &&
-		git checkout -b work2 --track origin/oldfeature &&
-		advance work2_commit
-	)
-'
-
-test_expect_success 'status shows ahead of tracked and diverged from origin/main' '
+test_expect_success 'status shows ahead of both origin/main and feature branch' '
 	(
 		cd test &&
-		git checkout work2 &&
-		git config status.goalBranch origin/main &&
+		git checkout -b feature2 origin/main &&
+		git push origin HEAD &&
+		advance work &&
 		git status >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch work2
-	Your branch is ahead of ${SQ}origin/oldfeature${SQ} by 1 commit.
+	On branch feature2
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
 	  (use "git push" to publish your local commits)
 
-	Diverged from ${SQ}origin/main${SQ} by 3 commits.
+	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
 
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for diverged from tracked but behind main' '
+test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
 	(
 		cd test &&
-		git fetch origin &&
-		git checkout origin/main &&
-		git checkout -b work2b &&
-		git branch --set-upstream-to=origin/oldfeature &&
-		git checkout origin/main &&
-		advance main_extra &&
-		git push origin HEAD:main
-	)
-'
-
-test_expect_success 'status shows diverged from tracked and behind origin/main' '
-	(
-		cd test &&
-		git checkout work2b &&
-		git config status.goalBranch origin/main &&
-		git status >../actual
+		git checkout feature2 >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch work2b
-	Your branch and ${SQ}origin/oldfeature${SQ} have diverged,
-	and have 1 and 1 different commits each, respectively.
-	  (use "git pull" if you want to integrate the remote branch with yours)
-
-	Behind ${SQ}origin/main${SQ} by 1 commit.
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
 
-	nothing to commit, working tree clean
+	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for behind tracked but ahead of main' '
+test_expect_success 'setup for ahead of tracked but diverged from main' '
 	(
 		cd test &&
-		git fetch origin &&
+		git checkout -b feature4 origin/main &&
+		advance work1 &&
 		git checkout origin/main &&
-		git checkout -b feature3 &&
-		advance feature3_1 &&
-		advance feature3_2 &&
-		advance feature3_3 &&
-		git push origin feature3 &&
-		git checkout -b work3 --track origin/feature3 &&
-		git reset --hard HEAD~2
+		advance work2 &&
+		git push origin HEAD:main &&
+		git checkout feature4 &&
+		advance work3
 	)
 '
 
-test_expect_success 'status shows behind tracked and ahead of origin/main' '
+test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
 	(
 		cd test &&
-		git checkout work3 &&
-		git config status.goalBranch origin/main &&
+		git checkout feature4 &&
+		git branch --set-upstream-to origin/main &&
+		git push origin HEAD &&
+		advance work &&
 		git status >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch work3
-	Your branch is behind ${SQ}origin/feature3${SQ} by 2 commits, and can be fast-forwarded.
-	  (use "git pull" to update your local branch)
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} have diverged,
+	and have 3 and 1 different commits each, respectively.
+	  (use "git pull" if you want to integrate the remote branch with yours)
 
-	Ahead of ${SQ}origin/main${SQ} by 1 commit.
+	Ahead of ${SQ}origin/feature4${SQ} by 1 commit.
 
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'setup upstream remote preference' '
+test_expect_success 'setup upstream remote' '
 	(
 		cd test &&
 		git remote add upstream ../. &&
 		git fetch upstream &&
-		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/main
+		git config remote.pushDefault origin
 	)
 '
 
-test_expect_success 'status prefers upstream remote over origin for comparison' '
+test_expect_success 'status with upstream remote and push.default set to origin' '
 	(
 		cd test &&
-		git checkout work &&
-		git config status.goalBranch upstream/main &&
+		git checkout -b feature5 upstream/main &&
+		git push origin &&
+		advance work &&
 		git status >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch work
-	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
+	On branch feature5
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
 	  (use "git push" to publish your local commits)
 
-	Diverged from ${SQ}upstream/main${SQ} by 5 commits.
+	Ahead of ${SQ}origin/feature5${SQ} by 1 commit.
 
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'setup for up to date with tracked but ahead of default' '
+test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
 	(
 		cd test &&
-		git checkout origin/feature &&
-		git checkout -b synced_feature --track origin/feature &&
-		git checkout origin/main &&
-		advance main_ahead &&
-		git push origin HEAD:main
-	)
-'
-
-test_expect_success 'status shows up to date with tracked but diverged from default' '
-	(
-		cd test &&
-		git checkout synced_feature &&
-		git config status.goalBranch upstream/main &&
+		git checkout -b feature6 upstream/main &&
+		advance work &&
+		git push origin &&
+		git reset --hard upstream/main &&
+		advance work &&
 		git status >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch synced_feature
-	Your branch is up to date with ${SQ}origin/feature${SQ}.
-
-	Diverged from ${SQ}upstream/main${SQ} by 3 commits.
-
-	nothing to commit, working tree clean
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'setup for up to date with tracked but ahead of origin/main' '
-	(
-		cd test &&
-		git remote remove upstream &&
-		git checkout origin/feature &&
-		git checkout -b synced_feature2 --track origin/feature &&
-		git checkout origin/main &&
-		advance main_ahead2 &&
-		git push origin HEAD:main
-	)
-'
-
-test_expect_success 'status shows up to date with tracked but diverged from origin/main' '
-	(
-		cd test &&
-		git checkout synced_feature2 &&
-		git config status.goalBranch origin/main &&
-		git status >../actual
-	) &&
-	cat >expect <<-EOF &&
-	On branch synced_feature2
-	Your branch is up to date with ${SQ}origin/feature${SQ}.
-
-	Diverged from ${SQ}origin/main${SQ} by 5 commits.
-
-	nothing to commit, working tree clean
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'setup for up to date with tracked but purely ahead of origin/main' '
-	(
-		cd test &&
-		git checkout origin/feature &&
-		git checkout -b synced_feature3 --track origin/feature
-	)
-'
-
-test_expect_success 'status shows up to date with tracked but shows default branch comparison' '
-	(
-		cd test &&
-		git checkout synced_feature3 &&
-		git config status.goalBranch origin/main &&
-		git status >../actual
-	) &&
-	cat >expect <<-EOF &&
-	On branch synced_feature3
-	Your branch is up to date with ${SQ}origin/feature${SQ}.
-
-	Diverged from ${SQ}origin/main${SQ} by 5 commits.
-
-	nothing to commit, working tree clean
-	EOF
-	test_cmp expect actual
-'
+	On branch feature6
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
 
-test_expect_success 'status with status.goalBranch unset shows no default comparison' '
-	(
-		cd test &&
-		git checkout synced_feature3 &&
-		git config --unset status.goalBranch || true &&
-		git status >../actual
-	) &&
-	cat >expect <<-EOF &&
-	On branch synced_feature3
-	Your branch is up to date with ${SQ}origin/feature${SQ}.
+	Diverged from ${SQ}origin/feature6${SQ} by 2 commits.
 
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'status with status.goalBranch set uses configured branch' '
+test_expect_success 'status with upstream remote and push branch up to date' '
 	(
 		cd test &&
-		git checkout synced_feature3 &&
-		git config status.goalBranch origin/main &&
+		git checkout -b feature7 upstream/main &&
+		git push origin &&
 		git status >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch synced_feature3
-	Your branch is up to date with ${SQ}origin/feature${SQ}.
+	On branch feature7
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
 
-	Diverged from ${SQ}origin/main${SQ} by 5 commits.
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
 
 	nothing to commit, working tree clean
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'status with status.goalBranch set to different remote/branch' '
+test_expect_success 'checkout shows push branch up to date' '
 	(
 		cd test &&
-		git checkout work &&
-		git config status.goalBranch origin/feature &&
-		git status >../actual
-	) &&
-	cat >expect <<-EOF &&
-	On branch work
-	Your branch is ahead of ${SQ}origin/feature${SQ} by 2 commits.
-	  (use "git push" to publish your local commits)
-
-	nothing to commit, working tree clean
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'status with status.goalBranch set to non-existent branch' '
-	(
-		cd test &&
-		git checkout synced_feature3 &&
-		git config status.goalBranch origin/nonexistent &&
-		git status >../actual
+		git checkout feature7 >../actual
 	) &&
 	cat >expect <<-EOF &&
-	On branch synced_feature3
-	Your branch is up to date with ${SQ}origin/feature${SQ}.
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
 
-	nothing to commit, working tree clean
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
 	EOF
 	test_cmp expect actual
 '
-- 
gitgitgadget
