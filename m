Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29538ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiH3Su1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiH3SuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7F17AB5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso5081299wmq.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=BkWHzltxr2FJmI63QOT2EpnXuf7DoEF4/F9fNSGTonw=;
        b=pR6sUSqwJIaYzxtsequWS8xxy0wEiUvcX8YVbMXedtvoxB3dMHoH1PjM4nKzy9cEqJ
         TFINX+4eKFiVsnTZ5VhsptXVafbB2tVM9f+OCUpFgzA/rp+wjocLldxp455GLYCBagAf
         iBpjTsY++QzPE7sd8PScNCOuRUW/GP3IGjJvdpXhAnks7LdcfgVBqSDMRzTsx8IBu4i4
         Uvoc3iTMKvGJo8sfG+ytjH8zVd5XoCDT/KIqcSz/5m2PKFE3dBUjP+LFG2TBJOhmbhlf
         /p9ODv5Im3V5d6OXo6pbYV0J7kVDFwur8jCBQM27sAsvebma4h5nQamBfOI2ugrpMH6k
         q2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=BkWHzltxr2FJmI63QOT2EpnXuf7DoEF4/F9fNSGTonw=;
        b=pf0BmuHJSGEft+EJix573KTvd9HN+9cL1l5yKUpVjJmJzsSrEOWmG+3WsPK8o6AUGM
         4v4jpz+YqY0KCnaXoFLUTiJIfwNci1lF1OJL85ipyq6VHinIcUctmtxpFVED6DVtXdVb
         SCi5t57yl35DkqklLKGxwcRTp5tbIFAzgQSptvo+PrU0rq7u5Dg2yYJTxkcuc+QmkHpi
         IbGjoOHHreCobssCGsVuMW/tVHeGszHeDHpwUISzUzzglJsin9cb7HQrbVPwE+ov5T2C
         5ZDaQ/3Osvjqktyn3iUbUpoAIDy7NViGGMoyhdg+VbbLv5gUTxpGUk9VK4myxEVq3wK4
         MLvA==
X-Gm-Message-State: ACgBeo11pixMzns6Z9sa3j99rHfxOjCYLI5gMDC2Vt03oJ/nJhcDk0e/
        JW06THA+TQ5oiYtt6c7LCBICQqlBa6U=
X-Google-Smtp-Source: AA6agR4a2fOucZGpbkCMj8UmbaDw1VkjwgHB7ZzqLtbTNVl3Ryj6SlQUA7ZzRORUMuT6rDWNMqA0FA==
X-Received: by 2002:a05:600c:2104:b0:3a5:40c4:bab6 with SMTP id u4-20020a05600c210400b003a540c4bab6mr10518528wml.119.1661885421765;
        Tue, 30 Aug 2022 11:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay15-20020a5d6f0f000000b002207a5d8db3sm10678794wrb.73.2022.08.30.11.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:20 -0700 (PDT)
Message-Id: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:03 +0000
Subject: [PATCH v6 00/16] Finish converting git bisect into a built-in
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
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After three GSoC/Outreachy students spent an incredible effort on this, it
is finally time to put a neat little bow on it, or maybe more like a big
bow, maybe even a very large one, seeing as it takes quite a while to tie
(half a year at the time of writing)...

Changes since v5:

 * Fixed the commit message of "bisect run: fix the error message" that had
   become stale as of v3 due to 80c2e9657f2 "overtaking" it and doing half
   of its job.
 * Skipped translation usage strings in "bisect--helper: migrate to
   OPT_SUBCOMMAND()" that do not contain translatable parts.
 * Minor white-space clean-up in "bisect--helper: migrate to
   OPT_SUBCOMMAND()".

