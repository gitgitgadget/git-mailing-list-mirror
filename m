Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222DF202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 09:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755174AbdCGJGr (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 04:06:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:39607 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754881AbdCGJGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 04:06:25 -0500
Received: (qmail 1387 invoked by uid 109); 7 Mar 2017 08:59:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:59:29 +0000
Received: (qmail 24084 invoked by uid 111); 7 Mar 2017 08:59:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 03:59:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 03:59:26 -0500
Date:   Tue, 7 Mar 2017 03:59:26 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, bmwill@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170307085926.x4ahakdhyx2vkzlx@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
 <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 10:39:49AM -0800, Jonathan Tan wrote:

> The "nohash" thing was in the hope of requiring only one signature to sign
> all the hashes (in all the functions) that the user wants, while preserving
> round-tripping ability.

Thanks, this explained it very well.

I understand the tradeoff now, though I am still of the opinion that
simplicity is probably a more important goal.

In practice I'd imagine that anybody doing commit-signing would just
sign the more-secure hash, and people doing tag releases would probably
do a dual-sign to be verifiable by both old and new clients. Those are
infrequent enough that the extra computation probably doesn't matter.
But that's just my gut feeling.

-Peff
