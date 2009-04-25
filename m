From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] bash completion: show-branch color support
Date: Sat, 25 Apr 2009 13:46:14 +0200
Message-ID: <1240659974-12161-1-git-send-email-markus.heidelberg@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 13:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxgMj-0002mY-16
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 13:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZDYLqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbZDYLqZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 07:46:25 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48604 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbZDYLqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 07:46:24 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id AECC8FDB0F1F;
	Sat, 25 Apr 2009 13:46:23 +0200 (CEST)
Received: from [89.59.73.176] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LxgKt-0000oA-00; Sat, 25 Apr 2009 13:46:23 +0200
X-Mailer: git-send-email 1.6.3.rc1.84.g1036b
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+AQETGpGGpdKNXZBClXYUu8abUSY9HfY9z67XY
	VXzV+dn73l1lT8kM/vi8AFccBYj9PACvJeNnDJUUQpTUYMYUjU
	xS/d0fWhcjU4XWRH5/zA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117549>

This implements completion of --color and --no-color for "git
show-branch" and color.showbranch for "git config".

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

   This goes on top of mh/show-branch-color which is currently in pu.

 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1a90cb8..b588387 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1333,7 +1333,8 @@ _git_config ()
 		__gitcomp "$(__git_merge_strategies)"
 		return
 		;;
-	color.branch|color.diff|color.interactive|color.status|color.ui)
+	color.branch|color.diff|color.interactive|\
+	color.showbranch|color.status|color.ui)
 		__gitcomp "always never auto"
 		return
 		;;
@@ -1415,6 +1416,7 @@ _git_config ()
 		color.interactive.help
 		color.interactive.prompt
 		color.pager
+		color.showbranch
 		color.status
 		color.status.added
 		color.status.changed
@@ -1676,6 +1678,7 @@ _git_show_branch ()
 		__gitcomp "
 			--all --remotes --topo-order --current --more=
 			--list --independent --merge-base --no-name
+			--color --no-color
 			--sha1-name --topics --reflog
 			"
 		return
-- 
1.6.3.rc1.84.g1036b
