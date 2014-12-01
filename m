From: Lars Wendler <polynomial-c@gentoo.org>
Subject: [PATCH] Fix build with LDFLAGS="-Wl,--as-needed"
Date: Mon,  1 Dec 2014 10:33:29 +0100
Message-ID: <1417426409-7328-1-git-send-email-polynomial-c@gentoo.org>
Cc: Lars Wendler <polynomial-c@gentoo.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 10:33:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvNMU-0002hg-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 10:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbaLAJdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 04:33:38 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:57353 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbaLAJdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 04:33:37 -0500
Received: from shanghai.paradoxon.rec (p4FDABF38.dip0.t-ipconnect.de [79.218.191.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: polynomial-c@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4979F33F7F8;
	Mon,  1 Dec 2014 09:33:36 +0000 (UTC)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260475>

Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
---
 contrib/svn-fe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index e8651aa..b90cf87 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -74,7 +74,7 @@ endif
 endif
 
 svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(XDIFF_LIB) $(GIT_LIB)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(EXTLIBS) -o $@ svn-fe.o $(LIBS)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ svn-fe.o $(LIBS) $(EXTLIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
 	$(QUIET_CC)$(CC) $(CFLAGS) -I../../vcs-svn -o $*.o -c $<
-- 
2.2.0
