Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11215C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF7E60EFD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhGWGxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:53:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:55384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhGWGxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:53:54 -0400
Received: (qmail 10186 invoked by uid 109); 23 Jul 2021 07:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:34:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22885 invoked by uid 111); 23 Jul 2021 07:34:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:34:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:34:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2] multi-pack-index: fix potential segfault without
 sub-command
Message-ID: <YPpxA1XWw65pRr0P@coredump.intra.peff.net>
References: <YPfWkzRtQKthOgZx@coredump.intra.peff.net>
 <12804130427fd71e88ce10aed283c1f9cdd330ef.1626886330.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12804130427fd71e88ce10aed283c1f9cdd330ef.1626886330.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 12:52:37PM -0400, Taylor Blau wrote:

> I didn't realize that we are veering away from test_i18ngrep in new
> tests, so here's a version of this trivial patch with grep instead.

This looks fine to me, but it looks like Junio may have already merged
the original into 'next' via 995cb54b5b (Merge branch 'tb/reverse-midx'
into next, 2021-07-20).

So we'd have to update it on top. I think we can just leave it be,
though. There's nothing incorrect about using test_i18ngrep for now, and
there are a ton of existing instances to handle if we choose to do a
bulk cleanup. One more isn't a big deal.

-Peff
