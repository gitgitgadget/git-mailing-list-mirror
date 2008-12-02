From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] gitk: Use check-buttons' -text property instead of separate labels
Date: Tue, 2 Dec 2008 21:42:16 +0100
Message-ID: <200812022142.16095.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7cd7-0006nF-MY
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbYLBVQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbYLBVQc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:16:32 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:33304 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbYLBVQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:16:31 -0500
X-Greylist: delayed 2052 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2008 16:16:31 EST
Received: from bsmtp.bon.at (mta-out-vip.lix.bon.at [172.18.12.14])
	by lbmfmo03.bon.at (Postfix) with ESMTP id D92EACE0D5
	for <git@vger.kernel.org>; Tue,  2 Dec 2008 21:43:49 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8320B2C400E;
	Tue,  2 Dec 2008 21:42:16 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 33BE828071;
	Tue,  2 Dec 2008 21:42:16 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102175>

Previously the check-buttons' labels in the Preferences were separate
widgets. This had the disadvantage that in order to toggle the check-button
with the mouse the check-box had to be clicked. With this change the
check-box can also be toggled by clicking the label.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/gitk b/gitk
index 64a873d..ee1941c 100755
--- a/gitk
+++ b/gitk
@@ -10079,15 +10079,11 @@ proc doprefs {} {
 	-font optionfont
     spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
     grid x $top.maxpctl $top.maxpct -sticky w
-    frame $top.showlocal
-    label $top.showlocal.l -text [mc "Show local changes"] -font optionfont
-    checkbutton $top.showlocal.b -variable showlocalchanges
-    pack $top.showlocal.b $top.showlocal.l -side left
+    checkbutton $top.showlocal -text [mc "Show local changes"] \
+	-font optionfont -variable showlocalchanges
     grid x $top.showlocal -sticky w
-    frame $top.autoselect
-    label $top.autoselect.l -text [mc "Auto-select SHA1"] -font optionfont
-    checkbutton $top.autoselect.b -variable autoselect
-    pack $top.autoselect.b $top.autoselect.l -side left
+    checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
+	-font optionfont -variable autoselect
     grid x $top.autoselect -sticky w
 
     label $top.ddisp -text [mc "Diff display options"]
@@ -10095,20 +10091,14 @@ proc doprefs {} {
     label $top.tabstopl -text [mc "Tab spacing"] -font optionfont
     spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $top.tabstopl $top.tabstop -sticky w
-    frame $top.ntag
-    label $top.ntag.l -text [mc "Display nearby tags"] -font optionfont
-    checkbutton $top.ntag.b -variable showneartags
-    pack $top.ntag.b $top.ntag.l -side left
+    checkbutton $top.ntag -text [mc "Display nearby tags"] \
+	-font optionfont -variable showneartags
     grid x $top.ntag -sticky w
-    frame $top.ldiff
-    label $top.ldiff.l -text [mc "Limit diffs to listed paths"] -font optionfont
-    checkbutton $top.ldiff.b -variable limitdiffs
-    pack $top.ldiff.b $top.ldiff.l -side left
+    checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
+	-font optionfont -variable limitdiffs
     grid x $top.ldiff -sticky w
-    frame $top.lattr
-    label $top.lattr.l -text [mc "Support per-file encodings"] -font optionfont
-    checkbutton $top.lattr.b -variable perfile_attrs
-    pack $top.lattr.b $top.lattr.l -side left
+    checkbutton $top.lattr -text [mc "Support per-file encodings"] \
+	-font optionfont -variable perfile_attrs
     grid x $top.lattr -sticky w
 
     entry $top.extdifft -textvariable extdifftool
-- 
1.6.0.4.763.g42102
