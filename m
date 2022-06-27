Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E89DC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiF0Sgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiF0Sg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3456913D4B
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so1245939wmb.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JeNucSDPM/n+yy/58/nXZi6Fg8Dmb+beewChopzKUsQ=;
        b=nKQ+1R+gM5rre6kn843l2IQpcbCJDYGJOiaMyiysG0aEFkCMLiCwl2ize8AEYHUDFv
         OPCIivz8UwCKSQKJBS/XjyWxbHQYqMPH/UTRY08OXDLiK53+GiFmQ6O+8pH0Sx2d7Bcn
         WNKV6tYeaO3GmOnCIut19Fduh0rUxEwf3wrE3mLNKIU41ilTbx4If1LZhgTWTzr27Vfz
         ZGVi3B1DSg17mctufZiXpQkNAzV1o3ks9cs0aEV+Y7QlP3cfZdI2ChIQHh61HDpzVHj8
         JQJS/1HiTaNCDdp7tFwdK6OgatT4rZPfkHQLIsCnp9xXLeOxfT/06YFpe6cinCZP+KMl
         RCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JeNucSDPM/n+yy/58/nXZi6Fg8Dmb+beewChopzKUsQ=;
        b=mb6p2zOvWjHUj8sk6pqRG6rmOIR02Yk6JovRCxSQEtnA81w6T+TLqid3XbmR7XyXZ/
         j62JT3ANoSnit0F0ILowIBX/BcuvsYMweScl8Dn8vXIvjKvd9/Cb0OIZdtu3zrk1db7h
         2Inezz8Fj+xNpiW8qAoRxQYi6WL+V2ho4hRuyYtnfSyx5MThUBid6/gUs2K1INtRvvW8
         KBtjdJxIY9WVHhULJ2+2eq/fujqBqx7B59+QQnqp7s96uW/R2gAQgVueq19TyujWUTAm
         nDZ1PeEgb2C3xRqr+VpV10AACAqkX5quJ+1/ugqx+6WahdtfO+ZM58jqhV+YIRxg1MSt
         zPMQ==
X-Gm-Message-State: AJIora//kcCroHks3wUBl7cmY6yEsqJaP9l65l5udHIPJJX4ZFdXWfWa
        kToWdJe3CLW/LdMZH4NSthuW56yPjBG4DA==
X-Google-Smtp-Source: AGRyM1tHsN0VzJKKKoXeaP3BwzlyCkXv+ZfiRwzeOg3mRJ+1B2a7yojG3H4Y5am3SY7nAG5jP89pjg==
X-Received: by 2002:a7b:cb82:0:b0:39e:f9cf:12b7 with SMTP id m2-20020a7bcb82000000b0039ef9cf12b7mr22212983wmi.135.1656354679246;
        Mon, 27 Jun 2022 11:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b0039c693a54ecsm16829155wmj.23.2022.06.27.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:18 -0700 (PDT)
Message-Id: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:01 +0000
Subject: [PATCH v4 00/16] Finish converting git bisect into a built-in
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After three GSoC/Outreachy students spent an incredible effort on this, it
is finally time to put a neat little bow on it.

Changes since v3:

 * Rebased because of merge conflicts with ab/plug-leak-in-revisions.
 * Fixed the bug that git bisect --bisect-terms 1 2 wanted to auto-start a
   bisection if running with a git executable built at the in-between state
   at patch "bisect: move even the command-line parsing to bisect--helper".
   Since this bug was "fixed" in v3 by the very next patch, "bisect: teach
   the bisect--helper command to show the correct usage strings", v4 avoids
   introducing this bug simply by letting these two patches trade places.
   The range-diff admittedly looks quite awful because both patches overlap
   quite a bit in the lines they modify. The end result is the same, though,
   the diff between v3's and v4's builtin/bisect.c would be empty if I
   hadn't been forced to rebase.
 * Added a test case to ensure that this bug won't be introduced again. This
   test case is the only actual difference relative to v3 of this patch
   series.

