Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0FC1F462
	for <e@80x24.org>; Sat, 25 May 2019 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfEYQFA (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 12:05:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43858 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfEYQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 12:05:00 -0400
Received: by mail-io1-f67.google.com with SMTP id v7so10092944iob.10
        for <git@vger.kernel.org>; Sat, 25 May 2019 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxETtE/+++dw92BM3lWiJqDn3Vxg/iR/iwfenRFGnrg=;
        b=iaqrD+NUntNKbbMP8Iz6bGhoe0Oeks10x4kHHnrF0EoaQnHbFd0VtZgwSBqi1OF7we
         Uv3V9RiOj1o5eeXBsNXfFAvEPkHC5HTyWDOuxuD98pgfc3NZqRlearNAhm3kA0ynrNXL
         jDs8BabGwxcMEZ0mfflV8r5b3L/LTB/AY1k8dP0PmuEjnSXNw+nseQ64LSqR4fIIoD9o
         CjeAehEDIdjvNrODohxc+Up7UKXN45Wchfx2Xy7HCGlrpaD+Ag2m/4pTU3ChVaMCyZHG
         22faQ+VzUZqCovcMxxbUsO9DprT9x8ObYACn+40hATAUE+uSVq297O7z9Ikpm/Nj33LE
         sUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxETtE/+++dw92BM3lWiJqDn3Vxg/iR/iwfenRFGnrg=;
        b=AztMKfgrDFOR1BSxOAjq1/C5kunBby6n42cW260ZNkee64yrMWXnKNRwxlEYGtyo8G
         tfh2O2cKutDvGxLNiqmNHxYkT9Yat5WFchR268MjcRKHgFmu/6tpKXYrf6UmHsZMIrbd
         fdUEeFD2yG6iwXiTK8msy9CVsP0wY83FKCNjBkyGM3USh4pEsn/ypycSGs4sqO6Mafp3
         fB//MTw0BRuUhrZ6zO3UkrseZP8CKMWJ6ndYz4zGLj9T+ay0pqkayR3Ov7rMkAFz7DTG
         A1XTSyFLAKjMudQBhgOdraOtV1wZItAHADA07dJ/3agAm7TkkN6Us06IB1xkdHpogcfL
         QeVQ==
X-Gm-Message-State: APjAAAU2PE2VXBRcx+B+/h1gBsupglnp+2ApR2NaKhZ6xyoRwhUENfPo
        aW9KStVh4S4x+i9ohrNXlTHiXYx5TgERQN4b5zTc2Q==
X-Google-Smtp-Source: APXvYqyvgthKvZqLmxVEI+VzqvKFamXSsUD7YaCSL7lN47jszqs7IgGem42WpXi7mklNORNwnS21YG3lhUDKldD3zUw=
X-Received: by 2002:a5e:920a:: with SMTP id y10mr7958012iop.86.1558800298810;
 Sat, 25 May 2019 09:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
 <CACsJy8DFw1Y_bhE=k2ZEMTk+vFvwwmx4GDnRXEQB9cp58M3vLg@mail.gmail.com>
In-Reply-To: <CACsJy8DFw1Y_bhE=k2ZEMTk+vFvwwmx4GDnRXEQB9cp58M3vLg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 25 May 2019 13:04:47 -0300
Message-ID: <CAHd-oW4_u6SMPropxR0tWb2b_Q31n2rda3FKPb9qsnCKwZ=b8Q@mail.gmail.com>
Subject: Re: [GSoC] How to protect cached_objects
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 6:55 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, May 23, 2019 at 11:51 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
>
> > Hi, everyone
> >
> > As one of my first tasks in GSoC, I'm looking to protect the global
> > states at sha1-file.c for future parallelizations. Currently, I'm
> > analyzing how to deal with the cached_objects array, which is a small
> > set of in-memory objects that read_object_file() is able to return
> > although they don't really exist on disk. The only current user of
> > this set is git-blame, which adds a fake commit containing
> > non-committed changes.
> >
> > As it is now, if we start parallelizing blame, cached_objects won't be
> > a problem since it is written to only once, at the beginning, and read
> > from a couple times latter, with no possible race conditions.
> >
> > But should we make these operations thread safe for future uses that
> > could involve potential parallel writes and reads too?
> >
> > If so, we have two options:
> > - Make the array thread local, which would oblige us to replicate data, or
> > - Protect it with locks, which could impact the sequential
> > performance. We could have a macro here, to skip looking on
> > single-threaded use cases. But we don't know, a priori, the number of
> > threads that would want to use the pack access code.
> >
> > Any thought on this?
>
> I would go with "that's the problem of the future me". I'll go with a
> simple global (I mean per-object store) mutex.

Thanks for the help, Duy. What you mean by "per-object store mutex" is
to have a lock for every "struct raw_object_store" in the "struct
repository"? Maybe I didn't quite understand what the "object store"
is, yet.

> After we have a
> complete picture how many locks we need, and can run some tests to see
> the amount of lock contention we have (or even cache missess if we
> have so many locks), then we can start thinking of an optimal
> strategy.

Please correct me if I misunderstand your suggestion. The idea is to
protect the pack access code at a higher level, measure contentions,
and then start refining the locks, if needed? I'm asking because I was
going directly to the lower level protections (or thread-safe
conversions) and planning to build it up. For example, I was working
this week to eliminate static variables inside pack access functions.
Do you think this approach is OK or should I work on a more "broader"
thread-safe conversion first (like a couple wide mutex) and refine it
down?

> I mean, this is an implementation detail and can't affect object
> access API right? That gives us some breathing room to change stuff
> without preparing for something that we don't need right now (like
> multiple cached_objects writers)

Indeed, makes sense to leave the multiple writers support to the
future, if it's ever needed. Thanks.
