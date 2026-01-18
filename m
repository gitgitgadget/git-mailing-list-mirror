Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBAB67E
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768766371; cv=none; b=jlLxd5sRPWVK7j+JiKMSxgz7nQzN2DrqB6Jj7bmV5JRybavSMl+eCkg230ugKTxU1gHlF0WariE7gSEL/cnriSwDRmKxaLOnBPP69q3uESVFATT4QBDUEbIbU06tAOnHMAFIrPLceXgYOWrPE7jMiLHryDf23QJ/NJid7JsWGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768766371; c=relaxed/simple;
	bh=H0LmaguYuW/YNIz7/wkLczTu8CNd8hg8RWQLMdMJxqg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V41l6NWeoCBJGjNNiSzVOMBCeF439lFXa6dlT54W6dMkiEG9ZaijrmK47EpPfjrgbdzVydqi0ATBIKce8ox3l2O9/jEzbkzAdCHIOzXX8xwcz64wchEixF5DacYgauxbHAyWGMjWfxhvBFUdRmq2+ZXMJceQxX9uP67njFh3hlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2kijr5B; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2kijr5B"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c52e25e636so568769585a.2
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 11:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768766358; x=1769371158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BWfGVdSkH6YL+G3KOG9++v5tToK063xyLBf1M6txyg=;
        b=L2kijr5BrpikDD/C+QoiSTc1p3Q2T8u7VGN4jyvgofGsS5WG7PfGjRc561lnn8gjO+
         0XJsIQ99jzJlVxK5jxM4GjlrmTRMjuc527N6FavZiTYXRErI7j4ADDPnVvYlXSFhDJIj
         felwsGI/ShZzMZi0lTjH2/lC5RU7SMyc+pUg1iqBKF2jCIocEKIIspTWp+BFdlihu3dh
         HrmzjWVtegMrEGI5FS3w1CmLtYyxKZyz9B2Dbuyy4aMdQtiltAhOgU9pRzRZWi9PC7Dr
         FVU3Rpz0cRCuY7yBfthixMaQVPcslpYkslYbbYVGFJJe/J1XBkAYf4TU++Ra7AF/8cPR
         Y9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768766358; x=1769371158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BWfGVdSkH6YL+G3KOG9++v5tToK063xyLBf1M6txyg=;
        b=ckzx2AQEND4O03OcgQGB1TF2SQ8qA1p4b68LVKjdGXOnsa7RBZrC3ZB1oAmNxYsxzl
         MbZN9V5qYzxwSae7/snChakLunQhZpiutM1Py6Th6SByoPxPE638KP1hMFj9rJypeRkL
         5hYWUIgBnBtUm6u07HUAW4yxjre0DbMABTVh1w5QuBR8/7y/P3puYEms8M0X4+xxdheO
         ENWZWbw/n1Xcin746I8evmAVm3Da8wtZEPCbBzU3bS0FjyKj5IR3BF7da/gVhSvdMGGH
         6Xzni2pa0fNNNyQtHGsY2IopFJBTmdt46dvu38sF0WGuMylmyMjJ2DrUA8fN4Y4PSIHK
         Fi9g==
X-Gm-Message-State: AOJu0Ywm+HgwhZHsMWasISw6wLw8ZFKLyKVvjTjJ+RY1fKpT9QG0vYmi
	osenq3dpbpebyn9Zoh3xVKMsHjvzTJDmFPxPpK6epMwCeLjIeMIAguExRVchlA==
X-Gm-Gg: AY/fxX7LMzRMoaAYMfyw9LKF6oc+3MiWUrGXmpvm4kBvNN0SC4ZEX+4mRDnBq93lRmM
	zJkcGecHYRTHbICZ2guGSiO0AxV6buCT+xIdOZWsHFqY60btYYR0e+k+/CL6p0PmNhGD+Z1sO7u
	Fx2bAXzAR0qvRQRJ+BeaX2QPALawi1CllRojyrEJNU7CjMv3mbSktil/VGcRWC9lKC33nOHUG+q
	0Ska2V7NO8gKR53wphraY3aR6zRELtgylgrifgYssYjj7pkvGhX9Ss4k478oaWBcAE8yoGgzVUl
	VA5HQ5PxdWcATxcQQAYLLqsgXfzOFhBemZaQ4MhwFwyT629mw9am5CxoYpj4cQIWJfpJKhznM2Z
	edf7scxplwPBSWbP/S6Zbn7vx93IBmi880zibKuEPjJ4Sa4PzZ71lO7c1PksFH2ETVX44jCLVXz
	7UFgjJa+GJKo99L10iuRhL2g==
X-Received: by 2002:a05:620a:45a4:b0:8b9:ef89:e161 with SMTP id af79cd13be357-8c6a695638cmr1305218985a.58.1768766358124;
        Sun, 18 Jan 2026 11:59:18 -0800 (PST)
