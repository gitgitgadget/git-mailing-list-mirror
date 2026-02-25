Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B00319852
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056273; cv=none; b=nf4JDow2z3LLPGIy2bfgG0tV0l2OJrtA1C+J0+2X6iif2feAL0LDBnQKqmnRrE/+DiQMHr/DUF6yVm/F4RCw86qecb4vnKcUlxypWmsSPZEiysqOq1jxsQ+pM3knybgy2bS3/dUE7M9fyHPuUbmxQBhyiy4KKyr4x5O30nCrfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056273; c=relaxed/simple;
	bh=Gx92/OSwXbzoom1DKBwm3Sug6Vp/PGxbAm77xsB9qo0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jE2+/ItLf/uEJPVOYsaID62U5QJa/kR56LFhh/n3i2hOKcplZE/j2+zo9alZnY1J9dhQFZIt+sm0oyeJEbTNsDd0ANMv1JOsNHU2ifsbd8sl3BpMhZkcLcwGCbpwCNcdPoiQrwZc/h2qERJvWPE2BEW4cXPt0J+fDPC4ue6eAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrtJ9Mwc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrtJ9Mwc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb420fbb5dso5337085a.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772056268; x=1772661068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fqPJKm7NpxcO76fgZ5LxbxtCJJRcHNj5YYofNcsveg=;
        b=hrtJ9MwcrkFrGwNpaz7TzYW6aiaJ1tzKbHlC8g5GS62UxahRqpbogLxyzkNpoR9NIx
         nT03wVvFBrFVOWzIxU0ZL6tQghoqNtBwNo1cf1sjrjtfnEfgKdMeyxDoU42td6bv29Fs
         F3Fc3e8YvM6JMm0BD+J655sVQPJCTzgH2Zb9sz8UsHqc0BEqsJA/xkuXZLPsxZEEzsfP
         L8yrVUFTFw2GNOeIK9tVEgpSBf7qh4Ev2MZ8V9S4Uad3lHBNaHArSX7NAcRzIONkbQ5w
         0DhHQUzunLWv7YJhcE7nVPxm2fN4jmrxM+QuVzeACj+aogFmHwhqVewUdmmlcQyLS5Zu
         WuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056268; x=1772661068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fqPJKm7NpxcO76fgZ5LxbxtCJJRcHNj5YYofNcsveg=;
        b=Y5MzsSFLlbCeKQ/fdcShkCQFSS9A0RUZBEJGlJg3mdFzOb7XJsw87lZSQGTBA00uLd
         R4gsCQdKY/BrnrVwv96AGBu6P5E8lTVo6/RLHVKgvtcJkorocehEE4TxqvXuRT2ZC8qy
         8MqRppvjUEucNlqkFmBlIcY/ZNjpbFq7dnDh2fWSFeVekPjuqU/nkRi5yo3CszvYV2G+
         t+nGzrc8CLlpvqxjdAqGEjgyVfy59DnwijhQIGlIyewEaTT2XOVg1YHpEmdX0fr4vv38
         aUKL6DWjcY/MFM95Tk47G2hhl89I1xkM5uvq/F03lJwCCskSk25cnZDW4Mk7hTfJTkYY
         hvog==
X-Gm-Message-State: AOJu0YxUFi4I8TSpShcBZmH2xeEydsZ3GNRc81v418LMNOM8ne48kfNB
	Et5Aa6pNwQdYiPaCAhrucnwLvo6ziaQcgecoeBlkTlVP77H2h54ZP1+Dc/wInw==
X-Gm-Gg: ATEYQzzFAAvf0L/bkIdjorqlkCNChJYiOdbBhgrLKA8srBMa8eHj58r3XOj67wgFXSq
	Duc3heq6MyC/7MEUvUXu3qjXusaa5L1O+APc6hitlT/QzdHWfbvvmqANvmpumlL37lQ6V6Pyytu
	3k7uO0YVTNKY9VhEFN3+9vNoedwJHjAw8EjEIlmGelwqUG5oJzjYLy7yNq4RJG9Z5K7pYie8Qhb
	n/o3wUe6TXovy+ZCiKp6qOVn3DGW73nxbwrkfWjXf2+Cky3pvOxbn7KLUWnN0HQ8oYUH/SJGlkv
	rcMKepiksRTSg8i91OaHSKPH5141qnqkMQuWW+IjDaJXAgtM11GyyYX/3f0W2RpBT6lsD3gsrAI
	4euZ6Fh/hEHMO8Yv5OxHmdlfm70bwpROQwu2QLUoCfK7mEfOL9JE4mky4VIBD40l3bECls1+xOj
	W0TZayLitJytwm+rSiw0XT53Oc6+YXgk3MAbf1
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr2249361985a.52.1772056267525;
        Wed, 25 Feb 2026 13:51:07 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf717f2bsm31439885a.35.2026.02.25.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:51:06 -0800 (PST)
