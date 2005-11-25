From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] cvsimport: Don't let local settings hinder cvs user-migration.
Date: Fri, 25 Nov 2005 02:37:09 +0100 (CET)
Message-ID: <20051125013709.EDBC25C7F8@nox.op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 25 02:38:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfSWc-0004yV-HG
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 02:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVKYBhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 20:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVKYBhN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 20:37:13 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43931 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161083AbVKYBhL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 20:37:11 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 766AC6BCBE
	for <git@vger.kernel.org>; Fri, 25 Nov 2005 02:37:10 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id EDBC25C7F8; Fri, 25 Nov 2005 02:37:09 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12726>


Avoid this by passing "--norc" to cvsps.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: c183291c9f13912f9111ee0ab2e24ac47f3147ed
11f061ae28cca5071bfd7a344808b84c399bdbbe
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index efe1934..08a890c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -502,7 +502,7 @@ unless($pid) {
 	if ($opt_P) {
 	    exec("cat", $opt_P);
 	} else {
-	    exec("cvsps",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
+	    exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
 	    die "Could not start cvsps: $!\n";
 	}
 }
---
0.99.9.GIT
