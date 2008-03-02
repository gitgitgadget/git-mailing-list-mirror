From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: Don't blame when git-describe fails
Date: Sun,  2 Mar 2008 22:45:52 +0800
Message-ID: <1204469152-24227-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 15:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVpSQ-0003Sh-8o
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbYCBOpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYCBOpy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:45:54 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51061 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750695AbYCBOpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:45:53 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 11A95470AE; Sun,  2 Mar 2008 22:45:52 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75785>

Avoid 'fatal: cannot describe' message

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..5e8b84f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -315,7 +315,7 @@ set_name_rev () {
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains --tags "$2"
+			git describe --contains --tags "$2" 2>/dev/null
 		}
 	) )
 	test -z "$revname" || revname=" ($revname)"
-- 
1.5.4.3.347.g5314c

