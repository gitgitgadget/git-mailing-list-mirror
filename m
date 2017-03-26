Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF98E20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdCZCpb (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35087 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdCZCp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id n11so4066876pfg.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHOByZsVlbR/FJoSCV5rX3gTa5cYMhZo+VhKeUuOFyE=;
        b=PVf89l8ainLQdYvDZaTshwnvNH7WHQhbLVYKM5M+wB5B3LbWEbMTXVZfBF+0ylt2Pu
         ZWnIyEctt9pWjgy2M8OThWP8iyGNamyhFlBsZwYgfQgDOGEovZcjuvQjoOIsjKpVGRhk
         XcYbIKaaUPVxjOOkze8PJ3nI2b5PQrDxJt7MC/gTpwGPYenGXtHR/2GkNmSZ0gAKSQWq
         /0lO9pJFtaKjhXUppk/6UunEwUXqCkHXej2EueUeyqemomvLFKOwjNO6rYZG7Dmfjtul
         0alkUazAX9bzSwkIowXLHQcEioJXyiR4gthrcqIAcFpRthhYAfBh3aSvVi5iU+VaOyFN
         +4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHOByZsVlbR/FJoSCV5rX3gTa5cYMhZo+VhKeUuOFyE=;
        b=A1uiI64lOyrlLZQQSSIW+PxsSOujIVUvR434KQRskSwT0gVQpsP3SC2S7dMrY2ZTmW
         wzokHUNqzFI1uO0tHItOOuOjYXBxmHnxCOhReg13XsbQthiqMHlX2z3Lt9aZoguI8AeV
         t+tm/0jmLiqnQJLYVi93euSLHZ3CEZOO6BcAxXrCXywbr3ZbkPvBEACtCACr9ujXnKc1
         80j/UUGNUkhGhZ75CSNLX9S70LGmMqasfVWW7ZsPBq1Npi/LNxjuxP2j0mE+nT5oPrY5
         aZ05sQOxY5hLlVot0rggrP2R5iH6NZTisGrpza72+gPzgI9BxuSlBbFxd+w2C4JsnEgZ
         vVkg==
X-Gm-Message-State: AFeK/H1kLVD9FQArv+x+iR3h4IjbdsZYeWyud8Jm0TmjrDYbL9EE1ZRGVrGExlU4FA3PqA==
X-Received: by 10.98.208.65 with SMTP id p62mr17390238pfg.239.1490496304240;
        Sat, 25 Mar 2017 19:45:04 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id j19sm12843640pfk.4.2017.03.25.19.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 21/28] refs: add new ref-store api
Date:   Sun, 26 Mar 2017 09:42:34 +0700
Message-Id: <20170326024241.31984-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not meant to cover all existing API. It adds enough to test ref
stores with the new test program test-ref-store, coming soon and to be
used by files-backend.c.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 251 ++++++++++++++++++++++++++++++++++++++-------------
 refs.h               |  74 +++++++++++++++
 refs/files-backend.c |  13 +--
 refs/refs-internal.h |  31 +------
 4 files changed, 270 insertions(+), 99 deletions(-)

diff --git a/refs.c b/refs.c
index 100a925bcc..c103f90b35 100644
--- a/refs.c
+++ b/refs.c
@@ -171,11 +171,23 @@ int refname_is_safe(const char *refname)
 	return 1;
 }
 
+char *refs_resolve_refdup(struct ref_store *refs,
+			  const char *refname, int resolve_flags,
+			  unsigned char *sha1, int *flags)
+{
+	const char *result;
+
+	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+					 sha1, flags);
+	return xstrdup_or_null(result);
+}
+
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     unsigned char *sha1, int *flags)
 {
-	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
-						  sha1, flags));
+	return refs_resolve_refdup(get_main_ref_store(),
+				   refname, resolve_flags,
+				   sha1, flags);
 }
 
 /* The argument to filter_refs */
