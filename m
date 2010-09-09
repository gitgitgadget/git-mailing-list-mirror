From: Oded Shimon <ods15@ods15.dyndns.org>
Subject: [PATCH] Add --src/dst-prefix to git-formt-patch in git-rebase.sh
Date: Thu,  9 Sep 2010 21:49:51 +0300
Message-ID: <1284058191-15831-1-git-send-email-ods15@ods15.dyndns.org>
References: <7vbp86n4t4.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 20:50:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmC9-0005KS-GQ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab0IISty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:49:54 -0400
Received: from bzq-79-177-53-38.red.bezeqint.net ([79.177.53.38]:36674 "EHLO
	ods15.dyndns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0IIStx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:49:53 -0400
Received: from ods15 by ods15.dyndns.org with local (Exim 4.71)
	(envelope-from <ods15@ods15.dyndns.org>)
	id 1OtmBz-00047u-86
	for git@vger.kernel.org; Thu, 09 Sep 2010 21:49:51 +0300
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <7vbp86n4t4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155875>

For the case of "diff.noprefix" in git-config, git-format-patch should
still output diff with standard prefixes for git-am

Signed-off-by: Oded Shimon <ods15@ods15.dyndns.org>
---
 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7508463..3335cee 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -566,6 +566,7 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+		--src-prefix=a/ --dst-prefix=b/ \
 		--no-renames $root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
-- 
1.6.4.4
