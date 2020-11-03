Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA7C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C4D22280
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgKCQKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:10:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:46202 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgKCQKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:10:01 -0500
Received: (qmail 6452 invoked by uid 109); 3 Nov 2020 16:10:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 16:10:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1891 invoked by uid 111); 3 Nov 2020 16:10:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 11:10:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 11:10:00 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] hashmap: introduce a new hashmap_partial_clear()
Message-ID: <20201103161000.GC444466@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <061ab45a9bdae5352f62fa6e81bb21ae5c94b8df.1602549650.git.gitgitgadget@gmail.com>
 <20201030134131.GD3277724@coredump.intra.peff.net>
 <CABPp-BEV6ZNsA_qqV67P=W4gASLGoggoR4wP2R6kf0eNfcsDCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEV6ZNsA_qqV67P=W4gASLGoggoR4wP2R6kf0eNfcsDCw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 09:03:38AM -0700, Elijah Newren wrote:

> > It would be nice if we had some actual perf numbers to report here, so
> > we could know exactly how much it was buying us. But I guess things are
> > a bit out-of-order there. You want to do this series first and then
> > build merge-ort on top as a user. We could introduce the basic data
> > structure first, then merge-ort, and then start applying optimizations
> > with real-world measurements. But I'm not sure it's worth the amount of
> > time you'd have to spend to reorganize in that way.
> 
> Yeah, the perf benefits didn't really come until I added a
> strmap_clear() based on this, so as you discovered I put perf numbers
> in patch 7 of this series.  Should I add a mention of the later commit
> message at this point in the series?

Nah, I think it's OK as it is. That kind of thing matters more for
reviewing than when you find the commit later on. And we're already
discussing it during the review.

-Peff
