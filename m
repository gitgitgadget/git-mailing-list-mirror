Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F126D205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 11:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032195AbdAGLFn (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 06:05:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:36415 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032100AbdAGLFm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 06:05:42 -0500
Received: (qmail 7371 invoked by uid 109); 7 Jan 2017 11:05:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 11:05:41 +0000
Received: (qmail 24197 invoked by uid 111); 7 Jan 2017 11:06:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 06:06:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2017 06:05:39 -0500
Date:   Sat, 7 Jan 2017 06:05:39 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Tolsch <btolsch@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
Subject: Re: [PATCH] rebase--interactive: count squash commits above 10
 correctly
Message-ID: <20170107110539.jcx25pdy7cosojcp@sigill.intra.peff.net>
References: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
 <20170107082318.jj3izthx2ylscrns@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701071150490.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701071150490.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 07, 2017 at 11:51:23AM +0100, Johannes Schindelin wrote:

> > We can fix this by making the ".*" less greedy. Instead of
> > depending on ".*?" working portably, we can just limit the
> > match to non-digit characters, which accomplishes the same
> > thing.
> 
> Or we could simply require a space before the first digit, which would
> maybe look a little simpler.

Yeah, if we can assume that all translations will always have a space
there. It is almost certainly true for Western languages, but I don't
know about others. It looks like the Korean translation omits a space
_after_ the digits, but there is still one before.

-Peff
