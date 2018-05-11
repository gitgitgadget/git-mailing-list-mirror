Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1F41F406
	for <e@80x24.org>; Fri, 11 May 2018 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeEKRXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 13:23:33 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:40002 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeEKRXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 13:23:32 -0400
Received: by mail-qk0-f175.google.com with SMTP id h138-v6so4947429qke.7
        for <git@vger.kernel.org>; Fri, 11 May 2018 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eVtPpta6xmHMuYg9B2ivUQVn7fjOdTZgSdTmk8CMPsw=;
        b=gQAahF9BZj8HPxuVtUU9c6AbxE2qx0fYyK+m/L/gXOQ85CAxBsHzHsdZ9Ep6A5E5pM
         PBHf1/yt0Gyq4O35R9JQdT2Xs2OeRJ/tAR0pVEEHfv8QxuoNjM1n/TRapcr6NtuqRTW1
         QBG6pWFQnv/sinTBDGg4aXGr2ke2YVGAqe/cA90pVM+IboYK6KgaKX2r0NZoOpfEuz8W
         m1lLFP6O3oaJKQxh5i5k/uc2XDcp6dRC21O4DeJ0gdzi/0JA1Gmfw4CkOg35Kd+nY/Sz
         STw2UUBVhuu7pfEJlkSAhrpi/ZBKJZRFuD+4AErn8oRfgysLQzogJjB7dvwyx3lq2/QL
         rQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eVtPpta6xmHMuYg9B2ivUQVn7fjOdTZgSdTmk8CMPsw=;
        b=p5hX/2CNglB+fzrFlmU4PKCFIXQqhT3DHDf6JyX+Z27Si4QWuhp6XL+Z8nxbMPqGVE
         7y1psNrXgOVGq3PztUCHYPEaXGALsNARBktQS2ksRN1qNjNXt2PFcc0xFXOZAaxmNZJn
         9gEvvLJB9qFNTBTQRVNpGfHoOBgAqNL8wF01L/gzfJUtGsxj8tkma1KrLn2TISkPuC16
         tsNOh9EofXNI7o2bFT3tpHbnixNT4sNjKlTBfgj7bOy3zHndTIs4jaeSWojWBQDbvtOz
         1SE6pI7o5fg0z8FqfZzN9zV0d5Z6MlQ9OASsR/hni+hXxrSBIOzsuJiUzVb6DVYmbYi8
         iVRg==
X-Gm-Message-State: ALKqPwe5HziE6sdeW0Z/BqI2xU3vDQPEA8OBPPR/EqVjwN6Er1CpNL9L
        8ggOGjRID78RPty/dxSqSlY=
X-Google-Smtp-Source: AB8JxZqbLYZK3P3kMx50txRcTwrSjdisll+L3EElxBDXHyCVMMSB59pAViJjGXzd+QPKTO1lJs8Uuw==
X-Received: by 2002:a37:8c82:: with SMTP id o124-v6mr6077238qkd.209.1526059411727;
        Fri, 11 May 2018 10:23:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b3-v6sm2788939qkd.5.2018.05.11.10.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 10:23:31 -0700 (PDT)
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
 <CAN0heSo-1+BvE0SiZMKT1zHZ4o+-mK0W9S+xxDA4Pyw3iTvpDQ@mail.gmail.com>
 <CAGZ79kY1m_6AdUoRx1L2=HzX7hG_uUUcYnLsb=VNdxPcvnpOEg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb3de182-c939-022f-92ed-3449e220af59@gmail.com>
Date:   Fri, 11 May 2018 13:23:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY1m_6AdUoRx1L2=HzX7hG_uUUcYnLsb=VNdxPcvnpOEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2018 3:22 PM, Stefan Beller wrote:
> On Thu, May 10, 2018 at 12:05 PM, Martin Ågren <martin.agren@gmail.com> wrote:
>> On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:
>>
>>> Commits 01-07 focus on the 'git commit-graph verify' subcommand. These
>>> are ready for full, rigorous review.
>> I don't know about "full" and "rigorous", but I tried to offer my thoughts.
>>
>> A lingering feeling I have is that users could possibly benefit from
>> seeing "the commit-graph has a bad foo" a bit more than just "the
>> commit-graph is bad". But adding "the bar is baz, should have been
>> frotz" might not bring that much. Maybe you could keep the translatable
>> string somewhat simple, then, if the more technical data could be useful
>> to Git developers, dump it in a non-translated format. (I guess it could
>> be hidden behind a debug switch, but let's take one step at a time..)
>> This is nothing I feel strongly about.
>>
>>>   t/t5318-commit-graph.sh                  |  25 +++++
>> I wonder about tests. Some tests seem to use `dd` to corrupt files and
>> check that it gets caught. Doing this in a a hash-agnostic way could be
>> tricky, but maybe not impossible. I guess we could do something
>> probabilistic, like "set the first two bytes of the very last OID to
>> zero -- surely all OIDs can't start with 16 zero bits". Hmm, that might
>> still require knowing the size of the OIDs...
>>
>> I hope to find time to do some more hands-on testing of this to see that
>> errors actually do get caught.
> Given that the commit graph is secondary data, the users work around
> to quickly get back to a well working repository is most likely to remove
> the file and regenerate it.
> As a developer who wants to fix the bug, a stacktrace/datadump and the
> history of git commands might be most valuable, but I agree we should
> hide that behind a debug flag.
>
> Packfiles and loose objects are primary data, which means that those
> need a more advanced way to diagnose and repair them, so I would imagine
> the commit graph fsck is closer to bitmaps fsck, which I would have suspected
> to be found in t5310, but a quick read doesn't reveal many tests that are
> checking for integrity. So I guess the test coverage here is ok, (although we
> should always ask for more)

My main goal is to help developers figure out what is wrong with a file, 
and then we can use other diagnostic tools to discover how it got into 
that state.

Martin's initial test cases are wonderful. I've adapted them to test the 
other conditions in the verify_commit_graph() method and caught some 
interesting behavior in the process. I'm preparing v2 so we can 
investigate the direction of the tests.

Thanks,
-Stolee
