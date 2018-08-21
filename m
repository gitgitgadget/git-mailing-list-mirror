Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8F21F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHUWot (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:44:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:50804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726628AbeHUWos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:44:48 -0400
Received: (qmail 7590 invoked by uid 109); 21 Aug 2018 19:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26221 invoked by uid 111); 21 Aug 2018 19:23:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:23:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:23:22 -0400
Date:   Tue, 21 Aug 2018 15:23:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: mention doc-diff
Message-ID: <20180821192321.GA720@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already advise people to make sure their documentation
formats correctly. Let's point them at the doc-diff script,
which can help with that.

Let's also put a brief note in the script about its purpose,
since that otherwise can only be found in the original
commit message. Along with the existing -h/usage text,
that's hopefully enough for developers to make use of it.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a finishing touch on the jk/diff-rendered-docs topic.

 Documentation/SubmittingPatches | 4 +++-
 Documentation/doc-diff          | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b44fd51f27..ec8b205145 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -80,7 +80,9 @@ GitHub-Travis CI hints section for details.
 
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
-well. It is currently a liberal mixture of US and UK English norms for
+well (try the Documentation/doc-diff script).
+
+We currently have a liberal mixture of US and UK English norms for
 spelling and grammar, which is somewhat unfortunate.  A huge patch that
 touches the files all over the place only to correct the inconsistency
 is not welcome, though.  Potential clashes with other changes that can
diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index f483fe427c..6e285e648c 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -1,4 +1,12 @@
 #!/bin/sh
+#
+# Build two documentation trees and diff the resulting formatted output.
+# Compared to a source diff, this can reveal mistakes in the formatting.
+# For example:
+#
+#   ./doc-diff origin/master HEAD
+#
+# would show the differences introduced by a branch based on master.
 
 OPTIONS_SPEC="\
 doc-diff [options] <from> <to> [-- <diff-options>]
-- 
2.19.0.rc0.398.g138a08f6f6
