Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7334C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932486AbeAXUxR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:53:17 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40184 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:53:14 -0500
Received: by mail-wm0-f48.google.com with SMTP id v123so11109729wmd.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=s8UNpIxXC/CY2Y2TA0e0IY7wB9nC8LQfJKB+ttODNVI=;
        b=i5WrFK/67j1GnnE+ouAQau3dspCqxzj6CplNxl8WH5Zt42+5zWc0nVXNr8L1L0iq7Y
         +y9QfQZhqza6uDkvs8a1AiTpJRrc82LfZSNRbFnppU8vfEIasTj8Kvvb0LS8mGpHWTwu
         tLBDWKASDjmdwrTOp2CfFm7Htw0accN0ke5WZK1Fl2wsJp+LoqqhAvOgB/fWwoH9tezA
         qtWYKefkS/3TfZeOBnP5vzBimBygirh8XM4s1PcWcY6Lwn8OmQGm/f3u+mGP38EaQrc3
         Z37GYbLqoETnvP866Uo7o20pqX0OMj485hrFF7kqiS+yC/8/SpylzOS3h6y5sCxUIckn
         rGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=s8UNpIxXC/CY2Y2TA0e0IY7wB9nC8LQfJKB+ttODNVI=;
        b=cTYw0ste7FaHgfnsiDoFF52blwDT40+3UoPDjK4vLKqdm9eiNxAfPFymLc9phWFEHi
         NRVjO0gUkawwIqnmuWnEPVmJQ0IZPqFyRA02jhu0s23Mf8VZAs0R0y6eOi/qbKPK4Szq
         2Yr7R8ShIEh/2Fx3B5m/gRjivSVT/DrSs2pRePQd0jMPAj9Z8fD9wSVIWZrXxwDXh6mu
         VSW2beA9XIIKBce2p9nuav+V5FQ6YNb0Y/p/fjyEUTqxSwm/iXGGxKfcD1bfSwkAZUU8
         OTm2MjaSXbsNiOyRBucUZvHetpMD+cSape1IHWdJMgW2/oemUUfL0YVHZo9NlXc76IqO
         4rGw==
X-Gm-Message-State: AKwxytfb1k0I8BrsUwwrMKJPE3M33lXJ5OeP2lqN0hGVXrABKFjWjAp/
        9gGGbBQfAcxzNhugtOFI8nDLDwlZ
X-Google-Smtp-Source: AH8x224MVK8ITHKeN7kb6s/+tXhdCRYmPKNWE0ep4pzvbeuK3us6l1Bw39f5nohJx//6djmoTz2lmQ==
X-Received: by 10.28.214.67 with SMTP id n64mr5217466wmg.25.1516827193767;
        Wed, 24 Jan 2018 12:53:13 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id f13sm2690610wre.84.2018.01.24.12.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 12:53:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Isaac Hier <isaachier@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Implement CMake build
References: <20180123001648.24260-1-isaachier@gmail.com> <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com> <xmqqpo5zdrgm.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqpo5zdrgm.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Jan 2018 21:53:10 +0100
Message-ID: <87a7x3kmh5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Junio C. Hamano jotted:

> Isaac Hier <isaachier@gmail.com> writes:
>
>> I realize this is a huge patch, but does anyone have feedback for the
>> general idea?
>
> I personally am not interested, especially with the justification
> given in the cover letter.
>
> Perhaps the one in this patch may be "mostly complete", and I am
> sure you can make it "complete" against a frozen target, but it is
> unclear to me how you envision keeping the completeness up to date.
>
> Whenever a developer needs to introduce a new build knob, the
> support for it needs to be implemented in not just Makefile but now
> also in this other thing.  Unless there is an automated
> bi-directional gateway to allow those who have been writing and
> reading Makefile not to worry about those who wants to build with
> CMake, and vice versa, you are forcing everybody to do the same work
> twice, no?
>
> Choice of build procedure for a project is like choise of SCM to
> store its source file.  If the new system is 10x better to make it
> worthwhile to educate everybody to use it, switching to a new system
> and ditching the current one *is* a reasonable thing to propose and
> consider.
>
> But I do not think you are proposing to switch, and I do not think
> you are convincingly arguing that it is 10x better than the current
> one, either.

There's more than 400 lines of instructions at the top of our current
Makfile. Most of that is of the form "if your system has/doesn't have
so-and-so, define so-and-so".

For whatever reason we've decided not to make autoconf a hard
dependency. I don't know/remember what those reasons are, but if we
could get *some* build system that could use compilation results to
drive its build that would be worth it.

I don't know if cmake is that system, i.e. if we could waive a magic
wand and replace our current build system with it whether we'd still
need a fallback Makefile on some platforms. Is it as portable as GNU
autoconf & make? I don't know.

It would be very nice if git's build system wouldn't require patches
like my fb95e2e38d ("grep: un-break building with PCRE >= 8.32 without
--enable-jit", 2017-06-01), which is only needed because we don't have a
way to run a small C program to determine what the value of something
like NO_LIBPCRE1_JIT should be.

Well, we have it *optionally* with autoconf, but as long as it's
optional we don't save ourselves any time, and from packages I've seen
in the wild most people who build git don't use it, so it wouldn't save
them any time either.
