From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 06/10] t2300: use documented technique to invoke git-sh-setup
Date: Sat, 24 Jan 2009 16:43:17 -0700
Message-ID: <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBZ-0006Ei-GO
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbZAXXng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbZAXXnf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:35 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:49250 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753211AbZAXXnb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:31 -0500
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id 7Sn41b00717UAYkA5bjYvi; Sat, 24 Jan 2009 23:43:32 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id 7bjW1b00J1TYyYj8ZbjX53; Sat, 24 Jan 2009 23:43:31 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 13F028911A;
	Sat, 24 Jan 2009 16:43:25 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107020>

This is needed to allow the test suite to run against a minimal bin
directory instead of GIT_EXEC_PATH.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/t2300-cd-to-toplevel.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index e42cbfe..eac348a 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -8,7 +8,7 @@ test_cd_to_toplevel () {
 	test_expect_success "$2" '
 		(
 			cd '"'$1'"' &&
-			. git-sh-setup &&
+			. "$(git --exec-path)"/git-sh-setup &&
 			cd_to_toplevel &&
 			[ "$(unset PWD; /bin/pwd)" = "$TOPLEVEL" ]
 		)
-- 
1.6.1.81.g9833d.dirty
