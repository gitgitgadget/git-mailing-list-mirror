From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 10/35] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Tue, 16 Sep 2014 21:33:31 +0200
Message-ID: <1410896036-12750-11-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWJ-0000DL-SL
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbaIPTeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52822 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754881AbaIPTea (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:30 -0400
X-AuditID: 12074413-f79ed6d000002501-a4-541890c6bfa1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 34.BC.09473.6C098145; Tue, 16 Sep 2014 15:34:30 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcE001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:29 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHtsgkSIweT9ohZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdMfP8LsaCzZIVr9oEGhjniXQxcnBICJhIbF2p08XI
	CWSKSVy4t56ti5GLQ0jgMqPE240fWSCcE0wSjadOsYJUsQnoSizqaWYCSYgItDFK7Lq4mRXE
	YRboZpR4f+I0E0iVsECwxPKzNxlBVrAIqEoc+coMEuYVcJWY9W07K8Q6OYkNu/+DlXACxb/u
	KwAxhQRcJA7e9ZvAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkjI
	Ce9g3HVS7hCjAAejEg+vxyPxECHWxLLiytxDjJIcTEqivP+6JUKE+JLyUyozEosz4otKc1KL
	DzFKcDArifD+8AXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkePmA
	sSUkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qK+GJgXICkeID2aoO08xYXJOYC
	RSFaTzHqcqzr/NbPJMSSl5+XKiXOa9MPVCQAUpRRmge3ApZgXjGKA30sDDGKB5ic4Ca9AlrC
	BLTkbI8YyJKSRISUVAOj94wdMSwFs6/6WZQ0Oop9NVvCUCfzS7huV89OLfaUJdIRi8Lv5BbJ
	iniaXs1bKbLizW+Vv9Vc768InBGyy2FaeHhB9HS/swvm5LUcXdk6a9+ys7++/PG9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257148>

There are a few places that use these values, so define constants for
them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  4 ++++
 lockfile.c | 11 ++++++-----
 refs.c     |  7 ++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 73ba5d0..e4e7c56 100644
--- a/cache.h
+++ b/cache.h
@@ -570,6 +570,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 
+/* String appended to a filename to derive the lockfile name: */
+#define LOCK_SUFFIX ".lock"
+#define LOCK_SUFFIX_LEN 5
+
 struct lock_file {
 	struct lock_file *next;
 	int fd;
diff --git a/lockfile.c b/lockfile.c
index b6fe848..99a774b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -181,10 +181,11 @@ static char *resolve_symlink(char *p, size_t s)
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
+	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
+	 * room for adding ".lock" for the lock file name:
 	 */
-	static const size_t max_path_len = sizeof(lk->filename) - 5;
+	static const size_t max_path_len = sizeof(lk->filename) -
+					   LOCK_SUFFIX_LEN;
 
 	if (!lock_file_list) {
 		/* One-time initialization */
@@ -209,7 +210,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
+	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		lk->owner = getpid();
@@ -319,7 +320,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - 5; /* .lock */
+	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
 	result_file[i] = 0;
 	if (rename(lk->filename, result_file))
 		return -1;
diff --git a/refs.c b/refs.c
index 8cb3539..53cd4fb 100644
--- a/refs.c
+++ b/refs.c
@@ -79,7 +79,8 @@ out:
 		if (refname[1] == '\0')
 			return -1; /* Component equals ".". */
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (cp - refname >= LOCK_SUFFIX_LEN &&
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
 }
@@ -2551,11 +2552,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
 
 		lock->lk->filename[i] = 0;
 		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
+		lock->lk->filename[i] = LOCK_SUFFIX[0];
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
2.1.0
