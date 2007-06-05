From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: [PATCH] New selection indication and softer colors
Date: Tue,  5 Jun 2007 23:50:02 +0200
Message-ID: <11810802023668-git-send-email-mmelchior@xs4all.nl>
Cc: git@vger.kernel.org, Matthijs Melchior <mmelchior@xs4all.nl>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 23:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvgux-0001Nw-7K
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 23:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762003AbXFEVuK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 17:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761890AbXFEVuK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 17:50:10 -0400
Received: from zwaan.xs4all.nl ([213.84.190.116]:14588 "EHLO zwaan.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762003AbXFEVuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 17:50:09 -0400
Received: from kayak.lan ([10.0.0.130]) by zwaan.xs4all.nl
	 with esmtp (ident Debian-exim using rfc1413) id m1Hvgug-000BBvC
	(Debian Smail-3.2 1996-Jul-4 #2); Tue, 5 Jun 2007 23:50:02 +0200 (CEST)
Received: from matthijs by kayak.lan with local (Exim 4.63)
	(envelope-from <mmelchior@xs4all.nl>)
	id 1Hvgug-0006F0-8T; Tue, 05 Jun 2007 23:50:02 +0200
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49230>

The default font was already bold, so marking the selected file with bold
font did not work.  Change that to lightgray background.
Also, the header colors are now softer, giving better readability.

Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
---

This gives better colors on my Debian Gnome desktop.

I hope you like it too.

 git-gui.sh |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d4ad73c..e33ee03 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1764,7 +1764,7 @@ pack .vpane -anchor n -side top -fill both -expand 1
 #
 frame .vpane.files.index -height 100 -width 200
 label .vpane.files.index.title -text {Staged Changes (Will Be Committed)} \
-	-background green
+	-background lightgreen
 text $ui_index -background white -borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -1784,7 +1784,7 @@ pack $ui_index -side left -fill both -expand 1
 #
 frame .vpane.files.workdir -height 100 -width 200
 label .vpane.files.workdir.title -text {Unstaged Changes (Will Not Be Committed)} \
-	-background red
+	-background lightsalmon
 text $ui_workdir -background white -borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -1801,10 +1801,8 @@ pack $ui_workdir -side left -fill both -expand 1
 .vpane.files add .vpane.files.workdir -sticky nsew
 
 foreach i [list $ui_index $ui_workdir] {
-	$i tag conf in_diff -font font_uibold
-	$i tag conf in_sel \
-		-background [$i cget -foreground] \
-		-foreground [$i cget -background]
+	$i tag conf in_diff -background lightgray
+	$i tag conf in_sel  -background lightgray
 }
 unset i
 
@@ -1962,18 +1960,18 @@ proc trace_current_diff_path {varname args} {
 }
 trace add variable current_diff_path write trace_current_diff_path
 
-frame .vpane.lower.diff.header -background orange
+frame .vpane.lower.diff.header -background gold
 label .vpane.lower.diff.header.status \
-	-background orange \
+	-background gold \
 	-width $max_status_desc \
 	-anchor w \
 	-justify left
 label .vpane.lower.diff.header.file \
-	-background orange \
+	-background gold \
 	-anchor w \
 	-justify left
 label .vpane.lower.diff.header.path \
-	-background orange \
+	-background gold \
 	-anchor w \
 	-justify left
 pack .vpane.lower.diff.header.status -side left
-- 
1.5.2.1
