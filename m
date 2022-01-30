Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA6FC433F5
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 22:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiA3WB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 17:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiA3WB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 17:01:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E2C061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 14:01:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v123so8921299wme.2
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=nLm0qUBNzMxd/MDSOiQiKDOOiQ0pDWjOfH4I0ADbRto=;
        b=SeNSvuqEfEY3SSIjLRoMJPFnCa1iixZxZmU6NiS3gUg4WYvbaLLgJAxqNCPIkVIRJ5
         gFYAtqvkXbacPXCFHQS3ldu7aoMVAI9vyVtLzoDClv8wYUjr2phJkCGOLFf/GQoZ/c5k
         VSxBiToLXYwbAmETOpEciuCckxyXZ9Jq3DayzON1RUvmcGKIlNFPhPbOe9f0fgLFinu1
         ObEX6DCLtL51d0Bc80mEG8//2GU53bFZTaimQzCDusL0NLY4olE21x8Gai6tH5mWeNod
         kFCzuFF2j/x6eikbI3deMlzgOM9y/6hsm8Wsb6I9JqRM47mR9xyALD7DXa04sbDrum8p
         QHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=nLm0qUBNzMxd/MDSOiQiKDOOiQ0pDWjOfH4I0ADbRto=;
        b=bQ1y/ZxrCH++bNFVjclbGTC8S6cYuPLGF+cycf9zvcTtVTVeKVBc0HjQkiqJelMn/+
         9b9KR+jD5VPJu5uF8wCT+/BG5Y0lpiBKQjYWr3dfCrqx0wSS0u9sRHCdw+mFZNe42Jpk
         To1QKDitPXMM0rnQiJqkF+zIa4eAi7oANUilmwp3sT5khVG9cEqgZtkVzSNGxw4XL6cJ
         i6nKo5QQFFcvXVmAUEoX0RtWcEZle6gvrHirt3fqog8bOQDGLU11eAeTp/lK4SpIkm/y
         nnmM0KfQ1AuL7FdUOm4/PwEYtDcYpqZj6yBHQabzfyxfUd8xRxyAIg8Fr4nKryQd0kYd
         haEw==
X-Gm-Message-State: AOAM532Na9jGMq/aPRi58BfxbWgOXFh1xWbqyTJs4KhONG4LRc57z8sy
        4qDHf99OuWYFM8wjU6uHu9qibBX6U/o=
X-Google-Smtp-Source: ABdhPJyedn8YrfEqJlRY+T4T0o03NlmAYtSZ8pf41MVj2/xMI+2Ha6LgJ2zonUoS/vj6X21RsUi/XQ==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr3920188wmq.45.1643580115166;
        Sun, 30 Jan 2022 14:01:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm10354349wrf.112.2022.01.30.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:01:54 -0800 (PST)
Message-Id: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 30 Jan 2022 22:01:49 +0000
Subject: [PATCH v3 0/4] Factorize i18n
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

Changes since V2:

 * switch to tab size 8
 * rename die_if* to die_for*
 * make 3 arg check a call to 4 arg check
 * switch another part to die_for_incompatible_opt4

Jean-Noël Avila (4):
  i18n: factorize more 'incompatible options' messages
  i18n: factorize "invalid value" messages
  i18n: remove from i18n strings that do not hold translatable parts
  i18n: transfer variables into placeholders in command synopsis

 archive.c                                 |  2 +-
 builtin/am.c                              |  8 ++++--
 builtin/bisect--helper.c                  |  6 ++--
 builtin/blame.c                           |  7 +++--
 builtin/commit.c                          | 35 ++++++++++-------------
 builtin/count-objects.c                   |  2 +-
 builtin/difftool.c                        |  5 ++--
 builtin/fast-export.c                     |  2 +-
 builtin/fetch.c                           |  4 +--
 builtin/grep.c                            |  8 ++----
 builtin/hash-object.c                     |  2 +-
 builtin/help.c                            |  4 +--
 builtin/log.c                             |  5 ++--
 builtin/merge-base.c                      |  6 ++--
 builtin/mktag.c                           |  2 +-
 builtin/mktree.c                          |  2 +-
 builtin/notes.c                           |  6 ++--
 builtin/pack-objects.c                    |  2 +-
 builtin/prune-packed.c                    |  2 +-
 builtin/pull.c                            |  6 ++--
 builtin/push.c                            |  2 +-
 builtin/rebase.c                          |  2 +-
 builtin/reflog.c                          |  6 ++--
 builtin/remote.c                          |  2 +-
 builtin/replace.c                         |  2 +-
 builtin/rev-list.c                        |  2 +-
 builtin/send-pack.c                       |  2 +-
 builtin/sparse-checkout.c                 |  8 +++---
 builtin/stripspace.c                      |  4 +--
 builtin/submodule--helper.c               |  2 +-
 builtin/update-server-info.c              |  2 +-
 diff-merges.c                             |  2 +-
 gpg-interface.c                           |  6 ++--
 ls-refs.c                                 |  3 +-
 parallel-checkout.c                       |  4 +--
 parse-options.c                           | 34 ++++++++++++++++++++++
 parse-options.h                           | 17 +++++++++++
 sequencer.c                               |  2 +-
 setup.c                                   |  3 +-
 submodule-config.c                        |  2 +-
 t/t4150-am.sh                             |  2 +-
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 42 files changed, 140 insertions(+), 87 deletions(-)


