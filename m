Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9514C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355316AbiEUOtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiEUOtM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E46CA84
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so14953189wra.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OhjtlXOrT7vnyEM+ekn1+2lKSnkgyofRum2Mactso54=;
        b=jfuM7GGlggS/kychAPZGEOYpGpu4SQqdDwMTd8XbHVv82NGA9Vcvy9ZtpOMfd5ZEdR
         gp4JfU4vuqT13URf57MUyzJ71IFLd7iucPrOdEcMWxBjTRQ2q1vFgBkebgnN2EkgEHg/
         hLavXITZ+qu6T3HH9lUzzy2DU8NFCOSUaw5rDHya5WisxDqNJ8YwjjjuzpiA0tGil9Wi
         Glrdio+yhtkc53z9yCchfMF6ont2IBHvnkfPHo0uUND5d4mtKEQdCLxFuYxMx7HQPgB1
         O4OvlGZdIU1XEmzNDNRzJCjL1XuHbK3jj4YOGClLWkM/lC9JusEBx5mLwpdFTl4uCfwH
         flyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OhjtlXOrT7vnyEM+ekn1+2lKSnkgyofRum2Mactso54=;
        b=W+Td2a4l5wSQmF4s89J0GRRkrEBmE8BaYjvP8uibPbLrsoX1txD2l+FLNq0rIM32Si
         E/7EnZpHaZN07gOowpejeIm8J1M9PnOpRJf8VA2OF91brtD4c+Z4OOQEumpavvRSN51A
         mSx20pQcTbQKdm/kJvFWJbY6fTsmg26XE1WiL5QSbFjae1B68B8iMcfrMeLDraTeaObn
         KN6veL6d2I6QSZi0ma9Y18Pjd06Lwy38DMpNjyz+Owqc/lGSFTsJyLj2Srx6r43Qk4RE
         AHMpKM2ElGrG9yVQQXMc21loyoPWLWRRiEPrt7W1Lb5jAHYr6jYbFzGrhlEAScpT+O9b
         EoZg==
X-Gm-Message-State: AOAM533+6/Ouml8kjVGEnREXg+LHUrHJZQ5eVW6mVYM/RnG3PPyVmmPM
        RtK1Yz/P9dv5ENR+sd4tQPHYPTGRYrQ=
X-Google-Smtp-Source: ABdhPJwavv92aAETQFW36C+y5ReRUFM+8Zab2JNKmab5T3Yue65fhUo0ZrCIzYulHcbisG9w8Ah5/g==
X-Received: by 2002:a05:6000:18aa:b0:20c:7ec0:b804 with SMTP id b10-20020a05600018aa00b0020c7ec0b804mr11821599wri.128.1653144548710;
        Sat, 21 May 2022 07:49:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13-20020a7bc20d000000b0039744664af7sm1180461wmi.1.2022.05.21.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:08 -0700 (PDT)
Message-Id: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:51 +0000
Subject: [PATCH v3 00/15] Finish converting git bisect into a built-in
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
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After three GSoC/Outreachy students spent an incredible effort on this, it
is finally time to put a neat little bow on it.

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

Johannes Schindelin (15):
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
  bisect: move even the command-line parsing to `bisect--helper`
  bisect: teach the `bisect--helper` command to show the correct usage
    strings
  Turn `git bisect` into a full built-in
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

 Makefile                               |   3 +-
 bisect.c                               |   3 -
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 202 +++++++++++--------------
 git-bisect.sh                          |  84 ----------
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            |  11 +-
 7 files changed, 100 insertions(+), 207 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (89%)
 delete mode 100755 git-bisect.sh


base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2Fdscho%2Fbisect-in-c-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho/bisect-in-c-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1132

