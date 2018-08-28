Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4911F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH2BdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:33:11 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42554 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH2BdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:33:11 -0400
Received: by mail-qk0-f193.google.com with SMTP id g13-v6so2052410qki.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=apmXUcZDErLJb4B1FiN8XXZzLgUk3cjyL4hr3jVdS5I=;
        b=fhEphLMbKfoOMZYJaxAe4n8sgTnvDpttE3nT4jJRMgqcMM+YKYPJJBweUjB7tFLM23
         v3ep/XEKF4j2ehATF9Ecj/1TQg5CivRl1ECryVl2Dq+gCjLW7KGdQsPNeMXD43IgEQm0
         xXyhLXq1uFA46nE9N+7hHsHbF/Pcbk9qyYQi523h4jnAKYpNtQD7BpcWMk2+y0veUHAo
         PgFTqX2BzApBU950H5WXAlK78Ciim748t0HCeyZY7oZpjU+SYFHoi+8BQOsvQFFIvyM8
         YF02VM0zS0XnMcjc5T0n5+qw7vbw4UWltXA8L7QhzC+KpVVnL7LGritCj0TP4vvK8jlH
         cwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=apmXUcZDErLJb4B1FiN8XXZzLgUk3cjyL4hr3jVdS5I=;
        b=irftJeh/EaBJ6+cJokwQ9Ivo+3+PTSm/Hf4s+CIixcjiVoWlf7Qw3Yn+r4F1R4bonr
         DJyoHLC0qXNw1DdN0TnX8gMg3uP/d3O36PYx9FOq0EinWeZ9HFvrrlYbsaXFBNFqxD+R
         ADqLAufJ6IZelWNsddBM8jYcJ5vlVYoUemSAN9hJZQPMPl7CU/Ts5Jn7Tu3k8URFAVB4
         XUGepU2NaXRZTW/A0Wlx7sgH04IZaLHOuGhas0+M+5haNRrrkwB1zNsPaojaIFxD2MfY
         Q3OcgSHzyo3WQc/y4CnHbm1/R1XHXhgc0Ot6EXiThzSDMZMK9FTgwn2vZt8jsMCcWtb/
         4ZxA==
X-Gm-Message-State: APzg51ApAO7KTnkT55VUN4PgQH/NY8+Qvp+9OqVxkixoYX0+bH1BfFxT
        g6THTNC7Ve60WWZFM7cVkg4=
X-Google-Smtp-Source: ANB0VdbhBinFjrs5ge7Ei5ATpL1TTp8hA/2gItph1Mofpl0bZWnghZCcFz1PFOdjjlb3BruivQaKIA==
X-Received: by 2002:a37:5bc5:: with SMTP id p188-v6mr3657779qkb.318.1535492376336;
        Tue, 28 Aug 2018 14:39:36 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id m95-v6sm1228969qte.69.2018.08.28.14.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:39:35 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: correct accidental #include of C file
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-5-dstolee@microsoft.com>
 <20180828212457.GA74687@aiede.svl.corp.google.com>
 <20180828213657.GA74296@aiede.svl.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6ae7f8fd-9be5-992e-e5a4-35254c263280@gmail.com>
Date:   Tue, 28 Aug 2018 17:39:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828213657.GA74296@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 5:36 PM, Jonathan Nieder wrote:
> Without this change, the build breaks with clang:
For some reason, it didn't fail with GCC for me, but this is an 
obviously correct change to make. Thanks!
>   libgit/ref-filter.pic.o: multiple definition of 'filter_refs'
>   libgit/commit-reach.pic.o: previous definition here
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jonathan Nieder wrote:
>> Derrick Stolee wrote:
>>> --- a/commit-reach.c
>>> +++ b/commit-reach.c
>>> @@ -1,8 +1,10 @@
>>>   #include "cache.h"
>>>   #include "commit.h"
>>> +#include "commit-graph.h"
>>>   #include "decorate.h"
>>>   #include "prio-queue.h"
>>>   #include "tree.h"
>>> +#include "ref-filter.c"
>> Did you mean "ref-filter.h"?
>>
>> This broke the build here.  Is there some check that we can use to
>> prevent it happening again?  I don't think we ever intentionally
>> #include a .c file.
> Here's what I'm applying locally.
>
> Thanks,
> Jonathan
>
>   commit-reach.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index c996524032..86715c103c 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -4,7 +4,7 @@
>   #include "decorate.h"
>   #include "prio-queue.h"
>   #include "tree.h"
> -#include "ref-filter.c"
> +#include "ref-filter.h"
>   #include "revision.h"
>   #include "tag.h"
>   #include "commit-reach.h"
