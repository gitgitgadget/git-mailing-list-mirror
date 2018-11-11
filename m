Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77511F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeKKRPF (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:15:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:47736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727055AbeKKRPE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:15:04 -0500
Received: (qmail 1957 invoked by uid 109); 11 Nov 2018 07:27:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 07:27:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32046 invoked by uid 111); 11 Nov 2018 07:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 02:26:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 02:27:16 -0500
Date:   Sun, 11 Nov 2018 02:27:16 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 00/10] fast export and import fixes and features
Message-ID: <20181111072716.GK30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:02PM -0800, Elijah Newren wrote:

> This is a series of ten patches representing two doc corrections, one
> pedantic fix, three real bug fixes, one micro code refactor, and three
> new features.  Each of these ten changes is relatively small in size.
> These changes predominantly affect fast-export, but there's a couple
> small changes for fast-import as well.
> 
> I could potentially split these patches up, but I'd just end up
> chaining them sequentially since otherwise there'd be lots of
> conflicts; having 10 different single patch series with lots of
> dependencies sounded like a bigger pain to me, but let me know if you
> would prefer I split them up and how you suggest doing so.

I think it's fine to put them in sequence when there's a textual
dependency.  If it turns out that one of them needs more discussion and
we don't want it to hold later patches hostage, we can always re-roll at
that point.

(I also think it's fine to lump together thematically similar patches
even when they aren't strictly dependent, even textually. It's less work
for the maintainer to consider 1 group of 10 than 10 groups of 1).

> These patches were driven by the needs of git-repo-filter[1], but most
> if not all of them should be independently useful.

I left lots of comments. Some of the earlier ones may just be showing my
confusion about fast-export works (some of which was cleared up by your
later patches). But I like the overall direction for sure.

-Peff
