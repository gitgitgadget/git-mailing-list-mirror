Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B31C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2A122CF7
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgLDVEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:04:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:52330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgLDVEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:04:47 -0500
Received: (qmail 931 invoked by uid 109); 4 Dec 2020 21:04:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 21:04:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16777 invoked by uid 111); 4 Dec 2020 21:04:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 16:04:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 16:04:05 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/2] upload-pack.c: don't free allowed_filters util
 pointers
Message-ID: <X8qkRRrWCbDn1MAu@coredump.intra.peff.net>
References: <cover.1607021483.git.me@ttaylorr.com>
 <a3c721054f337eac2b3a038e51693f44b68dd619.1607021483.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3c721054f337eac2b3a038e51693f44b68dd619.1607021483.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 01:55:18PM -0500, Taylor Blau wrote:

> We never noticed this in the tests because we didn't have an example of
> setting 'uploadPackFilter' configuration variables and then following up
> with a valid fetch. The first new 'git clone' prevents further
> regression here. For good measure on top, add a test which checks the
> same behavior at a tree depth greater than 0.

Very nice. The fix is obviously the right thing, but I like the
improvements to the tests here especially.

-Peff
