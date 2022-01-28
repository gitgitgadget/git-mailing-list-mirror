Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B73C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 22:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiA1WYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 17:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiA1WYK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 17:24:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C17CC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 14:24:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so13223338wrg.12
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=blqjjEa3ne55fSy3JOn3B/vA45hz3VxgTkkAiwOCMdQ=;
        b=VBfhwugkehcaSq66/dMNbwIto0qm4mzLfRsN003qABwOETF/vGbkE1OxdiWNDruQCQ
         Ps1LOr0iRYS8fddexIB3x6Ihgz3+/LxMqo36qx31lsEUvR6fJRsNcA9iPWIFmyp2Esj2
         y0oHhprMPza24dtp9w5YSQ4bPedWcrd1zIUjrx8JarjJ1HePDvgAC3QzpLGKuNdb45cF
         ZSbY/EZSz0iSNF06n4HoxqWpl6a3idjQNx5+prhM5il5UUQhb5P4qZMuiB/5ScOyEI33
         oHf1TuUsaDRapT/K5pmKJHa9PTlmgt4qbYkS17pPTkJrHCURP27o7O4eyPq+j7PAVEhl
         tbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=blqjjEa3ne55fSy3JOn3B/vA45hz3VxgTkkAiwOCMdQ=;
        b=KZ/VUqcCEbUoHk7LpvTjnaLrUtTYHfn79+GjVjvqALQwBVrOCdAHNfpzUaByPRK/fX
         hLdeXIXQfSs9fgMWr0WIlpDKTk1fD2UojCuXGGksWQ64dkUVMIkk+C9WBIYf+BYjjigm
         5e3C7cc1A9VC117/yGIs528YNCF3wRvxZqozVmwA4ykfgtjzE6aYiI7j2EKO0buCU6s6
         0VzrZxhWPC0k5yTPsfLegyrfG7zqn2Q0dQLouxJRZNJCz++d4EihkQ/+rnz8VoOleTBf
         2r6jW5eTibPh96pL/bkHTrhWbXV/C854bfydm1NsjdAFgGgC/gyV3BMVJcfPVqn/F0KX
         ogbQ==
X-Gm-Message-State: AOAM530amDs+9QZKJA/YEdle2uDo5XqVARvns5I9mwPRjpAT//bD1qQs
        ldGKPDePMaGvn8DEf3DHkNVJBnE1gRQ=
X-Google-Smtp-Source: ABdhPJxT8P+ec7Svc5HOK7MwXOiivhsM8glssKyy4IV8jYfQCu7mZfG768xgFKnclSi/scFZg1wwjQ==
X-Received: by 2002:adf:e352:: with SMTP id n18mr8758651wrj.186.1643408648344;
        Fri, 28 Jan 2022 14:24:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm3041210wmq.6.2022.01.28.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:24:05 -0800 (PST)
Message-Id: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 22:23:59 +0000
Subject: [PATCH v2 0/4] Factorize i18n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small series of i18n factorizations. Again the idea is to:

 * reduce the number of strings to translate
 * make life easier for translators by removing constant parts of the
   strings to translate
 * uniformize the UI by using a type of message for the a given type of
   condition.

Changes since V1:

 * factorize checks of more than 2 incompatible options into dedicated
   functions which list all the incompatible options present on the command
   line

Jean-Noël Avila (4):
  i18n: factorize more 'incompatible options' messages
  i18n: factorize "invalid value" messages
  i18n: remove from i18n strings that do not hold translatable parts
  i18n: transfer variables into placeholders in command synopsis

 archive.c                                 |  2 +-
 builtin/am.c                              |  7 ++--
 builtin/bisect--helper.c                  |  6 +--
 builtin/blame.c                           |  6 +--
 builtin/commit.c                          | 39 +++++++++---------
 builtin/count-objects.c                   |  2 +-
 builtin/difftool.c                        |  5 ++-
 builtin/fast-export.c                     |  2 +-
 builtin/fetch.c                           |  4 +-
 builtin/grep.c                            |  8 ++--
 builtin/hash-object.c                     |  2 +-
 builtin/help.c                            |  4 +-
 builtin/log.c                             |  5 ++-
 builtin/merge-base.c                      |  4 +-
 builtin/mktag.c                           |  2 +-
 builtin/mktree.c                          |  2 +-
 builtin/notes.c                           |  6 +--
 builtin/pack-objects.c                    |  2 +-
 builtin/prune-packed.c                    |  2 +-
 builtin/pull.c                            |  6 +--
 builtin/push.c                            |  2 +-
 builtin/rebase.c                          |  2 +-
 builtin/reflog.c                          |  6 +--
 builtin/remote.c                          |  2 +-
 builtin/replace.c                         |  2 +-
 builtin/rev-list.c                        |  2 +-
 builtin/send-pack.c                       |  2 +-
 builtin/sparse-checkout.c                 |  8 ++--
 builtin/stripspace.c                      |  4 +-
 builtin/submodule--helper.c               |  2 +-
 builtin/update-server-info.c              |  2 +-
 diff-merges.c                             |  2 +-
 gpg-interface.c                           |  4 +-
 ls-refs.c                                 |  2 +-
 parallel-checkout.c                       |  3 +-
 parse-options.c                           | 50 +++++++++++++++++++++++
 parse-options.h                           |  9 ++++
 sequencer.c                               |  2 +-
 setup.c                                   |  2 +-
 submodule-config.c                        |  2 +-
 t/t4150-am.sh                             |  2 +-
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 42 files changed, 145 insertions(+), 85 deletions(-)


