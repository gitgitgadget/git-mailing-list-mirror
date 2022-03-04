Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D35C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiCDPNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiCDPNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:13:46 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D87427EA
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:12:58 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so7654059otl.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4X4jx28DUg8Q0BMnGlm4XbWyPhqXE675BA6aDPyZBHo=;
        b=Oy47xwf5wjfqnNHjlsIDBMiBsIB9JSq0mxIX88aDnszy46EP3HkbAl3KAEKJvzHxY8
         BtT/QlxxDvEo9TwhxXA2516aOwvD3c67Fk4FsjCgH2STBvGddY+j7mCg3wSJwkzhuY1v
         9z1ea6gk+wO4Udb0GZHaMcKY7rJ2+OoFTe/J6KFIwbpipl09kLfqopG7+3inEeKUkEsR
         I7lVu/XsoPAktCIHzcMG37ZTabC8GiSeoNz7F73mP6qi/GaHqpdThaoVEVdyFEWIMko1
         KyIutjuPlULv/tjhHMsmRVnJ/+vZF4Um9vLSOiWPdMWM5QgpUF40v46M4gPs3LAgaCMq
         t0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4X4jx28DUg8Q0BMnGlm4XbWyPhqXE675BA6aDPyZBHo=;
        b=ksoCMH99i9nV7dRcD4cifhX6gNWlEbppD5ZBgx6NpiCuwtmhrSbn+lD++KX5nlhgvH
         qb9SNfduPkHgz88o8FcVJjg+dG3ve5+M+vhV9pG5jH/55EN8lwEz8ca8cCcovXBFaSGR
         67ssee68z+TIwtduHrpEUx3KW+jhF9jiZVaez+HxTUVjHewv++y6ZWjitGOkDKvbzPRK
         1I0oKtwGJ0pbIhURb4UknsJrc51MD0xlEbvCMccWJtWuKvYNzRGJ2KqJH0kbKnFWcP8s
         9S0c92tWpCgxI1HyqixKhDtdqVhgyxjFJ73kwuo6O+Ndywot8R1YqBVJL8uH2evK1DK1
         0UbA==
X-Gm-Message-State: AOAM532ZuTl6lXkJaswhyLIm7sYCCH3azUEe08atBI4kCa4ftfWU81q6
        Ioq39O0IRo3pH2D5Y3egnwX0
X-Google-Smtp-Source: ABdhPJzJbjJkMwnh+fILYqiogKukw2iOdKcZPTHe4SQrBg8qau2o+KJxWmzqaSod0+HFigWwLFfA+A==
X-Received: by 2002:a9d:462:0:b0:5af:9183:44bd with SMTP id 89-20020a9d0462000000b005af918344bdmr22839362otc.21.1646406777370;
        Fri, 04 Mar 2022 07:12:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q6-20020a056870028600b000d9be0ee766sm1731308oaf.57.2022.03.04.07.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 07:12:56 -0800 (PST)
Message-ID: <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
Date:   Fri, 4 Mar 2022 10:12:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
 <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
 <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
 <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 9:49 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 04 2022, Derrick Stolee wrote:
> 
>> On 2/24/2022 9:11 AM, Derrick Stolee wrote:
>>> I look forward to seeing your full implementation. There are many things
>>> about your RFC that left me confused and not fully understanding your
>>> vision.
>>
>> I am genuinely curious to see your full implementation of bundle URIs.
>> I've been having trouble joining the Git IRC chats, but I saw from the
>> logs that you are working on getting patches together.
>>
>> Do you have an expected timeline on that progress?
>>
>> I would like to move forward in getting bundle URIs submitted as a full
>> feature, but it is important to see your intended design so we can take
>> the best parts of both to create a version that satisfies us both.
> 
> Hi. Very sorry about the late reply. I relly meant to have something
> read to send at the end of this week, but it's been a bit of a
> whirlwhind of random things coming up & distracting me too much. Sorry.
> 
> I'm also totally on board with that goal, are you OK with waiting until
> the end of next week at the latest?

I'm OK with waiting, especially when I have a timeline in mind.
 
> Also, as noted in the upthread
> <220224.86czjdb22l.gmgdl@evledraar.gmail.com> it might be useful to chat
> in a more voice/video medium in parallel (maybe mid-next-week) about the
> high-level ideas & to get a feel for our goals, conflicts etc. Doing
> that over very long E-Mail exchanges (and the fault of "long" there is
> mostly on my side:) can be a bit harder...

I agree. I we can work out a time in a private thread and I can send
you a video call invite.

Thanks,
-Stolee
