From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 5/7] git push: Document that "nothing" is the future push default
Date: Mon,  9 Mar 2009 23:35:49 +0100
Message-ID: <1236638151-6465-6-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgonn-0003QR-9K
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbZCIXUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbZCIXUx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:20:53 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36540 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZCIXUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:20:53 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo5H-0002Lo-Bd
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:34 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112760>

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/RelNotes-1.6.3.txt |    7 +++++++
 builtin-push.c                   |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes-1.6.3.txt
index ee1fddb..87de02a 100644
--- a/Documentation/RelNotes-1.6.3.txt
+++ b/Documentation/RelNotes-1.6.3.txt
@@ -22,6 +22,13 @@ branch pointed at by its HEAD, gets a large warning.  You can choose what
 should happen upon such a push by setting the configuration variable
 receive.denyDeleteCurrent in the receiving repository.
 
+In a future release, the default of "git push" without further
+arguments will be to push nothing. Currently, it will push all
+matching refspecs to the current remote.  A configuration variable
+push.default has been introduced to select the default behaviour.  To
+ease the transition, a big warning is issued if this is not configured
+and a git push without arguments is attempted.
+
 
 Updates since v1.6.2
 --------------------
diff --git a/builtin-push.c b/builtin-push.c
index b9fe206..7ef499f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -79,11 +79,11 @@ static const char *warn_unconfigured_push_msg[] = {
 	"has not configured any push refspecs. The default action in this",
 	"case has been to push all matching refspecs, that is, all branches",
 	"that exist both locally and remotely will be updated.",
-	"This default may change in the future.",
+	"This default will change in the future.",
 	"",
 	"You can specify what action you want to take in this case, and",
 	"avoid seeing this message again, by configuring 'push.default' to:",
-	"  'nothing'  : Do not push anythig",
+	"  'nothing'  : Do not push anythig (the future default)",
 	"  'matching' : Push all matching branches (the current default)",
 	"  'current'  : Push the current branch to whatever it is tracking",
 	""
-- 
1.6.2.105.g6ff1f.dirty
