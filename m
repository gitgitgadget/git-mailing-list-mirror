Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E98520188
	for <e@80x24.org>; Fri, 12 May 2017 09:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbdELJLO (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 05:11:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbdELJLL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 05:11:11 -0400
Received: (qmail 3352 invoked by uid 109); 12 May 2017 09:11:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 09:11:06 +0000
Received: (qmail 22394 invoked by uid 111); 12 May 2017 09:11:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 05:11:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 05:11:04 -0400
Date:   Fri, 12 May 2017 05:11:04 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/
 for good
Message-ID: <20170512091104.5yl57m4x6z5oxq3r@sigill.intra.peff.net>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 03:47:33PM +0200, Johannes Schindelin wrote:

> Git uses the config for remote/upstream information in favor of the
> previously-used .git/remotes/ and .git/branches/ for a decade now.
> 
> Nothing in Git writes to these files any longer, and the most prominent
> user of .git/branches/ (Cogito) is long abandoned.
> 
> It is time to start not only deprecating this feature, but *really*
> deprecating it. Like, really, *really*. For reals.

I like the goal, and the patches themselves (both the deprecations and
the actual removal) all look good to me.

If we want to start slow (and if Junio is right that there may be some
people who are actually using this feature, we probably should), step 0
may be making people aware that it's on the horizon, even before we
start issuing annoying warnings to them. This thread does that to some
degree, but we could also put it in the release notes for a version.
That's not guaranteed to get people's attention, but it gives more
opportunity for them to speak up before installing a version of Git that
produces warnings whenever they fetch.

-Peff
