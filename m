Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB6B1FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 20:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbcFPUdv (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:33:51 -0400
Received: from kitenet.net ([66.228.36.95]:45008 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469AbcFPUdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:33:49 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=A/53GomV;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466109184; bh=IIpBBUPCEEMfgA1LQIGmWTvGO+PU4ozAlesTJ/l23TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/53GomVebghVYiSCupyfpqsvVIdIvkc3QPNkNpz7BYtsJwUUxntBWMmiyU+goZfN
	 jcctf2IJQ6qIuE31auEhiRUaWfWAX7O0xJOmCMGFpF6WQIpJEi/KHuFWzPb2PO1gjT
	 7iN+el1JteZXOygzXEgndaNsNO2EGGZKdU86H/U8=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH 1/4] clarify %f documentation
Date:	Thu, 16 Jun 2016 16:32:56 -0400
Message-Id: <20160616203259.5886-2-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.4.g2856e74.dirty
In-Reply-To: <20160616203259.5886-1-joeyh@joeyh.name>
References: <20160616203259.5886-1-joeyh@joeyh.name>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It's natural to expect %f to be an actual file on disk; help avoid that
mistake.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 Documentation/gitattributes.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..e077cc9 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -365,8 +365,8 @@ you can declare that the filter is `required`, in the configuration:
 ------------------------
 
 Sequence "%f" on the filter command line is replaced with the name of
-the file the filter is working on.  A filter might use this in keyword
-substitution.  For example:
+the file in the git repository the filter is working on.
+A filter might use this in keyword substitution.  For example:
 
 ------------------------
 [filter "p4"]
@@ -374,6 +374,9 @@ substitution.  For example:
 	smudge = git-p4-filter --smudge %f
 ------------------------
 
+Note that the "%f" is the name of a file in the git repository; the
+corresponding file on disk may not exist, or may have unrelated contents to
+what git is filtering.
 
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.9.0.4.g2856e74.dirty

