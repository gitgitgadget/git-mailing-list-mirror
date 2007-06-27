From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - bugfix - Update selection background colorbar in prefs
 dialog
Date: Tue, 26 Jun 2007 21:51:34 -0400
Message-ID: <11829090952211-git-send-email-mdl123@verizon.net>
References: <18048.36797.283166.952377@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Jun 27 03:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Mha-0006Gj-H9
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbXF0BwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757694AbXF0BwG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:52:06 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:54790 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304AbXF0BwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:52:04 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.74])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JK9000ZNUI9Z2D1@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 26 Jun 2007 20:51:46 -0500 (CDT)
In-reply-to: <18048.36797.283166.952377@cargo.ozlabs.ibm.com>
X-Mailer: git-send-email 1.5.2.2.282.g9826
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51001>

The callback function was incorrectly set to update the background
colorbar when updated the selection background. This did not affect the
colors chosen or their use, just their presentation in the preferences
dialog box.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 269f9b0..c06d327 100755
--- a/gitk
+++ b/gitk
@@ -7004,7 +7004,7 @@ proc doprefs {} {
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.selbgsep -padx 40 -relief sunk -background $selectbgcolor
     button $top.selbgbut -text "Select bg" -font optionfont \
-	-command [list choosecolor selectbgcolor 0 $top.bg background setselbg]
+	-command [list choosecolor selectbgcolor 0 $top.selbgsep background setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
 
     frame $top.buts
-- 
1.5.2.2.282.g9826
