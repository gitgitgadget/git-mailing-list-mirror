Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8958CC47E48
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E976101D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhGNVkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:40:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:50060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhGNVkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 17:40:22 -0400
Received: (qmail 391 invoked by uid 109); 14 Jul 2021 21:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 21:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28469 invoked by uid 111); 14 Jul 2021 21:37:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 17:37:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 17:37:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 1/3] doc/git-config: explain --file instead of referring to
 GIT_CONFIG
Message-ID: <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The explanation for the --file option only refers to GIT_CONFIG. This
redirection to an environment variable is confusing, but doubly so
because the description of GIT_CONFIG is out of date.

Let's describe --file from scratch, detailing both the reading and
writing behavior as we do for other similar options like --system, etc.

Signed-off-by: Jeff King <peff@peff.net>
---
The formatting is a bit clunky to read in the source, but I think it
looks OK in the rendered version. At any rate, it's all taken from the
other options, so if we want to improve it, it would make sense to do so
separately on top.

 Documentation/git-config.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5cddadafd2..193fef2867 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -143,7 +143,13 @@ See also <<FILES>>.
 
 -f config-file::
 --file config-file::
-	Use the given config file instead of the one specified by GIT_CONFIG.
+	For writing options: write to the specified file rather than the
+	repository `.git/config`.
++
+For reading options: read only from the specified file rather than from all
+avialable files.
++
+See also <<FILES>>.
 
 --blob blob::
 	Similar to `--file` but use the given blob instead of a file. E.g.
-- 
2.32.0.689.gbb74d99cdd

