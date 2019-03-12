Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A3520248
	for <e@80x24.org>; Tue, 12 Mar 2019 00:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCLATB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 20:19:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37723 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLATB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 20:19:01 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so525929ioh.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5t8Yt4yRd8fH8xGSoCHnhDhS2AvGz6BMHlWUMMHwalM=;
        b=w2aOK/vfV9/UuQDbV4pfmXzCQNFj393roQAvg+A1/dw4gOkvraeZbwQwMWAFu+E4LR
         qqVrKRa2nAZ/7oeNb2xotvPtAZUSStH667TfvcrtsfF1oC8pNyYXPVSfonpDwMZ0exux
         yDTTloV3MLBcl6BMX5VSurbdQpxNZ1A/n3VE0hDlD3hhtg9tZzp9pvCM7q4MpUVa7h1Y
         wCIcVHoIsfI0ZPJh0rYTEKSskTNOf2TSr/l7td1o9ZLIhzyT1XcLeGMY4/3uprZffBwb
         ay9RMOeCFyHto4RJGI+cFJUlyPWyVrCitYDSftxUwL2pCq7Sspsk+1UFDkQwzDCz/JzQ
         B5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5t8Yt4yRd8fH8xGSoCHnhDhS2AvGz6BMHlWUMMHwalM=;
        b=gTnfvULWlh2ZsaLU2vv67Mo4n9pf+lrm+5HGBYCbb9IPzF+hkVQm+bFxLgYlb/thfu
         PP36IGw33YXxPFnW0fca4evps/bIbQhARhhd/Wxl5PzrygoHk3zmUoucHYSP/OqadxWo
         aknUpTaXHKg5zl5I5855yR0c/ZrE4pQqnwsMwPQDd/8nsbwImvNztpPmojuXKUzc7spW
         NKRHlBH9iykQ7sKmqDekQ/5pyivmBu43sGToVwYWKZWK6NtVNBc8s8gAMotZApa5Djga
         9xM6E1Q1z7giIo0UnmnVuo2yvRDQgX5B2bs1o5rHvl2OivwL9XcvSD8wOa2VdcePZ/fR
         enkg==
X-Gm-Message-State: APjAAAWSc2PaHcBNQU0KQ/trnJGMElFWD1hEBs+h+IvgNTA3aPDvsdx5
        zKjNiXngdDSvE8xDRIxffwqe4RJYCPJ5/YMi4dtZtQ==
X-Google-Smtp-Source: APXvYqwuMzHRP+ozAdb7EAF0pHFsBHHdNzliq4WfgCyn7o3RvIIvlayc6vAOUL9qsDq02Qllks2I4lVDsUIy2+wRV3o=
X-Received: by 2002:a5e:d608:: with SMTP id w8mr8275895iom.293.1552349939673;
 Mon, 11 Mar 2019 17:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net> <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com> <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
In-Reply-To: <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 11 Mar 2019 21:18:47 -0300
Message-ID: <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Duy Nguyen <pclouds@gmail.com>
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

On Wed, Mar 6, 2019 at 7:17 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Mar 6, 2019 at 6:47 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > This exercise of estimating a good spot to gain performance with
> > parallelism at git seems more difficult than I thought, firstly. Also,
> > I'm not that familiar yet with git packing (neither with the sections
> > of it that could benefit from parallelism). So could anyone point me
> > some good references on this, where I could study and maybe come back
> > with more valuable suggestions?
>
> I think you should skim through
> Documentation/technical/pack-format.txt to have an idea what we're
> talking about here (inflation, delta cache...).

Thanks for the recommendation. It was a very explanatory reading.

