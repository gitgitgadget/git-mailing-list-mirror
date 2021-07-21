Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBDC6379B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F296101E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbhGUKqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:46:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:53100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236767AbhGUJ7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:59:20 -0400
Received: (qmail 2183 invoked by uid 109); 21 Jul 2021 10:39:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:39:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3343 invoked by uid 111); 21 Jul 2021 10:39:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:39:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:39:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 12/24] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <YPf5a4LzBwNweI3W@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <c474d2eda5b0b4393616109915626134429085d5.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c474d2eda5b0b4393616109915626134429085d5.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:29PM -0400, Taylor Blau wrote:

> In a recent commit, pack-objects learned support for the
> 'pack.preferBitmapTips' configuration. This patch prepares the
> multi-pack bitmap code to respect this configuration, too.
> 
> Since the multi-pack bitmap code already does a traversal of all
> references (in order to discover the set of reachable commits in the
> multi-pack index), it is more efficient to check whether or not each
> reference is a suffix of any value of 'pack.preferBitmapTips' rather
> than do an additional traversal.
> 
> Implement a function 'bitmap_is_preferred_refname()' which does just
> that. The caller will be added in a subsequent patch.

I suspect there was some patch reordering here. We don't have any
multi-pack bitmap code yet. :)

Probably this needs to say something like "in preparation for adding
multi-pack bitmap code..." or similar?

-Peff
