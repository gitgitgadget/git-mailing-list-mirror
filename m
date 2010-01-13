From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 4/5] gitk: Disable option when themed widgets are not available
Date: Wed, 13 Jan 2010 20:40:21 +0000
Message-ID: <1263415222-5911-4-git-send-email-mark@pogo.org.uk>
References: <alpine.NEB.2.01.1001132030010.15349@jrf.vwaro.pbz>
 <1263415222-5911-1-git-send-email-mark@pogo.org.uk>
 <1263415222-5911-2-git-send-email-mark@pogo.org.uk>
 <1263415222-5911-3-git-send-email-mark@pogo.org.uk>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVA1C-0003qp-0g
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab0AMUk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321Ab0AMUk2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:40:28 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58973 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755315Ab0AMUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:40:25 -0500
Received: from cpc1-acto2-0-0-cust60.4-2.cable.virginmedia.com ([82.28.218.61] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NVA0t-00060d-Fz; Wed, 13 Jan 2010 20:40:23 +0000
Received: from mark by stax.localdomain with local (Exim 4.69)
	(envelope-from <mark@stax.localdomain>)
	id 1NVA0s-0001Xx-Ps; Wed, 13 Jan 2010 20:40:22 +0000
X-Mailer: git-send-email 1.6.6.5.ge408
In-Reply-To: <1263415222-5911-3-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 82.28.218.61
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136882>

Disable the widget instead of using the label to indicate that themed
widgets are not available.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 3cdc31e..54f4fb3 100755
--- a/gitk
+++ b/gitk
@@ -10736,14 +10736,14 @@ proc doprefs {} {
 
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
1.6.6.5.ge408
