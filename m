Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A811F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeHJUnD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 16:43:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728835AbeHJUnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 16:43:02 -0400
Received: (qmail 17298 invoked by uid 109); 10 Aug 2018 18:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 18:12:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21598 invoked by uid 111); 10 Aug 2018 18:12:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 14:12:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 14:12:05 -0400
Date:   Fri, 10 Aug 2018 14:12:05 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Jolly <paul@myitcv.io>
Cc:     git@vger.kernel.org
Subject: Re: Change in behaviour in git fetch between 2.18.0 and
 2.18.0.547.g1d89318c48
Message-ID: <20180810181205.GA7516@sigill.intra.peff.net>
References: <CACoUkn5wXY7924hftXhCXh_N_htWoiaGEV5f7ZEM4-PE57_1oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACoUkn5wXY7924hftXhCXh_N_htWoiaGEV5f7ZEM4-PE57_1oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 07:04:08PM +0100, Paul Jolly wrote:

> I've tried to skim through the archive, but I couldn't find anything
> that describes what I'm seeing. Apologies if that's because I missed
> something/used the wrong search terms, or this is an intentional
> change in behaviour.
> 
> Using 2.18.0.547.g1d89318c48, git fetch behaves differently to 2.18.0.
> 
> The scenario in which I'm seeing a difference in behaviour is when
> there are (by virtue of the state of my local git repo and the origin,
> remote) pending objects, branch updates etc to fetch from the remote.
> [...]
> Indeed only if I repeat git fetch with 2.18.0.547.g1d89318c48 do I see
> the update to origin/master:

I think this is the bug from:

  https://public-inbox.org/git/20180729121900.GA16770@sigill.intra.peff.net/

The fix is in e2842b39f4 (fetch-pack: unify ref in and out param,
2018-08-01), and is currently in the 'next' branch, and marked for
merging to master in the next integration cycle.

-Peff
