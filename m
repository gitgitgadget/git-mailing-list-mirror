Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537D3090C9
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655953; cv=none; b=bM9/LkAbVKLpzuHovgDWCoSBqj33NvKQJX73jlKT0udH86h53zHvMT3YdlbQ14uCHO0Bn5NbWa7aFU41PXXTFmMUbkEGPjmTgoy6H6TS9CZQtW81J4XBPXgxAjw1fcXYkX+yC9X/4JsyjRbeu40Fh2yCDw5xrLLePcQt20ujXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655953; c=relaxed/simple;
	bh=T2TTsdIvyAdKNim1b4LYS5ZXn09xXTglIa6QDqAuTi0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H9wgVo0L4jjRTAiCuCytoxzBp/aixnsp8UIpm2Xqe8y/PH8DCNePknNCcS1WWa6f3NSb4CGsjuzcTokW3FNC2fk+GvEa4d1Fzl9fWosViFpAexcY91HiCWdMNRIq1DQK+79IsrdwtXK0r3jFOCkqM8iI+uAE+AXKO3nv6ba9Nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGfxuO+l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGfxuO+l"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a081c163b0so61793875ad.0
        for <git@vger.kernel.org>; Thu, 25 Dec 2025 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766655950; x=1767260750; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGsu1twb9wGPkZdMEMUTxah17qEntqaaVRyD/s7tYwo=;
        b=EGfxuO+l/4VIfJEp9bJqytXW8mssLVUieu2gSREJiBNKj61TX4EI1PZ6BCfdDOSx6i
         EGnP0AmscxjPOnRS/ljeo/TMqmetmpqkKEpVVGQcKzGUMl00mRlZwDN7F9syBw6+i1t5
         lm9EP23FLWkPPJT1sGctyxxVFVfn0AF59IQpf4Rh9hwzFT1j1J5M+gtEFLzEeBKpEzsz
         /7oRZouiZSj1IystWwGNLCmgLFbDCXtNEc/1VovjRtiWwYYEqkEjZO7O7MdLq7HxkSdW
         ERn/sBHJKx7hz/T5BkNfUqjS2w/LlYgAllDqmvQKFvsUtMs1uG+uHZDK3j6N6wcZsNnD
         pSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766655950; x=1767260750;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGsu1twb9wGPkZdMEMUTxah17qEntqaaVRyD/s7tYwo=;
        b=H8eJjyZmkbug2T7v/Rh1cSTvXNpc/uOj6DU3FgEHdZSk0UjRZ50K/tAulxnCl0c9lL
         h0WdA44p9npBePx+KmifXKePaQEXTcHs0j8tKpvKqVC2GmOHwgUDnN+Rrv+m5vAWMTUv
         dYyYXOEi8ZgvSXeOWudrgSGedDy/zR5ZhGJGeH1dVsqqKhoXEBjCC5pasScCauhM1ECb
         yoFFOA+YgwZ8bs+I0MUJ27z/BbhdFzfEhPgLexPhnROYX4Vdch/Ksjg5jItmS4jXndy8
         3pubSXvKhupfhynx14YwRUFn3yFxVr2wxHUK5RmlcFttltmwE37Uis6qqmpt2zavnYKQ
         K2YQ==
X-Gm-Message-State: AOJu0Yx3X2e/218gnLoyVSaOAcbiL9/6OIZyU8fC/zpaB2IrVBe+CbDa
	U/huHc+174Ugl7vaUidc8F7oqwdax2rp4OEpebhpOfiLhXrMf1FS9T4m10lrZQ==
