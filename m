Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADEC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 10:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiAaK5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 05:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiAaK45 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 05:56:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD6C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 02:56:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso13367190wma.1
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 02:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUsOXL9xlXDn4AGmW1NNke1sPsDD9kz7CU2MI1VXLp8=;
        b=qLZJ/mUys2bCwyhNPZRieaAoGncaL2+1BSsnBwRcsE4pZkxXbVGw/5/Ar5nHYluLXp
         lgEUle64UH6AQ0Sze+zBA0cuUcqT7cRS1c+99R+rVoghYMGbKGUZIFfSVbAizdTPiu65
         H12x37ffm0AfuiaphXMrFvPg3es+wMVDKyVK8j/3CMu2AP8DHiGiOrUPP6sVtHWPIMxK
         D+Ek0n3GsVW45zJOPfSGZnOsmpUZEiinCQDn6C44SuhXAVtXHxM8nCqYtt7s/PHl7EME
         VcDi6xlyAZL5w/wwfyaGiQIG2TYcWXyIx3TVG7ei4IAbKtnK/iRxXxQcTYRsJXB5Wu1j
         OiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUsOXL9xlXDn4AGmW1NNke1sPsDD9kz7CU2MI1VXLp8=;
        b=LIFyqTvmxFOol1kO14gHx3o3KS42FRYLANH1bZlrcOCXyhDNAaQsFa6Rb83xo+NzV3
         iQt1SGPH5PuRA69Z3A077wCU+pXaLdyU81IU18Vop6SoK4EldAsHGjGhI2kzwnm7WDwj
         xvXX6hcoilYmns2uEhfs2K/Csqu4NkGFw3eQGvwIwRFcuJUE/CpQ51PER292aHbjRtNQ
         vXfKCGjjRAHnGy9RN0M2CYq3dfGMvH811mXMMm+dt1m4rk4SaIsCEU90sqPawn/5QJ5y
         qRBEFkNok00r3dtTbtY72JHVEo+qY61etwnJ2BZgX//HJ5ywEjgCaL2RGFYl/GIrIQxc
         cBlw==
X-Gm-Message-State: AOAM532C8xFYiH5Vul+Tce/qE2EaYFivY7GnVkRoykDwCTRB1APOXwvF
        8N2ApFihuZfu9ukCA2HV8tg=
X-Google-Smtp-Source: ABdhPJx587XwGoHdBZR+p85vKK+zS5kaKmHn3HNoIM8wFjaS9Ki5RRk4TZM/IoZkZOHdx5Oy4HinZg==
X-Received: by 2002:a05:600c:2650:: with SMTP id 16mr18177534wmy.52.1643626615879;
        Mon, 31 Jan 2022 02:56:55 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id u9sm8366944wmc.11.2022.01.31.02.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 02:56:55 -0800 (PST)
Message-ID: <f50e2e2d-8b33-a403-ad94-150b065a1531@gmail.com>
Date:   Mon, 31 Jan 2022 10:56:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <aac3f9821c7f8927ab7cb65bd5c443f5a0174068.1643580113.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aac3f9821c7f8927ab7cb65bd5c443f5a0174068.1643580113.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jean-Noël

On 30/01/2022 22:01, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> Find more incompatible options to factorize.
> 
> When more than two options are mutually exclusive, print the ones
> which are actually on the command line.

I think this looks good and I'd be happy to see it go in as is with the 
blank line hunk removed. I like the way it now shows all the 
incompatible options that were on the command line, not just the first 
two. Using a function to handle the messages makes the code much nicer 
to read as well. I'm not sure that making die_for_incompatible_opt3() 
really needs to be inline or that we need _for_ in the function names 
but neither does any harm.

Best Wishes

