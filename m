Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E8C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 11:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiAXLGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiAXLGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 06:06:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E122C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:06:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so12811469wrg.11
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OyDWdq7RaJbklvaaLW0cDmYyNh3jalkiqJS07Ihu4h0=;
        b=JiM0L03eJ43lgXDnuit0OFJoyBR1VYf+9rpOjkJHc46qsr5ZZz/rEWaF0ROuE5fKlc
         YKh7H7qIKgADRBuDjbi5RE4gvX9cXPmdYyL+C79U+yxpnZGyNSoYU59kqWFHmEoXLs7s
         BDTtHwXUvDi/qXN0N1C6Fm+bkMnOWG5jIoWflkg6buWfkbD3rvajK/2iv/C+jJB1Harm
         z1BjlQH/R5EwqUkvcGqkOcymS4M37ihkO0eHSz5OVYLDmtR/tq3r+/dfNRhDOPuh0whi
         PnR3RhtIDXv/K+yx8zd0c9gFWE7rIvE9vhN3MxcwV0v2iR0xIKPinPnyFjQKWetKnnsB
         SVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OyDWdq7RaJbklvaaLW0cDmYyNh3jalkiqJS07Ihu4h0=;
        b=QLipolsh0xGBYUOGdO0WWPlWehuIvCfo5y8VVuksjvofTx8h9rzDecnWWwomYBjCK9
         x5ql9Y4VyvwL+BI/KVt9xYtuWVCu/leKxQaxBg4yKklI05Kio4pV3ZqxomZxsamO4TCa
         lL7sc3tfzvj5HdOouzDwoXD0eUCoNyz7bWzo43mu01ogkeKp79UA7h5b+FYMBjTBCVo8
         G758nSAi9XHTojicUbxWAGlQUTJLA81dgt7GcvXl+1+LEEjpDoOirxct6aguBashnFss
         B6eo8twwNNI16qL/uKM1OBAmyFlmnjSwtYy1mDbM3Pge1k/CDtl3aWG3XH8+HPr4Lbei
         Jw7A==
X-Gm-Message-State: AOAM533i2efaAOuWd6gMYddb7S1Lo3ziDhpwkdKV7Y0/GpshgDy4EXpA
        NjASurbhwY8SYgw1qL7ZMfw=
X-Google-Smtp-Source: ABdhPJzXDOTTCr6a8S9FmHkm/PoN/HDuc6lvXMiYoANgzclwtdE0RZPClw6XEZudaZX0mtDNvBkY8Q==
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr1272295wry.190.1643022380721;
        Mon, 24 Jan 2022 03:06:20 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id q3sm13372370wrs.56.2022.01.24.03.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 03:06:20 -0800 (PST)
Message-ID: <80593381-2ecc-5de5-76b7-0e6c6452559f@gmail.com>
Date:   Mon, 24 Jan 2022 11:06:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] i18n: factorize more 'incompatible options' messages
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <81ff928567fdf274000c660fb791641fc2ceccc9.1642876553.git.gitgitgadget@gmail.com>
 <ba203623-87b1-f3eb-9498-52c4ea4ba07e@kdbg.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ba203623-87b1-f3eb-9498-52c4ea4ba07e@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/01/2022 07:14, Johannes Sixt wrote:
> Am 22.01.22 um 19:35 schrieb Jean-Noël Avila via GitGitGadget:
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> When more than two options are mutually exclusive, print the ones
>> which are actually on the command line.
> 
> Reading this, I expect that all mutually exclusive options are listed in
> the error messages. But the updated code lists only the first and second
> option even if more are on the command line. What is the justification
> for that? Just "make the work for translators easier"? I am not 100%
> sure that this is the right balance. Wouldn't it be helpful for users to
> get to know which set of options is incompatible, or is an error message
> not the right place for this kind of education? Don't know...

That was my feeling as well when reading this patch, I think the loss of 
information in the error messages is a shame.

