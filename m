Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73305C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiLMLPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiLMLOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:14:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE061A238
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:13:25 -0800 (PST)
Received: (qmail 14492 invoked by uid 109); 13 Dec 2022 11:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:13:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4315 invoked by uid 111); 13 Dec 2022 11:13:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:13:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:13:24 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/9] xdiff: mark unused parameter in xdl_call_hunk_func()
Message-ID: <Y5heVMGLAQpWq39E@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is used interchangeably with xdl_emit via a function
pointer, so we can't just drop the unused parameter. Mark it to silence
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xdiffi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 32652ded2d..344c2dfc3e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -973,7 +973,7 @@ void xdl_free_script(xdchange_t *xscr) {
 	}
 }
 
-static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+static int xdl_call_hunk_func(xdfenv_t *xe UNUSED, xdchange_t *xscr, xdemitcb_t *ecb,
 			      xdemitconf_t const *xecfg)
 {
 	xdchange_t *xch, *xche;
-- 
2.39.0.546.g5ea984bc66

