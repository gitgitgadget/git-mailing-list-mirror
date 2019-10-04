Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1C91F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 09:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfJDJ3m (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:29:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfJDJ3l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:29:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so9154869wmc.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5/y/gCkQ70sCMX8PqfnoPRT+s2QW726tph4/n1j4QY=;
        b=l0k+Ptn+iL/I7zMdPZfE3LZc0tdIdl6mM4DzPD93oZ2vACC+41ZCFLc6deOM3i5sSr
         H1H4LEo9QPT7dJE/Z0Dh0GxtzvQJMiJZvCd2IEht01sMTqhuxRg8gBrHELfIXcWsXNFp
         wHd7m3Tlo3yv4updP+FP1DLxMaAbNQRYWD0yMJcALIcLePqZn24W6RXCdJxDcf3aww7R
         53CmdAmj+gRypCwWEgdvdJlGlPkKLYITPq2e6f7nSwUkrR+xmFlfljoAVKUf/jf+Fzy8
         s4wA699nj328KpYLWMQ0jf1WSiwu5vxY/SnsV6Pl2bTduHfUtrjhCCXyDscf7aoxvxwp
         NMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x5/y/gCkQ70sCMX8PqfnoPRT+s2QW726tph4/n1j4QY=;
        b=ZfrmUuDHT6W3qpn+/drUnzmb98oX8PRgVs5HPl7emkn7ExnjQ/Zgbsxuzq/7Xsyu3S
         7TbH5449yVNxQ9VYYbjhruUuyj8A4vDGE15sZWQ1vaYeI4gNmpOlJq/ZdZdjLCCHA3ur
         6B6R7H9NZpLIYP0+KW2erdOkjaxN8hbSxCMNCYOpy7fH0HDOOTTm6ciTqPHe3itc5jHm
         P53EyOzX92kxCjciyhw2tDNOQQCxBtIC6eUll6nPmhwD2Tz6UJbuc3GQytJJK2qRUJ6J
         zb0NcyJB0Iy8BnBxIowMFt+PNLbqUxhk6rcnyvT3asMaxvP/vnWnoZRoa70gYjPzA+uT
         O/UA==
X-Gm-Message-State: APjAAAVpg6mqKu/4+ilXgtNYI/8KMiLmem4ViAg42mDPyAOZj/q959WU
        HLwhPNYp0l7tpT0rmDtNcY3bObNa
X-Google-Smtp-Source: APXvYqyW9qw9MSjxEe78BpjLbxLCaOgttbkOrtvF3hrdy8S+cQlyPj5znt40h0GEWnf/fYUdLNmZdg==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr9822513wmk.20.1570181378736;
        Fri, 04 Oct 2019 02:29:38 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id a7sm10769167wra.43.2019.10.04.02.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 02:29:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/6] rebase -i: add --ignore-whitespace flag
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-2-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9e311cef-1f9d-4146-c2a7-c8179cdcdaf1@gmail.com>
Date:   Fri, 4 Oct 2019 10:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190907115034.14933-2-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 07/09/2019 12:50, Rohit Ashiwal wrote:
> There are two backends available for rebasing, viz, the am and the
> interactive. Naturally, there shall be some features that are
> implemented in one but not in the other. One such flag is
> --ignore-whitespace which indicates merge mechanism to treat lines
> with only whitespace changes as unchanged. Wire the interactive
> rebase to also understand the --ignore-whitespace flag by
> translating it to -Xignore-space-change.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   Documentation/git-rebase.txt            | 13 ++++-
>   builtin/rebase.c                        | 22 +++++++--
>   t/t3422-rebase-incompatible-options.sh  |  1 -
>   t/t3433-rebase-options-compatibility.sh | 65 +++++++++++++++++++++++++
>   4 files changed, 94 insertions(+), 7 deletions(-)
>   create mode 100755 t/t3433-rebase-options-compatibility.sh
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6156609cf7..873eb5768c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -371,8 +371,16 @@ If either <upstream> or --root is given on the command line, then the
>   default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   
>   --ignore-whitespace::
> +	Behaves differently depending on which backend is selected.
> ++
> +'am' backend: When applying a patch, ignore changes in whitespace in
> +context lines if necessary.
> ++
> +'interactive' backend: Treat lines with only whitespace changes as
> +unchanged for the sake of a three-way merge.
> +
>   --whitespace=<option>::
> -	These flag are passed to the 'git apply' program
> +	This flag is passed to the 'git apply' program
>   	(see linkgit:git-apply[1]) that applies the patch.
>   +
>   See also INCOMPATIBLE OPTIONS below.
> @@ -520,7 +528,6 @@ The following options:
>    * --committer-date-is-author-date
>    * --ignore-date
>    * --whitespace
> - * --ignore-whitespace
>    * -C
>   
>   are incompatible with the following options:
> @@ -543,6 +550,8 @@ In addition, the following pairs of options are incompatible:
>    * --preserve-merges and --interactive
>    * --preserve-merges and --signoff
>    * --preserve-merges and --rebase-merges
> + * --preserve-merges and --ignore-whitespace
> + * --rebase-merges and --ignore-whitespace
>    * --rebase-merges and --strategy
>    * --rebase-merges and --strategy-option
>   
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c065..f8a618d54c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -79,6 +79,7 @@ struct rebase_options {
>   	int allow_rerere_autoupdate;
>   	int keep_empty;
>   	int autosquash;
> +	int ignore_whitespace;
>   	char *gpg_sign_opt;
>   	int autostash;
>   	char *cmd;
> @@ -99,6 +100,7 @@ struct rebase_options {
>   
>   static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   {
> +	struct strbuf strategy_buf = STRBUF_INIT;
>   	struct replay_opts replay = REPLAY_OPTS_INIT;
>   
>   	replay.action = REPLAY_INTERACTIVE_REBASE;
> @@ -114,9 +116,15 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>   	replay.strategy = opts->strategy;
> +
>   	if (opts->strategy_opts)
> -		parse_strategy_opts(&replay, opts->strategy_opts);
> +		strbuf_addstr(&strategy_buf, opts->strategy_opts);
> +	if (opts->ignore_whitespace)
> +		strbuf_addstr(&strategy_buf, " --ignore-space-change");
> +	if (strategy_buf.len)
> +		parse_strategy_opts(&replay, strategy_buf.buf);
>   
> +	strbuf_release(&strategy_buf);
>   	return replay;
>   }
>   
> @@ -511,6 +519,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   	argc = parse_options(argc, argv, prefix, options,
>   			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>   
> +	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
> +
>   	if (!is_null_oid(&squash_onto))
>   		opts.squash_onto = &squash_onto;
>   
> @@ -964,6 +974,8 @@ static int run_am(struct rebase_options *opts)
>   	am.git_cmd = 1;
>   	argv_array_push(&am.args, "am");
>   
> +	if (opts->ignore_whitespace)
> +		argv_array_push(&am.args, "--ignore-whitespace");
>   	if (opts->action && !strcmp("continue", opts->action)) {
>   		argv_array_push(&am.args, "--resolved");
>   		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1407,9 +1419,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> -				  NULL, N_("passed to 'git am'"),
> -				  PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>   				  &options.git_am_opts, NULL,
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> @@ -1417,6 +1426,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>   				  N_("passed to 'git apply'"), 0),
> +		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> +			 N_("ignore changes in whitespace")),
>   		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>   				  N_("action"), N_("passed to 'git apply'"), 0),
>   		OPT_BIT('f', "force-rebase", &options.flags,
> @@ -1834,6 +1845,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (options.rebase_merges) {
> +		if (options.ignore_whitespace)
> +			die(_("cannot combine '--rebase-merges' with "
> +			      "'--ignore-whitespace'"));

--rebase-merges now supports --strategy_option so we should fix this.

>   		if (strategy_options.nr)
>   			die(_("cannot combine '--rebase-merges' with "
>   			      "'--strategy-option'"));
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index a5868ea152..4342f79eea 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>   }
>   
>   test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --ignore-whitespace
>   test_rebase_am_only --committer-date-is-author-date
>   test_rebase_am_only -C4
>   
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> new file mode 100755
> index 0000000000..2e16e00a9d
> --- /dev/null
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Rohit Ashiwal
> +#
> +
> +test_description='tests to ensure compatibility between am and interactive backends'
> +
> +. ./test-lib.sh
> +
> +# This is a special case in which both am and interactive backends
> +# provide the same output. 

I'm still concerned that we have to construct a special test case to get 
both backends to generate the same output. If this series is about 
supporting the behavior of the am backend in the sequencer then I'm 
worried that having the same option name have two different behaviors 
will create more problems than it solves. Do you have a feeling for how 
often the two backends give different results?

Best Wishes

Phillip

It was done intentionally because
> +# both the backends fall short of optimal behaviour.
> +test_expect_success 'setup' '
> +	git checkout -b topic &&
> +	q_to_tab >file <<-\EOF &&
> +	line 1
> +	Qline 2
> +	line 3
> +	EOF
> +	git add file &&
> +	git commit -m "add file" &&
> +	cat >file <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	git commit -am "update file" &&
> +	git tag side &&
> +
> +	git checkout --orphan master &&
> +	sed -e "s/^|//" >file <<-\EOF &&
> +	|line 1
> +	|        line 2
> +	|line 3
> +	EOF
> +	git add file &&
> +	git commit -m "add file" &&
> +	git tag main
> +'
> +
> +test_expect_success '--ignore-whitespace works with am backend' '
> +	cat >expect <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	test_must_fail git rebase main side &&
> +	git rebase --abort &&
> +	git rebase --ignore-whitespace main side &&
> +	test_cmp expect file
> +'
> +
> +test_expect_success '--ignore-whitespace works with interactive backend' '
> +	cat >expect <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	test_must_fail git rebase --merge main side &&
> +	git rebase --abort &&
> +	git rebase --merge --ignore-whitespace main side &&
> +	test_cmp expect file
> +'
> +
> +test_done
> 
