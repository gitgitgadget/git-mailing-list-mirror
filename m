From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 11/38] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Wed,  1 Oct 2014 12:28:15 +0200
Message-ID: <1412159322-2622-12-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9n-0002VI-GE
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaJAK3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42032 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387AbaJAK3J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:09 -0400
X-AuditID: 12074413-f79ed6d000002501-fb-542bd77451f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A3.AD.09473.477DB245; Wed,  1 Oct 2014 06:29:08 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6A026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:07 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1C25rh1icPyylkXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BkLpx9gKVgiWbG18R9LA+NkkS5G
	Tg4JAROJ6xdbWCBsMYkL99azdTFycQgJXGaUeNr3gxXCOc4k8fjPTHaQKjYBXYlFPc1MILaI
	gJrExLZDLCBFzAKLmSQmHNrEBpIQFgiW2H/0KpjNIqAqceBdL1gDr4CLxL72PUwQ6+QkNuz+
	zwhicwLFl19uBjtDSMBZYsedr0wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vN
	LNFLTSndxAgJR+EdjLtOyh1iFOBgVOLhVUjQDhFiTSwrrsw9xCjJwaQkyrvoElCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCG/2AaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFM
	VoaDQ0mCl+EaUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDrii4HxAZLiAdrr
	DNLOW1yQmAsUhWg9xajLsa7zWz+TEEtefl6qlDhv6FWgIgGQoozSPLgVsOTzilEc6GNhXmmQ
	UTzAxAU36RXQEiagJclrwJaUJCKkpBoYGSuvNGdxejSExpl6S0zfFrTOtVH2V8Uj+7dzZ0/0
	Xnbk0uF7M/WDq0T4NNwKs6odjJ2afP9Gl9hnZO1a+2xJmF/vkzTdvRuKr8284bnn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257703>

There are a few places that use these values, so define constants for
them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  4 ++++
 lockfile.c | 11 ++++++-----
 refs.c     |  7 ++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 0a76d02..24891a8 100644
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
index 0e32477..73d6bae 100644
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
@@ -2602,11 +2603,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
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
