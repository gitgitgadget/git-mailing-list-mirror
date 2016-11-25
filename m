Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B221FF76
	for <e@80x24.org>; Fri, 25 Nov 2016 03:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbcKYDSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 22:18:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:47011 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbcKYDSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 22:18:11 -0500
Received: (qmail 3906 invoked by uid 109); 25 Nov 2016 03:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Nov 2016 03:18:11 +0000
Received: (qmail 15788 invoked by uid 111); 25 Nov 2016 03:18:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 22:18:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2016 22:18:09 -0500
Date:   Thu, 24 Nov 2016 22:18:09 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
References: <cover.1479938494.git.johannes.schindelin@gmx.de>
 <cover.1480019834.git.johannes.schindelin@gmx.de>
 <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de>
 <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611242211450.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 10:56:23PM +0100, Johannes Schindelin wrote:

> > I think it would probably be OK to ship with that caveat (people would
> > probably use --global config, or "git -c" for a quick override), but if
> > you really wanted to address it, you can do something like what
> > pager.c:read_early_config() does.
> 
> The config setting is already overkill (and does even make something much
> harder than before: running tests with the builtin difftool used to be as
> simply as `touch use-builtin-difftool && make -C t t7800-difftool.sh, now
> I have to edit t7800-difftool.sh to configure difftool.useBuiltin, and
> without the repo-level config even that would not be working).
> 
> Imitating read_early_config() would be overkill deluxe.

I would have expected it to just be a build-time flag, like:

  make BUILTIN_DIFFTOOL=Yes test

but I did not closely follow the rest of the conversation, so I am
probably just repeating bits that were already said. So probably ignore
me.

I'm happy with pretty much anything under the reasoning of "this does not
matter much because it is going away soon".

-Peff
