Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618851F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQTyG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:54:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729716AbeGQTyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:54:06 -0400
Received: (qmail 14255 invoked by uid 109); 17 Jul 2018 19:19:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 19:19:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24896 invoked by uid 111); 17 Jul 2018 19:20:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 15:20:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 15:20:02 -0400
Date:   Tue, 17 Jul 2018 15:20:02 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] repack -ad: fix after `fetch --prune` in a
 shallow repository
Message-ID: <20180717192002.GB30594@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <pull.9.v2.git.gitgitgadget@gmail.com>
 <20180717191531.GA30594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717191531.GA30594@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 03:15:31PM -0400, Jeff King wrote:

> > - Also trigger `prune_shallow()` when `--unpack-unreachable=<approxidate>` was passed to `git repack`.
> > - No need to trigger `prune_shallow()` when `git repack` was called with `-k`.
> 
> I think you might have missed the bigger problem I pointed at, as it was
> buried deep within my later reply. Try applying this patch on top, which
> tests the opposite case (reachable shallow commits are retained):

By the way, I notice that the patches themselves are cc'd to you, but
the cover letter isn't. So my reply went only to gitgitgadget, which
(AFAIK) has not yet learned to work as a mail-to-comment gateway.

So I'm copying this to you directly to make sure you see it, but also
because I'm not sure if the gitgitgadget cc behavior is intentional or
not.

-Peff
