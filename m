Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8BB1FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 16:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbcKZQTL (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 11:19:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:47428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbcKZQTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 11:19:09 -0500
Received: (qmail 2006 invoked by uid 109); 26 Nov 2016 16:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 26 Nov 2016 16:19:09 +0000
Received: (qmail 23654 invoked by uid 111); 26 Nov 2016 16:19:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 26 Nov 2016 11:19:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2016 11:19:07 -0500
Date:   Sat, 26 Nov 2016 11:19:07 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
 <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de>
 <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox>
 <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251201580.117539@virtualbox>
 <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox>
 <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261320050.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611261320050.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2016 at 01:22:28PM +0100, Johannes Schindelin wrote:

> In other words, GIT_CONFIG_PARAMETERS is *explicitly scrubbed* from the
> environment when we run our tests (by the code block between the "before"
> and the "after" statements in the diff above).

Sorry if I wasn't clear. I meant to modify t7800 to run the tests twice,
once with the existing script and once with the builtin. I.e., to set
the variable after test-lib.sh has done its scrubbing, and then use a
loop or similar to go through the tests twice.

If you want to control it from outside the test script, you'd need
something like:

  if test "$GIT_TEST_DIFFTOOL" = "builtin"
  then
	GIT_CONFIG_PARAMETERS=...
  fi

-Peff
