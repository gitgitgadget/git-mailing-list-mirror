Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615221F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbcIDQNJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:09 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61558 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754216AbcIDQNB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:01 -0400
X-AuditID: 12074413-aa3ff70000000955-80-57cc472bc6fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id E6.21.02389.B274CC75; Sun,  4 Sep 2016 12:09:15 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5X026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:13 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/38] refs: reorder definitions
Date:   Sun,  4 Sep 2016 18:08:17 +0200
Message-Id: <1c1421e8f0bf4dd1bcaf3b7bb63a2d102d4fadae.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqKvtfibc4Gsnh0XXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujI4zjxgL5mtW9D7NbmCcr9jFyMkh
        IWAiMfv1LnYQW0hgK6NE46L8LkYuIPskk8T0VdPYQBJsAroSi3qamUBsEQE1iYlth1hAiphB
        imZNnAnWLSxgLPFiw0KwBhYBVYn+zmlgcV6BKInp5x6yQmyTk7i07QsziM0pYCFxZvdcIJsD
        aJu5RPuL7AmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihISb8A7G
        XSflDjEKcDAq8fBO0D0TLsSaWFZcmXuIUZKDSUmUd9bBk+FCfEn5KZUZicUZ8UWlOanFhxgl
        OJiVRHi1XYDKeVMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvNddgRoF
        i1LTUyvSMnNKENJMHJwgw3mAht8EqeEtLkjMLc5Mh8ifYlSUEud9CZIQAElklObB9cLSwStG
        caBXhHkT3ICqeICpBK77FdBgJqDB63afBhlckoiQkmpgnJp+TfTY+dupk8Uyv75NnKu6Ljze
        JdKlW/n9osfvmu9JfZ3259Lrpj2b9ti+4eprrmP1nhL8W/fvZZmVj859Tt5nn9yYtp1Bvui2
        8b+ojBVXGq/1cMuGGrnN6Jry6scXpaanoiwf92+QD/8fkbJYyTfrxrzqAO1nHVcOKan7v255
        xSXsq2WRoMRSnJFoqMVcVJwIAEMSS67iAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move resolve_gitlink_ref() and related functions lower in the file to
avoid the need for forward declarations in the next step.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 166 +++++++++++++++++++++++++--------------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d896052..7673342 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1316,89 +1316,6 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
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
@@ -1572,6 +1489,89 @@ static void unlock_ref(struct ref_lock *lock)
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
2.9.3