Received: from [127.0.0.1] ([20.161.30.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6049d9sm66500286d6.23.2026.01.18.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:59:17 -0800 (PST)
Message-Id: <caa761f6153b5b8992c63fea5b5c0fc9b9d444a5.1768766353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
References: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
	<pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Jan 2026 19:59:13 +0000
Subject: [PATCH v26 2/2] status: add status.compareBranches config for
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

Add a new configuration variable `status.compareBranches` that allows
users to specify a space-separated list of branches to compare against
the current branch in `git status` output.

Each branch in the list can be:
- A remote-tracking branch name (e.g., `origin/main`)
- The special reference `@{upstream}` for the tracking branch
- The special reference `@{push}` for the push destination

When not configured, the default behavior is equivalent to setting
`status.compareBranches = @{upstream}`, preserving backward compatibility.

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
 Documentation/config/status.adoc |  20 ++
 remote.c                         | 157 ++++++++++++---
 t/t6040-tracking-info.sh         | 322 +++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index 8caf90f51c..ab54f25fbc 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -17,6 +17,26 @@ status.aheadBehind::
 	`--no-ahead-behind` by default in linkgit:git-status[1] for
 	non-porcelain status formats.  Defaults to true.
 
+status.compareBranches::
+	A space-separated list of branches to compare the current branch
+	against in linkgit:git-status[1]. Each branch specification can be
+	a remote-tracking branch name (e.g. `origin/main`), or a special
+	reference like `@{upstream}` or `@{push}`. For each branch in the
+	list, git status shows whether the current branch is ahead, behind,
+	or has diverged from that branch.
++
+If not set, the default behavior is equivalent to `@{upstream}`, which
+compares against the configured upstream tracking branch.
++
+Example:
++
+----
+[status]
+	compareBranches = origin/main origin/develop
+----
++
+This would show comparisons against both `origin/main` and `origin/develop`.
+
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
diff --git a/remote.c b/remote.c
index fd592ec659..1ea17cbbfa 100644
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
@@ -272,6 +278,7 @@ static void branch_release(struct branch *branch)
 	free((char *)branch->refname);
 	free(branch->remote_name);
 	free(branch->pushremote_name);
+	free((char *)branch->push_tracking_ref);
 	merge_clear(branch);
 }
 
@@ -2230,13 +2237,53 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *resolve_compare_branch(struct branch *branch, const char *name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *resolved = NULL;
+	char *ret;
+
+	if (!branch || !name)
+		return NULL;
+
+	if (!strcasecmp(name, "@{upstream}") || !strcasecmp(name, "@{u}"))
+		resolved = branch_get_upstream(branch, NULL);
+	else if (!strcasecmp(name, "@{push}"))
+		resolved = branch_get_push(branch, NULL);
+
+	if (resolved)
+		return xstrdup(resolved);
+
+	strbuf_addf(&buf, "refs/remotes/%s", name);
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		buf.buf,
+		RESOLVE_REF_READING,
+		NULL, NULL);
+	if (resolved) {
+		ret = xstrdup(resolved);
+		strbuf_release(&buf);
+		return ret;
+	}
+
+	strbuf_release(&buf);
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
@@ -2245,7 +2292,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2254,7 +2301,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2265,7 +2312,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_pull_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2278,8 +2325,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_divergence_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2292,34 +2338,87 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf,
 			 int show_divergence_advice)
 {
-	int ours, theirs, cmp_fetch;
-	const char *full_base;
-	char *base;
-	int upstream_is_gone = 0;
-
-	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (cmp_fetch < 0) {
-		if (!full_base)
-			return 0;
-		upstream_is_gone = 1;
+	char *compare_branches_config = NULL;
+	struct string_list compare_branches = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int reported = 0;
+	size_t i;
+	const char *upstream_ref;
+	const char *push_ref;
+
+	repo_config_get_string(the_repository, "status.comparebranches",
+			       &compare_branches_config);
+
+	if (compare_branches_config) {
+		string_list_split(&compare_branches, compare_branches_config,
+				  " ", -1);
+		string_list_remove_empty_items(&compare_branches, 0);
+	} else {
+		string_list_append(&compare_branches, "@{upstream}");
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
+	for (i = 0; i < compare_branches.nr; i++) {
+		char *full_ref;
+		char *short_ref;
+		int ours, theirs, cmp;
+		int is_upstream, is_push;
+		unsigned flags = 0;
+
+		item = &compare_branches.items[i];
+		full_ref = resolve_compare_branch(branch, item->string);
+		if (!full_ref)
+			continue;
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
+	string_list_clear(&compare_branches, 0);
+	free(compare_branches_config);
+	return reported;
 }
 
 static int one_local_ref(const struct reference *ref, void *cb_data)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..ea899a5679 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,326 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+test_expect_success 'status.compareBranches with upstream and origin remotes multiple compare branches' '
+	(
+		cd test &&
+		git checkout -b feature6 upstream/main &&
+		git push origin &&
+		advance work &&
+		git -c status.compareBranches="upstream/main origin/feature6 origin/feature5" status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature6
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
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
