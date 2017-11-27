Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8229420C11
	for <e@80x24.org>; Mon, 27 Nov 2017 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbdK0PbK (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 10:31:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:41462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752291AbdK0PbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 10:31:10 -0500
Received: (qmail 24983 invoked by uid 109); 27 Nov 2017 15:31:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 15:31:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3250 invoked by uid 111); 27 Nov 2017 15:31:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 10:31:27 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 10:31:07 -0500
Date:   Mon, 27 Nov 2017 10:31:07 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171127153107.GB23218@sigill.intra.peff.net>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
 <20171126191510.GA1501@sigill>
 <CAP8UFD1hRWa1YtgRPZxXvkqcHfUoKKxgVUuN_d9C36jbrGBBXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1hRWa1YtgRPZxXvkqcHfUoKKxgVUuN_d9C36jbrGBBXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 09:57:14PM +0100, Christian Couder wrote:

> > As much as I hate autoconf,
> > is it the right advice for somebody who doesn't want to look at the
> > Makefile knobs to do:
> >
> >   autoconf
> >   ./configure
> >   make
> >
> > ?
> 
> I don't think so. I think it is just easier to advice to do as most of
> us do, and to just add a few checks in the Makefile to make it clear
> which dependencies should be installed or which knob should be
> tweaked.

I guess I can buy that line of reasoning (and in particular your later
comment that autoconf is doomed to bitrot, since most of us don't use
it). I'm just slightly concerned that we're going to end up
reimplementing autoconf inside our Makefile. ;)

But that is a slippery slope argument; we could switch our approach any
time if it starts to look bad.

-Peff
