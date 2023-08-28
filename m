Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F6C83F1B
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjH1Vsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjH1VsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1461F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:08 -0700 (PDT)
Received: (qmail 580 invoked by uid 109); 28 Aug 2023 21:48:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4559 invoked by uid 111); 28 Aug 2023 21:48:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/22] worktree: mark unused parameters in noop repair
 callback
Message-ID: <20230828214807.GO3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The noop repair callback unsurprisingly does not look at any of its
parameters. Mark them as unused to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index b8cf29e6a1..a56a6c2a3d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -581,8 +581,10 @@ static void repair_gitfile(struct worktree *wt,
 	strbuf_release(&dotgit);
 }
 
-static void repair_noop(int iserr, const char *path, const char *msg,
-			void *cb_data)
+static void repair_noop(int iserr UNUSED,
+			const char *path UNUSED,
+			const char *msg UNUSED,
+			void *cb_data UNUSED)
 {
 	/* nothing */
 }
-- 
2.42.0.505.g4c6fb48dec

