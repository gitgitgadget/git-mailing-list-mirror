Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64303201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbdBVOH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34968 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbdBVOHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:54 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so546938pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPw2zddI3Afmap0N3eiea8UC2/qjIMk4xm9CPyaDDwA=;
        b=OTVk23YFaSkUh1vfzWNCgB+HTUA1cqGLPvzlhFymn+WxqOyIWNQUIflxM7A/5r2yyi
         7v9nkUeY7DI3l3s4Y4iyDajNhwVk+Cb7LUXZtwDiZKEjVJLyjHj1LKRHEeZvd4AD1P2q
         j+p+AofOiwHvraMQ171YW0zxgZR7zP/eC6KGKbh4rKJyr2e+LW8NBB3LhAFnVlkBBAZy
         cAqLAQy1kEZn+6lNUvB/K+hb5ZHtlU9ATSVN4p2EVY0j/dWS5J0/AAPKCgjGV7S2RUTe
         tU0s5ppZJgDWG+5G15ihgaxAelKf06G4xMMFQj7m/O6V69fdTdvneQ3uTJGgwW42KkFm
         aZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPw2zddI3Afmap0N3eiea8UC2/qjIMk4xm9CPyaDDwA=;
        b=UuIUKhDmiBHSt6y7BLjA9tdg7+qWMNVvyAtNSu8uw7pMH71XcPjLmCp0cfDdw7pO4+
         T5f+wZxM1pqH9ZX8rhRlasa8UO2CsDqkrMtcviXnA4QfDqyZ7rCJugywZCWP5Z49oUXc
         D4KRSYPYV5fnGVdLv0qwb0Y1JCMuarAFxA1RGCWyQZJLoVV+d2Zzvxrv3iG0t2FaP03w
         whEQkDjnEP2V3ppobHE9SCgp5M2AaQ9kcKK7XtkizM4gEulLFj/SxezUzx4gJ05QHa91
         hK+yay2stfnwaA/LBMVSsW0XeG3UZGLGFofW37hWdOWOhClRGQABeCnRiTtDfVqA/LTL
         +XLg==
X-Gm-Message-State: AMke39kMEVsRLbecZ9APTh1YnUh3SxEVFJGeKCygaA3L4vLnmWmvDL9OAmev4mq+hJT1hA==
X-Received: by 10.99.98.195 with SMTP id w186mr8171181pgb.223.1487772473073;
        Wed, 22 Feb 2017 06:07:53 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id b83sm4130919pfe.12.2017.02.22.06.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 18/24] refs: add new ref-store api
Date:   Wed, 22 Feb 2017 21:04:44 +0700
Message-Id: <20170222140450.30886-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
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
 refs.c               | 235 +++++++++++++++++++++++++++++++++++++--------------
 refs.h               |  71 ++++++++++++++++
 refs/files-backend.c |  13 +--
 refs/refs-internal.h |  31 +------
 4 files changed, 253 insertions(+), 97 deletions(-)

diff --git a/refs.c b/refs.c
index 7843d3085..9137ac283 100644
--- a/refs.c
+++ b/refs.c
@@ -185,13 +185,20 @@ struct ref_filter {
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
@@ -286,34 +293,52 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
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
@@ -1120,14 +1145,17 @@ const char *find_descendant_ref(const char *dirname,
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
 
@@ -1168,10 +1196,9 @@ int head_ref(each_ref_fn fn, void *cb_data)
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
@@ -1183,19 +1210,30 @@ static int do_for_each_ref(const char *submodule, const char *prefix,
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
@@ -1204,19 +1242,23 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 
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
@@ -1224,19 +1266,25 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
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
@@ -1323,7 +1371,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_main_ref_store(), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1353,7 +1401,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, sha1, &flags) ||
 	    is_null_sha1(sha1))
 		return -1;
 	return 0;
@@ -1511,27 +1559,42 @@ void base_ref_store_init(struct ref_store *refs,
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
@@ -1542,19 +1605,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -1562,43 +1623,84 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -1608,11 +1710,10 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
@@ -1623,16 +1724,24 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
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
index 2efba6ba9..70d4eb87c 100644
--- a/refs.h
+++ b/refs.h
@@ -58,16 +58,47 @@ struct string_list;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1,
+				    int *flags);
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags);
 
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
@@ -84,6 +115,8 @@ extern int refs_init_db(struct strbuf *err);
  * Symbolic references are considered unpeelable, even if they
  * ultimately resolve to a peelable tag.
  */
+int refs_peel_ref(struct ref_store *refs, const char *refname,
+		  unsigned char *sha1);
 int peel_ref(const char *refname, unsigned char *sha1);
 
 /**
@@ -196,6 +229,17 @@ typedef int each_ref_fn(const char *refname,
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
@@ -225,6 +269,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
+int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
@@ -248,6 +293,7 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
  */
+int refs_pack_refs(struct ref_store *refs, unsigned int flags);
 int pack_refs(unsigned int flags);
 
 /*
@@ -263,6 +309,8 @@ int pack_refs(unsigned int flags);
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
+int refs_create_reflog(struct ref_store *refs, const char *refname,
+		       int force_create, struct strbuf *err);
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
@@ -272,6 +320,7 @@ int read_ref_at(const char *refname, unsigned int flags,
 		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
+int refs_reflog_exists(struct ref_store *refs, const char *refname);
 int reflog_exists(const char *refname);
 
 /*
@@ -290,9 +339,12 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
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
@@ -301,6 +353,12 @@ typedef int each_reflog_ent_fn(
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
 
@@ -308,6 +366,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
+int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_reflog(each_ref_fn fn, void *cb_data);
 
 #define REFNAME_ALLOW_ONELEVEL 1
@@ -328,8 +387,12 @@ const char *prettify_refname(const char *refname);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
+int refs_rename_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg);
 int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
+int refs_create_symref(struct ref_store *refs, const char *refname,
+		       const char *target, const char *logmsg);
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
 /*
@@ -551,6 +614,14 @@ typedef void reflog_expiry_cleanup_fn(void *cb_data);
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
index 474d1027c..dafddefd3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1320,7 +1320,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_dir_entry(refs, refname.buf,
 							  refname.len, 1));
 		} else {
-			if (!resolve_ref_recursively(&refs->base,
+			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
 						     sha1, &flag)) {
@@ -1629,7 +1629,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
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
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
-	if (!rename_ref_available(oldrefname, newrefname))
+	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname))
 		return 1;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
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
index f20dde39e..5f26208c2 100644
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