Message-Id: <6a88f41fa52e7b24fdb75dda6cac692014cebbf6.1772056263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
References: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
	<pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 21:51:03 +0000
Subject: [PATCH v29 2/2] status: add status.compareBranches config for
 multiple branch comparisons
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

Add a new configuration variable status.compareBranches that allows
users to specify a space-separated list of branch comparisons in
git status output.

Supported values:
- @{upstream} for the current branch's upstream tracking branch
- @{push} for the current branch's push destination

Any other value is ignored and a warning is shown.

When not configured, the default behavior is equivalent to setting
`status.compareBranches = @{upstream}`, preserving backward
compatibility.

The advice messages shown are context-aware:
- "git pull" advice is shown only when comparing against @{upstream}
- "git push" advice is shown only when comparing against @{push}
- Divergence advice is shown for upstream branch comparisons

This is useful for triangular workflows where the upstream tracking
branch differs from the push destination, allowing users to see their
status relative to both branches at once.

Example configuration:
    [status]
        compareBranches = @{upstream} @{push}

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/status.adoc |  19 ++
 remote.c                         | 148 +++++++++++---
 t/t6040-tracking-info.sh         | 335 +++++++++++++++++++++++++++++++
 3 files changed, 474 insertions(+), 28 deletions(-)

diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index 8caf90f51c..15ccd0116b 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -17,6 +17,25 @@ status.aheadBehind::
 	`--no-ahead-behind` by default in linkgit:git-status[1] for
 	non-porcelain status formats.  Defaults to true.
 
