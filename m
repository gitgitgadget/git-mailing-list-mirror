From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Correct inetd.conf example in asciidoc documentation
Date: Sun, 27 May 2007 14:33:06 +0200
Message-ID: <1180269190852-git-send-email-frank@lichtenheld.de>
References: <1180269190126-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 14:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsICF-000432-2P
	for gcvg-git@gmane.org; Sun, 27 May 2007 14:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXE0Mtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 08:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbXE0Mtv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 08:49:51 -0400
Received: from v32413.1blu.de ([88.84.155.73]:41066 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbXE0Mtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 08:49:46 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 May 2007 08:49:42 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HsHwA-0004cs-Oj; Sun, 27 May 2007 14:33:30 +0200
Received: from p3ee3d801.dip.t-dialin.net ([62.227.216.1] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HsHwA-0007Zm-0K; Sun, 27 May 2007 14:33:30 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HsHw0-0006Ll-BW; Sun, 27 May 2007 14:33:20 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <1180269190126-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48536>

While the given example worked, it made us look rather
incompetent. Give the correct reason why one needs the
more complex syntax and change the example to reflect
that.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index d22844b..9f0d990 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -46,11 +46,13 @@ INSTALLATION
    cvspserver stream tcp nowait nobody git-cvsserver pserver
 
 ------
-Note: In some cases, you need to pass the 'pserver' argument twice for
-git-cvsserver to see it. So the line would look like
+Note: Some inetd servers let you specify the name of the executable
+independently of the value of argv[0] (i.e. the name the program assumes
+it was executed with). In this case the correct line in /etc/inetd.conf
+looks like
 
 ------
-   cvspserver stream tcp nowait nobody git-cvsserver pserver pserver
+   cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserver pserver
 
 ------
 No special setup is needed for SSH access, other than having GIT tools
-- 
1.5.2-rc3.GIT
