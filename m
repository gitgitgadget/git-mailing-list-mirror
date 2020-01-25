Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304A9C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4882072C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbgAYAGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:06:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:44256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387449AbgAYAGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:06:32 -0500
Received: (qmail 9186 invoked by uid 109); 25 Jan 2020 00:06:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 00:06:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12340 invoked by uid 111); 25 Jan 2020 00:13:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 19:13:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 19:06:31 -0500
From:   Jeff King <peff@peff.net>
To:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 2/3] t1506: drop space after redirection operator
Message-ID: <20200125000631.GB567109@coredump.intra.peff.net>
References: <20200125000542.GA566779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125000542.GA566779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some (but not all!) redirections in this file are spelled "2> error".
Let's switch them to our usual style.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1506-rev-parse-diagnosis.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 8a75f37a11..f49fc770d6 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -104,35 +104,35 @@ test_expect_success 'correct relative file objects (6)' '
 test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
 	grep "Invalid object name '"'"'foobar'"'"'." error &&
-	test_must_fail git rev-parse foobar 2> error &&
+	test_must_fail git rev-parse foobar 2>error &&
 	test_i18ngrep "unknown revision or path not in the working tree." error
 '
 
 test_expect_success 'incorrect file in sha1:path' '
-	test_must_fail git rev-parse HEAD:nothing.txt 2> error &&
+	test_must_fail git rev-parse HEAD:nothing.txt 2>error &&
 	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"'"'" error &&
-	test_must_fail git rev-parse HEAD:index-only.txt 2> error &&
+	test_must_fail git rev-parse HEAD:index-only.txt 2>error &&
 	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." error &&
 	(cd subdir &&
-	 test_must_fail git rev-parse HEAD:file2.txt 2> error &&
+	 test_must_fail git rev-parse HEAD:file2.txt 2>error &&
 	 test_did_you_mean HEAD subdir/ file2.txt exists )
 '
 
 test_expect_success 'incorrect file in :path and :N:path' '
-	test_must_fail git rev-parse :nothing.txt 2> error &&
+	test_must_fail git rev-parse :nothing.txt 2>error &&
 	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
-	test_must_fail git rev-parse :1:nothing.txt 2> error &&
+	test_must_fail git rev-parse :1:nothing.txt 2>error &&
 	grep "Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
-	test_must_fail git rev-parse :1:file.txt 2> error &&
+	test_must_fail git rev-parse :1:file.txt 2>error &&
 	test_did_you_mean ":0" "" file.txt "is in the index" "at stage 1" &&
 	(cd subdir &&
-	 test_must_fail git rev-parse :1:file.txt 2> error &&
+	 test_must_fail git rev-parse :1:file.txt 2>error &&
 	 test_did_you_mean ":0" "" file.txt "is in the index" "at stage 1" &&
-	 test_must_fail git rev-parse :file2.txt 2> error &&
+	 test_must_fail git rev-parse :file2.txt 2>error &&
 	 test_did_you_mean ":0" subdir/ file2.txt "is in the index" &&
-	 test_must_fail git rev-parse :2:file2.txt 2> error &&
+	 test_must_fail git rev-parse :2:file2.txt 2>error &&
 	 test_did_you_mean :0 subdir/ file2.txt "is in the index") &&
-	test_must_fail git rev-parse :disk-only.txt 2> error &&
+	test_must_fail git rev-parse :disk-only.txt 2>error &&
 	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index." error
 '
 
-- 
2.25.0.421.gb74d19af79

