From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Clean up the SunOS Makefile rule
Date: Wed, 2 Nov 2005 20:27:31 +0100
Message-ID: <20051102192730.GA17706@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 02 20:43:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXORp-00057m-9N
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 20:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVKBTi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 14:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVKBTi5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 14:38:57 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:51629 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S965192AbVKBTi4
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 14:38:56 -0500
Received: (qmail 17726 invoked by uid 5842); 2 Nov 2005 19:27:31 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11031>

Don't set a non-standard CURLDIR as default, and fix an error
in Solaris 10 by setting NEEDS_LIBICONV.

---

I hope this is ok, since I was the one suggesting the
stupid non-standard /opt/sfw path in the first place.
Further more Solaris 10 seems to need NEEDS_LIBICONV.

I hope other people who know more about Solaris 
than me could point out, what will work on any 
Solaris system and not just the specific one I'm using.

Regards,

Peter
 
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: b774cd64105bda561bba3c528a7fea19b87755a1
5f5bb71e10f8f3e92df2475a456d73d5ee7ca55a
diff --git a/Makefile b/Makefile
index 357cb3e..cdd19c3 100644
--- a/Makefile
+++ b/Makefile
@@ -189,9 +189,9 @@ endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
+	NEEDS_LIBICONV = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
-	CURLDIR = /opt/sfw
 	INSTALL = ginstall
 	TAR = gtar
 	PLATFORM_DEFINES += -D__EXTENSIONS__
---
0.99.9.GIT
