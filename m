From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH] Put quotes around branch names to prevent special characters from being interpreted by the shell.
Date: Fri,  4 Jun 2010 11:53:20 -0400
Message-ID: <1275666800-31852-1-git-send-email-bmeyer@rim.com>
Cc: Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 18:00:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKZJS-0001JX-9X
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 18:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab0FDP75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 11:59:57 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:41101
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560Ab0FDP74 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 11:59:56 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 11:59:56 EDT
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id Rp4z1e0040bG4ec5DrtsMy; Fri, 04 Jun 2010 15:53:52 +0000
Received: from ben-laptop.rim.net ([71.192.50.29])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id Rrtr1e00H0dnthT3PrtsSh; Fri, 04 Jun 2010 15:53:52 +0000
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148425>

Perforce branch names with spaces (and other special characters) were causing issues.

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c1ea643..d42b865 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1228,7 +1228,7 @@ class P4Sync(Command):
         lostAndFoundBranches = set()
 
         for info in p4CmdList("branches"):
-            details = p4Cmd("branch -o %s" % info["branch"])
+            details = p4Cmd("branch -o \"%s\"" % info["branch"])
             viewIdx = 0
             while details.has_key("View%s" % viewIdx):
                 paths = details["View%s" % viewIdx].split(" ")
-- 
1.7.1
