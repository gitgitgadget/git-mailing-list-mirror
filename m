Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD1C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733D860FEB
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhG0RLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:11:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:58796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0RLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:11:51 -0400
Received: (qmail 30926 invoked by uid 109); 27 Jul 2021 17:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:11:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 651 invoked by uid 111); 27 Jul 2021 17:11:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:11:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:11:50 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YQA+VjLMV0icRvut@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <YPft87yCjR9e+93E@coredump.intra.peff.net>
 <YPhXb9Zns8S6aIod@nand.local>
 <YPpx0KoGUX0KfdSw@coredump.intra.peff.net>
 <YP8Dc9rHLrUmYQMl@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP8Dc9rHLrUmYQMl@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 02:48:19PM -0400, Taylor Blau wrote:

> On Fri, Jul 23, 2021 at 03:37:52AM -0400, Jeff King wrote:
> > I thought about suggesting that it be called "err" or "ret" or
> > something. And then we do not have to care that fill_bitmap_commit()
> > only returns an error in the non-closed state. We are simply propagating
> > its error-return back up the stack.
> 
> Hmm. For whatever the inconvience costs us, I do like that the variable
> can be named specifically like "open" or "closed" as opposed to the more
> generic "err" or "ret".
> 
> So I'll probably keep it is unless you feel strongly (which I suspect
> you do not).

I don't.

-Peff
