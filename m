Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A0C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D1864E62
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBQTWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:22:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:36142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhBQTWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:22:08 -0500
Received: (qmail 19679 invoked by uid 109); 17 Feb 2021 19:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 19:21:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7586 invoked by uid 111); 17 Feb 2021 19:21:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 14:21:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 14:21:26 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/8] builtin/pack-objects.c: add '--stdin-packs' option
Message-ID: <YC1sthj/3xFyoInq@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <c96b1bf99582beefb96c3774b13a4f5a12fc61cc.1612411124.git.me@ttaylorr.com>
 <YCxZcz5JGtxObOF3@coredump.intra.peff.net>
 <YC1nfH356wfmAKE2@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC1nfH356wfmAKE2@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 01:59:08PM -0500, Taylor Blau wrote:

> > > +		if (rev_list_unpacked)
> > > +			add_unreachable_loose_objects();
> >
> > Despite the name, that function is adding both reachable and unreachable
> > ones. So it is doing what you want. It might be worth renaming, but it's
> > not too big a deal since it's local to this file.
> 
> Yeah, I tend to err on the side of "it's fine as-is" since this isn't
> exposed outside of pack-objects internals. If you feel strongly I'm
> happy to change it, but I suspect you don't.

Yeah, I don't feel strongly (and if we did change it, it should be in a
separate patch anyway).

-Peff
