Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07A61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeIVEzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:55:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725748AbeIVEzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:55:48 -0400
Received: (qmail 6834 invoked by uid 109); 21 Sep 2018 23:04:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 23:04:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9684 invoked by uid 111); 21 Sep 2018 23:04:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 19:04:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 19:04:45 -0400
Date:   Fri, 21 Sep 2018 19:04:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] receive-pack: update comment with check_everything_connected
Message-ID: <20180921230444.GA2713@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That function is now called "check_connected()", but we forgot to update
this comment in 7043c7071c (check_everything_connected: use a struct
with named options, 2016-07-15).

Signed-off-by: Jeff King <peff@peff.net>
---
Just a minor annoyance I happened to notice while discussing in another
thread. I notice both of us still called it check-everything-connected
in our emails; old habits die hard, I suppose. ;)

 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a3bb13af10..3b7432c8e4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1834,7 +1834,7 @@ static void prepare_shallow_update(struct command *commands,
 	/*
 	 * keep hooks happy by forcing a temporary shallow file via
 	 * env variable because we can't add --shallow-file to every
-	 * command. check_everything_connected() will be done with
+	 * command. check_connected() will be done with
 	 * true .git/shallow though.
 	 */
 	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
-- 
2.19.0.762.gbd1f43ccbf
