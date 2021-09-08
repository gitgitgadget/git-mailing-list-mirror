Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E70C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C929A61166
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350025AbhIHV2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 17:28:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:42440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhIHV2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 17:28:20 -0400
Received: (qmail 26329 invoked by uid 109); 8 Sep 2021 21:27:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 21:27:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2059 invoked by uid 111); 8 Sep 2021 21:27:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 17:27:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 17:27:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
Message-ID: <YTkqr9DjMZknr/yh@coredump.intra.peff.net>
References: <xmqqsfyf5b74.fsf@gitster.g>
 <YTjjqV/4/oceM3lM@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTjjqV/4/oceM3lM@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 12:24:09PM -0400, Taylor Blau wrote:

> On Wed, Sep 08, 2021 at 08:38:55AM -0700, Junio C Hamano wrote:
> > * tb/pack-finalize-ordering (2021-09-07) 2 commits
> >  - builtin/repack.c: move `.idx` files into place last
> >  - pack-write.c: rename `.idx` file into place last
> >
> >  The order in which various files that make up a single (conceptual)
> >  packfile has been reevaluated and straightened up.  This matters in
> >  correctness, as an incomplete set of files must not be shown to a
> >  running Git.
> >
> >  Will merge to 'next'?
> 
> Ævar has a series [1] that complements this one nicely, so I would be
> happy to see them both queued.
> 
> I had some suggestions inline, but I don't feel strongly about whether
> or not they are implemented.

I think regardless of Ævar's related patches, we'd want to see a re-roll
of yours that touches index-pack's final(), too.

-Peff