@@ -185,13 +197,20 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+int refs_read_ref_full(struct ref_store *refs, const char *refname,
+		       int resolve_flags, unsigned char *sha1, int *flags)
 {
-	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
+	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, sha1, flags))
 		return 0;
 	return -1;
 }
 
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
+{
+	return refs_read_ref_full(get_main_ref_store(), refname,
+				  resolve_flags, sha1, flags);
+}
+
 int read_ref(const char *refname, unsigned char *sha1)
 {
 	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
@@ -286,34 +305,52 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
+int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
+}
+
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/tags/", fn, cb_data);
+	return refs_for_each_tag_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
+	return refs_for_each_tag_ref(get_submodule_ref_store(submodule),
+				     fn, cb_data);
+}
+
+int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/heads/", fn, cb_data);
+	return refs_for_each_branch_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
+	return refs_for_each_branch_ref(get_submodule_ref_store(submodule),
+					fn, cb_data);
+}
+
+int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/remotes/", fn, cb_data);
+	return refs_for_each_remote_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
+	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
+					fn, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -1120,14 +1157,17 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int rename_ref_available(const char *old_refname, const char *new_refname)
+int refs_rename_ref_available(struct ref_store *refs,
+			      const char *old_refname,
+			      const char *new_refname)
 {
 	struct string_list skip = STRING_LIST_INIT_NODUP;
 	struct strbuf err = STRBUF_INIT;
 	int ok;
 
 	string_list_insert(&skip, old_refname);
-	ok = !verify_refname_available(new_refname, NULL, &skip, &err);
+	ok = !refs_verify_refname_available(refs, new_refname,
+					    NULL, &skip, &err);
 	if (!ok)
 		error("%s", err.buf);
 
@@ -1168,10 +1208,9 @@ int head_ref(each_ref_fn fn, void *cb_data)
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
  */
-static int do_for_each_ref(const char *submodule, const char *prefix,
+static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
-	struct ref_store *refs = get_submodule_ref_store(submodule);
 	struct ref_iterator *iter;
 
 	if (!refs)
@@ -1183,19 +1222,30 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
 
+int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
+	return refs_for_each_ref(get_main_ref_store(), fn, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, "", fn, 0, 0, cb_data);
+	return refs_for_each_ref(get_submodule_ref_store(submodule), fn, cb_data);
+}
+
+int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
+			 each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(), prefix, fn, cb_data);
 }
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
@@ -1204,19 +1254,23 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(NULL, prefix, fn, 0, flag, cb_data);
+	return do_for_each_ref(get_main_ref_store(),
+			       prefix, fn, 0, flag, cb_data);
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
+			      each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
+	return refs_for_each_ref_in(get_submodule_ref_store(submodule),
+				    prefix, fn, cb_data);
 }
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base), 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(),
+			       git_replace_ref_base, fn,
+			       strlen(git_replace_ref_base),
+			       0, cb_data);
 }
 
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
@@ -1224,19 +1278,25 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref(get_main_ref_store(),
+			      buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0,
+	return do_for_each_ref(refs, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_rawref(get_main_ref_store(), fn, cb_data);
+}
+
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_recursively(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    unsigned char *sha1, int *flags)
@@ -1323,7 +1383,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_main_ref_store(), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1353,7 +1413,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, sha1, &flags) ||
 	    is_null_sha1(sha1))
 		return -1;
 	return 0;
@@ -1506,27 +1566,42 @@ void base_ref_store_init(struct ref_store *refs,
 }
 
 /* backend functions */
+int refs_pack_refs(struct ref_store *refs, unsigned int flags)
+{
+	return refs->be->pack_refs(refs, flags);
+}
+
 int pack_refs(unsigned int flags)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_pack_refs(get_main_ref_store(), flags);
+}
 
-	return refs->be->pack_refs(refs, flags);
+int refs_peel_ref(struct ref_store *refs, const char *refname,
+		  unsigned char *sha1)
+{
+	return refs->be->peel_ref(refs, refname, sha1);
 }
 
 int peel_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_peel_ref(get_main_ref_store(), refname, sha1);
+}
 
