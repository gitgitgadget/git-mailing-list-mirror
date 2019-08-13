Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4D21F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfHMMHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:07:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40789 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfHMMHS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:07:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so8425376wrl.7
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TBXForsl40VrNZ3Rg+EQ3DKi0Wwu7HBN6IBzpD+khFo=;
        b=oymEkbk2wcQDBF3+dak21Wzkppw65OXIw8tAlyfA1XAWJSULmq0XdrqzYwScVkgZWn
         ARSDXTugH+ML2T961ybbqGVTeCrGhskpyuHnCfDSnIwoGNhUNzGiQ9cQuRRwjonaezNF
         Qw0dU9fWK2nQJ1OYy0pcVo2b3ipmQR7R0IJGZuTUJrL1mKkBUpm+ARPuZlP3fSt4XjBI
         /WpKcI/kmjTc4tCFhUE2pkaWEVZ5KO4dpjnyHlbMs20GtOMw901PL9CAnYXPg7Fo2XRG
         Wr8/dquTUjfhXxDQdYVP1RXnKA9YJY9Qb3JCoBohDEZDyoac9/I9Gk/05JkwNxEMydC0
         0Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBXForsl40VrNZ3Rg+EQ3DKi0Wwu7HBN6IBzpD+khFo=;
        b=m0MlSpTSa7stVTBe1f0fXghLj/Gp20Bv7QmcmQb57jFH8DS4VLmgVFn0ABv4LEPjS/
         GS9QCrfJ9+qW93DT9mke6eKifuf07JmMYYBG+CsIg34cT+XPKuQ3Cs+SWI/u3/uriLsB
         B/qjRrwWA7eC5o1KHaErVtQsC9FB7c+PkiEa3AtiUMIXEhXxsE3P+WyF0eXblCjnp28j
         946aRynx4i8BkIvhNwLQtYH2LrPEr8HWyGm5tm4vYhK7rCRT0d4xCPILhxKdBIX2GmxF
         XDa9ocwFcNBeL8+zdMXfsBPVWkYTh/WwYud+vVQBLbkxxk8IKtawxmELK6EvE2OEeyJs
         zpJw==
X-Gm-Message-State: APjAAAVdVK+29L+5Vn1bo1LjNBKwwrn4i2eqqsnj9IaOreaCq4/NSPT3
        CNtYxDd6Uowiasf5lrkAGTo=
X-Google-Smtp-Source: APXvYqx5A3lS28zLCrgkJT+rySOLVZMSjoCzZJUZH6AubVjaUB1kj0B3WL/iJOpSC5890OLQRUR0zw==
X-Received: by 2002:adf:e602:: with SMTP id p2mr46782751wrm.306.1565698033954;
        Tue, 13 Aug 2019 05:07:13 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id b2sm16590700wrf.94.2019.08.13.05.07.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 05:07:12 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 1/6] rebase -i: add --ignore-whitespace flag
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-2-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a505fdf3-5926-9765-21ef-b82334a3fba4@gmail.com>
Date:   Tue, 13 Aug 2019 13:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812194301.5655-2-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

Thanks for the re-roll

On 12/08/2019 20:42, Rohit Ashiwal wrote:
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
>   Documentation/git-rebase.txt            | 10 +++-
>   builtin/rebase.c                        | 29 +++++++++--
>   t/t3422-rebase-incompatible-options.sh  |  1 -
>   t/t3433-rebase-options-compatibility.sh | 65 +++++++++++++++++++++++++
>   4 files changed, 97 insertions(+), 8 deletions(-)
>   create mode 100755 t/t3433-rebase-options-compatibility.sh
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6156609cf7..28e5e08a83 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -371,8 +371,13 @@ If either <upstream> or --root is given on the command line, then the
>   default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   
>   --ignore-whitespace::
> +	This flag is either passed to the 'git apply' program
> +	(see linkgit:git-apply[1]), or to 'git merge' program
> +	(see linkgit:git-merge[1]) as `-Xignore-space-change`,
> +	depending on which backend is selected by other options.

