From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Update fontsize in patch / tree list
Date: Mon, 25 Jun 2007 22:43:20 -0400
Message-ID: <11828258013248-git-send-email-mdl123@verizon.net>
References: <46807CEF.2010109@verizon.net>
 <1182825801300-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: gitster@pobox.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Jun 26 04:43:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I311v-0004Qr-8l
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 04:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbXFZCng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 22:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbXFZCng
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 22:43:36 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:38801 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbXFZCng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 22:43:36 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.74])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JK800GU928AOP81@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 25 Jun 2007 21:43:24 -0500 (CDT)
In-reply-to: <1182825801300-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.2.2.282.g9826
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50943>

When adjusting fontsize (using ctrl+/-), all panes except the lower right
were updated. This fixes that.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index cd9456e..62eefd9 100755
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
1.5.2.2.282.g9826
