Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EFEC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8613B23434
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbhANTwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:52:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:56380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbhANTwT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:52:19 -0500
Received: (qmail 17404 invoked by uid 109); 14 Jan 2021 19:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 19:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17461 invoked by uid 111); 14 Jan 2021 19:51:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 14:51:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 14:51:38 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <YACgyn029KBps/yx@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 05:23:25PM -0500, Taylor Blau wrote:

> In this revision, I addressed feedback from Junio, Peff, and Stolee. A
> range-diff is included below, but the main changes are:
> 
>   - Error messages are improved to include the pack and offset when applicable.
>   - Variable names were made clearer (e.g., n -> index_pos).
>   - Comments were added in pack-revindex.h to introduce relevant terminology,
>     and which methods convert between what orderings.
>   - int-sized lower- and upper-bounds were converted to be unsigned.

Thanks, this addresses all of my nits. I responded to a few of Junio's
reviews with some further comments/suggestions; the most interesting one
is using "index_pos" to indicate the ordering more clearly in patch 15.
I'm happy with or without including that.

-Peff
