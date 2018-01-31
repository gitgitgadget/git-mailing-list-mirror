Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2210A1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 00:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeAaAt3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 19:49:29 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32921 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbeAaAt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 19:49:28 -0500
Received: by mail-ot0-f193.google.com with SMTP id q9so835463oti.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 16:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ck2cS5Co2ohdSAnqbCK/kYj20HwA2+7c5xl/tbktqLw=;
        b=u2Cm1/uLW0XWJ8ByB1sqxPQ2CDPHCzHlPWP9Q2mtvOSlWqtpmyGy1ONmRLctvU516H
         Z7ypakx9AbceuV5iV8NqR7GdT+tD4vcGGvtDRWYtnf2f/kVD6cKEyrUL8munXTD4h9Xo
         /HYv+j0DkMeCIz6dBLaBoKmiQTALtmEIgl7+3YlIhHPNKCmI2l3g8sfHfMNYEdOTBGHt
         H0e6iazjpp89uCTg0l/soiirTCg4KsyxumhacQu4wRanZ/6RnLBzc2bCmlTJHCbHHmhS
         iM8ZQ6XOwRrJzUr6cr3qh/63wzxQe+TohQL+hIIgr/lNyA30yaaF9euFewFTaAelf5Ly
         fFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ck2cS5Co2ohdSAnqbCK/kYj20HwA2+7c5xl/tbktqLw=;
        b=C4QD54mBasfnftKiyPnKMeh661Yh7JJCAoK5g/r+p50pkep21oD8LGCvX1WXTtSORM
         Q273E2txWi4shWkHhzq8oKuINEnEnlEyA5pGQ5lzmJOtajdSZQqpDKdb6OlXyQqA5ReM
         0cZZrrzs1DyayePIdVtr3TWmPoL0nh43y0E5GoHWAU7pCaPPzoqf+7W+SYgVHvZ41nCh
         swJ7OC3QJdSQ9QtCIHsV6P3vx3BrUJ2xNlftvUQnM6O79GjwTtDjnHSkeC+ixp5UqYg9
         a/tdRKHYFDBpj1zeX05C1Ta8QVJty0FapSXCn3KbXD+smjl/WQ3TvM6kWDAipY9UczzP
         q6Kg==
X-Gm-Message-State: AKwxytdEkSigWKooPoLPUHOmX2mh6vSWfkfvV8+pmCCG5LyksWgt1zyL
        eC1YcupLmnq4wFLUS2PwVu4VCMlkEXbMa0IRlkI=
X-Google-Smtp-Source: AH8x226F11CZ7GRgoGo/lZBF4DRvgBz0F1YXhAUvOpCV22cTtVD/NkZ3QLe4JY25sFDxIS4D89k17GUYUC7rYH5GVTM=
X-Received: by 10.157.12.142 with SMTP id b14mr13637753otb.226.1517359768295;
 Tue, 30 Jan 2018 16:49:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 30 Jan 2018 16:48:57 -0800 (PST)
In-Reply-To: <CAGZ79kZ-hZzKtv05d5_7O2ndNZvGkU7qYnrn52zwpqSTqCiygQ@mail.gmail.com>
References: <20180129223728.30569-1-bmwill@google.com> <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
 <xmqq7erzrn3f.fsf@gitster-ct.c.googlers.com> <CAGZ79kZ-hZzKtv05d5_7O2ndNZvGkU7qYnrn52zwpqSTqCiygQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 31 Jan 2018 07:48:57 +0700
Message-ID: <CACsJy8C98HD59DGgqyWtZzj2RVqFe9GN=810A6fs2mMYBh_53Q@mail.gmail.com>
Subject: Re: [PATCH 00/37] removal of some c++ keywords
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 6:01 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> Is it simpler (though hacky) to just  do
>>>
>>> #ifdef __cplusplus
>>> #define new not_new
>>> #define try really_try
>>> ...
>>>
>>> somewhere in git-compat-util.h?
>>
>> Very tempting, especially given that your approach automatically
>> would cover topics in flight without any merge conflict ;-)
>>
>> I agree that it is hacky and somewhat ugly, but the hackiness
>> somehow does not bother me too much in this case; perhaps because
>> attempting to use a C++ compiler may already be hacky in the first
>> place?
>>
>> It probably depends on the reason why we are doing this topic.  If a
>> report about our source code coming from the C++ oriented tool cite
>> the symbol names seen by machines, then the "hacky" approach will
>> give us "not_new" where Brandon's patch may give us "new_oid", or
>> whatever symbol that is more appropriate for the context it appears
>> than such an automated cute name.

Well. the world after post processing is always ugly. But we could try
"#define new new__" to get the not so ugly names. new_oid is
definitely better regardless of c/c++ though so I could see that as a
good cleanup.

>>> Do we use any C features that are incompatible with C++? (or do we not
>>> need to care?)
>>
>> Good question.
>
> implicit casts from void?
> e.g. xmalloc returns a void pointer, not the type requested.
> https://embeddedartistry.com/blog/2017/2/28/c-casting-or-oh-no-we-broke-malloc

That causes lots of warnings but not errors (I bit the bullet and
tried to compile git with g++). The next set of changes would be to
reorganize nested enum/struct declarations. Even if nested, C
considers these flat while C++ sees them in namespaces. There's some
warnings about confusion with the new cool feature string literals,
but that's easy to fix.

There's also C99 designator in builtin/clean.c (I thought we avoided
C99, I can start using this specific feature more now :D)

I was stuck at the thread_local thing in index-pack.c and gave up. So
I don't know what else we would need to change.
-- 
Duy
