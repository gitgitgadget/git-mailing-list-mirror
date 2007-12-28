From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitk: use user-configured background in view definition
	dialog
Date: Fri, 28 Dec 2007 14:51:56 +0000
Message-ID: <20071228145156.8106.qmail@6afea2d2003e0e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 15:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8GZC-0004Ep-Av
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 15:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXL1Ovm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 09:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbXL1Ovl
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 09:51:41 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:59167 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752242AbXL1Ovl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 09:51:41 -0500
Received: (qmail 8107 invoked by uid 1000); 28 Dec 2007 14:51:56 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69284>

Have the text fields in the view definition dialog (View->New view...)
use the background color as configured through the preferences, instead
of hard-coded 'white'.

This was suggested by Paul Wise through
 http://bugs.debian.org/457124

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitk |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 684e614..7d70c64 100755
--- a/gitk
+++ b/gitk
@@ -1881,7 +1881,7 @@ proc editview {} {
 
 proc vieweditor {top n title} {
     global newviewname newviewperm viewfiles
-    global uifont
+    global uifont bgcolor
 
     toplevel $top
     wm title $top $title
@@ -1895,12 +1895,12 @@ proc vieweditor {top n title} {
 	-text [mc "Commits to include (arguments to git rev-list):"]
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
-	-background white -font uifont
+	-background $bgcolor -font uifont
     grid $top.args - -sticky ew -padx 5
     message $top.l -aspect 1000 -font uifont \
 	-text [mc "Enter files and directories to include, one per line:"]
     grid $top.l - -sticky w
-    text $top.t -width 40 -height 10 -background white -font uifont
+    text $top.t -width 40 -height 10 -background $bgcolor -font uifont
     if {[info exists viewfiles($n)]} {
 	foreach f $viewfiles($n) {
 	    $top.t insert end $f
-- 
1.5.3.7
