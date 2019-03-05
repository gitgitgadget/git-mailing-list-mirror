Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C027020248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfCEXrD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:47:03 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34824 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfCEXrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:47:02 -0500
Received: by mail-ua1-f67.google.com with SMTP id f88so8333867uaf.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSC3FMqLz8cCNT2miDg9Tsmtm2D5hx9+xuq7q1cymZE=;
        b=xrfhaV/LZL7RFLgUT8HFSZRcrSTy749wjbxNnurHkFDsqxl5mOBnStHZdGC3DD/RB0
         SC6WRLUx4B71RnDhyF+Vv0P4fO6cSHX166CA8hjMmQOuGRi9/R7w3vkqedbP7kTnLEkF
         JQX3RULyXgvv6YSBhKqc+2c0rciLeO3ayXWWjt3fWoE1FBWBkBKDXfY7wmAsshjGvkxf
         3eHkMkmYFAHZK6QuGm1YOBrxS7QE9uRbIIemg+trsc1rtCi9hH31ag5DHFf4a4/a2CSp
         o1kRQZ4TxtYD4U1FOSmxE+SO/9nlH5CmPf5Dg5IW8MwPdnigiktl3b85SmFJJSQHphQD
         82BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSC3FMqLz8cCNT2miDg9Tsmtm2D5hx9+xuq7q1cymZE=;
        b=kJ2pNnnNhIU119N6/3YXryuqu1UV/7TOYHXXrRj6x4MSSQjsUQYnndwpYGx/xltaVP
         8iRtCrrRFJOzMu3Jpng0s4dSVU00hFnqWPQOyz5sh1kE3pql1IClosCYbfnOk3c37B2N
         4B7APH9BLD2Mm82e9GMmFRim6cuIS7LNj6R1oN9E6Ma2qF4W1GH0FcosgO6LD72cmxJc
         YK4EPPvy7b04rXbgoLiMJPnh0aEiacH4BA8qhj19lFPCDZlAn+hqktMjNrjtEnuZq5GU
         7QtX1iVVmeqECTuanwD6rIjOPsRvdB/D4iuBwXWOvhHkoZay7ABF64Ij4Tq60XaySq5A
         zsOA==
X-Gm-Message-State: APjAAAXl4WAv6yxGk6CSmyDx7d3w8g0T4SRYVmXRS2mPEblMdlGFvVuO
        zlVZr+a9pwq+JPLL91C5wRLcD7hYQbM6ylNz3a0p3A==
X-Google-Smtp-Source: APXvYqxueNqqXkng3biR8uueZVgsVVpVnCD19gRB/CDbX5S2WysEAXoMR5cbKch0w94Dm9ujUXYy/isVVVSsHybrl3w=
X-Received: by 2002:ab0:244f:: with SMTP id g15mr2490085uan.4.1551829621261;
 Tue, 05 Mar 2019 15:47:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net> <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
In-Reply-To: <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 5 Mar 2019 20:46:50 -0300
Message-ID: <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
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

This exercise of estimating a good spot to gain performance with
parallelism at git seems more difficult than I thought, firstly. Also,
I'm not that familiar yet with git packing (neither with the sections
of it that could benefit from parallelism). So could anyone point me
some good references on this, where I could study and maybe come back
with more valuable suggestions?

On Tue, Mar 5, 2019 at 9:57 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Mar 5, 2019 at 11:51 AM Jeff King <peff@peff.net> wrote:
> > > processing power from multiple cores, but about _not_ blocking. I
> > > think one example use case here is parallel checkout. While one thread
> > > is blocked by pack access code for whatever reason, the others can
> > > still continue doing other stuff (e.g. write the checked out file to
> > > disk) or even access the pack again to check more things out.
> >

Hmm, you mean distributing the process of inflating, reconstructing
deltas and checking out files between the threads? (having each one
doing the process for a different file?)

> > I'm not sure if it would help much for packs, because they're organized
> > to have pretty good cold-cache read-ahead behavior. But who knows until
> > we measure it.
> >
> > I do suspect that inflating (and delta reconstruction) done in parallel
> > could be a win for git-grep, especially if you have a really simple
> > regex that is quick to search.
>
> Maybe git-blame too. But this is based purely on me watching CPU
> utilization of one command with hot cache. For git-blame though, diff
> code as to be thread safe too but that's another story.

I don't know if this relates to parallelizing pack access, but I
thought that sharing this with you all could perhaps bring some new
insights (maybe even on parallelizing some other git section): I asked
my friends who contribute to the Linux Kernel what git commands seems
to take longer during their kernel work, and the answers were:
- git log and git status, sometimes
- using pager's search at git log
- checking out to an old commit
- git log --oneline --decorate --graph