X-Gm-Gg: AY/fxX6M2QAsUqUKIdB+fUfpxCLSZm4it27V46/a0juIDtPWKULo5XjK3sAsRLe+8az
	nsgjlbTa/f9s1fnS6DDvs5p+XYupu+sbP7fNLqUQ6Gy1x+rx2Np1x+qOqc4rEhp3XLXzfWzQYRP
	Pj8q7LK3UWD7WrcyHRn1aXHz3qBmvhy0ciPZnyQI0lT/ERq0S9zZAOiAEKMNYN9zUd2cJyJ+aH5
	Tfv2pT33I3kPo8/e35OJgbPvc1ntKSmudw8LdK9alVlIJKSc0kVWz7C5v0zV8s3UXKzNZz1RMSy
	Uk8/5Enz1Uc23bPr/vqoz/JNNURovuBIRTT848bg5G7hVYVdE6NaBqIxLBLcDZ8u1NcZmdUXb4m
	Ro0D2aU/WJDzA78w7agKRXO51kJxmz4HuO5+d+jJSnYlF7c46yU+hNP+sMrrhDTPbnCTHKHLSz6
	1GfmKT7IO3KkumkSnVBpgVWg==
X-Google-Smtp-Source: AGHT+IEiwkL2ZdcEwvQF5mTq6q7PPJbb+eituVp66wbGLJsUdUZqYcPRHNY6smG6bfjV3+UU8cNLpw==
X-Received: by 2002:a05:7022:370f:b0:11b:998d:bded with SMTP id a92af1059eb24-121722eb8c4mr13882947c88.28.1766655949271;
        Thu, 25 Dec 2025 01:45:49 -0800 (PST)
