Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0EE1208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbdHIVsC (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:48:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:33888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752378AbdHIVsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:48:01 -0400
Received: (qmail 29716 invoked by uid 109); 9 Aug 2017 21:48:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:48:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31598 invoked by uid 111); 9 Aug 2017 21:48:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:48:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:47:58 -0400
Date:   Wed, 9 Aug 2017 17:47:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
Message-ID: <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:42:12PM +0200, Johannes Schindelin wrote:

> > This is a resurrection of the thread from April:
> > 
> >   https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/
> 
> As before, I would like to point out that people running with older cURL
> are most likely not at liberty to change the system libraries.
> 
> I know that I didn't when I was working on a very expensive microscope
> whose only certified control computer ran a very old version of CentOS,
> and I really needed to install Git on it.
> 
> In such a case, it is often preferable to be able to build against an old
> cURL -- even if some of the fancier features might be broken, and even if
> some minor compile errors need to be fixed.
> 
> I know I was happy to compile Git against an ancient cURL back then.
> 
> Just so you understand where I come from when I would like to caution
> against dropping support for older cURL unless it *really* adds an
> *enormous* amount of maintenance burden.
> 
> I mean, if we even go out of our way to support the completely outdated
> and obsolete .git/branches/ for what is likely a single user, it may not
> be the worst to keep those couple of #ifdef guards to keep at least
> nominal support for older cURLs?

You've totally ignored the argument I made back then[1], and which I
reiterated in this thread. So I'll say it one more time: the more
compelling reason is not the #ifdefs, but the fact that the older
versions are totally untested.  In fact, they do not even compile, and
yet I have not seen any patches to fix that.

So IMHO this is about being honest with users about which versions we
_actually_ support.

-Peff

[1] https://public-inbox.org/git/20170410182215.figy7hm4sogwipyz@sigill.intra.peff.net/
