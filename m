Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D9BC433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D032070B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgG1U1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:27:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:40248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgG1U1K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:27:10 -0400
Received: (qmail 29781 invoked by uid 109); 28 Jul 2020 20:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:27:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28664 invoked by uid 111); 28 Jul 2020 20:27:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:27:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:27:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/11] strvec: drop argv_array compatibility layer
Message-ID: <20200728202709.GJ1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers which need it anymore. Any topics in flight will
need to be updated as they get merged in (but the compiler will make
that quite clear).

Signed-off-by: Jeff King <peff@peff.net>
---
 strvec.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/strvec.h b/strvec.h
index 4be39c8a48..bd35de1ce4 100644
--- a/strvec.h
+++ b/strvec.h
@@ -86,17 +86,4 @@ void strvec_clear(struct strvec *);
  */
 const char **strvec_detach(struct strvec *);
 
-/* compatibility for historic argv_array interface */
-#define argv_array strvec
-#define ARGV_ARRAY_INIT STRVEC_INIT
-#define argv_array_init strvec_init
-#define argv_array_push strvec_push
-#define argv_array_pushf strvec_pushf
-#define argv_array_pushl strvec_pushl
-#define argv_array_pushv strvec_pushv
-#define argv_array_pop strvec_pop
-#define argv_array_split strvec_split
-#define argv_array_clear strvec_clear
-#define argv_array_detach strvec_detach
-
 #endif /* STRVEC_H */
-- 
2.28.0.rc2.475.g53c7e1c7f4

