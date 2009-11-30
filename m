From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2 1/6] t2300: use documented technique to invoke git-sh-setup
Date: Sun, 29 Nov 2009 23:19:26 -0700
Message-ID: <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 30 07:20:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzcI-0000qX-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZK3GTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbZK3GTz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:19:55 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:50929 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157AbZK3GTy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:19:54 -0500
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id BJJf1d0010x6nqcA5JL21u; Mon, 30 Nov 2009 06:20:02 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA12.emeryville.ca.mail.comcast.net with comcast
	id BJL01d0035FCJCg8YJL1Jq; Mon, 30 Nov 2009 06:20:01 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id D4EEB89115;
	Sun, 29 Nov 2009 23:19:59 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
In-Reply-To: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134048>

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
