From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH] gitk: Allow toggling of checkboxes by clicking on the label
Date: Thu, 08 May 2008 00:43:39 +0200
Message-ID: <4822309B.9010303@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 00:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtsNK-0005qL-1j
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654AbYEGWnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbYEGWnp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:43:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:45748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761931AbYEGWnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:43:42 -0400
Received: (qmail invoked by alias); 07 May 2008 22:43:40 -0000
Received: from 169-19.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.19.169]
  by mail.gmx.net (mp053) with SMTP; 08 May 2008 00:43:40 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18PX2dgKxYPf6Y/YJlHGysF11MnKsLKKRlKp2l3N0
	jrSu58kiDx7eNR
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81489>


Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
I hope this makes any sense, since I do not know any tcl/tk at all.  I
think being able to click on the label of checkboxes is good manner,
since otherwise you have to click into a fairly small area.  However,
this patch unfortunately also reduces the size of the checkbox itself,
proably because it adapts itself to the small optionfont.  I don't know
how to fix this other than increasing the size of optionfont, so I'll
let someone else do this, if this is desired.

 gitk-git/gitk |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a4d9c4..ef8dcc0 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8015,14 +8015,14 @@ proc doprefs {} {
     spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
     grid x $top.maxpctl $top.maxpct -sticky w
     frame $top.showlocal
-    label $top.showlocal.l -text [mc "Show local changes"] -font optionfont
-    checkbutton $top.showlocal.b -variable showlocalchanges
-    pack $top.showlocal.b $top.showlocal.l -side left
+    checkbutton $top.showlocal.b -variable showlocalchanges \
+	-text [mc "Show local changes"] -font optionfont
+    pack $top.showlocal.b -side left
     grid x $top.showlocal -sticky w
     frame $top.autoselect
-    label $top.autoselect.l -text [mc "Auto-select SHA1"] -font optionfont
-    checkbutton $top.autoselect.b -variable autoselect
-    pack $top.autoselect.b $top.autoselect.l -side left
+    checkbutton $top.autoselect.b -variable autoselect \
+	-text [mc "Auto-select SHA1"] -font optionfont
+    pack $top.autoselect.b -side left
     grid x $top.autoselect -sticky w
 
     label $top.ddisp -text [mc "Diff display options"]
@@ -8031,14 +8031,14 @@ proc doprefs {} {
     spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $top.tabstopl $top.tabstop -sticky w
     frame $top.ntag
-    label $top.ntag.l -text [mc "Display nearby tags"] -font optionfont
-    checkbutton $top.ntag.b -variable showneartags
-    pack $top.ntag.b $top.ntag.l -side left
+    checkbutton $top.ntag.b -variable showneartags \
+	-text [mc "Display nearby tags"] -font optionfont
+    pack $top.ntag.b -side left
     grid x $top.ntag -sticky w
     frame $top.ldiff
-    label $top.ldiff.l -text [mc "Limit diffs to listed paths"] -font optionfont
-    checkbutton $top.ldiff.b -variable limitdiffs
-    pack $top.ldiff.b $top.ldiff.l -side left
+    checkbutton $top.ldiff.b -variable limitdiffs \
+	-text [mc "Limit diffs to listed paths"] -font optionfont
+    pack $top.ldiff.b -side left
     grid x $top.ldiff -sticky w
 
     label $top.cdisp -text [mc "Colors: press to choose"]
-- 
1.5.5.1
