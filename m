Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8194CC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbhLTTSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhLTTSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:18:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC42C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:18:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z6so8844762plk.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tVslMDJKbf3Jy689oZkdkWN8TKuS6LaNk3RsYcK3N6U=;
        b=jfVWvoYLvzC/4ii5A+myaRl2bOxsfKpqshQng4scaj8t7kXBfdRBc/bn2TGUX5+36D
         oisRYkV69ENr/bi17lo5zxzPkyVSra0DWwiRSBHTDmWpI0s2lqeuQ7OKOLjify8wHIqE
         xYTLRMCNO98qQ7jxVND3iaCDXO03pE0nrwfOdAzp50HTA2Q1hvXjnL+J76HL4pZimsLk
         UQIvhCda5+FRO2EsTqccKoUojuLhBTetrDkKAuhzSiWKZd+epGggj5gAfjvcNvXUYugo
         5huqp8pJ4GYa3rIbcW6oeuZiZI54NPMZGCmXvpHjV2DZybg/TQMD0VpvWnJSiPtyFCte
         +b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tVslMDJKbf3Jy689oZkdkWN8TKuS6LaNk3RsYcK3N6U=;
        b=oV/HdBdgAHQ0fvaNjU0hN8Roo2rIHk0LO1EGaifjqBCWgsUFok5gqoL9G5x66M/KaI
         ZudGBrI+gJff+tyS6qNe++mK/h9S0ViX3L0DXjzLmPAgGr6D0qrhOwOcS6/t/Xtd+JFe
         lsP7vTqetcbUlUwtBZuDQGK/tNgnwJqTVt+uoWWxmDCI18sgy6wzd0ScdVa7/XFwQYIa
         x0pghv6lA76lfSi7kGPyg+Q92Wmie0GuYEY8WTxUETVsiZ5D32pMNcRJic6RBtbezizE
         1hLESEeZ0VMeE0unwvnMWaox8omJlEx2Tv8b90UwCAaWvmBpnHoaKL+o6N8471m8/QUn
         vi0A==
X-Gm-Message-State: AOAM530RsBmCCOe2xaOR/XvJT4/cdbgY5d/w7bfVBMSUm39Nl+ZsbmAU
        vTpmmiNwZXrIfAacKVWY9iM=
X-Google-Smtp-Source: ABdhPJzFHd2BIoO/zAbZobPj5/iYSPClP9tdfTvJPfcRPYLmar6Pw7/XE0vCSaiGnCLJf36PA1JmYQ==
X-Received: by 2002:a17:90b:4a0f:: with SMTP id kk15mr501549pjb.33.1640027928249;
        Mon, 20 Dec 2021 11:18:48 -0800 (PST)
Received: from [192.168.208.38] ([49.205.83.141])
        by smtp.gmail.com with ESMTPSA id s16sm19409118pfu.109.2021.12.20.11.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 11:18:48 -0800 (PST)
Subject: Re: taking a break from Git
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
 <YbohRy22vBuDZsG4@nand.local>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b6961967-ce5b-d5ab-d44f-69ee58641837@gmail.com>
Date:   Tue, 21 Dec 2021 00:48:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbohRy22vBuDZsG4@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On 15/12/21 10:39 pm, Taylor Blau wrote:
> On Wed, Dec 15, 2021 at 11:38:25AM -0500, Jeff King wrote:
>> Hey all,
>>
>> I'm going to be offline and completely absent from the mailing list for
>> five months starting at the end of December. After that, things are up
>> in the air, but I may not be as involved in the project as I have been.
>>
>> Sorry, there's no juicy gossip or drama to share. I still like everyone,
>> and think it's a cool project. ;) After 15 years, it just feels like
>> it's time for a break and to perhaps apply my brain to something else
>> for a while.
> 
> I am going to miss seeing patches and review from you tremendously.
> 
> ...
>
> I am a better programmer and Git contributor directly because of Peff's
> efforts. I am sure that anybody who has been fortunate enough to get
> review or advice from Peff feels the same as I do.
> 

I could resonate with this. I've always seen you as a prolific contributor
who is able to provide valuable feedback to long-timers and newcomers all
the same. Thanks for all that you've done so, Peff!

> 
>>    - I really am going to stop reading the list. Even if you cc me. So
>>      please don't get mad if I don't review your patches, or respond to
>>      bug reports. :)
> 
> Please do ;). Enjoy your well deserved time off, and thank you.
> 

I hope the same too. Wishing you luck on your future endeavour, Peff!

-- 
Sivaraam

PS: I've been wanting to interview you for Git Rev News for
quite some time now. Looks like I've waited too long. Given
the circumstance, I don't wish to bother you with one. But if
you feel like giving an interview, feel free to let me know :-)
