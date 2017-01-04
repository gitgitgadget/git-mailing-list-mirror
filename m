Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC26020968
	for <e@80x24.org>; Wed,  4 Jan 2017 08:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935210AbdADIQ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 03:16:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:35050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbdADIQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 03:16:26 -0500
Received: (qmail 6163 invoked by uid 109); 4 Jan 2017 08:15:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 08:15:46 +0000
Received: (qmail 30671 invoked by uid 111); 4 Jan 2017 08:16:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 03:16:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2017 03:15:44 -0500
Date:   Wed, 4 Jan 2017 03:15:44 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] giteveryday: unbreak rendering with AsciiDoctor
Message-ID: <20170104081544.5htofa3zpgkvty7x@sigill.intra.peff.net>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
 <c3b21bbec96408c4d6698129fd336c24c9e2f0f0.1483373021.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3b21bbec96408c4d6698129fd336c24c9e2f0f0.1483373021.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 02, 2017 at 05:04:05PM +0100, Johannes Schindelin wrote:

> The "giteveryday" document has a callout list that contains a code
> block. This is not a problem for AsciiDoc, but AsciiDoctor sadly was
> explicitly designed *not* to render this correctly [*1*]. The symptom is
> an unhelpful
> 
> 	line 322: callout list item index: expected 1 got 12
> 	line 325: no callouts refer to list item 1
> 	line 325: callout list item index: expected 2 got 13
> 	line 327: no callouts refer to list item 2
> 
> In Git for Windows, we rely on the speed improvement of AsciiDoctor (on
> this developer's machine, `make -j15 html` takes roughly 30 seconds with
> AsciiDoctor, 70 seconds with AsciiDoc), therefore we need a way to
> render this correctly.
> 
> The easiest way out is to simplify the callout list, as suggested by
> AsciiDoctor's author, even while one may very well disagree with him
> that a code block hath no place in a callout list.

This looks like a good re-write to avoid the issue while maintaining the
meaning and flow of the original.

-Peff
