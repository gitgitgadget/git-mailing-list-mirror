From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-archive: use RUN_SETUP
Date: Sat, 3 Mar 2007 17:14:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031714030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 17:14:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNWsY-0007Qs-CR
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 17:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030674AbXCCQO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 11:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbXCCQO1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 11:14:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:52892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030674AbXCCQO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 11:14:27 -0500
Received: (qmail invoked by alias); 03 Mar 2007 16:14:25 -0000
X-Provags-ID: V01U2FsdGVkX1+7jXpe9Li7ucj6fwDiQMAybhF2ZLe/Weom4c7RHm
	+jwaF8KNzYWgFk
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41302>


It used to roll its own setup.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	It deletes more lines than it adds...

 builtin-archive.c |    2 --
 git.c             |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 8ea6cb1..2fae885 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -252,8 +252,6 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	memset(&ar, 0, sizeof(ar));
 	tree_idx = parse_archive_args(argc, argv, &ar);
-	if (prefix == NULL)
-		prefix = setup_git_directory();
 
 	argv += tree_idx;
 	parse_treeish_arg(argv, &ar.args, prefix);
diff --git a/git.c b/git.c
index 909adf2..446d24e 100644
--- a/git.c
+++ b/git.c
@@ -237,7 +237,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "add", cmd_add, RUN_SETUP | DISALLOW_IN_GIT_DIR },
 		{ "annotate", cmd_annotate, USE_PAGER },
 		{ "apply", cmd_apply },
-		{ "archive", cmd_archive },
+		{ "archive", cmd_archive, RUN_SETUP },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
-- 
1.5.0.2.2498.g9e15a-dirty
