From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 1/5] gitk: Remove forced use of sans-serif font
Date: Wed, 13 Jan 2010 20:40:18 +0000
Message-ID: <1263415222-5911-1-git-send-email-mark@pogo.org.uk>
References: <alpine.NEB.2.01.1001132030010.15349@jrf.vwaro.pbz>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVA1F-0003qp-EY
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab0AMUk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328Ab0AMUk0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:40:26 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58972 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755321Ab0AMUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:40:25 -0500
Received: from cpc1-acto2-0-0-cust60.4-2.cable.virginmedia.com ([82.28.218.61] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NVA0t-0001zQ-4N; Wed, 13 Jan 2010 20:40:23 +0000
Received: from mark by stax.localdomain with local (Exim 4.69)
	(envelope-from <mark@stax.localdomain>)
	id 1NVA0s-0001Xr-FN; Wed, 13 Jan 2010 20:40:22 +0000
X-Mailer: git-send-email 1.6.6.5.ge408
In-Reply-To: <alpine.NEB.2.01.1001132030010.15349@jrf.vwaro.pbz>
X-SA-Exim-Connect-IP: 82.28.218.61
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136880>

The X resources set using uifont cover this case.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/gitk b/gitk
index 48cfce3..0e430bd 100755
--- a/gitk
+++ b/gitk
@@ -10528,7 +10528,6 @@ proc mkfontdisp {font top which} {
     set fontpref($font) [set $font]
     ${NS}::button $top.${font}but -text $which \
 	-command [list choosefont $font $which]
-    if {!$use_ttk} {$top.${font}but configure  -font optionfont}
     ${NS}::label $top.$font -relief flat -font $font \
 	-text $fontattr($font,family) -justify left
     grid x $top.${font}but $top.$font -sticky w
@@ -10791,15 +10790,6 @@ proc doprefs {} {
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
@@ -11411,8 +11401,6 @@ namespace import ::msgcat::mc
 
 catch {source ~/.gitk}
 
-font create optionfont -family sans-serif -size -12
-
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
 eval font create mainfontbold [fontflags mainfont 1]
-- 
1.6.6.5.ge408
