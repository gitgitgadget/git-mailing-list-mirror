From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/25] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Mon, 14 Apr 2014 15:54:31 +0200
Message-ID: <1397483695-10888-2-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhM1-0008QH-5z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbaDNNzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59713 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358AbaDNNzH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:07 -0400
X-AuditID: 12074413-f79076d000002d17-72-534be8bae220
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C2.40.11543.AB8EB435; Mon, 14 Apr 2014 09:55:06 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt091010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:05 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLvrhXewwZPl2hZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGfsnbqIqeCSWMXTD5PYGhhXCHUx
	cnBICJhI3L4r38XICWSKSVy4t56ti5GLQ0jgMqNE/5xfjCAJIYGTTBK7jkiC2GwCuhKLepqZ
	QGwRATWJiW2HWEAamAXamSQO7egFSwgLxEt8W9nODGKzCKhK3Pr5CCzOK+Ai8W/+RFaIbXIS
	J49NZgU5glPAVWLhhyyIXS4Sd79MYZ3AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65
	Xm5miV5qSukmRkggCu9g3HVS7hCjAAejEg9vxxzvYCHWxLLiytxDjJIcTEqivBk3gEJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeF23AuV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8Nc+BGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP
	0N4kkHbe4oLEXKAoROspRkUpcd4SkIQASCKjNA9uLCy9vGIUB/pSmDcNpIoHmJrgul8BDWYC
	GszSDja4JBEhJQWM8K8LNec6vtT7vFj9ZChjwLpClV1FeSH2Gf/dBS95LVzMM3WlbXwp8yMj
	vSBD/i9Hlzw4x9/cWHQumVHAaevxENU6pu35e6RnCyrYb4uSZH+9afXKQO59Bzaw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246223>

This function is used for other things besides the index, so rename it
accordingly.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-index.c | 2 +-
 cache.h                | 2 +-
 lockfile.c             | 6 +++---
 refs.c                 | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba54e19..0bab053 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -919,7 +919,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-			unable_to_lock_index_die(get_index_file(), lock_error);
+			unable_to_lock_die(get_index_file(), lock_error);
 		}
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
diff --git a/cache.h b/cache.h
index 107ac61..3a873a4 100644
--- a/cache.h
+++ b/cache.h
@@ -543,7 +543,7 @@ struct lock_file {
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
 extern int unable_to_lock_error(const char *path, int err);
-extern NORETURN void unable_to_lock_index_die(const char *path, int err);
+extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..d4bfb3f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -181,7 +181,7 @@ int unable_to_lock_error(const char *path, int err)
 	return -1;
 }
 
-NORETURN void unable_to_lock_index_die(const char *path, int err)
+NORETURN void unable_to_lock_die(const char *path, int err)
 {
 	die("%s", unable_to_lock_message(path, err));
 }
@@ -190,7 +190,7 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_index_die(path, errno);
+		unable_to_lock_die(path, errno);
 	return fd;
 }
 
@@ -201,7 +201,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_index_die(path, errno);
+			unable_to_lock_die(path, errno);
 		return fd;
 	}
 
diff --git a/refs.c b/refs.c
index 28d5eca..67fe8b7 100644
--- a/refs.c
+++ b/refs.c
@@ -2118,7 +2118,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			unable_to_lock_die(ref_file, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
1.9.1
