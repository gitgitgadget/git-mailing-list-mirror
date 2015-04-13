From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v3 5/5] bash-completion: add support for git-log --merges= and log.merges
Date: Mon, 13 Apr 2015 17:29:28 +0200
Message-ID: <1428938968-19013-5-git-send-email-koosha@posteo.de>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 17:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhgK0-0002Nj-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbbDMPak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:30:40 -0400
Received: from mx02.posteo.de ([89.146.194.165]:49927 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932400AbbDMPa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 11:30:29 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id B90E425A3DEC
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:30:28 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lQYmh3y52z5vMp
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:30:28 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1428938968-19013-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267090>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 contrib/completion/git-completion.bash | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fbe5972..a75d7f5 100644
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
@@ -1451,7 +1451,11 @@ _git_log ()
 		__gitcomp "long short" "" "${cur##--decorate=}"
 		return
 		;;
-	--*)
+	--merges=*)
+		__gitcomp "show hide only" "" "${cur##--merges=}"
+		return
+		;;
+		--*)
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
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