>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>   builtin/commit.c                          | 39 ++++++++++++++---------
>>   builtin/difftool.c                        | 18 +++++++++--
>>   builtin/grep.c                            |  4 +--
>>   builtin/log.c                             | 20 ++++++++++--
>>   builtin/merge-base.c                      |  4 +--
>>   t/t7500-commit-template-squash-signoff.sh |  2 +-
>>   6 files changed, 63 insertions(+), 24 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index b9ed0374e30..910f4c912bf 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1243,6 +1243,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>   				      struct wt_status *s)
>>   {
>>   	int f = 0;
>> +	char * f_options[4];
>>   
>>   	argc = parse_options(argc, argv, prefix, options, usage, 0);
>>   	finalize_deferred_config(s);
>> @@ -1251,7 +1252,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>   		force_author = find_author_by_nickname(force_author);
>>   
>>   	if (force_author && renew_authorship)
>> -		die(_("Using both --reset-author and --author does not make sense"));
>> +		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
>>   
>>   	if (logfile || have_option_m || use_message)
>>   		use_editor = 0;
>> @@ -1268,19 +1269,19 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>   			die(_("You are in the middle of a rebase -- cannot amend."));
>>   	}
>>   	if (fixup_message && squash_message)
>> -		die(_("Options --squash and --fixup cannot be used together"));
>> -	if (use_message)
>> -		f++;
>> -	if (edit_message)
>> -		f++;
>> -	if (fixup_message)
>> -		f++;
>> -	if (logfile)
>> -		f++;
>> +		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
>> +	f_options[f] = "-C";
>> +	f+=	!!use_message;
>> +	f_options[f] = "-c";
>> +	f+=!!edit_message;
>> +	f_options[f] = "-F";
>> +	f+=!!logfile;
>> +	f_options[f] = "--fixup";
>> +	f+=!!fixup_message;

This feels like an out of bounds access waiting to happen when someone 
adds a new option but forgets to increase the size of f_options above

Best Wishes

Phillip

