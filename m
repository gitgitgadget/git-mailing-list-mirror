Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E611FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbcFREPb (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52495 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbcFREP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:29 -0400
X-AuditID: 12074414-63fff700000008e6-c0-5764cadf0e21
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 10.B9.02278.FDAC4675; Sat, 18 Jun 2016 00:15:27 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJc029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:26 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/13] refs: remove unnecessary "extern" keywords
Date:	Sat, 18 Jun 2016 06:15:07 +0200
Message-Id: <1354c9b2ded11a2bc24e04b98268a5969b44c666.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHv/VEq4wa0WU4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGcc//qPseB3QsX9pUtZGhj3BnQx
	cnJICJhInH3Qz9bFyMUhJLCVUWJn/3lGCOckk8S/w0dYQKrYBHQlFvU0M4HYIgIREg2vWsCK
	mAXmMEncftjJ3MXIwSEs4CLxsCEaxGQRUJVousINUs4rECXxet1kdohlchKXpz9gA7E5BSwk
	FmzZxwRSLiRgLrF3seEERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3
	MUICTmQH45GTcocYBTgYlXh4A+xTwoVYE8uKK3MPMUpyMCmJ8l6pBArxJeWnVGYkFmfEF5Xm
	pBYfYpTgYFYS4d1yAijHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTB
	u/QkUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KPzji4ERAJLiAdq7CaSdt7gg
	MRcoCtF6ilGXY96kXceYhFjy8vNSpcR5F4AcJwBSlFGaB7cCll5eMYoDfSzM+wJkFA8wNcFN
	egW0hAloiea8ZJAlJYkIKakGxuIs3vrQ45+PyaWVz9Y7q17tdtI1t3dH/namVvvw44+flCxg
	d+CNjdhbpbLGedHtj2pvbLwr43JuTuc6mr2z7vb1n/IFVgbJoVtN3t6dsMNtn/PSgt+T1rjO
	1ptt3qGUvG1m8hu5XzN9eSL+dsy5YvhMaGucr9qehzFHFi2uOMP7pWLarmJJJSWW4oxEQy3m
	ouJEAO8jBskKAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There's continuing work in this area, so clean up unneeded "extern"
keywords rather than schlepping them around. Also split up some overlong
lines and add parameter names in a couple of places.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 132 +++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 72 insertions(+), 60 deletions(-)

diff --git a/refs.h b/refs.h
index 9230d47..21874f0 100644
--- a/refs.h
+++ b/refs.h
@@ -52,19 +52,19 @@
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
-extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-				      unsigned char *sha1, int *flags);
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags);
 
-extern char *resolve_refdup(const char *refname, int resolve_flags,
-			    unsigned char *sha1, int *flags);
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags);
 
-extern int read_ref_full(const char *refname, int resolve_flags,
-			 unsigned char *sha1, int *flags);
-extern int read_ref(const char *refname, unsigned char *sha1);
+int read_ref_full(const char *refname, int resolve_flags,
+		  unsigned char *sha1, int *flags);
+int read_ref(const char *refname, unsigned char *sha1);
 
-extern int ref_exists(const char *refname);
+int ref_exists(const char *refname);
 
-extern int is_branch(const char *refname);
+int is_branch(const char *refname);
 
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
@@ -74,24 +74,25 @@ extern int is_branch(const char *refname);
  * Symbolic references are considered unpeelable, even if they
  * ultimately resolve to a peelable tag.
  */
-extern int peel_ref(const char *refname, unsigned char *sha1);
+int peel_ref(const char *refname, unsigned char *sha1);
 
 /**
  * Resolve refname in the nested "gitlink" repository that is located
  * at path.  If the resolution is successful, return 0 and set sha1 to
  * the name of the object; otherwise, return a non-zero value.
  */
-extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
  * full_name according to the rules defined by ref_rev_parse_rules in
  * refs.c.
  */
-extern int refname_match(const char *abbrev_name, const char *full_name);
+int refname_match(const char *abbrev_name, const char *full_name);
 
-extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
-extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
+int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
 /*
  * A ref_transaction represents a collection of ref updates
@@ -182,38 +183,45 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
-extern int head_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
-extern int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken);
-extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
-extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
+int head_ref(each_ref_fn fn, void *cb_data);
+int for_each_ref(each_ref_fn fn, void *cb_data);
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
+			unsigned int broken);
+int for_each_tag_ref(each_ref_fn fn, void *cb_data);
+int for_each_branch_ref(each_ref_fn fn, void *cb_data);
+int for_each_remote_ref(each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(each_ref_fn fn, void *cb_data);
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+			 const char *prefix, void *cb_data);
 
-extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+int for_each_ref_submodule(const char *submodule,
+			   each_ref_fn fn, void *cb_data);
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data);
-extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+int for_each_tag_ref_submodule(const char *submodule,
+			       each_ref_fn fn, void *cb_data);
+int for_each_branch_ref_submodule(const char *submodule,
+				  each_ref_fn fn, void *cb_data);
+int for_each_remote_ref_submodule(const char *submodule,
+				  each_ref_fn fn, void *cb_data);
 
-extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+int head_ref_namespaced(each_ref_fn fn, void *cb_data);
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn fn, void *cb_data);
+int for_each_rawref(each_ref_fn fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
 }
 
-extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
-extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
+void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
+			   const struct string_list *refnames);
 
 /*
  * Flags for controlling behaviour of pack_refs()
@@ -245,13 +253,13 @@ int pack_refs(unsigned int flags);
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *refname, unsigned int flags,
-		       unsigned long at_time, int cnt,
-		       unsigned char *sha1, char **msg,
-		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+int read_ref_at(const char *refname, unsigned int flags,
+		unsigned long at_time, int cnt,
+		unsigned char *sha1, char **msg,
+		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
-extern int reflog_exists(const char *refname);
+int reflog_exists(const char *refname);
 
 /*
  * Delete the specified reference. If old_sha1 is non-NULL, then
@@ -260,21 +268,25 @@ extern int reflog_exists(const char *refname);
  * exists, regardless of its old value. It is an error for old_sha1 to
  * be NULL_SHA1. flags is passed through to ref_transaction_delete().
  */
-extern int delete_ref(const char *refname, const unsigned char *old_sha1,
-		      unsigned int flags);
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags);
 
 /*
  * Delete the specified references. If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
  * an all-or-nothing transaction).
  */
-extern int delete_refs(struct string_list *refnames);
+int delete_refs(struct string_list *refnames);
 
 /** Delete a reflog */
-extern int delete_reflog(const char *refname);
+int delete_reflog(const char *refname);
 
 /* iterate over reflog entries */
-typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
+typedef int each_reflog_ent_fn(
+		unsigned char *old_sha1, unsigned char *new_sha1,
+		const char *committer, unsigned long timestamp,
+		int tz, const char *msg, void *cb_data);
+
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
@@ -282,7 +294,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
-extern int for_each_reflog(each_ref_fn, void *);
+int for_each_reflog(each_ref_fn fn, void *cb_data);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
@@ -295,16 +307,16 @@ extern int for_each_reflog(each_ref_fn, void *);
  * allow a single "*" wildcard character in the refspec. No leading or
  * repeated slashes are accepted.
  */
-extern int check_refname_format(const char *refname, int flags);
+int check_refname_format(const char *refname, int flags);
 
-extern const char *prettify_refname(const char *refname);
+const char *prettify_refname(const char *refname);
 
-extern char *shorten_unambiguous_ref(const char *refname, int strict);
+char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
+int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-extern int create_symref(const char *refname, const char *target, const char *logmsg);
+int create_symref(const char *refname, const char *target, const char *logmsg);
 
 /*
  * Update HEAD of the specified gitdir.
@@ -313,7 +325,7 @@ extern int create_symref(const char *refname, const char *target, const char *lo
  * $GIT_DIR points to.
  * Return 0 if successful, non-zero otherwise.
  * */
-extern int set_worktree_head_symref(const char *gitdir, const char *target);
+int set_worktree_head_symref(const char *gitdir, const char *target);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
@@ -463,7 +475,7 @@ int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr);
 
-extern int parse_hide_refs_config(const char *var, const char *value, const char *);
+int parse_hide_refs_config(const char *var, const char *value, const char *);
 
 /*
  * Check whether a ref is hidden. If no namespace is set, both the first and
@@ -473,7 +485,7 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
  * the ref is outside that namespace, the first parameter is NULL. The second
  * parameter always points to the full ref name.
  */
-extern int ref_is_hidden(const char *, const char *);
+int ref_is_hidden(const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,
@@ -522,11 +534,11 @@ typedef void reflog_expiry_cleanup_fn(void *cb_data);
  * enum expire_reflog_flags. The three function pointers are described
  * above. On success, return zero.
  */
-extern int reflog_expire(const char *refname, const unsigned char *sha1,
-			 unsigned int flags,
-			 reflog_expiry_prepare_fn prepare_fn,
-			 reflog_expiry_should_prune_fn should_prune_fn,
-			 reflog_expiry_cleanup_fn cleanup_fn,
-			 void *policy_cb_data);
+int reflog_expire(const char *refname, const unsigned char *sha1,
+		  unsigned int flags,
+		  reflog_expiry_prepare_fn prepare_fn,
+		  reflog_expiry_should_prune_fn should_prune_fn,
+		  reflog_expiry_cleanup_fn cleanup_fn,
+		  void *policy_cb_data);
 
 #endif /* REFS_H */
-- 
2.8.1