Received: from [127.0.0.1] ([52.157.2.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de25dsm55371064c88.7.2025.12.25.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 01:45:48 -0800 (PST)
Message-Id: <pull.2138.v7.git.git.1766655947789.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Dec 2025 09:45:47 +0000
Subject: [PATCH v7] status: additional comparison with goal branch
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
builds upon, to show "ahead" (i.e. you have built new history,
while others are not touching it), "behind" (i.e. you haven't
added any work since you were in-sync, while others have added
their work on the branch), "diverged" (i.e. you have commits
that you haven't pushed out, while others have added commits).

When you fork a branch 'feature' from the 'main' branch of the
remote, but then create 'feature' branch at the remote and push
there, while you still occasionally pull from or rebase onto
their 'main', you'd also want to know how much you have diverged
from 'main', in addition to how your 'feature' and their
'feature' compares. Currently the comparison with 'main' is not
given, making it hard to know when to start thinking about
rebasing onto the upstream default branch.

Show two sets of comparison: one with the tracking branch (as
before), and another with the upstream's default branch (what
their HEAD points to, typically 'main' or 'master'). The latter
comparison appears on a separate line after the tracking branch
status, using the same format:
- "Ahead of 'origin/main' by N commits" when purely ahead
- "Behind 'origin/main' by N commits" when purely behind
- "Diverged from 'origin/main' by N commits" when diverged

Example output when tracking a feature branch:
    On branch feature
    Your branch is ahead of 'origin/feature' by 2 commits.
      (use "git push" to publish your local commits)

    Ahead of 'origin/main' by 5 commits.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    status: show default branch comparison when tracking non-default branch
    
    cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
    ychin.macvim@gmail.com cc: "brian m. carlson"
    sandals@crustytoothpaste.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v7
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v6:

 1:  a3800aed18 ! 1:  04e2fb76ee status: show comparison with upstream default branch
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    status: show comparison with upstream default branch
     +    status: additional comparison with goal branch
      
          "git status" on a branch that follows a remote branch compares
          commits on the current branch and the remote-tracking branch it
     @@ Commit message
      
              Ahead of 'origin/main' by 5 commits.
      
     -    The upstream default branch is determined by checking symbolic refs:
     -    1. refs/remotes/upstream/HEAD (if upstream remote exists)
     -    2. refs/remotes/origin/HEAD (fallback)
     -
     -    This works with any default branch name (main, master, develop,
     -    etc.) as long as the symbolic ref is configured. The comparison
     -    is also shown when the branch is up-to-date with its tracking
     -    branch but differs from the upstream default branch.
     -
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## remote.c ##
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
       
     -+static char *get_default_remote_ref(char **full_ref_out)
     ++static char *get_goal_branch_ref(char **full_ref_out)
      +{
     -+	int flag;
     ++	const char *config_value;
      +	const char *resolved;
     -+	static const char *remotes[] = { "upstream", "origin", NULL };
     -+	int i;
     -+
     -+	for (i = 0; remotes[i]; i++) {
     -+		struct strbuf head_ref = STRBUF_INIT;
     -+		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remotes[i]);
     -+
     -+		resolved = refs_resolve_ref_unsafe(
     -+			get_main_ref_store(the_repository),
     -+			head_ref.buf,
     -+			RESOLVE_REF_READING,
     -+			NULL, &flag);
     -+
     -+		strbuf_release(&head_ref);
     -+
     -+		if (resolved && (flag & REF_ISSYMREF)) {
     -+			if (full_ref_out)
     -+				*full_ref_out = xstrdup(resolved);
     -+			return refs_shorten_unambiguous_ref(
     -+				get_main_ref_store(the_repository), resolved, 0);
     -+		}
     -+	}
     ++	int flag;
     ++	struct strbuf ref_buf = STRBUF_INIT;
     ++	char *slash_pos;
     ++	char *ret = NULL;
      +
     -+	return NULL;
     -+}
     ++	if (repo_config_get_value(the_repository, "status.goalBranch", &config_value))
     ++		return NULL;
      +
     -+static int is_default_remote_branch(const char *name)
     -+{
     -+	char *default_full = NULL;
     -+	char *default_short;
     -+	int result = 0;
     ++	if (!config_value || !*config_value)
     ++		return NULL;
      +
     -+	default_short = get_default_remote_ref(&default_full);
     -+	if (!default_short)
     -+		return 0;
     ++	slash_pos = strchr(config_value, '/');
     ++	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
     ++		warning(_("invalid value for status.goalBranch: '%s' (expected format: remote/branch)"),
     ++			config_value);
     ++		return NULL;
     ++	}
      +
     -+	result = !strcmp(name, default_short);
     ++	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
     ++		    (int)(slash_pos - config_value), config_value,
     ++		    slash_pos + 1);
     ++
     ++	resolved = refs_resolve_ref_unsafe(
     ++		get_main_ref_store(the_repository),
     ++		ref_buf.buf,
     ++		RESOLVE_REF_READING,
     ++		NULL, &flag);
     ++
     ++	if (resolved) {
     ++		if (full_ref_out)
     ++			*full_ref_out = xstrdup(resolved);
     ++		ret = refs_shorten_unambiguous_ref(
     ++			get_main_ref_store(the_repository), resolved, 0);
     ++	}
      +
     -+	free(default_short);
     -+	free(default_full);
     -+	return result;
     ++	strbuf_release(&ref_buf);
     ++	return ret;
      +}
      +
     -+static void format_default_branch_comparison(struct strbuf *sb,
     ++static void format_goal_branch_comparison(struct strbuf *sb,
      +					     const char *branch_refname,
     ++					     const char *goal_full,
     ++					     const char *goal_short,
      +					     enum ahead_behind_flags abf)
      +{
     -+	int default_ours = 0, default_theirs = 0;
     -+	char *default_full = NULL;
     -+	char *default_short;
     -+
     -+	default_short = get_default_remote_ref(&default_full);
     -+	if (!default_short)
     -+		return;
     ++	int goal_ahead = 0, goal_behind = 0;
      +
     -+	if (stat_branch_pair(branch_refname, default_full,
     -+			     &default_ours, &default_theirs, abf) <= 0) {
     -+		free(default_short);
     -+		free(default_full);
     ++	if (stat_branch_pair(branch_refname, goal_full,
     ++			     &goal_ahead, &goal_behind, abf) <= 0)
      +		return;
     -+	}
      +
      +	strbuf_addstr(sb, "\n");
      +
     -+	if (default_ours > 0 && default_theirs == 0) {
     ++	if (goal_ahead > 0 && goal_behind == 0) {
      +		strbuf_addf(sb,
      +			Q_("Ahead of '%s' by %d commit.\n",
      +			   "Ahead of '%s' by %d commits.\n",
     -+			   default_ours),
     -+			default_short, default_ours);
     -+	} else if (default_theirs > 0 && default_ours == 0) {
     ++			   goal_ahead),
     ++			goal_short, goal_ahead);
     ++	} else if (goal_behind > 0 && goal_ahead == 0) {
      +		strbuf_addf(sb,
      +			Q_("Behind '%s' by %d commit.\n",
      +			   "Behind '%s' by %d commits.\n",
     -+			   default_theirs),
     -+			default_short, default_theirs);
     -+	} else if (default_ours > 0 && default_theirs > 0) {
     ++			   goal_behind),
     ++			goal_short, goal_behind);
     ++	} else if (goal_ahead > 0 && goal_behind > 0) {
      +		strbuf_addf(sb,
      +			Q_("Diverged from '%s' by %d commit.\n",
      +			   "Diverged from '%s' by %d commits.\n",
     -+			   default_ours + default_theirs),
     -+			default_short, default_ours + default_theirs);
     ++			   goal_ahead + goal_behind),
     ++			goal_short, goal_ahead + goal_behind);
      +	}
     -+
     -+	free(default_short);
     -+	free(default_full);
      +}
      +
       /*
        * Return true when there is anything to report, otherwise false.
        */
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 	const char *full_base;
     - 	char *base;
     - 	int upstream_is_gone = 0;
     -+	int show_default_branch_comparison;
     - 
     - 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     - 	if (sti < 0) {
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       
       	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
       					    full_base, 0);
     -+
     -+	show_default_branch_comparison = !is_default_remote_branch(base);
      +
       	if (upstream_is_gone) {
       		strbuf_addf(sb,
       			_("Your branch is based on '%s', but the upstream is gone.\n"),
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 		strbuf_addf(sb,
     - 			_("Your branch is up to date with '%s'.\n"),
     - 			base);
     -+		if (show_default_branch_comparison)
     -+			format_default_branch_comparison(sb, branch->refname, abf);
     - 	} else if (abf == AHEAD_BEHIND_QUICK) {
     - 		strbuf_addf(sb,
     - 			    _("Your branch and '%s' refer to different commits.\n"),
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 		if (advice_enabled(ADVICE_STATUS_HINTS))
     - 			strbuf_addstr(sb,
     - 				_("  (use \"git push\" to publish your local commits)\n"));
     -+		if (show_default_branch_comparison)
     -+			format_default_branch_comparison(sb, branch->refname, abf);
     - 	} else if (!ours) {
     - 		strbuf_addf(sb,
     - 			Q_("Your branch is behind '%s' by %d commit, "
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 		if (advice_enabled(ADVICE_STATUS_HINTS))
     - 			strbuf_addstr(sb,
     - 				_("  (use \"git pull\" to update your local branch)\n"));
     -+		if (show_default_branch_comparison)
     -+			format_default_branch_comparison(sb, branch->refname, abf);
     - 	} else {
     - 		strbuf_addf(sb,
     - 			Q_("Your branch and '%s' have diverged,\n"
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 		    advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
     -+		if (show_default_branch_comparison)
     -+			format_default_branch_comparison(sb, branch->refname, abf);
       	}
     ++
     ++	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
     ++		char *goal_full = NULL;
     ++		char *goal_short = get_goal_branch_ref(&goal_full);
     ++
     ++		if (goal_short && strcmp(base, goal_short))
     ++			format_goal_branch_comparison(sb, branch->refname, goal_full,
     ++						     goal_short, abf);
     ++
     ++		free(goal_short);
     ++		free(goal_full);
     ++	}
     ++
       	free(base);
       	return 1;
     + }
      
       ## t/t6040-tracking-info.sh ##
      @@ t/t6040-tracking-info.sh: test_expect_success setup '
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout work >/dev/null &&
     -+		git status --long -b | head -5
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch work
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +  (use "git push" to publish your local commits)
      +
      +Ahead of '\''origin/main'\'' by 3 commits.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout main >/dev/null &&
     -+		git checkout work 2>&1 | grep -E "(Switched|Your branch|Ahead of)" | head -3
     ++		git config status.goalBranch origin/main &&
     ++		git checkout work 2>&1
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +Switched to branch '\''work'\''
      +Your branch is ahead of '\''origin/feature'\'' by 2 commits.
     ++  (use "git push" to publish your local commits)
     ++
      +Ahead of '\''origin/main'\'' by 3 commits.
      +EOF
      +	test_cmp expect actual
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout work2 >/dev/null &&
     -+		git status --long -b | head -5
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch work2
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +  (use "git push" to publish your local commits)
      +
      +Diverged from '\''origin/main'\'' by 3 commits.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout work2b >/dev/null &&
     -+		git status --long -b | head -6
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch work2b
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +  (use "git pull" if you want to integrate the remote branch with yours)
      +
      +Behind '\''origin/main'\'' by 1 commit.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout work3 >/dev/null &&
     -+		git status --long -b | head -5
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch work3
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +  (use "git pull" to update your local branch)
      +
      +Ahead of '\''origin/main'\'' by 1 commit.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout work >/dev/null &&
     -+		git status --long -b | head -5
     ++		git config status.goalBranch upstream/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch work
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +  (use "git push" to publish your local commits)
      +
      +Diverged from '\''upstream/main'\'' by 5 commits.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout synced_feature >/dev/null &&
     -+		git status --long -b | head -4
     ++		git config status.goalBranch upstream/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch synced_feature
      +Your branch is up to date with '\''origin/feature'\''.
      +
      +Diverged from '\''upstream/main'\'' by 3 commits.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout synced_feature2 >/dev/null &&
     -+		git status --long -b | head -4
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch synced_feature2
      +Your branch is up to date with '\''origin/feature'\''.
      +
      +Diverged from '\''origin/main'\'' by 5 commits.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git checkout synced_feature3 >/dev/null &&
     -+		git status --long -b | head -4
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
     ++	) >actual &&
     ++	cat >expect <<-\EOF &&
     ++On branch synced_feature3
     ++Your branch is up to date with '\''origin/feature'\''.
     ++
     ++Diverged from '\''origin/main'\'' by 5 commits.
     ++
     ++nothing to commit, working tree clean
     ++EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status with status.goalBranch unset shows no default comparison' '
     ++	(
     ++		cd test &&
     ++		git checkout synced_feature3 >/dev/null &&
     ++		git config --unset status.goalBranch 2>/dev/null || true &&
     ++		git status --long -b
     ++	) >actual &&
     ++	cat >expect <<-\EOF &&
     ++On branch synced_feature3
     ++Your branch is up to date with '\''origin/feature'\''.
     ++
     ++nothing to commit, working tree clean
     ++EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status with status.goalBranch set uses configured branch' '
     ++	(
     ++		cd test &&
     ++		git checkout synced_feature3 >/dev/null &&
     ++		git config status.goalBranch origin/main &&
     ++		git status --long -b
      +	) >actual &&
      +	cat >expect <<-\EOF &&
      +On branch synced_feature3
      +Your branch is up to date with '\''origin/feature'\''.
      +
      +Diverged from '\''origin/main'\'' by 5 commits.
     ++
     ++nothing to commit, working tree clean
     ++EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status with status.goalBranch set to different remote/branch' '
     ++	(
     ++		cd test &&
     ++		git checkout work >/dev/null &&
     ++		git config status.goalBranch origin/feature &&
     ++		git status --long -b
     ++	) >actual &&
     ++	cat >expect <<-\EOF &&
     ++On branch work
     ++Your branch is ahead of '\''origin/feature'\'' by 2 commits.
     ++  (use "git push" to publish your local commits)
     ++
     ++nothing to commit, working tree clean
     ++EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status with status.goalBranch set to non-existent branch' '
     ++	(
     ++		cd test &&
     ++		git checkout synced_feature3 >/dev/null &&
     ++		git config status.goalBranch origin/nonexistent &&
     ++		git status --long -b
     ++	) >actual &&
     ++	cat >expect <<-\EOF &&
     ++On branch synced_feature3
     ++Your branch is up to date with '\''origin/feature'\''.
     ++
     ++nothing to commit, working tree clean
      +EOF
      +	test_cmp expect actual
      +'
 2:  417f2075fb < -:  ---------- Simplify default branch comparison logic
 3:  c9ec5d9610 < -:  ---------- Use repo.settings.statusGoalBranch config for status comparison
 4:  0e308141da < -:  ---------- Rename default_remote to goal_branch
 5:  441678939f < -:  ---------- Add warning for malformed statusGoalBranch config
 6:  242dbbae44 < -:  ---------- Change config key to status.compareBranch


 remote.c                 |  92 +++++++++++
 t/t6040-tracking-info.sh | 340 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 432 insertions(+)

diff --git a/remote.c b/remote.c
index 59b3715120..7e13c027b5 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,84 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_goal_branch_ref(char **full_ref_out)
+{
+	const char *config_value;
+	const char *resolved;
+	int flag;
+	struct strbuf ref_buf = STRBUF_INIT;
+	char *slash_pos;
+	char *ret = NULL;
+
+	if (repo_config_get_value(the_repository, "status.goalBranch", &config_value))
+		return NULL;
+
+	if (!config_value || !*config_value)
+		return NULL;
+
+	slash_pos = strchr(config_value, '/');
+	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
+		warning(_("invalid value for status.goalBranch: '%s' (expected format: remote/branch)"),
+			config_value);
+		return NULL;
+	}
+
+	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
+		    (int)(slash_pos - config_value), config_value,
+		    slash_pos + 1);
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		ref_buf.buf,
+		RESOLVE_REF_READING,
+		NULL, &flag);
+
+	if (resolved) {
+		if (full_ref_out)
+			*full_ref_out = xstrdup(resolved);
+		ret = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), resolved, 0);
+	}
+
+	strbuf_release(&ref_buf);
+	return ret;
+}
+
+static void format_goal_branch_comparison(struct strbuf *sb,
+					     const char *branch_refname,
+					     const char *goal_full,
+					     const char *goal_short,
+					     enum ahead_behind_flags abf)
+{
+	int goal_ahead = 0, goal_behind = 0;
+
+	if (stat_branch_pair(branch_refname, goal_full,
+			     &goal_ahead, &goal_behind, abf) <= 0)
+		return;
+
+	strbuf_addstr(sb, "\n");
+
+	if (goal_ahead > 0 && goal_behind == 0) {
+		strbuf_addf(sb,
+			Q_("Ahead of '%s' by %d commit.\n",
+			   "Ahead of '%s' by %d commits.\n",
+			   goal_ahead),
+			goal_short, goal_ahead);
+	} else if (goal_behind > 0 && goal_ahead == 0) {
+		strbuf_addf(sb,
+			Q_("Behind '%s' by %d commit.\n",
+			   "Behind '%s' by %d commits.\n",
+			   goal_behind),
+			goal_short, goal_behind);
+	} else if (goal_ahead > 0 && goal_behind > 0) {
+		strbuf_addf(sb,
+			Q_("Diverged from '%s' by %d commit.\n",
+			   "Diverged from '%s' by %d commits.\n",
+			   goal_ahead + goal_behind),
+			goal_short, goal_ahead + goal_behind);
+	}
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2258,6 +2336,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2311,6 +2390,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
+
+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
+		char *goal_full = NULL;
+		char *goal_short = get_goal_branch_ref(&goal_full);
+
+		if (goal_short && strcmp(base, goal_short))
+			format_goal_branch_comparison(sb, branch->refname, goal_full,
+						     goal_short, abf);
+
+		free(goal_short);
+		free(goal_full);
+	}
+
 	free(base);
 	return 1;
 }
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..fe34ddf0ab 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -21,6 +21,7 @@ test_expect_success setup '
 	git clone . test &&
 	(
 		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main &&
 		git checkout -b b1 origin &&
 		git reset --hard HEAD^ &&
 		advance d &&
@@ -292,4 +293,343 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for ahead of non-main tracking branch' '
+	(
+		cd test &&
+		git checkout -b feature origin/main &&
+		advance feature1 &&
+		git push origin feature &&
+		git checkout -b work --track origin/feature &&
+		advance work1 &&
+		advance work2
+	)
+'
+
+test_expect_success 'status shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Ahead of '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout main >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git checkout work 2>&1
+	) >actual &&
+	cat >expect <<-\EOF &&
+Switched to branch '\''work'\''
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Ahead of '\''origin/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 >/dev/null &&
+		git status --long -b
+	) >actual &&
+	test_grep "ahead of .origin/main. by 2 commits" actual &&
+	test_grep ! "Ahead of" actual
+'
+
+test_expect_success 'setup for ahead of tracked but diverged from main' '
+	(
+		cd test &&
+		git checkout origin/main &&
+		git checkout -b oldfeature &&
+		advance oldfeature1 &&
+		git push origin oldfeature &&
+		git checkout origin/main &&
+		advance main_newer &&
+		git push origin HEAD:main &&
+		git checkout -b work2 --track origin/oldfeature &&
+		advance work2_commit
+	)
+'
+
+test_expect_success 'status shows ahead of tracked and diverged from origin/main' '
+	(
+		cd test &&
+		git checkout work2 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2
+Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for diverged from tracked but behind main' '
+	(
+		cd test &&
+		git fetch origin &&
+		git checkout origin/main &&
+		git checkout -b work2b &&
+		git branch --set-upstream-to=origin/oldfeature &&
+		git checkout origin/main &&
+		advance main_extra &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows diverged from tracked and behind origin/main' '
+	(
+		cd test &&
+		git checkout work2b >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2b
+Your branch and '\''origin/oldfeature'\'' have diverged,
+and have 1 and 1 different commits each, respectively.
+  (use "git pull" if you want to integrate the remote branch with yours)
+
+Behind '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for behind tracked but ahead of main' '
+	(
+		cd test &&
+		git fetch origin &&
+		git checkout origin/main &&
+		git checkout -b feature3 &&
+		advance feature3_1 &&
+		advance feature3_2 &&
+		advance feature3_3 &&
+		git push origin feature3 &&
+		git checkout -b work3 --track origin/feature3 &&
+		git reset --hard HEAD~2
+	)
+'
+
+test_expect_success 'status shows behind tracked and ahead of origin/main' '
+	(
+		cd test &&
+		git checkout work3 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work3
+Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forwarded.
+  (use "git pull" to update your local branch)
+
+Ahead of '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream remote preference' '
+	(
+		cd test &&
+		git remote add upstream ../. &&
+		git fetch upstream &&
+		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/main
+	)
+'
+
+test_expect_success 'status prefers upstream remote over origin for comparison' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config status.goalBranch upstream/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''upstream/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but ahead of default' '
+	(
+		cd test &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature --track origin/feature &&
+		git checkout origin/main &&
+		advance main_ahead &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but diverged from default' '
+	(
+		cd test &&
+		git checkout synced_feature >/dev/null &&
+		git config status.goalBranch upstream/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''upstream/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but ahead of origin/main' '
+	(
+		cd test &&
+		git remote remove upstream &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature2 --track origin/feature &&
+		git checkout origin/main &&
+		advance main_ahead2 &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but diverged from origin/main' '
+	(
+		cd test &&
+		git checkout synced_feature2 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature2
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but purely ahead of origin/main' '
+	(
+		cd test &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature3 --track origin/feature
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but shows default branch comparison' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch unset shows no default comparison' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config --unset status.goalBranch 2>/dev/null || true &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch set uses configured branch' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch set to different remote/branch' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config status.goalBranch origin/feature &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch set to non-existent branch' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config status.goalBranch origin/nonexistent &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
