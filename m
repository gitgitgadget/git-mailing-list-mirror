Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535FC20248
	for <e@80x24.org>; Thu,  4 Apr 2019 07:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDDH4v (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 03:56:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36042 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDDH4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 03:56:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16so1309556edr.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uafBjO/fP12KCyJnaSsoIWi0fqoUgTnd4ziSA82uf8=;
        b=SbpNqB6s4cO7tAOadiHAnVGyUWPQ1ps++e+km3UkumnCnG0o+RUmicnyAi2XrWypV2
         ANt2vw0xEnvlbF4yk1Jp1NTe+fSw1YWzDO3HO1nkUiQ6Vk3AK1jpINSrgGUV0QkeLxUK
         dhwjVuL34Q1yyz5gP5Fb+6S1U3R630jNbATO34K8Qq1Ac00JrijinBXaB23in+V/crRh
         X6cCE0/uDEQOC2neFNShUfHOQSOd4YgRc8RP4JOV3dVsfL3BystCjJwiTovwLtmK+FNy
         08kEB+Ezg4EvGh1feYqrxaGIqu+iax31CY8pKE+ya2yKKx5WmhsdRL1CsjDG3Nm9G0Sw
         leAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uafBjO/fP12KCyJnaSsoIWi0fqoUgTnd4ziSA82uf8=;
        b=DJI0I1axMPREO69yokHR42p4Sb8oNgsPoT1sPe3mNtI2PZbIToVc2FlbDJPioqTBCu
         11wM5Q2SkTJXUeRcqM3f7yO1bHpDSRCLivpJjUaNY6b8wcP/FkUkH8kj4Nv4CzV9fIbq
         MbhZth9jxVf27/4SM/taOHSLZzLiTp3wE3uBWl17ERuhh/HvYu9k4lMoyxzNEvM9iS8p
         iAl9P2GdMehn3I1TDCi4lN8CcgdgHIxHK78UuArbu4rs1wnRLlogBNL0YbH0Qnw3yKPc
         Wv8BmWLjkIEDY1uALTmTe0366BNcU6mgiKWBLtNTAtjuhF29EVkI4//eEC83joKCGjD6
         BiRw==
X-Gm-Message-State: APjAAAX7yyI+bAi85XwyJQlxYGZtWEdqavl5WUNUi/ZwftvFbnGchxu0
        uZkmyIdA3SX/mkwndD8ew3eKyuhKqrXI4M9YOkE=
X-Google-Smtp-Source: APXvYqwsslgSoig7Vy4a4AeHevwzapZHreT3hwBB0lEO35roeuik3KHru8EXVHKHfS0pPcS+i2EtP0EmV80XQyR68cE=
X-Received: by 2002:a50:9b50:: with SMTP id a16mr2843141edj.160.1554364607115;
 Thu, 04 Apr 2019 00:56:47 -0700 (PDT)
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
 <CAHd-oW7fXbJyxesgCoiTOWGLH9Tpk5FUN7VsaBrqU842BJpT3Q@mail.gmail.com>
In-Reply-To: <CAHd-oW7fXbJyxesgCoiTOWGLH9Tpk5FUN7VsaBrqU842BJpT3Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Apr 2019 09:56:35 +0200
Message-ID: <CAP8UFD33xf8FMuVNakzaUhYXo3A2fnvBAoFgoDQUOKgqnWYQBw@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
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

On Thu, Apr 4, 2019 at 3:15 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I've been studying the codebase and looking for older emails in the ML
> that discussed what I want to propose as my GSoC project. In
> particular, I found a thread about slow git commands on chromium, so I
> reached them out at chromium's ML to ask if it's still an issue. I got
> the following answer:
>
> On Wed, Apr 3, 2019 at 1:41 PM Erik Chen <erikchen@chromium.org> wrote:
> > Yes, this is absolutely still a problem for Chrome. I filed some bugs for common operations that are slow for Chrome: git blame [1], git stash [2], git status [3]
> > On Linux, blame is the only operation that is really problematic. On macOS and Windows ... it's hard to find a git operation that isn't slow. :(

Nice investigation. About git status I wonder though if they have
tried the possible optimizations, like untracked cache or
core.fsmonitor.

> I don't really know if treading would help stash and status, but I
> think it could help blame. By the little I've read of blame's code so
> far, my guess is that the priority queue used for the commits could be
> an interface for a producer-consumer mechanism and that way,
> assign_blame's main loop could be done in parallel. And as we can se
> at [4], that is 90% of the command's time. Does this makes sense?

I can't really tell as I haven't studied this, but from the links in
your email I think it kind of makes sense.

Instead of doing assign_blame()'s main loop in parallel though, if my
focus was only making git blame faster, I think I would first try to
cache xdl_hash_record() results and then if possible to compute
xdl_hash_record() in parallel as it seems to be a big bottleneck and a
quite low hanging fruit.

> But as Duy pointed out, if I recall correctly, for git blame to be
> parallel, pack access and diff code would have to be thread-safe
> first. And also, it seems, by what we've talked earlier, that this
> much wouldn't fit all together in a single GSoC. So, would it be a
> nice GSoC proposal to try "making code used by blame thread-safe",
> targeting a future parallelism on blame to be done after GSoC?

Yeah, I think it would be a nice proposal, even though it doesn't seem
to be the most straightforward way to make git blame faster.

Back in 2008 when we proposed a GSoC about creating a sequencer, it
wasn't something that would easily fit in a GSoC, and in fact it
didn't, but over the long run it has been very fruitful as the
sequencer is now used by cherry-pick and rebase -i, and there are
plans to use it even more. So unless people think it's not a good idea
for some reason, which hasn't been the case yet, I am ok with a GSoC
project like this.

> And if
> so, could you please point me out which files should I be studying to
> write the planning for this proposal? (Unfortunately I wasn't able to
> study pack access and diff code yet. I got carried on looking for
> performance hostposts and now I'm a bit behind schedule :(

I don't think you need to study everything yet, and I think you
already did a lot of studying, so I would suggest you first try to
send soon a proposal with the information you have right now, and then
depending on the feedback you get and the time left (likely not
much!!!), you might study some parts of the code a bit more later.

> Also, an implementation for fuzzy blame is being developer right
> now[5] and Jeff (CC-ed) suggested recently another performance
> improvement that could be done in blame[6]. So I would like to know
> wether you think it is worthy putting efforts trying to parallelize
> it.

What you would do seems compatible to me with the fuzzy blame effort
and an effort to cache xdl_hash_record() results.

Thanks,
Christian.
