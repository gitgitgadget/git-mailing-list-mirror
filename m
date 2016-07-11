Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992CD1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbcGKWqv (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:46:51 -0400
Received: from kitenet.net ([66.228.36.95]:60934 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbcGKWqu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:46:50 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=hbTM55ad;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277197; bh=Q37/p1l59xZISgA1LWyXTUqwJEg7T96CGx2mCEyU9UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbTM55adTxAE7hwBgj9q7PkR66nfsMxhWSpQn/R9iSUOaJ11fW10rEUxkLzcXKK5x
	 ktVQ6sdgyCC5CbgYfBn6sMJ+EH6sTTJlLS0czzSkl453Izvk85rBtBGYsVSCzgbPai
	 1rM45vbD/pViJQ2IUyiT/WxLexQFFn0DnVLiWuWA=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 1/8] clarify %f documentation
Date:	Mon, 11 Jul 2016 18:45:05 -0400
Message-Id: <1468277112-9909-2-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
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
2.8.1

