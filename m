Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FE71FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757144AbcLAWX6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:23:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:50294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752680AbcLAWX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:23:57 -0500
Received: (qmail 21815 invoked by uid 109); 1 Dec 2016 22:23:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 22:23:57 +0000
Received: (qmail 5213 invoked by uid 111); 1 Dec 2016 22:24:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 17:24:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 17:23:55 -0500
Date:   Thu, 1 Dec 2016 17:23:55 -0500
From:   Jeff King <peff@peff.net>
To:     "Alfonsogonzalez, Ernesto (GE Digital)" 
        <ernesto.alfonsogonzalez@ge.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: EXT: Re: "Your branch is ahead of 'origin' by X commits"
Message-ID: <20161201222354.yu2q62udi56ygyoz@sigill.intra.peff.net>
References: <D465DC74.B911%ernesto.alfonsogonzalez@ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D465DC74.B911%ernesto.alfonsogonzalez@ge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 10:03:33PM +0000, Alfonsogonzalez, Ernesto (GE Digital) wrote:

> So I used branch ‹set-upstream and see the expected behavior.
> 
> $ git branch --set-upstream-to=origin/master
> Branch master set up to track remote branch master from origin.

Ah, that makes sense.

> I¹m still not sure what it means for the branch upstream to be ³origin²
> only.

The name "origin" generally resolves to refs/remotes/origin/HEAD, which
is a symbolic ref pointing to the "default branch" for that remote.
That's generally set at clone time from what the remote has in its HEAD,
but you can update it with "git remote set-head" if you want to.

But that's just for resolving the name; I'm not sure that it would work
to set a branch's upstream to just "origin".  Do you possibly have
another ref named origin?

-Peff
