Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274B4208D0
	for <e@80x24.org>; Thu, 17 Aug 2017 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdHQOWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 10:22:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752159AbdHQOWf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 10:22:35 -0400
Received: (qmail 23345 invoked by uid 109); 17 Aug 2017 14:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 14:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26762 invoked by uid 111); 17 Aug 2017 14:23:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 10:23:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 10:22:33 -0400
Date:   Thu, 17 Aug 2017 10:22:33 -0400
From:   Jeff King <peff@peff.net>
To:     "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
Message-ID: <20170817142233.v2c534zh6wv7ttei@sigill.intra.peff.net>
References: <1502960406180.9006@arris.com>
 <1502960572292.1402@arris.com>
 <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
 <1502969387926.66865@arris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1502969387926.66865@arris.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 11:29:48AM +0000, Carlsson, Magnus wrote:

> >  2. If we continue to follow the "are we storing any refs" rule for the
> >     default, possibly it should expand to "did we store anything,
> >     including opportunistic tracking-ref updates".
> 
> Personally I think that I would prefer to always fetch relevant tags.
> If I don't want tags I can simply use the "--no-tags"

I think it's a bit more complex because "git pull" uses "git fetch"
under the hood. In fact, your "git fetch origin master" is exactly what
gets run when you do:

  git pull origin master

That's maybe OK. But I think one-off pulls like:

  git pull https://example.com/repo.git master

probably wouldn't want it. I'd have to give it some thought.

-Peff
