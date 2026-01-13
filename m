Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86A387360
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298130; cv=none; b=WI5GKI+AHoVyPUlB5+1sZhbWih/91KcWt/ZhvMz27zaVp0HoNDWqDKtiPxK6Fol/Yay6rQj37x9N02zZ7JDsBXCTrJ4NJOmn9xFXd7OUmHMAmVWOxEOD1CGLv4wPO6knfeE9vIHRKUHBKdeuF6ySyVINfi7xJvjbQ0N4e5Kmv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298130; c=relaxed/simple;
	bh=qez/R1dgNu9sMJvvBsyn3i0N5SaEbsRxL1a3t0QTV7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qes9iWjWp+OWLVUP811heyefPlNP7kde4HpRu3zbTsuB7oQbA5JcQXKfCFVMMzJE2BWlksQPSaAQ2cYr0vKFhxofJw2vJxaIMMPk4ifmg7IxoqHsS9hBdPb3nh1eBZFxBJoybeIPD6peXrMR2JAAR0axgTMGbfkljpbfcWHEYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEC5dLbX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEC5dLbX"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45a815c1cfdso1642483b6e.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768298127; x=1768902927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT48qGSeYuQqsRlPIEkfYmTJ1HPXFEfwuw2oQu/9hg0=;
        b=iEC5dLbXwvqBNOJJ6joxAd379QRKHcMd3ufdQ2CYQEqtWQg59LBx5K+dINx51WjMcu
         BZ4BCxq2U203cb6RW1KMlE50r7/+iPtJBJt0Zv8dCfWw+DfzkVZiBhjN+kP5CPveYXYZ
         5D40e30j4bwEdWz3ky5K5EMa+qEYK5RUtgb3jaAjOl33bcZSlI16lI7vT+AlPY9RcMjt
         9oQGEJrmGUrC5YLdeIw32GqkYfADN5MVKEUp3eRSV6KaESPpSwGNMBA5RIZS5oc+1da1
         c8zalU4mG723DcDm69GAkxHM5uVqoT0ivdNS5rE2hP8WOzL1vu5aeHxBttZ+JH9rNjGT
         /wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298127; x=1768902927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CT48qGSeYuQqsRlPIEkfYmTJ1HPXFEfwuw2oQu/9hg0=;
        b=Jbi+HLMKzeF1V6jBPGpr5XYW+0UfGTV1zeJb5xASscW3LhobfeZHWwI6QdsTrHcBo3
         sIuQ56gHebZs1Jq+XiUhmsyhcBhSvEbhSYBFD99VMVDQUDyh75kPd8Fe8qswHfGYP9FK
         24ZfGzxVE1NwMhfJSMF9+oaUggleTWUx7KAHxo1CHl8OeZBQwM4VZTXiIxAHqXedY4z7
         Z7Gy/Yj0YwXTZyz+Djh02KbTEq7DPTVsAcjz4ibiS1/vT3DB+S28nyyUCCc7kRWZ1Pm9
         kW6oKSTeVcmGbQjxPb3Fh3erqc2QVGNwcFdO4CqZQKv3LoXljC9vzcB9bF8J351j+bgW
         +LZg==
X-Gm-Message-State: AOJu0Yy1Z/79p3eBArdBPuqx8G96xEZ5JLYfy24m9isWIsZIboNF/yhc
	jC3610ZraO7xRlfF45KSKtGL0unfsyw+1EK9BByuT9sZ7V3MrRoZDx8zteuUzw==
X-Gm-Gg: AY/fxX71P/fZS7aA5JcNFdHyqEFhjXgJFYCoIEe8Rin+VLh5Lf4uDShC7Td4tlqFc0K
	whKNO9hRXFBgO2SomK+ra6Wgg6GwCvowt/5KvS8Anmd8/6/+LF+bWOah2pdQ+E2giU42LCV9lhC
	8Ci9fu96lPArYk/8kTEvChRPsN1Zbg7SW9ooUNZfj6SzOgf5N3DD/awC6ut77smHUgzVMAQGgyq
	QDljTg4EhSA3HFiOZm3eq42GtTPvE3dmUxbe9Cn34Mrz+A6hROvO8najXYkZqzEwuVKbWWX1EVx
	ZAkRdxrTI672OFct7WAdGNG8NVxTw4X9vc3b4lYcT8Hh2lJ5lgwLeWSDQ4q4UoLuly5IqS94gm6
	UIlh3+w6i4NHt7C5X4DDJ2rb9LVPYUxk5f1qtoANFRT7H9YNEX3EF/xcXMwjDn/eFZAuUjfRafo
	Y9m2dicYa7siMFZA==
