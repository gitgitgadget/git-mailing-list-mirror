Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A5C71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjH1Vrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjH1Vrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:47:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18A186
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:32 -0700 (PDT)
Received: (qmail 534 invoked by uid 109); 28 Aug 2023 21:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4526 invoked by uid 111); 28 Aug 2023 21:47:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/22] pack-bitmap: mark unused parameters in show_object
 callback
Message-ID: <20230828214731.GD3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to the cases in c50dca2a18 (list-objects: mark unused
callback parameters, 2023-02-24), but was added after that commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6afc03d1e4..ca8319b87c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1101,8 +1101,9 @@ static void show_boundary_commit(struct commit *commit, void *_data)
 	}
 }
 
-static void show_boundary_object(struct object *object,
-				 const char *name, void *data)
+static void show_boundary_object(struct object *object UNUSED,
+				 const char *name UNUSED,
+				 void *data UNUSED)
 {
 	BUG("should not be called");
 }
-- 
2.42.0.505.g4c6fb48dec