I still think this should document what it does rather than how it is 
implemented - see my previous comments.
> +
>   --whitespace=<option>::
> -	These flag are passed to the 'git apply' program
> +	This flag is passed to the 'git apply' program
>   	(see linkgit:git-apply[1]) that applies the patch.
>   +
>   See also INCOMPATIBLE OPTIONS below.
> @@ -520,7 +525,6 @@ The following options:
>    * --committer-date-is-author-date
>    * --ignore-date
>    * --whitespace
> - * --ignore-whitespace
>    * -C
>   
>   are incompatible with the following options:
> @@ -543,6 +547,8 @@ In addition, the following pairs of options are incompatible:
>    * --preserve-merges and --interactive
>    * --preserve-merges and --signoff
>    * --preserve-merges and --rebase-merges
> + * --preserve-merges and --ignore-whitespace
> + * --rebase-merges and --ignore-whitespace
>    * --rebase-merges and --strategy
>    * --rebase-merges and --strategy-option
>   
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c065..ab1bbb78ee 100644
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
> +	char *strategy_opts = opts->strategy_opts;

strategy_opts is a shallow copy of opts->strategy_opts - this will cause 
problems later

>   	struct replay_opts replay = REPLAY_OPTS_INIT;
>   
>   	replay.action = REPLAY_INTERACTIVE_REBASE;
> @@ -114,8 +116,19 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>   	replay.strategy = opts->strategy;
> -	if (opts->strategy_opts)
> -		parse_strategy_opts(&replay, opts->strategy_opts);
> +
> +	if (opts->ignore_whitespace) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (strategy_opts)
> +			strbuf_addstr(&buf, strategy_opts);

I'd rewrite this as
	if (opts->strategy_opts)
		strbuf_addstr(&buf, opts->strategy_opts);

without the outer if testing opts->ignore_whitespace
> +
then add
	if (opts->ignore_whitespace)
here
> +		strbuf_addstr(&buf, " --ignore-space-change");
> +		free(strategy_opts);

and then you don't need this free() or strategy_opts. At the moment this 
has freed opts->stragety_opts which is what we were trying to avoid, in 
fact it's slightly worse than the last version because we don't change 
opts->strategy_opts to reflect the fact it has been freed. Also the 
caller cannot know if it has been freed as it depends what other options 
are set.

> +		strategy_opts = strbuf_detach(&buf, NULL);
> +	}
> +	if (strategy_opts)
> +		parse_strategy_opts(&replay, strategy_opts);

replace this withe
	if (buf.len)
		parse_strategy_opts(&replay, buf.buf);
	strbuf_release(&buf);

This way we never change opts->strategy_opts and we always release the 
temporary copy.

Best Wishes

Phillip

>   
>   	return replay;
>   }
> @@ -511,6 +524,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   	argc = parse_options(argc, argv, prefix, options,
>   			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>   
> +	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
> +
>   	if (!is_null_oid(&squash_onto))
>   		opts.squash_onto = &squash_onto;
>   
> @@ -964,6 +979,8 @@ static int run_am(struct rebase_options *opts)
>   	am.git_cmd = 1;
>   	argv_array_push(&am.args, "am");
>   
> +	if (opts->ignore_whitespace)
> +		argv_array_push(&am.args, "--ignore-whitespace");
>   	if (opts->action && !strcmp("continue", opts->action)) {
>   		argv_array_push(&am.args, "--resolved");
>   		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1407,9 +1424,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> -				  NULL, N_("passed to 'git am'"),
> -				  PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>   				  &options.git_am_opts, NULL,
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> @@ -1417,6 +1431,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>   				  N_("passed to 'git apply'"), 0),
> +		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> +			 N_("ignore changes in whitespace")),
>   		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>   				  N_("action"), N_("passed to 'git apply'"), 0),
>   		OPT_BIT('f', "force-rebase", &options.flags,
> @@ -1834,6 +1850,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (options.rebase_merges) {
> +		if (options.ignore_whitespace)
> +			die(_("cannot combine '--rebase-merges' with "
> +			      "'--ignore-whitespace'"));
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
> +# provide the same output. It was done intentionally because
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
