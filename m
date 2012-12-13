From: "Jesper L. Nielsen" <lyager@gmail.com>
Subject: [PATCH] For git-subtree, when installing docs (make install-doc), create man1 folder first.
Date: Thu, 13 Dec 2012 21:09:36 +0100
Message-ID: <1355429376-4192-1-git-send-email-lyager@gmail.com>
Cc: "Jesper L. Nielsen" <lyager@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 13 21:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjFZx-0001Hi-O1
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 21:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab2LMUkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 15:40:05 -0500
Received: from majestix.2m.dk ([194.239.1.200]:47140 "EHLO majestix.2m.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426Ab2LMUkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 15:40:04 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2012 15:40:04 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by majestix.2m.dk (Postfix) with ESMTP id 1D32EC10064;
	Thu, 13 Dec 2012 21:33:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.2m.dk
Received: from majestix.2m.dk ([127.0.0.1])
	by localhost (majestix.2m.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DSnqCDw4o80; Thu, 13 Dec 2012 21:33:52 +0100 (CET)
Received: from jln-build.dev.2m.dk (unknown [194.239.1.65])
	by majestix.2m.dk (Postfix) with ESMTP id 09715C1005F;
	Thu, 13 Dec 2012 21:33:52 +0100 (CET)
Received: by jln-build.dev.2m.dk (Postfix, from userid 1001)
	id DF38E29EE57; Thu, 13 Dec 2012 21:09:38 +0100 (CET)
X-Mailer: git-send-email 1.8.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211471>

From: "Jesper L. Nielsen" <lyager@gmail.com>

Hi..

I installed Git subtree and discovered that the if the man1dir doesn't exist the man-page for Git Subtree is just called man1.

So, small patch to create the folder first in the Makefile. Hope everything is right with the patch and submitting of the patch.

Best Regards
Jesper

Signed-off-by: Jesper L. Nielsen <lyager@gmail.com>
---
 contrib/subtree/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 05cdd5c..a341cf4 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -35,6 +35,7 @@ install: $(GIT_SUBTREE)
 install-doc: install-man
 
 install-man: $(GIT_SUBTREE_DOC)
+	mkdir -p $(man1dir)
 	$(INSTALL) -m 644 $^ $(man1dir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
-- 
1.8.0.2
