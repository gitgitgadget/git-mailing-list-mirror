Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB30B67E
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768766358; cv=none; b=S9r1BRhPlTTqyQONKKsm2rSlYsWaYXA7LbO93txpKSb/kEQv79z/cg5kFxGgOKQXPQ30c/2ErGpSJFnnvcMqOZnF9A4/lhYRTwpXYSFkWvmU2Gb/+pGSh/owmluyw/X8VkaW5mLSTqn/SzKOgsveENmSVzXpEMSaViiGBLi91ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768766358; c=relaxed/simple;
	bh=Q9hoHh1gslaw9iVgsvb4E3gxgjX0TFZRdPPV2lrHWUo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E7AOHcNVOMAeMm3elvFXOW2Hh/+PCyXOJr+6E24KgR52psBrT9Q3UR6sXNXolGKvsPPSdDhlfufDvBoG+/cOprJcQfAkgzAAps3pQDi6IFpqBMcCt3EVnONdJJaxUGzDSPtWCm83ocJeGvJ4yPzIWdeYTAao0aLD5vL5l/BRNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxj1XHXK; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxj1XHXK"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a37cb5afdso66522666d6.0
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768766354; x=1769371154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/l+FlslkOGzR8ylrurUsP02Pw8n0IoqOR3gJwbKv7I=;
        b=Qxj1XHXKgg/jZIgX0UjJx0RyCv97KGgiRaxBSZ3NL+2b30Y08CW/4bRnoAnr5KUNT8
         og9Y5kCuaXQNHv4CLUOtL/PCuJ7y4RdgMOZAEAxqogGQ/WgS1UKb0TXtz9dRr8jdwHxX
         dELdj2bEiExPGLbrMgeZKPm+k3uCuk3JZetijfPVFlYI9kxA8lZ5PH/m31DFy2Hfx78g
         JFESqc/FVYP3d00q9SeKHIRqwkGqNPygWnETqBHBXJ1z1kdIF15mPVGxCMl0NsZxEkFk
         oyAwq+AyfMxc5U24Q4MIBAwcyn6sUUSwnCKWBNi3QbLibXgWuoe0607g7GIc/AUaHs/i
         0EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768766354; x=1769371154;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/l+FlslkOGzR8ylrurUsP02Pw8n0IoqOR3gJwbKv7I=;
        b=TTo1TP5w5yZeTvF0l6yvY8G6gdhQv9/7YEIBw408AbUz0HdyQoT8OGH9uLnXInW5YV
         8sFSNL+qpadzcjCq3dP6DMT62OCMh0x5ylzbA51Zh7udV5+78HA9nG+/mLbufyoW/YKP
         +Iv7g4A9547O2WqD9hXCCj0FJhKeMe5qFnfOgCIh7vSkGDa5Q2aeyySSy1qNbytDGYcZ
         pjOuoOGFJStjbLnV+VV8fHlyLHXdDnQG1aoHr0U0grVp7aotBND3ijJihbIYIuCa2PmB
         lpDOW7xKrzD6kozok0x7whty5K2UacRRE0nkBYAUXRxHAvfEGEcwmebiiF/T7zBjtbi8
         M2hw==
X-Gm-Message-State: AOJu0YyEvJzME7Valugah3svUHUFMgTRCXmsGGwuqLNx+rDj6RnH6awZ
	Ydk4eXunfORm0J0Emsa/GnkSGQexpVA7b3cSZv9er6zO5y0EsFmjt7r8yz1tbg==
X-Gm-Gg: AY/fxX72F3dO21gfmE3GMsG2bWcTaShld6LT/PPhLVYL3QvDffPuR2Cgud4WA6F0s1I
	fGqv7aZx/0e3mJGC/77vUdmQZzFaeB+hx+bu1NKWhgYlbuNBCKIkD/5aFn8PrI5PROi9sYEXeCo
	tHQF9J9Jrr332ffE10nk11LoSrxglGAxWGP6B81ww3Bvf9q0WSzUqsCnVi7yDRSbJ08UulUCMTd
	1Vw/oYJNsZ67mqhpW9+uuycXmXlX9BTedqBsp2o5j9m8Ek/aKBpKQsJXHSqON1rmtq2CvjsEDuM
	HSukSTZcTgZfBNoPShBA3NL3PQ9qlW7/Exh017UFfhKmEpRMgxlbGgvfbYpLNrX9xSrGHclSeJQ
	VgZP6/jET9pxBYalPtxYlA67HBnFm/p8bmwxDDZhhETibAmresvO6U9Muoss6AowxwQjb16bBQG
	TLiDdq+lueL+8=
