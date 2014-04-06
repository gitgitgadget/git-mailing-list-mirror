From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/25] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Mon,  7 Apr 2014 01:33:44 +0200
Message-ID: <1396827247-28465-3-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbL-000602-VM
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbaDFXfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:31 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54063 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754571AbaDFXer (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:47 -0400
X-AuditID: 12074411-f79ab6d000002f0e-a0-5341e4953045
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 84.2F.12046.594E1435; Sun,  6 Apr 2014 19:34:45 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWn011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:44 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqDv1iWOwQfdaE4uuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MFmfeNDJadHZ8ZXRg9/j7/gOTx85Zd9k9nvXuYfS4eEnZY/EDL4/P
	m+Q8bj/bxhLAHsVtk5RYUhacmZ6nb5fAnXH/sVrBJbGK66/ZGhhXCHUxcnJICJhITJn0iBHC
	FpO4cG89WxcjF4eQwGVGiX1T25ghnONMEs8/7GEDqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCxw
	g1Hi3b7DQA4Hh7BAvMTefXUgNSwCqhLb/rxjBrF5BVwkTnffZoXYJidx8thkMJtTwFVi3eS5
	LCC2EFDNu3332CYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJ2
	gjsYZ5yUO8QowMGoxMO74pBjsBBrYllxZe4hRkkOJiVRXst7QCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivAduAOV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8fY+B
	GgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP0N7pIO28xQWJuUBR
	iNZTjIpS4rwzHwElBEASGaV5cGNhyeQVozjQl8K8y0DaeYCJCK77FdBgJqDBDWF2IINLEhFS
	Ug2MzV5LHDX3xMSUy2+bOGWP36mzwgz8Veqn3O3/5V6/JS+vN9P+csrpZ2fV8t3cXr8MNo+4
	WCYbuM8z4dxChx0P2Bco3+c6+Xeuc+uPZ6u4bkzx/dDf/YdZ1Vz39JOZNl+Wv1dv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245803>

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
index d12ad95..3b1721b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -891,7 +891,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
