Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0AD1FF6D
	for <e@80x24.org>; Sun, 27 Nov 2016 16:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbcK0QvD (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 11:51:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:47583 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbcK0QvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 11:51:02 -0500
Received: (qmail 32379 invoked by uid 109); 27 Nov 2016 16:51:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 16:51:01 +0000
Received: (qmail 29285 invoked by uid 111); 27 Nov 2016 16:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 11:51:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2016 11:50:59 -0500
Date:   Sun, 27 Nov 2016 11:50:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox>
 <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251201580.117539@virtualbox>
 <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox>
 <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261320050.117539@virtualbox>
 <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261400300.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611261400300.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2016 at 02:01:36PM +0100, Johannes Schindelin wrote:

> > If you want to control it from outside the test script, you'd need
> > something like:
> > 
> >   if test "$GIT_TEST_DIFFTOOL" = "builtin"
> 
> That is a bit magic. I first used "GIT_USE_BUILTIN_DIFFTOOL" and it did
> not work. My name is arguably more correct (see also Jakub's note about
> "naming is hard"), but yours works because there is a "TEST" substring in
> it.

Yes. You are free to add an exception to the env list in test-lib.sh,
but we usually use GIT_TEST_* to avoid having to do so.

-Peff
