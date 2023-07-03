Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7884EB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGCGon (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGCGog (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E911E41
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:32 -0700 (PDT)
Received: (qmail 14105 invoked by uid 109); 3 Jul 2023 06:44:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2643 invoked by uid 111); 3 Jul 2023 06:44:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/14] rev-parse: mark unused parameter in for_each_abbrev
 callback
Message-ID: <20230703064431.GL3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to use the "data" parameter in this instance. Let's mark
it to avoid -Wunused-parameter warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 3e2ee44177..075e2c5aa4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -226,7 +226,7 @@ static int anti_reference(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int show_abbrev(const struct object_id *oid, void *cb_data)
+static int show_abbrev(const struct object_id *oid, void *cb_data UNUSED)
 {
 	show_rev(NORMAL, oid, NULL);
 	return 0;
-- 
2.41.0.586.g3c0cc15bc7