Changes since v2:

 * We're now careful to provide identical usage strings upon git bisect -h
   and git bisect bogus.
 * When a bogus command is provided, we now error out instead of trying to
   start a git bisect run.
 * Rebased onto main to avoid plenty of merge conflicts with
   rs/bisect-executable-not-found, ac/usage-string-fixups and with
   cd/bisect-messages-from-pre-flight-states.

Changes since v1:

 * Added a regression test to "bisect run: fix the error message".
 * Added a patch to address an error message that double-single-quoted the
   command.
 * Reworked the logic in "bisect--helper: make --bisect-state optional" to
   delay showing the usage upon an unknown command, which should make the
   code a lot less confusing.
 * Split out the change that moved the BISECT_STATE case to the end of the
   switch block.
 * Added a patch that replaces the return error() calls in
   cmd_bisect_helper() with die() calls, to avoid returning -1 as an exit
   code.
 * Dropped the use of parse_options() for the single purpose of handling -h;
   This is now done explicitly.
 * Simplified the diff of "bisect: move even the option parsing to
   bisect--helper" by modifying argc and argv instead of modifying all the
   function calls using those variables.
 * In the "Turn git bisect into a full built-in" patch, changed the name of
   the variable holding the usage to use the builtin_ prefix used in other
   built-ins, too.
 * Removed the trailing dot from the commit message of "Turn git bisect into
   a full built-in".

Johannes Schindelin (16):
  bisect: verify that a bogus option won't try to start a bisection
  bisect run: fix the error message
  bisect: avoid double-quoting when printing the failed command
  bisect--helper: retire the --no-log option
  bisect--helper: really retire --bisect-next-check
  bisect--helper: really retire `--bisect-autostart`
  bisect--helper: using `--bisect-state` without an argument is a bug
  bisect--helper: align the sub-command order with git-bisect.sh
  bisect--helper: make `--bisect-state` optional
  bisect--helper: move the `BISECT_STATE` case to the end
  bisect--helper: return only correct exit codes in `cmd_*()`
  bisect: teach the `bisect--helper` command to show the correct usage
    strings
  bisect: move even the command-line parsing to `bisect--helper`
  Turn `git bisect` into a full built-in
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

 Makefile                               |   3 +-
 bisect.c                               |   3 -
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 202 +++++++++++--------------
 git-bisect.sh                          |  84 ----------
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            |  21 ++-
 7 files changed, 110 insertions(+), 207 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (89%)
 delete mode 100755 git-bisect.sh


base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2Fdscho%2Fbisect-in-c-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho/bisect-in-c-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1132

