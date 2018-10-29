Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D191F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJ3Bm1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:42:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44133 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeJ3Bm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:42:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id b22-v6so10008339qtr.11
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YqKV6VfUCt5JbSkIpL/tj8L3tfRK66hEZtgXYbZCQd4=;
        b=CbAQtiBBW8+Ide9QaRXS+oTbPRTkCseMySmFQmwkZEOuEDCli0h2EP7ThJC6woR6F2
         9Xhqw4F+1pYVkoDdmLOBkyiVU81caXKRYjFdWGglqD+488EfNGP5qv9jIZFfLx1dJqCq
         a4hdVw20si0uYhvKSi1uaO0YnOANBgIIdhIejSBcwYSnA+0+nxQ8Rv7/gFBFMsTjw6qn
         deZPtc1u37rHzCL/FNkgTjknvKf4bAf7fbJx4bkpsb4igzqvHRMdKu0ToVx5TCiKO4mz
         r+F/fqRV/3eaKUKVa+z52S+O23dBRYxectFJLqJZARl9B1ZMA/HRmWxhk5PIBTyCJIl6
         BtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YqKV6VfUCt5JbSkIpL/tj8L3tfRK66hEZtgXYbZCQd4=;
        b=SWC4qqvDNabdyRCRcz1WcVIdJYw2Pi+w8UZivPgg3wN5qaSLIZnFhY5lFtnufKzVLk
         3Gw0F1naczQAWaEU6EFQ/l4pj1Tz1hvacTC760c/9ffUPUP7hvaGwt5xLbKC/rFxcb9T
         GI9hQ2SyZxK2+wtY0/fF3RkD+krVRd8G/nnLL92GlCWyECdJBgBS+OrCYEkO3whLwtvH
         AxMIGCvk3cH8+oa21Sy6NjpGX+HolvHqaG+afUoyoS2+QGqa0HvW/++LZYXVkoqvBjcY
         riUp7Z1uwO/7aJ+f0WYFjrysdNTOdwsY+/Ea1XbqPOEgBdGkktNVRVQFuX9nPSXncvcJ
         SkIg==
X-Gm-Message-State: AGRZ1gKSFEwwm6mEL8LRG7f+4Fdpya8OX9hIJpgDDhoUIn5w8SKTSxZE
        r/5kd+0XAOIMrvtyGeWH5vA=
X-Google-Smtp-Source: AJdET5fYkhsh/X5z9ZaE9k9wLnbS1zMI7AFbTJ7rTyWnMBt2aT6xMqMqwecNbIgmIUKG7ROHTohYPQ==
X-Received: by 2002:ac8:71c6:: with SMTP id i6-v6mr5905184qtp.204.1540831980864;
        Mon, 29 Oct 2018 09:53:00 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id c5-v6sm2553350qtj.55.2018.10.29.09.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:52:59 -0700 (PDT)
Subject: Re: [PATCH 07/10] preload-index.c: remove #ifdef NO_PTHREADS
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-8-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1217c887-cb15-87c6-649f-8b927abe8180@gmail.com>
Date:   Mon, 29 Oct 2018 12:52:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181027071003.1347-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/27/2018 3:10 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   preload-index.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/preload-index.c b/preload-index.c
> index 9e7152ab14..0e24886aca 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -7,17 +7,7 @@
>   #include "fsmonitor.h"
>   #include "config.h"
>   #include "progress.h"
> -
> -#ifdef NO_PTHREADS
> -static void preload_index(struct index_state *index,
> -			  const struct pathspec *pathspec,
> -			  unsigned int refresh_flags)
> -{
> -	; /* nothing */
> -}
> -#else
> -
> -#include <pthread.h>
> +#include "thread-utils.h"
>   
>   /*
>    * Mostly randomly chosen maximum thread counts: we
> @@ -108,7 +98,7 @@ static void preload_index(struct index_state *index,
>   	struct thread_data data[MAX_PARALLEL];
>   	struct progress_data pd;
>   
> -	if (!core_preload_index)
> +	if (!HAVE_THREADS || !core_preload_index)

I also "hoped in general that the non-threaded code paths could mostly 
just collapse into the same as the "threads == 1" cases, and we wouldn't 
have to "are threads even supported" in a lot of places."

In this case, if we cap the threads to online_cpus() the later test for 
'if (threads < 2)' would do that.  I haven't measured this specific case 
but in the other cases I have measured, having more threads than cpus 
did not result in a performance win.

>   		return;
>   
>   	threads = index->cache_nr / THREAD_COST;
> @@ -151,7 +141,6 @@ static void preload_index(struct index_state *index,
>   
>   	trace_performance_leave("preload index");
>   }
> -#endif
>   
>   int read_index_preload(struct index_state *index,
>   		       const struct pathspec *pathspec,
> 
