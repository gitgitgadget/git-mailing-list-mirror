Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC48C7CFD3
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942C24741
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfLMRjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:39:05 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:16186 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfLMRjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:39:05 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 21C386A7F2;
        Fri, 13 Dec 2019 17:39:04 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47ZHw76RDVz4HDk;
        Fri, 13 Dec 2019 17:39:03 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id D5AFF53A4; Fri, 13 Dec 2019 17:39:03 +0000 (UTC)
From:   Ed Maste <emaste@FreeBSD.org>
To:     git@vger.kernel.org
Cc:     lukasz@niemier.pl, Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH] userdiff: remove empty subexpression from elixir regex
Date:   Fri, 13 Dec 2019 17:39:02 +0000
Message-Id: <20191213173902.71541-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The regex failed to compile on FreeBSD.

Fixes: a807200f67588f6e
Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 324916f20f..165d7e8653 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -35,7 +35,7 @@ PATTERNS("dts",
 PATTERNS("elixir",
 	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
 	 /* Atoms, names, and module attributes */
-	 "|[@:]?[a-zA-Z0-9@_?!]+"
+	 "[@:]?[a-zA-Z0-9@_?!]+"
 	 /* Numbers with specific base */
 	 "|[-+]?0[xob][0-9a-fA-F]+"
 	 /* Numbers */
-- 
2.24.0

