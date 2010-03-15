From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH resend 2] Revert "git-gui (Win): make starting via "Git GUI Here" on .git/ possible"
Date: Tue, 16 Mar 2010 00:27:45 +0100
Message-ID: <1268695665-9282-1-git-send-email-markus.heidelberg@web.de>
References: <1268695225-8915-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:26:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJgJ-0006Ga-Kr
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937129Ab0COX0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 19:26:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:38793 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564Ab0COX0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:26:37 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id F3207154CE594;
	Tue, 16 Mar 2010 00:26:36 +0100 (CET)
Received: from [91.19.1.188] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NrJgC-0004qE-00; Tue, 16 Mar 2010 00:26:36 +0100
X-Mailer: git-send-email 1.7.0.2.201.gbb6c1
In-Reply-To: <1268695225-8915-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19803YCJo/gakd5lG2OemRZRyE+SIJLkcyZ3hzl
	YG74Uerg1LQlRi/qB18MQ/Rbv9cgeKWemlJxGVa5jmSqdOv20d
	gJbgqQ14yLqnGVXTjYIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142276>

This reverts commit b01d4326040ec6b9d98baba32091c9458fc809d4.

This workaround for the Windows Explorer is not necessary anymore,
because git-gui has learnt to deal with the .git directory in commit
87cd09f4 (git-gui: work from the .git dir, 2010-01-23).

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Resend with Signoff.

 windows/git-gui.sh |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/windows/git-gui.sh b/windows/git-gui.sh
index 66bbb2f..53c3a94 100644
--- a/windows/git-gui.sh
+++ b/windows/git-gui.sh
@@ -3,12 +3,7 @@
 exec wish "$0" -- "$@"
 
 if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
-	set workdir [lindex $argv 1]
-	cd $workdir
-	if {[lindex [file split $workdir] end] eq {.git}} {
-		# Workaround for Explorer right click "Git GUI Here" on .git/
-		cd ..
-	}
+	cd [lindex $argv 1]
 	set argv [lrange $argv 2 end]
 	incr argc -2
 }
-- 
1.7.0.2.201.gbb6c1
