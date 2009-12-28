From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 1/5] gitk: Remove forced use of sans-serif font
Date: Mon, 28 Dec 2009 20:03:59 +0000
Message-ID: <1262030643-12952-1-git-send-email-mark@pogo.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 21:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMFK-0006Za-IC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbZL1UbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbZL1UbH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:31:07 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58971 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751571AbZL1UbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:31:05 -0500
Received: from host86-131-13-173.range86-131.btcentralplus.com ([86.131.13.173] helo=vega)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NPLp3-0003Ep-4Q; Mon, 28 Dec 2009 20:04:09 +0000
Received: from mark by vega with local (Exim 4.69)
	(envelope-from <mark@vega>)
	id 1NPLox-0003NU-Ow; Mon, 28 Dec 2009 20:04:03 +0000
X-Mailer: git-send-email 1.6.6
X-SA-Exim-Connect-IP: 86.131.13.173
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135757>

The X resources set using uifont cover this case.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk-git/gitk |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 364c7a8..c58fd58 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10513,7 +10513,6 @@ proc mkfontdisp {font top which} {
     set fontpref($font) [set $font]
     ${NS}::button $top.${font}but -text $which \
 	-command [list choosefont $font $which]
-    if {!$use_ttk} {$top.${font}but configure  -font optionfont}
     ${NS}::label $top.$font -relief flat -font $font \
 	-text $fontattr($font,family) -justify left
     grid x $top.${font}but $top.$font -sticky w
@@ -10776,15 +10775,6 @@ proc doprefs {} {
     mkfontdisp textfont $top [mc "Diff display font"]
     mkfontdisp uifont $top [mc "User interface font"]
 
-    if {!$use_ttk} {
-	foreach w {maxpctl maxwidthl showlocal autoselect tabstopl ntag
-	    ldiff lattr extdifff.l extdifff.b bgbut fgbut
-	    diffoldbut diffnewbut hunksepbut markbgbut selbgbut
-	    want_ttk ttk_note} {
-	    $top.$w configure -font optionfont
-	}
-    }
-
     ${NS}::frame $top.buts
     ${NS}::button $top.buts.ok -text [mc "OK"] -command prefsok -default active
     ${NS}::button $top.buts.can -text [mc "Cancel"] -command prefscan -default normal
@@ -11396,8 +11386,6 @@ namespace import ::msgcat::mc
 
 catch {source ~/.gitk}
 
-font create optionfont -family sans-serif -size -12
-
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
 eval font create mainfontbold [fontflags mainfont 1]
-- 
1.6.6
