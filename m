Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3A2BAF9
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128493; cv=none; b=LIV3YeYZj51qdibZv93kxqNSHb8NyUHjRMTuyx7V/sB0S88gmuts3e1pGH6nGiC+iJGCMs8ZoeL/r7gI8zff7WbLmzQ6VYLxM1NouhWAVl4/LiCb2qNtzDtoE4ut0Kr1mwrTziPx3p4gctEprJg4BmoOl7E5mRq5M3zrHe7p3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128493; c=relaxed/simple;
	bh=drMqlpE9RXX0LaOQgiM6+HnFR1JqLX7D0MRgiYfusJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JcYzaklrRwW9S6QE6BU9w760vtDELnQbpj/yINcqFc1YM4a5Fbc0Ttwmh7JqwVa84oHZi1p6Kh2gv35y4V+xmgTH9WqZL2OaFlrgyRlStotLPZRkQLp79lYmkKJ8BkfXdJ63mN165UgWsV5oVjH5+c76kRX5MdpR742d+DqtaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvB9rhCd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvB9rhCd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso19106355e9.2
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751128489; x=1751733289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbL2O/K5y+IuXmfbsrB18h3fHo2oUimkydCqAvW8Pgo=;
        b=YvB9rhCdZDbQ8DmOYvf/w5asTz/OK2ZBR3oOZo7dd26aI4nraXjiEiSCcMgada6z/E
         skhkhHtc/1xAjkRQBImYCGKQRgD1PF5eXcUgODWrkkmp4mkEi/cYB3z0vh3yO8GWIaOg
         9pSIWCTETDIAg3mFlWF8NPCZCahm8ciT4IOitydJqA2NxmxoA2yBEb4wmjLguezyxTtv
         GcJ6GXVvaSQaL7sSbFtrfWvkh556r7ORTNexFI3QLfYeC86Qp3pCRAizsQOUygyKPOIE
         929GTDQ8NdjlnaUnW2LDUGAMv/pFx75+jNjY7EDm3agtJOfKwJQ1CqX5f2YavkI0yofe
         EWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751128489; x=1751733289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbL2O/K5y+IuXmfbsrB18h3fHo2oUimkydCqAvW8Pgo=;
        b=GF6U8A68gLcph193idT2s3iKA6b4U6HXL9T67Qm7DxZs9Eq8gcnr0XIWD2HONVrk+q
         8QZBRIaV7z3LQoEzrA7Nmyrtcn2Xc+uuTKMlYOwUto/5+VI6K/q+AX0JMmjnhaDng43S
         N9F5p8AY5ySD4qbdBGfz5kxpotRbJ2VbDTIua4jtCxxogR2+MW2pAF5MATKcmlwOtkyB
         8z8TY1K7B5oWVH1cDIuvhWhMYNMQGi9pmYeMPN8qu9BHlUM2fnXs9rXGvQ4etns5GcuW
         95zXqh5bGfcA3mYVydtUHo7F63h+MwJwt789nzVXC5UvM9iilKdQTjdR3ysPN04qjqrN
         LGNg==
X-Gm-Message-State: AOJu0YzoNfsMhfndT97sZFZj5SLImmfWnm8PO0e1SzUEMM4edxQ/VE5o
	PmMCJ6S9JmhfF0800dKYIgA0xhSfzTJar3ELaYkFebvE74PxcYlUDoe+4fJTRA==
X-Gm-Gg: ASbGncs9hT0Qw26fQ0YOSZcRdvGDpnM7ggtnUsDnIFhvAVOerJGvsmdwcs3r42BZ/9a
	BSfxHizmD0ZW17EBfMfEp86FlngcE3GORTRH887OUW+jjBi8ulRaCg+4KX+fRTk7QT4HXoyC0w8
	UViO74p14i5JYJrudMOl8qhK/BDH8S674kNLg9ajuTuYmgOOYAxKk3UiPhrzYjlT4Zw+5TNoaBq
	H1Uz0m0cHt8PpAFec/rO2LdaH7lyxBbsYfogjEAmoM/QDKaI7EwmwgtJKjMJCgfaHfPyio9V8YJ
	ekURu966dsLKFu3ELmf/X+7SQYzYL9XaQk7rI9LBrFhgUbXJzX7cAOO+Wvs05Lk=
