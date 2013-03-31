From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] bash: teach __git_ps1 about REVERT_HEAD
Date: Sun, 31 Mar 2013 01:30:48 +0100
Message-ID: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
Cc: gitster@pobox.com, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 01:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM6Ky-0007aC-MK
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 01:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab3CaAk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 20:40:56 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:34509 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab3CaAk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 20:40:56 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2013 20:40:55 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id D722282922;
	Sun, 31 Mar 2013 01:30:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FntJLpM+XAAB; Sun, 31 Mar 2013 01:30:58 +0100 (CET)
Received: from Robin-Rosenbergs-MacBook-Pro.local.com (unknown [10.9.0.2])
	by zimbra.dewire.com (Postfix) with ESMTP id 6381482920;
	Sun, 31 Mar 2013 01:30:58 +0100 (CET)
X-Mailer: git-send-email 1.8.1.337.gf3f86a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219599>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-prompt.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 341422a..756a951 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -282,6 +282,8 @@ __git_ps1 ()
 				r="|MERGING"
 			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
 				r="|CHERRY-PICKING"
+			elif [ -f "$g/REVERT_HEAD" ]; then
+				r="|REVERTING"
 			elif [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
-- 
1.8.1.337.gf3f86a8
