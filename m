Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8371E20248
	for <e@80x24.org>; Fri,  5 Apr 2019 16:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfDEQ3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 12:29:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35368 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEQ3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 12:29:00 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so10518207itc.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpEKzKMrStTSqkZ3E8ExmcnDeChavM0q+Q9DF26GYFQ=;
        b=Flry0h74am++NvPgLHJzUc8pcdDuhumIhJ6tlvLAwJ5HYYbgC6O9eslTyJ63QvOlUL
         aK1cCH+h7FR29AdKVflbFsyLLH4OccbF40kmuyPt1SYjRwJUZPYG4gdxItxCrynyJcd5
         Dz7y+DWaiIDzLROX5DnvZsONKmvr2BiRyQInZzik5IvsSod7wLnV1PaEsTKlPLSUINvi
         SZXnpY+0zfW485VPmW5ZdN49u2WkfaCfC9TsqDuZrV8i1wJ7Cl0wPOfgb4gTBhRUztSz
         8IDJPICm8c5+5QIazei4fZPu0ym2Sv4Q2KG49liJHb9bO8hD4FOuWetbhrFhI8iYEcX1
         C71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpEKzKMrStTSqkZ3E8ExmcnDeChavM0q+Q9DF26GYFQ=;
        b=eOlnFDnY+2fuC4wLVoXyuiREKXw0Ljzu8gUJ9ImxEejekiP4mTDkjtJR1+5fafuOS0
         aBB3ob32upQLCT6LsRoR4qzwBhqxdlDyNm/yqUS6e7fa35XVOsJSrFqbLi4nYsAXNWyX
         R2jaHL/CNcqz4ivy4roDmObDqe/uDY5oq/PlbFN3AtQW+xGC2p4jb9IWh6RyDjzsOysR
         gKpthUNUlFDJiwVH1YQHZnHu4FW3XwrFuwjLIQXL8pLE4TzhuHaMQDlxkwprQkSdTDHj
         JMei8quW6zIQyUMbVC4XVI+j2aLxIqx9xC5jf+r6NnTMPHBEFq5qToiDc/+kwSkNnri7
         fnnA==
X-Gm-Message-State: APjAAAX5cnAw0hd+30TNOeasbJp8PnyPYAiBN3DlW1GBSrl3MHDEsPWx
        vdDTrQZm0E9HbkxgW4Y/B+8SP81qtcmi/NTRrANV9w==
X-Google-Smtp-Source: APXvYqxsTXRTTWr2Zc2/0yUDVLfYyi9fCyn1OGdcE9w35gu93q9z0hLsH5wGvQrwIav775cckh021H2yuYNRElxvsDk=
X-Received: by 2002:a02:c955:: with SMTP id u21mr10154607jao.105.1554481739721;
 Fri, 05 Apr 2019 09:28:59 -0700 (PDT)
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
 <CAHd-oW7fXbJyxesgCoiTOWGLH9Tpk5FUN7VsaBrqU842BJpT3Q@mail.gmail.com> <CAP8UFD33xf8FMuVNakzaUhYXo3A2fnvBAoFgoDQUOKgqnWYQBw@mail.gmail.com>
In-Reply-To: <CAP8UFD33xf8FMuVNakzaUhYXo3A2fnvBAoFgoDQUOKgqnWYQBw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 5 Apr 2019 13:28:48 -0300
Message-ID: <CAHd-oW6iBQJ_SCTbRtDdWrg=NftqcMhyZ=SFkj7Am==OpG3bTA@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Christian Couder <christian.couder@gmail.com>
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

On Thu, Apr 4, 2019 at 4:56 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Thu, Apr 4, 2019 at 3:15 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > I've been studying the codebase and looking for older emails in the ML
> > that discussed what I want to propose as my GSoC project. In
> > particular, I found a thread about slow git commands on chromium, so I
> > reached them out at chromium's ML to ask if it's still an issue. I got
> > the following answer:
> >
> > On Wed, Apr 3, 2019 at 1:41 PM Erik Chen <erikchen@chromium.org> wrote:
> > > Yes, this is absolutely still a problem for Chrome. I filed some bugs for common operations that are slow for Chrome: git blame [1], git stash [2], git status [3]
> > > On Linux, blame is the only operation that is really problematic. On macOS and Windows ... it's hard to find a git operation that isn't slow. :(
>
> Nice investigation. About git status I wonder though if they have
> tried the possible optimizations, like untracked cache or
> core.fsmonitor.

I don't know if they did, but I suggested them to check
core.commitGraph, pack.useBitmaps and core.untrackedCache (which Duy
suggested me in another thread).

> > I don't really know if treading would help stash and status, but I
> > think it could help blame. By the little I've read of blame's code so
> > far, my guess is that the priority queue used for the commits could be
> > an interface for a producer-consumer mechanism and that way,
> > assign_blame's main loop could be done in parallel. And as we can se
> > at [4], that is 90% of the command's time. Does this makes sense?
>
> I can't really tell as I haven't studied this, but from the links in
> your email I think it kind of makes sense.
>
> Instead of doing assign_blame()'s main loop in parallel though, if my
> focus was only making git blame faster, I think I would first try to
> cache xdl_hash_record() results and then if possible to compute
> xdl_hash_record() in parallel as it seems to be a big bottleneck and a
> quite low hanging fruit.

Hm, I see. But although it would take more effort to add threading at
assign_blame(), wouldn't it be better because more work could be done
in parallel? I think it could be implemented in the same fashion git
grep does.

> > But as Duy pointed out, if I recall correctly, for git blame to be
> > parallel, pack access and diff code would have to be thread-safe
> > first. And also, it seems, by what we've talked earlier, that this
> > much wouldn't fit all together in a single GSoC. So, would it be a
> > nice GSoC proposal to try "making code used by blame thread-safe",
> > targeting a future parallelism on blame to be done after GSoC?
>
> Yeah, I think it would be a nice proposal, even though it doesn't seem
> to be the most straightforward way to make git blame faster.
>
> Back in 2008 when we proposed a GSoC about creating a sequencer, it
> wasn't something that would easily fit in a GSoC, and in fact it
> didn't, but over the long run it has been very fruitful as the
> sequencer is now used by cherry-pick and rebase -i, and there are
> plans to use it even more. So unless people think it's not a good idea
> for some reason, which hasn't been the case yet, I am ok with a GSoC
> project like this.
>
> > And if
> > so, could you please point me out which files should I be studying to
> > write the planning for this proposal? (Unfortunately I wasn't able to
> > study pack access and diff code yet. I got carried on looking for
> > performance hostposts and now I'm a bit behind schedule :(
>
> I don't think you need to study everything yet, and I think you
> already did a lot of studying, so I would suggest you first try to
> send soon a proposal with the information you have right now, and then
> depending on the feedback you get and the time left (likely not
> much!!!), you might study some parts of the code a bit more later.

Thanks a lot, Christian. I'm writing my proposal and will try to send it today.

> > Also, an implementation for fuzzy blame is being developer right
> > now[5] and Jeff (CC-ed) suggested recently another performance
> > improvement that could be done in blame[6]. So I would like to know
> > wether you think it is worthy putting efforts trying to parallelize
> > it.
>
> What you would do seems compatible to me with the fuzzy blame effort
> and an effort to cache xdl_hash_record() results.
>
> Thanks,
> Christian.
