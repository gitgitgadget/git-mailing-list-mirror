From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 36/38] refs: add method to rename refs
Date: Fri,  3 Jun 2016 23:04:11 +0200
Message-ID: <5b60488598626c2230db96e951dbc4ff6201e5f0.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ5-00025e-2i
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbcFCVGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:45 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61312 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932971AbcFCVFb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:31 -0400
X-AuditID: 1207440c-c3fff70000000b85-3e-5751f11a6362
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A7.65.02949.A11F1575; Fri,  3 Jun 2016 17:05:30 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kd2003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:29 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqCv1MTDc4P51a4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGfM6tjLVtAqU/FhWlwD42exLkZO
	DgkBE4nVm9ezdzFycQgJbGWUaP+7iQnCOc4kcaFpIxtIFZuArsSinmYmEFtEIEKi4VULI0gR
	s8AcJonbDzuZQRLCAmYSX45MYQSxWQRUJWasPgHWzCsQJXH+4GV2iHVyEpenPwCLcwpYSLR8
	XsUKYgsJmEs0njrMMoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2M
	kKDj2cH4bZ3MIUYBDkYlHt6CZ4HhQqyJZcWVuYcYJTmYlER5994BCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhTXkNlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfAu
	eg/UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KgfhiYBSApHiA9p4DaectLkjM
	BYpCtJ5iVJQS5z0EkhAASWSU5sGNhaWSV4ziQF8K894GqeIBpiG47ldAg5mABhc88gcZXJKI
	kJJqYPQ5N3ufoFTY9LLstssmxgKt3a+VbNpTdsS4qM+5IOM/ZWXSD/tfaYc9tj52T7/7LMr9
	+rSFNYFy05eVts5gDl1/l7+0KlpKf+bKGFPGAj1hrma5pZeXzRMP3xaW2an8ROeX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296406>

From: David Turner <dturner@twopensource.com>

This removes the last caller of function get_files_ref_store(), so
remove it.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  7 +++++++
 refs/files-backend.c | 24 ++++++------------------
 refs/refs-internal.h |  4 ++++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 7dc67a6..17a36fb 100644
--- a/refs.c
+++ b/refs.c
@@ -1544,3 +1544,10 @@ int delete_refs(struct string_list *refnames, unsigned int flags)
 
 	return refs->be->delete_refs(refs, refnames, flags);
 }
+
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->rename_ref(refs, oldref, newref, logmsg);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b2d677e..d098c7d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1001,22 +1001,6 @@ static struct files_ref_store *files_downcast(
 	return refs;
 }
 
-/*
- * Return a pointer to the reference store for the specified
- * submodule. For the main repository, use submodule==NULL; such a
- * call cannot fail. For a submodule, the submodule must exist and be
- * a nonbare repository, otherwise return NULL. Verify that the
- * reference store is a files_ref_store, and cast it to that type
- * before returning it.
- */
-static struct files_ref_store *get_files_ref_store(const char *submodule,
-						   const char *caller)
-{
-	struct ref_store *refs = get_ref_store(submodule);
-
-	return refs ? files_downcast(refs, 1, caller) : NULL;
-}
-
 /* The length of a peeled reference line in packed-refs, including EOL: */
 #define PEELED_LINE_LENGTH 42
 
@@ -2584,9 +2568,12 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
-	struct files_ref_store *refs = get_files_ref_store(NULL, "rename_ref");
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -4090,6 +4077,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6c46353..4bfa5ce 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -489,6 +489,9 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *logmsg);
 typedef int delete_refs_fn(struct ref_store *ref_store,
 			   struct string_list *refnames, unsigned int flags);
+typedef int rename_ref_fn(struct ref_store *ref_store,
+			  const char *oldref, const char *newref,
+			  const char *logmsg);
 
 /*
  * Iterate over the references in the specified ref_store that are
@@ -588,6 +591,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
-- 
2.8.1