Phillip

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>   builtin/commit.c                          | 35 ++++++++++-------------
>   builtin/difftool.c                        |  5 ++--
>   builtin/grep.c                            |  8 ++----
>   builtin/log.c                             |  5 ++--
>   builtin/merge-base.c                      |  6 ++--
>   parse-options.c                           | 34 ++++++++++++++++++++++
>   parse-options.h                           | 17 +++++++++++
>   t/t7500-commit-template-squash-signoff.sh |  2 +-
>   8 files changed, 80 insertions(+), 32 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index b9ed0374e30..33ca9e99c80 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1242,8 +1242,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   				      struct commit *current_head,
>   				      struct wt_status *s)
>   {
> -	int f = 0;
> -
>   	argc = parse_options(argc, argv, prefix, options, usage, 0);
>   	finalize_deferred_config(s);
>   
> @@ -1251,7 +1249,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		force_author = find_author_by_nickname(force_author);
>   
>   	if (force_author && renew_authorship)
> -		die(_("Using both --reset-author and --author does not make sense"));
> +		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
>   
>   	if (logfile || have_option_m || use_message)
>   		use_editor = 0;
> @@ -1268,20 +1266,16 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   			die(_("You are in the middle of a rebase -- cannot amend."));
>   	}
>   	if (fixup_message && squash_message)
> -		die(_("Options --squash and --fixup cannot be used together"));
> -	if (use_message)
> -		f++;
> -	if (edit_message)
> -		f++;
> -	if (fixup_message)
> -		f++;
> -	if (logfile)
> -		f++;
> -	if (f > 1)
> -		die(_("Only one of -c/-C/-F/--fixup can be used."));
> -	if (have_option_m && (edit_message || use_message || logfile))
> -		die((_("Option -m cannot be combined with -c/-C/-F.")));
> -	if (f || have_option_m)
> +		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> +	die_for_incompatible_opt4(!!use_message, "-C",
> +				  !!edit_message, "-c",
> +				  !!logfile, "-F",
> +				  !!fixup_message, "--fixup");
> +	die_for_incompatible_opt4(have_option_m, "-m",
> +				  !!edit_message, "-c",
> +				  !!use_message, "-C",
> +				  !!logfile, "-F");
> +	if (use_message || edit_message || logfile ||fixup_message || have_option_m)
>   		template_file = NULL;
>   	if (edit_message)
>   		use_message = edit_message;
> @@ -1306,9 +1300,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   	if (patch_interactive)
>   		interactive = 1;
>   
> -	if (also + only + all + interactive > 1)
> -		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
> -
> +	die_for_incompatible_opt4(also, "-i/--include",
> +				  only, "-o/--only",
> +				  all, "-a/--all",
> +				  interactive, "--interactive/-p/--patch");
>   	if (fixup_message) {
>   		/*
>   		 * We limit --fixup's suboptions to only alpha characters.
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index c79fbbf67e5..faa3507369a 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -732,8 +732,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>   	} else if (dir_diff)
>   		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
>   
> -	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
> +	die_for_incompatible_opt3(use_gui_tool, "--gui",
> +				  !!difftool_cmd, "--tool",
> +				  !!extcmd, "--extcmd");
>   
>   	if (use_gui_tool)
>   		setenv("GIT_MERGETOOL_GUI", "true", 1);
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9e34a820ad4..88144f06300 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1167,11 +1167,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>   	if (!show_in_pager && !opt.status_only)
>   		setup_pager();
>   
> -	if (!use_index && (untracked || cached))
> -		die(_("--cached or --untracked cannot be used with --no-index"));
> -
> -	if (untracked && cached)
> -		die(_("--untracked cannot be used with --cached"));
> +	die_for_incompatible_opt3(!use_index, "--no-index",
> +				  untracked, "--untracked",
> +				  cached, "--cached");
>   
>   	if (!use_index || untracked) {
>   		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
> diff --git a/builtin/log.c b/builtin/log.c
> index 4b493408cc5..970aa3483c4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1978,8 +1978,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	if (rev.show_notes)
>   		load_display_notes(&rev.notes_opt);
>   
> -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
> +	die_for_incompatible_opt3(use_stdout, "--stdout",
> +				  rev.diffopt.close_file, "--output",
> +				  !!output_directory, "--output-directory");
>   
>   	if (use_stdout) {
>   		setup_pager();
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index 6719ac198dc..26b84980dbd 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -159,12 +159,14 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
>   		if (argc < 2)
>   			usage_with_options(merge_base_usage, options);
>   		if (show_all)
> -			die("--is-ancestor cannot be used with --all");
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--is-ancestor", "--all");
>   		return handle_is_ancestor(argc, argv);
>   	}
>   
>   	if (cmdmode == 'r' && show_all)
> -		die("--independent cannot be used with --all");
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--independent", "--all");
>   
>   	if (cmdmode == 'o')
>   		return handle_octopus(argc, argv, show_all);
> diff --git a/parse-options.c b/parse-options.c
> index a8283037be9..276e3911a74 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1079,3 +1079,37 @@ void NORETURN usage_msg_opt(const char *msg,
>   	die_message("%s\n", msg); /* The extra \n is intentional */
>   	usage_with_options(usagestr, options);
>   }
> +
> +void die_for_incompatible_opt4(int opt1, const char *opt1_name,
> +			       int opt2, const char *opt2_name,
> +			       int opt3, const char *opt3_name,
> +			       int opt4, const char *opt4_name)
> +{
> +	int count = 0;
> +	const char *options[4];
> +
> +	if (opt1)
> +		options[count++] = opt1_name;
> +	if (opt2)
> +		options[count++] = opt2_name;
> +	if (opt3)
> +		options[count++] = opt3_name;
> +	if (opt4)
> +		options[count++] = opt4_name;
> +	switch (count) {
> +	case 4:
> +		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
> +		    opt1_name, opt2_name, opt3_name, opt4_name);
> +		break;
> +	case 3:
> +		die(_("options '%s', '%s', and '%s' cannot be used together"),
> +		    options[0], options[1], options[2]);
> +		break;
> +	case 2:
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    options[0], options[1]);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> diff --git a/parse-options.h b/parse-options.h
> index e22846d3b7b..68f7ae9c31a 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -225,6 +225,22 @@ NORETURN void usage_msg_opt(const char *msg,
>   			    const char * const *usagestr,
>   			    const struct option *options);
>   
> +void die_for_incompatible_opt4(int opt1, const char *opt1_name,
> +			       int opt2, const char *opt2_name,
> +			       int opt3, const char *opt3_name,
> +			       int opt4, const char *opt4_name);
> +
> +
> +inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
> +				      int opt2, const char *opt2_name,
> +				      int opt3, const char *opt3_name)
> +{
> +	die_for_incompatible_opt4(opt1, opt1_name,
> +				  opt2, opt2_name,
> +				  opt3, opt3_name,
> +				  0, "");
> +}
> +
>   /*
>    * Use these assertions for callbacks that expect to be called with NONEG and
>    * NOARG respectively, and do not otherwise handle the "unset" and "arg"
> @@ -339,4 +355,5 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
>   #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
>   #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
>   
> +
>   #endif
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 91964653a0b..5fcaa0b4f2a 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -442,7 +442,7 @@ test_expect_success '--fixup=reword: give error with pathsec' '
>   '
>   
>   test_expect_success '--fixup=reword: -F give error message' '
> -	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
> +	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
>   	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
>   	test_cmp expect actual
>   '

