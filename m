Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7EC433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD744619C5
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 16:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhC3QCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:02:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:37510 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhC3QBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 12:01:54 -0400
Received: (qmail 21519 invoked by uid 109); 30 Mar 2021 16:01:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 16:01:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27270 invoked by uid 111); 30 Mar 2021 16:01:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 12:01:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 12:01:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 00/16] midx: implement a multi-pack reverse index
Message-ID: <YGNLcBH5rldiSAWC@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
 <YGNHj6iRlCOjjCL8@coredump.intra.peff.net>
 <YGNIp4AHcdaHHHUc@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGNIp4AHcdaHHHUc@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 11:49:59AM -0400, Taylor Blau wrote:

> On Tue, Mar 30, 2021 at 11:45:19AM -0400, Jeff King wrote:
> > > This reroll differs only in the feedback I incorporated from Peff's review. They
> > > are mostly cosmetic; the most substantial change being that the --preferred-pack
> > > code now uses bsearch() to locate the name of the preferred pack (instead of
> > > implementing a binary search itself).
> >
> > Yeah, I read over this part carefully, since it's actual new code (that
> > isn't run yet!), but I think it is correct.
> 
> Thankfully this does have coverage via any test that passes
> `--preferred-pack` (like the one below).

Oh right, I forgot this was touching that early part. So now I'm doubly
confident in it.

-Peff
