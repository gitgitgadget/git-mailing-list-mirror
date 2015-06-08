From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/13] refs: move the remaining ref module declarations to refs.h
Date: Mon,  8 Jun 2015 13:45:47 +0200
Message-ID: <2f18cd5c2fdce062a319a116affc7a42ed21a3c4.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVl-0005aa-5F
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbFHLqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:30 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62189 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333AbbFHLqR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:17 -0400
X-AuditID: 1207440f-f79236d000000c5e-17-55758081920d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 36.FD.03166.18085755; Mon,  8 Jun 2015 07:46:09 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58BjopA017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:46:08 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqNvYUBpqsP0Ai0XXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4MyY/6GcuuFNbsf3EFaYGxklpXYycHBICJhLrOvazQdhiEhfurQeyuTiEBC4zSsx9NgPK
	OcEk8fjVLVaQKjYBXYlFPc1MILaIgJrExLZDLCBFzAIdjBIXlm9jB0kICwRKdCyZCzaWRUBV
	4mbvL0YQm1cgSmL95FNQ6+Qkzh//yQxicwpYSNz9fwEsLiRgLvFxWzvjBEbeBYwMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCgop/B2PXeplDjAIcjEo8vAcWlYQKsSaW
	FVfmHmKU5GBSEuXtKisNFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCy2QBlONNSaysSi3Kh0lJ
	c7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfB+rANqFCxKTU+tSMvMKUFIM3FwggznkhIp
	Ts1LSS1KLC3JiAdFR3wxMD5AUjxAe5+BtPMWFyTmAkUhWk8xKkqJ8z4GSQiAJDJK8+DGwlLF
	K0ZxoC+FeXXrgap4gGkGrvsV0GAmoMHfvxaDDC5JREhJNTCarb718qWKLV/kJL/tBxz6eC8Y
	aC4XeGBssUd8kvXyd/yP5q8/tCuaf826LefCngtISUgKsF73aZfc9Czl6bb42S8e/PpgveTs
	n2mPPVRe5MQ59LlYb58+c5bLi5YTJsFfHz5IsNzpw7JtcnbVA5/qrU1KV6anrDoc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271023>

Some functions from the refs module were still declared in cache.h.
Move them to refs.h.

Add some parameter names where they were missing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 archive.c               |   1 +
 builtin/blame.c         |   1 +
 builtin/fast-export.c   |   1 +
 builtin/fmt-merge-msg.c |   1 +
 builtin/init-db.c       |   1 +
 builtin/log.c           |   1 +
 cache.h                 |  66 -----------------------
 refs.c                  |   6 ++-
 refs.h                  | 139 +++++++++++++++++++++++++++++++++++++-----------
 remote-testsvn.c        |   1 +
 10 files changed, 118 insertions(+), 100 deletions(-)

diff --git a/archive.c b/archive.c
index d37c41d..936a594 100644
--- a/archive.c
+++ b/archive.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "refs.h"
 #include "commit.h"
 #include "tree-walk.h"
 #include "attr.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index b3e948e..1c998cb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,6 +6,7 @@
  */
 
 #include "cache.h"
+#include "refs.h"
 #include "builtin.h"
 #include "blob.h"
 #include "commit.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b8182c2..d23f3be 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "cache.h"
+#include "refs.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 05f4c26..4ba7f28 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "refs.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4335738..49df78d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "refs.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
diff --git a/builtin/log.c b/builtin/log.c
index e67671e..3caa917 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -5,6 +5,7 @@
  *		 2006 Junio Hamano
  */
 #include "cache.h"
