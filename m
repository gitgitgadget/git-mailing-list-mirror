Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A70320286
	for <e@80x24.org>; Fri,  8 Sep 2017 03:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbdIHDhi (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 23:37:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:60380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932108AbdIHDhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 23:37:36 -0400
Received: (qmail 8387 invoked by uid 109); 8 Sep 2017 03:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:37:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5546 invoked by uid 111); 8 Sep 2017 03:38:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 23:38:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 23:37:34 -0400
Date:   Thu, 7 Sep 2017 23:37:34 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: conditionally compile unleak_memory() definition
Message-ID: <20170908033733.r3c2akrtbk5wvqad@sigill.intra.peff.net>
References: <1cf112f5-aad1-e1c6-b507-9524f4b72fec@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cf112f5-aad1-e1c6-b507-9524f4b72fec@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 05:08:23PM +0100, Ramsay Jones wrote:

> Hi Jeff,
> 
> If you need to re-roll your 'jk/leak-checkers' branch, could you
> please squash this into the relevant patch (commit c57586d954,
> "add UNLEAK annotation for reducing leak false positives", 05-09-2017).
> 
> This was noticed by sparse, since it is not declared when the
> SUPPRESS_ANNOTATED_LEAKS pre-processor macro is not defined.
> (You could move the declaration out of the #ifdef in the header
> file, I suppose, but it seems pointless to compile the function
> if it isn't being used).

Thanks, that makes sense. There are a handful of other bits to modify in
that final commit, so I will end up with at least one re-roll.

-Peff
