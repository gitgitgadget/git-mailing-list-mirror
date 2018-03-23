Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49EA1F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 09:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCWJMY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 05:12:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:39776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751668AbeCWJMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 05:12:23 -0400
Received: (qmail 4976 invoked by uid 109); 23 Mar 2018 09:12:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Mar 2018 09:12:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26527 invoked by uid 111); 23 Mar 2018 09:13:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Mar 2018 05:13:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2018 05:12:21 -0400
Date:   Fri, 23 Mar 2018 05:12:21 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] doc/gitattributes: mention non-recursive behavior
Message-ID: <20180323091221.GB24416@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
 <20180320041454.GA15213@sigill.intra.peff.net>
 <CACsJy8CpwtNfp9oQGvECBuWGcwLEKK609iPJVEiXH4cDD6mpEg@mail.gmail.com>
 <20180321065005.GB16784@sigill.intra.peff.net>
 <CACsJy8DCkh=kn1bmCQf4idPggsh5cEY936gfR-5qaQKRsmLBzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DCkh=kn1bmCQf4idPggsh5cEY936gfR-5qaQKRsmLBzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 05:16:16PM +0100, Duy Nguyen wrote:

> >> After 8b1bd02415 (Make !pattern in .gitattributes non-fatal -
> >> 2013-03-01) maybe we could use the verb "ignored" too instead of
> >> "forbidden"
> >
> > Makes sense. The original is already in 'next', so do you want to send
> > an incremental patch?
> 
> It's up to you. After all it's you who's doing all the work :)

I was trying to trick you into doing it. ;)

As I tried to write up the commit message, though, I had second
thoughts. It's true that they are ignored in the current code. But I do
not think they are something we want to encourage, and certainly we do
not want to promise that the "ignored" behavior will last forever.

So I think it is actually best to declare them forbidden, and we just
happen to treat it as a non-fatal error in the current code.

> > One other maybe-difference I came across coincidentally today: you have
> > to quote the pattern in .gitattributes if it contains spaces, but not in
> > .gitignore. But that's more an artifact of the rest of the file syntax
> > than the pattern syntax (.gitignore has no other fields to confuse it
> > with).
> 
> Yeah I forgot about that (and I was the one who started it). The
> document was updated in 860a74d9d9 (attr: support quoting pathname
> patterns in C style - 2017-01-27) though.

OK. I was considering adding a special note to the list of differences,
but I think the existing text is probably fine.

-Peff