-	return refs->be->peel_ref(refs, refname, sha1);
+int refs_create_symref(struct ref_store *refs,
+		       const char *ref_target,
+		       const char *refs_heads_master,
+		       const char *logmsg)
+{
+	return refs->be->create_symref(refs, ref_target,
+				       refs_heads_master,
+				       logmsg);
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_main_ref_store();
-
-	return refs->be->create_symref(refs, ref_target, refs_heads_master,
-				       logmsg);
+	return refs_create_symref(get_main_ref_store(), ref_target,
+				  refs_heads_master, logmsg);
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
@@ -1537,19 +1612,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return refs->be->transaction_commit(refs, transaction, err);
 }
 
-int verify_refname_available(const char *refname,
-			     const struct string_list *extra,
-			     const struct string_list *skip,
-			     struct strbuf *err)
+int refs_verify_refname_available(struct ref_store *refs,
+				  const char *refname,
+				  const struct string_list *extra,
+				  const struct string_list *skip,
+				  struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
-
 	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	struct ref_store *refs = get_main_ref_store();
 	struct ref_iterator *iter;
 
 	iter = refs->be->reflog_iterator_begin(refs);
@@ -1557,43 +1630,84 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
-				void *cb_data)
+int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_for_each_reflog(get_main_ref_store(), fn, cb_data);
+}
 
+int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
+				     const char *refname,
+				     each_reflog_ent_fn fn,
+				     void *cb_data)
+{
 	return refs->be->for_each_reflog_ent_reverse(refs, refname,
 						     fn, cb_data);
 }
 
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
+				void *cb_data)
+{
+	return refs_for_each_reflog_ent_reverse(get_main_ref_store(),
+						refname, fn, cb_data);
+}
+
+int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
+			     each_reflog_ent_fn fn, void *cb_data)
+{
+	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
+}
+
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
 			void *cb_data)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_for_each_reflog_ent(get_main_ref_store(), refname,
+					fn, cb_data);
+}
 
-	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
+int refs_reflog_exists(struct ref_store *refs, const char *refname)
+{
+	return refs->be->reflog_exists(refs, refname);
 }
 
 int reflog_exists(const char *refname)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_reflog_exists(get_main_ref_store(), refname);
+}
 
-	return refs->be->reflog_exists(refs, refname);
+int refs_create_reflog(struct ref_store *refs, const char *refname,
+		       int force_create, struct strbuf *err)
+{
+	return refs->be->create_reflog(refs, refname, force_create, err);
 }
 
 int safe_create_reflog(const char *refname, int force_create,
 		       struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_create_reflog(get_main_ref_store(), refname,
+				  force_create, err);
+}
 
-	return refs->be->create_reflog(refs, refname, force_create, err);
+int refs_delete_reflog(struct ref_store *refs, const char *refname)
+{
+	return refs->be->delete_reflog(refs, refname);
 }
 
 int delete_reflog(const char *refname)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_delete_reflog(get_main_ref_store(), refname);
+}
 
-	return refs->be->delete_reflog(refs, refname);
+int refs_reflog_expire(struct ref_store *refs,
+		       const char *refname, const unsigned char *sha1,
+		       unsigned int flags,
+		       reflog_expiry_prepare_fn prepare_fn,
+		       reflog_expiry_should_prune_fn should_prune_fn,
+		       reflog_expiry_cleanup_fn cleanup_fn,
+		       void *policy_cb_data)
+{
+	return refs->be->reflog_expire(refs, refname, sha1, flags,
+				       prepare_fn, should_prune_fn,
+				       cleanup_fn, policy_cb_data);
 }
 
 int reflog_expire(const char *refname, const unsigned char *sha1,
@@ -1603,11 +1717,10 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	struct ref_store *refs = get_main_ref_store();
-
-	return refs->be->reflog_expire(refs, refname, sha1, flags,
-				       prepare_fn, should_prune_fn,
-				       cleanup_fn, policy_cb_data);
+	return refs_reflog_expire(get_main_ref_store(),
+				  refname, sha1, flags,
+				  prepare_fn, should_prune_fn,
+				  cleanup_fn, policy_cb_data);
 }
 
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
@@ -1618,16 +1731,24 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
 
