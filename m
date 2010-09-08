From: Oded Shimon <ods15@ods15.dyndns.org>
Subject: [PATCH] Add explicit --src/dst-prefix to git-formt-patch in git-rebase.sh for the case of "diff.noprefix" in git-config
Date: Wed,  8 Sep 2010 16:54:05 +0300
Message-ID: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 16:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtLPB-00079B-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 16:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab0IHONf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 10:13:35 -0400
Received: from bzq-79-177-53-38.red.bezeqint.net ([79.177.53.38]:38259 "EHLO
	ods15.dyndns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0IHONe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 10:13:34 -0400
X-Greylist: delayed 1164 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2010 10:13:33 EDT
Received: from ods15 by ods15.dyndns.org with local (Exim 4.71)
	(envelope-from <ods15@ods15.dyndns.org>)
	id 1OtL6D-0002An-Qh
	for git@vger.kernel.org; Wed, 08 Sep 2010 16:54:05 +0300
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155785>

---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7508463..e83a0cf 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -565,7 +565,7 @@ fi
 
 if test -z "$do_merge"
 then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	git format-patch -k --stdout --full-index --ignore-if-in-upstream --src-prefix=a/ --dst-prefix=b/ \
 		--no-renames $root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
-- 
1.6.4.4
