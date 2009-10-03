From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add the utterly important 'mispel' command
Date: Sun, 4 Oct 2009 00:41:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910040040180.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 00:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuDIa-0003Om-Of
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 00:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbZJCWkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 18:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZJCWkY
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 18:40:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:60604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752747AbZJCWkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 18:40:23 -0400
Received: (qmail invoked by alias); 03 Oct 2009 22:39:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 04 Oct 2009 00:39:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J3NBW8ruJoEJvi78F7rz6Am+oap1na9DTaaKm8o
	nd333Nje3quN6f
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129507>


If you do not remember how to mispel a command, you need some help.

Provide it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
Signed-off-by: Christian Halstrick <christian.halstrick@sap.com>
Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Acked-By: <paisleyklm@gmail.com>
---

	Please apply.

 Makefile         |    1 +
 builtin-mispel.c |   11 +++++++++++
 builtin.h        |    2 ++
 git.c            |    1 +
 help.c           |   31 +++++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 builtin-mispel.c

diff --git a/Makefile b/Makefile
index 690ac55..0b48b3b 100644
--- a/Makefile
+++ b/Makefile
@@ -610,6 +610,7 @@ BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
 BUILTIN_OBJS += builtin-mktree.o
+BUILTIN_OBJS += builtin-mispel.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
diff --git a/builtin-mispel.c b/builtin-mispel.c
new file mode 100644
index 0000000..e685f91
--- /dev/null
+++ b/builtin-mispel.c
@@ -0,0 +1,11 @@
+#include "cache.h"
+#include "builtin.h"
+
+int cmd_mispel(int argc, const char **argv, const char *prefix)
+{
+	if (argc < 2)
+		die ("What command do you want to mispel?");
+	error("You probably meant %s", help_mispeld_comd(argv[1]));
+	return 0;
+
+}
diff --git a/builtin.h b/builtin.h
index 20427d2..2973d90 100644
--- a/builtin.h
+++ b/builtin.h
@@ -12,6 +12,7 @@ extern const char git_more_info_string[];
 
 extern void list_common_cmds_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
+const char *help_mispeld_comd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int read_line_with_nul(char *buf, int size, FILE *file);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
@@ -73,6 +74,7 @@ extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
+extern int cmd_mispel(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 807d875..2caca54 100644
--- a/git.c
+++ b/git.c
@@ -327,6 +327,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "mktree", cmd_mktree, RUN_SETUP },
+		{ "mispel", cmd_mispel },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/help.c b/help.c
index 6c46d8b..97f0f22 100644
--- a/help.c
+++ b/help.c
@@ -296,6 +296,37 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->names = NULL;
 }
 
+const char *help_mispeld_comd(const char *cmd)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(main_cmds));
+	git_config(git_unknown_cmd_config, NULL);
+
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	add_cmd_list(&main_cmds, &aliases);
+	add_cmd_list(&main_cmds, &other_cmds);
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(main_cmds.names), cmdname_compare);
+	uniq(&main_cmds);
+
+	/* This reuses cmdname->len for similarity index */
+	for (i = 0; i < main_cmds.cnt; ++i)
+		main_cmds.names[i]->len =
+			levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
+
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(*main_cmds.names), levenshtein_compare);
+
+	if (main_cmds.cnt< 2)
+		die ("Uh oh. Your system reports no Git commands at all.");
+
+	return main_cmds.names[1]->name;
+}
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
-- 
1.6.4.msysgit.0.1.g2dcf.dirty
