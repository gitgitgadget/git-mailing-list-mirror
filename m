From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 1/4] t2300: use documented technique to invoke git-sh-setup
Date: Sat, 28 Nov 2009 11:38:54 -0700
Message-ID: <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 28 19:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NESH9-0005ra-2i
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbZK1Snl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbZK1Snk
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:43:40 -0500
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:34379
	"EHLO QMTA12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378AbZK1Snd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 13:43:33 -0500
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59])
	by QMTA12.emeryville.ca.mail.comcast.net with comcast
	id AhBw1d0011GXsucACijhdo; Sat, 28 Nov 2009 18:43:41 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA07.emeryville.ca.mail.comcast.net with comcast
	id Aijg1d0015FCJCg8Tijgdn; Sat, 28 Nov 2009 18:43:40 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id BE67689115;
	Sat, 28 Nov 2009 11:43:38 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133968>

This is needed to allow the test suite to run against a standard
install bin directory instead of GIT_EXEC_PATH.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/t2300-cd-to-toplevel.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index 3b01ad2..9965bc5 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -8,7 +8,7 @@ test_cd_to_toplevel () {
 	test_expect_success $3 "$2" '
 		(
 			cd '"'$1'"' &&
-			. git-sh-setup &&
+			. "$(git --exec-path)"/git-sh-setup &&
 			cd_to_toplevel &&
 			[ "$(pwd -P)" = "$TOPLEVEL" ]
 		)
-- 
1.6.4.GIT
