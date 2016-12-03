Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3731FF40
	for <e@80x24.org>; Sat,  3 Dec 2016 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbcLCQXd (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 11:23:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:51216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbcLCQXd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 11:23:33 -0500
Received: (qmail 15617 invoked by uid 109); 3 Dec 2016 16:23:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 16:23:19 +0000
Received: (qmail 21915 invoked by uid 111); 3 Dec 2016 16:23:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 11:23:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2016 11:23:18 -0500
Date:   Sat, 3 Dec 2016 11:23:18 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: make --only --allow-empty work without paths
Message-ID: <20161203162318.uv27n4uhylobegto@sigill.intra.peff.net>
References: <20161202221513.GA5370@inner.h.apk.li>
 <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
 <20161203065949.GG19570@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161203065949.GG19570@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 07:59:49AM +0100, Andreas Krey wrote:

> > OK. I'm not sure why you would want to create an empty commit in such a
> > case.
> 
> User: Ok tool, make me a pullreq.
> 
> Tool: But you haven't mentioned any issue
>       in your commit messages. Which are they?
> 
> User: Ok, that would be A-123.
> 
> Tool: git commit --allow-empty -m 'FIX: A-123'

OK. I think "tool" is slightly funny here, but I get that is part of the
real world works. Thanks for illustrating.

> > Yes, I think --run is a misfeature (I actually had to look it up, as I
> ...
> > implicit. If a single test script is annoyingly long to run, I'd argue
> 
> It wasn't about runtime but about output. I would have
> liked to see only the output of my still-failing test;
> a 'stop after test X' would be helpful there.

You can do --verbose-only=<n>, but if the test is failing, I typically
use "-v -i". That makes everything verbose, and then stops at the
failing test, so you can see the output easily.

-Peff