-int delete_refs(struct string_list *refnames, unsigned int flags)
+int refs_delete_refs(struct ref_store *refs, struct string_list *refnames,
+		     unsigned int flags)
 {
-	struct ref_store *refs = get_main_ref_store();
-
 	return refs->be->delete_refs(refs, refnames, flags);
 }
 
-int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+int delete_refs(struct string_list *refnames, unsigned int flags)
 {
-	struct ref_store *refs = get_main_ref_store();
+	return refs_delete_refs(get_main_ref_store(), refnames, flags);
+}
 
+int refs_rename_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg)
+{
 	return refs->be->rename_ref(refs, oldref, newref, logmsg);
 }
+
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
+}
diff --git a/refs.h b/refs.h
index e6d8f67895..eaa31e8193 100644
--- a/refs.h
+++ b/refs.h
@@ -57,16 +57,50 @@ struct string_list;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1,
+				    int *flags);
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags);
 
+char *refs_resolve_refdup(struct ref_store *refs,
+			  const char *refname, int resolve_flags,
+			  unsigned char *sha1, int *flags);
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     unsigned char *sha1, int *flags);
 
+int refs_read_ref_full(struct ref_store *refs, const char *refname,
+		       int resolve_flags, unsigned char *sha1, int *flags);
 int read_ref_full(const char *refname, int resolve_flags,
 		  unsigned char *sha1, int *flags);
 int read_ref(const char *refname, unsigned char *sha1);
 
+/*
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference. Otherwise,
+ * return a negative value and write an explanation to err. If extras
+ * is non-NULL, it is a list of additional refnames with which refname
+ * is not allowed to conflict. If skip is non-NULL, ignore potential
+ * conflicts with refs in skip (e.g., because they are scheduled for
+ * deletion in the same operation). Behavior is undefined if the same
+ * name is listed in both extras and skip.
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ *
+ * extras and skip must be sorted.
+ */
+
+int refs_verify_refname_available(struct ref_store *refs,
+				  const char *refname,
+				  const struct string_list *extra,
+				  const struct string_list *skip,
+				  struct strbuf *err);
+
 int ref_exists(const char *refname);
 
 int should_autocreate_reflog(const char *refname);
@@ -83,6 +117,8 @@ extern int refs_init_db(struct strbuf *err);
  * Symbolic references are considered unpeelable, even if they
  * ultimately resolve to a peelable tag.
  */
+int refs_peel_ref(struct ref_store *refs, const char *refname,
+		  unsigned char *sha1);
 int peel_ref(const char *refname, unsigned char *sha1);
 
 /**
@@ -196,6 +232,17 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
+int refs_for_each_ref(struct ref_store *refs,
+		      each_ref_fn fn, void *cb_data);
+int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
+			 each_ref_fn fn, void *cb_data);
+int refs_for_each_tag_ref(struct ref_store *refs,
+			  each_ref_fn fn, void *cb_data);
+int refs_for_each_branch_ref(struct ref_store *refs,
+			     each_ref_fn fn, void *cb_data);
+int refs_for_each_remote_ref(struct ref_store *refs,
+			     each_ref_fn fn, void *cb_data);
+
 int head_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
@@ -225,6 +272,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
+int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
@@ -248,6 +296,7 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
  */
+int refs_pack_refs(struct ref_store *refs, unsigned int flags);
 int pack_refs(unsigned int flags);
 
 /*
@@ -263,6 +312,8 @@ int pack_refs(unsigned int flags);
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
+int refs_create_reflog(struct ref_store *refs, const char *refname,
+		       int force_create, struct strbuf *err);
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
@@ -272,6 +323,7 @@ int read_ref_at(const char *refname, unsigned int flags,
 		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
+int refs_reflog_exists(struct ref_store *refs, const char *refname);
 int reflog_exists(const char *refname);
 
 /*
@@ -290,9 +342,12 @@ int delete_ref(const char *msg, const char *refname,
  * an all-or-nothing transaction). flags is passed through to
  * ref_transaction_delete().
  */
+int refs_delete_refs(struct ref_store *refs, struct string_list *refnames,
+		     unsigned int flags);
 int delete_refs(struct string_list *refnames, unsigned int flags);
 
 /** Delete a reflog */
