Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8827B1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJXCfc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 22:35:32 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41336 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJXCfc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 22:35:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id j20so246382vso.8
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qpjjem9r7Tv8Z4Dj+dw6ZRnl3WcGf9naV89CLNng25Q=;
        b=ViIBmWRjJ2JsKYDYbrJsxbVJK1KMrsN56DmCLEGe+SxeFOy6CF25RsyJKgbAmiM+wb
         5Kf09I5F2q916q/mwLs/d09vBNkl5JalJVH+++xs/esIouoJoTHU2C4Whj/Amm71P5PN
         8h9lY43lwiTPBfptI48/9e0YiFwfk0ZQcjH4SwqL2UZmVNbjKS4BQ/K1anbxTGC5mMmf
         lku57adyKScuKTxXCSSwTCs+VW4O+USg6bsevhaxgACp8xvnCSbvRirq38dZJd+m+dx9
         GzfWSWyjWAcBivP/B+8OBvh8BQ3UwAPPmdvIKOnmfoqB+WqqzFNIQKRtkUIdretaNR7V
         v8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qpjjem9r7Tv8Z4Dj+dw6ZRnl3WcGf9naV89CLNng25Q=;
        b=LtOaxrJv8MF+ds8ngV5ZBGOUFL8elRg0Hch8S1wd66/NAr0ywFaAoOs0Z2tY/WFItw
         38iEf3dD2t6hUGNLLOKQPRKAdQiiZZnNaHd1GxBR3Cp9mBYV/N4FimKSDifP038YRVYq
         X4MY470aCHWLsjkL9IrR7J9j1FftGUyGkBcyBdET+y7THmrxc3scFuSEpErp9ceUF+VE
         9e/UXCG/QjyE1Q9hm4ju0rAThlbQBKB9YbvXEcKO+OBTwtHeqRRBkkFi0b3SGkaMn72f
         6cK5tddu9EaRjf0lBoWtj+Tun1JM426a7/Aa2mKuQLa71tvxNEhAfCqaFhzzCe4UKhd+
         3eEw==
X-Gm-Message-State: ABuFfoghmzfemgkjojtltuDwuMh0JCNysJ5zE9hKtwzyJujrN0wQMo8v
        vZffsB8YsuDVcIfFFEZDMWo=
X-Google-Smtp-Source: ACcGV60irgXRJYb89u+S3QI0SeopBCB3hVlKCWLD8grYSKz0roVD6S3Gy+/ruNLmenx27rN8fXKfwg==
X-Received: by 2002:a67:1fcf:: with SMTP id t76mr2814586vsf.137.1540318262846;
        Tue, 23 Oct 2018 11:11:02 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id q184sm555604vke.11.2018.10.23.11.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 11:11:02 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-3-peartben@gmail.com>
 <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
 <20181017182337.GD28326@sigill.intra.peff.net>
 <874lddc9fs.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
Date:   Tue, 23 Oct 2018 14:11:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <874lddc9fs.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/23/2018 5:13 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 17 2018, Jeff King wrote:
> 
>> On Wed, Oct 17, 2018 at 02:19:59PM -0400, Eric Sunshine wrote:
>>
>>> On Wed, Oct 17, 2018 at 12:40 PM Ben Peart <peartben@gmail.com> wrote:
>>>> Add a reset.quietDefault config setting that sets the default value of the
>>>> --quiet flag when running the reset command.  This enables users to change
>>>> the default behavior to take advantage of the performance advantages of
>>>> avoiding the scan for unstaged changes after reset.  Defaults to false.
>>>
>>> As with the previous patch, my knee-jerk reaction is that this really
>>> feels wrong being tied to --quiet. It's particularly unintuitive.
>>>
>>> What I _could_ see, and what would feel more natural is if you add a
>>> new option (say, --optimize) which is more general, incorporating
>>> whatever optimizations become available in the future, not just this
>>> one special-case. A side-effect of --optimize is that it implies
>>> --quiet, and that is something which can and should be documented.
>>
>> Heh, I just wrote something very similar elsewhere in the thread. I'm
>> still not sure if it's a dumb idea, but at least we can be dumb
>> together.
> 
> Same here. I'm in general if favor of having the ability to configure
> porcelain command-line options, but in this case it seems like it would
> be more logical to head for something like:
> 
>      core.uiMessaging=[default,exhaustive,lossyButFaster,quiet]
> 
> Where default would be our current "exhaustive", and this --quiet case
> would be covered by lossyButFaster, but also things like the
> "--no-ahead-behind" flag for git-status.
> 

This sounds like an easy way to choose a set of default values that we 
think make sense to get bundled together. That could be a way for users 
to quickly choose a set of good defaults but I still think you would 
want find grained control over the individual settings.

Coming up with the set of values to bundle together, figuring out the 
hierarchy of precedence for this new global config->individual 
config->individual command line, updating the code to make it all work 
is outside the scope of this particular patch series.

> Just on this implementation: The usual idiom for flags as config is
> command.flag=xyz, not command.flagDefault=xyz, so this should be
> reset.quiet.
> 

Thanks, I agree and fixed that in later iterations.
