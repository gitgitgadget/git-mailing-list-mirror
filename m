From: Peter Hofmann <git-dev@uninformativ.de>
Subject: [PATCH] gitk: Replaced "green" with "#00FF00".
Date: Thu, 27 Dec 2012 13:59:16 +0100
Message-ID: <20121227125916.GC7039@mobiltux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 14:29:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToDWo-0005XG-5x
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 14:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab2L0N3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 08:29:24 -0500
Received: from alice.uninformativ.de ([88.198.107.139]:51731 "EHLO
	alice.uninformativ.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2L0N3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 08:29:23 -0500
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2012 08:29:22 EST
Received: from [95.89.203.198] (helo=localhost)
	by alice.uninformativ.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <git-dev@uninformativ.de>)
	id 1ToD3M-0003yH-QF; Thu, 27 Dec 2012 13:59:16 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212199>

The definition of "green" has changed in Tk 8.6:

- http://wiki.tcl.tk/21276
- http://www.tcl.tk/cgi-bin/tct/tip/403

gitk looks pretty awkward with Tk 8.6. "green" is simply too dark now
because it has changed from "#00FF00" to "#008000".

One could also use "lime" instead of "#00FF00" but that would break
compatibility with older versions of Tk.

Signed-off-by: Peter Hofmann <git-dev@uninformativ.de>
---
 gitk-git/gitk | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..d7e922b 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2209,7 +2209,7 @@ proc makewindow {} {
 	set h [expr {[font metrics uifont -linespace] + 2}]
 	set progresscanv .tf.bar.progress
 	canvas $progresscanv -relief sunken -height $h -borderwidth 2
-	set progressitem [$progresscanv create rect -1 0 0 $h -fill green]
+	set progressitem [$progresscanv create rect -1 0 0 $h -fill "#00FF00"]
 	set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
 	set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
     }
@@ -2342,7 +2342,7 @@ proc makewindow {} {
     $ctext tag conf dresult -fore [lindex $diffcolors 1]
     $ctext tag conf m0 -fore red
     $ctext tag conf m1 -fore blue
-    $ctext tag conf m2 -fore green
+    $ctext tag conf m2 -fore "#00FF00"
     $ctext tag conf m3 -fore purple
     $ctext tag conf m4 -fore brown
     $ctext tag conf m5 -fore "#009090"
@@ -3226,7 +3226,7 @@ set rectmask {
        0x00, 0x00, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f,
        0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0x00, 0x00};
 }
-image create bitmap reficon-H -background black -foreground green \
+image create bitmap reficon-H -background black -foreground "#00FF00" \
     -data $rectdata -maskdata $rectmask
 image create bitmap reficon-o -background black -foreground "#ddddff" \
     -data $rectdata -maskdata $rectmask
@@ -5909,7 +5909,7 @@ proc drawcmittext {id row col} {
     if {$id eq $nullid} {
 	set ofill red
     } elseif {$id eq $nullid2} {
-	set ofill green
+	set ofill "#00FF00"
     } elseif {$id eq $mainheadid} {
 	set ofill yellow
     } else {
@@ -6377,7 +6377,7 @@ proc drawtags {id x xt y1} {
 	} else {
 	    # draw a head or other ref
 	    if {[incr nheads -1] >= 0} {
-		set col green
+		set col "#00FF00"
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
 		}
@@ -11617,7 +11617,7 @@ if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "meld"
 }
 
-set colors {green red blue magenta darkgrey brown orange}
+set colors {"#00FF00" red blue magenta darkgrey brown orange}
 if {[tk windowingsystem] eq "win32"} {
     set uicolor SystemButtonFace
     set bgcolor SystemWindow
-- 
1.8.0.2
