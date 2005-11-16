From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix tests with new git in C
Date: Wed, 16 Nov 2005 02:44:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160244240.14176@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 16 02:47:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCM9-0007jm-IE
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVKPBow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKPBow
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:44:52 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34443 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965154AbVKPBov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 20:44:51 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 75C5513F8C9; Wed, 16 Nov 2005 02:44:50 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5A2CD9F309; Wed, 16 Nov 2005 02:44:50 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 466E59F2E3; Wed, 16 Nov 2005 02:44:50 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3118513F8C9; Wed, 16 Nov 2005 02:44:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11986>


GIT_EXEC_PATH *has* to be set.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/test-lib.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: 923eb95f309cc9765505d187ce03881a555e75f6
ab9cab703171b1ccfe1bee5c3b210ca7369a0476
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a8f239d..e654155 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -158,6 +158,8 @@ test_done () {
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
 PATH=$(pwd)/..:$PATH
+GIT_EXEC_PATH=$(pwd)/..
+export GIT_EXEC_PATH
 
 # Test repository
 test=trash
---
0.99.9.GIT
