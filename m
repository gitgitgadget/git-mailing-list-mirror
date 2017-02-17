Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEAB20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934167AbdBQOGQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32853 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934043AbdBQOGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:06:15 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so5045585pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6Ug8uewcVCHD+71rHLd8lVtElm/mDCIMGUDTfs4WyU=;
        b=iikLTbygKt8WT/meZrGpw/EpCa+/GI/+HWABQbmghu894017hQu0E61MqVBQ2s9KW3
         fc7wR20O1ORFRvGA+pYAxVppAE7Mr40bx2Ug7WcmeVfDqPwlvaXxpZNfnfATygGm+9Oh
         cOnUjD1Jdf+H6blzq0hpK4GcSk5zlG2vJ4Gj6yMCSt8xznOHlDUTgQ+YsPXazf53dwTR
         Di3vl0YQNELZ3UeJyb52NBz4Gx9M54AVo0sFj4eIO5SwiaUGCjXsya/hKeSFD3T5YgvO
         BS6uXn1At881BKXYSEP1prjgT3y5yDMXzYS/kYycrR3nCaVXx7M3iEqM0+6BgaaT7Fkv
         rnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6Ug8uewcVCHD+71rHLd8lVtElm/mDCIMGUDTfs4WyU=;
        b=FvHvu2+wbSV/5EvWexWNwAMDHScLzqOL0LXhhLheP8l5WW4Ml83VDthDkFL56MiO98
         42VNI+yPdfuWIzS6iNW4kd7vG3orbORSxpUgR+S5dd1IO6I+RqXYJKsdZG+fkDjbXJtK
         pPPc7seIQf+efHUOZb6ReIIr2InCr82ZkAmtwAai1wDnqbTEpM0K+rVTuuUWWTA1vgvk
         K9S0m6DpwbsF1Ut7x7IWyo2JY3zSDzbujVezo0R4/fQMziwzSJ/alnY7KtSpDnhWIlbh
         ekAT2LO+JvzBx4t1fyUiJLydzjITt46xeQ/YW0bdp/tGfww/UTx79pKdw4hPrEFn2Qd/
         X30w==
X-Gm-Message-State: AMke39lJTKPl1jxTpo56JXVcrH6gSI5Moylmpm2tqoItsoSs6N8QyztNKP9gMr+VEEVeMg==
X-Received: by 10.99.94.195 with SMTP id s186mr10395182pgb.198.1487340374405;
        Fri, 17 Feb 2017 06:06:14 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id u28sm20206495pgo.20.2017.02.17.06.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:06:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:06:09 +0700
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
Subject: [PATCH v3 12/16] refs.c: make get_main_ref_store() public and use it
Date:   Fri, 17 Feb 2017 21:04:32 +0700
Message-Id: <20170217140436.17336-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
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
 refs.c | 36 ++++++++++++++++++------------------
 refs.h |  2 ++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 55a80a83d..25f657a6f 100644
--- a/refs.c
+++ b/refs.c
@@ -1303,7 +1303,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->init_db(refs, err);
 }
@@ -1311,7 +1311,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_ref_store(NULL), refname,
+	return resolve_ref_recursively(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1434,7 +1434,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
-static struct ref_store *get_main_ref_store(void)
+struct ref_store *get_main_ref_store(void)
 {
 	struct ref_store *refs;
 
@@ -1483,14 +1483,14 @@ void base_ref_store_init(struct ref_store *refs,
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
@@ -1498,7 +1498,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_symref(refs, ref_target, refs_heads_master,
 				       logmsg);
@@ -1507,7 +1507,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1517,14 +1517,14 @@ int verify_refname_available(const char *refname,
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
@@ -1535,7 +1535,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent_reverse(refs, refname,
 						     fn, cb_data);
@@ -1544,14 +1544,14 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
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
@@ -1559,14 +1559,14 @@ int reflog_exists(const char *refname)
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
@@ -1578,7 +1578,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_expire(refs, refname, sha1, flags,
 				       prepare_fn, should_prune_fn,
@@ -1588,21 +1588,21 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 694784391..f803528fc 100644
--- a/refs.h
+++ b/refs.h
@@ -553,4 +553,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 int ref_storage_backend_exists(const char *name);
 
+struct ref_store *get_main_ref_store(void);
+
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

