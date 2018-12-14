Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB67620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLNCkP (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:40:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56151 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeLNCkP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:40:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so4240266wmc.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7g4ShaxZlrJLPr29NkZ6dp9JhnKMTFKJcoeOdlrWyoc=;
        b=ohERhrZ3WGz49BoANDvh800t9JBYaCbxtv5C2qGfNxCsudnNNCTIiif7k+FB7HjxEI
         BMEg2g9HYFJ+IX1LLIZqesZaptkvzObpGxRVsJdzanP0xRacKY314hOrCs8Zv036gDoL
         J4U22ZUmvF66aeqrODLHWjgzEfi2jBRxdunBLA8REjjg7YO2Uft4cV4Q7sdgURSscGU+
         igG5O5XDE1wRqKj0gCXavPCbtvIawG16Lg/FSUcWGpPd66lZNd4QMSK+lpr87B+Cjg5+
         MEozTKZa8Bw8HdPRD9DJeixatEgd6WoXtL7ocqjdf4oxoLtD+Bl1FJ8lyyBr3f8TH9IH
         ln1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7g4ShaxZlrJLPr29NkZ6dp9JhnKMTFKJcoeOdlrWyoc=;
        b=CI7yTn8MdUxcrj33J6F3ko6U4oPnWM88BeUxan3FcH675LOqTaU74G0Yl3uqL4oEDQ
         Hv3q2wvAnUpeHEs2K56Vt6i40CPERC6siB1E8ujThVtlTqN4Msai3ZA5bplu79R/HF05
         SyyaHybDKtl/yvRvZZ0uZiv7N2PStQooyhX2YvTL0J3M6/IoJoNiKCF1Qu0J3AirVST0
         W3tO09ghcdCuph//iJpMr86LWh/zvKg/SBP1F5aO7A7aBM6yWpyyAJIhzKGcGMTxhquy
         flcUDCvGp6X5UnodHFogzMZig9FmbUuTdYrMxkdQ/nT4HGIQo4HKnjB0V4kUyhwK3x/s
         SN5Q==
X-Gm-Message-State: AA+aEWaJPzH8jLFaNQFvijMvjuiMiQSfIoNBD69AH/D6oSmlW0e4VwhC
        0XZdozMdCmCptCDWRGGPgHk=
X-Google-Smtp-Source: AFSGD/VdUdDWOW3rcTvMs5+9e92ker/X5jp5+c8B9NUWY4zRb4jEpCeim0xYldWbmj/y+y157Vs+RQ==
X-Received: by 2002:a1c:541a:: with SMTP id i26mr1631354wmb.128.1544755213341;
        Thu, 13 Dec 2018 18:40:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm24180949wmi.3.2018.12.13.18.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:40:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Preparing for 2.20.1 brown-paper-bag maintenance release
References: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com>
        <87r2el1q0g.fsf@evledraar.gmail.com>
        <CACsJy8AB0gQAvAWh3vtiSFnZWXtdvQdi4czBoR2B8TkECMrQtQ@mail.gmail.com>
        <CACsJy8CexGXtyBa1oNP0jVx-+8JPTcfTd5wf1ZyfJWf8HDtLVQ@mail.gmail.com>
Date:   Fri, 14 Dec 2018 11:40:12 +0900
In-Reply-To: <CACsJy8CexGXtyBa1oNP0jVx-+8JPTcfTd5wf1ZyfJWf8HDtLVQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 13 Dec 2018 19:17:49 +0100")
Message-ID: <xmqq1s6kesqb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Dec 13, 2018 at 7:08 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> There's also a bug in my patch (-2 is already being used by
>> parse_opt_unknown_cb and my patch will change behavior of git-blame at
>> least in theory).
>
> Ah no. Too many magic numbers in parse-options.c code. It's working
> fine but I'll need to give these some names to avoid confusion in the
> future.

OK.

