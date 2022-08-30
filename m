Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA1ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 19:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH3TkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiH3TkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 15:40:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462132B63D
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:40:10 -0700 (PDT)
Received: (qmail 7527 invoked by uid 109); 30 Aug 2022 19:40:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 19:40:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28353 invoked by uid 111); 30 Aug 2022 19:40:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 15:40:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 15:40:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 0/2] cleaning up tempfile active flag
Message-ID: <Yw5nmNJSm9uzLOKL@coredump.intra.peff.net>
References: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net>
 <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 12:46:29AM +0200, René Scharfe wrote:

> Subject: [PATCH] tempfile: avoid directory cleanup race

Thanks again for this patch. With it, I think it's reasonable to do the
following cleanup on top.

  [1/2]: tempfile: drop active flag
  [2/2]: tempfile: update comment describing state transitions

 tempfile.c | 28 ++++++----------------------
 tempfile.h |  3 +--
 2 files changed, 7 insertions(+), 24 deletions(-)

-Peff
