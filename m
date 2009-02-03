From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 8/8] test-lib: avoid assuming that templates/ are in the
 GIT_EXEC_PATH
Date: Wed, 4 Feb 2009 00:26:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040026290.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUg0-0007K0-2K
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZBCX0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbZBCX0C
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:26:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:34417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753212AbZBCX0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:26:00 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 04 Feb 2009 00:25:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JrqEQnWjJ6iimukA1CCw2zryVS8gBZhJPl/KnyT
	AOCsnUTDba+lkU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108272>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 495d55d..54bbb97 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -454,7 +454,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir -p "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >&3 2>&4 ||
+	"$GIT_EXEC_PATH/git" init "--template=$owd/../templates/blt/" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
@@ -578,8 +578,6 @@ else
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
-
-	make_symlink ../../../templates "$GIT_VALGRIND"/bin/templates || exit
 fi
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
-- 
1.6.1.2.582.g3fdd5