+status.compareBranches::
+	A space-separated list of branch comparison specifiers to use in
+	linkgit:git-status[1]. Currently, only `@{upstream}` and `@{push}`
+	are supported. They are interpreted as `branch@{upstream}` and
+	`branch@{push}` for the current branch.
++
+If not set, the default behavior is equivalent to `@{upstream}`, which
+compares against the configured upstream tracking branch.
++
+Example:
++
+----
+[status]
+	compareBranches = @{upstream} @{push}
+----
++
+This would show comparisons against both the configured upstream and push
+tracking branches for the current branch.
+
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
diff --git a/remote.c b/remote.c
index e9e2f56ed6..cc6ff29438 100644
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
@@ -2234,13 +2240,42 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *resolve_compare_branch(struct branch *branch, const char *name)
+{
+	const char *resolved = NULL;
+
+	if (!branch || !name)
+		return NULL;
+
+	if (!strcasecmp(name, "@{upstream}"))
+		resolved = branch_get_upstream(branch, NULL);
+	else if (!strcasecmp(name, "@{push}"))
+		resolved = branch_get_push(branch, NULL);
+	else {
+		warning(_("ignoring value '%s' for status.compareBranches; only @{upstream} and @{push} are supported"),
+			name);
+		return NULL;
+	}
+
+	if (resolved)
+		return xstrdup(resolved);
+	return NULL;
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
@@ -2249,7 +2284,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2258,7 +2293,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2269,7 +2304,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_pull_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2282,8 +2317,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_divergence_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2296,34 +2330,92 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf,
 			 int show_divergence_advice)
 {
-	int ours, theirs, cmp_fetch;
-	const char *full_base;
-	char *base;
-	int upstream_is_gone = 0;
+	char *compare_branches = NULL;
+	struct string_list branches = STRING_LIST_INIT_DUP;
+	struct strset processed_refs = STRSET_INIT;
+	int reported = 0;
+	size_t i;
+	const char *upstream_ref;
+	const char *push_ref;
 
-	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (cmp_fetch < 0) {
-		if (!full_base)
-			return 0;
-		upstream_is_gone = 1;
+	repo_config_get_string(the_repository, "status.comparebranches",
+			       &compare_branches);
+
+	if (compare_branches) {
+		string_list_split(&branches, compare_branches, " ", -1);
+		string_list_remove_empty_items(&branches, 0);
+	} else {
+		string_list_append(&branches, "@{upstream}");
 	}
 
-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    full_base, 0);
+	upstream_ref = branch_get_upstream(branch, NULL);
+	push_ref = branch_get_push(branch, NULL);
 
-	if (upstream_is_gone) {
-		strbuf_addf(sb,
-			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else {
-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+	for (i = 0; i < branches.nr; i++) {
+		char *full_ref;
+		char *short_ref;
+		int ours, theirs, cmp;
+		int is_upstream, is_push;
+		unsigned flags = 0;
+
+		full_ref = resolve_compare_branch(branch,
+						  branches.items[i].string);
+		if (!full_ref)
+			continue;
+
+		if (!strset_add(&processed_refs, full_ref)) {
+			free(full_ref);
+			continue;
+		}
+
+		short_ref = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), full_ref, 0);
+
+		is_upstream = upstream_ref && !strcmp(full_ref, upstream_ref);
+		is_push = push_ref && !strcmp(full_ref, push_ref);
+
+		if (is_upstream && (!push_ref || !strcmp(upstream_ref, push_ref)))
+			is_push = 1;
+
+		cmp = stat_branch_pair(branch->refname, full_ref,
+				       &ours, &theirs, abf);
+
+		if (cmp < 0) {
+			if (is_upstream) {
+				strbuf_addf(sb,
+					_("Your branch is based on '%s', but the upstream is gone.\n"),
+					short_ref);
+				if (advice_enabled(ADVICE_STATUS_HINTS))
+					strbuf_addstr(sb,
+						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+				reported = 1;
+			}
+			free(full_ref);
+			free(short_ref);
+			continue;
+		}
+
+		if (reported)
+			strbuf_addstr(sb, "\n");
+
+		if (is_upstream)
+			flags |= ENABLE_ADVICE_PULL;
+		if (is_push)
+			flags |= ENABLE_ADVICE_PUSH;
+		if (show_divergence_advice && is_upstream)
+			flags |= ENABLE_ADVICE_DIVERGENCE;
+		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
+					 abf, flags);
+		reported = 1;
+
+		free(full_ref);
+		free(short_ref);
 	}
 
-	free(base);
-	return 1;
+	string_list_clear(&branches, 0);
+	strset_clear(&processed_refs);
+	free(compare_branches);
+	return reported;
 }
 
 static int one_local_ref(const struct reference *ref, void *cb_data)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..aa9456bb61 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,339 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+test_expect_success 'setup for compareBranches tests' '
+	(
+		cd test &&
+		git config push.default current &&
+		git config status.compareBranches "@{upstream} @{push}"
+	)
+'
+
+test_expect_success 'status.compareBranches from upstream has no duplicates' '
+	(
+		cd test &&
+		git checkout main &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
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
+test_expect_success 'checkout with status.compareBranches shows both branches' '
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
+test_expect_success 'status.compareBranches shows diverged and ahead' '
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
+test_expect_success 'status --no-ahead-behind with status.compareBranches' '
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
+test_expect_success 'status.compareBranches with upstream and origin remotes' '
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
+test_expect_success 'status.compareBranches supports ordered upstream/push entries' '
+	(
+		cd test &&
+		git checkout -b feature6 upstream/main &&
+		git push origin &&
+		advance work &&
+		git -c status.compareBranches="@{push} @{upstream}" status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature6
+	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with diverged push branch' '
+	(
+		cd test &&
+		git checkout -b feature7 upstream/main &&
+		advance work &&
+		git push origin &&
+		git reset --hard upstream/main &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch and ${SQ}origin/feature7${SQ} have diverged,
+	and have 1 and 1 different commits each, respectively.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches shows up to date branches' '
+	(
+		cd test &&
+		git checkout -b feature8 upstream/main &&
+		git push origin &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind with status.compareBranches up to date' '
+	(
+		cd test &&
+		git checkout feature8 &&
+		git push origin &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout with status.compareBranches shows up to date' '
+	(
+		cd test &&
+		git checkout feature8 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with upstream behind and push up to date' '
+	(
+		cd test &&
+		git checkout -b ahead upstream/main &&
+		advance work &&
+		git push upstream HEAD &&
+		git checkout -b feature9 upstream/main &&
+		git push origin &&
+		git branch --set-upstream-to upstream/ahead &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature9
+	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull" to update your local branch)
+
+	Your branch is up to date with ${SQ}origin/feature9${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with remapped push refspec' '
+	(
+		cd test &&
+		git checkout -b feature10 origin/main &&
+		git config remote.origin.push refs/heads/feature10:refs/heads/remapped &&
+		git push &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature10
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
+test_expect_success 'status.compareBranches with remapped push and upstream remote' '
+	(
+		cd test &&
+		git checkout -b feature11 upstream/main &&
+		git config remote.origin.push refs/heads/feature11:refs/heads/remapped &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature11
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
+test_expect_success 'clean up after compareBranches tests' '
+	(
+		cd test &&
+		git config --unset status.compareBranches
+	)
+'
+
 test_done
-- 
gitgitgadget