X-Google-Smtp-Source: AGHT+IH4P3KJP2u/2pLBSttVyaUWV/ELKZByKdj65b0yTL9ZtKLXqCze8eNLR0L09ag6JC7iWuKxug==
X-Received: by 2002:a05:600c:c172:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-4538ee3458amr96030525e9.10.1751128489162;
        Sat, 28 Jun 2025 09:34:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6fa2sm114104975e9.27.2025.06.28.09.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:34:48 -0700 (PDT)
Message-Id: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Jun 2025 16:34:42 +0000
Subject: [PATCH v3 0/4] Better support for customising context lines in --patch commands
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

This series of patches attempt to give --interactive/--patch compatible
builtins ("add", "commit", "checkout", "reset", "restore" and "stash")
better support and nicer experience for configuring how many context lines
are shown in diffs through a variety of ways.

Prior to these patches, the user could not choose how many context lines
they saw in --patch commands (apart from one workaround by using
GIT_DIFF_OPTS=-u<number> ..., however this isn't a good user experience or a
persistent solution). Additionally, the behaviour around reading from the
diff.context and diff.interHunkContext configs was also inconsistent with
other diff generating commands such as "log -p".

The summarised changes below hopefully make this experience better and fix
some inconsistencies:

 * diff.context and diff.interHunkContext configs are now respected by
   --patch compatible commands
 * --unified and --inter-hunk-context command line options have been added
   to --patch compatible commands (which take prescendence over file
   configs)
 * "add" and "commit" in --interactive mode now expose a new "context"
   subcommand which configures the amount of context lines you wish to see
   in subsequent diffs generated from other subcommands such as "patch" or
   "diff"

The original discussion for this can be read at:

 * https://lore.kernel.org/git/CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com/

Changes since v1:

 * Update commit descriptions
 * Update tests to use the more modern and robust test_grep and test_config
   utils
 * Reword some documentation / user messages
 * Ensure each commit is atomic and builds/passes tests on it's own
 * Make new command line options DRY
 * Add tests for interhunk context interaction
 * Error if context config/command line options are negative
 * Drop previous last commit to do with new subcommand for --interactive
   add/commit. My motivations behind this patch series originally where
   quite simple, just for add-patch commands to respect context configs.
   This subcommand, after the discussion in v1, will require more thought
   and a larger implementation that what I had anticipated. I would prefer
   to leave this for another time as it's the least impactful but the most
   time intensive and complicated idea.

