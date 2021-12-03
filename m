Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D27C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 05:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhLCFNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 00:13:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:42678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhLCFNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 00:13:38 -0500
Received: (qmail 21971 invoked by uid 109); 3 Dec 2021 05:10:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 05:10:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28768 invoked by uid 111); 3 Dec 2021 05:10:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 00:10:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 00:10:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 0/3] unused-parameter cleanups on top of
 pw/xdiff-classify-record-in-histogram
Message-ID: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
References: <xmqqzgpm2xrd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 06:16:54PM -0800, Junio C Hamano wrote:

> * pw/xdiff-classify-record-in-histogram (2021-11-18) 3 commits
>  - xdiff: simplify comparison
>  - xdiff: avoid unnecessary memory allocations
>  - diff histogram: intern strings
> 
>  "diff --histogram" optimization.
> 
>  Will merge to 'next'.

This being merged to 'next' tickled my -Wunused-parameter topic, so
there were a few more opportunities for cleanup.

Definitely not urgent, but I think worth doing. Prepared on top of the
topic branch.

  [1/3]: xdiff: drop CMP_ENV macro from xhistogram
  [2/3]: xdiff: drop xpparam_t parameter from histogram cmp_recs()
  [3/3]: xdiff: drop unused flags parameter from recs_match

 xdiff/xdiffi.c     | 18 +++++++++---------
 xdiff/xhistogram.c |  8 ++------
 2 files changed, 11 insertions(+), 15 deletions(-)

-Peff
