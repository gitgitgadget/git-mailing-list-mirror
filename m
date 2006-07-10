From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] Move all builtin .c files into builtin/
Date: Mon, 10 Jul 2006 00:54:09 -0400
Message-ID: <11525072491512-git-send-email-ryan@michonline.com>
References: <1152507249880-git-send-email-ryan@michonline.com> <11525072492717-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 10 06:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FznpD-0003Tt-PH
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 06:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWGJE4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 00:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWGJE4s
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 00:56:48 -0400
Received: from h4x0r5.com ([70.85.31.202]:4872 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751336AbWGJE4r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 00:56:47 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fznn7-0004Dw-1W; Sun, 09 Jul 2006 21:54:41 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1Fznmb-0003VL-Pf; Mon, 10 Jul 2006 00:54:09 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g6bdc-dirty
In-Reply-To: <11525072492717-git-send-email-ryan@michonline.com>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23589>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 Makefile                                           |   15 ++-------------
 builtin/Makefile                                   |   13 +++++++++++++
 builtin-add.c => builtin/builtin-add.c             |    0 
 builtin-apply.c => builtin/builtin-apply.c         |    0 
 builtin-cat-file.c => builtin/builtin-cat-file.c   |    0 
 .../builtin-check-ref-format.c                     |    0 
 .../builtin-commit-tree.c                          |    0 
 builtin-count.c => builtin/builtin-count.c         |    0 
 .../builtin-diff-files.c                           |    0 
 .../builtin-diff-index.c                           |    0 
 .../builtin-diff-stages.c                          |    0 
 builtin-diff-tree.c => builtin/builtin-diff-tree.c |    0 
 builtin-diff.c => builtin/builtin-diff.c           |    0 
 .../builtin-fmt-merge-msg.c                        |    0 
 builtin-grep.c => builtin/builtin-grep.c           |    0 
 builtin-help.c => builtin/builtin-help.c           |    0 
 builtin-init-db.c => builtin/builtin-init-db.c     |    0 
 builtin-log.c => builtin/builtin-log.c             |    0 
 builtin-ls-files.c => builtin/builtin-ls-files.c   |    0 
 builtin-ls-tree.c => builtin/builtin-ls-tree.c     |    0 
 builtin-mailinfo.c => builtin/builtin-mailinfo.c   |    0 
 builtin-mailsplit.c => builtin/builtin-mailsplit.c |    0 
 builtin-push.c => builtin/builtin-push.c           |    0 
 builtin-read-tree.c => builtin/builtin-read-tree.c |    0 
 builtin-rev-list.c => builtin/builtin-rev-list.c   |    0 
 builtin-rev-parse.c => builtin/builtin-rev-parse.c |    0 
 builtin-rm.c => builtin/builtin-rm.c               |    0 
 .../builtin-show-branch.c                          |    0 
 .../builtin-stripspace.c                           |    0 
 builtin-tar-tree.c => builtin/builtin-tar-tree.c   |    0 
 .../builtin-update-index.c                         |    0 
 .../builtin-update-ref.c                           |    0 
 .../builtin-upload-tar.c                           |    0 
 .../builtin-write-tree.c                           |    0 
 builtin.h => builtin/builtin.h                     |    0 
 git.c                                              |    2 +-
 36 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index d6e2b0f..92368b9 100644
--- a/Makefile
+++ b/Makefile
@@ -87,7 +87,7 @@ uname_P := $(shell sh -c 'uname -p 2>/de
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -I.
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -177,6 +177,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 
 
 include interop/Makefile
+include builtin/Makefile
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -222,18 +223,6 @@ LIB_OBJS = \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	alloc.o $(DIFF_OBJS)
 
-BUILTIN_OBJS = \
-	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
-	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
-	builtin-tar-tree.o builtin-upload-tar.o builtin-update-index.o \
-	builtin-ls-files.o builtin-ls-tree.o builtin-write-tree.o \
-	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
-	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
-	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
-	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
-	builtin-update-ref.o builtin-fmt-merge-msg.o
-
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
 
diff --git a/builtin/Makefile b/builtin/Makefile
new file mode 100644
index 0000000..3588fce
--- /dev/null
+++ b/builtin/Makefile
@@ -0,0 +1,13 @@
+BUILTIN_OBJ_BASE = \
+	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
+	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-format.o \
+	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
+	builtin-tar-tree.o builtin-upload-tar.o builtin-update-index.o \
+	builtin-ls-files.o builtin-ls-tree.o builtin-write-tree.o \
+	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
+	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
+	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
+	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
+	builtin-update-ref.o builtin-fmt-merge-msg.o
+
+BUILTIN_OBJS = $(addprefix builtin/,$(BUILTIN_OBJ_BASE))
\ No newline at end of file
diff --git a/builtin-add.c b/builtin/builtin-add.c
similarity index 100%
rename from builtin-add.c
rename to builtin/builtin-add.c
diff --git a/builtin-apply.c b/builtin/builtin-apply.c
similarity index 100%
rename from builtin-apply.c
rename to builtin/builtin-apply.c
diff --git a/builtin-cat-file.c b/builtin/builtin-cat-file.c
similarity index 100%
rename from builtin-cat-file.c
rename to builtin/builtin-cat-file.c
diff --git a/builtin-check-ref-format.c b/builtin/builtin-check-ref-format.c
similarity index 100%
rename from builtin-check-ref-format.c
rename to builtin/builtin-check-ref-format.c
diff --git a/builtin-commit-tree.c b/builtin/builtin-commit-tree.c
similarity index 100%
rename from builtin-commit-tree.c
rename to builtin/builtin-commit-tree.c
diff --git a/builtin-count.c b/builtin/builtin-count.c
similarity index 100%
rename from builtin-count.c
rename to builtin/builtin-count.c
diff --git a/builtin-diff-files.c b/builtin/builtin-diff-files.c
similarity index 100%
rename from builtin-diff-files.c
rename to builtin/builtin-diff-files.c
diff --git a/builtin-diff-index.c b/builtin/builtin-diff-index.c
similarity index 100%
rename from builtin-diff-index.c
rename to builtin/builtin-diff-index.c
diff --git a/builtin-diff-stages.c b/builtin/builtin-diff-stages.c
similarity index 100%
rename from builtin-diff-stages.c
rename to builtin/builtin-diff-stages.c
diff --git a/builtin-diff-tree.c b/builtin/builtin-diff-tree.c
similarity index 100%
rename from builtin-diff-tree.c
rename to builtin/builtin-diff-tree.c
diff --git a/builtin-diff.c b/builtin/builtin-diff.c
similarity index 100%
rename from builtin-diff.c
rename to builtin/builtin-diff.c
diff --git a/builtin-fmt-merge-msg.c b/builtin/builtin-fmt-merge-msg.c
similarity index 100%
rename from builtin-fmt-merge-msg.c
rename to builtin/builtin-fmt-merge-msg.c
diff --git a/builtin-grep.c b/builtin/builtin-grep.c
similarity index 100%
rename from builtin-grep.c
rename to builtin/builtin-grep.c
diff --git a/builtin-help.c b/builtin/builtin-help.c
similarity index 100%
rename from builtin-help.c
rename to builtin/builtin-help.c
diff --git a/builtin-init-db.c b/builtin/builtin-init-db.c
similarity index 100%
rename from builtin-init-db.c
rename to builtin/builtin-init-db.c
diff --git a/builtin-log.c b/builtin/builtin-log.c
similarity index 100%
rename from builtin-log.c
rename to builtin/builtin-log.c
diff --git a/builtin-ls-files.c b/builtin/builtin-ls-files.c
similarity index 100%
rename from builtin-ls-files.c
rename to builtin/builtin-ls-files.c
diff --git a/builtin-ls-tree.c b/builtin/builtin-ls-tree.c
similarity index 100%
rename from builtin-ls-tree.c
rename to builtin/builtin-ls-tree.c
diff --git a/builtin-mailinfo.c b/builtin/builtin-mailinfo.c
similarity index 100%
rename from builtin-mailinfo.c
rename to builtin/builtin-mailinfo.c
diff --git a/builtin-mailsplit.c b/builtin/builtin-mailsplit.c
similarity index 100%
rename from builtin-mailsplit.c
rename to builtin/builtin-mailsplit.c
diff --git a/builtin-push.c b/builtin/builtin-push.c
similarity index 100%
rename from builtin-push.c
rename to builtin/builtin-push.c
diff --git a/builtin-read-tree.c b/builtin/builtin-read-tree.c
similarity index 100%
rename from builtin-read-tree.c
rename to builtin/builtin-read-tree.c
diff --git a/builtin-rev-list.c b/builtin/builtin-rev-list.c
similarity index 100%
rename from builtin-rev-list.c
rename to builtin/builtin-rev-list.c
diff --git a/builtin-rev-parse.c b/builtin/builtin-rev-parse.c
similarity index 100%
rename from builtin-rev-parse.c
rename to builtin/builtin-rev-parse.c
diff --git a/builtin-rm.c b/builtin/builtin-rm.c
similarity index 100%
rename from builtin-rm.c
rename to builtin/builtin-rm.c
diff --git a/builtin-show-branch.c b/builtin/builtin-show-branch.c
similarity index 100%
rename from builtin-show-branch.c
rename to builtin/builtin-show-branch.c
diff --git a/builtin-stripspace.c b/builtin/builtin-stripspace.c
similarity index 100%
rename from builtin-stripspace.c
rename to builtin/builtin-stripspace.c
diff --git a/builtin-tar-tree.c b/builtin/builtin-tar-tree.c
similarity index 100%
rename from builtin-tar-tree.c
rename to builtin/builtin-tar-tree.c
diff --git a/builtin-update-index.c b/builtin/builtin-update-index.c
similarity index 100%
rename from builtin-update-index.c
rename to builtin/builtin-update-index.c
diff --git a/builtin-update-ref.c b/builtin/builtin-update-ref.c
similarity index 100%
rename from builtin-update-ref.c
rename to builtin/builtin-update-ref.c
diff --git a/builtin-upload-tar.c b/builtin/builtin-upload-tar.c
similarity index 100%
rename from builtin-upload-tar.c
rename to builtin/builtin-upload-tar.c
diff --git a/builtin-write-tree.c b/builtin/builtin-write-tree.c
similarity index 100%
rename from builtin-write-tree.c
rename to builtin/builtin-write-tree.c
diff --git a/builtin.h b/builtin/builtin.h
similarity index 100%
rename from builtin.h
rename to builtin/builtin.h
diff --git a/git.c b/git.c
index 49062ca..81f6675 100644
--- a/git.c
+++ b/git.c
@@ -12,7 +12,7 @@ #include "git-compat-util.h"
 #include "exec_cmd.h"
 #include "cache.h"
 
-#include "builtin.h"
+#include "builtin/builtin.h"
 
 static void prepend_to_path(const char *dir, int len)
 {
-- 
1.4.1.gc473b-dirty
