Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8F020248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfBVUAb (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:00:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52424 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVUAb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:00:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so3038087wml.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lZ+djjaY6snwmBw/pwsuypwMDBSa/2REZZpOwFphpDE=;
        b=XlR6rnikaVq9O8wOOqw8BReU+p/8A8xrvnPDInyFv96qBL6yaEs5kX0loQwGkCkR2r
         R0laD/dhKkYxdjqt6leZ11FYZdQp+wcRY1CgCjwp2jGUaW+isrOrDYoavROSm9x9txpM
         sJyoqycP0Qfht1fUGxbYmjFKhLtVTU+3eRQDVhs/fCy35NoUdBDXgnRAo9+hwjg8W0A0
         Onr566lSPCEJ44ALwoumQAxMgJv8n3rofrqa2FZPVLQwAr96uIxiZJ/xn4VUA4zAgPW6
         YSBWhyCLHVYReC11KHYi31OQUBuxa4HlxJ6Z7sKrIuXKJIv7HeILYGw4iRIK4wNwnw+q
         uB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lZ+djjaY6snwmBw/pwsuypwMDBSa/2REZZpOwFphpDE=;
        b=tii9v0IVXB5xNZfBM1lgHjfm/etkswq1QDoOMDj+j58/xtumuj8Ns7PP7DH3v774Z0
         sheOTv/VLex1mAHKwCAhPN5HiX8kPbDoP60lLc8zweSzhSi0xDSYDdnN6OmTNXA7FIoV
         tK7TLCnOleagA36Qs08ppbuDailx9yjw49fTIxM3lbTiBd46qZwJ6FAVkuEkfjLsH7xe
         MlgcAqWG4k5Hp21TCjj9+/gGPA4P6KJFNUmwjgIHGf9RxKWOALF05ZceSj8Cy0ZBwTSS
         lfEvM97gB+JiT0XWjN9h0ikKxDAHfo1+VbRg1RaeKavWjBzeKqLZRiTBr62Ojoj+mYiY
         D/og==
X-Gm-Message-State: AHQUAuaNhbq1yKIuSurvES/GAAqSHx7ak0oKxpkCm+yvUyrNWTm+Qs+b
        s/5NoL4Qsf+pk4K1EZsHAYUU9ViT
X-Google-Smtp-Source: AHgI3IYELdGgqAT4Uj5oNx4UIsVOCnG7wtMPSxOTm0EsVuMSZi1/91WCdQ8nYZOQ1GfRLD6NolnK2g==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr3392671wmc.129.1550865628213;
        Fri, 22 Feb 2019 12:00:28 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p6sm6831713wre.63.2019.02.22.12.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:00:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Ideas for even more compact fetch.output=compact output
References: <20190125095122.28719-1-pclouds@gmail.com>
        <875ztc5evt.fsf@evledraar.gmail.com>
        <CACsJy8DJvxuhVJBpgTNiFHt+0ZOFqm4agvxrJfa2D1jvDojaRQ@mail.gmail.com>
        <xmqqftsfr8hw.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 22 Feb 2019 12:00:25 -0800
In-Reply-To: <xmqqftsfr8hw.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 22 Feb 2019 10:19:39 -0800")
Message-ID: <xmqqr2bzpp9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> If we had this:
>>>
>>>     From github.com:git/git
>>>        a7da99ff1b..28d0017056  next                -> origin/*
>>>      + e911e946c2...9cc6aca6e9 pu                  -> origin/*  (forced update)
>>>        a7da99ff1b..28d0017056  refs/[pull/412/head]  -> origin/*
>>>      + 1dbcd06490...6b1f08d3ef refs/[pull/412/merge] -> origin/*  (forced update)
>>>      + e911e946c2...9cc6aca6e9 refs/[pull/444/head]  -> origin/*  (forced update)
>>>      + 8131760e3b...ed5bbbbcec refs/[pull/444/merge] -> origin/*  (forced update)
>>>
>>> We could de-duplicate such output. I.e. used [] as "capture" delimiters
>>> for the subsequent "*" since "[" and "]" aren't valid in ref names (but
>>> "()" and "{}" are!).
>>
>> First impression, I think the square brackets makes it harder to read
>> the left column.
>>
>> I was going to suggest coloring, which could be used to highlight the
>> common parts. But I think that would mess it up even more because it
>> kinda steals focus.
>>
>> Another option is simply display refspec on the right hand side, e.g.
>>
>>  refs/pull/412/merge -> refs/*:origin/*  (forced update)
>>  refs/pull/444/head  -> refs/*:origin/*  (forced update)
>>  refs/pull/444/merge -> refs/*:origin/*  (forced update)
>>
>> This keeps the right column boring and mostly the same without losing
>> meaning, while the left column is left untouched. It does make you
>> think a bit to find out what the actual ref on the right hand side is
>> though.
>
> None of the above, including the existing "origin/*" lets people cut
> and paste the left-hand-side (which is what is available locally to

Aw, I meant right-hand-side (i.e. knife hand, not fork hand).

> them) to a command line, e.g. after seeing
>
>      From github.com:git/git
>         a7da99ff1b..28d0017056  next                -> origin/*
>
> you cannot append "origin/next" after "git log .." with a few
> mouse-clicks.  As the actual object name after the update appear
> with the double-dot, "git log ..28d0017056" is also hard to create
> without dragging a7da99ff1b part from the output.
>
> Having said that, I do not do pointy-and-clicky cut&paste myself, so
> it would not bother me that much and any of these "compaction" ideas
> may be OK.  Using the refmap notation would start bothering people
> for perceived repetition of that right-hand-side, though.
