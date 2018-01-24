Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D081F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeAXUiJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:38:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:56014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932072AbeAXUiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:38:09 -0500
Received: (qmail 30314 invoked by uid 109); 24 Jan 2018 20:38:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 20:38:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28397 invoked by uid 111); 24 Jan 2018 20:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 15:38:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 15:38:06 -0500
Date:   Wed, 24 Jan 2018 15:38:06 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Yet another approach to handling empty snapshots
Message-ID: <20180124203806.GD7773@sigill.intra.peff.net>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
 <cover.1516791909.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 12:14:10PM +0100, Michael Haggerty wrote:

> This patch series fixes the handling of empty packed-refs snapshots
> (i.e., those with `snapshot->buf` and friends equal to `NULL`), partly
> by changing `snapshot` to store a pointer to the start of the
> post-header `packed-refs` content instead of `header_len`. It makes a
> couple of other improvements as well.
> 
> I'm not sure whether I like this approach better than the alternative
> of always setting `snapshot->buf` to a non-NULL value, by allocating a
> length-1 bit of RAM if necessary. The latter is less intrusive, though
> even if that approach is taken, I think patches 01, 02, and 04 from
> this patch series would be worthwhile improvements.

This looks good to me. I agree that 1, 2, and 4 are improvements
regardless (but 4 as it is now depends on 3, right?).

I don't have a strong opinion between this series and the other options
presented. It's probably not worth agonizing over, so we should pick one
and move on.

-Peff
