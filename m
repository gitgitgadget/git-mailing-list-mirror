From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/5] Support Irix
Date: Fri, 17 Feb 2006 15:23:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602171523250.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Feb 17 15:24:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA6WP-0000OP-QT
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWBQOXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 09:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWBQOXn
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 09:23:43 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25494 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751439AbWBQOXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 09:23:42 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9ED7B14668C; Fri, 17 Feb 2006 15:23:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 91DBC86D2;
	Fri, 17 Feb 2006 15:23:41 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68D4014668C; Fri, 17 Feb 2006 15:23:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16348>


Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

83cb63120fb66c66d88f04c3d9c61e82b8f1837d
diff --git a/Makefile b/Makefile
index 6e00737..7e1990b 100644
--- a/Makefile
+++ b/Makefile
@@ -279,6 +279,16 @@ ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
+ifeq ($(uname_S),IRIX64)
+	NO_IPV6=YesPlease
+	NO_SETENV=YesPlease
+	NO_STRCASESTR=YesPlease
+	NO_SOCKADDR_STORAGE=YesPlease
+	SHELL_PATH=/usr/gnu/bin/bash
+	ALL_CFLAGS += -DPATH_MAX=1024
+	# for now, build 32-bit version
+	ALL_LDFLAGS += -L/usr/lib32
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
-- 
1.2.1.g09fe-dirty
