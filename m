Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4108B208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbdHTKQg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 06:16:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:44014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752808AbdHTKQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 06:16:35 -0400
Received: (qmail 29749 invoked by uid 109); 20 Aug 2017 10:16:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 10:16:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13516 invoked by uid 111); 20 Aug 2017 10:17:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 06:17:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 06:16:32 -0400
Date:   Sun, 20 Aug 2017 06:16:32 -0400
From:   Jeff King <peff@peff.net>
To:     ch <cr@onlinehome.de>
Cc:     git@vger.kernel.org
Subject: Re: Add --ignore-missing to git-pack-objects?
Message-ID: <20170820101632.irj22dighcrrcvlv@sigill.intra.peff.net>
References: <7d7a5801-1418-cc03-6d88-c148a38fccec@onlinehome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d7a5801-1418-cc03-6d88-c148a38fccec@onlinehome.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 12:51:01AM +0200, ch wrote:

> Is it possible to add an option akin to git-rev-list's '--ignore-missing' to
> git-pack-objects?
> 
> I use git bundles to (incrementally) backup my repositories. My script inspects
> all bundles in the backup and passes their contained refs as excludes to
> git-pack-objects to build the pack for the new bundle. This works fine as long
> as none of these refs have been garbage-collected in the source repository.
> Something like '--ignore-missing' would be really handy here to ask
> git-pack-objects to simply ignore any of the passed revs that are not present
> (anymore).

So if I understand correctly, you are only using these for the negative
side of the traversal? rev-list should ignore missing objects in such a
case even without --ignore-missing, and I think it may simply be a bug
if pack-objects is not.

Do you have a simple reproduction recipe?

-Peff
