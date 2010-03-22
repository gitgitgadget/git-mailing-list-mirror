From: maximilian attems <max@stro.at>
Subject: [PATCH] am: Pass exclude and include args to apply
Date: Mon, 22 Mar 2010 05:39:40 +0100
Message-ID: <1269232780-25314-1-git-send-email-max@stro.at>
Cc: maximilian attems <max@stro.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 05:40:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtZR9-00083L-5L
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 05:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab0CVEkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 00:40:16 -0400
Received: from baikonur.stro.at ([213.239.196.228]:46374 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0CVEkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 00:40:15 -0400
Received: from dual (pa-67-234-122-227.dhcp.embarqhsd.net [67.234.122.227])
	by baikonur.stro.at (Postfix) with ESMTP id 83E435C00B;
	Mon, 22 Mar 2010 05:32:29 +0100 (CET)
Received: by dual (Postfix, from userid 1000)
	id D5596240DB; Mon, 22 Mar 2010 05:39:58 +0100 (CET)
X-Mailer: git-send-email 1.7.0.2
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142896>

I had to port patches from dash git to klibc git,
where dash has a different directory structure.

Exported with format-patch on one side and used am
for the other side. There this switches came in handy.

Signed-off-by: maximilian attems <max@stro.at>
---
 git-am.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 50a292a..fc2f862 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,6 +22,8 @@ whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
+exclude=        pass it through git-apply
+include=        pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
 patch-format=   format the patch(es) are in
@@ -339,7 +341,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace|--directory)
+	--whitespace|--directory|--exclude|--include)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
-- 
1.7.0.2
