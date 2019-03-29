Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE6A20248
	for <e@80x24.org>; Fri, 29 Mar 2019 22:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfC2WQ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 18:16:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44787 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfC2WQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 18:16:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so3283435edh.11
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=lnX2t1XGrouncHn3Cd7ZugUhaH0O9uB7p9wX7oQsMm4=;
        b=T8oCE+70I2sX93dDXVihyPW9Fq045uEYpOoaJfvULrShtNb4Bn1jAAKMOv7WicROhy
         mXOFRhgdg1jKWqCqnL/yN4eX95pe+zPn8cqZMeawBJRjC1anRaoDDuXZhjsgpb/cIaFB
         sl8+/YLC8WD4isvG2WXG+/+4n/monZEgStz/f3JOdX6fEW0Mg02DP+1iSz4o/0cEfbZe
         r32uhZgf8Ea/f/BzAI8EQrDfc6QRmPHhz44jPWsLJhaGSQu4TshbxUZjFAXBsT6QhxQS
         RalH8z5ryMlaAbmvKg//UdkVK+1aIlqUffFfW9qpLgXTPTZ1jPezaaHhp2klv2eotiet
         1wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=lnX2t1XGrouncHn3Cd7ZugUhaH0O9uB7p9wX7oQsMm4=;
        b=eHuKW0TydSYnjnm3KNcjMn8fnyEwvJ4TTsF3cvDmDjXBYuWypomIch+9ep3VQvYIsR
         VfQ2d/aMxhwXSPPSI/aOvBfDS4iKQUiyilwVW81ilpdiO+94wF2kCXfEMQtFj0dWPG8O
         SeuDqwV+BCXtPeFGkyNAFZPvS3xHw9P+5EQJN34FCl8NJ6M7maNjirNa/st4JcbpRJjX
         2NvO+34hgCRHDqCO6GcSR6GBrYFShGrCM4hT7plCIt3yElwHb+mS2EnApNwXlGcJh0vX
         33NNVqAX3G7OWMCMidv+QUkSRQwZlLWhTYeKZ6qAL1gcQn01IbJkWj0bKSPN4hc83jFv
         K9fg==
X-Gm-Message-State: APjAAAWDd7AYDF5d2Je78IgfPnUveR9iboAywjRWzZyqo0lQXOi3QgwY
        jxCClQtZAf14Eoq/fQXO01h/TrzH
X-Google-Smtp-Source: APXvYqy4RqrU08XJbdjRgFDQaq21YRVsluPMYg2XpoBkWUCIInqNhG2DUI+b2apGmMxxiQXWQLF6Hw==
X-Received: by 2002:a50:95f8:: with SMTP id x53mr31746989eda.267.1553897783305;
        Fri, 29 Mar 2019 15:16:23 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r12sm564883ejs.16.2019.03.29.15.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 15:16:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/7] trace2: report peak memory usage of the process
