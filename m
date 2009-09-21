From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 2/8] git gui: teach delete dialog to open with a default remote
Date: Mon, 21 Sep 2009 15:06:49 +0200
Message-ID: <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicC-0002uk-FI
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbZIUNGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbZIUNGz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:06:55 -0400
Received: from darksea.de ([83.133.111.250]:35685 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755977AbZIUNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:54 -0400
Received: (qmail 28817 invoked from network); 21 Sep 2009 15:06:56 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:56 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128878>

This is useful if you want to open the delete dialog with a preselected
remote. We use this in the next patch from this series.
---
 git-gui/lib/remote_branch_delete.tcl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index 2416420..e0dbc25 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -22,7 +22,7 @@ field head_cache
 field full_cache
 field cached
 
-constructor dialog {} {
+constructor dialog {{initial_remote origin}} {
 	global all_remotes M1B
 
 	make_toplevel top w
@@ -52,8 +52,8 @@ constructor dialog {} {
 			-variable @urltype
 		eval tk_optionMenu $w.dest.remote_m @remote $all_remotes
 		grid $w.dest.remote_r $w.dest.remote_m -sticky w
-		if {[lsearch -sorted -exact $all_remotes origin] != -1} {
-			set remote origin
+		if {[lsearch -sorted -exact $all_remotes $initial_remote] != -1} {
+			set remote $initial_remote
 		} else {
 			set remote [lindex $all_remotes 0]
 		}
-- 
1.6.5.rc1.12.gc72fe
