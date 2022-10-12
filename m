Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFB0C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJLNOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJLNOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:14:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C7CBFC9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:14:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j16so26178638wrh.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7B1OUaKBXIL/F1HTLD4diSKHpPTHjZypVSaKZ0Xhu/E=;
        b=oqq8BkL8CQT0EnYcibVGYla13jNL5dPN3YhAgyuINPbeT/nXk7N/ffTkqaCdB3LG+J
         v8iQAgaXr+He4oxVe7mJv+HGeQaqvlFYuByZ18dzlNk1WEndL+uAKvEYkE4VNQ6sxTX8
         dvmVZCGHaOkQ/taT3jiEgdTgsXY0oBhVCBdxVCeks4kCEAXR2avC9m2sFzFQynFQz38p
         jhLQbhvJ1wchZbUOFu5G3ApQjBSFjdH0uPWeYhml5tgq7mtrjFgVuQt4D0ukTC9Ajybv
         qsS5A1bT3vjDfj3GgSt1Iah456USnUf2xLAuXxaB/9PoC2QKVvb/FpcpniF51Y87yxB9
         qWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B1OUaKBXIL/F1HTLD4diSKHpPTHjZypVSaKZ0Xhu/E=;
        b=eeyno1mL2OJ5FIA5LB+2B4pG+T9XcKEOxgSdx04LQrauwe4VgL8Jn1hZ8ZcQkd9jJE
         2esa7V8Y5jy8R9kesYfrXIoxMrla/wBkjt23exvvWN3zI/G5z5EelkPpxGIXxGIdcN2b
         k4SQD9wlSTOUFJ+n87zH9PHHWM5zHWqTA3wJUkyaHinQXWNYqc18btsE/uuTiykom3Kb
         D3P2vSZJ0RG6CPJgHWML2v0skGoDofZtkJx36Jd4Cnhe4YdwpxowwxCMHOnu5xAnmDIE
         a3T2agOWCKlH86HusI173s26Cffe4B6w9dlZNN0sr8/jEHAsP/fZEOF3VI10iwEGnIbA
         YiTw==
X-Gm-Message-State: ACrzQf0/AOBmpVMZwGexqLCJKnZQdZk5hsXGrGf1NUhAhPmBbKq5SJPo
        Umhy1TMc9viVF2vlhYqbkhQ=
X-Google-Smtp-Source: AMsMyM5l0QsInaPeXaLv2iuoO15RZYvGnrCEV6jGANFFRTKRffKIeJYqyMsdQ2kcRT/kzLfCa1Nyrw==
X-Received: by 2002:a5d:4ec3:0:b0:22e:2f18:35cc with SMTP id s3-20020a5d4ec3000000b0022e2f1835ccmr17538871wrv.628.1665580452813;
        Wed, 12 Oct 2022 06:14:12 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id u9-20020a5d4349000000b0022cdb687bf9sm17566338wrr.0.2022.10.12.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:14:12 -0700 (PDT)
Message-ID: <bd199beb-99b4-aff3-2964-f5dd9cd70cef@gmail.com>
Date:   Wed, 12 Oct 2022 14:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 10/22] run-command API: don't fall back on
 online_cpus()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <patch-v2-10.22-eb9d672b0d8-20221012T084850Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v2-10.22-eb9d672b0d8-20221012T084850Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/10/2022 10:01, Ævar Arnfjörð Bjarmason wrote:
> When a "jobs = 0" is passed let's BUG() out rather than fall back on
> online_cpus(). The default behavior was added when this API was
> implemented in c553c72eed6 (run-command: add an asynchronous parallel
> child processor, 2015-12-15).

This commit message still does not explain why this change is necessary. 
The cover letter says you hope it is obvious but it isn't. As I pointed 
out in my previous review[1] I think it is possible for 
run_processes_parallel() to take a const struct without this change.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/8f95fbdb-b211-56af-8693-0e5a84afebac@gmail.com

> Most of our code in-tree that scales up to "online_cpus()" by default
> calls that function by itself. By having these callers of the
> "run_processes_parallel()" API do the same we can in subsequent
> commits pass all arguments down as a "const struct".
> 
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
>   run-command.c               | 7 +++----
>   submodule-config.c          | 2 ++
>   t/t5526-fetch-submodules.sh | 5 +++++
>   4 files changed, 12 insertions(+), 4 deletions(-)
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
> index 5a63008b6e1..21c00a48823 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1562,8 +1562,8 @@ static void pp_init(struct parallel_processes *pp,
>   		    task_finished_fn task_finished,
>   		    void *data, int ungroup)
>   {
> -	if (n < 1)
> -		n = online_cpus();
> +	if (!n)
> +		BUG("you must provide a non-zero number of processes!");
>   
>   	pp->max_processes = n;
>   
> @@ -1831,8 +1831,7 @@ void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
>   				task_finished_fn task_finished, void *pp_cb,
>   				const char *tr2_category, const char *tr2_label)
>   {
> -	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
> -				   ((n < 1) ? online_cpus() : n));
> +	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
>   
>   	run_processes_parallel(n, get_next_task, start_failure,
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

