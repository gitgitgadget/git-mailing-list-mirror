From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH 5/5] Update Bash completion script to include git log --merges option
Date: Sun, 22 Mar 2015 19:28:41 +0100
Message-ID: <1427048921-28677-5-git-send-email-koosha@posteo.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Cc: Koosha Khajehmoogahi <koosha@posteo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:30:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZkdn-0003PJ-95
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 19:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbbCVSaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 14:30:13 -0400
Received: from mx02.posteo.de ([89.146.194.165]:41312 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbbCVSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 14:30:11 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id C7A8A1F5E873;
	Sun, 22 Mar 2015 19:30:09 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l96p94bklz5vNB;
	Sun, 22 Mar 2015 19:30:09 +0100 (CET)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266076>

Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 731c289..b63bb95 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1406,7 +1406,7 @@ _git_ls_tree ()
 __git_log_common_options="
 	--not --all
 	--branches --tags --remotes
-	--first-parent --merges --no-merges
+	--first-parent --merges --merges= --no-merges
 	--max-count=
 	--max-age= --since= --after=
 	--min-age= --until= --before=
@@ -1451,6 +1451,10 @@ _git_log ()
 		__gitcomp "long short" "" "${cur##--decorate=}"
 		return
 		;;
+    --merges=*)
+        __gitcomp "show hide only" "" "${cur##--merges=}"
+        return
+        ;;
 	--*)
 		__gitcomp "
 			$__git_log_common_options
@@ -1861,6 +1865,10 @@ _git_config ()
 		__gitcomp "$__git_log_date_formats"
 		return
 		;;
+	log.merges)
+		__gitcomp "show hide only"
+		return
+		;;
 	sendemail.aliasesfiletype)
 		__gitcomp "mutt mailrc pine elm gnus"
 		return
@@ -2150,6 +2158,7 @@ _git_config ()
 		interactive.singlekey
 		log.date
 		log.decorate
+		log.merges
 		log.showroot
 		mailmap.file
 		man.
-- 
2.3.3.263.g095251d.dirty
