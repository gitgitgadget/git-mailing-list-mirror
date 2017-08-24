Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2A720285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbdHXOas (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 10:30:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:47972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752681AbdHXOas (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:30:48 -0400
Received: (qmail 19146 invoked by uid 109); 24 Aug 2017 14:30:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 14:30:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10178 invoked by uid 111); 24 Aug 2017 14:31:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 10:31:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Aug 2017 07:30:44 -0700
Date:   Thu, 24 Aug 2017 07:30:44 -0700
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
Message-ID: <20170824143044.tu375seveoktinlm@sigill.intra.peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
 <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
 <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
 <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com>
 <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
 <alpine.DEB.2.20.1708241554520.5192@tvnag.unkk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1708241554520.5192@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 04:02:19PM +0200, Daniel Stenberg wrote:

> On Thu, 24 Aug 2017, Jeff King wrote:
> 
> > > I opened a bug upstream and they already fixed this.
> > > https://github.com/curl/curl/pull/1820
> > 
> > Cool! That's much faster than I had expected. :)
> 
> Your wish is our command! =)

Oh good. While I have you here, have you given any thought to a curl
handle that has two half-duplex file descriptors, rather than a single
full-duplex socket? That would let us tunnel over pipes rather than
worrying about the portability of socketpair().

I suspect it would be quite complicated, because I imagine that lots of
internal bits of curl assume there's a single descriptor.

>  / daniel.haxx.se (who landed the IMAP PREAUTH fix in curl)

Don't you land most of the fixes in curl? :)

-Peff
