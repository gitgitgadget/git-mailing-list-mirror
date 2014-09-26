From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 11/39] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Fri, 26 Sep 2014 12:08:11 +0200
Message-ID: <1411726119-31598-12-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:16:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSZc-0002HF-NX
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbaIZKQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:16 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56881 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756498AbaIZKQL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:11 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2014 06:16:11 EDT
X-AuditID: 1207440f-f79156d000006a5c-7c-54253b4415c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 92.ED.27228.44B35245; Fri, 26 Sep 2014 06:09:08 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLu013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:07 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1HWxVg0x+LFF36LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozXl1cyFSyRrHj9uLSBcbJIFyMn
	h4SAicT/441MELaYxIV769m6GLk4hAQuM0r8+L+fHcLZxCSxYNVeZpAqNgFdiUU9zWAdIgJq
	EhPbDrGAFDELLGaSmHBoExtIQlggWKL3TSdYEYuAqsSFebeB4hwcvAKuEjc77CC2yUls2P2f
	EcTmBAo3br8GZgsJuEi0rJ/MMoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwS
	vdSU0k2MkFDk38HYtV7mEKMAB6MSD++NdSohQqyJZcWVuYcYJTmYlER5v1iohgjxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4b1jBJTjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwWlkBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1c
	IO28xQWJuUBRiNZTjLoc6zq/9TMJseTl56VKifMesQQqEgApyijNg1sBSzyvGMWBPhbmFQEZ
	xQNMWnCTXgEtYQJaonREGWRJSSJCSqqB0edoh6vqgnklR/9k7lXzP/i83j1Jv/pRgVLGwY2y
	O6dk8G6R/ab03vLs/pf1M2+/qL5qtGT204uFzcXh+/9PVerlOWu2ssVs1SfpR9w1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257530>

There are a few places that use these values, so define constants for
them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  4 ++++
 lockfile.c | 11 ++++++-----
 refs.c     |  7 ++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 07682cb..9f09a89 100644
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
index 2680dc9..23847fc 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -166,10 +166,11 @@ static char *resolve_symlink(char *p, size_t s)
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
@@ -194,7 +195,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
+	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		lk->owner = getpid();
@@ -308,7 +309,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (close_lock_file(lk))
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
