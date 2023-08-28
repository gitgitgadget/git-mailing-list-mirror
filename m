Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98730C83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjH1VsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjH1Vr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:47:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BB2102
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:55 -0700 (PDT)
Received: (qmail 561 invoked by uid 109); 28 Aug 2023 21:47:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4544 invoked by uid 111); 28 Aug 2023 21:47:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/22] trace2: mark unused config callback parameter
Message-ID: <20230828214754.GJ3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should have been part of 783a86c142 (config: mark unused callback
parameters, 2022-08-19), but was missed in that commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace2/tr2_sysenv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index f26ec95ab4..d3ecac2772 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -58,7 +58,8 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
 /* clang-format on */
 
 static int tr2_sysenv_cb(const char *key, const char *value,
-			 const struct config_context *ctx UNUSED, void *d)
+			 const struct config_context *ctx UNUSED,
+			 void *d UNUSED)
 {
 	int k;
 
-- 
2.42.0.505.g4c6fb48dec

