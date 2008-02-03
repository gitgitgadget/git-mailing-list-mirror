From: Tommy Thorn <tommy-git@thorn.ws>
Subject: [PATCH 1/3] git-p4: Fix an obvious typo
Date: Sun,  3 Feb 2008 01:21:04 -0800
Message-ID: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
Cc: Tommy Thorn <tommy-git@thorn.ws>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 10:51:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLbV7-0007Be-2v
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 10:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761619AbYBCJu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 04:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761525AbYBCJu2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 04:50:28 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:44233 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761163AbYBCJu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 04:50:26 -0500
X-Greylist: delayed 1757 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2008 04:50:26 EST
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=localhost.localdomain)
	by server204.webhostingpad.com with esmtpa (Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JLb2B-0006wh-Iu; Sun, 03 Feb 2008 03:21:07 -0600
X-Mailer: git-send-email 1.5.4.rc5.17.g22b645
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72341>

The regexp "$," can't match anything. Clearly not intended.

This was introduced in ce6f33c8 which is quite a while ago.

Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c80a6da..553e237 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1670,7 +1670,7 @@ class P4Clone(P4Sync):
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-        depotDir = re.sub(r"\.\.\.$,", "", depotDir)
+        depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
         return os.path.split(depotDir)[1]
 
-- 
1.5.4.rc5.17.g22b645