> The format style violations are quite obvious here. But see below for a
> suggestion to write this differently.
> 
>>   	if (f > 1)
>> -		die(_("Only one of -c/-C/-F/--fixup can be used."));
>> +		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
>>   	if (have_option_m && (edit_message || use_message || logfile))
>> -		die((_("Option -m cannot be combined with -c/-C/-F.")));
>> +		die(_("options '%s' and '%s' cannot be used together"), "-m", f_options[0]);
>>   	if (f || have_option_m)
>>   		template_file = NULL;
>>   	if (edit_message)
>> @@ -1305,9 +1306,17 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>   
>>   	if (patch_interactive)
>>   		interactive = 1;
>> -
>> -	if (also + only + all + interactive > 1)
>> -		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
>> +	f = 0;
>> +	f_options[f] = "-i/--include";
>> +	f += also;
>> +	f_options[f] = "-o/--only";
>> +	f += only;
>> +	f_options[f] = "-a/--all";
>> +	f += all;
>> +	f_options[f] = "--interactive/-p/--patch";
> 
> Interesting. -p and --interactive do different things, but can be used
> together (-p overrides --interactive). The original error message
> suggests that this is not the case. Just a marginal note...
> 
>> +	f += interactive;
>> +	if (f > 1)
>> +		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
>>   
>>   	if (fixup_message) {
>>   		/*
>> diff --git a/builtin/difftool.c b/builtin/difftool.c
>> index c79fbbf67e5..92854bc7737 100644
>> --- a/builtin/difftool.c
>> +++ b/builtin/difftool.c
>> @@ -685,6 +685,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>>   	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
>>   	    tool_help = 0, no_index = 0;
>>   	static char *difftool_cmd = NULL, *extcmd = NULL;
>> +	int f = 0;
>> +	char *f_options[3];
>>   	struct option builtin_difftool_options[] = {
>>   		OPT_BOOL('g', "gui", &use_gui_tool,
>>   			 N_("use `diff.guitool` instead of `diff.tool`")),
>> @@ -732,8 +734,20 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>>   	} else if (dir_diff)
>>   		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
>>   
>> -	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
>> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
>> +	if (use_gui_tool) {
>> +		f_options[f] = "--gui";
>> +		f++;
>> +	}
>> +	if (difftool_cmd) {
>> +		f_options[f] = "--tool";
>> +		f++;
>> +	}
>> +	if (extcmd) {
>> +		f_options[f] = "--extcmd";
>> +		f++;
>> +	}
>> +	if (f > 1)
>> +		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
> 
> I prefer this if-cascade over the "f += truth_value" style, because I
> find it is easier to understand. If you write it as
> 
> 	if (extcmd)
> 		f_options[f++] = "--extcmd";
> 
> you get each branch down to two lines. (But then others may disagree
> with the easy-to-understand argument due to the f++ buried in the
> expression. Unsure...)
> 
>>   
>>   	if (use_gui_tool)
>>   		setenv("GIT_MERGETOOL_GUI", "true", 1);
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 9e34a820ad4..b199781cb27 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -1168,10 +1168,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>   		setup_pager();
>>   
>>   	if (!use_index && (untracked || cached))
>> -		die(_("--cached or --untracked cannot be used with --no-index"));
>> +		die(_("options '%s' and '%s' cannot be used together"),"--cached/--untracked", "--no-index");
> 
> Huh? "--cached/--untracked"? Which one was used on the command line? But...
> 
>>   
>>   	if (untracked && cached)
>> -		die(_("--untracked cannot be used with --cached"));
>> +		die(_("options '%s' and '%s' cannot be used together"), "--untracked", "--cached");
>>   
>>   	if (!use_index || untracked) {
>>   		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
> 
> ... doesn't this logic imply that --cached, --untracked, and --no-index
> are three mutually exclusive options?
> 
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 4b493408cc5..59b4a2fd380 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1759,6 +1759,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>   	struct strbuf rdiff_title = STRBUF_INIT;
>>   	int creation_factor = -1;
>>   
>> +	int f = 0;
>> +	char * f_options[4];
>> +
> 
> Style: char *f_options[4]; don't needlessly separate these new variables
> from the others by an empty line.
> 
>>   	const struct option builtin_format_patch_options[] = {
>>   		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
>>   			    N_("use [PATCH n/m] even with a single patch"),
>> @@ -1978,8 +1981,21 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>   	if (rev.show_notes)
>>   		load_display_notes(&rev.notes_opt);
>>   
>> -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
>> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
>> +	if (use_stdout) {
>> +		f_options[f] = "--stdout";
>> +		f++;
>> +	}
>> +	if (rev.diffopt.close_file) {
>> +		f_options[f] = "--output";
>> +		f++;
>> +	}
>> +	if (output_directory) {
>> +		f_options[f] = "--output-directory";
>> +		f++;
>> +	}
>> +
>> +	if (f > 1)
>> +		die(_("options '%s'and '%s' cannot be used together"), f_options[0], f_options[1]);
>>   
>>   	if (use_stdout) {
>>   		setup_pager();
>> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
>> index 6719ac198dc..1447f1c493a 100644
>> --- a/builtin/merge-base.c
>> +++ b/builtin/merge-base.c
>> @@ -159,12 +159,12 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
>>   		if (argc < 2)
>>   			usage_with_options(merge_base_usage, options);
>>   		if (show_all)
>> -			die("--is-ancestor cannot be used with --all");
>> +			die(_("options '%s' and '%s' cannot be used together"),"--is-ancestor", "--all");
>>   		return handle_is_ancestor(argc, argv);
>>   	}
>>   
>>   	if (cmdmode == 'r' && show_all)
>> -		die("--independent cannot be used with --all");
>> +		die(_("options '%s' and '%s' cannot be used together"),"--independent", "--all");
>>   
>>   	if (cmdmode == 'o')
>>   		return handle_octopus(argc, argv, show_all);
>> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
>> index 91964653a0b..5fcaa0b4f2a 100755
>> --- a/t/t7500-commit-template-squash-signoff.sh
>> +++ b/t/t7500-commit-template-squash-signoff.sh
>> @@ -442,7 +442,7 @@ test_expect_success '--fixup=reword: give error with pathsec' '
>>   '
>>   
>>   test_expect_success '--fixup=reword: -F give error message' '
>> -	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
>> +	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
>>   	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
>>   	test_cmp expect actual
>>   '
> 
> A general comment: To me, it looks like you didn't want to change the
> variable name 'f' in the first hunk above, and then just named the array
> 'f_options' to go with 'f'. Perhaps `exclusive_opt` (not plural!) for
> the array. Now, renaming 'f' to something longer makes the code a bit
> unwieldy. Therefore, let me suggest yet another approach: factor out
> functions check_exclusive_opts3(), check_exclusive_opts4(), to be used like
> 
> 	check_exclusive_opts3(use_stdout, "--stdout",
> 		rev.diffopt.close_file, "--output",
> 		output_directory, "--output-directory");
> 
> I am not yet proposing check_exclusive_opts2(), but others may think it
> is an improvement, too, (if they think that such functions are an
> improvement in the first place).
> 
> -- Hannes

