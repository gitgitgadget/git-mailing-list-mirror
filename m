Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCA820281
	for <e@80x24.org>; Thu, 21 Sep 2017 00:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbdIUAGD (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 20:06:03 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:49599 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdIUAGC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 20:06:02 -0400
Received: by mail-qk0-f173.google.com with SMTP id u67so4333578qkg.6
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NmVjiXbRnSF+X+/aAHJkhaNPAD7oYBc1vOrms3EaIEg=;
        b=s5fSzV2FYeCtTZCvwKDLUUTNHlkafNeyVUSlTwWM+QtpuFBrLMJVach+TkrT0b8KiT
         L163C20QTEXXEoIeJVw8Csa87UqiZG1O38a/NH38JaYCwl5vqeQJtIA5x3OY1JCR7bMp
         0qNFiVyCKGrT7Jp7T7zbbX8ZbN/Arqppzl6S2PkzLRBl8Z4XAtFab8/n4l4zR/TRYzPD
         0eqzNscN7yvonAmqUYEXGnHfAmBDWh2SVwVj7jKdizrnur15Q4+tNrIlOMOV9+QzqjgI
         VJDKJH/etu2/GjHScFtC9UywrKvvj/FFsJ07hDiKhV/llHuUvmuwRZWetWhdT/oiEM4J
         t+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmVjiXbRnSF+X+/aAHJkhaNPAD7oYBc1vOrms3EaIEg=;
        b=AhfADY0kHeXbtGq3nMrBxI/lHVtllddY+Uo8J5Al/w86VpFS4I06WTgc/HOEH8RZo0
         d/JzH2Fn29OMtBflQLNcX8Y7UN2v9WxZ204a82n4Em+WuV3zfraz/6Cxzf5s6ZYm7iBE
         2BattFBevlPT8Va+Je5U7jtNSD1mLYTVyNJM6kJEhcROeLZlaSBbm07BUCGHiMECB0S1
         eMnTdgkXaNHbGq61AWU2wQiI/cWR95+Dp74lQ39u6NeZ0tNCuc93HKOFS7uOnKkoIFuq
         fXslHP1TTJPKVEqhVhVDIGNTaV8Bbo+fvypKmYNJWBhNHuGVvdSRxZLLJrYAt5gtlW4r
         Rgdw==
X-Gm-Message-State: AHPjjUhWNCo0zpv1yqQzuZ8NOhUobVGUsWs+cEALWWIa3Tw8soNJs330
        X3qiOYoXvdNYg3RnSf/1PRk=
X-Google-Smtp-Source: AOwi7QBrdPXsODUFWTeRUbuMe9aXaa2L8InB8ftULz/KiN7Nksea0yY41KVC/aG1VXBmkr+WWHYbdQ==
X-Received: by 10.233.237.7 with SMTP id c7mr662280qkg.69.1505952362071;
        Wed, 20 Sep 2017 17:06:02 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m29sm104283qtk.58.2017.09.20.17.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 17:06:00 -0700 (PDT)
Subject: Re: [PATCH v6 09/12] split-index: disable the fsmonitor extension
 when running the split index test
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, johannes.schindelin@gmx.de, pclouds@gmail.com,
        peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-10-benpeart@microsoft.com>
 <20170919204354.GG75068@aiede.mtv.corp.google.com>
 <43c9d3b2-2895-adcb-6f77-b6967aacf9c8@gmail.com>
 <20170920174613.GA27425@aiede.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ee8157e0-1f82-2384-3742-1dd00ea4b58c@gmail.com>
Date:   Wed, 20 Sep 2017 20:05:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170920174613.GA27425@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 1:46 PM, Jonathan Nieder wrote:
> Hi,
> 
> Ben Peart wrote:
>> On 9/19/2017 4:43 PM, Jonathan Nieder wrote:
> 
>>> This feels to me like the wrong fix.  Wouldn't it be better for the
>>> test not to depend on the precise object ids?  See the "Tips for
>>> Writing Tests" section in t/README:
>>
>> I completely agree that a better fix would be to rewrite the test to
>> not hard code the SHA values.  I'm sure this will come to bite us
>> again as we discuss the migration to a different SHA algorithm.
> 
> nit: the kind of change I'm proposing does not entail a full rewrite. :)
> 
> The SHA migration aspect is true, but that's actually the least of my
> worries.  I intend to introduce a SHA1 test prereq that crazy tests
> which want to depend on the hash function can declare a dependency on.
> 
> My actual worry is that tests hard-coding object ids are (1) hard to
> understand, as illustrated by my having no clue what these particular
> object ids refer to and (2) very brittle, since an object id changes
> whenever a timestamp or any of the history leading to an object
> changes.  They create a trap for anyone wanting to change the test
> later.  They are basically change detector tests, which is generally
> accepted to be a bad practice.
> 
>> That said, I think fixing this correctly is outside the scope of
>> this patch series.  It has been written this way since it was
>> created back in 2014 (and patched in 2015 to hard code the V4 index
>> SHA).
> 
> Fair enough.
> 
>> If desired, this patch can simply be dropped from the series
>> entirely as I doubt anyone other than me will attempt to run it with
>> the fsmonitor extension turned on.
> 
> *shrug*
> 
> My motivations in the context of the review were:
> 
>   * now that we noticed the problem, we have an opportunity to fix it!
>     (i.e. a fix would not have to be part of this series and would not
>     necessarily have to be written by you)
> 
>   * if we include this non-fix, the commit message really needs to say
>     something about it.  Otherwise people are likely to cargo-cult it
>     in other contexts and make the problem worse.
> 

I'll update the commit message to indicate this is a temporary 
workaround until the underlying hard coded SHA issue is fixed.

> Thanks,
> Jonathan
> 
