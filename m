From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 38/38] lockfile.h: extract new header file for the functions in lockfile.c
Date: Wed,  1 Oct 2014 12:28:42 +0200
Message-ID: <1412159322-2622-39-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAZ-0002tu-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbaJAK36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:58 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42567 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751778AbaJAK3z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:55 -0400
X-AuditID: 12074414-f79446d000001f1d-ba-542bd7a2fe99
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AB.61.07965.2A7DB245; Wed,  1 Oct 2014 06:29:54 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6b026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:53 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1F10XTvEYNFmPYuuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDN6Np1jKpg/gbFi47nHbA2ME4u7
	GDk5JARMJOZ3T2CDsMUkLtxbD2RzcQgJXGaU6O97xgrhHGeSeH7+AjtIFZuArsSinmYmEFtE
	QE1iYtshFpAiZoHFTBITDm0CGyUsECtxbu1MRhCbRUBV4sbu2WBxXgEXiWl/ZzFDrJOT2LD7
	P1gNJ1B8+eVmFhBbSMBZYsedr0wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvN
	LNFLTSndxAgJSJEdjEdOyh1iFOBgVOLhVUjQDhFiTSwrrsw9xCjJwaQkyrvoElCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCG/2AaAcb0piZVVqUT5MSpqDRUmc99tidT8hgfTEktTs1NSC1CKY
	rAwHh5IEL8M1oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UHzEFwMjBCTFA7TX
	GaSdt7ggMRcoCtF6ilGXY13nt34mIZa8/LxUKXHeTJAiAZCijNI8uBWw9POKURzoY2HecJAq
	HmDqgpv0CmgJE9CS5DVgS0oSEVJSDYzLLiye+0tWwKBRii/wusGmr2F5UWdcPnmf0nxgsHZx
	7Q2LJU8nO5rMDjv9dPaX/O6He5hlZ9XvTn+9PbxMduNRjurC+5qp389NPWrKyF8T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257719>

Move the interface declaration for the functions in lockfile.c from
cache.h to a new file, lockfile.h. Add #includes where necessary (and
remove some redundant includes of cache.h by files that already
include builtin.h).

Move the documentation of the lock_file state diagram from lockfile.c
to the new header file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/add.c            |  1 +
 builtin/apply.c          |  1 +
 builtin/checkout-index.c |  2 +-
 builtin/checkout.c       |  2 +-
 builtin/clone.c          |  1 +
 builtin/commit.c         |  1 +
 builtin/describe.c       |  1 +
 builtin/diff.c           |  1 +
 builtin/gc.c             |  2 +-
 builtin/merge.c          |  1 +
 builtin/mv.c             |  2 +-
 builtin/read-tree.c      |  1 +
 builtin/receive-pack.c   |  1 +
 builtin/reflog.c         |  2 +-
 builtin/reset.c          |  1 +
 builtin/rm.c             |  2 +-
 builtin/update-index.c   |  1 +
 bundle.c                 |  1 +
 cache-tree.c             |  1 +
 cache.h                  | 27 +---------------
 config.c                 |  1 +
 credential-store.c       |  1 +
 fast-import.c            |  1 +
 fetch-pack.c             |  1 +
 lockfile.c               | 52 +-----------------------------
 lockfile.h               | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 merge-recursive.c        |  1 +
 merge.c                  |  1 +
 read-cache.c             |  1 +
 refs.c                   |  1 +
 rerere.c                 |  1 +
 sequencer.c              |  1 +
 sha1_file.c              |  1 +
 shallow.c                |  1 +
 test-scrap-cache-tree.c  |  1 +
 35 files changed, 118 insertions(+), 83 deletions(-)
 create mode 100644 lockfile.h

diff --git a/builtin/add.c b/builtin/add.c
index 352b85e..ae6d3e2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "lockfile.h"
 #include "dir.h"
 #include "pathspec.h"
 #include "exec_cmd.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index 8714a88..69efb0e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -7,6 +7,7 @@
  *
  */
 #include "cache.h"
+#include "lockfile.h"
 #include "cache-tree.h"
 #include "quote.h"
 #include "blob.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 05edd9e..383dccf 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -5,7 +5,7 @@
  *
  */
 #include "builtin.h"
-#include "cache.h"
+#include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "parse-options.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8afdf2b..570bb09 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,5 +1,5 @@
-#include "cache.h"
 #include "builtin.h"
+#include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 3927edf..d3bf953 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -9,6 +9,7 @@
  */
 
 #include "builtin.h"
+#include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index f55e809..c230018 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -6,6 +6,7 @@
  */
 
 #include "cache.h"
+#include "lockfile.h"
 #include "cache-tree.h"
 #include "color.h"
 #include "dir.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index ee6a3b9..9103193 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..4326fa5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "lockfile.h"
 #include "color.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index ced1456..005adbe 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -11,7 +11,7 @@
  */
 
 #include "builtin.h"
-#include "cache.h"
+#include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "sigchain.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index be07f27..4513fad 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "builtin.h"
+#include "lockfile.h"
 #include "run-command.h"
 #include "diff.h"
 #include "refs.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 8883baa..563d05b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,8 +3,8 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
