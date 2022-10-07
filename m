Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE611C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJGJvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJGJvY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:51:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAF7A2236
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:51:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b7so6458699wrq.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XwMSftwFA/y9bRSb+Oei8zcSAAlSvFrVQdDNQWyv5cI=;
        b=EK895GmnTiqbTmJpinQ2WuyJSg4YyhWsz263fdurJ2IuxGf5mpw3ipPpRhWusAEbP6
         FF//7ya2mbaOwl9Fv5gr3bvpjsuw7PCMo6RNmTHPhrIDT1Itl5P+VHj/V93s2K7UMsv9
         t9jh/epTROQQElod8mBiNPgK2jvMO3qSeLbjxHCM6j91usk+8ryGQOqEWnk937bKatKB
         UOHL9x0Qma4JeGq/Txq/yOMlvNidsHQKjp8twvJ87k1dDj3jZRV+uEIS2IPVhPVkbhrJ
         kt9CyiHBJwF1/JoPsMngwfe+Ce6k102hbGZEGhV13+kMqdk7ocyLosxxgHD407t+9ku9
         JuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwMSftwFA/y9bRSb+Oei8zcSAAlSvFrVQdDNQWyv5cI=;
        b=FCWjn7bQTKyg8pBZ0LcQgBUl6fFBdQsi8FRi7tQMcFprvMfNm8pZXzUpVvLlNMfGVG
         BGV1JrDKYWG2G2ic1WQGBaf6d3+wVRtQFg4NKaJ0SE1pUHPKhgmhrkS7rWY3nKeGZV6o
         HwXGeRvibASIlEJM/wOts+mewsOmu8UAYEeFYoRUIqvia3OPYT9sebx84S9JrPqvgXfn
         N+tB0VErJIjw4nANYVqQ+WhkkakopNhYK9yYC1ZL5LZwNywshd/odSUQSu3TYpISUiGD
         lJIkhMVdGgUkrGLH+l2VkeoyYd7cIumD/sIhASx553ODMWI7Uea/DRNwPLrsA1CRux2o
         XbPw==
X-Gm-Message-State: ACrzQf3XN7tTNppTcr26U05pu1eqP4YuBJDZJAKRN7ebqj5WSJpnyWHf
        ESurSM3Q6nLnQp4xkVaujk8=
X-Google-Smtp-Source: AMsMyM4F7tyW5BZkXt/xFg2y1GW17LMjNdT0l4QLf7H2IOGiK9q1LvFDbl51eTOyuoPbUfLtK7siWg==
X-Received: by 2002:a5d:6da2:0:b0:22e:4244:953a with SMTP id u2-20020a5d6da2000000b0022e4244953amr2531102wrs.225.1665136264072;
        Fri, 07 Oct 2022 02:51:04 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id l10-20020adfe9ca000000b002286670bafasm1593017wrn.48.2022.10.07.02.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 02:51:03 -0700 (PDT)
Message-ID: <8f95fbdb-b211-56af-8693-0e5a84afebac@gmail.com>
Date:   Fri, 7 Oct 2022 10:51:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/15] run-command API: don't fall back on online_cpus()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <patch-08.15-4223980f296-20220930T111343Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-08.15-4223980f296-20220930T111343Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2022 12:28, Ævar Arnfjörð Bjarmason wrote:
> When a "jobs = 0" is passed let's BUG() out rather than fall back on
> online_cpus().

Why? It seems like a useful default behavior.

> The default behavior was added when this API was
> implemented in c553c72eed6 (run-command: add an asynchronous parallel
> child processor, 2015-12-15).
> 
> Most of our code in-tree that scales up to "online_cpus()" by default
> calls that function by itself. By having these callers of the
> "run_processes_parallel()" API do the same we can in subsequent
> commits pass all arguments down as a "const struct".

This is not convincing, you can have a function with a const struct 
interface that sets the number of jobs by doing

f(const struct *pp) {
	struct pp mutable;

	if (!pp->n) {
		mutable = *pp;
		mutable.n = online_cpus();
		pp = &mutable;
	}
	...
}

I'm not convinced by the reasoning given for removing the default behavior

Best Wishes

Phillip

> The preceding commit has an overview of the API callers that passed
> "jobs = 0". There were only two of them (actually three, but they
> resolved to these two config parsing codepaths).
> 
> The "fetch.parallel" caller already had a test for the
> "fetch.parallel=0" case added in 0353c688189 (fetch: do not run a
> redundant fetch from submodule, 2022-05-16), but there was no such
> test for "submodule.fetchJobs". Let's add one here.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/fetch.c             | 2 ++
>   run-command.c               | 6 +++---
>   submodule-config.c          | 2 ++
>   t/t5526-fetch-submodules.sh | 5 +++++
>   4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 78043fb67ef..82f1da14ec1 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -122,6 +122,8 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>   		fetch_parallel_config = git_config_int(k, v);
>   		if (fetch_parallel_config < 0)
>   			die(_("fetch.parallel cannot be negative"));
> +		if (!fetch_parallel_config)
> +			fetch_parallel_config = online_cpus();
>   		return 0;
>   	}
>   
> diff --git a/run-command.c b/run-command.c
> index 80d282dbdb6..1a604af14fb 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1568,8 +1568,8 @@ static void pp_init(struct parallel_processes *pp,
>   {
>   	unsigned int i;
>   
> -	if (jobs < 1)
> -		jobs = online_cpus();
> +	if (!jobs)
> +		BUG("you must provide a non-zero number of jobs!");
>   
>   	pp->max_processes = jobs;
>   
> @@ -1843,7 +1843,7 @@ void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
>   				const char *tr2_category, const char *tr2_label)
>   {
>   	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
> -				   ((jobs < 1) ? online_cpus() : jobs));
> +				   jobs);
>   
>   	run_processes_parallel(jobs, get_next_task, start_failure,
>   			       task_finished, pp_cb);
> diff --git a/submodule-config.c b/submodule-config.c
> index cd7ee236a12..4dc61b3a78a 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -303,6 +303,8 @@ int parse_submodule_fetchjobs(const char *var, const char *value)
>   	int fetchjobs = git_config_int(var, value);
>   	if (fetchjobs < 0)
>   		die(_("negative values not allowed for submodule.fetchJobs"));
> +	if (!fetchjobs)
> +		fetchjobs = online_cpus();
>   	return fetchjobs;
>   }
>   
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index e36f9fdf242..98a287ffb90 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -724,6 +724,11 @@ test_expect_success 'fetching submodules respects parallel settings' '
>   		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
>   		grep "9 tasks" trace.out &&
>   		>trace.out &&
> +
> +		GIT_TRACE=$(pwd)/trace.out git -c submodule.fetchJobs=0 fetch &&
> +		grep "preparing to run up to [0-9]* tasks" trace.out &&
> +		! grep "up to 0 tasks" trace.out &&
> +		>trace.out
>   	)
>   '
>   

