Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C181F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJJDFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 23:05:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34860 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJJDFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 23:05:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id v19-v6so3089616qtg.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vLj8ICAdnmeeykcUKhtxb3j1xlzQ9xEmHx7jUtl9A1w=;
        b=E9ZNFhKBJF5o74zzxGCoXSpiuXhm7o25rqUwkO5R1OMzOOvaufmmOBWwEyEbRsvIaP
         5fBXm77+zo9dQJHR2TM4xm7U9qtWz7GBpEttIDDB2zPEAT3qsCZJN2tnFMh+StNJaQHc
         J7M1ux4HvuP3X+PDcwtAso4iAPYf5IEWEn1TT2zbVX7sjQHnHAQf7F6cOkEfBP+CgT3S
         bXbAiQtzKb7reWh7+ao+vqjPieKIvKNY+YzEPqFJbu5MnxJI30ZmMQd4c/5Py/zwKyfR
         RlozQlcb8Ufi9MNia5wuJlBLJf0FrOVxnoA1yfvx945jyEJyTX3qD6wgSLDfWIJUtx04
         z9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vLj8ICAdnmeeykcUKhtxb3j1xlzQ9xEmHx7jUtl9A1w=;
        b=C6TR9Z9OMScmvmte6EtIM/f6CqlV72q6dAFB8Svkx4RXwYQvFRhVnl+aaM0sV0E5HG
         /gcyHLiMvegRjCX9lmi96no5JpzgH0bd0SEjfs8s8LRFfeYHCBpWM33lEDRmcv310M3K
         Y7mQaPCKQgFrLpImNoD7auj/jhkjQUnIAPlgINhi/cNYHtltxWrTlhjt1mpJ4xonkOTq
         TC7SGS55sLjOLogkOghLVV0SFP5O1jEwxbkUEu49vQDvio36Mw40ztntoG4tNVYHT4qr
         4uE6x6VcRQ2JnskHBH8f/220W1fpoEznwczOUUY38gImI0Tdk0h2I2wrF0xbMBZsDS/G
         73+Q==
X-Gm-Message-State: ABuFfohkl2Pydu+SlaiEUtlTm0HtR0mCYCa4Q4OQbMQrqlo/qrDM6+FR
        EEmIPRsF05UrZFqFbUagwuU=
X-Google-Smtp-Source: ACcGV62FleBG11/VAp6O+REc9+ggPvSrji8Cjc0SfQtjJ0Q4ard9vx+zj3V1XGBQ1Z1i3s3oWR04WQ==
X-Received: by 2002:ac8:74cc:: with SMTP id j12-v6mr1396944qtr.358.1539114440016;
        Tue, 09 Oct 2018 12:47:20 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u23-v6sm12374306qth.45.2018.10.09.12.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 12:47:18 -0700 (PDT)
Subject: Re: [PATCH 0/4] Bloom filter experiment
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8dd5ab67-8f9b-fddb-b4ae-b4187eeffaac@gmail.com>
Date:   Tue, 9 Oct 2018 15:47:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2018 3:34 PM, SZEDER Gábor wrote:
> To keep the ball rolling, here is my proof of concept in a somewhat
> cleaned-up form, with still plenty of rough edges.
>
> You can play around with it like this:
>
>    $ GIT_USE_POC_BLOOM_FILTER=$((8*1024*1024*8)) git commit-graph write
>    Computing commit graph generation numbers: 100% (52801/52801), done.
>    Computing bloom filter: 100% (52801/52801), done.
>    # Yeah, I even added progress indicator! :)
>    $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y git rev-list --count --full-history HEAD -- t/valgrind/valgrind.sh
>    886
>    20:40:24.783699 revision.c:486          bloom filter total queries: 66095 definitely not: 64953 maybe: 1142 false positives: 256 fp ratio: 0.003873
>
> The value of $GIT_USE_POC_BLOOM_FILTER only really matters when writing
> the Bloom filter, and it specifies the number of bits in the filter's
> bitmap, IOW the above command creates a 8MB Bloom filter.  To make use
> of the filter the variable can be anything non-empty.
>
> Writing the Bloom filter is very slow as it is (yeah, that's why
> bothered with the progress indicator ;).  I wrote about it in patch 2's
> commit message: the cause for about half of the slowness is rather
> obvious, but I don't (yet) know what's responsible for the other half.
>
>
> Not a single test...  but I've run loops over all files in git.git
> comparing 'git rev-list HEAD -- $file's output with and without the
> Bloom filter, and, surprisingly, they match.  My quick'n'dirty
> experiments usually don't fare this well...
>
>
> It's also available at:
>
>    https://github.com/szeder/git bloom-filter-experiment

Thanks! I will take a close look at this tomorrow and start playing with it.

-Stolee

