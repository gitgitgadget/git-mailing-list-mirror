Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577EC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiCISnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiCISni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:43:38 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF536356
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:42:35 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o22so2649067qta.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8Z8a51f2OzBP0ddLFUm+iKJKY23WvMsqIUfe9tX9Wbc=;
        b=HUouS9Zzn+sDUFhUeBtdaiZn8NMQQUOV6pt/3b6vw1ylMopBlZuRVrYRUolCtEHKOt
         oru2IF0HPs6llr4bbBSCgi7bIDGF08Om8v9w2RK5ergIMaxbAeZ3D5mLhT3OkzQXvAcE
         YWsVL4HE1wmlRL6btu+3st7cWpxQCFNaqWlG6iqXC62pKKhU6A2TE5YhKOicwjPkWg/C
         gm84TD/JpP43NzFZSMVDo8oDFS4jWaiLxgBdHkhh2iqwgZRQ4053kYjQbV/rN6TF+t1A
         3wWJOpLX3UFNTleNH9VaBQfRUQVOabOue/YEehqqKqmrUCoywM3qz9rL7AnlLk2I9xTL
         rrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8Z8a51f2OzBP0ddLFUm+iKJKY23WvMsqIUfe9tX9Wbc=;
        b=TCApI6rC5/JaxFwWEWTwblbL5edQ9OHYdydzpEPtMJZhAayyeQ/z5owzWrgoFqPcjD
         AGcQvC5t7XxAfhzOKL37z3mtkkY9nVC+Vu/St4CHx3SXqYjReT7aHmILkg6Yc5EwA1tS
         5qwjXFf/jo+XAcQNESbSkfJCHtFIGGR+JP/msHQIYBizSozj3cAsoOeKUgcupCflWvjL
         eBn2EGDeb/9P9O52WKQTVSjQQno5U4oD454ae0C3CVh042g+sgedJtCB2VcRi5FJlGKQ
         yxmWUh1QCDis6D64g0xa970woY91aI2dLV4pgn+Ri0qnmqEbjs6hjAmD7gaw7jcUUFGd
         Ya3Q==
X-Gm-Message-State: AOAM530v3zjQsNb43tInpI5+fnjuO1lXaluJS6BzEE6OO0ZYY508fJkE
        6dORafiXE5dR1CJNVoWSlVIj89uQNINT
X-Google-Smtp-Source: ABdhPJz5NgELaiLj1OLKndVtEElgrhdfgjA50wA0Y1s13bWHz7gVXOAcA6KqbrEWlBk6Nxof9N00xw==
X-Received: by 2002:a05:622a:15cf:b0:2de:8dc8:6d5a with SMTP id d15-20020a05622a15cf00b002de8dc86d5amr961940qty.14.1646851354574;
        Wed, 09 Mar 2022 10:42:34 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a15d500b006097f0a8e13sm1227334qkm.119.2022.03.09.10.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:42:34 -0800 (PST)
Message-ID: <6555f3dc-e72c-2b0f-fe66-d81d48dff6f7@github.com>
Date:   Wed, 9 Mar 2022 13:42:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 25/27] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <5a0c1b7a2873accc6db4b34493962378819eacd4.1646777728.git.gitgitgadget@gmail.com>
 <af6c456a-d49f-e0f2-50ae-f44fdb6351e3@github.com>
In-Reply-To: <af6c456a-d49f-e0f2-50ae-f44fdb6351e3@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 1:40 PM, Derrick Stolee wrote:
> On 3/8/2022 5:15 PM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a set of prereqs to help understand how file names
>> are handled by the filesystem when they contain NFC and NFD
>> Unicode characters.
> 
> Prereqs look good and are well documented.
> 
>> +if test $unicode_debug = 1
> 
> Is this $unicode_debug something I should know from a previous
> patch? or is it a leftover from local debugging?

I see that you set unicode_debug = 0 in a later patch, but I
suppose that we might want this output no matter what. Or, do
we think it will interrupt the output parsing of 'prove' and
other tools?

Thanks,
-Stolee
