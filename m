Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6475520C32
	for <e@80x24.org>; Fri,  8 Dec 2017 09:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbdLHJFh (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 04:05:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:51870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750993AbdLHJFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 04:05:33 -0500
Received: (qmail 29722 invoked by uid 109); 8 Dec 2017 09:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 09:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30221 invoked by uid 111); 8 Dec 2017 09:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 04:05:55 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 04:05:31 -0500
Date:   Fri, 8 Dec 2017 04:05:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jacob.e.keller@intel.com
Subject: Re: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing
 --relative
Message-ID: <20171208090531.GC26199@sigill.intra.peff.net>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com>
 <20171207173034.12865-2-gitster@pobox.com>
 <20171207211102.GA12850@sigill.intra.peff.net>
 <xmqqpo7qb3n8.fsf@gitster.mtv.corp.google.com>
 <20171207222143.GA14845@sigill.intra.peff.net>
 <xmqqlgieb25x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgieb25x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 02:31:38PM -0800, Junio C Hamano wrote:

> If this goes on top as a standalone patch, then the reason why it is
> separate from the other users of _default() is not because the way
> it uses the null return is special, but because it was written by a
> different author, I would think.

Mostly I was just concerned that we missed a somewhat subtle bug in the
first conversion, and I think it's worth calling out in the commit
message why that callsite must be converted in a particular way. Whether
that happens in a separate commit or squashed, I don't care too much.

But I dunno. Maybe it is obvious now that the correct code is in there.
;)

-Peff
