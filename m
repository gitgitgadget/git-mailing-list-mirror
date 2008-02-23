From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sat, 23 Feb 2008 11:37:59 +0000
Message-ID: <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 12:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSsht-0000BU-TR
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 12:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYBWLhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 06:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYBWLhm
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 06:37:42 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:51550 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752450AbYBWLhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 06:37:41 -0500
Received: (qmail 12855 invoked by uid 1000); 23 Feb 2008 11:37:59 -0000
Content-Disposition: inline
In-Reply-To: <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74815>

Saving the geometry can cause several inconveniences, e.g. when using a
temporary dual screen setup, or sharing ~/.gitk between multiple
systems.  Additionally it can be argued that window placement and sizing
are the tasks of the window manager.  So don't do that anymore.

This has been requested by martin f krafft and Josh Triplett through
 http://bugs.debian.org/442253
 http://bugs.debian.org/467121

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitk-git/gitk |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f1f21e9..8039d19 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1188,14 +1188,6 @@ proc savestuff {w} {
 	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
 
-	puts $f "set geometry(main) [wm geometry .]"
-	puts $f "set geometry(topwidth) [winfo width .tf]"
-	puts $f "set geometry(topheight) [winfo height .tf]"
-        puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
-        puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash coord 1]\""
-	puts $f "set geometry(botwidth) [winfo width .bleft]"
-	puts $f "set geometry(botheight) [winfo height .bleft]"
-
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-- 
1.5.4.2
