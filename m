Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4B720966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdCZCoj (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32786 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZCoi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so4697151pgf.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMabCbFvGcc0toZbt5K2zygzy/M9wHHMh0S5qS4eSLk=;
        b=sG3rfd6VushC3RRkNLaxwCCyUWUFj2Fsk2fHWq+QcwCjFqH52NBeiUX+7ik0osNegl
         1Si7KSMLk95duzu8/siRiPfi9IeNxAwxNvXpMTz7K+wQ0Q3K+CrxHuwN2oqbNHYiMYPo
         tLfC/yOzueA+FW6vGF6eQQ7NAikF1bjj188+ceSPYeYaHLhZGHUpUsTuauNa5SLrf7ft
         SMHEKyCAxY+ZwnYLyj4+/7099kxjZMZ9O97R5AzWwNAj7dDNACEwsWgdvUuCHvyGkaW0
         UcjjujJH3JtyvsFgKZOwE3t/lVfyNr8/DlRvuzlpPkxSPDqxTKaaTWZdTQY4hlPrZaiz
         dy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMabCbFvGcc0toZbt5K2zygzy/M9wHHMh0S5qS4eSLk=;
        b=eVpXsdjtQOy2Y4gSQ2DoZciII+67yGjr9b7KaUYTI/V+DQQMd7oMLfsPM6JdMWOZgi
         r7XQR2X05iqI1GfpOKG+shdybq8kzHS+Z8x1jBam8JJhDKa++M+kFvGSVueRt8pxUI5l
         TZttb98Z1MrsMs3eGo/rUgvVSO+pz+HlVImVzQ3bU3riZkoCnui/fVJQ4Zgp3VDlljrM
         SfbE+umOdbNbt4FW/RLPj/DdSCPweK5On7ri1lJjQxf1prSlzpifV93IEM2NyVlk+gKG
         w6JLTd3mBHAYqniGvv+7revJ1qhiRWQSccBXHykZds6k2WqMqpDwnVkz0mWpsJmMnMeM
         SM/Q==
X-Gm-Message-State: AFeK/H3CraJGdOOYUIIH9G9tYpM6LJYU9iyNYGVHuovRO1lK4fBB/rvCq5V0PwzfgdV/iA==
X-Received: by 10.84.131.79 with SMTP id 73mr20179622pld.45.1490496272272;
        Sat, 25 Mar 2017 19:44:32 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id w28sm12800491pfl.115.2017.03.25.19.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:26 +0700
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
Subject: [PATCH v7 16/28] refs.c: make get_main_ref_store() public and use it
Date:   Sun, 26 Mar 2017 09:42:29 +0700
Message-Id: <20170326024241.31984-17-pclouds@gmail.com>
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

get_ref_store() will soon be renamed to get_submodule_ref_store().
Together with future get_worktree_ref_store(), the three functions
provide an appropriate ref store for different operation modes. New APIs
will be added to operate directly on ref stores.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 36 ++++++++++++++++++------------------
 refs.h               |  3 +++
 refs/files-backend.c |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 87f64271ac..1f4c1a2347 100644
--- a/refs.c
+++ b/refs.c
@@ -1314,7 +1314,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->init_db(refs, err);
 }
@@ -1322,7 +1322,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_ref_store(NULL), refname,
+	return resolve_ref_recursively(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1428,7 +1428,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
-static struct ref_store *get_main_ref_store(void)
+struct ref_store *get_main_ref_store(void)
 {
 	if (main_ref_store)
 		return main_ref_store;
@@ -1488,14 +1488,14 @@ void base_ref_store_init(struct ref_store *refs,
 /* backend functions */
 int pack_refs(unsigned int flags)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->pack_refs(refs, flags);
 }
 
 int peel_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->peel_ref(refs, refname, sha1);
 }
@@ -1503,7 +1503,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_symref(refs, ref_target, refs_heads_master,
 				       logmsg);
@@ -1512,7 +1512,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1522,14 +1522,14 @@ int verify_refname_available(const char *refname,
 			     const struct string_list *skip,
 			     struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
 }
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 	struct ref_iterator *iter;
 
 	iter = refs->be->reflog_iterator_begin(refs);
@@ -1540,7 +1540,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent_reverse(refs, refname,
 						     fn, cb_data);
@@ -1549,14 +1549,14 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
 			void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
 }
 
 int reflog_exists(const char *refname)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_exists(refs, refname);
 }
@@ -1564,14 +1564,14 @@ int reflog_exists(const char *refname)
 int safe_create_reflog(const char *refname, int force_create,
 		       struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_reflog(refs, refname, force_create, err);
 }
 
 int delete_reflog(const char *refname)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->delete_reflog(refs, refname);
 }
@@ -1583,7 +1583,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_expire(refs, refname, sha1, flags,
 				       prepare_fn, should_prune_fn,
@@ -1593,21 +1593,21 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
 
 int delete_refs(struct string_list *refnames, unsigned int flags)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->delete_refs(refs, refnames, flags);
 }
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->rename_ref(refs, oldref, newref, logmsg);
 }
diff --git a/refs.h b/refs.h
index 2d6b6263fc..a6cd12267f 100644
--- a/refs.h
+++ b/refs.h
@@ -2,6 +2,7 @@
 #define REFS_H
 
 struct object_id;
+struct ref_store;
 struct strbuf;
 struct string_list;
 
@@ -560,4 +561,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 int ref_storage_backend_exists(const char *name);
 
+struct ref_store *get_main_ref_store(void);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9676cd32e4..b62f374f9c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3163,7 +3163,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target, const char
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
+		files_downcast(get_main_ref_store(), 0, "set_head_symref");
 
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
-- 
2.11.0.157.gd943d85

