From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/38] refs: reorder definitions
Date: Fri,  3 Jun 2016 23:03:46 +0200
Message-ID: <b67dc4918007a8b556ff12fed9e712535951ac8f.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHG-0000Yi-SP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbcFCVEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:04:52 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61288 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbcFCVEq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:46 -0400
X-AuditID: 1207440c-c53ff70000000b85-5f-5751f0ec5d3b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id AF.45.02949.CE0F1575; Fri,  3 Jun 2016 17:04:44 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcb003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:43 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvmQ2C4wf2rRhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M5Ytfwge8EbjYoDVz6xNTB+Uuhi
	5OSQEDCRaNt6kK2LkYtDSGAro8TDD1sYIZzjTBJ/nx5mBKliE9CVWNTTzARiiwhESDS8agEr
	YhaYwyRx+2EnM0hCWMBAomn/SxYQm0VAVWLmrpmsIDavQJTElDkrWCHWyUlcnv6ADcTmFLCQ
	aPm8CiwuJGAu0XjqMMsERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3
	MULCjmcH47d1MocYBTgYlXh4C54FhguxJpYVV+YeYpTkYFIS5d17ByjEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhDflNVCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTB
	a/weqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFAXxxcA4AEnxAO2NAWnnLS5I
	zAWKQrSeYlSUEucNBUkIgCQySvPgxsKSyStGcaAvhXnngFTxABMRXPcroMFMQIMLHvmDDC5J
	REhJNTAaibTsT5n6K2FSAz974G71V9nTLyx7Nf3P1lV6HqJT7VzWbN4e3H35V5/huojjZWe3
	d8jen3h3Ztsz2f8M8md5ti749evFdobgLIXktJh0ziv74x6UVlx4f/B8dcH0LRuf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296376>

Move resolve_gitlink_ref() and related functions lower in the file to
avoid the need for forward declarations in the next step.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 166 +++++++++++++++++++++++++--------------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fea4487..50bfe97 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1320,89 +1320,6 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 	return get_ref_dir(refs->loose);
 }
 
-#define MAXREFLEN (1024)
-
-/*
- * Called by resolve_gitlink_ref_recursive() after it failed to read
- * from the loose refs in refs. Find <refname> in the packed-refs file
- * for the submodule.
- */
-static int resolve_gitlink_packed_ref(struct files_ref_store *refs,
-				      const char *refname, unsigned char *sha1)
-{
-	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
-
-	ref = find_ref(dir, refname);
-	if (ref == NULL)
-		return -1;
-
-	hashcpy(sha1, ref->u.value.oid.hash);
-	return 0;
-}
-
-static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
-					 const char *refname, unsigned char *sha1,
-					 int recursion)
-{
-	int fd, len;
-	char buffer[128], *p;
-	char *path;
-
-	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
-		return -1;
-	path = *refs->base.submodule
-		? git_pathdup_submodule(refs->base.submodule, "%s", refname)
-		: git_pathdup("%s", refname);
-	fd = open(path, O_RDONLY);
-	free(path);
-	if (fd < 0)
-		return resolve_gitlink_packed_ref(refs, refname, sha1);
-
-	len = read(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-	if (len < 0)
-		return -1;
-	while (len && isspace(buffer[len-1]))
-		len--;
-	buffer[len] = 0;
-
-	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, sha1))
-		return 0;
-
-	/* Symref? */
-	if (strncmp(buffer, "ref:", 4))
-		return -1;
-	p = buffer + 4;
-	while (isspace(*p))
-		p++;
-
-	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
-}
-
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
-{
-	int len = strlen(path);
-	struct strbuf submodule = STRBUF_INIT;
-	struct files_ref_store *refs;
-
-	while (len && path[len-1] == '/')
-		len--;
-	if (!len)
-		return -1;
-
-	strbuf_add(&submodule, path, len);
-	refs = get_files_ref_store(submodule.buf, "resolve_gitlink_ref");
-	if (!refs) {
-		strbuf_release(&submodule);
-		return -1;
-	}
-	strbuf_release(&submodule);
-
-	return resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-}
-
 /*
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
@@ -1576,6 +1493,89 @@ static void unlock_ref(struct ref_lock *lock)
 	free(lock);
 }
 
+#define MAXREFLEN (1024)
+
+/*
+ * Called by resolve_gitlink_ref_recursive() after it failed to read
+ * from the loose refs in refs. Find <refname> in the packed-refs file
+ * for the submodule.
+ */
+static int resolve_gitlink_packed_ref(struct files_ref_store *refs,
+				      const char *refname, unsigned char *sha1)
+{
+	struct ref_entry *ref;
+	struct ref_dir *dir = get_packed_refs(refs);
+
+	ref = find_ref(dir, refname);
+	if (ref == NULL)
+		return -1;
+
+	hashcpy(sha1, ref->u.value.oid.hash);
+	return 0;
+}
+
+static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
+					 const char *refname, unsigned char *sha1,
+					 int recursion)
+{
+	int fd, len;
+	char buffer[128], *p;
+	char *path;
+
+	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
+		return -1;
+	path = *refs->base.submodule
+		? git_pathdup_submodule(refs->base.submodule, "%s", refname)
+		: git_pathdup("%s", refname);
+	fd = open(path, O_RDONLY);
+	free(path);
+	if (fd < 0)
+		return resolve_gitlink_packed_ref(refs, refname, sha1);
+
+	len = read(fd, buffer, sizeof(buffer)-1);
+	close(fd);
+	if (len < 0)
+		return -1;
+	while (len && isspace(buffer[len-1]))
+		len--;
+	buffer[len] = 0;
+
+	/* Was it a detached head or an old-fashioned symlink? */
+	if (!get_sha1_hex(buffer, sha1))
+		return 0;
+
+	/* Symref? */
+	if (strncmp(buffer, "ref:", 4))
+		return -1;
+	p = buffer + 4;
+	while (isspace(*p))
+		p++;
+
+	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+{
+	int len = strlen(path);
+	struct strbuf submodule = STRBUF_INIT;
+	struct files_ref_store *refs;
+
+	while (len && path[len-1] == '/')
+		len--;
+	if (!len)
+		return -1;
+
+	strbuf_add(&submodule, path, len);
+	refs = get_files_ref_store(submodule.buf, "resolve_gitlink_ref");
+	if (!refs) {
+		strbuf_release(&submodule);
+		return -1;
+	}
+	strbuf_release(&submodule);
+
+	return resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
+}
+
 /*
  * Lock refname, without following symrefs, and set *lock_p to point
  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
-- 
2.8.1
