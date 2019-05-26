Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B71D1F462
	for <e@80x24.org>; Sun, 26 May 2019 02:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfEZCoA (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 22:44:00 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39471 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfEZCoA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 22:44:00 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so19427845itf.4
        for <git@vger.kernel.org>; Sat, 25 May 2019 19:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdD5miy0tsl4Mr5xmDeV8ncseVfF7JAV8eAR+ZrwHxw=;
        b=o9GWCxNQbPpATt6AjfFgWksfWKpBXEr7npmAHPIL4LKnCjP7vJDKEjXHGLvzguFqmP
         53S5oaZGjRBsldqg1LHfUcSORxzjqjpylW1bS7UhSu28k9fijnYnyq9Syo+C5efpgDNJ
         Ctd/vVVOJhzpk2LRHgP5LKcJVdTjjkw4rtOYTEjNc2CUuSSvwu9vJ1LsOr4RRo7Op3qV
         OiggvDLiC6gGI5MXkEFHebiunMr4Kopy5RACjvJc4joJjaQXiLNzkhy2wLBqb5GkvuG1
         V+fuwxL4vbv1hjG5EaRVb037wmWv8TlLIjZh/PqohmbtR8ulapmeSRO5oKttxMNQuM9x
         bIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdD5miy0tsl4Mr5xmDeV8ncseVfF7JAV8eAR+ZrwHxw=;
        b=J8EFJ2cjqO2hGAytQLoPSjTIP9rwzpW0M93mAUVEXfq2COndNVEz/qyyoEjBJYwpPR
         mkDc4EMYeBS/Nex20ADK9MvqCBPORSWLFwn1GXuMd84ZplgeCAFiUP82QcyxKal0JD3D
         tEcnIXb/WR3ZHit/zjB1hWfLkfg1EokCCmJu1HrF1UH8zWFtYVDQtVUACg0WV123fzrL
         F72tL2DMU8BkWjdA1MD2GI9eX/Vu/kqncqduPLuHABrDm+UECdTc7JG4VN68T0qJpOlX
         Jma3Nt3lqLHis/tamgV65fpTXfOsAEmcUOEFiz4FN0CQLrnpY06FJ18hc/J8ZpCxY4/a
         odJQ==
X-Gm-Message-State: APjAAAXVXE/3Y/6S+jSToXRS4yehAXnuuaHZuQNUsZmwfw83f5FfD8Yy
        b+VIQNlk78LlnVb4zMwMG+3fv7jHTveB6od1UDekjA==
X-Google-Smtp-Source: APXvYqwBaUP3TzxNUorFasFAH7pxeeVvnytuF9s3rSOk/vtyBwDOfeLGUbFDM8IL75LiFMcEIK1Woo1G7AMHVsMqBSw=
X-Received: by 2002:a24:47cc:: with SMTP id t195mr22773860itb.117.1558838639130;
 Sat, 25 May 2019 19:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
 <CACsJy8DFw1Y_bhE=k2ZEMTk+vFvwwmx4GDnRXEQB9cp58M3vLg@mail.gmail.com> <CAHd-oW4_u6SMPropxR0tWb2b_Q31n2rda3FKPb9qsnCKwZ=b8Q@mail.gmail.com>
In-Reply-To: <CAHd-oW4_u6SMPropxR0tWb2b_Q31n2rda3FKPb9qsnCKwZ=b8Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 26 May 2019 09:43:32 +0700
Message-ID: <CACsJy8Aj7EJn9UeC81NnE-_fcLybCzvzqB8rL6T=2oc3Z+RhMA@mail.gmail.com>
Subject: Re: [GSoC] How to protect cached_objects
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 25, 2019 at 11:04 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Fri, May 24, 2019 at 6:55 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Thu, May 23, 2019 at 11:51 PM Matheus Tavares Bernardino
> > <matheus.bernardino@usp.br> wrote:
> > >
> >
> > > Hi, everyone
> > >
> > > As one of my first tasks in GSoC, I'm looking to protect the global
> > > states at sha1-file.c for future parallelizations. Currently, I'm
> > > analyzing how to deal with the cached_objects array, which is a small
> > > set of in-memory objects that read_object_file() is able to return
> > > although they don't really exist on disk. The only current user of
> > > this set is git-blame, which adds a fake commit containing
> > > non-committed changes.
> > >
> > > As it is now, if we start parallelizing blame, cached_objects won't be
> > > a problem since it is written to only once, at the beginning, and read
> > > from a couple times latter, with no possible race conditions.
> > >
> > > But should we make these operations thread safe for future uses that
> > > could involve potential parallel writes and reads too?
> > >
> > > If so, we have two options:
> > > - Make the array thread local, which would oblige us to replicate data, or
> > > - Protect it with locks, which could impact the sequential
> > > performance. We could have a macro here, to skip looking on
> > > single-threaded use cases. But we don't know, a priori, the number of
> > > threads that would want to use the pack access code.
> > >
> > > Any thought on this?
> >
> > I would go with "that's the problem of the future me". I'll go with a
> > simple global (I mean per-object store) mutex.
>
> Thanks for the help, Duy. What you mean by "per-object store mutex" is
> to have a lock for every "struct raw_object_store" in the "struct
> repository"? Maybe I didn't quite understand what the "object store"
> is, yet.

It's struct 'raw_object_store'. I think that struct encapsulates all
data structures around $GIT_DIR/objects.

> > After we have a
> > complete picture how many locks we need, and can run some tests to see
> > the amount of lock contention we have (or even cache missess if we
> > have so many locks), then we can start thinking of an optimal
> > strategy.
>
> Please correct me if I misunderstand your suggestion. The idea is to
> protect the pack access code at a higher level, measure contentions,
> and then start refining the locks, if needed? I'm asking because I was
> going directly to the lower level protections (or thread-safe
> conversions) and planning to build it up. For example, I was working
> this week to eliminate static variables inside pack access functions.
> Do you think this approach is OK or should I work on a more "broader"
> thread-safe conversion first (like a couple wide mutex) and refine it
> down?

Having one or two big locks might be easy to get thread safe, but that
increases lock contention and may take forever to fix (it took a long
time to kill Linux's "big kernel lock", and python's equivalent is
still here). So having smaller locks around each shared state makes
more sense. At least you will have easier time combining them later if
you want (breaking down big locks is much harder).

What I was getting at was just stick to simple locks like mutex. Once
you have identified all shared states to protect, you can profile to
have more information and then decide can to choose a different kind
of lock, like the read/write one. We might even need to reorganize
data structure to be more lock-friendly (or go lockless if you feel
brave)...
-- 
Duy
