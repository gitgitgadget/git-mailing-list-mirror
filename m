From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Sun, 20 Jul 2008 21:11:48 +0200
Message-ID: <200807202111.48332.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 21:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKeKy-0003fc-ED
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 21:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYGTTLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYGTTLw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 15:11:52 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:43137 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbYGTTLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 15:11:52 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 20EA533C6F;
	Sun, 20 Jul 2008 21:11:49 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D24A11D0C8;
	Sun, 20 Jul 2008 21:11:48 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89217>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
  Discovered by an accidental NO_MMAP=1 in config.mak.

  -- Hannes

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c676d97..2be40eb 100644
--- a/Makefile
+++ b/Makefile
@@ -1203,7 +1203,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o
+git-shell$X: abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o $(COMPAT_OBJS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-- 
1.5.6.3.443.g5f70e
