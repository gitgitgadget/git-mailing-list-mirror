Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700491F597
	for <e@80x24.org>; Fri, 20 Jul 2018 06:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeGTGew (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 02:34:52 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41175 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeGTGew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 02:34:52 -0400
Received: by mail-io0-f195.google.com with SMTP id q9-v6so9025461ioj.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X2qcPxG96aa3u828UPsT71mD8dKvLxzacWlXGcJiM0=;
        b=KrsztbNM0fA+7W5sOaDxZsTN53A9//QKM1ONBnaBuSzuFRHlrU4q05zCbO7o3Qo7XM
         OyVKNCKMq+JYjKs2mqiSbNvnPzd/P+quClOTD7sWU6wPvppMQ75kBxAAmHSgGBx8S+pB
         YQgjU49FXlKtBFT3qlBCshCf//9HSACVopPN9gffVgJ3fZ85rifIGGhIKLsb4S49Xjtj
         kYH+hG8Egyew8mEICEfUxOqPd/l6mxb+4zkCDl+tkXOLB4uFTDj9CiP+hHQece05oicQ
         gyjvgrHcReOlCuLy6U390Zhg2QbCXPY0KGZEmcHJ/FOj8yFM6hSyeKlv6Vkn8hgh7T/l
         9vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X2qcPxG96aa3u828UPsT71mD8dKvLxzacWlXGcJiM0=;
        b=Te0xqP/m+7O6MbiV/1e6W2ybs63oOlPHlBdsdyUz7JY7zo12Bun+S9wcke0I6okABD
         X90GM8ODiq0s0C+7FCzQxwD492ApoimxDA7akexbrHelnr98w2bMYZ/cZUmCXja9ZHHu
         Wj74yCzowJbfrvWnlr06drIVyx7uw4bTGVqRae19dz+AeFnrgp2/n81TIO+iG5PgDx0V
         wUoB4V1SNhc+wWRSE+OBhYELXLrw2iZwsZTUhnMPijJjRlb8y1tbtNDAEzXVMPsBNcwe
         GRgYqgV/RO3otEfqvnMxrrAq8jpNsw04+N8ojnFhFqQ37toSHNjetLBa92BCIx8g4bFw
         qd4g==
X-Gm-Message-State: AOUpUlEZO53W8p1QmkKephBcEGSSFELGlNMydJYpUB/0zzcSX7NezttE
        tfTzLmoBPkypImiAwdjiDd24LNxnwGo3QTmX3i8=
X-Google-Smtp-Source: AAOMgpcIDWiBbZFBXHfIeKqBb2Qr5M+x5/i+EZ/tYuRh5VudMB5jV4bVZ8kfSI8jnXHH94VdJEgvTENmQxcee6Iuc+o=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr427390ioe.282.1532065700598;
 Thu, 19 Jul 2018 22:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home> <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net> <20180719173135.GA24563@duynguyen.home>
 <20180719182442.GA5796@duynguyen.home> <CABPp-BEo1Ar17uwX=ib8iVYosdwhTXhdMWvi7kgqDb3iPQoj5Q@mail.gmail.com>
 <20180720052829.GA3852@sigill.intra.peff.net>
In-Reply-To: <20180720052829.GA3852@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jul 2018 07:47:54 +0200
Message-ID: <CACsJy8Aw1JKpv_o13GmicR1BstJxF1ow358YcRax2EmnjuZuhA@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 7:28 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 19, 2018 at 04:11:01PM -0700, Elijah Newren wrote:
>
> > Looking at the output from Peff's instrumentation elsewhere in this
> > thread, I see a lot of lines like
> >    mismatched get: 32889efd307c7be376da9e3d45a78305f14ba73a = (, 28)
> > Does that mean it was reading the array when it wasn't ready?
>
> Yes, it looks like we saw a "get" without a "set". Though this could
> also be due to threading. The tracing isn't atomic with respect to the
> actual get/set operation, so it's possible that the ordering of the
> trace output does not match the ordering of the actual operations.
>
> > However, it's interesting to also look at the effect on packing
> > linux.git (on the same beefy hardware):
> >
> > Version  Pack (MB)  MaxRSS(kB)  Time (s)
> > -------  ---------  ----------  --------
> >  2.17.0     1279     11382932      632.24
> >  2.18.0     1279     10817568      621.97
> >  fiv-v4     1279     11484168     1193.67
> >
> > While the pack size is nice and small, the original memory savings
> > added in 2.18.0 are gone and the performance is much worse.  :-(
>
> Interesting. I can't reproduce here. The fix-v4 case is only slightly
> slower than 2.18.0. Can you double check that your compiler flags, etc,
> were the same? Many times I've accidentally compared -O0 to -O0. :)

He ran 40 threads though. That number of threads can make lock
contention very expensive. Yeah my money is also on lock contention.

> You might also try the patch below (on top of fix-v4), which moves the

Another thing Elijah could try is watch CPU utilization. If this is
lock contention, I think core utilization should be much lower because
we spend more time waiting than actually doing things.

> locking to its own dedicated mutex. That should reduce lock contention,

I think we could use cache_lock() which is for non-odb shared data
(and delta_size[] fits this category)

> and it fixes the remaining realloc where I think we're still racy. On my

Yeah it's not truly racy as you also noted in another mail. I'll make
a note about this in the commit message.

> repack of linux.git, it dropped the runtime from 6m3s to 5m41s, almost
> entirely in system CPU.
-- 
Duy
