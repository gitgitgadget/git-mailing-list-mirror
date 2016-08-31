Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2E51FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 03:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758500AbcHaDjk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 23:39:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:35700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756892AbcHaDjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 23:39:39 -0400
Received: (qmail 31998 invoked by uid 109); 31 Aug 2016 03:39:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 03:39:39 +0000
Received: (qmail 2659 invoked by uid 111); 31 Aug 2016 03:39:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 23:39:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 23:39:34 -0400
Date:   Tue, 30 Aug 2016 23:39:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] squelch some "gcc -O3 -Wmaybe-uninitialized" warnings
Message-ID: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I happened to be compiling git with -O3 today, and noticed we generate
some warnings about uninitialized variables (I actually compile with
-Wall, but the only false positives I saw were these).

Here are patches to squelch them.

  [1/2]: error_errno: use constant return similar to error()
  [2/2]: color_parse_mem: initialize "struct color" temporary

-Peff
