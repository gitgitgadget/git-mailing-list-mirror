Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2D286433
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928120; cv=none; b=DBcsTsteD0YaRGCNz3+iP+2hf3vWfaiL7mGzgKHUZ0NFTZYXLkYf+Bss60ZWHp2JGHnRATW6JUZQG8ROhnAKV9+FbuZBMyGgbw/lwVXl8wepAxN7uqKtM1JsrbCeLNf+p5OrVkr17ji4XlBfVhL5lG27Vd6lEvZlzqPbpLCaUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928120; c=relaxed/simple;
	bh=kr9epte1nWG/S5yiYfm/X0YL4q17Oe75i3bTWzcceBA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rRmiHJ0zhn6JYcBLo4wk7sjivnkisKPlQGhxS/Mcn0zluYXjk8Tabb7GLVIDdr5fwEzGG9cDh4ln7hYUTnFcQu1EW+x/EeD4Q8zKF4iqQj9gMAQQS2ZOtfCA0G0QRisiTknqODMciJsBfjVbXKBsaCCj8hFedl2eI8oHPGZy2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdCcSVUX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdCcSVUX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso1799750f8f.3
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928116; x=1753532916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9Dh1VTLaAZ01bqsvH7coplCqW21Enr+M5Ya5GsrGAQ=;
        b=VdCcSVUXpsiNogejl2ZaftvD93e9l5BG4Pkm8ephU7LQHvmQ5BsdNLO671aYh18UDr
         48iucRGYCxKs/W6ADyxvtJN2rSBxRogiBeaaVWPHchg53Qu2a4corji6aOwUHn8lDno7
         eLxrpp7s4dC/74RkBBpdlIWsmUwO7K22d0l5ULsGmaFH25YVqZqrkioXbEfUgEqjfo5d
         o+R8E4eo2bJr5rCgIVbjcyA5tUj9xZizcaT/5pwNz4bg02rxnwpoAaLBFtKl4kjO6a7r
         QIfTxn85RdoQTgsEUdoUWA4PPoIEQyJ6hP+OeLZdENHfhl98OQyobF6CoHpQOi7XiKfC
         i+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928116; x=1753532916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9Dh1VTLaAZ01bqsvH7coplCqW21Enr+M5Ya5GsrGAQ=;
        b=pkg1ulAVSCm3+AnB3OmAHmCj8cNjBgET3N9yJEF8cGQkASk+RtSS8q0RUCk5LdWI34
         MHHvIG14AhWgoksuPYL/kmVjpDCtPqP7nA1FEJoT8A6y5Ck7ZC2GNXvprHnlcaqbtwiF
         9IlCcstgcR9Nee+8bt6sT32PXZcF3xIS2aaUDHST3MzGzZ7PkNkIgazxgJxPeQYAZIBa
         0rLw6Zp2QGbnqgyOB5kgoVd6fs6FUcUv9LIOvawjFlf5wAI4KAzZOb+V5LjLJl5dr458
         E24fXiEyjLj8+bb81xHkxZsfpb7uaRqahjLXe0zqj6XuJL5oeQL3k//CdDg8Uxxf2EA1
         8Hwg==
X-Gm-Message-State: AOJu0YzQ1bmGfEFY0VoO23YLI/WQECIggYF+wzvrPIYJ8q5Td8Ybsy3f
	z/kMxMDwNmOv5pVIW8eoEs483BGaJhcb0OL6jZLN6XPUMcg2P8O1qTZdwP75Gg==
