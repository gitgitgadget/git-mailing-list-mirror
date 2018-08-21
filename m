Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95A31F97E
	for <e@80x24.org>; Tue, 21 Aug 2018 18:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeHUWC7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:02:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:50696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726813AbeHUWC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:02:59 -0400
Received: (qmail 5980 invoked by uid 109); 21 Aug 2018 18:41:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 18:41:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25425 invoked by uid 111); 21 Aug 2018 18:41:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 14:41:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 14:41:40 -0400
Date:   Tue, 21 Aug 2018 14:41:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] test-tool.h: include git-compat-util.h
Message-ID: <20180821184140.GA24165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test-tool programs include "test-tool.h" as their first
include, which breaks our CodingGuideline of "the first
include must be git-compat-util.h or an equivalent".

Rather than change them all, let's instead make test-tool.h
one of those equivalents, just like we do for builtin.h
(which many of the actual git builtins include first).

Signed-off-by: Jeff King <peff@peff.net>
---
Repost, as the original was in a larger thread about includes and didn't
get any comment.

 t/helper/test-tool.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e926c416ea..e954e8c522 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,6 +1,8 @@
 #ifndef __TEST_TOOL_H__
 #define __TEST_TOOL_H__
 
+#include "git-compat-util.h"
+
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
-- 
2.19.0.rc0.398.g138a08f6f6
