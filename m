Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A161F597
	for <e@80x24.org>; Wed, 25 Jul 2018 18:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbeGYTnH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 15:43:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42095 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbeGYTnH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 15:43:07 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so8616312qto.9
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Snuv6ddS1BDVP+eBHUNjGKWD4/q/tpZ6yAE/lPiTpaU=;
        b=fNf7sEHTbIGfLx6wq10pv5OcSqpVf9hXbFt4yinFZDgTVNuViXxw7NrrBZmaIO6wev
         vZ9qPLW+XnG1Fd/kv75tCHsn9/RfWZxlV/T9YNazN0d3I7i/o6yUqZgZQ1UIbWUp0w7l
         sUbvVkpC2Po1aS2ZKU6MDTIEKnueqZjAkvbhL6uDVmy5DFWPjhVDAVVkw2Nvtx2uDTLx
         TY2xKIWiYDi7sL4iSQFQMlJmrkqWGevLGs1o5ulp1D1R72zfTZxcF1Ai+kHQsvOiVQZ2
         /XIM5Fb27cAjWtlKVFpfZNEZqnNGsp3TCGo/hEWKpSRevnx5jEejlLDOS3GpZ6BYUxQ8
         PFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Snuv6ddS1BDVP+eBHUNjGKWD4/q/tpZ6yAE/lPiTpaU=;
        b=rcat6min85dEI616Y+0ZIZ7eUtiDeo1wjt3hvkOsU8Md4jiZTKOHPZ20g8kfVZsrYc
         jcaDK7yDN+DLv9e0ZPoBWypGTVTFfBhHCATh9qKUxfQwmm2j5WB5G+RZ/Gjaszc0aoqZ
         dOm0CMMOWSAgpV+bBIL7L1+Cp+cPGP50jpOmR9HXV4fwv2jJjEk6fzoMMubonXmhVqze
         4KVeE+LhuA1UI62NWT4NnnDpETE5Z3Tv+56MvFRqf6KNwO9yf64GaWueQbwONzkj1QpW
         7Flmw1HmzzsbX2OhAlTH1QuJ5q2oUw8RLMQenZwqcH1Mi0tKlR4u0h85i3/Ir+yJzkMg
         oBjA==
X-Gm-Message-State: AOUpUlF8LVen+9MaDHNsmioC42ukgTiRsm9dqU6WCUPLD2nkkigZechy
        0j5+5ktYGAy1GkqteEzsn1E=
X-Google-Smtp-Source: AAOMgpeGEbawHMDAz2OrsQV06HjoMvoR0Uxnl6V/tpGpSLSpXQGHYoNX795eH9FjLHhWo7bSkZyb5Q==
X-Received: by 2002:ac8:3913:: with SMTP id s19-v6mr21865156qtb.344.1532543414172;
        Wed, 25 Jul 2018 11:30:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:319d:74bf:900e:a469? ([2001:4898:8010:1:f232:74bf:900e:a469])
        by smtp.gmail.com with ESMTPSA id j16-v6sm8998423qtp.13.2018.07.25.11.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 11:30:13 -0700 (PDT)
Subject: Re: [PATCH v2 15/18] test-reach: test commit_contains
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org, sbeller@google.com
References: <20180720163227.105950-16-dstolee@microsoft.com>
 <20180723203500.231932-1-jonathantanmy@google.com>
 <xmqqr2jrur1m.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c8b2860-3de7-e7fd-da07-9f2ae27e2e8f@gmail.com>
Date:   Wed, 25 Jul 2018 14:30:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2jrur1m.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2018 2:08 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>> +	} else if (!strcmp(av[1], "commit_contains")) {
>>> +		struct ref_filter filter;
>>> +		struct contains_cache cache;
>>> +		init_contains_cache(&cache);
>>> +
>>> +		if (ac > 2 && !strcmp(av[2], "--tag"))
>>> +			filter.with_commit_tag_algo = 1;
>>> +		else
>>> +			filter.with_commit_tag_algo = 0;
>>> +
>>> +		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
>> Should we initialize filter (with {NULL} or some equivalent)?
> Sounds like a sensible suggestion.  Wouldn't we segfault otherwise
> depending on what garbage bytes are on the stack?

It's a good idea to initialize the struct properly, but the only part of 
the 'filter' struct that is accessed by that method is the 
'with_commit_tag_algo' member. Everything else is read from A, X, and cache.

Thanks,
-Stolee
