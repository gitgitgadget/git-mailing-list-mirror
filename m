Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D484C201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbdBRNen (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33343 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdBRNem (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:42 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so7375519pgj.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Viy1djsCv1oQrnEvtFb7OKcSm7epNdOk0mnQKXP6DD8=;
        b=lmQDl6oMvHQWRj+vOSEk6B+cEUHoIe5glyIIPaACCWVYEjYADYluI2Ps1wJlja1ljt
         Bfm/1R5X++qqkuWebnnDnvnw6RzsVEeAJSvdAf6wWOCFZQtca8Bf3aNr69akiv1t3WfN
         djI9FAg+3Q+S28r54L1YnQUID6bPTqMO0VOc1Rl8dwbvczWySqCwHe7cAiSv3WDnl0dO
         BSJE6GIIWYGR1jSuJEEO0yI2tonHCTAEpoZS/A1oryZVBntG9buubCiBmvV7yDfqm/kZ
         TiHGOpD3E3YnsHWp0mC9TULqjqq9pgPKsboWcD2/z0EIn+jBkow6D5ADnxIZOmOvIVhj
         C85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Viy1djsCv1oQrnEvtFb7OKcSm7epNdOk0mnQKXP6DD8=;
        b=rXCSB5lzAEw17yTBwLgN5+CGkjjpN0NeFk01sJFK6tJnB+/MSgUzr3a11q3PbZtFLA
         DKDS/qTs/jWanrqSo2qAdePRdKSKrVaJj9lqjLAKNOwtZhxEdMGp5qEcBuAMJhg8mJI1
         Ycn6xvKMrDZ8/R22WNpG499Ov3Qk9jjS0fdH0D4M1gy/WFdGOlVDlXPG0YjMreTrVCQq
         xGi1J4bylXMBM7BndZFlz3pCljNB0OiBlb1I5aCdnCfTuC/+jPSZRwEapOjlhlwvZAvR
         1jGkB45G0DrGNTlyTn6YVHcE2lc55uXrqCY1yLNqsPmeg0IBMBwlRKzDBZOhcrbxKjJX
         +IkA==
X-Gm-Message-State: AMke39klN51X9j4YBJAh0Vk5o9/yt18GGVy4if87Yxf22HmT6Jb+bkw9jjG/UTzDH47mVg==
X-Received: by 10.84.129.132 with SMTP id b4mr18215905plb.54.1487424881086;
        Sat, 18 Feb 2017 05:34:41 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id c64sm25491712pfa.45.2017.02.18.05.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:34 +0700
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
Subject: [PATCH v4 11/15] refs.c: make get_main_ref_store() public and use it
Date:   Sat, 18 Feb 2017 20:32:59 +0700
Message-Id: <20170218133303.3682-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
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
index 8b640bd05..1b60e6180 100644
--- a/refs.c
+++ b/refs.c
@@ -1308,7 +1308,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->init_db(refs, err);
 }
@@ -1316,7 +1316,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_ref_store(NULL), refname,
+	return resolve_ref_recursively(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1439,7 +1439,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
-static struct ref_store *get_main_ref_store(void)
+struct ref_store *get_main_ref_store(void)
 {
 	struct ref_store *refs;
 
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
index 9fbff90e7..a35b687d7 100644
--- a/refs.h
+++ b/refs.h
@@ -555,4 +555,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 int ref_storage_backend_exists(const char *name);
 
+struct ref_store *get_main_ref_store(void);
+
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

