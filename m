Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F9C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327E922D08
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhASXP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:15:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:60438 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbhASXLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:11:47 -0500
Received: (qmail 15585 invoked by uid 109); 19 Jan 2021 23:11:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 23:11:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13741 invoked by uid 111); 19 Jan 2021 23:11:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 18:11:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 18:11:03 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdnB3Qy46qQ2to4@coredump.intra.peff.net>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAdjBC7z2eE1Z0uk@coredump.intra.peff.net>
 <YAdkg7ZijzfB8eMc@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdkg7ZijzfB8eMc@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 06:00:19PM -0500, Taylor Blau wrote:

> > Good catch. It didn't matter until now because nobody relied on having a
> > NULL entry when no prefix had been added (instead, they always iterated
> > over prefixes->nr). IMHO that is worth fixing as a separate commit.
> 
> Yeah. Even after calling it out as such myself, I promptly forgot it
> when preparing the first patch I sent back to Jacob!
> 
> I didn't pull it out into its own patch, and rather folded it in to my
> 2/2. It has a small call-out of its own, but if you'd prefer it by
> itself, I'm happy to resubmit it with that change included.

It's not a _huge_ deal to me, but I think it is slightly nicer as a
separate patch. Plus it can easily be credited to Jacob, so at least he
gets some authorship credit out of this. :)

-Peff
