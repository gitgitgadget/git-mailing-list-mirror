Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EC61F462
	for <e@80x24.org>; Mon, 17 Jun 2019 05:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfFQFDn (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 01:03:43 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41806 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFQFDn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 01:03:43 -0400
Received: by mail-ed1-f51.google.com with SMTP id p15so14158548eds.8
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctn3prHzu5y3FInKmsnxwJ3+wVQnzNCzaYvHauQGVa0=;
        b=IOnyX5DSHkxQazidUYoo429TEJAjuBbtel3A9lamIufhLTqQJSY72EMqEl1lbwfDhI
         2ab4WOfbbhCVEW8x07opXxV/j143iy4XUwkQgqkm3PgrHYYu08Vh9lsBvS6lHfW69p/f
         S4VpYeL0oxwa5WMoqEV9XHkqRVaPk6+2x4sNnQDBi1hbQvG6Np3349+JXO708GDehaVs
         pWXVYFh8ovZC0FgN6RFw6/hxtBrQavdIfxjY2NRAj9PiAPx8s3IrzdUrmSz41dyUQPEE
         iWbtz/y4PPXdWB0hl8DpDo+EZAdyhR/98wMPFKRyDYEx2HiBghW76MZEKcwNhrIEQfjE
         Ezrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctn3prHzu5y3FInKmsnxwJ3+wVQnzNCzaYvHauQGVa0=;
        b=JgTNGr0238Knq34PYNER6NH/fFFr8GUCsyEYH9jhSG6yyGOzN0SqXSAm7DJLqXdi04
         EEPot/0freHtT29r4RozHeVylyQU2CeNPgaM0dI1Pt2dYmtX9mulFvg5Tw3b77WtElYN
         1jQmuBcIVIFBlXo21F0kM/ntcURsGJRiIqpyZEl5xVKraMnVa3SBdTcCJh7CChImmesc
         7Th7jkHwE1L0cQbSZM2euJwsFWQyZG7vmkcpIJK4p0niVj5K1AVZtrCB+nXwWGEBf+Kv
         az9bzhfRARzbMbIhXljzCO0LJqQ0osKXy2KgDfZM7hQ0pOydHirReLQtKNfPvw0nLLVu
         cLJQ==
X-Gm-Message-State: APjAAAU9TPzy4qOGbv31CnN96wV3HmVje/GPxLeyTCbMIkGhAMSNs3uv
        H39NEhfXkOOTzaYYvcyZvlD7TnTtCWXFchtLo47eukiHdFw=
X-Google-Smtp-Source: APXvYqzTFkJyHRa8WbHmD3/ONKMJ1RbsSp6ihf0sDl34xhM4OoBFURifFawjbwBSsZYqwQ1o31WkFX1kP5M944rHQqI=
X-Received: by 2002:a50:886a:: with SMTP id c39mr71163953edc.214.1560747821221;
 Sun, 16 Jun 2019 22:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net> <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
 <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
In-Reply-To: <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Jun 2019 07:03:29 +0200
Message-ID: <CAP8UFD3_kKvBs=rMvBp-K-UPD5mCqVsHRZ1VqGYY7uR8G+H8SQ@mail.gmail.com>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 17, 2019 at 6:33 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Jun 15, 2019 at 5:41 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > > I do wonder if the trailer code is correct to always respect it, though.
> > > For example, in "git log" output we'd expect to see commit messages from
> > > people with all sorts of config. I suppose the point is that their
> > > comment characters wouldn't make it into the commit object at all, so
> > > the right answer there is probably not to look for comment characters at
> > > all.
> >
> > Would you suggest an option, maybe called `--ignore-comments` to ignore them?
>
> Since 'git interpret-trailers' already ignores lines starting with '#',
> is this option true by default?

Sorry, I should have suggested something called --unstrip-comments or
--ignore-comment-char that would make 'git interpret-trailers' stop
stripping lines that start with the comment character.