Changes since v4:

 * rebased onto sg/parse-options-subcommand
 * migrated to OPT_SUBCOMMAND().
 * As a consequence, this patch series is now unfortunately very large. And
   the range-diff is much less useful than I'd like because of the extensive
   changes that were de facto made a precondition to moving this patch
   series further. Junio, I would have liked to keep the scope (and burden
   for the reviewers) substantially smaller, maybe you can help with the
   review?

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
  bisect--helper: retire the --no-log option
  bisect--helper: really retire --bisect-next-check
  bisect--helper: really retire `--bisect-autostart`
  bisect--helper: simplify exit code computation
  bisect--helper: make `terms` an explicit singleton
  bisect--helper: make the order consistently `argc, argv`
  bisect--helper: migrate to OPT_SUBCOMMAND()
  bisect: verify that a bogus option won't try to start a bisection
  bisect run: fix the error message
  bisect: avoid double-quoting when printing the failed command
  bisect--helper: calling `bisect_state()` without an argument is a bug
  bisect--helper: make `state` optional
  bisect: move even the command-line parsing to `bisect--helper`
  Turn `git bisect` into a full built-in
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

 Makefile                               |   3 +-
 bisect.c                               |   3 -
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 679 ++++++++++++++-----------
 git-bisect.sh                          |  84 ---
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            |  21 +-
 7 files changed, 406 insertions(+), 388 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (67%)
 delete mode 100755 git-bisect.sh


base-commit: 8f9d80f6c06369b563c76ec46c462e740a1a2cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2Fdscho%2Fbisect-in-c-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho/bisect-in-c-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1132

