From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 4/5] gitk: Disable option when themed widgets are not available
Date: Mon, 28 Dec 2009 20:04:02 +0000
Message-ID: <1262030643-12952-4-git-send-email-mark@pogo.org.uk>
References: <1262030643-12952-1-git-send-email-mark@pogo.org.uk>
 <1262030643-12952-2-git-send-email-mark@pogo.org.uk>
 <1262030643-12952-3-git-send-email-mark@pogo.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 21:31:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMFL-0006Za-54
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbZL1UbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZL1UbL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:31:11 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58966 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751766AbZL1UbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:31:07 -0500
Received: from host86-131-13-173.range86-131.btcentralplus.com ([86.131.13.173] helo=vega)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NPLp3-0002ha-N8; Mon, 28 Dec 2009 20:04:09 +0000
Received: from mark by vega with local (Exim 4.69)
	(envelope-from <mark@vega>)
	id 1NPLoy-0003Nc-Iu; Mon, 28 Dec 2009 20:04:04 +0000
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262030643-12952-3-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 86.131.13.173
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135758>

Disable the widget instead of using the label to indicate that themed
widgets are not available.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk-git/gitk |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5cbc885..5008753 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10721,14 +10721,14 @@ proc doprefs {} {
 
     ${NS}::label $top.lgen -text [mc "General options"]
     grid $top.lgen - -sticky w -pady 10
-    ${NS}::checkbutton $top.want_ttk -variable want_ttk \
-	-text [mc "Use themed widgets"]
     if {$have_ttk} {
-	${NS}::label $top.ttk_note -text [mc "(change requires restart)"]
+	${NS}::checkbutton $top.want_ttk -variable want_ttk \
+	    -text [mc "Use themed widgets (change requires restart)"]
     } else {
-	${NS}::label $top.ttk_note -text [mc "(currently unavailable)"]
+	${NS}::checkbutton $top.want_ttk \
+	    -text [mc "Use themed widgets"] -state disabled
     }
-    grid x $top.want_ttk $top.ttk_note -sticky w
+    grid x $top.want_ttk - -sticky w
 
     ${NS}::label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
-- 
1.6.6
