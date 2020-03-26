Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819BC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B0620772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgCZIZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:25:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726347AbgCZIZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:25:28 -0400
Received: (qmail 1305 invoked by uid 109); 26 Mar 2020 08:25:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:25:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12176 invoked by uid 111); 26 Mar 2020 08:35:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:35:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:25:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t/lib-credential.sh: drop shebang line
Message-ID: <20200326082527.GA3611762@coredump.intra.peff.net>
References: <20200326082338.GA3611364@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326082338.GA3611364@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of lib-credential.sh is to be sourced into other test
scripts. It doesn't need a "#!/bin/sh" line, as running it directly
makes no sense. Nor does it serve any real filetype documentation
purpose, as the file is cleary named with a ".sh" extension.

In the spirit of c74c72034f (test: replace shebangs with descriptions in
shell libraries, 2013-11-25), let's replace it with a human-readable
description.

Signed-off-by: Jeff King <peff@peff.net>
---
I left the similar case in lib-gpg alone so as not to conflict with
Dscho's version.

 t/lib-credential.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 937b831ea6..5ea8bc9f1d 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# Shell library for testing credential handling including helpers. See t0302
+# for an example of testing a specific helper.
 
 # Try a set of credential helpers; the expected stdin,
 # stdout and stderr should be provided on stdin,
-- 
2.26.0.576.gb87790c3c1

