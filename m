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
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A851F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 09:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405309AbfJRJqq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 05:46:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404742AbfJRJqq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 05:46:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so5451581wma.5
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k1znC7pKIXqIbg0Xlb7A+XmRD1pph7wmAYnlK2TOxx4=;
        b=d8vaSGGmElNQFyXD4ulPoo9mnX7h65NVviVILfb93bluDidwUAHlImLViTsvlReaiF
         cyAe5MNkVpIo7G00nJiKK65FE2FoJkoTKs7q4dB//dzXSb0elgjhMrRuXlo6/pefA57j
         tfu8IK9iU5DRJbvDNRs0Y1L0V+57A2k0yAGdK9ma3nI4ilul6NxWbi7zbux2O6LlQJko
         UD4yAGwG+wOqpIgYj4A24bRoCOcBVi6bueBi9U1LDXg5S8TZvhl8zot9bqaKx9PJrH4U
         H3nTGFyttL3AVeX8Lo0PiIcGaKM1u1tng1hAYRiVCapAvy8zTH5PuGM7xePSUOVmhzNP
         Jfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k1znC7pKIXqIbg0Xlb7A+XmRD1pph7wmAYnlK2TOxx4=;
        b=hwC5Ht/SZHlRzw5BSoJv/wSkMmAwr+k1H/8bBwDAXYoSq/sGcJsVVJNgcmBm/q7Sap
         OvvZYUWFif5kGof4PpF/p83qsL8tDsD3/i1lkaH8QusUM7EqgnP1de9yCr5aqDzJjzs9
         u2US0lWiaNN9TjwbFWy1WZd6q4i2VBIlhgRf9GL1FnVEwj4BxZfEwj3GeV6AxgXmnV04
         ++HFl96GYpLeGBG2XqxAQDj6h9GpNq6r0mAS94Zv24RnKbjWVel6hBW9yn+wLQnyq2yw
         l96/JLzNKnFs4TRBjzhVdXa/ILMguc/FubWxFHg4uc6O2a2rgEx0FpQxj28bgjXDMYzX
         TXiQ==
X-Gm-Message-State: APjAAAXF3aCGhVaLxVtoDGbvhFPJmSO7JHK3GqbInh4nVJpvuMc8e3Kp
        OkqGDibkQ7HEYzvp/2DXkrxXCcGU
X-Google-Smtp-Source: APXvYqzEVo49si/dLWIenJGZItwmYT8xUDs6J53I17NlM334fDxSsrp43j8X/bE8jqDCA6eP8xywuQ==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr6752564wmb.12.1571391999246;
        Fri, 18 Oct 2019 02:46:39 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id y3sm9160063wro.36.2019.10.18.02.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:46:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 7/7] merge: teach --autostash option
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4a47c27f-2c6a-0bd6-eac8-533700087af9@gmail.com>
Date:   Fri, 18 Oct 2019 10:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 16/10/2019 18:26, Denton Liu wrote:
> In rebase, one can pass the `--autostash` option to cause the worktree
> to be automatically stashed before continuing with the rebase. This
> option is missing in merge, however.

It might be helpful to say why this option is useful. I can see one 
might want to stash before doing `git pull` in the same way as one might 
before a rebase but what's the motivation for doing it before a normal 
merge?

