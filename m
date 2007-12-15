From: Steffen Prohaska <prohaska@zib.de>
Subject: [RFC 4/4] gitk: Use adddiffline to nicely format diff-diff
Date: Sat, 15 Dec 2007 17:51:45 +0100
Message-ID: <11977375052395-git-send-email-prohaska@zib.de>
References: <1197737505128-git-send-email-prohaska@zib.de>
 <1197737505599-git-send-email-prohaska@zib.de>
 <11977375051617-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 17:52:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aFr-00010h-KU
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 17:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbXLOQv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 11:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbXLOQvx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 11:51:53 -0500
Received: from mailer.zib.de ([130.73.108.11]:44317 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329AbXLOQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 11:51:48 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBFGpk3J006057
	for <git@vger.kernel.org>; Sat, 15 Dec 2007 17:51:46 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBFGpj9F029051;
	Sat, 15 Dec 2007 17:51:45 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11977375051617-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68397>


---
 gitk-git/gitk |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3c4ec03..31b2b5f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6059,8 +6059,9 @@ proc doseldiffdiff {oldid newid} {
 
     set diff [exec git diff-diff $oldid $newid]
     $ctext conf -state normal
-    $ctext insert end "\n"
-    $ctext insert end $diff
+    foreach line [split $diff "\n"] {
+	adddiffline $line [list $oldid $newid]
+    }
     $ctext conf -state disabled
 }
 
-- 
1.5.4.rc0.37.geff3a-dirty