+#include "refs.h"
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/cache.h b/cache.h
index be92121..1c00098 100644
--- a/cache.h
+++ b/cache.h
@@ -1009,76 +1009,10 @@ extern int get_oid_hex(const char *hex, struct object_id *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
-extern int read_ref_full(const char *refname, int resolve_flags,
-			 unsigned char *sha1, int *flags);
-extern int read_ref(const char *refname, unsigned char *sha1);
 
-/*
- * Resolve a reference, recursively following symbolic refererences.
- *
- * Store the referred-to object's name in sha1 and return the name of
- * the non-symbolic reference that ultimately pointed at it.  The
- * return value, if not NULL, is a pointer into either a static buffer
- * or the input ref.
- *
- * If the reference cannot be resolved to an object, the behavior
- * depends on the RESOLVE_REF_READING flag:
- *
- * - If RESOLVE_REF_READING is set, return NULL.
- *
- * - If RESOLVE_REF_READING is not set, clear sha1 and return the name of
- *   the last reference name in the chain, which will either be a non-symbolic
- *   reference or an undefined reference.  If this is a prelude to
- *   "writing" to the ref, the return value is the name of the ref
- *   that will actually be created or changed.
- *
- * If the RESOLVE_REF_NO_RECURSE flag is passed, only resolves one
- * level of symbolic reference.  The value stored in sha1 for a symbolic
- * reference will always be null_sha1 in this case, and the return
- * value is the reference that the symref refers to directly.
- *
- * If flags is non-NULL, set the value that it points to the
- * combination of REF_ISPACKED (if the reference was found among the
- * packed references), REF_ISSYMREF (if the initial reference was a
- * symbolic reference), REF_BAD_NAME (if the reference name is ill
- * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
- * (if the ref is malformed or has a bad name). See refs.h for more detail
- * on each flag.
- *
- * If ref is not a properly-formatted, normalized reference, return
- * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
- * give up and return NULL.
- *
- * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
- * name is invalid according to git-check-ref-format(1).  If the name
- * is bad then the value stored in sha1 will be null_sha1 and the two
- * flags REF_ISBROKEN and REF_BAD_NAME will be set.
- *
- * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
- * directory and do not consist of all caps and underscores cannot be
- * resolved. The function returns NULL for such ref names.
- * Caps and underscores refers to the special refs, such as HEAD,
- * FETCH_HEAD and friends, that all live outside of the refs/ directory.
- */
-#define RESOLVE_REF_READING 0x01
-#define RESOLVE_REF_NO_RECURSE 0x02
-#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
-extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
-extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
-
-extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
-extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
-/*
- * Return true iff abbrev_name is a possible abbreviation for
- * full_name according to the rules defined by ref_rev_parse_rules in
- * refs.c.
- */
-extern int refname_match(const char *abbrev_name, const char *full_name);
-
-extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
diff --git a/refs.c b/refs.c
index 2c4d9ab..30aa2a5 100644
--- a/refs.c
+++ b/refs.c
@@ -1732,9 +1732,11 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags)
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags)
 {
-	return xstrdup_or_null(resolve_ref_unsafe(ref, resolve_flags, sha1, flags));
+	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
+						  sha1, flags));
 }
 
 /* The argument to filter_refs */