Range-diff vs v5:

  1:  05262b6a7d1 =  1:  05262b6a7d1 bisect--helper: retire the --no-log option
  2:  1e43148864a =  2:  1e43148864a bisect--helper: really retire --bisect-next-check
  3:  1a1649d9d0d =  3:  1a1649d9d0d bisect--helper: really retire `--bisect-autostart`
  4:  9ab30552c6a =  4:  9ab30552c6a bisect--helper: simplify exit code computation
  5:  92b3b116ef8 =  5:  92b3b116ef8 bisect--helper: make `terms` an explicit singleton
  6:  c9dc0281e38 =  6:  c9dc0281e38 bisect--helper: make the order consistently `argc, argv`
  7:  5b7a3d58b4f !  7:  e97e187bbec bisect--helper: migrate to OPT_SUBCOMMAND()
     @@ Commit message
          `bisect--helper` learns about it in preparation for replacing the
          `git-bisect.sh` script altogether.
      
     +    As a consequence, the usage strings are copied over from the scripted
     +    version of the `git bisect` command. To avoid regressing on 959d670d1a4
     +    (i18n: remove from i18n strings that do not hold translatable parts,
     +    2022-01-31), we specifically do not enclose usage strings in `N_(...)`
     +    that do not contain any translatable parts.
     +
          Note that a couple of `bisect_*()` functions are not converted into
          `cmd_bisect_*()` functions directly, as they have callers other than the
          `OPT_SUBCOMMAND()` one (and the original functions did not expect
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      +	   "    [<pathspec>...]"),
      +	N_("git bisect (bad|new) [<rev>]"),
      +	N_("git bisect (good|old) [<rev>...]"),
     -+	N_("git bisect terms [--term-good | --term-bad]"),
     ++	"git bisect terms [--term-good | --term-bad]",
      +	N_("git bisect skip [(<rev>|<range>)...]"),
     -+	N_("git bisect next"),
     ++	"git bisect next",
      +	N_("git bisect reset [<commit>]"),
     -+	N_("git bisect (visualize|view)"),
     ++	"git bisect (visualize|view)",
      +	N_("git bisect replay <logfile>"),
     -+	N_("git bisect log"),
     ++	"git bisect log",
      +	N_("git bisect run <cmd>..."),
      +	NULL
      +};
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      +};
      +
      +static const char * const bisect_terms_usage[] = {
     -+	N_("git bisect terms [--term-good | --term-bad]"),
     ++	"git bisect terms [--term-good | --term-bad]",
      +	NULL
      +};
      +
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      +};
      +
      +static const char * const bisect_next_usage[] = {
     -+	N_("git bisect next"),
     ++	"git bisect next",
      +	NULL
      +};
      +
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      +};
      +
      +static const char * const bisect_visualize_usage[] = {
     -+	N_("git bisect visualize"),
     ++	"git bisect visualize",
      +	NULL
      +};
      +
     @@ builtin/bisect--helper.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NA
      +};
      +
      +static const char * const bisect_log_usage[] = {
     -+	N_("git bisect log"),
     ++	"git bisect log",
      +	NULL
      +};
      +
     @@ builtin/bisect--helper.c: static int bisect_reset(const char *commit)
      +		OPT_END()
      +	};
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_reset_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_reset_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
      +	if (argc > 1)
      +		usage_msg_opt(_("requires either no argument or a commit"),
     @@ builtin/bisect--helper.c: finish:
      +	};
      +
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_terms_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_terms_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
      +	if (argc > 1)
      +		usage_msg_opt(_("terms: requires 0 or 1 argument"),
     @@ builtin/bisect--helper.c: static enum bisect_error bisect_state(int argc, const
      +	get_terms();
      +
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_state_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_state_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
      +	if (!argc)
      +		usage_msg_opt(_("need at least one argument"),
     @@ builtin/bisect--helper.c: static enum bisect_error bisect_state(int argc, const
       	const char* filename = git_path_bisect_log();
       
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_log_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_log_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
      +	if (argc > 0)
      +		usage_msg_opt(_("require 0 argument"), bisect_log_usage,
     @@ builtin/bisect--helper.c: static int process_replay_line(struct strbuf *line)
       
      +	set_terms("bad", "good");
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_reset_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_reset_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
      +	if (argc != 1)
      +		usage_msg_opt(_("no logfile given"), bisect_replay_usage,
     @@ builtin/bisect--helper.c: static enum bisect_error bisect_replay(const char *fil
      +	set_terms("bad", "good");
      +	get_terms();
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_skip_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_skip_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
       	strvec_push(&argv_state, "skip");
       
     @@ builtin/bisect--helper.c: static int bisect_run(int argc, const char **argv)
       
      +	get_terms();
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     bisect_run_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
     ++			     bisect_run_usage, PARSE_OPT_STOP_AT_NON_OPTION);
      +
       	if (bisect_next_check(NULL))
       		return BISECT_FAILED;
  8:  ba537af7066 =  8:  30c87f2e92e bisect: verify that a bogus option won't try to start a bisection
  9:  409492ad830 !  9:  4696652b99c bisect run: fix the error message
     @@ Commit message
      
          However, the error message was supposed to print out whether the state
          was "good" or "bad", but used a bogus (because non-populated) `args`
     -    variable for it.
     +    variable for it. This was fixed in 80c2e9657f2 (bisect--helper: report
     +    actual bisect_state() argument on error, 2022-01-18), but the error
     +    message still talks about `bisect--helper`, which is an implementation
     +    detail that should not concern end users.
     +
     +    Fix that, and add a regression test to ensure that the intended form of
     +    the error message.
      
          Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 10:  bc5efc8fbfe = 10:  b202a0e386c bisect: avoid double-quoting when printing the failed command
 11:  8a0adfe3867 = 11:  3376b450867 bisect--helper: calling `bisect_state()` without an argument is a bug
 12:  189d2b3ba46 = 12:  e7623508f90 bisect--helper: make `state` optional
 13:  32bf74e3050 = 13:  3f052580c95 bisect: move even the command-line parsing to `bisect--helper`
 14:  a8f08f5e0cb = 14:  a83fe3dc3c2 Turn `git bisect` into a full built-in
 15:  a96489310d3 = 15:  f2132b61ff7 bisect: remove Cogito-related code
 16:  bfa7aa19f03 = 16:  4f93692e071 bisect: no longer try to clean up left-over `.git/head-name` files

-- 
gitgitgadget
