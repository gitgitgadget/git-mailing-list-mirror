X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] no need to install manpages as executable
Date: Sun, 10 Dec 2006 23:39:32 -0800
Message-ID: <20061211073932.GA12555@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 11 Dec 2006 07:35:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33976>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtfgt-0003zg-Ay for gcvg-git@gmane.org; Mon, 11 Dec
 2006 08:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762638AbWLKHfI convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006 02:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762637AbWLKHfH
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 02:35:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60886 "EHLO
 sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762638AbWLKHfG (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 02:35:06 -0500
Received: from sous-sol.org (localhost.localdomain [127.0.0.1]) by
 sous-sol.org (8.13.8/8.13.7) with ESMTP id kBB7dWjN012746; Sun, 10 Dec 2006
 23:39:32 -0800
Received: (from chrisw@localhost) by sous-sol.org (8.13.8/8.13.7/Submit) id
 kBB7dWgj012745; Sun, 10 Dec 2006 23:39:32 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

No need to install manpages as executable.  Noticed by Ville Skytt=E4.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Applies cleanly to maint and master.

 Documentation/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c00f5f6..d68bc4a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -56,8 +56,8 @@ man7: $(DOC_MAN7)
=20
 install: man
 	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir) $(DESTDIR)$(man7dir)
-	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1dir)
-	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7dir)
+	$(INSTALL) -m644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
+	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
=20
=20
