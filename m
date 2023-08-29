Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7365CC83F17
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjH2XpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbjH2XpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662421B1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:14 -0700 (PDT)
Received: (qmail 14793 invoked by uid 109); 29 Aug 2023 23:45:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19838 invoked by uid 111); 29 Aug 2023 23:45:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 04/22] pack-bitmap: mark unused parameters in show_object
 callback
Message-ID: <20230829234513.GB227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
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
2.42.0.528.g7950723a09

