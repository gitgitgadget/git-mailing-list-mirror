Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3CC51F51C
	for <e@80x24.org>; Sun, 20 May 2018 17:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeETRIR (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 13:08:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:47008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751521AbeETRIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 13:08:16 -0400
Received: (qmail 22908 invoked by uid 109); 20 May 2018 17:08:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 May 2018 17:08:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23110 invoked by uid 111); 20 May 2018 17:08:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 20 May 2018 13:08:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 May 2018 10:08:14 -0700
Date:   Sun, 20 May 2018 10:08:14 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 3/5] query_fsmonitor: use xsnprintf for formatting
 integers
Message-ID: <20180520170814.GB11967@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
 <20180519015758.GC32492@sigill.intra.peff.net>
 <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 19, 2018 at 10:27:46AM +0200, René Scharfe wrote:

> Am 19.05.2018 um 03:57 schrieb Jeff King:
> > These formatted integers should always fit into their
> > 64-byte buffers. Let's use xsnprintf() to add an assertion
> > that this is the case, which makes auditing for other
> > unchecked snprintfs() easier.
> 
> How about this instead?
> 
> -- >8 --
> Subject: [PATCH] fsmonitor: use internal argv_array of struct child_process

Yeah, I agree that is much nicer (I was so focused on the snprintfs I
didn't bother to look at the context for a better solution).

Thanks, getting a review in the form of a complete patch is my favorite
kind of review. :)

> Inspired-by: Jeff King <peff@peff.net>

Heh.

-Peff