Changes since v2:

 * Update tests to only test single command (following Philip's suggestion)
 * Add negative option checks
 * Minor commit re-wording

Leon Michalak (4):
  test: use "test_grep"
  test: use "test_config"
  add-patch: respect diff.context configuration
  add-patch: add diff.context command line overrides

 Documentation/diff-context-options.adoc |  10 ++
 Documentation/git-add.adoc              |   2 +
 Documentation/git-checkout.adoc         |   2 +
 Documentation/git-commit.adoc           |   2 +
 Documentation/git-reset.adoc            |   2 +
 Documentation/git-restore.adoc          |   2 +
 Documentation/git-stash.adoc            |   2 +
 add-interactive.c                       |  53 +++++++++--
 add-interactive.h                       |  17 +++-
 add-patch.c                             |  11 ++-
 builtin/add.c                           |  21 ++++-
 builtin/checkout.c                      |  31 +++++-
 builtin/commit.c                        |  16 +++-
 builtin/reset.c                         |  17 +++-
 builtin/stash.c                         |  56 ++++++++---
 commit.h                                |   3 +-
 parse-options.h                         |   2 +
 t/t3701-add-interactive.sh              | 119 +++++++++++++++++++-----
 t/t4055-diff-context.sh                 |  72 +++++++++-----
 t/t9902-completion.sh                   |   2 +
 20 files changed, 362 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/diff-context-options.adoc


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1915%2FNinjaInShade%2Finteractive-patch-context-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1915/NinjaInShade/interactive-patch-context-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1915

Range-diff vs v2:

 1:  4f92a1b4c24 ! 1:  044a93014b6 test: refactor to use "test_grep"
     @@ Metadata
      Author: Leon Michalak <leonmichalak6@gmail.com>
      
       ## Commit message ##
     -    test: refactor to use "test_grep"
     +    test: use "test_grep"
      
     -    Refactor to use the modern "test_grep" test utility instead of regular
     -    "grep" which provides better debug information if tests fail.
     +    Use the modern "test_grep" test utility instead of regular "grep" which
     +    provides better debug information if tests fail.
      
          This is a prerequisite to the commits that follow which add to both test
          files.
 2:  75424cb8e1c ! 2:  e5c40d37750 test: refactor to use "test_config"
     @@ Metadata
      Author: Leon Michalak <leonmichalak6@gmail.com>
      
       ## Commit message ##
     -    test: refactor to use "test_config"
     +    test: use "test_config"
      
     -    Refactor to use the modern "test_config" test utility instead of manual
     -    "git config" as the former provides clean up on test completion.
     +    Use the modern "test_config" test utility instead of manual"git config"
     +    as the former provides clean up on test completion.
      
          This is a prerequisite to the commits that follow which add to this test
          file.
 3:  f16d3de8611 ! 3:  1ec8a138486 add-patch: respect diff.context configuration
     @@ Commit message
          the user's diff.context and diff.interHunkContext file configurations.
          This patch fixes this inconsistency.
      
     +    This is because the plumbing commands used by "git add -p" to generate
     +    the diff do not read those config settings. Fix this by reading the
     +    config before generating the patch and passing it along to the diff
     +    command with the "-U" and "--inter-hunk-context" command-line options.
     +
          Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
      
       ## add-interactive.c ##
     @@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repositor
      +			die(_("%s cannot be negative"), "diff.context");
      +		else
      +			s->context = context;
     -+	};
     ++	}
      +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
      +		if (interhunkcontext < 0)
      +			die(_("%s cannot be negative"), "diff.interHunkContext");
      +		else
      +			s->interhunkcontext = interhunkcontext;
     -+	};
     ++	}
      +
       	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
       	if (s->use_single_key)
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
       		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
       	if (s->revision) {
      
     - ## t/t4055-diff-context.sh ##
     -@@ t/t4055-diff-context.sh: test_expect_success 'diff.context honored by "log"' '
     - 	test_grep "^ firstline" output
     + ## t/t3701-add-interactive.sh ##
     +@@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
     + 	test_cmp expect actual
       '
       
     -+test_expect_success 'diff.context honored by "add"' '
     -+	git add -p >output &&
     -+	test_grep ! firstline output &&
     -+	test_config diff.context 8 &&
     -+	git log -1 -p >output &&
     -+	test_grep "^ firstline" output
     -+'
     -+
     -+test_expect_success 'diff.context honored by "commit"' '
     -+	! git commit -p >output &&
     -+	test_grep ! firstline output &&
     -+	test_config diff.context 8 &&
     -+	! git commit -p >output &&
     -+	test_grep "^ firstline" output
     -+'
     -+
     -+test_expect_success 'diff.context honored by "checkout"' '
     -+	git checkout -p >output &&
     -+	test_grep ! firstline output &&
     -+	test_config diff.context 8 &&
     -+	git checkout -p >output &&
     -+	test_grep "^ firstline" output
     -+'
     -+
     -+test_expect_success 'diff.context honored by "stash"' '
     -+	! git stash -p >output &&
     -+	test_grep ! firstline output &&
     -+	test_config diff.context 8 &&
     -+	! git stash -p >output &&
     -+	test_grep "^ firstline" output
     ++test_expect_success 'add -p respects diff.context' '
     ++	test_write_lines a b c d e f g h i j k l m >file &&
     ++	git add file &&
     ++	test_write_lines a b c d e f G h i j k l m >file &&
     ++	echo y | git -c diff.context=5 add -p >actual &&
     ++	test_grep "@@ -2,11 +2,11 @@" actual
      +'
      +
     -+test_expect_success 'diff.context honored by "restore"' '
     -+	git restore -p >output &&
     -+	test_grep ! firstline output &&
     -+	test_config diff.context 8 &&
     -+	git restore -p >output &&
     -+	test_grep "^ firstline" output
     ++test_expect_success 'add -p respects diff.interHunkContext' '
     ++	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
     ++	git add file &&
     ++	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
     ++	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
     ++	test_grep "@@ -2,16 +2,16 @@" actual
      +'
      +
     - test_expect_success 'The -U option overrides diff.context' '
     - 	test_config diff.context 8 &&
     - 	git log -U4 -1 >output &&
     -@@ t/t4055-diff-context.sh: test_expect_success 'negative integer config parsing' '
     - 	test_grep "bad config variable" output
     - '
     - 
     -+test_expect_success 'negative integer config parsing by "add"' '
     ++test_expect_success 'add -p rejects negative diff.context' '
      +	test_config diff.context -1 &&
      +	test_must_fail git add -p 2>output &&
      +	test_grep "diff.context cannot be negative" output
      +'
      +
     -+test_expect_success 'negative integer config parsing by "commit"' '
     -+	test_config diff.context -1 &&
     -+	test_must_fail git commit -p 2>output &&
     -+	test_grep "bad config variable" output
     -+'
     -+
     -+test_expect_success 'negative integer config parsing by "checkout"' '
     -+	test_config diff.context -1 &&
     -+	test_must_fail git checkout -p 2>output &&
     -+	test_grep "diff.context cannot be negative" output
     -+'
     -+
     -+test_expect_success 'negative integer config parsing by "stash"' '
     -+	test_config diff.context -1 &&
     -+	test_must_fail git stash -p 2>output &&
     -+	test_grep "diff.context cannot be negative" output
     -+'
     -+
     -+test_expect_success 'negative integer config parsing by "restore"' '
     -+	test_config diff.context -1 &&
     -+	test_must_fail git restore -p 2>output &&
     -+	test_grep "diff.context cannot be negative" output
     -+'
     -+
     - test_expect_success '-U0 is valid, so is diff.context=0' '
     - 	test_config diff.context 0 &&
     - 	git diff >output &&
     + test_done
 4:  973dfadd1b3 ! 4:  b68c58b667c add-patch: add diff.context command line overrides
     @@ Documentation/git-checkout.adoc: section of linkgit:git-add[1] to learn how to o
       
      +include::diff-context-options.adoc[]
      +
     - --ignore-other-worktrees::
     + `--ignore-other-worktrees`::
       	`git checkout` refuses when the wanted branch is already checked
       	out or otherwise in use by another worktree. This option makes
      
     @@ builtin/add.c: static struct option builtin_add_options[] = {
       	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
       	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
       	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
     +@@ builtin/add.c: int cmd_add(int argc,
     + 	prepare_repo_settings(repo);
     + 	repo->settings.command_requires_full_index = 0;
     + 
     ++	if (add_p_opt.context < -1)
     ++		die(_("'%s' cannot be negative"), "--unified");
     ++	if (add_p_opt.interhunkcontext < -1)
     ++		die(_("'%s' cannot be negative"), "--inter-hunk-context");
     ++
     + 	if (patch_interactive)
     + 		add_interactive = 1;
     + 	if (add_interactive) {
      @@ builtin/add.c: int cmd_add(int argc,
       			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
       		if (pathspec_from_file)
     @@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
      -				   &opts->pathspec);
      +		return !!run_add_p(the_repository, patch_mode, &add_p_opt,
      +				   rev, &opts->pathspec);
     -+	} else {
     -+		if (opts->patch_context != -1)
     -+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
     -+		if (opts->patch_interhunk_context != -1)
     -+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
       	}
       
       	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
     @@ builtin/checkout.c: static struct option *add_checkout_path_options(struct check
       		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
       			 N_("do not limit pathspecs to sparse entries only")),
       		OPT_PATHSPEC_FROM_FILE(&opts->pathspec_from_file),
     +@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
     + 	argc = parse_options(argc, argv, prefix, options,
     + 			     usagestr, parseopt_flags);
     + 
     ++	if (opts->patch_context < -1)
     ++		die(_("'%s' cannot be negative"), "--unified");
     ++	if (opts->patch_interhunk_context < -1)
     ++		die(_("'%s' cannot be negative"), "--inter-hunk-context");
     ++
     ++	if (!opts->patch_mode) {
     ++		if (opts->patch_context != -1)
     ++			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
     ++		if (opts->patch_interhunk_context != -1)
     ++			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
     ++	}
     ++
     + 	if (opts->show_progress < 0) {
     + 		if (opts->quiet)
     + 			opts->show_progress = 0;
      
       ## builtin/commit.c ##
      @@
     @@ builtin/commit.c: static const char *edit_message, *use_message;
       static int edit_flag = -1; /* unspecified */
       static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
       static int config_commit_verbose = -1; /* unspecified */
     +@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
     + 	const char *ret;
     + 	char *path = NULL;
     + 
     ++	if (add_p_opt.context < -1)
     ++		die(_("'%s' cannot be negative"), "--unified");
     ++	if (add_p_opt.interhunkcontext < -1)
     ++		die(_("'%s' cannot be negative"), "--inter-hunk-context");
     ++
     + 	if (is_status)
     + 		refresh_flags |= REFRESH_UNMERGED;
     + 	parse_pathspec(&pathspec, 0,
      @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
       		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
       		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
     @@ builtin/reset.c: int cmd_reset(int argc,
       		OPT_BOOL('N', "intent-to-add", &intent_to_add,
       				N_("record only the fact that removed paths will be added later")),
       		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
     +@@ builtin/reset.c: int cmd_reset(int argc,
     + 		oidcpy(&oid, &tree->object.oid);
     + 	}
     + 
     ++	if (add_p_opt.context < -1)
     ++		die(_("'%s' cannot be negative"), "--unified");
     ++	if (add_p_opt.interhunkcontext < -1)
     ++		die(_("'%s' cannot be negative"), "--inter-hunk-context");
     ++
     + 	prepare_repo_settings(the_repository);
     + 	the_repository->settings.command_requires_full_index = 0;
     + 
      @@ builtin/reset.c: int cmd_reset(int argc,
       		if (reset_type != NONE)
       			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
      +		if (add_p_opt.interhunkcontext != -1)
      +			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
      +	}
     ++
     ++	if (add_p_opt.context < -1)
     ++		die(_("'%s' cannot be negative"), "--unified");
     ++	if (add_p_opt.interhunkcontext < -1)
     ++		die(_("'%s' cannot be negative"), "--inter-hunk-context");
      +
       	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
      -			    include_untracked, only_staged);
     @@ builtin/stash.c: static int save_stash(int argc, const char **argv, const char *
       
       	memset(&ps, 0, sizeof(ps));
      +
     ++	if (add_p_opt.context < -1)
     ++		die(_("'%s' cannot be negative"), "--unified");
     ++	if (add_p_opt.interhunkcontext < -1)
     ++		die(_("'%s' cannot be negative"), "--inter-hunk-context");
     ++
      +	if (!patch_mode) {
      +		if (add_p_opt.context != -1)
      +			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
     @@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *
       #define OPT_IPVERSION(v) \
       	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
      
     - ## t/t4032-diff-inter-hunk-context.sh ##
     -@@ t/t4032-diff-inter-hunk-context.sh: t() {
     - 	"
     - }
     + ## t/t3701-add-interactive.sh ##
     +@@ t/t3701-add-interactive.sh: test_expect_success 'add -p rejects negative diff.context' '
     + 	test_grep "diff.context cannot be negative" output
     + '
       
     -+t_patch() {
     -+	use_config=
     -+	git config --unset diff.interHunkContext
     -+
     -+	case $# in
     -+	4) hunks=$4; cmd="add -p -U$3";;
     -+	5) hunks=$5; cmd="add -p -U$3 --inter-hunk-context=$4";;
     -+	6) hunks=$5; cmd="add -p -U$3"; git config diff.interHunkContext $4; use_config="(diff.interHunkContext=$4) ";;
     -+	esac
     -+	label="$use_config$cmd, $1 common $2"
     -+	file=f$1
     -+
     -+	if ! test -f $file
     -+	then
     -+		f A $1 B >$file
     -+		git add $file
     -+		git commit -q -m. $file
     -+		f X $1 Y >$file
     -+	fi
     -+
     -+	test_expect_success "$label: count hunks ($hunks)" "
     -+		test $(test_write_lines q | git $cmd $file | sed -n 's/^([0-9]*\/\([0-9]*\)) Stage this hunk.*/\1/p') = $hunks
     ++for cmd in add checkout restore 'commit -m file'
     ++do
     ++	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" "
     ++		test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
     ++		git add file &&
     ++		test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
     ++		echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
     ++			$cmd -p -U 4 --inter-hunk-context 2 >actual &&
     ++		test_grep \"@@ -2,20 +2,20 @@\" actual
      +	"
     -+}
     ++done
     ++
     ++test_expect_success 'reset accepts -U and --inter-hunk-context' '
     ++	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
     ++	git commit -m file file &&
     ++	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
     ++	git add file &&
     ++	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
     ++		reset -p -U 4 --inter-hunk-context 2 >actual &&
     ++	test_grep "@@ -2,20 +2,20 @@" actual
     ++'
     ++
     ++test_expect_success 'stash accepts -U and --inter-hunk-context' '
     ++	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
     ++	git commit -m file file &&
     ++	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
     ++	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
     ++		stash -p -U 4 --inter-hunk-context 2 >actual &&
     ++	test_grep "@@ -2,20 +2,20 @@" actual
     ++'
     ++
     ++for cmd in add checkout commit reset restore 'stash save' 'stash push'
     ++do
     ++	test_expect_success "$cmd rejects invalid context options" "
     ++		test_must_fail git $cmd -p -U -3 2>actual &&
     ++		cat actual | echo &&
     ++		test_grep -e \"'--unified' cannot be negative\" actual &&
     ++
     ++		test_must_fail git $cmd -p --inter-hunk-context -3 2>actual &&
     ++		test_grep -e \"'--inter-hunk-context' cannot be negative\" actual &&
     ++
     ++		test_must_fail git $cmd -U 7 2>actual &&
     ++		test_grep -E \"'--unified' requires '(--interactive/)?--patch'\" actual &&
     ++
     ++		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
     ++		test_grep -E \"'--inter-hunk-context' requires '(--interactive/)?--patch'\" actual
     ++	"
     ++done
      +
     - cat <<EOF >expected.f1.0.1 || exit 1
     - diff --git a/f1 b/f1
     - --- a/f1
     -@@ t/t4032-diff-inter-hunk-context.sh: t 3 lines	1	2	1	config
     - t 9 lines	3	2	2	config
     - t 9 lines	3	3	1	config
     - 
     -+# common lines	ctx	intrctx	hunks
     -+t_patch 1 line	0		2
     -+t_patch 1 line	0	0	2
     -+t_patch 1 line	0	1	1
     -+t_patch 1 line	0	2	1
     -+t_patch 1 line	1		1
     -+
     -+t_patch 2 lines	0		2
     -+t_patch 2 lines	0	0	2
     -+t_patch 2 lines	0	1	2
     -+t_patch 2 lines	0	2	1
     -+t_patch 2 lines	1		1
     -+
     -+t_patch 3 lines	1		2
     -+t_patch 3 lines	1	0	2
     -+t_patch 3 lines	1	1	1
     -+t_patch 3 lines	1	2	1
     -+
     -+t_patch 9 lines	3		2
     -+t_patch 9 lines	3	2	2
     -+t_patch 9 lines	3	3	1
     -+
     -+#					use diff.interHunkContext?
     -+t_patch 1 line	0	0	2	config
     -+t_patch 1 line	0	1	1	config
     -+t_patch 1 line	0	2	1	config
     -+t_patch 9 lines	3	3	1	config
     -+t_patch 2 lines	0	0	2	config
     -+t_patch 2 lines	0	1	2	config
     -+t_patch 2 lines	0	2	1	config
     -+t_patch 3 lines	1	0	2	config
     -+t_patch 3 lines	1	1	1	config
     -+t_patch 3 lines	1	2	1	config
     -+t_patch 9 lines	3	2	2	config
     -+t_patch 9 lines	3	3	1	config
     -+
     - test_expect_success 'diff.interHunkContext invalid' '
     - 	git config diff.interHunkContext asdf &&
     - 	test_must_fail git diff &&
     + test_done
      
       ## t/t4055-diff-context.sh ##
      @@ t/t4055-diff-context.sh: test_expect_success 'The -U option overrides diff.context' '

-- 
gitgitgadget
