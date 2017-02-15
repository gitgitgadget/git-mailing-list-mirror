Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3002013A
	for <e@80x24.org>; Wed, 15 Feb 2017 16:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdBOQoU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 11:44:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:55867 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdBOQoT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 11:44:19 -0500
Received: (qmail 3472 invoked by uid 109); 15 Feb 2017 16:44:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:44:19 +0000
Received: (qmail 15585 invoked by uid 111); 15 Feb 2017 16:44:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 11:44:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 11:44:16 -0500
Date:   Wed, 15 Feb 2017 11:44:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Message-ID: <20170215164416.tekykkzhm6qlj2h2@sigill.intra.peff.net>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
 <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
 <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 09:27:53AM -0500, Jeff Hostetler wrote:

> I have some informal numbers in a spreadsheet.  I was seeing
> a 8-9% speed up on a status on my gigantic repo.
> 
> I'll try to put together a before/after perf-test to better
> demonstrate this.

Thanks. What I'm mostly curious about is how much each individual step
buys. Sometimes when doing a long optimization series, I find that some
of the optimizations make other ones somewhat redundant (e.g., if patch
2 causes us to call the optimized code from patch 3 less often).

-Peff
