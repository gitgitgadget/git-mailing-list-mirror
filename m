From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 06/32] refs: add methods for misc ref operations
Date: Wed, 24 Feb 2016 17:58:38 -0500
Message-ID: <1456354744-8022-7-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiR4-00052b-7P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbcBXXBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:01:24 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34488 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065AbcBXW7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:20 -0500
Received: by mail-qg0-f43.google.com with SMTP id b67so27009127qgb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3VW31Rp6HfxoPoBZRgVnhiCtYQJV5UfBRawka5MAiJ4=;
        b=nQffTs9s+WCkOK5q2MitbevLKWjt0aWCxKASk6049islB8rj4K3mtv6J/WtDMxnnRh
         7/ico9UtLroqn5afwtuTE+AuMKtbMjLL9Yer922gBQ2QfSyS+MRdl9YEyhtCNzEOBM4f
         N2QJDJe19mCwwPozsOPa+Z85BecxglhRcKCW7SFheFZ7kONhzqVD/KDQfpjXs/ueFdOD
         NW3vPutJpeoW6Mm4pSMyEjKAH1Hio0lFTiTE2t6Vvla59h5MuoIzH9om7vjUT7FBs30A
         rLiYfHHAjrjyD8khAjZrIsW77yLEm47kD+2pNU4fW0zG3cwbsH6GMvBa0CNim2LgwmUd
         TgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3VW31Rp6HfxoPoBZRgVnhiCtYQJV5UfBRawka5MAiJ4=;
        b=A1C6M+a6c7n0XUpa6fnOulUrA/EoB6VsVt9poG0kAiJ6puZDVIJaqYl/S0HLJ50M8r
         lD8v+p5yc1Ho2OkhkTQ7TVjYUBHY7vEHcKhBTpjwb1vVSAtQOjhDZSL+jcAPbkmpawd9
         /eR0PfG22VQhG1Br2mVGsox5ZB2GfYCiqSgh+wXslIdgZxt5fVlVD6AR117WGIzWrYTR
         5ecZNAC4Q9kMwnVCanc2m5Ltken1s3SCusxIQ4fBftQEKusUd7BDMsJ/WPS5+79A7wVL
         6a2OXbbvm0KB86xqlIs6E4ysiOxPEJrQOXmjyWEygKcWeBlBheOjGPF7BioTDQ5TOF5V
         VVAw==
X-Gm-Message-State: AG10YOTFlVwkA4E8HJaSPS6pr0RVfYrQqKoL66IKJ4Dz4c8rHwP1Ir0lrXj3Ww9JkuJGsg==
X-Received: by 10.140.109.98 with SMTP id k89mr51486669qgf.69.1456354759174;
        Wed, 24 Feb 2016 14:59:19 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:18 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287275>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
read_raw_ref, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

read_raw_ref becomes static because it's not used outside refs.c

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 37 +++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 33 ++++++++++++++++++++++-----------
 refs/refs-internal.h | 27 +++++++++++++++++++++++----
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 6d16058..6fd5121 100644
--- a/refs.c
+++ b/refs.c
@@ -1191,6 +1191,14 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
+static int read_raw_ref(const char *refname, unsigned char *sha1,
+			struct strbuf *symref, struct strbuf *sb_path,
+			unsigned int *flags)
+{
+	return the_refs_backend->read_raw_ref(refname, sha1, symref, sb_path,
+					      flags);
+}
+
 /* This function needs to return a meaningful errno on failure */
 static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
@@ -1302,3 +1310,32 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->transaction_commit(transaction, err);
 }
+
+int verify_refname_available(const char *refname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	return the_refs_backend->verify_refname_available(refname, extra, skip, err);
+}
+
+int pack_refs(unsigned int flags)
+{
+	return the_refs_backend->pack_refs(flags);
+}
+
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	return the_refs_backend->peel_ref(refname, sha1);
+}
+
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	return the_refs_backend->create_symref(ref_target, refs_heads_master,
+					       logmsg);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1)
+{
+	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 45b81cd..3a83c0d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1338,7 +1338,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	struct strbuf submodule = STRBUF_INIT;
@@ -1421,9 +1422,9 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  */
-int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, struct strbuf *sb_path,
-		 unsigned int *flags)
+static int files_read_raw_ref(const char *refname, unsigned char *sha1,
+			      struct strbuf *symref, struct strbuf *sb_path,
+			      unsigned int *flags)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	int ret = -1;
@@ -1576,7 +1577,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2136,7 +2137,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2327,10 +2328,10 @@ out:
 	return ret;
 }
 
-int verify_refname_available(const char *newname,
-			     struct string_list *extras,
-			     struct string_list *skip,
-			     struct strbuf *err)
+static int files_verify_refname_available(const char *newname,
+					  struct string_list *extras,
+					  struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
@@ -2750,7 +2751,9 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(const char *refname,
+			       const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
@@ -3404,4 +3407,12 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+
+	files_read_raw_ref,
+	files_verify_refname_available,
+	files_resolve_gitlink_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 62ba0c0..c5f5ef7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -209,18 +209,37 @@ int rename_ref_available(const char *oldname, const char *newname);
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
-int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, struct strbuf *sb_path,
-		 unsigned int *flags);
-
 /* refs backends */
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
+/* misc methods */
+typedef int pack_refs_fn(unsigned int flags);
+typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
+typedef int create_symref_fn(const char *ref_target,
+			     const char *refs_heads_master,
+			     const char *logmsg);
+
+/* resolution methods */
+typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
+			    struct strbuf *symref, struct strbuf *sb_path,
+			    unsigned int *flags);
+typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
+typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
+				   unsigned char *sha1);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+
+	pack_refs_fn *pack_refs;
+	peel_ref_fn *peel_ref;
+	create_symref_fn *create_symref;
+
+	read_raw_ref_fn *read_raw_ref;
+	verify_refname_available_fn *verify_refname_available;
+	resolve_gitlink_ref_fn *resolve_gitlink_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.767.g62658d5-twtrsrc
