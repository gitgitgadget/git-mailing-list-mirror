Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D0E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjJCU0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCU0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:26:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC25A7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:26:10 -0700 (PDT)
Received: (qmail 14850 invoked by uid 109); 3 Oct 2023 20:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14902 invoked by uid 111); 3 Oct 2023 20:26:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:26:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:26:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/10] t6700: mark test as leak-free
Message-ID: <20231003202609.GA7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has never leaked since it was added. Let's annotate it to make
sure it stays that way (and to reduce noise when looking for other
leak-free scripts after we fix some leaks).

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not directly related to the rest; this could be spun off to
its own series, or put atop jk/tree-name-and-depth-limit and merged from
there.

 t/t6700-tree-depth.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index e410c41234..9e70a7c763 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='handling of deep trees in various commands'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We'll test against two depths here: a small one that will let us check the
-- 
2.42.0.810.gbc538a0ee6