Range-diff vs v3:

  -:  ----------- >  1:  30ddbd7affc bisect: verify that a bogus option won't try to start a bisection
  1:  cf6034625dd =  2:  97dd2da8f89 bisect run: fix the error message
  2:  955ccd4d8c8 =  3:  5571e0f76ff bisect: avoid double-quoting when printing the failed command
  3:  abcbc25966c =  4:  5bfaf0334c3 bisect--helper: retire the --no-log option
  4:  af60ef1b5a4 =  5:  e85f236304b bisect--helper: really retire --bisect-next-check
  5:  07a92c58f8e =  6:  b94b7bb4fd0 bisect--helper: really retire `--bisect-autostart`
  6:  04ba0950b85 =  7:  aad3c9a0850 bisect--helper: using `--bisect-state` without an argument is a bug
  7:  6847af9d485 =  8:  375a46dca9f bisect--helper: align the sub-command order with git-bisect.sh
  8:  b7bc53b9cb6 =  9:  c57f63f6a61 bisect--helper: make `--bisect-state` optional
  9:  1919237a819 = 10:  87f53469a72 bisect--helper: move the `BISECT_STATE` case to the end
 10:  1236a731903 = 11:  ce508583e45 bisect--helper: return only correct exit codes in `cmd_*()`
 12:  ac472aefb6a ! 12:  5dbe233e4ec bisect: teach the `bisect--helper` command to show the correct usage strings
     @@ Commit message
          `bisect` command, we hereby teach it to print the very same usage
          strings as the scripted `git-bisect.sh` does.
      
     -    With this patch, the `bisect--helper` command is able to do everything
     -    that the `git-bisect.sh` script could, leaving as last step only to
     -    retire that script at long last, which we will do in the next commit.
     -
     -    Note: Since we cannot use the `parse-options` API to handle the
     -    subcommands of `git bisect` anyway, we no longer use it even just to
     -    show the usage string anymore, either.
     -
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      -	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
      -	"git bisect--helper --bisect-visualize",
      -	N_("git bisect--helper --bisect-run <cmd>..."),
     --	NULL
     --};
      +static const char *bisect_usage =
      +	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
      +	   "visualize|view|replay|log|run]");
      +
     -+static const char *bisect_long_usage =
     ++static const char * const bisect_long_usage[] = {
      +	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
      +	   "visualize|view|replay|log|run]\n"
      +	   "\n"
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      +	   "git bisect run <cmd>...\n"
      +	   "\tuse <cmd>... to automatically bisect.\n"
      +	   "\n"
     -+	   "Please use \"git help bisect\" to get the full man page.");
     ++	   "Please use \"git help bisect\" to get the full man page."),
     + 	NULL
     + };
       
     - struct add_bisect_ref_data {
     - 	struct rev_info *revs;
     -@@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     - int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - {
     - 	int res = 0;
     --	struct option options[] = {
     --		OPT_END()
     --	};
     +@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
       	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
     - 	const char *command = argc > 1 ? argv[1] : "help";
       
     - 	if (!strcmp("-h", command) || !strcmp("help", command))
     --		usage_with_options(git_bisect_helper_usage, options);
     -+		usage(bisect_long_usage);
     + 	argc = parse_options(argc, argv, prefix, options,
     +-			     git_bisect_helper_usage,
     ++			     bisect_long_usage,
     + 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
       
     - 	argc -= 2;
     - 	argv += 2;
     + 	switch (cmdmode ? cmdmode : BISECT_STATE) {
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - 		get_terms(&terms);
       		res = bisect_run(&terms, argv, argc);
     - 	} else {
     -+		if (!file_is_not_empty(git_path_bisect_start()) &&
     -+		    !one_of(command, "bad", "good", "new", "old", NULL))
     + 		break;
     + 	case BISECT_STATE:
     ++		if (argc &&
     ++		    !file_is_not_empty(git_path_bisect_start()) &&
     ++		    !one_of(argv[0], "bad", "good", "new", "old", NULL))
      +			usage(bisect_usage);
       		set_terms(&terms, "bad", "good");
       		get_terms(&terms);
     --		if (check_and_set_terms(&terms, command)) {
     --			char *msg = xstrfmt(_("unknown command: '%s'"), command);
     + 		if (!cmdmode &&
     +-		    (!argc || check_and_set_terms(&terms, argv[0]))) {
     +-			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
      -			usage_msg_opt(msg, git_bisect_helper_usage, options);
      -		}
     -+		if (check_and_set_terms(&terms, command))
     ++		    (!argc || check_and_set_terms(&terms, argv[0])))
      +			usage(bisect_usage);
     - 		/* shift the `command` back in */
     - 		argc++;
     - 		argv--;
     + 		res = bisect_state(&terms, argv, argc);
     + 		break;
     + 	default:
 11:  4ae78d37d04 ! 13:  d56f2a14060 bisect: move even the command-line parsing to `bisect--helper`
     @@ Commit message
          bisect: move even the command-line parsing to `bisect--helper`
      
          On our journey to a fully built-in `git bisect`, this is the
     -    one of the last steps.
     +    last step.
      
          Side note: The `parse-options` API is not at all set up to parse
          subcommands such as `git bisect start`, `git bisect reset`, etc.
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     +@@ builtin/bisect--helper.c: static const char *bisect_usage =
     + 	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
     + 	   "visualize|view|replay|log|run]");
     + 
     +-static const char * const bisect_long_usage[] = {
     ++static const char *bisect_long_usage =
     + 	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
     + 	   "visualize|view|replay|log|run]\n"
     + 	   "\n"
     +@@ builtin/bisect--helper.c: static const char * const bisect_long_usage[] = {
     + 	   "git bisect run <cmd>...\n"
     + 	   "\tuse <cmd>... to automatically bisect.\n"
     + 	   "\n"
     +-	   "Please use \"git help bisect\" to get the full man page."),
     +-	NULL
     +-};
     ++	   "Please use \"git help bisect\" to get the full man page.");
     + 
     + struct add_bisect_ref_data {
     + 	struct rev_info *revs;
      @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
       
       int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      -		BISECT_RUN,
      -	} cmdmode = 0;
       	int res = 0;
     - 	struct option options[] = {
     +-	struct option options[] = {
      -		OPT_CMDMODE(0, "bisect-start", &cmdmode,
      -			 N_("start the bisect session"), BISECT_START),
      -		OPT_CMDMODE(0, "bisect-state", &cmdmode,
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      -			 N_("list the bisection steps so far"), BISECT_LOG),
      -		OPT_CMDMODE(0, "bisect-run", &cmdmode,
      -			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
     - 		OPT_END()
     - 	};
     +-		OPT_END()
     +-	};
       	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
      +	const char *command = argc > 1 ? argv[1] : "help";
     ++
     ++	if (!strcmp("-h", command) || !strcmp("help", command))
     ++		usage(bisect_long_usage);
       
      -	argc = parse_options(argc, argv, prefix, options,
     --			     git_bisect_helper_usage,
     +-			     bisect_long_usage,
      -			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
     -+	if (!strcmp("-h", command) || !strcmp("help", command))
     -+		usage_with_options(git_bisect_helper_usage, options);
     ++	argc -= 2;
     ++	argv += 2;
       
      -	switch (cmdmode ? cmdmode : BISECT_STATE) {
      -	case BISECT_START:
     -+	argc -= 2;
     -+	argv += 2;
     -+
      +	if (!strcmp("start", command)) {
       		set_terms(&terms, "bad", "good");
       		res = bisect_start(&terms, argv, argc);
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
       		res = bisect_run(&terms, argv, argc);
      -		break;
      -	case BISECT_STATE:
     +-		if (argc &&
     +-		    !file_is_not_empty(git_path_bisect_start()) &&
     +-		    !one_of(argv[0], "bad", "good", "new", "old", NULL))
      +	} else {
     ++		if (!file_is_not_empty(git_path_bisect_start()) &&
     ++		    !one_of(command, "bad", "good", "new", "old", NULL))
     + 			usage(bisect_usage);
       		set_terms(&terms, "bad", "good");
       		get_terms(&terms);
      -		if (!cmdmode &&
     --		    (!argc || check_and_set_terms(&terms, argv[0]))) {
     --			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
     -+		if (check_and_set_terms(&terms, command)) {
     -+			char *msg = xstrfmt(_("unknown command: '%s'"), command);
     - 			usage_msg_opt(msg, git_bisect_helper_usage, options);
     - 		}
     +-		    (!argc || check_and_set_terms(&terms, argv[0])))
     ++		if (check_and_set_terms(&terms, command))
     + 			usage(bisect_usage);
      +		/* shift the `command` back in */
      +		argc++;
      +		argv--;
 13:  85f5c256ae3 = 14:  378d6d22737 Turn `git bisect` into a full built-in
 14:  289917e96af = 15:  33566b86d77 bisect: remove Cogito-related code
 15:  8f8d2ba0fe4 = 16:  334664f23a8 bisect: no longer try to clean up left-over `.git/head-name` files

-- 
gitgitgadget