X-Google-Smtp-Source: AGHT+IHySB7KSdbFVxaGkBxXx3pEq+jgvgqgNqWpVIrBlLtCDzxD8exbcP15NDiOXZkv6NJfLyB/Bw==
X-Received: by 2002:a05:6808:6:b0:450:125d:d9e with SMTP id 5614622812f47-45a6bdbd167mr7893287b6e.21.1768298126959;
        Tue, 13 Jan 2026 01:55:26 -0800 (PST)
Received: from [127.0.0.1] ([52.173.219.149])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5dfb6256sm9588678b6e.0.2026.01.13.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:55:25 -0800 (PST)
Message-Id: <138b79a0b9987fceb2da1269fbed88f89221e061.1768298118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
References: <pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
	<pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 09:55:18 +0000
Subject: [PATCH v24 2/2] status: show comparison with push remote tracking
 branch
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

"git status" on a branch that follows a remote branch compares
commits on the current branch and the remote-tracking branch it
builds upon, to show "ahead", "behind", or "diverged" status.

When working on a feature branch that tracks a remote feature branch,
but you also want to track progress relative to the push destination
tracking branch (which may differ from the upstream branch), git status
now shows an additional comparison.

When the upstream tracking branch differs from the push destination
tracking branch, git status shows both the comparison with the upstream
tracking branch (as before) and an additional comparison with the push
destination tracking branch. The push branch comparison appears on a
separate line after the upstream branch status, using the same format.

Example output when tracking origin/main but push destination is
origin/feature:
    On branch feature
    Your branch and 'origin/main' have diverged,
    and have 3 and 1 different commits each, respectively.
      (use "git pull" if you want to integrate the remote branch with yours)

    Your branch is ahead of 'origin/feature' by 1 commit.
      (use "git push" to publish your local commits)

The comparison is only shown when the push destination tracking branch
differs from the upstream tracking branch, even if they are on the same
remote.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 105 ++++++++++++++--
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 360 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index fd592ec659..8d64a3bee6 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,12 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum {
+	ENABLE_ADVICE_PULL       = (1 << 0),
+	ENABLE_ADVICE_PUSH       = (1 << 1),
+	ENABLE_ADVICE_DIVERGENCE = (1 << 2),
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2230,13 +2236,69 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_remote_push_branch(struct branch *branch)
+{
+	struct remote *remote;
+	const char *push_remote;
+	char *push_dst = NULL;
+	char *tracking_ref;
+	const char *resolved;
+	char *ret;
+
+	if (!branch)
+		return NULL;
+
+	push_remote = pushremote_for_branch(branch, NULL);
+	if (!push_remote)
+		return NULL;
+
+	remote = remotes_remote_get(the_repository, push_remote);
+	if (!remote)
+		return NULL;
+
+	push_dst = remote_ref_for_branch(branch, 1);
+	if (!push_dst) {
+		if (remote->push.nr)
+			return NULL;
+		push_dst = xstrdup(branch->refname);
+	}
+
+	tracking_ref = (char *)tracking_for_push_dest(remote, push_dst, NULL);
+	free(push_dst);
+
+	if (!tracking_ref)
+		return NULL;
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		tracking_ref,
+		RESOLVE_REF_READING,
+		NULL, NULL);
+
+	if (!resolved) {
+		free(tracking_ref);
+		return NULL;
+	}
+
+	ret = xstrdup(resolved);
+	free(tracking_ref);
+	return ret;
+}
+
 static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
