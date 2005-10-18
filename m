From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] No funny names on cygwin...
Date: Tue, 18 Oct 2005 16:27:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510181627040.31297@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 18 16:28:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERsRE-0007ia-1j
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 16:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJRO1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 10:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJRO1d
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 10:27:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53725 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750760AbVJRO1c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 10:27:32 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CE23A13EC95; Tue, 18 Oct 2005 16:27:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B4A559EE82; Tue, 18 Oct 2005 16:27:31 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A11239EE36; Tue, 18 Oct 2005 16:27:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 73D8813EC95; Tue, 18 Oct 2005 16:27:31 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10212>

On FAT/NTFS, filenames cannot contain tabs. So t3300-funny-names would
reliably fail already when trying to create such files.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 t/t3300-funny-names.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

applies-to: 2a40773d42d149766148a0c4ed9c501b67d55ee4
b92942c59ac2c70d867035e8ed4f6eca1f53df1b
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index ccd7063..897c378 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -9,6 +9,9 @@ This test tries pathnames with funny cha
 tree, index, and tree objects.
 '
 
+# since FAT/NTFS does not allow tabs in filenames, skip this test
+test "$(uname -o 2>/dev/null)" = Cygwin && exit 0
+
 . ./test-lib.sh
 
 p0='no-funny'
---
0.99.8.GIT
