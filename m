From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] test-lib: quiet down init-db output for tests
Date: Thu, 28 Dec 2006 01:10:51 -0800
Message-ID: <11672970561224-git-send-email-normalperson@yhbt.net>
References: <11672970521665-git-send-email-normalperson@yhbt.net> <11672970542015-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:11:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrIC-0002Gx-Hb
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWL1JLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWL1JLB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:11:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43004 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964955AbWL1JK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:10:59 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6573D7DC094;
	Thu, 28 Dec 2006 01:10:56 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:10:56 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <11672970542015-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35545>

I don't think anybody running tests needs to know they're
running init-db and creating a repository for testing.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f0f9cd6..ad2b6f6 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -176,7 +176,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init-db --template=$GIT_EXEC_PATH/templates/blt/ 2>/dev/null ||
+	"$GIT_EXEC_PATH/git" init-db --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
 	error "cannot run git init-db -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.4.4.3.gd4ada
