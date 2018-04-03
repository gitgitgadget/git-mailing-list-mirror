Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75C61F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeDCSbi (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:31:38 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:39094 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDCSbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:31:38 -0400
Received: by mail-qk0-f170.google.com with SMTP id j73so19691011qke.6
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MbZT9b5RGD2+ZWs+pGwwfPQJUOR+laSxVSf91ZQash8=;
        b=PyhQzySERCIYxw5b/SX4TAbhY5fkHHMtEZVm3DQ0BHyMGtk5WAfIe9LzEGa4TpDJPo
         iBIZkCkCWrvH/h2Dtt3+acF+PSrcVQOtLu7yHOr6iFgBvGJ+NK/JTFdpRm10uS6CPp4F
         tKKVY6Iu7mEJMhLgyVaY9D3nYjx/q+lH+cMrvucnKR84t1mUZph7yrjb8QmmWC1fp/7p
         w4E2n01SSU2nX9NgRAsma3obCwgg93btIEluvN6nbIvdf1/n7rAI7+erOWpDx3NhzeTL
         VVJi6lO6OnQrHF1a2Nm7y5czOkISAsdf4X6iKGXDnhd/I4qcHt8L7M92WPEpNaBd6I4H
         xhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MbZT9b5RGD2+ZWs+pGwwfPQJUOR+laSxVSf91ZQash8=;
        b=gre3YdakABAcDH/vWAzTHIV9zrBGa8YXGOysDFE5IHOtcQOHLcJcj49g5EOA7Oz14X
         SIcwnDkN7gAr8MUIjDM3jb67qZ8AttxBEGxIv5lhfiFwLRpQLbFDBEpggGAgKCk41sB5
         3iXvWSt/GuUv6wszo95BO5APsAQn7ZH0amjQnOyAwtF25neJUtedoszGAazcYmQ9F6oT
         QiYfgcG2yIMEe3FwzmmAm9LgEB7dBQwwNQLgfTYoUwjut6p//TXOclgrjSPS8VMVBgGT
         amSkDGaJu/hH6h2IFE4gwZpsTaufvlAKhs9dxqm2dekVKgM9SbHryMVwo9ZrgYEk3CV7
         PzVw==
X-Gm-Message-State: ALQs6tCTJilsstSBfHyX8Jb3O1VmSAiNRtHyBhcXQPseQ04Z1uz+fcP6
        rYQ5Wdx45KTCmqdljKTDziE=
X-Google-Smtp-Source: AIpwx4+bpvvZ/4BYA9rxw/mC2fTTgK4m7kcl6dJs4OP1nX5Is35Kvz8MQ8Z5N1FfkJEjdwJLU25m+w==
X-Received: by 10.55.105.5 with SMTP id e5mr19851360qkc.141.1522780297217;
        Tue, 03 Apr 2018 11:31:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id c18sm840492qtp.0.2018.04.03.11.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 11:31:36 -0700 (PDT)
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
To:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-3-dstolee@microsoft.com>
 <20180403180536.GB100220@google.com>
 <20180403182800.GA8377@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2b5a08da-6b15-194e-4336-ce7c84240a9b@gmail.com>
Date:   Tue, 3 Apr 2018 14:31:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403182800.GA8377@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 2:28 PM, Jeff King wrote:
> On Tue, Apr 03, 2018 at 11:05:36AM -0700, Brandon Williams wrote:
>
>> On 04/03, Derrick Stolee wrote:
>>> The generation number of a commit is defined recursively as follows:
>>>
>>> * If a commit A has no parents, then the generation number of A is one.
>>> * If a commit A has parents, then the generation number of A is one
>>>    more than the maximum generation number among the parents of A.
>>>
>>> Add a uint32_t generation field to struct commit so we can pass this
>> Is there any reason to believe this would be too small of a value in the
>> future?  Or is a 32 bit unsigned good enough?
> The linux kernel took ~10 years to produce 500k commits. Even assuming
> those were all linear (and they're not), that gives us ~80,000 years of
> leeway. So even if the pace of development speeds up or we have a
> quicker project, it still seems we have a pretty reasonable safety
> margin.

That, and larger projects do not have linear histories. Despite having 
almost 2 million reachable commits, the Windows repository has maximum 
generation number ~100,000.

Thanks,
-Stolee
