From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Move "-include config.mak" to end of configuration section
Date: Thu, 01 Dec 2005 01:23:33 +0200
Message-ID: <20051201012333.44bd81f2.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 01 00:25:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhbIa-0002m7-UG
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 00:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVK3XXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 18:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVK3XXh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 18:23:37 -0500
Received: from marski.suomi.net ([212.50.131.142]:10442 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S1751215AbVK3XXh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 18:23:37 -0500
Received: from spartak.suomi.net (spartak.suomi.net [212.50.140.227])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IQS00I0TJNCKN40@marski.suomi.net> for git@vger.kernel.org;
 Thu, 01 Dec 2005 01:23:36 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IQS004WCJSUAV50@mailstore.suomi.net>; Thu,
 01 Dec 2005 01:26:54 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam2.suomi.net (Postfix) with SMTP id 9021711B531; Thu,
 01 Dec 2005 01:23:33 +0200 (EET)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.7; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.022,	required 5,
 autolearn=not spam, AWL 0.58, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13030>


This makes it possible to define WITH_SEND_EMAIL etc. in config.mak.

---

 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

fe5fece83b2ab0d67a4277d851faf50ad944cff4
diff --git a/Makefile b/Makefile
index 984d167..c44f5da 100644
--- a/Makefile
+++ b/Makefile
@@ -75,7 +75,7 @@ RPMBUILD = rpmbuild
 # explicitly what architecture to check for. Fix this up for yours..
 SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 
-
+-include config.mak
 
 ### --- END CONFIGURATION SECTION ---
 
@@ -254,8 +254,6 @@ ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
 
--include config.mak
-
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not always want -R.
-- 
0.99.9.GIT
