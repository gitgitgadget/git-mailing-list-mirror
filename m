Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A1520189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbcFVVJl (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:09:41 -0400
Received: from kitenet.net ([66.228.36.95]:59238 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbcFVVJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:09:40 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=mg1eyg1Q;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466629760; bh=WzlFR/Fq+JjErnTxjwXdctZQ9oUxhdv7jiKLx+KAxsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mg1eyg1QBRMPxAs7JkBZk763MxlJQtVpEs0js6Jntr/SlYRSFweFXTfgwqRXdUH5A
	 2LHX9els/GLsyKLl8+/FTJHFG0lKbrXatEfhVXvSnJrhEzoklb77bFSGSV0RcMfbPA
	 KC7wJ9UK9jIFZLCDQH2vs/9egY6Kl9mCPlDLhlZY=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v4 1/8] clarify %f documentation
Date:	Wed, 22 Jun 2016 17:09:11 -0400
Message-Id: <1466629758-8035-2-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
References: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
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
index f2afdb6..197ece8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -379,6 +379,11 @@ substitution.  For example:
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
2.9.0.587.ga3bedf2