base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1123%2Fjnavila%2Ffactorize_i18n-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1123/jnavila/factorize_i18n-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1123

Range-diff vs v1:

 1:  81ff928567f ! 1:  844e01391e1 i18n: factorize more 'incompatible options' messages
     @@ Metadata
       ## Commit message ##
          i18n: factorize more 'incompatible options' messages
      
     +    Find more incompatible options to factorize.
     +
          When more than two options are mutually exclusive, print the ones
          which are actually on the command line.
      
     @@ Commit message
      
       ## builtin/commit.c ##
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
     + 				      struct commit *current_head,
       				      struct wt_status *s)
       {
     - 	int f = 0;
     -+	char * f_options[4];
     - 
     +-	int f = 0;
     +-
       	argc = parse_options(argc, argv, prefix, options, usage, 0);
       	finalize_deferred_config(s);
     + 
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
       		force_author = find_author_by_nickname(force_author);
       
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      -		f++;
      -	if (logfile)
      -		f++;
     -+		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
     -+	f_options[f] = "-C";
     -+	f+=	!!use_message;
     -+	f_options[f] = "-c";
     -+	f+=!!edit_message;
     -+	f_options[f] = "-F";
     -+	f+=!!logfile;
     -+	f_options[f] = "--fixup";
     -+	f+=!!fixup_message;
     - 	if (f > 1)
     +-	if (f > 1)
      -		die(_("Only one of -c/-C/-F/--fixup can be used."));
     -+		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
     - 	if (have_option_m && (edit_message || use_message || logfile))
     +-	if (have_option_m && (edit_message || use_message || logfile))
      -		die((_("Option -m cannot be combined with -c/-C/-F.")));
     -+		die(_("options '%s' and '%s' cannot be used together"), "-m", f_options[0]);
     - 	if (f || have_option_m)
     +-	if (f || have_option_m)
     ++		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
     ++	die_if_incompatible_opt4(!!use_message, "-C",
     ++							 !!edit_message, "-c",
     ++							 !!logfile, "-F",
     ++							 !!fixup_message, "--fixup");
     ++	if (have_option_m) {
     ++		if (edit_message)
     ++			die(_("options '%s' and '%s' cannot be used together"), "-m", "-c");
     ++		else if  (use_message)
     ++			die(_("options '%s' and '%s' cannot be used together"), "-m", "-C");
     ++		else if (logfile)
     ++			die(_("options '%s' and '%s' cannot be used together"), "-m", "-F");
     ++	}
     ++	if (use_message || edit_message || logfile ||fixup_message || have_option_m)
       		template_file = NULL;
       	if (edit_message)
     + 		use_message = edit_message;
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
     - 
       	if (patch_interactive)
       		interactive = 1;
     --
     + 
      -	if (also + only + all + interactive > 1)
      -		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
     -+	f = 0;
     -+	f_options[f] = "-i/--include";
     -+	f += also;
     -+	f_options[f] = "-o/--only";
     -+	f += only;
     -+	f_options[f] = "-a/--all";
     -+	f += all;
     -+	f_options[f] = "--interactive/-p/--patch";
     -+	f += interactive;
     -+	if (f > 1)
     -+		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
     - 
     +-
     ++	die_if_incompatible_opt4(also, "-i/--include",
     ++							 only, "-o/--only",
     ++							 all, "-a/--all",
     ++							 interactive, "--interactive/-p/--patch");
       	if (fixup_message) {
       		/*
     + 		 * We limit --fixup's suboptions to only alpha characters.
      
       ## builtin/difftool.c ##
     -@@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
     - 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
     - 	    tool_help = 0, no_index = 0;
     - 	static char *difftool_cmd = NULL, *extcmd = NULL;
     -+	int f = 0;
     -+	char *f_options[3];
     - 	struct option builtin_difftool_options[] = {
     - 		OPT_BOOL('g', "gui", &use_gui_tool,
     - 			 N_("use `diff.guitool` instead of `diff.tool`")),
      @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
       	} else if (dir_diff)
       		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
       
      -	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
      -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
     -+	if (use_gui_tool) {
     -+		f_options[f] = "--gui";
     -+		f++;
     -+	}
     -+	if (difftool_cmd) {
     -+		f_options[f] = "--tool";
     -+		f++;
     -+	}
     -+	if (extcmd) {
     -+		f_options[f] = "--extcmd";
     -+		f++;
     -+	}
     -+	if (f > 1)
     -+		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
     ++	die_if_incompatible_opt3(use_gui_tool, "--gui",
     ++							 !!difftool_cmd, "--tool",
     ++							 !!extcmd, "--extcmd");
       
       	if (use_gui_tool)
       		setenv("GIT_MERGETOOL_GUI", "true", 1);
      
       ## builtin/grep.c ##
      @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
     + 	if (!show_in_pager && !opt.status_only)
       		setup_pager();
       
     - 	if (!use_index && (untracked || cached))
     +-	if (!use_index && (untracked || cached))
      -		die(_("--cached or --untracked cannot be used with --no-index"));
     -+		die(_("options '%s' and '%s' cannot be used together"),"--cached/--untracked", "--no-index");
     - 
     - 	if (untracked && cached)
     +-
     +-	if (untracked && cached)
      -		die(_("--untracked cannot be used with --cached"));
     -+		die(_("options '%s' and '%s' cannot be used together"), "--untracked", "--cached");
     ++	die_if_incompatible_opt3(!use_index, "--no-index",
     ++							 untracked, "--untracked",
     ++							 cached, "--cached");
       
       	if (!use_index || untracked) {
       		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
      
       ## builtin/log.c ##
     -@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     - 	struct strbuf rdiff_title = STRBUF_INIT;
     - 	int creation_factor = -1;
     - 
     -+	int f = 0;
     -+	char * f_options[4];
     -+
     - 	const struct option builtin_format_patch_options[] = {
     - 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
     - 			    N_("use [PATCH n/m] even with a single patch"),
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
       	if (rev.show_notes)
       		load_display_notes(&rev.notes_opt);
       
      -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
      -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
     -+	if (use_stdout) {
     -+		f_options[f] = "--stdout";
     -+		f++;
     -+	}
     -+	if (rev.diffopt.close_file) {
     -+		f_options[f] = "--output";
     -+		f++;
     -+	}
     -+	if (output_directory) {
     -+		f_options[f] = "--output-directory";
     -+		f++;
     -+	}
     -+
     -+	if (f > 1)
     -+		die(_("options '%s'and '%s' cannot be used together"), f_options[0], f_options[1]);
     ++	die_if_incompatible_opt3(use_stdout, "--stdout",
     ++							 rev.diffopt.close_file, "--output",
     ++							 !!output_directory, "--output-directory");
       
       	if (use_stdout) {
       		setup_pager();
     @@ builtin/merge-base.c: int cmd_merge_base(int argc, const char **argv, const char
       	if (cmdmode == 'o')
       		return handle_octopus(argc, argv, show_all);
      
     + ## parse-options.c ##
     +@@ parse-options.c: void NORETURN usage_msg_opt(const char *msg,
     + 	die_message("%s\n", msg); /* The extra \n is intentional */
     + 	usage_with_options(usagestr, options);
     + }
     ++
     ++void die_if_incompatible_opt3(int opt1, const char *opt1_name,
     ++							  int opt2, const char *opt2_name,
     ++							  int opt3, const char *opt3_name)
     ++{
     ++	int count = 0;
     ++	const char *options[3];
     ++
     ++	if (opt1)
     ++		options[count++] = opt1_name;
     ++	if (opt2)
     ++		options[count++] = opt2_name;
     ++	if (opt3)
     ++		options[count++] = opt3_name;
     ++	if (count > 2)
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name);
     ++	else if (count > 1)
     ++		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
     ++}
     ++
     ++void die_if_incompatible_opt4(int opt1, const char *opt1_name,
     ++							  int opt2, const char *opt2_name,
     ++							  int opt3, const char *opt3_name,
     ++							  int opt4, const char *opt4_name)
     ++{
     ++	int count = 0;
     ++	const char *options[4];
     ++
     ++	if (opt1)
     ++		options[count++] = opt1_name;
     ++	if (opt2)
     ++		options[count++] = opt2_name;
     ++	if (opt3)
     ++		options[count++] = opt3_name;
     ++	if (opt4)
     ++		options[count++] = opt4_name;
     ++	switch (count) {
     ++	case 4:
     ++		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name, opt4_name);
     ++		break;
     ++	case 3:
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"), options[0], options[1], options[2]);
     ++		break;
     ++	case 2:
     ++		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
     ++		break;
     ++	default:
     ++		break;
     ++	}
     ++}
     +
     + ## parse-options.h ##
     +@@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *, int);
     + #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
     + #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
     + 
     ++void die_if_incompatible_opt3(int opt1, const char *opt1_name,
     ++							  int opt2, const char *opt2_name,
     ++							  int opt3, const char *opt3_name);
     ++
     ++void die_if_incompatible_opt4(int opt1, const char *opt1_name,
     ++							  int opt2, const char *opt2_name,
     ++							  int opt3, const char *opt3_name,
     ++							  int opt4, const char *opt4_name);
     ++
     + #endif
     +
       ## t/t7500-commit-template-squash-signoff.sh ##
      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success '--fixup=reword: give error with pathsec' '
       '
 2:  ca48e82a6b4 = 2:  4c860698d69 i18n: factorize "invalid value" messages
 3:  ead191faad9 = 3:  376f8b56908 i18n: remove from i18n strings that do not hold translatable parts
 4:  643be0d82de = 4:  8b0057f6180 i18n: transfer variables into placeholders in command synopsis

-- 
gitgitgadget
