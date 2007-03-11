From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not output "GEN " when generating perl.mak
Date: Sun, 11 Mar 2007 14:19:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703111418280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 11 14:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQNxO-0006Ur-EC
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 14:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbXCKNTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 09:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXCKNTK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 09:19:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:54452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752197AbXCKNTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 09:19:09 -0400
Received: (qmail invoked by alias); 11 Mar 2007 13:19:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 11 Mar 2007 14:19:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/56Sl3ZoD5rdJq99ZAKH/kEz0iQq9obf98wY8wSr
	RwlEmCmeBLshMH
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41921>


This fixes the same issue as 8bef6204, which became an issue again
after 31d0399c.

Besides, it is not really helpful to print just "GEN " (_without_
"perl.mak").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 perl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 5ec0389..17d004e 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -33,7 +33,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	$(QUIET_GEN)'$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
+	'$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
 endif
 
 # this is just added comfort for calling make directly in perl dir
-- 
1.5.0.3.2649.g9f8ff
