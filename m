From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 01/38] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Wed,  1 Oct 2014 12:28:05 +0200
Message-ID: <1412159322-2622-2-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9V-0002Nk-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbaJAK2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:28:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53405 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaJAK2w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:28:52 -0400
X-AuditID: 12074411-f79d86d000006a97-f6-542bd763ce5e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.9E.27287.367DB245; Wed,  1 Oct 2014 06:28:51 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk60026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:28:50 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1E2+rh1isPGMvkXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BnLnvQyF9wXr5g2ZRNrA+Nc4S5G
	Tg4JAROJ+c3/mCFsMYkL99azdTFycQgJXGaUWDznDRtIQkjgOJPEisnJIDabgK7Eop5mJhBb
	REBNYmLbIRaQBmaBxUwSEw5tAmrg4BAWiJd4ckAEpIZFQFXic/83sHpeAWeJGxMvMUIsk5PY
	sPs/mM0p4CKx/HIzC8QuZ4kdd74yTWDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11Qv
	N7NELzWldBMjJBQFdzDOOCl3iFGAg1GJh1chQTtEiDWxrLgy9xCjJAeTkijvoktAIb6k/JTK
	jMTijPii0pzU4kOMEhzMSiK82QeAcrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalF
	MFkZDg4lCV6Ga0CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDIiC8GxgZIigdo
	rzNIO29xQWIuUBSi9RSjLse6zm/9TEIsefl5qVLivJkgRQIgRRmleXArYInnFaM40MfCvOEg
	VTzApAU36RXQEiagJclrwJaUJCKkpBoYI0tsul5HpHOp3OPz/rXwT6GAXuTPG681He5xzFqh
	ry6v5+rV/aW5+pzgvublU6X2vPz37blBvbFyaQuHjFcNq0r3jJx5M6revCqJ+3Vk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257699>

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
index 8206039..0a76d02 100644
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
index ffd45e9..0e32477 100644
--- a/refs.c
+++ b/refs.c
@@ -2225,7 +2225,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			unable_to_lock_die(ref_file, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.0
