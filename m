Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD3A1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936268AbeFOPKh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 11:10:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39013 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeFOPKh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 11:10:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id p23-v6so9300737qtn.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cUNfXhyPMtKbLQiPht7hyzCd2nMzuCWBL5ywgAow2g8=;
        b=k1/y0dTpT5A0OIWOkmcHznZdmfede0NSaHYveWyXQa7VA+0HVcuo6QyDFn67lBK/p0
         ekBcaTCd8lgE5QJT+6oKcWYgqRGXKnA9dfjgNOrisaQQXlQVpkVLKyZkTOAzSyVjheLe
         7jCf06xPcevURdGrTkKjUKRbuWnB5B3MWRXdXrMbrCDpf9Iyk2JrYE9ceo1sAkT8OTYR
         mnZsdEqXBZD2vL4HmgcvxBoOSDaXpW6t2LuEQBzHvFR32uo5cimP8yoX2cEtHYUdN3YN
         9aYlfCbpXY7Ua4Cnmh4hfsA9hgyS5MY5t7SdOJSpHkFeJDnnhJ9vU3L2S3iWjZf515ha
         jVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cUNfXhyPMtKbLQiPht7hyzCd2nMzuCWBL5ywgAow2g8=;
        b=FmnS52AhjjFZlyTBbKZMrexDdRNvJiKXR/CMsuwAsApdTc77Xh7JHySjs1/0dPvNGO
         kWz1NIhN1IYlqbYSDH6PV5zWZfv5bxJYkjqABgFfoVAIWtGzdQ3lDL7adFVayF6SqF9o
         aaaEkLr3+SoDcUn1E0L2Ors9v98ZXsS0tugsMMFqRcKoSgeiwAIR+FKl8Xe5rvXLLFoO
         ZV1aZWVXSdAfXiH1hVCMv85p1s8ieSvfcthlO5DFiPICH4366ipP1VNYKSEgmCbvgWAQ
         u8KpV1wlVuSKJQW32UPvyYiTUmnAksHrrr20kKwKsE2ghwXiRBxNZouRNm8moZTVdSc6
         8vBg==
X-Gm-Message-State: APt69E1tPB8YoPLM6+t2FEou/t/uPTHkXtHL4xpUVaMEVR4s+fNIaBOw
        UzIHJh9fqhtZksbeHj3L/ig=
X-Google-Smtp-Source: ADUXVKI9gknYOCihmF4TffzcU7AeDF1hIOlzA2W4QT7AvapaLFWlsUTch+DqXnag9cC0VabQEJBqCg==
X-Received: by 2002:ac8:329:: with SMTP id q41-v6mr1851526qtg.369.1529075436299;
        Fri, 15 Jun 2018 08:10:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id u31-v6sm6377197qtc.28.2018.06.15.08.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 08:10:35 -0700 (PDT)
Subject: Re: [PATCH 8/8] ewah_io: delete unused 'ewah_serialize_native()'
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615143018.170686-9-dstolee@microsoft.com>
 <57747146-2aea-39f4-0ef7-aca3a2ce0a66@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2148a0f8-fbe1-4486-b27c-a8d8194b6e7f@gmail.com>
Date:   Fri, 15 Jun 2018 11:10:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <57747146-2aea-39f4-0ef7-aca3a2ce0a66@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2018 11:01 AM, Ramsay Jones wrote:
>
> On 15/06/18 15:30, Derrick Stolee wrote:
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   ewah/ewah_io.c | 26 --------------------------
>>   ewah/ewok.h    |  1 -
>>   2 files changed, 27 deletions(-)
> This duplicates Jeff's patch #3.
Thanks. I got a bit hasty as I was working from 'maint' and didn't 
double-check.

-Stolee