References: <pull.169.git.gitgitgadget@gmail.com> <pull.169.v2.git.gitgitgadget@gmail.com> <86d8fe28cf2f51a494163f9cec3e3b0541288435.1553879063.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <86d8fe28cf2f51a494163f9cec3e3b0541288435.1553879063.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Mar 2019 23:16:21 +0100
Message-ID: <87k1gh9vii.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 29 2019, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach Windows version of git to report peak memory usage
> during exit() processing.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  common-main.c                            |  2 +-
>  compat/win32/trace2_win32_process_info.c | 50 ++++++++++++++++++++++--
>  trace2.c                                 |  2 +
>  trace2.h                                 | 14 +++++--
>  4 files changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/common-main.c b/common-main.c
> index 299ca62a72..582a7b1886 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -41,7 +41,7 @@ int main(int argc, const char **argv)
>
>  	trace2_initialize();
>  	trace2_cmd_start(argv);
> -	trace2_collect_process_info();
> +	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
>
>  	git_setup_gettext();
>
> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
> index 52bd62034b..2a514caed9 100644
> --- a/compat/win32/trace2_win32_process_info.c
> +++ b/compat/win32/trace2_win32_process_info.c
> @@ -1,5 +1,6 @@
>  #include "../../cache.h"
>  #include "../../json-writer.h"
> +#include "lazyload.h"
>  #include <Psapi.h>
>  #include <tlHelp32.h>
>
> @@ -137,11 +138,54 @@ static void get_is_being_debugged(void)
>  				   "windows/debugger_present", 1);
>  }
>
> -void trace2_collect_process_info(void)
> +/*
> + * Emit JSON data with the peak memory usage of the current process.
> + */
> +static void get_peak_memory_info(void)
> +{
> +	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo,
> +			  HANDLE, PPROCESS_MEMORY_COUNTERS, DWORD);
> +
> +	if (INIT_PROC_ADDR(GetProcessMemoryInfo)) {
> +		PROCESS_MEMORY_COUNTERS pmc;
> +
> +		if (GetProcessMemoryInfo(GetCurrentProcess(), &pmc,
> +					 sizeof(pmc))) {
> +			struct json_writer jw = JSON_WRITER_INIT;
> +
> +			jw_object_begin(&jw, 0);
> +
> +#define KV(kv) #kv, (intmax_t)pmc.kv
> +
> +			jw_object_intmax(&jw, KV(PageFaultCount));
> +			jw_object_intmax(&jw, KV(PeakWorkingSetSize));
> +			jw_object_intmax(&jw, KV(PeakPagefileUsage));
> +
> +			jw_end(&jw);
> +
> +			trace2_data_json("process", the_repository,
> +					 "windows/memory", &jw);
> +			jw_release(&jw);
> +		}
> +	}
> +}
> +
> +void trace2_collect_process_info(enum trace2_process_info_reason reason)
>  {
>  	if (!trace2_is_enabled())
>  		return;
>
> -	get_is_being_debugged();
> -	get_ancestry();
> +	switch (reason) {
> +	case TRACE2_PROCESS_INFO_STARTUP:
> +		get_is_being_debugged();
> +		get_ancestry();
> +		return;
> +
> +	case TRACE2_PROCESS_INFO_EXIT:
> +		get_peak_memory_info();
> +		return;
> +
> +	default:
> +		BUG("trace2_collect_process_info: unknown reason '%d'", reason);
> +	}
>  }
> diff --git a/trace2.c b/trace2.c
> index 490b3f071e..6baa65cdf9 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -213,6 +213,8 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
>  	if (!trace2_enabled)
>  		return code;
>
> +	trace2_collect_process_info(TRACE2_PROCESS_INFO_EXIT);
> +
>  	tr2main_exit_code = code;
>
>  	us_now = getnanotime() / 1000;
> diff --git a/trace2.h b/trace2.h
> index 894bfca7e0..888531eb08 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -391,13 +391,19 @@ void trace2_printf(const char *fmt, ...);
>   * Optional platform-specific code to dump information about the
>   * current and any parent process(es).  This is intended to allow
>   * post-processors to know who spawned this git instance and anything
> - * else the platform may be able to tell us about the current process.
> + * else that the platform may be able to tell us about the current process.
>   */
> +
> +enum trace2_process_info_reason {
> +	TRACE2_PROCESS_INFO_STARTUP,
> +	TRACE2_PROCESS_INFO_EXIT,
> +};
> +
>  #if defined(GIT_WINDOWS_NATIVE)
> -void trace2_collect_process_info(void);
> +void trace2_collect_process_info(enum trace2_process_info_reason reason);
>  #else
> -#define trace2_collect_process_info() \
> -	do {                          \
> +#define trace2_collect_process_info(reason) \
> +	do {                                \
>  	} while (0)
>  #endif

FWIW this is the "VmPeak" line in /proc/$$/status on Linux. I don't know
if we can/should parse that in practice (I've been bitten in the past by
things in /proc having high cost on some kernel versions in the past,
notably smaps).
