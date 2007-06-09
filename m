From: Johan Herland <johan@herland.net>
Subject: [PATCH 6/7] Softrefs: Administrivia associated with softrefs subsystem
 and git-softref builtin
Date: Sat, 09 Jun 2007 20:24:01 +0200
Message-ID: <200706092024.01593.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5bf-0004dM-Fu
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568AbXFISYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756489AbXFISYI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:24:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:42226 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756476AbXFISYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:24:06 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00M03SG50L00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:24:05 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JMTSG2II00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:24:02 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000N4SG1VJ60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:24:01 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49598>

Also cleans up sorting and whitespace in Documentation/cmd-list.perl

Signed-off-by: Johan Herland <johan@herland.net>
---
 .gitignore                  |    1 +
 Documentation/cmd-list.perl |    7 ++++---
 Makefile                    |    6 ++++--
 builtin.h                   |    1 +
 git.c                       |    1 +
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 27e5aeb..7fd6904 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,7 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
+git-softref
 git-ssh-fetch
 git-ssh-pull
 git-ssh-push
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index a181f75..4e1f45b 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -90,6 +90,7 @@ git-clean                               mainporcelain
 git-clone                               mainporcelain
 git-commit                              mainporcelain
 git-commit-tree                         plumbingmanipulators
+git-config                              ancillarymanipulators
 git-convert-objects                     ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-cvsexportcommit                     foreignscminterface
@@ -101,13 +102,13 @@ git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff                                mainporcelain
 git-diff-tree                           plumbinginterrogators
-git-fast-import				ancillarymanipulators
+git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain
 git-fetch-pack                          synchingrepositories
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck	                        ancillaryinterrogators
+git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain
@@ -155,7 +156,6 @@ git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
 git-repack                              ancillarymanipulators
-git-config                              ancillarymanipulators
 git-remote                              ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
@@ -174,6 +174,7 @@ git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
+git-softref                             ancillarymanipulators
 git-ssh-fetch                           synchingrepositories
 git-ssh-upload                          synchingrepositories
 git-status                              mainporcelain
diff --git a/Makefile b/Makefile
index 0f75955..22e3e53 100644
--- a/Makefile
+++ b/Makefile
@@ -296,7 +296,7 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h
+	mailmap.h remote.h softrefs.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -318,7 +318,8 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
+	softrefs.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -370,6 +371,7 @@ BUILTIN_OBJS = \
 	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
+	builtin-softref.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
 	builtin-tar-tree.o \
diff --git a/builtin.h b/builtin.h
index da4834c..beae52c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -67,6 +67,7 @@ extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_softref(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 29b55a1..96cc0b8 100644
--- a/git.c
+++ b/git.c
@@ -283,6 +283,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "softref", cmd_softref, RUN_SETUP },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
-- 
1.5.2.1.144.gabc40
