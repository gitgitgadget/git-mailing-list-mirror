From: Lars Noschinski <lars.noschinski@rwth-aachen.de>
Subject: [PATCH] git-cvsserver: fix call to nonexistant cleanupWorkDir()
Date: Wed, 16 Jul 2008 13:35:46 +0200
Message-ID: <20080716113546.GA23390@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 13:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ5Pf-0006dh-C9
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 13:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYGPLmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 07:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYGPLmQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 07:42:16 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:44711 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYGPLmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 07:42:15 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2008 07:42:15 EDT
Received: from [134.61.46.235] (helo=vertikal.home.noschinski.de)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars.noschinski@rwth-aachen.de>)
	id 1KJ5IR-0008VZ-U3; Wed, 16 Jul 2008 13:35:47 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars.noschinski@rwth-aachen.de>)
	id 1KJ5IQ-0006EN-GR; Wed, 16 Jul 2008 13:35:46 +0200
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88670>

git-cvsserver.perl contained a single call to a nonexistant function
cleanupWorkDir(). This was obviously a typo for cleanupWorkTree().

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
  git-cvsserver.perl |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 920bbe1..b00d1c2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1884,7 +1884,7 @@ sub req_annotate
      }
  
      # done; get out of the tempdir
-    cleanupWorkDir();
+    cleanupWorkTree();
  
      print "ok\n";
  
-- 
1.5.5.2