-#include "cache.h"
 #include "builtin.h"
+#include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
 #include "string-list.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index e7e1c33..43b47f7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "lockfile.h"
 #include "object.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index daf0600..10fa25d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "lockfile.h"
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7c78b15..b6388f7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,5 +1,5 @@
-#include "cache.h"
 #include "builtin.h"
+#include "lockfile.h"
 #include "commit.h"
 #include "refs.h"
 #include "dir.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 855d478..4c08ddc 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
 #include "builtin.h"
+#include "lockfile.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 2b61d3b..d8a9c86 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,8 +3,8 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-#include "cache.h"
 #include "builtin.h"
+#include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6c95988..b0e3dc9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
diff --git a/bundle.c b/bundle.c
index b2b89fe..891a3ca 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "bundle.h"
 #include "object.h"
 #include "commit.h"
diff --git a/cache-tree.c b/cache-tree.c
index 75a54fd..215202c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
diff --git a/cache.h b/cache.h
index d19e57f..b71ceb2 100644
--- a/cache.h
+++ b/cache.h
@@ -570,36 +570,11 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 
-/* String appended to a filename to derive the lockfile name: */
-#define LOCK_SUFFIX ".lock"
-#define LOCK_SUFFIX_LEN 5
-
-struct lock_file {
-	struct lock_file *volatile next;
-	volatile sig_atomic_t active;
-	volatile int fd;
-	volatile pid_t owner;
-	char on_list;
-	struct strbuf filename;
-};
-#define LOCK_DIE_ON_ERROR 1
-#define LOCK_NO_DEREF 2
-extern int unable_to_lock_error(const char *path, int err);
-extern void unable_to_lock_message(const char *path, int err,
-				   struct strbuf *buf);
-extern NORETURN void unable_to_lock_die(const char *path, int err);
-extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
-extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
-extern char *get_locked_file_path(struct lock_file *);
-extern int commit_lock_file_to(struct lock_file *, const char *path);
-extern int commit_lock_file(struct lock_file *);
-extern int reopen_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
-extern int close_lock_file(struct lock_file *);
-extern void rollback_lock_file(struct lock_file *);
+
 extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 
 /* Environment bits from configuration mechanism */
diff --git a/config.c b/config.c
index 2110779..c31d4d2 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,7 @@
  *
  */
 #include "cache.h"
+#include "lockfile.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
diff --git a/credential-store.c b/credential-store.c
index f9146e5..d435514 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "credential.h"
 #include "string-list.h"
 #include "parse-options.h"
diff --git a/fast-import.c b/fast-import.c
index 783c684..deadc33 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -153,6 +153,7 @@ Format of STDIN stream:
 
 #include "builtin.h"
 #include "cache.h"
+#include "lockfile.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 7487aa7..655ee64 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "commit.h"
diff --git a/lockfile.c b/lockfile.c
index 63f4e94..d27e61c 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -2,59 +2,9 @@
  * Copyright (c) 2005, Junio C Hamano
  */
 #include "cache.h"
+#include "lockfile.h"
 #include "sigchain.h"
 
-/*
- * File write-locks as used by Git.
- *
- * For an overview of how to use the lockfile API, please see
- *
- *     Documentation/technical/api-lockfile.txt
- *
- * This module keeps track of all locked files in lock_file_list for
- * use at cleanup. This list and the lock_file objects that comprise
- * it must be kept in self-consistent states at all time, because the
- * program can be interrupted any time by a signal, in which case the
- * signal handler will walk through the list attempting to clean up
- * any open lock files.
- *
- * A lockfile is owned by the process that created it. The lock_file
- * object has an "owner" field that records its owner. This field is
- * used to prevent a forked process from closing a lockfile created by
- * its parent.
- *
- * The possible states of a lock_file object are as follows:
- *
- * - Uninitialized.  In this state the object's on_list field must be
- *   zero but the rest of its contents need not be initialized.  As
- *   soon as the object is used in any way, it is irrevocably
- *   registered in the lock_file_list, and on_list is set.
- *
- * - Locked, lockfile open (after hold_lock_file_for_update(),
- *   hold_lock_file_for_append(), or reopen_lock_file()). In this
- *   state:
- *   - the lockfile exists
- *   - active is set
- *   - filename holds the filename of the lockfile
- *   - fd holds a file descriptor open for writing to the lockfile
- *   - owner holds the PID of the process that locked the file
- *
- * - Locked, lockfile closed (after successful close_lock_file()).
- *   Same as the previous state, except that the lockfile is closed
- *   and fd is -1.
- *
- * - Unlocked (after commit_lock_file(), commit_lock_file_to(),
- *   rollback_lock_file(), a failed attempt to lock, or a failed
- *   close_lock_file()).  In this state:
- *   - active is unset
- *   - filename is empty (usually, though there are transitory
- *     states in which this condition doesn't hold). Client code should
- *     *not* rely on the filename being empty in this state.
- *   - fd is -1
- *   - the object is left registered in the lock_file_list, and
- *     on_list is set.
- */
-
 static struct lock_file *volatile lock_file_list;
 
 static void remove_lock_files(void)
