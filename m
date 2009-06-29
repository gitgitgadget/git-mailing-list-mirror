From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Makefile: git.o depends on library headers
Date: Mon, 29 Jun 2009 21:42:08 +0200
Message-ID: <200906292142.08963.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLMkp-0005bs-5u
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 21:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739AbZF2TmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbZF2TmM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 15:42:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:32646 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759383AbZF2TmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 15:42:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 379DBA7EB4;
	Mon, 29 Jun 2009 21:42:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7BA77427A0;
	Mon, 29 Jun 2009 21:42:09 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122456>

This dependency was not yet specified anywhere else.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 41ab8e9..cdc40d0 100644
--- a/Makefile
+++ b/Makefile
@@ -1464,7 +1464,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
+$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
-- 
1.6.3.17.g1665f