+int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
 /* iterate over reflog entries */
@@ -301,6 +356,12 @@ typedef int each_reflog_ent_fn(
 		const char *committer, unsigned long timestamp,
 		int tz, const char *msg, void *cb_data);
 
+int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
+			     each_reflog_ent_fn fn, void *cb_data);
+int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
+				     const char *refname,
+				     each_reflog_ent_fn fn,
+				     void *cb_data);
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
@@ -308,6 +369,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
+int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_reflog(each_ref_fn fn, void *cb_data);
 
 #define REFNAME_ALLOW_ONELEVEL 1
@@ -328,8 +390,12 @@ const char *prettify_refname(const char *refname);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
+int refs_rename_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg);
 int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
+int refs_create_symref(struct ref_store *refs, const char *refname,
+		       const char *target, const char *logmsg);
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
 /*
@@ -552,6 +618,14 @@ typedef void reflog_expiry_cleanup_fn(void *cb_data);
  * enum expire_reflog_flags. The three function pointers are described
  * above. On success, return zero.
  */
+int refs_reflog_expire(struct ref_store *refs,
+		       const char *refname,
+		       const unsigned char *sha1,
+		       unsigned int flags,
+		       reflog_expiry_prepare_fn prepare_fn,
+		       reflog_expiry_should_prune_fn should_prune_fn,
+		       reflog_expiry_cleanup_fn cleanup_fn,
+		       void *policy_cb_data);
 int reflog_expire(const char *refname, const unsigned char *sha1,
 		  unsigned int flags,
 		  reflog_expiry_prepare_fn prepare_fn,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d97a924860..dec8540a0f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1314,7 +1314,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_dir_entry(refs, refname.buf,
 							  refname.len, 1));
 		} else {
-			if (!resolve_ref_recursively(&refs->base,
+			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
 						     sha1, &flag)) {
@@ -1623,7 +1623,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 * another reference such as "refs/foo". There is no
 		 * reason to expect this error to be transitory.
 		 */
-		if (verify_refname_available(refname, extras, skip, err)) {
+		if (refs_verify_refname_available(&refs->base, refname,
+						  extras, skip, err)) {
 			if (mustexist) {
 				/*
 				 * To the user the relevant error is
@@ -2671,7 +2672,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			    oldrefname);
 		goto out;
 	}
-	if (!rename_ref_available(oldrefname, newrefname)) {
+	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
 		ret = 1;
 		goto out;
 	}
@@ -4055,9 +4056,9 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
-		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
-					     err)) {
+		if (refs_verify_refname_available(&refs->base, update->refname,
+						  &affected_refnames, NULL,
+						  err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f20dde39ee..5f26208c2c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -112,28 +112,6 @@ enum peel_status {
 enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
 
 /*
- * Return 0 if a reference named refname could be created without
- * conflicting with the name of an existing reference. Otherwise,
- * return a negative value and write an explanation to err. If extras
- * is non-NULL, it is a list of additional refnames with which refname
- * is not allowed to conflict. If skip is non-NULL, ignore potential
- * conflicts with refs in skip (e.g., because they are scheduled for
- * deletion in the same operation). Behavior is undefined if the same
- * name is listed in both extras and skip.
- *
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- *
- * extras and skip must be sorted.
- */
-int verify_refname_available(const char *newname,
-			     const struct string_list *extras,
-			     const struct string_list *skip,
-			     struct strbuf *err);
-
-/*
  * Copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
  * because reflog file is one line per entry.
@@ -252,7 +230,9 @@ const char *find_descendant_ref(const char *dirname,
  * processes (though rename_ref() catches some races that might get by
  * this check).
  */
-int rename_ref_available(const char *old_refname, const char *new_refname);
+int refs_rename_ref_available(struct ref_store *refs,
+			      const char *old_refname,
+			      const char *new_refname);
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define SYMREF_MAXDEPTH 5
@@ -646,9 +626,4 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
-const char *resolve_ref_recursively(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    unsigned char *sha1, int *flags);
-
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.11.0.157.gd943d85