X-Received: by 2002:a05:6214:4015:b0:88a:42b1:2600 with SMTP id 6a1803df08f44-8942d7cb6bfmr109059636d6.28.1768766354173;
        Sun, 18 Jan 2026 11:59:14 -0800 (PST)
Received: from [127.0.0.1] ([20.161.30.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab202sm658559585a.11.2026.01.18.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:59:13 -0800 (PST)
Message-Id: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
References: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Jan 2026 19:59:11 +0000
Subject: [PATCH v26 0/2] status: add status.compareBranches config for multiple branch comparisons
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
Jeff King peff@peff.net

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: add status.compareBranches config for multiple branch
    comparisons

 Documentation/config/status.adoc |  20 ++
 remote.c                         | 187 ++++++++++++++----
 t/t6040-tracking-info.sh         | 322 +++++++++++++++++++++++++++++++
 3 files changed, 492 insertions(+), 37 deletions(-)


base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v26
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v26
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v25:

 1:  fd05c7b778 = 1:  27a46f8d9c refactor format_branch_comparison in preparation
 2:  fa744efc59 ! 2:  caa761f615 status: show comparison with push remote tracking branch
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    status: show comparison with push remote tracking branch
     +    status: add status.compareBranches config for multiple branch comparisons
      
     -    "git status" on a branch that follows a remote branch compares
     -    commits on the current branch and the remote-tracking branch it
     -    builds upon, to show "ahead", "behind", or "diverged" status.
     +    Add a new configuration variable `status.compareBranches` that allows
     +    users to specify a space-separated list of branches to compare against
     +    the current branch in `git status` output.
      
     -    When working on a feature branch that tracks a remote feature branch,
     -    but you also want to track progress relative to the push destination
     -    tracking branch (which may differ from the upstream branch), git status
     -    now shows an additional comparison.
     +    Each branch in the list can be:
     +    - A remote-tracking branch name (e.g., `origin/main`)
     +    - The special reference `@{upstream}` for the tracking branch
     +    - The special reference `@{push}` for the push destination
      
     -    When the upstream tracking branch differs from the push destination
     -    tracking branch, git status shows both the comparison with the upstream
     -    tracking branch (as before) and an additional comparison with the push
     -    destination tracking branch. The push branch comparison appears on a
     -    separate line after the upstream branch status, using the same format.
     +    When not configured, the default behavior is equivalent to setting
     +    `status.compareBranches = @{upstream}`, preserving backward compatibility.
      
     -    Example output when tracking origin/main but push destination is
     -    origin/feature:
     -        On branch feature
     -        Your branch and 'origin/main' have diverged,
     -        and have 3 and 1 different commits each, respectively.
     -          (use "git pull" if you want to integrate the remote branch with yours)
     +    The advice messages shown are context-aware:
     +    - "git pull" advice is shown only when comparing against @{upstream}
     +    - "git push" advice is shown only when comparing against @{push}
     +    - Divergence advice is shown for upstream branch comparisons
      
     -        Your branch is ahead of 'origin/feature' by 1 commit.
     -          (use "git push" to publish your local commits)
     +    This is useful for triangular workflows where the upstream tracking
     +    branch differs from the push destination, allowing users to see their
     +    status relative to both branches at once.
      
     -    The comparison is only shown when the push destination tracking branch
     -    differs from the upstream tracking branch, even if they are on the same
     -    remote.
     +    Example configuration:
     +        [status]
     +            compareBranches = @{upstream} @{push}
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## Documentation/config/status.adoc ##
     +@@ Documentation/config/status.adoc: status.aheadBehind::
     + 	`--no-ahead-behind` by default in linkgit:git-status[1] for
     + 	non-porcelain status formats.  Defaults to true.
     + 
     ++status.compareBranches::
     ++	A space-separated list of branches to compare the current branch
     ++	against in linkgit:git-status[1]. Each branch specification can be
     ++	a remote-tracking branch name (e.g. `origin/main`), or a special
     ++	reference like `@{upstream}` or `@{push}`. For each branch in the
     ++	list, git status shows whether the current branch is ahead, behind,
     ++	or has diverged from that branch.
     +++
     ++If not set, the default behavior is equivalent to `@{upstream}`, which
     ++compares against the configured upstream tracking branch.
     +++
     ++Example:
     +++
     ++----
     ++[status]
     ++	compareBranches = origin/main origin/develop
     ++----
     +++
     ++This would show comparisons against both `origin/main` and `origin/develop`.
     ++
     + status.displayCommentPrefix::
     + 	If set to true, linkgit:git-status[1] will insert a comment
     + 	prefix before each output line (starting with
     +
       ## remote.c ##
      @@
       
     @@ remote.c
       struct counted_string {
       	size_t len;
       	const char *s;
     +@@ remote.c: static void branch_release(struct branch *branch)
     + 	free((char *)branch->refname);
     + 	free(branch->remote_name);
     + 	free(branch->pushremote_name);
     ++	free((char *)branch->push_tracking_ref);
     + 	merge_clear(branch);
     + }
     + 
      @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
       
     -+static char *get_remote_push_branch(struct branch *branch)
     ++static char *resolve_compare_branch(struct branch *branch, const char *name)
      +{
     -+	struct remote *remote;
     -+	const char *push_remote;
     -+	char *push_dst = NULL;
     -+	char *tracking_ref;
     -+	const char *resolved;
     ++	struct strbuf buf = STRBUF_INIT;
     ++	const char *resolved = NULL;
      +	char *ret;
      +
     -+	if (!branch)
     -+		return NULL;
     -+
     -+	push_remote = pushremote_for_branch(branch, NULL);
     -+	if (!push_remote)
     ++	if (!branch || !name)
      +		return NULL;
      +
     -+	remote = remotes_remote_get(the_repository, push_remote);
     -+	if (!remote)
     -+		return NULL;
     ++	if (!strcasecmp(name, "@{upstream}") || !strcasecmp(name, "@{u}"))
     ++		resolved = branch_get_upstream(branch, NULL);
     ++	else if (!strcasecmp(name, "@{push}"))
     ++		resolved = branch_get_push(branch, NULL);
      +
     -+	push_dst = remote_ref_for_branch(branch, 1);
     -+	if (!push_dst) {
     -+		if (remote->push.nr)
     -+			return NULL;
     -+		push_dst = xstrdup(branch->refname);
     -+	}
     -+
     -+	tracking_ref = (char *)tracking_for_push_dest(remote, push_dst, NULL);
     -+	free(push_dst);
     -+
     -+	if (!tracking_ref)
     -+		return NULL;
     ++	if (resolved)
     ++		return xstrdup(resolved);
      +
     ++	strbuf_addf(&buf, "refs/remotes/%s", name);
      +	resolved = refs_resolve_ref_unsafe(
      +		get_main_ref_store(the_repository),
     -+		tracking_ref,
     ++		buf.buf,
      +		RESOLVE_REF_READING,
      +		NULL, NULL);
     -+
     -+	if (!resolved) {
     -+		free(tracking_ref);
     -+		return NULL;
     ++	if (resolved) {
     ++		ret = xstrdup(resolved);
     ++		strbuf_release(&buf);
     ++		return ret;
      +	}
      +
     -+	ret = xstrdup(resolved);
     -+	free(tracking_ref);
     -+	return ret;
     ++	strbuf_release(&buf);
     ++	return NULL;
      +}
      +
       static void format_branch_comparison(struct strbuf *sb,
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
       	}
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 	const char *full_base;
     - 	char *base;
     - 	int upstream_is_gone = 0;
     -+	unsigned base_branch_flags = ENABLE_ADVICE_PULL | ENABLE_ADVICE_PUSH;
     -+	int push_ours, push_theirs, push_cmp_fetch;
     -+	char *full_push;
     -+	char *push = NULL;
     -+	unsigned push_branch_flags = 0;
     + 			 enum ahead_behind_flags abf,
     + 			 int show_divergence_advice)
     + {
     +-	int ours, theirs, cmp_fetch;
     +-	const char *full_base;
     +-	char *base;
     +-	int upstream_is_gone = 0;
     +-
     +-	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     +-	if (cmp_fetch < 0) {
     +-		if (!full_base)
     +-			return 0;
     +-		upstream_is_gone = 1;
     ++	char *compare_branches_config = NULL;
     ++	struct string_list compare_branches = STRING_LIST_INIT_DUP;
     ++	struct string_list_item *item;
     ++	int reported = 0;
     ++	size_t i;
     ++	const char *upstream_ref;
     ++	const char *push_ref;
     ++
     ++	repo_config_get_string(the_repository, "status.comparebranches",
     ++			       &compare_branches_config);
     ++
     ++	if (compare_branches_config) {
     ++		string_list_split(&compare_branches, compare_branches_config,
     ++				  " ", -1);
     ++		string_list_remove_empty_items(&compare_branches, 0);
     ++	} else {
     ++		string_list_append(&compare_branches, "@{upstream}");
     + 	}
       
     - 	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     - 	if (cmp_fetch < 0) {
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
     - 					    full_base, 0);
     +-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
     +-					    full_base, 0);
     ++	upstream_ref = branch_get_upstream(branch, NULL);
     ++	push_ref = branch_get_push(branch, NULL);
       
     -+	full_push = get_remote_push_branch(branch);
     -+	if (full_push) {
     -+		push = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
     -+						     full_push, 0);
     -+		if (push && base && strcmp(base, push)) {
     -+			push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
     -+						   &push_ours, &push_theirs, abf);
     -+			if (push_cmp_fetch >= 0) {
     -+				base_branch_flags = ENABLE_ADVICE_PULL;
     -+				push_branch_flags = ENABLE_ADVICE_PUSH;
     +-	if (upstream_is_gone) {
     +-		strbuf_addf(sb,
     +-			_("Your branch is based on '%s', but the upstream is gone.\n"),
     +-			base);
     +-		if (advice_enabled(ADVICE_STATUS_HINTS))
     +-			strbuf_addstr(sb,
     +-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     +-	} else {
     +-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
     ++	for (i = 0; i < compare_branches.nr; i++) {
     ++		char *full_ref;
     ++		char *short_ref;
     ++		int ours, theirs, cmp;
     ++		int is_upstream, is_push;
     ++		unsigned flags = 0;
     ++
     ++		item = &compare_branches.items[i];
     ++		full_ref = resolve_compare_branch(branch, item->string);
     ++		if (!full_ref)
     ++			continue;
     ++
     ++		short_ref = refs_shorten_unambiguous_ref(
     ++			get_main_ref_store(the_repository), full_ref, 0);
     ++
     ++		is_upstream = upstream_ref && !strcmp(full_ref, upstream_ref);
     ++		is_push = push_ref && !strcmp(full_ref, push_ref);
     ++
     ++		if (is_upstream && (!push_ref || !strcmp(upstream_ref, push_ref)))
     ++			is_push = 1;
     ++
     ++		cmp = stat_branch_pair(branch->refname, full_ref,
     ++				       &ours, &theirs, abf);
     ++
     ++		if (cmp < 0) {
     ++			if (is_upstream) {
     ++				strbuf_addf(sb,
     ++					_("Your branch is based on '%s', but the upstream is gone.\n"),
     ++					short_ref);
     ++				if (advice_enabled(ADVICE_STATUS_HINTS))
     ++					strbuf_addstr(sb,
     ++						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     ++				reported = 1;
      +			}
     ++			free(full_ref);
     ++			free(short_ref);
     ++			continue;
      +		}
     -+	}
      +
     - 	if (upstream_is_gone) {
     - 		strbuf_addf(sb,
     - 			_("Your branch is based on '%s', but the upstream is gone.\n"),
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 			strbuf_addstr(sb,
     - 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
     - 	} else {
     --		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
     -+		if (show_divergence_advice)
     -+			base_branch_flags |= ENABLE_ADVICE_DIVERGENCE;
     -+		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf,
     -+					 base_branch_flags);
     -+	}
     -+
     -+	if (push_branch_flags & ENABLE_ADVICE_PUSH) {
     -+		strbuf_addstr(sb, "\n");
     -+		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
     -+					 push_branch_flags);
     ++		if (reported)
     ++			strbuf_addstr(sb, "\n");
     ++
     ++		if (is_upstream)
     ++			flags |= ENABLE_ADVICE_PULL;
     ++		if (is_push)
     ++			flags |= ENABLE_ADVICE_PUSH;
     ++		if (show_divergence_advice && is_upstream)
     ++			flags |= ENABLE_ADVICE_DIVERGENCE;
     ++		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
     ++					 abf, flags);
     ++		reported = 1;
     ++
     ++		free(full_ref);
     ++		free(short_ref);
       	}
       
     - 	free(base);
     -+	free(full_push);
     -+	free(push);
     - 	return 1;
     +-	free(base);
     +-	return 1;
     ++	string_list_clear(&compare_branches, 0);
     ++	free(compare_branches_config);
     ++	return reported;
       }
       
     + static int one_local_ref(const struct reference *ref, void *cb_data)
      
       ## t/t6040-tracking-info.sh ##
      @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status shows ahead of both origin/main and feature branch' '
     ++test_expect_success 'setup for compareBranches tests' '
     ++	(
     ++		cd test &&
     ++		git config push.default current &&
     ++		git config status.compareBranches "@{upstream} @{push}"
     ++	)
     ++'
     ++
     ++test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
      +	(
      +		cd test &&
      +		git checkout -b feature2 origin/main &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
     ++test_expect_success 'checkout with status.compareBranches shows both branches' '
      +	(
      +		cd test &&
      +		git checkout feature2 >../actual
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	)
      +'
      +
     -+test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
     ++test_expect_success 'status.compareBranches shows diverged and ahead' '
      +	(
      +		cd test &&
      +		git checkout feature4 &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status --no-ahead-behind shows diverged from origin/main and ahead of feature branch' '
     ++test_expect_success 'status --no-ahead-behind with status.compareBranches' '
      +	(
      +		cd test &&
      +		git checkout feature4 &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	)
      +'
      +
     -+test_expect_success 'status with upstream remote and push.default set to origin' '
     ++test_expect_success 'status.compareBranches with upstream and origin remotes' '
      +	(
      +		cd test &&
      +		git checkout -b feature5 upstream/main &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
     ++test_expect_success 'status.compareBranches with upstream and origin remotes multiple compare branches' '
      +	(
      +		cd test &&
      +		git checkout -b feature6 upstream/main &&
     ++		git push origin &&
     ++		advance work &&
     ++		git -c status.compareBranches="upstream/main origin/feature6 origin/feature5" status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature6
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++
     ++	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status.compareBranches with diverged push branch' '
     ++	(
     ++		cd test &&
     ++		git checkout -b feature7 upstream/main &&
      +		advance work &&
      +		git push origin &&
      +		git reset --hard upstream/main &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature6
     ++	On branch feature7
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
      +
     -+	Your branch and ${SQ}origin/feature6${SQ} have diverged,
     ++	Your branch and ${SQ}origin/feature7${SQ} have diverged,
      +	and have 1 and 1 different commits each, respectively.
      +
      +	nothing to commit, working tree clean
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status with upstream remote and push branch up to date' '
     ++test_expect_success 'status.compareBranches shows up to date branches' '
      +	(
      +		cd test &&
     -+		git checkout -b feature7 upstream/main &&
     ++		git checkout -b feature8 upstream/main &&
      +		git push origin &&
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature7
     ++	On branch feature8
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature8${SQ}.
      +
      +	nothing to commit, working tree clean
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status --no-ahead-behind with upstream remote and push branch up to date' '
     ++test_expect_success 'status --no-ahead-behind with status.compareBranches up to date' '
      +	(
      +		cd test &&
     -+		git checkout feature7 &&
     ++		git checkout feature8 &&
      +		git push origin &&
      +		git status --no-ahead-behind >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature7
     ++	On branch feature8
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature8${SQ}.
      +
      +	nothing to commit, working tree clean
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'checkout shows push branch up to date' '
     ++test_expect_success 'checkout with status.compareBranches shows up to date' '
      +	(
      +		cd test &&
     -+		git checkout feature7 >../actual
     ++		git checkout feature8 >../actual
      +	) &&
      +	cat >expect <<-EOF &&
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature8${SQ}.
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status with upstream ahead and push branch up to date' '
     ++test_expect_success 'status.compareBranches with upstream behind and push up to date' '
      +	(
      +		cd test &&
      +		git checkout -b ahead upstream/main &&
      +		advance work &&
      +		git push upstream HEAD &&
     -+		git checkout -b feature8 upstream/main &&
     ++		git checkout -b feature9 upstream/main &&
      +		git push origin &&
      +		git branch --set-upstream-to upstream/ahead &&
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature8
     ++	On branch feature9
      +	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
      +	  (use "git pull" to update your local branch)
      +
     -+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature9${SQ}.
      +
      +	nothing to commit, working tree clean
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status shows remapped push refspec' '
     ++test_expect_success 'status.compareBranches with remapped push refspec' '
      +	(
      +		cd test &&
     -+		git checkout -b feature9 origin/main &&
     -+		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
     ++		git checkout -b feature10 origin/main &&
     ++		git config remote.origin.push refs/heads/feature10:refs/heads/remapped &&
      +		git push &&
      +		advance work &&
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature9
     ++	On branch feature10
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
      +
      +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status shows remapped push refspec with upstream remote' '
     ++test_expect_success 'status.compareBranches with remapped push and upstream remote' '
      +	(
      +		cd test &&
     -+		git checkout -b feature10 upstream/main &&
     -+		git config remote.origin.push refs/heads/feature10:refs/heads/remapped &&
     ++		git checkout -b feature11 upstream/main &&
     ++		git config remote.origin.push refs/heads/feature11:refs/heads/remapped &&
      +		git push origin &&
      +		advance work &&
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature10
     ++	On branch feature11
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
      +
      +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'clean up after compareBranches tests' '
     ++	(
     ++		cd test &&
     ++		git config --unset status.compareBranches
     ++	)
     ++'
      +
       test_done

-- 
gitgitgadget
