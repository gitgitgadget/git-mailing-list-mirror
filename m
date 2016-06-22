Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E9A2018B
	for <e@80x24.org>; Wed, 22 Jun 2016 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbcFVUV6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:21:58 -0400
Received: from kitenet.net ([66.228.36.95]:57422 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbcFVUV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:21:56 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=IABSEch8;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466626899; bh=SclJGLnGHqBgV0aXdlPTdQNZzdj/Dn1OpYGSVw3q5qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IABSEch8Zkhw+0bWbmZxtnZBGpTB58xjV2r5QNGkwQrA93vtjrO2tf7vVBZ5hdEfQ
	 DJlrXE+a9Pz4Z1+byzKHpUdkiJpU2kl8bJXepmF9ycjGUbYNDDBSUwueqlCyL9SI8i
	 eV7X5LA4WofbGXk8H7xnAMo7cH2f8Rjg9NTzgsiE=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v3 1/8] clarify %f documentation
Date:	Wed, 22 Jun 2016 16:21:26 -0400
Message-Id: <20160622202133.23565-2-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.8.gf959b2a
In-Reply-To: <20160622202133.23565-1-joeyh@joeyh.name>
References: <20160622202133.23565-1-joeyh@joeyh.name>
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It's natural to expect %f to be an actual file on disk; help avoid that
mistake.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 Documentation/gitattributes.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..145dd10 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -374,6 +374,11 @@ substitution.  For example:
 	smudge = git-p4-filter --smudge %f
 ------------------------
 
+Note that "%f" is the name of the path that is being worked on. Depending
+on the version that is being filtered, the corresponding file on disk may
+not exist, or may have different contents. So, smudge and clean commands
+should not try to access the file on disk, but only act as filters on the
+content provided to them on standard input.
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.9.0.8.g973eabb.dirty

