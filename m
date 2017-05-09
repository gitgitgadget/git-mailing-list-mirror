Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F481FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbdEIMvR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:51:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36446 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbdEIMvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:51:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id y128so14516924qka.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uiCfZKXRW+EsjZkAr2IB/B2Unyn7SKwJCzak96Vis2g=;
        b=gzt5pi1j3E7c3LtQAqSOlByL7Lni20oiKHsOA5z12OfDPCkJwwaYONKg2lXMldsiOU
         S83t0uUw++3lWhE3YI45rMQBfpJmU0CBZOe3eBZQxV6HCSapV5ScXEv4vU7t5oHp9Dfk
         y9JX1P2DwRqhV6+FsFwfEAeNZ1dMD9Fb2Hz5rglVFwxO+KltqBJXSyETPKdWe6QHebfZ
         RVH6K+xzDu3OGT2QM6KMX0rn9bcVuiqJtAI4XzO0peNtTvXzUC4C/j9c5NYJAUHupCtF
         Um6N8AiJ/gLI1vUWgBgtf5cDupa0bxRirOuSrM5SW54Fu+nI8pYJ+BqvP3NR9uOti3um
         supQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uiCfZKXRW+EsjZkAr2IB/B2Unyn7SKwJCzak96Vis2g=;
        b=soXh2qxoPjgVzia3JKa8LDPQqhqXhSTJBs5ItkJcqTfoAIewYkjMj5Usvh7ONbZlEn
         3IxJwWh4N8W96AFJ7/3fx/a3JQlbDdb3G0bcisIspXf7ZnUCXNmNQhrVHnCtnCtsj53v
         h6rOM4bZiYHcIMFadbBIjE5ckmrLOFET+BHwNrUilCAX2MO9NCWz7yRSIBmMUwxi98F+
         0ZprZ1aNPURXlIkNx5jqZO4iAAuKRIShorBRNJE3n0K5sroovS6Ud/rXz8VwOxAMl0KG
         bZtvBi7WLwvKe+M/g2NNERSxNnXTcL5Hg36MMOry7WR95N6M9RRVK/vMOhoGj4yzIWMV
         bekw==
X-Gm-Message-State: AN3rC/6QZCsA+7f+8w/3XtIsnIGqf92LjwNKL5Cu6HucW5uUdPSwguqF
        S2as0eVQwWGRdw==
X-Received: by 10.55.77.195 with SMTP id a186mr31837987qkb.296.1494334275149;
        Tue, 09 May 2017 05:51:15 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d198sm12026839qkb.1.2017.05.09.05.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2017 05:51:13 -0700 (PDT)
Subject: Re: [PATCH 0/1] Preserve the untracked cache across checkout, reset
 --hard, etc
To:     Junio C Hamano <gitster@pobox.com>,
        David Turner <David.Turner@twosigma.com>
References: <cover.1494236457.git.johannes.schindelin@gmx.de>
 <CAP8UFD3qoeQE5ZbFHGLE-_B4rOr3X2m-WPB7rb8QAbZA6zMRxg@mail.gmail.com>
 <2c0be7c0a8ce4f5ea49dfaf3f8511bc0@exmbdft7.ad.twosigma.com>
 <xmqqy3u639n4.fsf@gitster.mtv.corp.google.com>
Cc:     'Christian Couder' <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1e21e5c4-3440-a82f-b6c5-1a3e00439054@gmail.com>
Date:   Tue, 9 May 2017 08:51:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3u639n4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 5/9/2017 1:02 AM, Junio C Hamano wrote:
> David Turner <David.Turner@twosigma.com> writes:
>
>> Can you actually keep the email address as my Twopensource one?  I want to make sure that Twitter, my employer at the time, gets credit for this work (just as I want to make sure that my current employer, Two Sigma, gets credit for my current work).
>>
>> Please feel free to add Signed-off-by: David Turner <dturner@twosigma.com> in case that makes tracking easier.
>>
>> Thanks.
>>
>> WRT the actual patch, I want to note that past me did not do a
>> great job here.  The tests do not correctly check that the
>> post-checkout untracked cache is still valid after a checkout.
>> For example, let's say that previously, the directory foo was
>> entirely untracked (but it contained a file bar), but after the
>> checkout, there is a file foo/baz.  Does the untracked cache need
>> to get updated?
>>
>> Unfortunately, the untracked cache is very unlikely to make it to
>> the top of my priority list any time soon, so I won't be able to
>> correct this test (and, if necessary, correct the code).  But I
>> would strongly suggest that the test be improved before this code
>> is merged.
>>
>> Thanks for CCing me.
> I will try to find time to tweak what was sent to the list here to
> reflect your affiliations better, but marked with DONTMERGE waiting
> for the necessary updates you mentioned above, so that this change
> is not forgotten.  It may turn out to be that copying from src to
> dst like the patch does is all that is needed, or the cache may need
> further invalidation when the copying happens, and I haven't got a
> good feeling that anybody who are familiar with the codepath vetted
> the correctness from seeing the discussion from sidelines (yet).
>
> Thanks.

I've been looking into similar issues with the cache associated with 
using a file system monitor (aka Watchman) 
(https://github.com/git-for-windows/git/compare/master...benpeart:fsmonitor) 
to speed updating the index to reflect changes in the working directory.

I can take a look and see if this patch results in valid results and 
reply to the thread or resubmit as needed.

Ben
