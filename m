Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D631C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4691161423
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhJEUdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:33:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236314AbhJEUdA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:33:00 -0400
Received: (qmail 17629 invoked by uid 109); 5 Oct 2021 20:31:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 20:31:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6461 invoked by uid 111); 5 Oct 2021 20:31:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 16:31:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 16:31:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Message-ID: <YVy2DNd+XemykKE0@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The note on ordering for --batch-all-objects was written when that was
the only possible ordering. These days we have --unordered, too, so
let's point to it.

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly related to this series, but I noticed it while I was in the
area, and I'm about to touch these same lines, so it seemed better than
spinning it off into its own series.

 Documentation/git-cat-file.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 4eb0421b3f..6467707c6e 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -94,8 +94,9 @@ OPTIONS
 	Instead of reading a list of objects on stdin, perform the
 	requested batch operation on all objects in the repository and
 	any alternate object stores (not just reachable objects).
-	Requires `--batch` or `--batch-check` be specified. Note that
-	the objects are visited in order sorted by their hashes.
+	Requires `--batch` or `--batch-check` be specified. By default,
+	the objects are visited in order sorted by their hashes; see
+	also `--unordered` below.
 
 --buffer::
 	Normally batch output is flushed after each object is output, so
-- 
2.33.0.1231.g45ae28b974

