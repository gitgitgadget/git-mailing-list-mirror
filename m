From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 02/21] refs: add methods for misc ref operations
Date: Fri,  5 Feb 2016 14:44:03 -0500
Message-ID: <1454701462-3817-3-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:44:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJJ-0000vJ-5t
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbcBETor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:47 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:32953 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbcBEToo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:44 -0500
Received: by mail-qg0-f49.google.com with SMTP id b35so75918303qge.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oCbtUxpItSn4x8pj1A4cJADSN4b6jmDa+MlboPt4yOk=;
        b=nTvtRS24j2no5FADI0KOJPruT4YJwt/jN/u53WJe9C4usu7hRLWr9S/QMrUNjhgpwb
         FVN1S4FKgxWm5Lo74u7sAZvP2uF+3q7vE8cXRLHpFz2HLYliVxTOXZqOGfauW0csocuz
         BjnpzMuIUA/OOZR2/B3Gfd4ts67cegU7OOESMh+TDXDtjPB9SrMOa2g9Lour4YgN+qJX
         ZTr+N3Qvx8JSrkXNk0osNHg38sMxE/5sfCXJxVsECCUCSX0tYQo/nRQkHu/GNwhG3fCY
         457qhIwEEZgnX4++4f6wK1IMz2H0DGJJlTB78Wv5jqOCT01Rydaakk1p1DN+1uOJH+9W
         966g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oCbtUxpItSn4x8pj1A4cJADSN4b6jmDa+MlboPt4yOk=;
        b=KQyrEqsvPcBpYHOobwrlL6SeDy/mbRZ8p5ej9+fJQWovt60aebfSrKht7BcJzrpiqD
         47syTErE+Vjn76Ay5IEpXmEBSvEORmAlV9kpgRYrTwCvAXIeEZkhUoRpN2RR9RzUKI+W
         qGd0TcnWGINr3hjPIjlaXkGCQur7yyGkd0q1jb/KhBhKxaio07PN1/QSCyIgnZw9JzJi
         PVUtlB0xp116iD2vDdGthr2EXKcy46+KIvV3hDbR6CWb1Jtjv5JkiWAHpRYVUTcKsCoA
         1HybTrfMD8E5xTD6VSp7uXhvVgzfiLwk+CFxEgkEG8TtADT1S3xVCTcBlQOsKPeHujtB
         U8bA==
X-Gm-Message-State: AG10YORjX3eSxwuuxfnBFJqFU9HoKFzP0gKPlJyrvFLVGGkwJccfnMeGaZX9WtvnO14daA==
X-Received: by 10.140.101.130 with SMTP id u2mr19213638qge.71.1454701483421;
        Fri, 05 Feb 2016 11:44:43 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285603>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    |  1 +
 refs.c               | 36 ++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 33 +++++++++++++++++++++++----------
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 4 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 07229d6..26e1cc3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
diff --git a/refs.c b/refs.c
index 1c646f5..afdde7d 100644
--- a/refs.c
+++ b/refs.c
@@ -1122,3 +1122,39 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->transaction_commit(transaction, err);
 }
+
+const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	return the_refs_backend->resolve_ref_unsafe(ref, resolve_flags, sha1,
+						    flags);
+}
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
index 2a73564..882d830 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1343,7 +1343,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	struct strbuf submodule = STRBUF_INIT;
@@ -1583,8 +1584,10 @@ static const char *resolve_ref_1(const char *refname,
 	}
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+static const char *files_resolve_ref_unsafe(const char *refname,
+					    int resolve_flags,
+					    unsigned char *sha1,
+					    int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct strbuf sb_contents = STRBUF_INIT;
@@ -1633,7 +1636,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2270,7 +2273,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2461,10 +2464,10 @@ out:
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
@@ -2884,7 +2887,9 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(const char *refname,
+			       const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
@@ -3538,4 +3543,12 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+
+	files_resolve_ref_unsafe,
+	files_verify_refname_available,
+	files_resolve_gitlink_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc0e852..e83bc22 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -201,10 +201,33 @@ int rename_ref_available(const char *oldname, const char *newname);
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
+typedef const char *resolve_ref_unsafe_fn(const char *ref,
+					  int resolve_flags,
+					  unsigned char *sha1, int *flags);
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
+	resolve_ref_unsafe_fn *resolve_ref_unsafe;
+	verify_refname_available_fn *verify_refname_available;
+	resolve_gitlink_ref_fn *resolve_gitlink_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.749.g730654d-twtrsrc
