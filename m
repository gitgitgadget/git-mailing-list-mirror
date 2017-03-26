Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A08F20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdCZCpT (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36127 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdCZCpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so4067110pfr.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4y222quJsSs5W1XXlYwgqcFLdSsZACEWwT9mVeNhBlc=;
        b=GTkYGIQAEJYRw6af1QCOFaLf+78Fln1YaoqGEvPS11C6MlXKUG6/XF1hgxvOpbByOT
         VycZqgZaUDCGv/tbxN8+AWyNnoXxyQUO/ea4U3fkuCTpr2XK8OCNDud7Mgin86fRaLI3
         gdtd3RdHVF30t6bbLWwf6tqyeIyHodlwiWAVNrn9ZxILPHvorvwf8Z/6peJCJl5asupZ
         s9XGrORByfTdYzg/ZktxYEFQNj0lHNwY4FPBzFlOHz7rTV1blYRIbVazOyRbxo0HrWxJ
         sZ1dslIMkFv1RVhky2yy1ju8WsthqHLPB1TWEvCS+LdOVcZJ1fH3FQ/+2yJpPICx0S2V
         vYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4y222quJsSs5W1XXlYwgqcFLdSsZACEWwT9mVeNhBlc=;
        b=iaxKMLhpmqIm31myFMvyLafaQek86qL2dz8Rq9KSDF3+V+ZkINng7xRCc/5eQvndPi
         WAMkR7Zkl/jAmKmXfr14A2MKzZ1t3E5EZc+ow3boI7oH2pL3ttmi39fjlLrJABEescXM
         ECbHKNv5ZkAmHdSv4skgkMoDKCMx0+plTOe/4Stwx4X171xflEruDfFWA5ahsSaDMROh
         vuLfiKcwNK9qJH4dOy7eHiWbkcSF5IvQCyJNyLdj03WsmErn5kEd/jsr/XG1g2ergp/x
         lWIGAyaRvkR820LX0yBWEruk+cGEiUlgLyF7j5JM9Sf2K2iz/d3hCca9bAYx+9G74Z/H
         vPLw==
X-Gm-Message-State: AFeK/H0czLwVu6sXKluKwnnesmnHfgmQP+A4/FPV6HtELiHXeZ0ZvGC4VthavEH76hE+5g==
X-Received: by 10.99.0.213 with SMTP id 204mr17091480pga.60.1490496310404;
        Sat, 25 Mar 2017 19:45:10 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id j19sm12843895pfk.4.2017.03.25.19.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:45:04 +0700
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
Subject: [PATCH v7 22/28] refs: new transaction related ref-store api
Date:   Sun, 26 Mar 2017 09:42:35 +0700
Message-Id: <20170326024241.31984-23-pclouds@gmail.com>
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

The transaction struct now takes a ref store at creation and will
operate on that ref store alone.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 55 ++++++++++++++++++++++++++++++++++++++++------------
 refs.h               |  9 +++++++++
 refs/refs-internal.h |  1 +
 3 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index c103f90b35..50ea24bd75 100644
--- a/refs.c
+++ b/refs.c
@@ -630,16 +630,20 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
 	return 0;
 }
 
-int delete_ref(const char *msg, const char *refname,
-	       const unsigned char *old_sha1, unsigned int flags)
+int refs_delete_ref(struct ref_store *refs, const char *msg,
+		    const char *refname,
+		    const unsigned char *old_sha1,
+		    unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		assert(refs == get_main_ref_store());
 		return delete_pseudoref(refname, old_sha1);
+	}
 
-	transaction = ref_transaction_begin(&err);
+	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_sha1,
 				   flags, msg, &err) ||
@@ -654,6 +658,13 @@ int delete_ref(const char *msg, const char *refname,
 	return 0;
 }
 
+int delete_ref(const char *msg, const char *refname,
+	       const unsigned char *old_sha1, unsigned int flags)
+{
+	return refs_delete_ref(get_main_ref_store(), msg, refname,
+			       old_sha1, flags);
+}
+
 int copy_reflog_msg(char *buf, const char *msg)
 {
 	char *cp = buf;
@@ -813,11 +824,20 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 	return 1;
 }
 
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err)
 {
+	struct ref_transaction *tr;
 	assert(err);
 
-	return xcalloc(1, sizeof(struct ref_transaction));
+	tr = xcalloc(1, sizeof(struct ref_transaction));
+	tr->ref_store = refs;
+	return tr;
+}
+
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+{
+	return ref_store_transaction_begin(get_main_ref_store(), err);
 }
 
 void ref_transaction_free(struct ref_transaction *transaction)
@@ -934,18 +954,20 @@ int update_ref_oid(const char *msg, const char *refname,
 		old_oid ? old_oid->hash : NULL, flags, onerr);
 }
 
-int update_ref(const char *msg, const char *refname,
-	       const unsigned char *new_sha1, const unsigned char *old_sha1,
-	       unsigned int flags, enum action_on_err onerr)
+int refs_update_ref(struct ref_store *refs, const char *msg,
+		    const char *refname, const unsigned char *new_sha1,
+		    const unsigned char *old_sha1, unsigned int flags,
+		    enum action_on_err onerr)
 {
 	struct ref_transaction *t = NULL;
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		assert(refs == get_main_ref_store());
 		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
 	} else {
-		t = ref_transaction_begin(&err);
+		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
 		    ref_transaction_update(t, refname, new_sha1, old_sha1,
 					   flags, msg, &err) ||
@@ -976,6 +998,15 @@ int update_ref(const char *msg, const char *refname,
 	return 0;
 }
 
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1,
+	       const unsigned char *old_sha1,
+	       unsigned int flags, enum action_on_err onerr)
+{
+	return refs_update_ref(get_main_ref_store(), msg, refname, new_sha1,
+			       old_sha1, flags, onerr);
+}
+
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
@@ -1607,7 +1638,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	struct ref_store *refs = transaction->ref_store;
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1726,7 +1757,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	struct ref_store *refs = transaction->ref_store;
 
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
diff --git a/refs.h b/refs.h
index eaa31e8193..37f4aa8bd5 100644
--- a/refs.h
+++ b/refs.h
@@ -333,6 +333,10 @@ int reflog_exists(const char *refname);
  * exists, regardless of its old value. It is an error for old_sha1 to
  * be NULL_SHA1. flags is passed through to ref_transaction_delete().
  */
+int refs_delete_ref(struct ref_store *refs, const char *msg,
+		    const char *refname,
+		    const unsigned char *old_sha1,
+		    unsigned int flags);
 int delete_ref(const char *msg, const char *refname,
 	       const unsigned char *old_sha1, unsigned int flags);
 
@@ -418,6 +422,8 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
@@ -552,6 +558,9 @@ void ref_transaction_free(struct ref_transaction *transaction);
  * ref_transaction_update(). Handle errors as requested by the `onerr`
  * argument.
  */
+int refs_update_ref(struct ref_store *refs, const char *msg, const char *refname,
+		    const unsigned char *new_sha1, const unsigned char *old_sha1,
+		    unsigned int flags, enum action_on_err onerr);
 int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5f26208c2c..690498698e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -200,6 +200,7 @@ enum ref_transaction_state {
  * as atomically as possible.  This structure is opaque to callers.
  */
 struct ref_transaction {
+	struct ref_store *ref_store;
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
-- 
2.11.0.157.gd943d85

