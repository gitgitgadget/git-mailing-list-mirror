From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Update fontsize in patch / tree list
Date: Sun, 20 May 2007 11:45:49 -0400
Message-ID: <11796759503065-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: paulus@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 17:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpnbe-0001Pl-MB
	for gcvg-git@gmane.org; Sun, 20 May 2007 17:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbXETPpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756965AbXETPpz
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 11:45:55 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:55486 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbXETPpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 11:45:54 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.225])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JIC00IKLJSFQTAD@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 20 May 2007 10:45:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.rc3.95.gb3c7e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47845>

When adjusting fontsize (using ctrl+/-), all panes except the lower right
were updated. This fixes that.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 530f8e1..4a15d7b 100755
--- a/gitk
+++ b/gitk
@@ -4695,13 +4695,14 @@ proc redisplay {} {
 }
 
 proc incrfont {inc} {
-    global mainfont textfont ctext canv phase
+    global mainfont textfont ctext canv phase cflist
     global stopped entries
     unmarkmatches
     set mainfont [lreplace $mainfont 1 1 [expr {[lindex $mainfont 1] + $inc}]]
     set textfont [lreplace $textfont 1 1 [expr {[lindex $textfont 1] + $inc}]]
     setcoords
     $ctext conf -font $textfont
+    $cflist conf -font $textfont
     $ctext tag conf filesep -font [concat $textfont bold]
     foreach e $entries {
 	$e conf -font $mainfont
-- 
1.5.2.rc3.95.gb3c7e
