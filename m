Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E8D20248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfCFKRp (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:17:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36267 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbfCFKRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:17:44 -0500
Received: by mail-io1-f65.google.com with SMTP id r136so9734213iod.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 02:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XF12w50hoHqkoqiheoR9lG8a9eTo3SUUZeW0Nw8ecOY=;
        b=Q7+OomfVGniK+5Bfo9ZaeV8neKi/UMBOGCuVvhE0qqPlHuAsUuL+NiL2QDRSxVpR0s
         m6uo2goln5vWobBdWpXvbCKihWwPygNxij/wDe6C7hnHaWVS6o+LeWC/cPMjA0TMF40C
         UdqqeaGIadbW8i/zAbwP58fFaDM+lRgUyfh99eJhwL6jkk+5LbEHl0wLJw89/lWO0Bfv
         VmSJai1rrnRJZCvuQoQUWuzeGavCTzKA13VZL+59LhxhSSvQQrQF06Vq89lQQQeiXcPG
         4GPrslJZ3qRRKyRNpHIhMeJXU0AHbJ3uXQde9JSm5L7rzUL0kaOVE1qF6ONSl/NB8Gck
         ZYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF12w50hoHqkoqiheoR9lG8a9eTo3SUUZeW0Nw8ecOY=;
        b=OutNOlhsnyHt3rlEi1Qyex8dlNZn11QZyqNGwgXQOsu8m5zozbTguuemUzbM60uZMR
         XeQdq1vUVbZb7ur4TA3+V0RWdRG33ybSTniFeImAnHO+y83BIJRHH74BRaIKiqkYR8JS
         q10Jf7IykNIqm+hF92BlJPCeAgQaZlJ3DGGdx9XIsLEM5LPvUsPXElTknvaNP/YPwMm8
         tYkhnm5UY1uVkzt/3PTMqHnnAASujA/em2GK0uF7k5kgHp1IqCJxCMydYL1WcnquiFoi
         +WoCr0YXZh8eYD121QeOEiwUrhZxgT3wl7v8d8JJNMvbbNeGlhoxfxjjoUYmjkhFOyLz
         +1Dw==
X-Gm-Message-State: APjAAAXW16JMawMXhAvWCq11whiEWf8tWk1t0WVW4EP5Hnqkw2NL9Sme
        kg6Z7uPmCq3yBrSi9ZyqnQEajRTX0IDJxIu4jEE=
X-Google-Smtp-Source: APXvYqzPcjX6ck12ByrbsDFz93SCEXato/PDabdeUPBZz6Bmzosvo/HwO3GQ24SPUOyx1rp+nVRkOtXNdbwgK9fWSII=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr2752482ioj.118.1551867463614;
 Wed, 06 Mar 2019 02:17:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net> <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
In-Reply-To: <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Mar 2019 17:17:17 +0700
Message-ID: <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 6, 2019 at 6:47 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> This exercise of estimating a good spot to gain performance with
> parallelism at git seems more difficult than I thought, firstly. Also,
> I'm not that familiar yet with git packing (neither with the sections
> of it that could benefit from parallelism). So could anyone point me
> some good references on this, where I could study and maybe come back
> with more valuable suggestions?

I think you should skim through
Documentation/technical/pack-format.txt to have an idea what we're
talking about here (inflation, delta cache...).

The short (and slightly inaccurate) version is, in order to give the
content of a SHA-1, we need to

1. locate that "object" in the pack file (I'm ignoring loose objects)

2. assume (worst case) that this object is a delta object, it contains
only modification of another object, so you would need to get the
content of the other object first, then apply these modification ("the
delta") to get the content. This could repeat many times

3. once you get full content, it's actually zlib compressed, so you
need to uncompress/inflate it.

Step 2 would be super slow if you have to uncompress that "another
object" every single time. So there's a "delta cache" which stores the
content of these "other objects". Next time you see a delta object on
top of one of these in the cache, you can just apply the delta and be
done with it. Much faster. This delta cache is of course global and
not thread safe.

Step 3 can also be slow when dealing with large blobs.

Another global state that Jeff mentions is pack windows I think is a
bit harder to explain quickly. But basically we have many "windows" to
see the raw content of a pack file, these windows are global (per pack
actually) and are also not thread safe.

So all these steps are not thread safe. When a command with multiple
thread support accesses the pack, all those steps are protected by a
single mutex (it's grep_mutex in builtin/grep.c or read_lock() in
builtin/pack-objects.c). As you can see steps here are CPU-bound (step
3 is obvious, step 2 will have to inflate the other objects), so if
you use a more fine-grained mutex, chances are the inflation step can
be done in parallel.

I think the good spots to gain performance are the commands that
already have multiple thread support. I mentioned git-grep and
git-pack-objects.c above. git-index-pack is the third one but it's
special and I think does not use general pack access code.

I think if we could somehow measure lock contention of those big locks
above we can guesstimate how much gain there is. If threads in
git-grep for example often have to wait for grep_mutex, then in the
best case scenario when you make pack access thread safe, lock
contention goes down to near zero.

> On Tue, Mar 5, 2019 at 9:57 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Tue, Mar 5, 2019 at 11:51 AM Jeff King <peff@peff.net> wrote:
> > > > processing power from multiple cores, but about _not_ blocking. I
> > > > think one example use case here is parallel checkout. While one thread
> > > > is blocked by pack access code for whatever reason, the others can
> > > > still continue doing other stuff (e.g. write the checked out file to
> > > > disk) or even access the pack again to check more things out.
> > >
>
> Hmm, you mean distributing the process of inflating, reconstructing
> deltas and checking out files between the threads? (having each one
> doing the process for a different file?)

Yes. So if one thread hits a giant file (and spends lot of time
inflating), the other threads can still go on inflate smaller files
and writing them to disk.

> > > I'm not sure if it would help much for packs, because they're organized
> > > to have pretty good cold-cache read-ahead behavior. But who knows until
> > > we measure it.
> > >
> > > I do suspect that inflating (and delta reconstruction) done in parallel
> > > could be a win for git-grep, especially if you have a really simple
> > > regex that is quick to search.
> >
> > Maybe git-blame too. But this is based purely on me watching CPU
> > utilization of one command with hot cache. For git-blame though, diff
> > code as to be thread safe too but that's another story.
>
> I don't know if this relates to parallelizing pack access, but I
> thought that sharing this with you all could perhaps bring some new
> insights (maybe even on parallelizing some other git section): I asked
> my friends who contribute to the Linux Kernel what git commands seems
> to take longer during their kernel work, and the answers were:
> - git log and git status, sometimes
> - using pager's search at git log
> - checking out to an old commit
> - git log --oneline --decorate --graph

Sometimes the slowness is not because of serialized pack access. I'm
sure git-status is not that much impacted by slow pack access.

The pager search case may be sped up (git-log has to look at lots of
blobs and trees) but you also need to parallelize diff code as well
and that I think is way too big to consider.

The checking out old commit, I think could also be sped up with
parallel checkout. Again this is really out of scope. But of course it
can't be done until pack access is thread safe. Or can be done but not
as pretty [1]. [1] suggests 30% speedup. That's the share-nothing best
possible case, I think. But that code is no way optimized so real
speedup could be higher.

[1] https://public-inbox.org/git/20160415095139.GA3985@lanh/
-- 
Duy
