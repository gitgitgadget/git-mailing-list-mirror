Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA271F404
	for <e@80x24.org>; Wed, 15 Aug 2018 05:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeHOIsK (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:48:10 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38957 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeHOIsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:48:09 -0400
Received: by mail-ua1-f65.google.com with SMTP id g18-v6so173591uam.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJWnLpFBh8RKh0y/sbE5nYU/ZGzsub2Q/dprQTGkMo0=;
        b=hq3t6sZnDBI5qauia8NPwf+7wMTcZZIWaYTAWmJ6ICvcvqyEMKR2V1IN7LpouB8aB1
         4QJU9qCY5ekMAS4XaHL6Q8bLDQnEsMneEDWRyq6bD4fzLUtRx57IEgdS5ebXEEYsdTFl
         QfmykHzKrCWzX/qeztyI0HuEEVgtdtAmnhfjg6rf4eYW98mftT2VRXHoVOBU3OyTudZj
         Ye1FgoR4TTKgN7lQPPeucpvW3hDnrWHU1wbycsh2Ki8yBkAnfSLgCUEFTVmPR3zvI4Q3
         Aqr0Pko2sFQFyO/QHCR876wdHHaxZlvHUStbDhnU1EKtCl3zEGNYLujxamSNztrLEK3U
         7btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJWnLpFBh8RKh0y/sbE5nYU/ZGzsub2Q/dprQTGkMo0=;
        b=ZiWiFF8BT862boGJftjkQbF/F1leRXLDT8+xRGWrLbfBnZV7U7FGel+wg20rXUUdCH
         S46PA9GvDURFoN+f57cImS1lZFq+vCwBDWpA/TaDfVgVUxMjddcfO2AoGo0Z5W8+YgNZ
         NPbeZ2bloaehX7Q1FWedL0QLuMOJgghttPUj+vK6L9Tu21RK1eW6DWfqaASLwJ51abaU
         X4QdHgq01d/aA78sipAP4WgECsYk+wt9FrCVrOnuyo0U9V5s+7db7r4wKc7ugiyfmwka
         VF7JxzGSulTq30C+UmChvNJ0fYA53uWXsS6WWbdYt46bEEKVPG2nf8nBvky/QLQV21QO
         AC7g==
X-Gm-Message-State: AOUpUlGG+VH25y/AQ7Svhf/cHEn6Nnw/AZsoqLUdB3U0WfU4abBw4qit
        Ss2S3iOJY0SDyC6s49TMc7m0fC8Qb9R8QLKb4Mw=
X-Google-Smtp-Source: AA+uWPxrJHJYikakvu8PNh2VV5gzyKskbwUsMGSCvLpljtTazD85zHuFMCUKeQNR5FRxnZCIDIXIVbQiQdB1TxSvSdY=
X-Received: by 2002:a1f:8c2:: with SMTP id 185-v6mr15777600vki.51.1534312644597;
 Tue, 14 Aug 2018 22:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180811043218.31456-1-newren@gmail.com> <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
 <20180811173406.GA9119@sigill.intra.peff.net> <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com> <xmqqftzgxjww.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftzgxjww.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Aug 2018 22:57:13 -0700
Message-ID: <CABPp-BGtuxmeLTFTmsRvaK6J0jA9Sa3wx3rR0Ov8nJkxL4aqqA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 10:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > On Mon, Aug 13, 2018 at 11:24 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> Jeff King <peff@peff.net> writes:
> >
> >> As things are slowly moving out of the so-far kitchen-sink "cache.h"
> >> into more specific subsystem headers (like object-store.h), we may
> >> actually want to tighten the "header that includes it first" part a
> >> bit in the future, so that 'git grep cache.h' would give us a more
> >> explicit and a better picture of what really depends on knowing what
> >> the lowest level plumbing API are built around.
> >>
> >> > So I think the better test is a two-line .c file with:
> >> >
> >> >   #include "git-compat-util.h"
> >> >   #include $header_to_check
> >>
> >> But until that tightening happens, I do not actually mind the
> >> two-line .c file started with inclusion of cache.h instead of
> >> git-compat-util.h.  That would limit the scope of this series
> >> further.
> >
> > Yes, this removes about 2/3 of patch #1.
>
> Sorry for making a misleading comment.  I should have phrased "I
> would not have minded if the series were looser by assuming
> cache.h", implying that "but now the actual patch went extra mile to
> be more complete, what we have is even better ;-)".

Ah, gotcha.  Thanks for the clarification.
