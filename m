Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A66620985
	for <e@80x24.org>; Tue, 13 Sep 2016 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754603AbcIMDXr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:42285 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754555AbcIMDXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:44 -0400
Received: (qmail 20270 invoked by uid 109); 13 Sep 2016 03:23:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:44 +0000
Received: (qmail 18454 invoked by uid 111); 13 Sep 2016 03:23:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:40 -0700
Date:   Mon, 12 Sep 2016 20:23:40 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 07/16] pager: remove obsolete comment
Message-ID: <20160913032340.v4drd44zylqwl7lq@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment at the top of pager.c claims that we've split
the code out so that Windows can do something different.
This dates back to f67b45f (Introduce trivial new pager.c
helper infrastructure, 2006-02-28), because the original
implementation used fork(). Later, we ended up sticking the
Windows #ifdefs into this file anyway. And then even later,
in ea27a18 (spawn pager via run_command interface,
2008-07-22) we unified the implementations.

So these days this comment is really saying nothing at all.
Let's drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/pager.c b/pager.c
index 6470b81..ae46da9 100644
--- a/pager.c
+++ b/pager.c
@@ -6,11 +6,6 @@
 #define DEFAULT_PAGER "less"
 #endif
 
-/*
- * This is split up from the rest of git so that we can do
- * something different on Windows.
- */
-
 static struct child_process pager_process = CHILD_PROCESS_INIT;
 
 static void wait_for_pager(int in_signal)
-- 
2.10.0.230.g6f8d04b

