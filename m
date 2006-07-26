From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] git-instaweb: respect bindir from Makefile
Date: Wed, 26 Jul 2006 16:32:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261632420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:33:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kRU-0006AL-VD
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWGZOcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWGZOcx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:32:53 -0400
Received: from mail.gmx.de ([213.165.64.21]:7603 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751639AbWGZOcx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:32:53 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:32:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 26 Jul 2006 16:32:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24213>


Not everybody installs git to /usr/bin/git.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index baed711..f3726d4 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,7 @@ git-instaweb: git-instaweb.sh gitweb/git
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    $@.sh > $@+
+	    $@.sh | sed "s|/usr/bin/git|$(bindir)/git|" > $@+
 	chmod +x $@+
 	mv $@+ $@
 
-- 
1.4.2.rc2.g6a4e