-				     bool show_divergence_advice)
+				     unsigned flags)
 {
+	bool enable_push_advice = (flags & ENABLE_ADVICE_PUSH) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool enable_pull_advice = (flags & ENABLE_ADVICE_PULL) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool enable_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+
 	if (up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
@@ -2245,7 +2307,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2254,7 +2316,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2265,7 +2327,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_pull_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2278,8 +2340,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_divergence_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2296,6 +2357,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	unsigned base_branch_flags = ENABLE_ADVICE_PULL | ENABLE_ADVICE_PUSH;
+	int push_ours, push_theirs, push_cmp_fetch;
+	char *full_push;
+	char *push = NULL;
+	unsigned push_branch_flags = 0;
 
 	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (cmp_fetch < 0) {
@@ -2307,6 +2373,20 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	full_push = get_remote_push_branch(branch);
+	if (full_push) {
+		push = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+						     full_push, 0);
+		if (push && base && strcmp(base, push)) {
+			push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
+						   &push_ours, &push_theirs, abf);
+			if (push_cmp_fetch >= 0) {
+				base_branch_flags = ENABLE_ADVICE_PULL;
+				push_branch_flags = ENABLE_ADVICE_PUSH;
+			}
+		}
+	}
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2315,10 +2395,21 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+		if (show_divergence_advice)
+			base_branch_flags |= ENABLE_ADVICE_DIVERGENCE;
+		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf,
+					 base_branch_flags);
+	}
+
+	if (push_branch_flags & ENABLE_ADVICE_PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
+					 push_branch_flags);
 	}
 
 	free(base);
+	free(full_push);
+	free(push);
 	return 1;
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..cf5a926dcd 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,266 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'status tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch b4
+	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch b4
+	Your branch and ${SQ}origin/main${SQ} refer to different commits.
+	  (use "git status --ahead-behind" for details)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows ahead of both origin/main and feature branch' '
+	(
+		cd test &&
+		git checkout -b feature2 origin/main &&
+		git push origin HEAD &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature2
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
+	(
+		cd test &&
+		git checkout feature2 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for ahead of tracked but diverged from main' '
+	(
+		cd test &&
+		git checkout -b feature4 origin/main &&
+		advance work1 &&
+		git checkout origin/main &&
+		advance work2 &&
+		git push origin HEAD:main &&
+		git checkout feature4 &&
+		advance work3
+	)
+'
+
+test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
+	(
+		cd test &&
+		git checkout feature4 &&
+		git branch --set-upstream-to origin/main &&
+		git push origin HEAD &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} have diverged,
+	and have 3 and 1 different commits each, respectively.
+	  (use "git pull" if you want to integrate the remote branch with yours)
+
+	Your branch is ahead of ${SQ}origin/feature4${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind shows diverged from origin/main and ahead of feature branch' '
+	(
+		cd test &&
+		git checkout feature4 &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} refer to different commits.
+
+	Your branch and ${SQ}origin/feature4${SQ} refer to different commits.
+	  (use "git status --ahead-behind" for details)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream remote' '
+	(
+		cd test &&
+		git remote add upstream ../. &&
+		git fetch upstream &&
+		git config remote.pushDefault origin
+	)
+'
+
+test_expect_success 'status with upstream remote and push.default set to origin' '
+	(
+		cd test &&
+		git checkout -b feature5 upstream/main &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature5
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
+	(
+		cd test &&
+		git checkout -b feature6 upstream/main &&
+		advance work &&
+		git push origin &&
+		git reset --hard upstream/main &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature6
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch and ${SQ}origin/feature6${SQ} have diverged,
+	and have 1 and 1 different commits each, respectively.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with upstream remote and push branch up to date' '
+	(
+		cd test &&
+		git checkout -b feature7 upstream/main &&
+		git push origin &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind with upstream remote and push branch up to date' '
+	(
+		cd test &&
+		git checkout feature7 &&
+		git push origin &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows push branch up to date' '
+	(
+		cd test &&
+		git checkout feature7 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows remapped push refspec' '
+	(
+		cd test &&
+		git checkout -b feature8 origin/main &&
+		git config remote.origin.push refs/heads/feature8:refs/heads/remapped &&
+		git push &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows remapped push refspec with upstream remote' '
+	(
+		cd test &&
+		git checkout -b feature9 upstream/main &&
+		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature9
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