diff --git a/refs.h b/refs.h
index cb56662..33c2f76 100644
--- a/refs.h
+++ b/refs.h
@@ -2,6 +2,98 @@
 #define REFS_H
 
 /*
+ * Resolve a reference, recursively following symbolic refererences.
+ *
+ * Store the referred-to object's name in sha1 and return the name of
+ * the non-symbolic reference that ultimately pointed at it.  The
+ * return value, if not NULL, is a pointer into either a static buffer
+ * or the input ref.
+ *
+ * If the reference cannot be resolved to an object, the behavior
+ * depends on the RESOLVE_REF_READING flag:
+ *
+ * - If RESOLVE_REF_READING is set, return NULL.
+ *
+ * - If RESOLVE_REF_READING is not set, clear sha1 and return the name of
+ *   the last reference name in the chain, which will either be a non-symbolic
+ *   reference or an undefined reference.  If this is a prelude to
+ *   "writing" to the ref, the return value is the name of the ref
+ *   that will actually be created or changed.
+ *
+ * If the RESOLVE_REF_NO_RECURSE flag is passed, only resolves one
+ * level of symbolic reference.  The value stored in sha1 for a symbolic
+ * reference will always be null_sha1 in this case, and the return
+ * value is the reference that the symref refers to directly.
+ *
+ * If flags is non-NULL, set the value that it points to the
+ * combination of REF_ISPACKED (if the reference was found among the
+ * packed references), REF_ISSYMREF (if the initial reference was a
+ * symbolic reference), REF_BAD_NAME (if the reference name is ill
+ * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
+ * (if the ref is malformed or has a bad name). See refs.h for more detail
+ * on each flag.
+ *
+ * If ref is not a properly-formatted, normalized reference, return
+ * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
+ * give up and return NULL.
+ *
+ * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
+ * name is invalid according to git-check-ref-format(1).  If the name
+ * is bad then the value stored in sha1 will be null_sha1 and the two
+ * flags REF_ISBROKEN and REF_BAD_NAME will be set.
+ *
+ * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
+ * directory and do not consist of all caps and underscores cannot be
+ * resolved. The function returns NULL for such ref names.
+ * Caps and underscores refers to the special refs, such as HEAD,
+ * FETCH_HEAD and friends, that all live outside of the refs/ directory.
+ */
+#define RESOLVE_REF_READING 0x01
+#define RESOLVE_REF_NO_RECURSE 0x02
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
+
+extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+				      unsigned char *sha1, int *flags);
+
+extern char *resolve_refdup(const char *refname, int resolve_flags,
+			    unsigned char *sha1, int *flags);
+
+extern int read_ref_full(const char *refname, int resolve_flags,
+			 unsigned char *sha1, int *flags);
+extern int read_ref(const char *refname, unsigned char *sha1);
+
+extern int ref_exists(const char *refname);
+
+extern int is_branch(const char *refname);
+
+/*
+ * If refname is a non-symbolic reference that refers to a tag object,
+ * and the tag can be (recursively) dereferenced to a non-tag object,
+ * store the SHA1 of the referred-to object to sha1 and return 0.  If
+ * any of these conditions are not met, return a non-zero value.
+ * Symbolic references are considered unpeelable, even if they
+ * ultimately resolve to a peelable tag.
+ */
+extern int peel_ref(const char *refname, unsigned char *sha1);
+
+/**
+ * Resolve refname in the nested "gitlink" repository that is located
+ * at path.  If the resolution is successful, return 0 and set sha1 to
+ * the name of the object; otherwise, return a non-zero value.
+ */
+extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
+
+/*
+ * Return true iff abbrev_name is a possible abbreviation for
+ * full_name according to the rules defined by ref_rev_parse_rules in
+ * refs.c.
+ */
+extern int refname_match(const char *abbrev_name, const char *full_name);
+
+extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
+extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+
+/*
  * A ref_transaction represents a collection of ref updates
  * that should succeed or fail together.
  *
@@ -78,15 +170,15 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
-extern int head_ref(each_ref_fn, void *);
-extern int for_each_ref(each_ref_fn, void *);
-extern int for_each_ref_in(const char *, each_ref_fn, void *);
-extern int for_each_tag_ref(each_ref_fn, void *);
-extern int for_each_branch_ref(each_ref_fn, void *);
-extern int for_each_remote_ref(each_ref_fn, void *);
-extern int for_each_replace_ref(each_ref_fn, void *);
-extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
-extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
+extern int head_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
+extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char* prefix, void *cb_data);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
@@ -99,14 +191,14 @@ extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn,
 extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
+/* can be used to learn about broken ref and symref */
+extern int for_each_rawref(each_ref_fn fn, void *cb_data);
+
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
 }
 
-/* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn, void *);
-
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
@@ -124,20 +216,6 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
  */
 int pack_refs(unsigned int flags);
 
-extern int ref_exists(const char *);
-
-extern int is_branch(const char *refname);
-
-/*
- * If refname is a non-symbolic reference that refers to a tag object,
- * and the tag can be (recursively) dereferenced to a non-tag object,
- * store the SHA1 of the referred-to object to sha1 and return 0.  If
- * any of these conditions are not met, return a non-zero value.
- * Symbolic references are considered unpeelable, even if they
- * ultimately resolve to a peelable tag.
- */
-extern int peel_ref(const char *refname, unsigned char *sha1);
-
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
@@ -205,17 +283,13 @@ extern int for_each_reflog(each_ref_fn, void *);
 extern int check_refname_format(const char *refname, int flags);
 
 extern const char *prettify_refname(const char *refname);
+
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-/**
- * Resolve refname in the nested "gitlink" repository that is located
- * at path.  If the resolution is successful, return 0 and set sha1 to
- * the name of the object; otherwise, return a non-zero value.
- */
-extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
+extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
@@ -366,6 +440,7 @@ int update_ref(const char *msg, const char *refname,
 	       unsigned int flags, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
+
 extern int ref_is_hidden(const char *);
 
 enum expire_reflog_flags {
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 48bf6eb..f599c37 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "refs.h"
 #include "remote.h"
 #include "strbuf.h"
 #include "url.h"
-- 
2.1.4
