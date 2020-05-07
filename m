Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C8C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BD920736
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEGUmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:42:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:40920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726093AbgEGUmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:42:04 -0400
Received: (qmail 2621 invoked by uid 109); 7 May 2020 20:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:42:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21848 invoked by uid 111); 7 May 2020 20:42:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:42:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:42:04 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 0/8] commit-graph: drop CHECK_OIDS, peel in callers
Message-ID: <20200507204204.GF29683@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 06:07:09PM -0600, Taylor Blau wrote:

> Here's a small re-roll of my series to move peeling outside of the
> commit-graph internals, and drop the CHECK_OIDS flag. This re-roll was
> promised in [1], and only updates the messages used in the new progress
> meters. For convenience, a range-diff from v1 is included below.

I just reviewed v1. :) But I think the revised progress messages in v2
are much better.

The overall direction looks very good to me. I left a couple of
comments. Nothing too major, but I think there are some things worth
addressing (leaks, and more robust error checking in the final patch).

-Peff
