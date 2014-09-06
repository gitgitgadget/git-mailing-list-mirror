From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 01/32] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Sat,  6 Sep 2014 09:50:15 +0200
Message-ID: <1409989846-22401-2-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAn8-000069-UM
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbaIFHwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42589 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750724AbaIFHv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:51:59 -0400
X-AuditID: 12074413-f79ed6d000002501-ec-540abd1feb2a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 38.53.09473.F1DBA045; Sat,  6 Sep 2014 03:51:59 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH0006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:51:58 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqCu/lyvEYNUaPouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujBcXV7AX/BCreLh0FnMD4wGhLkZODgkBE4kNt/6zQthiEhfurWfr
	YuTiEBK4zChx5MZBJgjnGJPEpEXL2EGq2AR0JRb1NIMlRATaGCV2XdwM1s4skCLR8bybsYuR
	g0NYIF5i6/EYEJNFQFXi6205kApeAReJ3VP/MkMsk5PYsPs/I4jNKeAqMb2pE8wWAqppP9nP
	NIGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkDAT3sG466TcIUYB
	DkYlHt4CB64QIdbEsuLK3EOMkhxMSqK8ecuBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4OyYD
	5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzNe4AaBYtS01Mr0jJz
	ShDSTBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3kaQdt7igsRcoChE6ylGXY51nd/6
	mYRY8vLzUqXEeZlAigRAijJK8+BWwJLKK0ZxoI+FeSeCVPEAExLcpFdAS5iAlpinc4IsKUlE
	SEk1MDbsXrM57HCu67fMymNzT83w3dHSv3v+wcrUCa4H1x3av9ku5MJ0eRfp1YxpM0rt+y2c
	zL+rPnpmx8tySbk0Wr+1Lvar4am+yUcnPQrh+cSUGvTi2deHByWeh56/OSPl1GKG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256551>

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
index 4d5b76c..da77094 100644
--- a/cache.h
+++ b/cache.h
@@ -581,7 +581,7 @@ struct lock_file {
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
index 27927f2..5ae8e69 100644
--- a/refs.c
+++ b/refs.c
@@ -2159,7 +2159,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			unable_to_lock_die(ref_file, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.0