> The short (and slightly inaccurate) version is, in order to give the
> content of a SHA-1, we need to
>
> 1. locate that "object" in the pack file (I'm ignoring loose objects)
>
> 2. assume (worst case) that this object is a delta object, it contains
> only modification of another object, so you would need to get the
> content of the other object first, then apply these modification ("the
> delta") to get the content. This could repeat many times
>
> 3. once you get full content, it's actually zlib compressed, so you
> need to uncompress/inflate it.
>
> Step 2 would be super slow if you have to uncompress that "another
> object" every single time. So there's a "delta cache" which stores the
> content of these "other objects". Next time you see a delta object on
> top of one of these in the cache, you can just apply the delta and be
> done with it. Much faster. This delta cache is of course global and
> not thread safe.
>
> Step 3 can also be slow when dealing with large blobs.

Thanks for the explanation.

> Another global state that Jeff mentions is pack windows I think is a
> bit harder to explain quickly. But basically we have many "windows" to
> see the raw content of a pack file, these windows are global (per pack
> actually) and are also not thread safe.
>
> So all these steps are not thread safe. When a command with multiple
> thread support accesses the pack, all those steps are protected by a
> single mutex (it's grep_mutex in builtin/grep.c or read_lock() in
> builtin/pack-objects.c). As you can see steps here are CPU-bound (step
> 3 is obvious, step 2 will have to inflate the other objects), so if
> you use a more fine-grained mutex, chances are the inflation step can
> be done in parallel.
>
> I think the good spots to gain performance are the commands that
> already have multiple thread support. I mentioned git-grep and
> git-pack-objects.c above. git-index-pack is the third one but it's
> special and I think does not use general pack access code.
>
> I think if we could somehow measure lock contention of those big locks
> above we can guesstimate how much gain there is. If threads in
> git-grep for example often have to wait for grep_mutex, then in the
> best case scenario when you make pack access thread safe, lock
> contention goes down to near zero.

I've been thinking on how I could implement a test to estimate the
lock contention but had no success until now. I wanted to try
mutrace[2] but couldn't install it; I tried valgrind's drd but it
didn't seem to report a contention time estimation; And I tried
measuring the time of "pthread_mutex_lock(&grep_mutex)" but I don't
know how much significative this value is, since we can't directly
compare it (the time of many threads at lock) with the overall
execution time. Do you have an idea on how we could measure the lock
contention here?

Another thing that is occurring to me right now is whether git-grep,
as it is implemented today, would really benefit from thread-safe pack
access. I may have to study the code more, but it seems to me that
just the producer thread uses pack access.

[2] http://0pointer.de/blog/projects/mutrace.html

> > On Tue, Mar 5, 2019 at 9:57 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Tue, Mar 5, 2019 at 11:51 AM Jeff King <peff@peff.net> wrote:
> > > > > processing power from multiple cores, but about _not_ blocking. I
> > > > > think one example use case here is parallel checkout. While one thread
> > > > > is blocked by pack access code for whatever reason, the others can
> > > > > still continue doing other stuff (e.g. write the checked out file to
> > > > > disk) or even access the pack again to check more things out.
> > > >
> >
> > Hmm, you mean distributing the process of inflating, reconstructing
> > deltas and checking out files between the threads? (having each one
> > doing the process for a different file?)
>
> Yes. So if one thread hits a giant file (and spends lot of time
> inflating), the other threads can still go on inflate smaller files
> and writing them to disk.
>
> > > > I'm not sure if it would help much for packs, because they're organized
> > > > to have pretty good cold-cache read-ahead behavior. But who knows until
> > > > we measure it.
> > > >
> > > > I do suspect that inflating (and delta reconstruction) done in parallel
> > > > could be a win for git-grep, especially if you have a really simple
> > > > regex that is quick to search.
> > >
> > > Maybe git-blame too. But this is based purely on me watching CPU
> > > utilization of one command with hot cache. For git-blame though, diff
> > > code as to be thread safe too but that's another story.
> >
> > I don't know if this relates to parallelizing pack access, but I
> > thought that sharing this with you all could perhaps bring some new
> > insights (maybe even on parallelizing some other git section): I asked
> > my friends who contribute to the Linux Kernel what git commands seems
> > to take longer during their kernel work, and the answers were:
> > - git log and git status, sometimes
> > - using pager's search at git log
> > - checking out to an old commit
> > - git log --oneline --decorate --graph
>
> Sometimes the slowness is not because of serialized pack access. I'm
> sure git-status is not that much impacted by slow pack access.
>
> The pager search case may be sped up (git-log has to look at lots of
> blobs and trees) but you also need to parallelize diff code as well
> and that I think is way too big to consider.
>
> The checking out old commit, I think could also be sped up with
> parallel checkout. Again this is really out of scope. But of course it
> can't be done until pack access is thread safe. Or can be done but not
> as pretty [1]. [1] suggests 30% speedup. That's the share-nothing best
> possible case, I think. But that code is no way optimized so real
> speedup could be higher.
>
> [1] https://public-inbox.org/git/20160415095139.GA3985@lanh/

So, although it would be out of scope for GSoC, checkout, diff and log
(and maybe others) could all benefit from a thread-safe/parallel pack
access, right? If so, it is very motivating the impact this project
could, in theory, have :)

> --
> Duy
