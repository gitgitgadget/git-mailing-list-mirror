From: "Guillermo S. Romero" <gsromero@infernal-iceberg.com>
Subject: [PATCH] gitk: Follow themed bgcolor in help dialogs
Date: Thu, 4 Feb 2016 03:32:19 +0100
Message-ID: <20160204023219.GA27647@fortress.battleship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 04:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRA9K-0001YG-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 04:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbcBDC76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 21:59:58 -0500
Received: from igloo.infernal-iceberg.com ([78.47.19.187]:41369 "EHLO
	igloo.infernal-iceberg.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757056AbcBDC75 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 21:59:57 -0500
X-Greylist: delayed 1656 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2016 21:59:57 EST
Received: from localhost ([127.0.0.1] helo=fortress.battleship)
	by igloo.infernal-iceberg.com with esmtp (Exim 4.72)
	(envelope-from <gsromero@infernal-iceberg.com>)
	id 1aR9iW-0003zW-5F; Thu, 04 Feb 2016 03:32:20 +0100
Received: from unnamed by fortress.battleship with local (Exim 4.86)
	(envelope-from <gsromero@infernal-iceberg.com>)
	id 1aR9iV-00082N-RC; Thu, 04 Feb 2016 03:32:19 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285393>

Make Help > About & Key bindings dialogs readable if theme
has changed font color to something incompatible with white.

Signed-off-by: Guillermo S. Romero <gsromero@infernal-iceberg.com>
---

Hi:

Found more places where themable colors makes things unreadable
because not everything adapted to the changed style.

GSR
 
PS: Not subscribed to git@vger, so remember to CC: me.
 

 gitk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 5f1255c..805a1c7 100755
--- a/gitk
+++ b/gitk
@@ -3021,7 +3021,7 @@ proc bindall {event action} {
 }
 
 proc about {} {
-    global uifont NS
+    global bgcolor NS
     set w .about
     if {[winfo exists $w]} {
 	raise $w
@@ -3036,7 +3036,7 @@ Gitk - a commit viewer for git
 Copyright \u00a9 2005-2014 Paul Mackerras
 
 Use and redistribute under the terms of the GNU General Public License"] \
-	    -justify center -aspect 400 -border 2 -bg white -relief groove
+	    -justify center -aspect 400 -border 2 -bg $bgcolor -relief groove
     pack $w.m -side top -fill x -padx 2 -pady 2
     ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -default active
     pack $w.ok -side bottom
@@ -3047,7 +3047,7 @@ Use and redistribute under the terms of the GNU General Public License"] \
 }
 
 proc keys {} {
-    global NS
+    global bgcolor NS
     set w .keys
     if {[winfo exists $w]} {
 	raise $w
@@ -3103,7 +3103,7 @@ proc keys {} {
 [mc "<%s-minus>	Decrease font size" $M1T]
 [mc "<F5>		Update"]
 " \
-	    -justify left -bg white -border 2 -relief groove
+	    -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -default active
     bind $w <Key-Escape> [list destroy $w]
-- 
2.7.0.rc3
