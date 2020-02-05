Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA09C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CD021741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBEMaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:30:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:52994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726961AbgBEMaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 07:30:20 -0500
Received: (qmail 16408 invoked by uid 109); 5 Feb 2020 12:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Feb 2020 12:30:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7090 invoked by uid 111); 5 Feb 2020 12:38:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Feb 2020 07:38:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Feb 2020 07:30:18 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: Re: [PATCH v2 0/5] commit-graph: use 'struct object_directory *'
 everywhere
Message-ID: <20200205123018.GB55322@coredump.intra.peff.net>
References: <cover.1580424766.git.me@ttaylorr.com>
 <cover.1580764494.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580764494.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 01:17:53PM -0800, Taylor Blau wrote:

> Here is a re-roll of the series in this thread to replace string-based
> path comparison in 'commit-graph.c' code with raw pointer comparison of
> 'struct object_directory *'s.
> 
> The only thing that has changed substantially since v1 is that I swapped
> the order of patches 2/6 and 4/6. What was patch 3/6 got folded into
> what is now patch 2/5. This resolves an inconvenience where we had to
> define a helper function in 'commit-graph.c', when it really belonged in
> 'builtin/commit-graph.c'.
> 
> I took a few other suggestions from Martin in what is now patch 4/5, and
> noticed a few other small things along the way. A range-diff since v1 is
> included below.

Thanks, I read over this and the new layout looks quite good.

-Peff