> 
> Implement the `--autostash` option and corresponding `merge.autoStash`
> option in merge which stashes before merging and then pops after.
> 
> Reported-by: Alban Gruin <alban.gruin@gmail.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/merge.c | 13 +++++++++++++
>   builtin/pull.c  |  9 +++++----
>   t/t5520-pull.sh |  8 --------
>   3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 062e911441..d1a5eaad0d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -40,6 +40,7 @@
>   #include "branch.h"
>   #include "commit-reach.h"
>   #include "wt-status.h"
> +#include "autostash.h"
>   
>   #define DEFAULT_TWOHEAD (1<<0)
>   #define DEFAULT_OCTOPUS (1<<1)
> @@ -58,6 +59,8 @@ static const char * const builtin_merge_usage[] = {
>   	NULL
>   };
>   
> +static GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
> +
>   static int show_diffstat = 1, shortlog_len = -1, squash;
>   static int option_commit = -1;
>   static int option_edit = -1;
> @@ -81,6 +84,7 @@ static int show_progress = -1;
>   static int default_to_upstream = 1;
>   static int signoff;
>   static const char *sign_commit;
> +static int autostash;
>   static int no_verify;
>   
>   static struct strategy all_strategy[] = {
> @@ -285,6 +289,8 @@ static struct option builtin_merge_options[] = {
>   	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
>   	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>   	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +	OPT_BOOL(0, "autostash", &autostash,
> +	      N_("automatically stash/stash pop before and after")),
>   	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
>   	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>   	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
> @@ -440,6 +446,7 @@ static void finish(struct commit *head_commit,
>   		strbuf_addf(&reflog_message, "%s: %s",
>   			getenv("GIT_REFLOG_ACTION"), msg);
>   	}
> +	apply_autostash(merge_autostash());
>   	if (squash) {
>   		squash_message(head_commit, remoteheads);
>   	} else {
> @@ -631,6 +638,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>   	} else if (!strcmp(k, "commit.gpgsign")) {
>   		sign_commit = git_config_bool(k, v) ? "" : NULL;
>   		return 0;
> +	} else if (!strcmp(k, "merge.autostash")) {
> +		autostash = git_config_bool(k, v);
> +		return 0;
>   	}
>   
>   	status = fmt_merge_msg_config(k, v, cb);
> @@ -724,6 +734,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>   		for (j = common; j; j = j->next)
>   			commit_list_insert(j->item, &reversed);
>   
> +		if (autostash)
> +			perform_autostash(merge_autostash());
>   		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>   		clean = merge_recursive(&o, head,
>   				remoteheads->item, reversed, &result);
> @@ -1288,6 +1300,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   
>   		/* Invoke 'git reset --merge' */
>   		ret = cmd_reset(nargc, nargv, prefix);
> +		apply_autostash(merge_autostash());
>   		goto done;
>   	}
>   
> diff --git a/builtin/pull.c b/builtin/pull.c
> index d25ff13a60..ee186781ae 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -183,7 +183,7 @@ static struct option pull_options[] = {
>   		N_("verify that the named commit has a valid GPG signature"),
>   		PARSE_OPT_NOARG),
>   	OPT_BOOL(0, "autostash", &opt_autostash,
> -		N_("automatically stash/stash pop before and after rebase")),
> +		N_("automatically stash/stash pop before and after")),

I've not looked closely at the code in this patch but noticed this. I 
think it would read better if it said

     automatically stash/stash pop before and after pulling

Best Wishes

Phillip

>   	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
>   		N_("merge strategy to use"),
>   		0),
> @@ -671,6 +671,10 @@ static int run_merge(void)
>   	argv_array_pushv(&args, opt_strategy_opts.argv);
>   	if (opt_gpg_sign)
>   		argv_array_push(&args, opt_gpg_sign);
> +	if (opt_autostash == 0)
> +		argv_array_push(&args, "--no-autostash");
> +	else if (opt_autostash == 1)
> +		argv_array_push(&args, "--autostash");
>   	if (opt_allow_unrelated_histories > 0)
>   		argv_array_push(&args, "--allow-unrelated-histories");
>   
> @@ -918,9 +922,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>   	if (get_oid("HEAD", &orig_head))
>   		oidclr(&orig_head);
>   
> -	if (!opt_rebase && opt_autostash != -1)
> -		die(_("--[no-]autostash option is only valid with --rebase."));
> -
>   	autostash = config_autostash;
>   	if (opt_rebase) {
>   		if (opt_autostash != -1)
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index cf4cc32fd0..75f162495a 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -365,14 +365,6 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
>   	test_pull_autostash_fail --rebase --no-autostash
>   '
>   
> -for i in --autostash --no-autostash
> -do
> -	test_expect_success "pull $i (without --rebase) is illegal" '
> -		test_must_fail git pull $i . copy 2>err &&
> -		test_i18ngrep "only valid with --rebase" err
> -	'
> -done
> -
>   test_expect_success 'pull.rebase' '
>   	git reset --hard before-rebase &&
>   	test_config pull.rebase true &&
> 
