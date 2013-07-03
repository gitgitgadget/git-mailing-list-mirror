From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] Change "remote tracking" to "remote-tracking"
Date: Wed,  3 Jul 2013 11:12:34 +0200
Message-ID: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Schubert <mschub@elegosoft.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 11:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJRb-0008OZ-29
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435Ab3GCJdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:33:43 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:54892 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261Ab3GCJdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:33:42 -0400
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2013 05:33:42 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 849C8DE051;
	Wed,  3 Jul 2013 11:23:14 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmtsKTiKfWqn; Wed,  3 Jul 2013 11:23:14 +0200 (CEST)
Received: from pc.elego.de (unknown [46.189.27.162])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 55FB6DE00E;
	Wed,  3 Jul 2013 11:23:14 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.2.860.gf7f8a72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229477>

Fix a typo ("remote remote-tracking") going back to the big cleanup
in 2010 (8b3f3f84 etc). Also, remove some more occurrences of
"tracking" and "remote tracking" in favor of "remote-tracking".

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 Documentation/git-p4.txt           | 2 +-
 Documentation/git-submodule.txt    | 2 +-
 Documentation/glossary-content.txt | 4 ++--
 builtin/clone.c                    | 2 +-
 builtin/merge.c                    | 4 ++--
 t/t5505-remote.sh                  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c579fbc..609c1d2 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -180,7 +180,7 @@ subsequent 'sync' operations.
 	Import changes into given branch.  If the branch starts with
 	'refs/', it will be used as is.  Otherwise if it does not start
 	with 'p4/', that prefix is added.  The branch is assumed to
-	name a remote tracking, but this can be modified using
+	name a remote-tracking, but this can be modified using
 	'--import-local', or by giving a full ref name.  The default
 	branch is 'master'.
 +
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e576713..bfff090 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -262,7 +262,7 @@ OPTIONS
 --remote::
 	This option is only valid for the update command.  Instead of using
 	the superproject's recorded SHA-1 to update the submodule, use the
-	status of the submodule's remote tracking branch.  The remote used
+	status of the submodule's remote-tracking branch.  The remote used
 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
 	The remote branch used defaults to `master`, but the branch name may
 	be overridden by setting the `submodule.<name>.branch` option in
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index db2a74d..dba5062 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -113,7 +113,7 @@ Note that commands that operate on the history of the current branch
 while the HEAD is detached. They update the HEAD to point at the tip
 of the updated history without affecting any branch.  Commands that
 update or inquire information _about_ the current branch (e.g. `git
-branch --set-upstream-to` that sets what remote tracking branch the
+branch --set-upstream-to` that sets what remote-tracking branch the
 current branch integrates with) obviously do not work, as there is no
 (real) current branch to ask about in this state.
 
@@ -267,7 +267,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	The default upstream <<def_repository,repository>>. Most projects have
 	at least one upstream project which they track. By default
 	'origin' is used for that purpose. New upstream updates
-	will be fetched into remote <<def_remote_tracking_branch,remote-tracking branches>> named
+	will be fetched into <<def_remote_tracking_branch,remote-tracking branches>> named
 	origin/name-of-upstream-branch, which you can see using
 	`git branch -r`.
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 14b1323..17f57cd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -701,7 +701,7 @@ static void write_refspec_config(const char* src_ref_prefix,
 			/*
 			 * otherwise, the next "git fetch" will
 			 * simply fetch from HEAD without updating
-			 * any remote tracking branch, which is what
+			 * any remote-tracking branch, which is what
 			 * we want.
 			 */
 		} else {
diff --git a/builtin/merge.c b/builtin/merge.c
index 2ebe732..bad4536 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -948,7 +948,7 @@ static int evaluate_result(void)
 }
 
 /*
- * Pretend as if the user told us to merge with the tracking
+ * Pretend as if the user told us to merge with the remote-tracking
  * branch we have for the upstream of the current branch
  */
 static int setup_with_upstream(const char ***argv)
@@ -967,7 +967,7 @@ static int setup_with_upstream(const char ***argv)
 	args = xcalloc(branch->merge_nr + 1, sizeof(char *));
 	for (i = 0; i < branch->merge_nr; i++) {
 		if (!branch->merge[i]->dst)
-			die(_("No remote tracking branch for %s from %s"),
+			die(_("No remote-tracking branch for %s from %s"),
 			    branch->merge[i]->src, branch->remote_name);
 		args[i] = branch->merge[i]->dst;
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ee5d65d..8f6e392 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -74,7 +74,7 @@ test_expect_success 'add another remote' '
 	)
 '
 
-test_expect_success C_LOCALE_OUTPUT 'check remote tracking' '
+test_expect_success C_LOCALE_OUTPUT 'check remote-tracking' '
 	(
 		cd test &&
 		check_remote_track origin master side &&
-- 
1.8.3.2.860.gf7f8a72
