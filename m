From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] git-gui: relax "dirty" version detection
Date: Mon, 18 Feb 2008 09:36:33 +0100
Message-ID: <1203323793-18020-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, spearce@spearce.org,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 09:37:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1VR-0006G4-9c
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbYBRIhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbYBRIhF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:37:05 -0500
Received: from wincent.com ([72.3.236.74]:33135 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234AbYBRIhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:37:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1I8aZjV006415;
	Mon, 18 Feb 2008 02:36:36 -0600
X-Mailer: git-send-email 1.5.4.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74245>

"git gui" would complain at launch if the local version of Git was
"1.5.4.2.dirty". Loosen the regular expression to look for either
"-dirty" or ".dirty", thus eliminating spurious warnings.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 5d65272..238a239 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -663,7 +663,7 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
 }
 
 set _real_git_version $_git_version
-regsub -- {-dirty$} $_git_version {} _git_version
+regsub -- {[\-\.]dirty$} $_git_version {} _git_version
 regsub {\.[0-9]+\.g[0-9a-f]+$} $_git_version {} _git_version
 regsub {\.rc[0-9]+$} $_git_version {} _git_version
 regsub {\.GIT$} $_git_version {} _git_version
-- 
1.5.4.2.dirty
