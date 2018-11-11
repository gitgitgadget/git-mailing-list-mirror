Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AE11F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 08:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeKKSc4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 13:32:56 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35615 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeKKSc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 13:32:56 -0500
Received: by mail-ua1-f66.google.com with SMTP id d8so2063472ual.2
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 00:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGwbMKudGckvnoZBbQ+ymOvcdRLqrALmzVMR2ekzR/g=;
        b=pHWWcR394hyoQROWn1X4w1NNaRHgU2RhJ+wEkrlUvFg6nzTfn6RNNXWTRrQX0muDZJ
         peIvNHOu1Lmxzl4CYJoM8TZF52lVllbr9C196KM2W1ghAaP4l2Z7Uiqea5949dSVctjz
         S9XkO7dFXnAI2Trj0nJWUwYvEb1VfpPU1JSnegNEPaNSQ151Ho9Ys0OMLVzAp6zeqosX
         UJqGE2tjW1L758ITA5uQEFzo7PAApiZSb7yUPHqVBrubH2sLCXUlYxCkSQ9Cij0mBiSf
         Kh6LapDp7G2ziosWDQw9R6KTWkY9frtml4q0YhDZGJxGm5ScChOjDxgL9Vq4E6y0oqJa
         lICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGwbMKudGckvnoZBbQ+ymOvcdRLqrALmzVMR2ekzR/g=;
        b=UCa18U9sGa5uV8M7yM0oRDvSIhFKdhX4x6xyWd6pnuVfUcCHcnOGEemz0CCsLCiJz0
         XSzwZ4gKpTuy954DIA/6TYrzOBRdQpliRcDqRX+/PiEjllBKEh87zPTHv9fAT0Ih7vP0
         ahcAnn1RvIaMtG9PeuIvFPvYcB/loo/A2rTyQ7tGGC4Qc1U+VWXe5ZuzVTaFBlr4No+h
         4OLu3ri1KENKFKP3aTszpnCsxiVMkD/Pd+0VTdeaOKNeJqatuWIJhKwFOx9xY4z+xUcO
         pAQtvONv4BwrgtC09zVjEmW5l+toboT3mHfGHRcoViclLJsc/PBueJWAwuWaDNLYF4SL
         37qQ==
X-Gm-Message-State: AGRZ1gI+IsPav5P2vXAnEpUtJzNy0CMLaAl6IBl6+7Pi51a3XZOaUDuT
        av7IihoTGgcbIaSMSl/AYihn6RxAwMwZ57gYgWo=
X-Google-Smtp-Source: AJdET5c2hQiZCi75CAE8yQgHNizWfxvHLg8F0K15xRctAkex4R10mDWX+lXehjwVz0M9ekhDw4ywhSbNcSLmZ+g91SY=
X-Received: by 2002:ab0:465:: with SMTP id 92mr6912017uav.28.1541925898896;
 Sun, 11 Nov 2018 00:44:58 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111072716.GK30850@sigill.intra.peff.net>
In-Reply-To: <20181111072716.GK30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 11 Nov 2018 00:44:47 -0800
Message-ID: <CABPp-BGzqpxF_+ubp2cft9dQ-03pgcCxJEP13VOUv5WADHDjnA@mail.gmail.com>
Subject: Re: [PATCH 00/10] fast export and import fixes and features
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 11:27 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:02PM -0800, Elijah Newren wrote:
>
> > This is a series of ten patches representing two doc corrections, one
> > pedantic fix, three real bug fixes, one micro code refactor, and three
> > new features.  Each of these ten changes is relatively small in size.
> > These changes predominantly affect fast-export, but there's a couple
> > small changes for fast-import as well.
> >
> > I could potentially split these patches up, but I'd just end up
> > chaining them sequentially since otherwise there'd be lots of
> > conflicts; having 10 different single patch series with lots of
> > dependencies sounded like a bigger pain to me, but let me know if you
> > would prefer I split them up and how you suggest doing so.
>
> I think it's fine to put them in sequence when there's a textual
> dependency.  If it turns out that one of them needs more discussion and
> we don't want it to hold later patches hostage, we can always re-roll at
> that point.
>
> (I also think it's fine to lump together thematically similar patches
> even when they aren't strictly dependent, even textually. It's less work
> for the maintainer to consider 1 group of 10 than 10 groups of 1).
>
> > These patches were driven by the needs of git-repo-filter[1], but most
> > if not all of them should be independently useful.
>
> I left lots of comments. Some of the earlier ones may just be showing my
> confusion about fast-export works (some of which was cleared up by your
> later patches). But I like the overall direction for sure.

Thanks for taking the time to read over the series and providing lots
of feedback!  And, whoops, looks like it's gotten kinda late, so I'll
check any further feedback on Monday.