Range-diff vs v2:

  1:  81ca0d68cde !  1:  cf6034625dd bisect run: fix the error message
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     - {
     - 	int res = BISECT_OK;
     - 	struct strbuf command = STRBUF_INIT;
     --	struct strvec args = STRVEC_INIT;
     - 	struct strvec run_args = STRVEC_INIT;
     - 	const char *new_state;
     - 	int temporary_stdout_fd, saved_stdout;
     -@@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     - 	strvec_push(&run_args, command.buf);
     - 
     - 	while (1) {
     --		strvec_clear(&args);
     --
     - 		printf(_("running %s\n"), command.buf);
     - 		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
     - 
      @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
       			printf(_("bisect found first bad commit"));
       			res = BISECT_OK;
       		} else if (res) {
      -			error(_("bisect run failed: 'git bisect--helper --bisect-state"
     --			" %s' exited with error code %d"), args.v[0], res);
      +			error(_("bisect run failed: 'git bisect"
     -+			" %s' exited with error code %d"), new_state, res);
     + 			" %s' exited with error code %d"), new_state, res);
       		} else {
       			continue;
     - 		}
     - 
     - 		strbuf_release(&command);
     --		strvec_clear(&args);
     - 		strvec_clear(&run_args);
     - 		return res;
     - 	}
      
       ## t/t6030-bisect-porcelain.sh ##
     -@@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect visualize with a filename with dash and space' '
     - 	git bisect visualize -p -- "-hello 2"
     +@@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect state output with bad commit' '
     + 	grep -F "waiting for good commit(s), bad commit known" output
       '
       
     -+test_expect_success 'testing' '
     ++test_expect_success 'verify correct error message' '
      +	git bisect reset &&
      +	git bisect start $HASH4 $HASH1 &&
      +	write_script test_script.sh <<-\EOF &&
  2:  4320101f2e0 !  2:  955ccd4d8c8 bisect: avoid double-quoting when printing the failed command
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
       			error(_("bisect run failed: exit code %d from"
      -				" '%s' is < 0 or >= 128"), res, command.buf);
      +				" %s is < 0 or >= 128"), res, command.buf);
     - 			strbuf_release(&command);
     - 			return res;
     + 			break;
       		}
     + 
  3:  88d7173c86b !  3:  abcbc25966c bisect--helper: retire the --no-log option
     @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, co
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
       			 N_("visualize the bisection"), BISECT_VISUALIZE),
       		OPT_CMDMODE(0, "bisect-run", &cmdmode,
     - 			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
     + 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
      -		OPT_BOOL(0, "no-log", &nolog,
      -			 N_("no log for BISECT_WRITE")),
       		OPT_END()
  4:  b914fe64dda =  4:  af60ef1b5a4 bisect--helper: really retire --bisect-next-check
  5:  0d3db63bda6 =  5:  07a92c58f8e bisect--helper: really retire `--bisect-autostart`
  6:  a345cf3e0e4 =  6:  04ba0950b85 bisect--helper: using `--bisect-state` without an argument is a bug
  7:  0487701220b !  7:  6847af9d485 bisect--helper: align the sub-command order with git-bisect.sh
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      +		OPT_CMDMODE(0, "bisect-log", &cmdmode,
      +			 N_("list the bisection steps so far"), BISECT_LOG),
       		OPT_CMDMODE(0, "bisect-run", &cmdmode,
     - 			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
     + 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
       		OPT_END()
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
       		usage_with_options(git_bisect_helper_usage, options);
  8:  d8b2767c148 !  8:  b7bc53b9cb6 bisect--helper: make `--bisect-state` optional
     @@ builtin/bisect--helper.c
      @@ builtin/bisect--helper.c: static const char * const git_bisect_helper_usage[] = {
       	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
       					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
     - 	N_("git bisect--helper --bisect-next"),
     + 	"git bisect--helper --bisect-next",
      -	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
      -	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
      +	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
      +	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
       	N_("git bisect--helper --bisect-replay <filename>"),
       	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
     - 	N_("git bisect--helper --bisect-visualize"),
     + 	"git bisect--helper --bisect-visualize",
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
       			     git_bisect_helper_usage,
       			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
  9:  e8904db81c5 =  9:  1919237a819 bisect--helper: move the `BISECT_STATE` case to the end
 10:  208f8fa4851 = 10:  1236a731903 bisect--helper: return only correct exit codes in `cmd_*()`
 11:  dc04b06206b ! 11:  4ae78d37d04 bisect: move even the option parsing to `bisect--helper`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    bisect: move even the option parsing to `bisect--helper`
     +    bisect: move even the command-line parsing to `bisect--helper`
      
          On our journey to a fully built-in `git bisect`, this is the
     -    second-to-last step.
     +    one of the last steps.
      
     -    Side note: The `if (!strcmp(...)) ... else if (!strcmp(...)) ... else if
     -    (!strcmp(...)) ...` chain seen in this patch was not actually the first
     -    idea how to convert the command modes to sub-commands. Since the
     -    `bisect--helper` command already used the `parse-opions` API with neatly
     -    set-up command modes, naturally the idea was to use `PARSE_OPT_NODASH`
     -    to support proper sub-commands instead. However, the `parse-options` API
     -    is not set up for that, and even after making that option work with long
     -    options, it turned out that `STOP_AT_NON_OPTION` and `KEEP_UNKNOWN`
     -    would have to be used but these options were not designed to work
     -    together. So it would appear as if a lot of work would have to be done
     -    just to be able to use `parse_options()` just to parse the sub-command,
     -    instead of a simple `if...else if` chain, the latter being a
     -    dramatically simpler implementation.
     +    Side note: The `parse-options` API is not at all set up to parse
     +    subcommands such as `git bisect start`, `git bisect reset`, etc.
     +    Instead of fighting an up-hill battle trying to "fix" that, we simply
     +    roll the same type of manual subcommand parsing as we already do e.g.
     +    in `builtin/bundle.c`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
     - static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
     - static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
     - 
     --static const char * const git_bisect_helper_usage[] = {
     --	N_("git bisect--helper --bisect-reset [<commit>]"),
     --	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
     --	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
     --					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
     --	N_("git bisect--helper --bisect-next"),
     --	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
     --	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
     --	N_("git bisect--helper --bisect-replay <filename>"),
     --	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
     --	N_("git bisect--helper --bisect-visualize"),
     --	N_("git bisect--helper --bisect-run <cmd>..."),
     -+static const char * const git_bisect_usage[] = {
     -+	N_("git bisect help\n"
     -+	   "\tprint this long help message."),
     -+	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
     -+	   "\t\t [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]\n"
     -+	   "\treset bisect state and start bisection."),
     -+	N_("git bisect (bad|new) [<rev>]\n"
     -+	   "\tmark <rev> a known-bad revision/\n"
     -+	   "\t\ta revision after change in a given property."),
     -+	N_("git bisect (good|old) [<rev>...]\n"
     -+	   "\tmark <rev>... known-good revisions/\n"
     -+	   "\t\trevisions before change in a given property."),
     -+	N_("git bisect terms [--term-good | --term-bad]\n"
     -+	   "\tshow the terms used for old and new commits (default: bad, good)"),
     -+	N_("git bisect skip [(<rev>|<range>)...]\n"
     -+	   "\tmark <rev>... untestable revisions."),
     -+	N_("git bisect next\n"
     -+	   "\tfind next bisection to test and check it out."),
     -+	N_("git bisect reset [<commit>]\n"
     -+	   "\tfinish bisection search and go back to commit."),
     -+	N_("git bisect (visualize|view)\n"
     -+	   "\tshow bisect status in gitk."),
     -+	N_("git bisect replay <logfile>\n"
     -+	   "\treplay bisection log."),
     -+	N_("git bisect log\n"
     -+	   "\tshow bisect log."),
     -+	N_("git bisect run <cmd>...\n"
     -+	   "\tuse <cmd>... to automatically bisect."),
     - 	NULL
     - };
     - 
      @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
       
       int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      -		OPT_CMDMODE(0, "bisect-log", &cmdmode,
      -			 N_("list the bisection steps so far"), BISECT_LOG),
      -		OPT_CMDMODE(0, "bisect-run", &cmdmode,
     --			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
     +-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
       		OPT_END()
       	};
       	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      -			     git_bisect_helper_usage,
      -			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
      +	if (!strcmp("-h", command) || !strcmp("help", command))
     -+		usage_with_options(git_bisect_usage, options);
     ++		usage_with_options(git_bisect_helper_usage, options);
       
      -	switch (cmdmode ? cmdmode : BISECT_STATE) {
      -	case BISECT_START:
     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      -		if (!cmdmode &&
      -		    (!argc || check_and_set_terms(&terms, argv[0]))) {
      -			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
     --			usage_msg_opt(msg, git_bisect_helper_usage, options);
      +		if (check_and_set_terms(&terms, command)) {
      +			char *msg = xstrfmt(_("unknown command: '%s'"), command);
     -+			usage_msg_opt(msg, git_bisect_usage, options);
     + 			usage_msg_opt(msg, git_bisect_helper_usage, options);
       		}
      +		/* shift the `command` back in */
      +		argc++;
  -:  ----------- > 12:  ac472aefb6a bisect: teach the `bisect--helper` command to show the correct usage strings
 12:  7db4b03b668 ! 13:  85f5c256ae3 Turn `git bisect` into a full built-in
     @@ builtin.h: int cmd_am(int argc, const char **argv, const char *prefix);
       int cmd_bugreport(int argc, const char **argv, const char *prefix);
      
       ## builtin/bisect--helper.c => builtin/bisect.c ##
     -@@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
     - static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
     - static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
     - 
     --static const char * const git_bisect_usage[] = {
     -+static const char * const builtin_bisect_usage[] = {
     - 	N_("git bisect help\n"
     - 	   "\tprint this long help message."),
     - 	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
      @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     - 	}
     + 	return res;
       }
       
      -int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
      +int cmd_bisect(int argc, const char **argv, const char *prefix)
       {
       	int res = 0;
     - 	struct option options[] = {
     -@@ builtin/bisect.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - 	const char *command = argc > 1 ? argv[1] : "help";
     - 
     - 	if (!strcmp("-h", command) || !strcmp("help", command))
     --		usage_with_options(git_bisect_usage, options);
     -+		usage_with_options(builtin_bisect_usage, options);
     - 
     - 	argc -= 2;
     - 	argv += 2;
     -@@ builtin/bisect.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - 		get_terms(&terms);
     - 		if (check_and_set_terms(&terms, command)) {
     - 			char *msg = xstrfmt(_("unknown command: '%s'"), command);
     --			usage_msg_opt(msg, git_bisect_usage, options);
     -+			usage_msg_opt(msg, builtin_bisect_usage, options);
     - 		}
     - 		/* shift the `command` back in */
     - 		argc++;
     + 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
      
       ## git-bisect.sh (deleted) ##
      @@
 13:  0611d16f772 = 14:  289917e96af bisect: remove Cogito-related code
 14:  e2fa11a819e = 15:  8f8d2ba0fe4 bisect: no longer try to clean up left-over `.git/head-name` files

-- 
gitgitgadget
