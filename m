Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77DE1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 02:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdBIC5P (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 21:57:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:51993 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdBIC5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 21:57:14 -0500
Received: (qmail 20120 invoked by uid 109); 9 Feb 2017 02:50:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 02:50:33 +0000
Received: (qmail 17262 invoked by uid 111); 9 Feb 2017 02:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 21:50:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 21:50:30 -0500
Date:   Wed, 8 Feb 2017 21:50:30 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git-scm.com status report
Message-ID: <20170209025030.52frbjekatebjoii@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
 <20170209021208.rvy7uww3qsktbf4a@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170209021208.rvy7uww3qsktbf4a@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 02:12:09AM +0000, brian m. carlson wrote:

> My only concern with using GitHub Pages is that I don't believe it
> currently supports TLS on custom domains.  Since we currently have TLS
> enabled, along with HTTP Strict Transport Security (as we should), such
> a configuration literally wouldn't work[0].  I think it's important that
> we continue to serve HTTPS only, anyway.

I agree we should continue to serve HTTPS. The usual solution for our
use case is to stick a CDN like Cloudflare in front of GitHub Pages (and
I think we'd want to do that anyway for performance).

I haven't done it, but there are various guides. Here's the one from
Cloudflare:

  https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/

> I agree that a static site is the way to go from a maintenance
> perspective, though.  Jekyll does support Asciidoctor with a plugin,
> just not on GitHub Pages, so it would theoretically be possible to build
> the site as one big unit if we did it that way.  I've played around with
> that plugin, so I'm happy to provide guidance if we want to do that.

We already massage the data coming from Git (and from the Pro Git books)
a bit before and after feeding it to asciidoctor. So I always assumed
that any static site would involve some import steps for those things,
and we'd commit the intermediate product into the repository.

-Peff