X-Gm-Gg: ASbGncslnUO1420KAaNZWfIfiYJsaVPHxDiXtXsF0Up9Zi41PKEH1sRtR1de3+4Xyxy
	tf46XiCEipSJdQxqOQQEMkf3nk5sMFpBYTJDIQfDDbpNS2Gj1//mCJPo2WKPURgeOSMWfLU1TNL
	8Nbn/yEhUA/S1ivZcETsKXFVfxJ6mVtk258t9k1eS/6pize7wuCywn3mq4nsp5q6qdKcONjcPQw
	lu8Bxoh5P9lEK3dJx3ruyzcEYT8dI+y0JnCFUGTRuPO9EVVyqew9XGoD3M9Vgf2ZMbL/UelYcm+
	gaZoPNbjyAtw0+ayiATItokvVUkZ9r3EeA5bKajs+e7DdEDKmVEtvQ3KkxhatoI3wcX4V2sKhef
	dwSMu6FJm62/YSraKk2lHO2o=
X-Google-Smtp-Source: AGHT+IFkHB0YeOR3AcocexuCrZb9cQUOvyn2sn4FI1kP2aUNnfD4Zyh7281yBIOrGST3KsW7w7b3yw==
X-Received: by 2002:a05:6000:2a0a:b0:3b6:18be:3fbc with SMTP id ffacd0b85a97d-3b618be3fe5mr4065840f8f.2.1752928115538;
        Sat, 19 Jul 2025 05:28:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2c013sm4638383f8f.33.2025.07.19.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:28:34 -0700 (PDT)
Message-Id: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Jul 2025 12:28:29 +0000
Subject: [PATCH v4 0/4] Better support for customising context lines in --patch commands
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

Changes since v3:

 * Update commit descriptions
 * Read struct properties directly instead of assigning to variables first
 * Simplify config setting / error checking
 * Remove redundant tests in later commit as they were replaced with better
   test(s)
 * Change tests to use single quotes (this messes with the grep so was
   unable to explicitly test single quotes in the error messages, so decided
   to use regex . instead, which is what some other tests that have this
   problem seem to use as well)

Leon Michalak (4):
  t: use test_grep in t3701 and t4055
  t: use test_config in t4055
  add-patch: respect diff.context configuration
  add-patch: add diff.context command line overrides

 Documentation/diff-context-options.adoc | 10 +++
 Documentation/git-add.adoc              |  2 +
 Documentation/git-checkout.adoc         |  2 +
 Documentation/git-commit.adoc           |  2 +
 Documentation/git-reset.adoc            |  2 +
 Documentation/git-restore.adoc          |  2 +
 Documentation/git-stash.adoc            |  2 +
 add-interactive.c                       | 45 ++++++++++--
 add-interactive.h                       | 17 ++++-
 add-patch.c                             | 14 ++--
 builtin/add.c                           | 21 +++++-
 builtin/checkout.c                      | 31 +++++++-
 builtin/commit.c                        | 16 +++-
 builtin/reset.c                         | 17 ++++-
 builtin/stash.c                         | 56 +++++++++++---
 commit.h                                |  3 +-
 parse-options.h                         |  2 +
 t/t3701-add-interactive.sh              | 97 +++++++++++++++++++------
 t/t4055-diff-context.sh                 | 72 ++++++++++++------
 t/t9902-completion.sh                   |  2 +
 20 files changed, 332 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/diff-context-options.adoc


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1915%2FNinjaInShade%2Finteractive-patch-context-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1915/NinjaInShade/interactive-patch-context-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1915

