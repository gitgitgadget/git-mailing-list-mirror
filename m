Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97D420248
	for <e@80x24.org>; Thu,  4 Apr 2019 01:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDDBPe (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:15:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36108 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDDBPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:15:34 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so1065929itc.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KmVkAgmrHjU9B9kJQdmE78JxR+1qd7xSed+TGN+REo=;
        b=l9/q81WgXeFPX4xbKJBXUmJ7+IEwv2SG+ZpoXaCHMgeJuOmCWOLTEtGdkXo81Ib0Nu
         qmNaMg2Akb1/uxqnaSdrqf3Hk3B1ugmz4RQago01UfHaVecJuw+I8QsneeZ8o1yh2JjE
         gjHtoVuzav0UCfKM6Ts7nAY/PDxgni2zVgVAM6dAN4Ki9JeAXMsn39fvea4OTiQWc7g0
         sqIIOWHvmMiV3C0xfS/JGKYA5ABi0/6VUSZzjL8sA8duI1nTvswboi4WN4TICihZ8/TO
         P/o5UoMsx6y4/RBwE/Dla2/8GExIC+fYoh3z0xAP9ZATXGC69VF3TCSK/jPqZEN0UsAP
         Zwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KmVkAgmrHjU9B9kJQdmE78JxR+1qd7xSed+TGN+REo=;
        b=QwoYmIAk+rsDHAtKTIRruDtU8utzgiYC4HzxB5QCBa1ppPtvwX4WiGD4P5JyXX/HWZ
         dlcQBaDTHCvOV16MtZDf3SsDqPgHOiVETH6JA1+hKPEtHv/JySinUs0jkdB2SerDP4MG
         25Qy8+klJb+bMNKeZvnPW/gL8pck6P1SHlrsht3VoLo1Eit1eVVD43kzUEReyDe66vjq
         z3BOXOk1czabtzqEiu4HxExvUaW/A0bQAy5tm8Ekry3E3xHT1NIh8Tn8xtYY6dFOj0l2
         WdJWx8hRNhCIHJ3UHETbjl3NaN3zs1EeUwqLTOxZkqRHE3PyRV7kfypZ+oFBnrVP1eOr
         UwGg==
X-Gm-Message-State: APjAAAVTYTthGZbgDD97gxGWbNWpKxPmlEYDmV7vO6xvswO5khjAayAe
        MkD22cwUbHfJrxe9wwZOCgewcMGJyb2L2VTw5UAEwWR0H9I=
X-Google-Smtp-Source: APXvYqwVHT4EJn0cyeo5s0b2rbzpLPpwh4FLdJDfc3KPIec3ks8OBwv/miQZdkFuebOUHK3Vr4qnCHKca/RuxAO0MXs=
X-Received: by 2002:a24:7294:: with SMTP id x142mr2799336itc.7.1554340532699;
 Wed, 03 Apr 2019 18:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net> <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
 <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
 <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com>
 <20190312100237.GA20471@ash> <CACsJy8C=1dj-1T=5dt92LK5_Ario_YL2hkQWpi2dkhXyYY=_Hw@mail.gmail.com>
In-Reply-To: <CACsJy8C=1dj-1T=5dt92LK5_Ario_YL2hkQWpi2dkhXyYY=_Hw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 3 Apr 2019 22:15:21 -0300
Message-ID: <CAHd-oW7fXbJyxesgCoiTOWGLH9Tpk5FUN7VsaBrqU842BJpT3Q@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        David Kastrup <dak@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been studying the codebase and looking for older emails in the ML
that discussed what I want to propose as my GSoC project. In
particular, I found a thread about slow git commands on chromium, so I
reached them out at chromium's ML to ask if it's still an issue. I got
the following answer:

On Wed, Apr 3, 2019 at 1:41 PM Erik Chen <erikchen@chromium.org> wrote:
> Yes, this is absolutely still a problem for Chrome. I filed some bugs for common operations that are slow for Chrome: git blame [1], git stash [2], git status [3]
> On Linux, blame is the only operation that is really problematic. On macOS and Windows ... it's hard to find a git operation that isn't slow. :(

I don't really know if treading would help stash and status, but I
think it could help blame. By the little I've read of blame's code so
far, my guess is that the priority queue used for the commits could be
an interface for a producer-consumer mechanism and that way,
assign_blame's main loop could be done in parallel. And as we can se
at [4], that is 90% of the command's time. Does this makes sense?

But as Duy pointed out, if I recall correctly, for git blame to be
parallel, pack access and diff code would have to be thread-safe
first. And also, it seems, by what we've talked earlier, that this
much wouldn't fit all together in a single GSoC. So, would it be a
nice GSoC proposal to try "making code used by blame thread-safe",
targeting a future parallelism on blame to be done after GSoC? And if
so, could you please point me out which files should I be studying to
write the planning for this proposal? (Unfortunately I wasn't able to
study pack access and diff code yet. I got carried on looking for
performance hostposts and now I'm a bit behind schedule :(

Also, an implementation for fuzzy blame is being developer right
now[5] and Jeff (CC-ed) suggested recently another performance
improvement that could be done in blame[6]. So I would like to know
wether you think it is worthy putting efforts trying to parallelize
it.

Thanks again for all the support.
Matheus Tavares

[1] https://bugs.chromium.org/p/git/issues/detail?id=18&q=
[2] https://bugs.chromium.org/p/git/issues/detail?id=17&q=
[3] https://bugs.chromium.org/p/git/issues/detail?id=16&q=
[4] https://i.imgur.com/XmyJMuE.png
[5] https://public-inbox.org/git/20190403160207.149174-1-brho@google.com/T/#mb772910506e99e00337e4606f8377f95ef41c8c6
[6] https://public-inbox.org/git/87ftqz5osx.fsf@fencepost.gnu.org/T/#m9caa63d35d39de8d2b7c5c6852f331dc2328e1ea
