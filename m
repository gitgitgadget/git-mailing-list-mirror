Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9501D1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 04:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfFQEdt (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 00:33:49 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:45392 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfFQEdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 00:33:49 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x5H4XZPr021081
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 13:33:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x5H4XZPr021081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560746016;
        bh=gOtm3DBYRH8DGWcZ7rotmzOoCS68M5UpgMxk5Yoa1Ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bgEvSnRJMDOZK7xhDQyCQkJK0vh4GvlcEqlDW/9Wq0+PBdKHRlyyUv55febaDYe5k
         rijy6+7nk68O4H/SD3yMJsIwynxwd/xIqvOp2798LGxlo/3jWQsHbslPX+F8hqoyOy
         xtx55awoK/7/buYtaEZHFFDUsbIA//aWzaS7yPWtJjlwdFX+9W9Av1FK8h9kPoYYL7
         KfSTQFlw8A/U6GnYhlbwhoQBpGsmPLVo+ZHQLZTjbgF8s962tjcVh4RDli0lkHn5hn
         mDszakh1d4xYN7mPmLIWm2VqdwBBec57k/8PX8ymg1l5yMH1hSzOxepPvjARyiSPQc
         NKaE3wyb9IWJQ==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id n21so5256592vsp.12
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 21:33:36 -0700 (PDT)
X-Gm-Message-State: APjAAAULZlRb1hdo5k2wLzSV1UL9bvNFaaFA1J5d+8sYwR38e+HhPA2T
        oBMWqwflAPqLWBZsgiSSQ0uT2aGW94e4aYHWaHA=
X-Google-Smtp-Source: APXvYqzEszwmHMFtWfjqfaJHIpeK3M+49YrzKrzUpLKhTET7qLCME//0M6x0s4Bw1Qsq26k/OfX5LFsCmgGDgY6Pv4o=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr19902423vsl.155.1560746015370;
 Sun, 16 Jun 2019 21:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net> <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
In-Reply-To: <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 17 Jun 2019 13:32:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
Message-ID: <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 5:41 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jun 14, 2019 at 5:10 PM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Jun 14, 2019 at 08:35:04PM +0900, Masahiro Yamada wrote:
> >
> > > Perhaps, 'git interpret-trailers' should be changed
> > > to recognize core.commentChar ?
> >
> > It looks like the trailer code does respect it, but the
> > interpret-trailers program never loads the config. Does the patch below
> > make your problem go away?
>
> It seems to me to be the right analysis and the right fix too.
>
> > I do wonder if the trailer code is correct to always respect it, though.
> > For example, in "git log" output we'd expect to see commit messages from
> > people with all sorts of config. I suppose the point is that their
> > comment characters wouldn't make it into the commit object at all, so
> > the right answer there is probably not to look for comment characters at
> > all.
>
> Would you suggest an option, maybe called `--ignore-comments` to ignore them?

Since 'git interpret-trailers' already ignores lines starting with '#',
is this option true by default?


> Thanks,
> Christian.



-- 
Best Regards
Masahiro Yamada