Range-diff vs v3:

 1:  044a93014b6 ! 1:  bbb2bc7082b test: use "test_grep"
     @@ Metadata
      Author: Leon Michalak <leonmichalak6@gmail.com>
      
       ## Commit message ##
     -    test: use "test_grep"
     +    t: use test_grep in t3701 and t4055
      
     -    Use the modern "test_grep" test utility instead of regular "grep" which
     -    provides better debug information if tests fail.
     -
     -    This is a prerequisite to the commits that follow which add to both test
     -    files.
     +    As a preparatory clean-up, use the "test_grep" test utility instead of
     +    regular "grep" which provides better debug information if tests fail.
      
          Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
      
 2:  e5c40d37750 ! 2:  feace2d3676 test: use "test_config"
     @@ Metadata
      Author: Leon Michalak <leonmichalak6@gmail.com>
      
       ## Commit message ##
     -    test: use "test_config"
     +    t: use test_config in t4055
      
          Use the modern "test_config" test utility instead of manual"git config"
          as the former provides clean up on test completion.
 3:  1ec8a138486 ! 3:  994029d6602 add-patch: respect diff.context configuration
     @@ Commit message
      
          Various builtins that use add-patch infrastructure do not respect
          the user's diff.context and diff.interHunkContext file configurations.
     -    This patch fixes this inconsistency.
      
     -    This is because the plumbing commands used by "git add -p" to generate
     -    the diff do not read those config settings. Fix this by reading the
     -    config before generating the patch and passing it along to the diff
     -    command with the "-U" and "--inter-hunk-context" command-line options.
     +    The user may be used to seeing their diffs with customized context size,
     +    but not in the patches "git add -p" shows them to pick from.
     +
     +    Teach add-patch infrastructure to read these configuration variables and
     +    pass their values when spawning the underlying plumbing commands as
     +    their command line option.
      
          Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
      
       ## add-interactive.c ##
     -@@ add-interactive.c: static void init_color(struct repository *r, struct add_i_state *s,
     - void init_add_i_state(struct add_i_state *s, struct repository *r)
     - {
     +@@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repository *r)
       	const char *value;
     -+	int context;
     -+	int interhunkcontext;
       
       	s->r = r;
      +	s->context = -1;
     @@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repositor
       	repo_config_get_string(r, "diff.algorithm",
       			       &s->interactive_diff_algorithm);
       
     -+	if (!repo_config_get_int(r, "diff.context", &context)) {
     -+		if (context < 0)
     ++	if (!repo_config_get_int(r, "diff.context", &s->context))
     ++		if (s->context < 0)
      +			die(_("%s cannot be negative"), "diff.context");
     -+		else
     -+			s->context = context;
     -+	}
     -+	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
     -+		if (interhunkcontext < 0)
     ++	if (!repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext))
     ++		if (s->interhunkcontext < 0)
      +			die(_("%s cannot be negative"), "diff.interHunkContext");
     -+		else
     -+			s->interhunkcontext = interhunkcontext;
     -+	}
      +
       	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
       	if (s->use_single_key)
     @@ add-interactive.h: struct add_i_state {
       void init_add_i_state(struct add_i_state *s, struct repository *r);
      
       ## add-patch.c ##
     -@@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
     +@@ add-patch.c: static int normalize_marker(const char *p)
     + static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
       {
       	struct strvec args = STRVEC_INIT;
     - 	const char *diff_algorithm = s->s.interactive_diff_algorithm;
     -+	int diff_context = s->s.context;
     -+	int diff_interhunkcontext = s->s.interhunkcontext;
     +-	const char *diff_algorithm = s->s.interactive_diff_algorithm;
       	struct strbuf *plain = &s->plain, *colored = NULL;
       	struct child_process cp = CHILD_PROCESS_INIT;
       	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
       	int res;
       
       	strvec_pushv(&args, s->mode->diff_cmd);
     -+	if (diff_context != -1)
     -+		strvec_pushf(&args, "--unified=%i", diff_context);
     -+	if (diff_interhunkcontext != -1)
     -+		strvec_pushf(&args, "--inter-hunk-context=%i", diff_interhunkcontext);
     - 	if (diff_algorithm)
     - 		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
     +-	if (diff_algorithm)
     +-		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
     ++	if (s->s.context != -1)
     ++		strvec_pushf(&args, "--unified=%i", s->s.context);
     ++	if (s->s.interhunkcontext != -1)
     ++		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.interhunkcontext);
     ++	if (s->s.interactive_diff_algorithm)
     ++		strvec_pushf(&args, "--diff-algorithm=%s", s->s.interactive_diff_algorithm);
       	if (s->revision) {
     + 		struct object_id oid;
     + 		strvec_push(&args,
      
       ## t/t3701-add-interactive.sh ##
      @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
 4:  b68c58b667c ! 4:  2774b930406 add-patch: add diff.context command line overrides
     @@ add-interactive.c: static void init_color(struct repository *r, struct add_i_sta
      +		      struct add_p_opt *add_p_opt)
       {
       	const char *value;
     - 	int context;
     + 
      @@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repository *r)
       	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
       	if (s->use_single_key)
     @@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *
       	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
      
       ## t/t3701-add-interactive.sh ##
     -@@ t/t3701-add-interactive.sh: test_expect_success 'add -p rejects negative diff.context' '
     - 	test_grep "diff.context cannot be negative" output
     +@@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
     + 	test_cmp expect actual
       '
       
     +-test_expect_success 'add -p respects diff.context' '
     +-	test_write_lines a b c d e f g h i j k l m >file &&
      +for cmd in add checkout restore 'commit -m file'
      +do
     -+	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" "
     ++	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" '
      +		test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
      +		git add file &&
      +		test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
      +		echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
      +			$cmd -p -U 4 --inter-hunk-context 2 >actual &&
     -+		test_grep \"@@ -2,20 +2,20 @@\" actual
     -+	"
     ++		test_grep "@@ -2,20 +2,20 @@" actual
     ++	'
      +done
      +
      +test_expect_success 'reset accepts -U and --inter-hunk-context' '
      +	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
      +	git commit -m file file &&
      +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
     -+	git add file &&
     + 	git add file &&
     +-	test_write_lines a b c d e f G h i j k l m >file &&
     +-	echo y | git -c diff.context=5 add -p >actual &&
     +-	test_grep "@@ -2,11 +2,11 @@" actual
      +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
      +		reset -p -U 4 --inter-hunk-context 2 >actual &&
      +	test_grep "@@ -2,20 +2,20 @@" actual
     -+'
     -+
     + '
     + 
     +-test_expect_success 'add -p respects diff.interHunkContext' '
     +-	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
     +-	git add file &&
     +-	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
     +-	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
     +-	test_grep "@@ -2,16 +2,16 @@" actual
      +test_expect_success 'stash accepts -U and --inter-hunk-context' '
      +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
      +	git commit -m file file &&
     @@ t/t3701-add-interactive.sh: test_expect_success 'add -p rejects negative diff.co
      +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
      +		stash -p -U 4 --inter-hunk-context 2 >actual &&
      +	test_grep "@@ -2,20 +2,20 @@" actual
     -+'
     -+
     -+for cmd in add checkout commit reset restore 'stash save' 'stash push'
     + '
     + 
     +-test_expect_success 'add -p rejects negative diff.context' '
     +-	test_config diff.context -1 &&
     +-	test_must_fail git add -p 2>output &&
     +-	test_grep "diff.context cannot be negative" output
     +-'
     ++for cmd in add checkout commit reset restore "stash save" "stash push"
      +do
     -+	test_expect_success "$cmd rejects invalid context options" "
     ++	test_expect_success "$cmd rejects invalid context options" '
      +		test_must_fail git $cmd -p -U -3 2>actual &&
      +		cat actual | echo &&
     -+		test_grep -e \"'--unified' cannot be negative\" actual &&
     ++		test_grep -e ".--unified. cannot be negative" actual &&
      +
      +		test_must_fail git $cmd -p --inter-hunk-context -3 2>actual &&
     -+		test_grep -e \"'--inter-hunk-context' cannot be negative\" actual &&
     ++		test_grep -e ".--inter-hunk-context. cannot be negative" actual &&
      +
      +		test_must_fail git $cmd -U 7 2>actual &&
     -+		test_grep -E \"'--unified' requires '(--interactive/)?--patch'\" actual &&
     ++		test_grep -E ".--unified. requires .(--interactive/)?--patch." actual &&
      +
      +		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
     -+		test_grep -E \"'--inter-hunk-context' requires '(--interactive/)?--patch'\" actual
     -+	"
     ++		test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
     ++	'
      +done
     -+
     + 
       test_done
      
       ## t/t4055-diff-context.sh ##

-- 
gitgitgadget
