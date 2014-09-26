From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 01/39] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Fri, 26 Sep 2014 12:08:01 +0200
Message-ID: <1411726119-31598-2-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSg-0003cB-8W
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbaIZKJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:05 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53310 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751753AbaIZKIx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:08:53 -0400
X-AuditID: 1207440e-f79da6d0000002fc-1c-54253b3402b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A8.49.00764.43B35245; Fri, 26 Sep 2014 06:08:52 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLk013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:51 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1DWxVg0x6L5lbtF1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd8bDr1NZCu6LVyy48YC9gXGucBcj
	J4eEgInEqouH2CFsMYkL99azdTFycQgJXGaUWLrnJzOEs4lJ4vCts6wgVWwCuhKLepqZQGwR
	ATWJiW2HWECKmAUWM0lMOLSJDSQhLBAv8X7WdBYQm0VAVeJw7xewZl4BF4nZ738xQqyTk9iw
	+z+YzSngKtG4/RqYLQRU07J+MssERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIz
	S/RSU0o3MULCkW8HY/t6mUOMAhyMSjy8N9aphAixJpYVV+YeYpTkYFIS5f1ioRoixJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYT3jhFQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwVtkBdQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2
	eoC08xYXJOYCRSFaTzHqcqzr/NbPJMSSl5+XKiXOe8QSqEgApCijNA9uBSz5vGIUB/pYmNcX
	ZBQPMHHBTXoFtIQJaInSEWWQJSWJCCmpBsZFLGEPv1YeOfrs0RFnv/SJP+W9c3e8ftJxn+no
	10pbz4P1rMnXU8M4/l/5rdkqPHXDmkd3rV5pq3CunLQnKUTaWlBjh1Hu9XUPRO74 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257508>

This function is used for other things besides the index, so rename it
accordingly.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/update-index.c | 2 +-
 cache.h                | 2 +-
 lockfile.c             | 6 +++---
 refs.c                 | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e8c7fd4..6c95988 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -942,7 +942,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-			unable_to_lock_index_die(get_index_file(), lock_error);
+			unable_to_lock_die(get_index_file(), lock_error);
 		}
 		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
diff --git a/cache.h b/cache.h
index af590d5..07682cb 100644
--- a/cache.h
+++ b/cache.h
@@ -582,7 +582,7 @@ struct lock_file {
 extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
-extern NORETURN void unable_to_lock_index_die(const char *path, int err);
+extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 2a800ce..f1ce154 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -185,7 +185,7 @@ int unable_to_lock_error(const char *path, int err)
 	return -1;
 }
 
-NORETURN void unable_to_lock_index_die(const char *path, int err)
+NORETURN void unable_to_lock_die(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -198,7 +198,7 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_index_die(path, errno);
+		unable_to_lock_die(path, errno);
 	return fd;
 }
 
@@ -209,7 +209,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_index_die(path, errno);
+			unable_to_lock_die(path, errno);
 		return fd;
 	}
 
diff --git a/refs.c b/refs.c
index 2ce5d69..8cb3539 100644
--- a/refs.c
+++ b/refs.c
@@ -2167,7 +2167,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			unable_to_lock_die(ref_file, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.0