diff --git a/lockfile.h b/lockfile.h
new file mode 100644
index 0000000..9059e89
--- /dev/null
+++ b/lockfile.h
@@ -0,0 +1,84 @@
+#ifndef LOCKFILE_H
+#define LOCKFILE_H
+
+/*
+ * File write-locks as used by Git.
+ *
+ * For an overview of how to use the lockfile API, please see
+ *
+ *     Documentation/technical/api-lockfile.txt
+ *
+ * This module keeps track of all locked files in lock_file_list for
+ * use at cleanup. This list and the lock_file objects that comprise
+ * it must be kept in self-consistent states at all time, because the
+ * program can be interrupted any time by a signal, in which case the
+ * signal handler will walk through the list attempting to clean up
+ * any open lock files.
+ *
+ * A lockfile is owned by the process that created it. The lock_file
+ * object has an "owner" field that records its owner. This field is
+ * used to prevent a forked process from closing a lockfile created by
+ * its parent.
+ *
+ * The possible states of a lock_file object are as follows:
+ *
+ * - Uninitialized.  In this state the object's on_list field must be
+ *   zero but the rest of its contents need not be initialized.  As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in the lock_file_list, and on_list is set.
+ *
+ * - Locked, lockfile open (after hold_lock_file_for_update(),
+ *   hold_lock_file_for_append(), or reopen_lock_file()). In this
+ *   state:
+ *   - the lockfile exists
+ *   - active is set
+ *   - filename holds the filename of the lockfile
+ *   - fd holds a file descriptor open for writing to the lockfile
+ *   - owner holds the PID of the process that locked the file
+ *
+ * - Locked, lockfile closed (after successful close_lock_file()).
+ *   Same as the previous state, except that the lockfile is closed
+ *   and fd is -1.
+ *
+ * - Unlocked (after commit_lock_file(), commit_lock_file_to(),
+ *   rollback_lock_file(), a failed attempt to lock, or a failed
+ *   close_lock_file()).  In this state:
+ *   - active is unset
+ *   - filename is empty (usually, though there are transitory
+ *     states in which this condition doesn't hold). Client code should
+ *     *not* rely on the filename being empty in this state.
+ *   - fd is -1
+ *   - the object is left registered in the lock_file_list, and
+ *     on_list is set.
+ */
+
+struct lock_file {
+	struct lock_file *volatile next;
+	volatile sig_atomic_t active;
+	volatile int fd;
+	volatile pid_t owner;
+	char on_list;
+	struct strbuf filename;
+};
+
+/* String appended to a filename to derive the lockfile name: */
+#define LOCK_SUFFIX ".lock"
+#define LOCK_SUFFIX_LEN 5
+
+#define LOCK_DIE_ON_ERROR 1
+#define LOCK_NO_DEREF 2
+
+extern int unable_to_lock_error(const char *path, int err);
+extern void unable_to_lock_message(const char *path, int err,
+				   struct strbuf *buf);
+extern NORETURN void unable_to_lock_die(const char *path, int err);
+extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
+extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern char *get_locked_file_path(struct lock_file *);
+extern int commit_lock_file_to(struct lock_file *, const char *path);
+extern int commit_lock_file(struct lock_file *);
+extern int reopen_lock_file(struct lock_file *);
+extern int close_lock_file(struct lock_file *);
+extern void rollback_lock_file(struct lock_file *);
+
+#endif /* LOCKFILE_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index 8ad4be8..4b0884b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -5,6 +5,7 @@
  */
 #include "advice.h"
 #include "cache.h"
+#include "lockfile.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/merge.c b/merge.c
index 74ced7f..fcff632 100644
--- a/merge.c
+++ b/merge.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "commit.h"
 #include "run-command.h"
 #include "resolve-undo.h"
diff --git a/read-cache.c b/read-cache.c
index 9f137e7..8f3e9eb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "lockfile.h"
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
diff --git a/refs.c b/refs.c
index e40c47e..1d73f1d 100644
--- a/refs.c
+++ b/refs.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
diff --git a/rerere.c b/rerere.c
index 20b18ad..1b0555f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "xdiff-interface.h"
diff --git a/sequencer.c b/sequencer.c
index 5e8a207..1b9a35e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "sequencer.h"
 #include "dir.h"
 #include "object.h"
diff --git a/sha1_file.c b/sha1_file.c
index c08c0cb..46ff273 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -8,6 +8,7 @@
  */
 #include "cache.h"
 #include "string-list.h"
+#include "lockfile.h"
 #include "delta.h"
 #include "pack.h"
 #include "blob.h"
diff --git a/shallow.c b/shallow.c
index 4919baf..bd7569e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
index 9ebcbca..6efee31 100644
--- a/test-scrap-cache-tree.c
+++ b/test-scrap-cache-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "lockfile.h"
 #include "tree.h"
 #include "cache-tree.h"
 
-- 
2.1.0
