Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E407C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjHHVWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjHHVWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:22:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4AD44BF
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 14:19:58 -0700 (PDT)
Received: (qmail 12439 invoked by uid 109); 8 Aug 2023 21:19:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 21:19:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24467 invoked by uid 111); 8 Aug 2023 21:19:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 17:19:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 17:19:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: leak in jt/path-filter-fix, was Re: What's cooking in git.git
 (Aug 2023, #01; Wed, 2)
Message-ID: <20230808211957.GB322409@coredump.intra.peff.net>
References: <xmqqfs518gdh.fsf@gitster.g>
 <20230808192240.GA4091261@coredump.intra.peff.net>
 <ZNKj9vwZv4kKJEcL@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNKj9vwZv4kKJEcL@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 04:22:14PM -0400, Taylor Blau wrote:

> On Tue, Aug 08, 2023 at 03:22:40PM -0400, Jeff King wrote:
> > Since this hit 'next', Coverity complained about a small leak. Fixed by
> > the patch below.
> 
> The patch below looks good and makes sense to me. That warning is
> awfully long, though ;-).
> 
> In any event, I expect that 'next' will be rewound before this topic
> graduates, since it is meaty and we are in the middle of the -rc phase.
> 
> ...and we also have my series on top [1], so it may be worthwhile for
> you, Jonathan, and I to figure out how to combine our efforts here. I
> think that this could likely get squashed in to Jonathan's topic
> if/after it gets ejected from 'next'. We can take my patches together in
> the same series, separately in a different one, or discard them
> altogether.
> 
> If we do decide to pursue the approach in [1], I think combining
> everything together into one big series makes the most sense for ease of
> merging.

Yeah, I am just coming back from vacation and didn't follow all of the
discussion on this topic carefully. The few patches I sent today were
just enough to get the test suite passing again (the send-email fixes)
and silence any new Coverity warnings. ;)

If it does get re-rolled, I would be quite happy if my fix here just
gets squashed into the appropriate commit.

-Peff