base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1123%2Fjnavila%2Ffactorize_i18n-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1123/jnavila/factorize_i18n-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1123

Range-diff vs v2:

 1:  844e01391e1 ! 1:  aac3f9821c7 i18n: factorize more 'incompatible options' messages
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      -		die((_("Option -m cannot be combined with -c/-C/-F.")));
      -	if (f || have_option_m)
      +		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
     -+	die_if_incompatible_opt4(!!use_message, "-C",
     -+							 !!edit_message, "-c",
     -+							 !!logfile, "-F",
     -+							 !!fixup_message, "--fixup");
     -+	if (have_option_m) {
     -+		if (edit_message)
     -+			die(_("options '%s' and '%s' cannot be used together"), "-m", "-c");
     -+		else if  (use_message)
     -+			die(_("options '%s' and '%s' cannot be used together"), "-m", "-C");
     -+		else if (logfile)
     -+			die(_("options '%s' and '%s' cannot be used together"), "-m", "-F");
     -+	}
     ++	die_for_incompatible_opt4(!!use_message, "-C",
     ++				  !!edit_message, "-c",
     ++				  !!logfile, "-F",
     ++				  !!fixup_message, "--fixup");
     ++	die_for_incompatible_opt4(have_option_m, "-m",
     ++				  !!edit_message, "-c",
     ++				  !!use_message, "-C",
     ++				  !!logfile, "-F");
      +	if (use_message || edit_message || logfile ||fixup_message || have_option_m)
       		template_file = NULL;
       	if (edit_message)
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      -	if (also + only + all + interactive > 1)
      -		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
      -
     -+	die_if_incompatible_opt4(also, "-i/--include",
     -+							 only, "-o/--only",
     -+							 all, "-a/--all",
     -+							 interactive, "--interactive/-p/--patch");
     ++	die_for_incompatible_opt4(also, "-i/--include",
     ++				  only, "-o/--only",
     ++				  all, "-a/--all",
     ++				  interactive, "--interactive/-p/--patch");
       	if (fixup_message) {
       		/*
       		 * We limit --fixup's suboptions to only alpha characters.
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
       
      -	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
      -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
     -+	die_if_incompatible_opt3(use_gui_tool, "--gui",
     -+							 !!difftool_cmd, "--tool",
     -+							 !!extcmd, "--extcmd");
     ++	die_for_incompatible_opt3(use_gui_tool, "--gui",
     ++				  !!difftool_cmd, "--tool",
     ++				  !!extcmd, "--extcmd");
       
       	if (use_gui_tool)
       		setenv("GIT_MERGETOOL_GUI", "true", 1);
     @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      -
      -	if (untracked && cached)
      -		die(_("--untracked cannot be used with --cached"));
     -+	die_if_incompatible_opt3(!use_index, "--no-index",
     -+							 untracked, "--untracked",
     -+							 cached, "--cached");
     ++	die_for_incompatible_opt3(!use_index, "--no-index",
     ++				  untracked, "--untracked",
     ++				  cached, "--cached");
       
       	if (!use_index || untracked) {
       		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       
      -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
      -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
     -+	die_if_incompatible_opt3(use_stdout, "--stdout",
     -+							 rev.diffopt.close_file, "--output",
     -+							 !!output_directory, "--output-directory");
     ++	die_for_incompatible_opt3(use_stdout, "--stdout",
     ++				  rev.diffopt.close_file, "--output",
     ++				  !!output_directory, "--output-directory");
       
       	if (use_stdout) {
       		setup_pager();
     @@ builtin/merge-base.c: int cmd_merge_base(int argc, const char **argv, const char
       			usage_with_options(merge_base_usage, options);
       		if (show_all)
      -			die("--is-ancestor cannot be used with --all");
     -+			die(_("options '%s' and '%s' cannot be used together"),"--is-ancestor", "--all");
     ++			die(_("options '%s' and '%s' cannot be used together"),
     ++			    "--is-ancestor", "--all");
       		return handle_is_ancestor(argc, argv);
       	}
       
       	if (cmdmode == 'r' && show_all)
      -		die("--independent cannot be used with --all");
     -+		die(_("options '%s' and '%s' cannot be used together"),"--independent", "--all");
     ++		die(_("options '%s' and '%s' cannot be used together"),
     ++		    "--independent", "--all");
       
       	if (cmdmode == 'o')
       		return handle_octopus(argc, argv, show_all);
     @@ parse-options.c: void NORETURN usage_msg_opt(const char *msg,
       	usage_with_options(usagestr, options);
       }
      +
     -+void die_if_incompatible_opt3(int opt1, const char *opt1_name,
     -+							  int opt2, const char *opt2_name,
     -+							  int opt3, const char *opt3_name)
     -+{
     -+	int count = 0;
     -+	const char *options[3];
     -+
     -+	if (opt1)
     -+		options[count++] = opt1_name;
     -+	if (opt2)
     -+		options[count++] = opt2_name;
     -+	if (opt3)
     -+		options[count++] = opt3_name;
     -+	if (count > 2)
     -+		die(_("options '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name);
     -+	else if (count > 1)
     -+		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
     -+}
     -+
     -+void die_if_incompatible_opt4(int opt1, const char *opt1_name,
     -+							  int opt2, const char *opt2_name,
     -+							  int opt3, const char *opt3_name,
     -+							  int opt4, const char *opt4_name)
     ++void die_for_incompatible_opt4(int opt1, const char *opt1_name,
     ++			       int opt2, const char *opt2_name,
     ++			       int opt3, const char *opt3_name,
     ++			       int opt4, const char *opt4_name)
      +{
      +	int count = 0;
      +	const char *options[4];
     @@ parse-options.c: void NORETURN usage_msg_opt(const char *msg,
      +		options[count++] = opt4_name;
      +	switch (count) {
      +	case 4:
     -+		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name, opt4_name);
     ++		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
     ++		    opt1_name, opt2_name, opt3_name, opt4_name);
      +		break;
      +	case 3:
     -+		die(_("options '%s', '%s', and '%s' cannot be used together"), options[0], options[1], options[2]);
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"),
     ++		    options[0], options[1], options[2]);
      +		break;
      +	case 2:
     -+		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
     ++		die(_("options '%s' and '%s' cannot be used together"),
     ++		    options[0], options[1]);
      +		break;
      +	default:
      +		break;
     @@ parse-options.c: void NORETURN usage_msg_opt(const char *msg,
      +}
      
       ## parse-options.h ##
     +@@ parse-options.h: NORETURN void usage_msg_opt(const char *msg,
     + 			    const char * const *usagestr,
     + 			    const struct option *options);
     + 
     ++void die_for_incompatible_opt4(int opt1, const char *opt1_name,
     ++			       int opt2, const char *opt2_name,
     ++			       int opt3, const char *opt3_name,
     ++			       int opt4, const char *opt4_name);
     ++
     ++
     ++inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
     ++				      int opt2, const char *opt2_name,
     ++				      int opt3, const char *opt3_name)
     ++{
     ++	die_for_incompatible_opt4(opt1, opt1_name,
     ++				  opt2, opt2_name,
     ++				  opt3, opt3_name,
     ++				  0, "");
     ++}
     ++
     + /*
     +  * Use these assertions for callbacks that expect to be called with NONEG and
     +  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
      @@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *, int);
       #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
       #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
       
     -+void die_if_incompatible_opt3(int opt1, const char *opt1_name,
     -+							  int opt2, const char *opt2_name,
     -+							  int opt3, const char *opt3_name);
     -+
     -+void die_if_incompatible_opt4(int opt1, const char *opt1_name,
     -+							  int opt2, const char *opt2_name,
     -+							  int opt3, const char *opt3_name,
     -+							  int opt4, const char *opt4_name);
      +
       #endif
      
 2:  4c860698d69 ! 2:  078336ae418 i18n: factorize "invalid value" messages
     @@ builtin/am.c: static int parse_opt_patchformat(const struct option *opt, const c
       	 */
       	else
      -		return error(_("Invalid value for --patch-format: %s"), arg);
     -+		return error(_("invalid value for '%s': '%s'"), "--patch-format", arg);
     ++		return error(_("invalid value for '%s': '%s'"),
     ++			     "--patch-format", arg);
       	return 0;
       }
       
     @@ builtin/am.c: static int parse_opt_show_current_patch(const struct option *opt,
       		if (new_value >= ARRAY_SIZE(valid_modes))
      -			return error(_("Invalid value for --show-current-patch: %s"), arg);
      +			return error(_("invalid value for '%s': '%s'"),
     -+						 "--show-current-patch", arg);
     ++				     "--show-current-patch", arg);
       	}
       
       	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
     @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
      -			warning(_("invalid color '%s' in color.blame.repeatedLines"),
      -				value);
      +			warning(_("invalid value for '%s': '%s'"),
     -+					"color.blame.repeatedLines", value);
     ++				"color.blame.repeatedLines", value);
       		return 0;
       	}
       	if (!strcmp(var, "color.blame.highlightrecent")) {
     @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
       					    OUTPUT_SHOW_AGE_WITH_COLOR);
       		} else {
      -			warning(_("invalid value for blame.coloring"));
     -+			warning(_("invalid value for '%s': '%s'"), "blame.coloring", value);
     ++			warning(_("invalid value for '%s': '%s'"),
     ++				"blame.coloring", value);
       			return 0;
       		}
       	}
     @@ builtin/fetch.c: static void prepare_format_display(struct ref *ref_map)
      -		die(_("configuration fetch.output contains invalid value %s"),
      -		    format);
      +		die(_("invalid value for '%s': '%s'"),
     -+			  "fetch.output", format);
     ++		    "fetch.output", format);
       
       	for (rm = ref_map; rm; rm = rm->next) {
       		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
       		fmt = get_format_by_name(value);
       		if (!fmt)
      -			return error("unsupported value for %s: %s",
     -+			return error("invalid value for '%s': '%s'",
     ++			return error(_("invalid value for '%s': '%s'"),
       				     var, value);
       		use_format = fmt;
       		return 0;
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb
       
       		if (ret)
      -			return error("unsupported value for %s: %s", var,
     -+			return error("invalid value for '%s': '%s'", var,
     - 				     value);
     +-				     value);
     ++			return error(_("invalid value for '%s': '%s'"),
     ++				     var, value);
       		return 0;
       	}
     + 
      
       ## ls-refs.c ##
      @@ ls-refs.c: static void ensure_config_read(void)
     @@ ls-refs.c: static void ensure_config_read(void)
       			/* do nothing */
       		} else {
      -			die(_("invalid value '%s' for lsrefs.unborn"), str);
     -+			die(_("invalid value for '%s': '%s'"), "lsrefs.unborn", str);
     ++			die(_("invalid value for '%s': '%s'"),
     ++			    "lsrefs.unborn", str);
       		}
       	}
       	config_read = 1;
     @@ parallel-checkout.c: void get_parallel_checkout_configs(int *num_workers, int *t
       	if (env_workers && *env_workers) {
       		if (strtol_i(env_workers, 10, num_workers)) {
      -			die("invalid value for GIT_TEST_CHECKOUT_WORKERS: '%s'",
     +-			    env_workers);
      +			die(_("invalid value for '%s': '%s'"),
     -+				"GIT_TEST_CHECKOUT_WORKERS",
     - 			    env_workers);
     ++			    "GIT_TEST_CHECKOUT_WORKERS", env_workers);
       		}
       		if (*num_workers < 1)
     + 			*num_workers = online_cpus();
      
       ## sequencer.c ##
      @@ sequencer.c: static int populate_opts_cb(const char *key, const char *value, void *data)
     @@ setup.c: static enum extension_result handle_extension(const char *var,
       		format = hash_algo_by_name(value);
       		if (format == GIT_HASH_UNKNOWN)
      -			return error("invalid value for 'extensions.objectformat'");
     -+			return error(_("invalid value for '%s': '%s'"), "extensions.objectformat", value);
     ++			return error(_("invalid value for '%s': '%s'"),
     ++				     "extensions.objectformat", value);
       		data->hash_algo = format;
       		return EXTENSION_OK;
       	}
 3:  376f8b56908 = 3:  d5ddd903df7 i18n: remove from i18n strings that do not hold translatable parts
 4:  8b0057f6180 = 4:  b8e80e178ee i18n: transfer variables into placeholders in command synopsis

-- 
gitgitgadget
