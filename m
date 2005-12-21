From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Use --abbrev in git-whatchanged
Date: Wed, 21 Dec 2005 23:37:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Dec 21 23:37:23 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCa4-0007Z9-QZ
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 23:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVLUWhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 17:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVLUWhE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 17:37:04 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39343 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964846AbVLUWhB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 17:37:01 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD35713FC80; Wed, 21 Dec 2005 23:37:00 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A303B9E268; Wed, 21 Dec 2005 23:37:00 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8E0959E21B; Wed, 21 Dec 2005 23:37:00 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 685D213FC80; Wed, 21 Dec 2005 23:37:00 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13909>


The output is much nicer on standard 80 columns. If you want the old
behaviour, you can still do

	git-whatchanged --abbrev=40

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-whatchanged.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5d0a4d9aedc8af48666744ab240cdc30b9c6cae3
diff --git a/git-whatchanged.sh b/git-whatchanged.sh
index b170f74..a30f64d 100755
--- a/git-whatchanged.sh
+++ b/git-whatchanged.sh
@@ -8,5 +8,5 @@ rev_list_args=$(git-rev-parse --sq --def
 diff_tree_args=$(git-rev-parse --sq --no-revs "$@") &&
 
 eval "git-rev-list $rev_list_args" |
-eval "git-diff-tree --stdin --pretty -r $diff_tree_args" |
+eval "git-diff-tree --stdin --pretty -r --abbrev $diff_tree_args" |
 LESS="$LESS -S" ${PAGER:-less}
-- 
0.99.9.GIT
