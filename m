Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C5C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C774564DDF
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhA2WKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:10:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:40922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhA2WKt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:10:49 -0500
Received: (qmail 4267 invoked by uid 109); 29 Jan 2021 22:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 22:09:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9869 invoked by uid 111); 29 Jan 2021 22:10:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 17:10:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 17:10:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 05/10] p5303: measure time to repack with keep
Message-ID: <YBSHv3TWleRxM1+/@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
 <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
 <xmqqy2gbsclr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2gbsclr.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 12:38:08PM -0800, Junio C Hamano wrote:

> > Oops. Looks like I was the one who introduced that. Nobody seems to have
> > complained, so I'm somewhat tempted to leave it. But it would not be too
> > hard to replace with perl, I think.
> 
> Yeah, but would it be worth it?  I am actually OK to say that you
> need GNU sed if you want to run perf.  We already rely on GNU time
> to run perf tests, no?

True. This one is a little worse because it's subtle, and somebody might
copy it unknowingly into the regular test suite.

I am happy to leave it, or for you to pick up the patch I sent earlier
(which I did verify produces identical output).

-Peff
