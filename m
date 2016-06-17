Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EADA1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 22:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbcFQWn4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 18:43:56 -0400
Received: from kitenet.net ([66.228.36.95]:34582 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbcFQWnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 18:43:55 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=ahXZvCGf;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466203425; bh=Hx1q36a7uhG2DeGmd2V8H9EtAgvZXHTjw+pGEJzYZEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahXZvCGf5JlTOJFIl5FJUwvCgG/xmwf0VEL6B5C20gGttFyhG6BMZ0VTYErrGqe+n
	 UTAPuRyp9ePs9knxIbNxEdwbbsO7Xeqz3C6l6et+8GklUih6NY3KtJt97M8yAIezVI
	 p6VaTnlBQnzpCBOMRJ5lKk4fEbOZRiQ/zdgsofwI=
Date:	Fri, 17 Jun 2016 18:43:45 -0400
From:	Joey Hess <joeyh@joeyh.name>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH v2 0/4] clarify %f documentation
Message-ID: <20160617224345.GA26764@kitenet.net>
References: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
 <xmqqshwbzfab.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <xmqqshwbzfab.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-93.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST
	autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It's natural to expect %f to be an actual file on disk; help avoid that
mistake.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---

This patch series was meant to contain 5 patches; here's the missing
one. This patch will apply cleanly on top of v2.9.0.

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
2.8.1
