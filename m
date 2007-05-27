From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Note that CVS_SERVER can also be specified as method variable
Date: Sun, 27 May 2007 14:33:07 +0200
Message-ID: <1180269200838-git-send-email-frank@lichtenheld.de>
References: <1180269190126-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 14:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsICC-000432-VK
	for gcvg-git@gmane.org; Sun, 27 May 2007 14:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbXE0Mtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 08:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXE0Mtn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 08:49:43 -0400
Received: from v32413.1blu.de ([88.84.155.73]:41066 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXE0Mtn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 08:49:43 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 May 2007 08:49:42 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HsHwK-0004dg-Q6; Sun, 27 May 2007 14:33:40 +0200
Received: from p3ee3d801.dip.t-dialin.net ([62.227.216.1] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HsHwK-0007a0-1T; Sun, 27 May 2007 14:33:40 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HsHwA-0006Lr-Fu; Sun, 27 May 2007 14:33:30 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <1180269190126-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48538>

Reasonably new versions of the cvs CLI client allow one to
specifiy CVS_SERVER as a method variable directly in
CVSROOT. This is way more convinient than using an
environment variable since it gets saved in CVS/Root.

Since I only discovered this by accident I guess there
might be others out there that learnt CVS on the 1.11
series (or even earlier) and profit from such a note
about cvs improvements in the last couple years.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 9f0d990..ca7579d 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -57,7 +57,17 @@ looks like
 ------
 No special setup is needed for SSH access, other than having GIT tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
-env variable, you can rename git-cvsserver to cvs.
+environment variable, you can rename git-cvsserver to cvs.
+
+Note: Newer cvs versions (>= 1.12.11) also support specifying
+CVS_SERVER directly in CVSROOT like
+
+------
+cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
+------
+This has the advantage that it will be saved in your 'CVS/Root' files and
+you don't need to worry about always setting the correct environment
+variable.
 --
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
-- 
1.5.2-rc3.GIT
