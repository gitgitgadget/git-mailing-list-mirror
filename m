Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D18C433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiAXTjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352683AbiAXTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39DC02983C
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso59042wma.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7fOxL6/59cAuU6DFZOWe6UrF2Y5v3xI+JhobzCD2hfU=;
        b=kIuc2ZKWA+NL+vU3T7lhH9hdUTYG3bU1HQgBQSZBZI4Xuq/qpX0/NNmbQkIUrTCTQ/
         nF4GQfceRpUibCJkItg8dr4AOo2GbwzoiqmM+NIjn08EV14jrLS2lL8r4zPK19XZBcqu
         4lxcmeGLo6mLF/FEkLET862FQdBtg//fSfJ6t25oVQf4g/USngd1OKxRFVcO4AWIpSKS
         /hAG1aZb1td1Ktt89H0I0PO2m1NlpktPUB6qu7OQxfJhE5CrEVWa4VhCtAIIMwZoYebe
         fqkQIouqf1SWtJlJvDl+Mv8lRgvkY/qXImGSmiUkvnwj3TZe6EuORNm+6GsOwyAG3sCi
         mpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7fOxL6/59cAuU6DFZOWe6UrF2Y5v3xI+JhobzCD2hfU=;
        b=tQqmWt1K/imyOfomGz/ync20QdHyk9Ds3LpLAVkECPiH3MkUWSSSOEjCnQX1vdvVJs
         /pudfVueSRusLfCOwOshn9/gTInrFdqdOIxOqIWZme+Y6O+PX13ye0+9o/gaWo4mToaf
         YPvDJ7ZE5qzCmslAvtNOqO4yrxZ+o6f5iZXUEMVwv9S0JUzfpxfRyg89JzBrmDmkwj9b
         nxKDlMB8I7srvqoNSL3X042cC4IFMvFPiN7kyejdcPTzAh8GiCKRlkSia9c4Fvbi41Zy
         yKqVPkHrAmLCkqvvGIA3i2/ESKFSNVov9hfR/dHrh01FQWZkqHzIjOabyFWLJDoGbAj0
         Hvyg==
X-Gm-Message-State: AOAM531HBiVx8LppWQqPgEgZKU4XwqN5Itfn9LhzyeYSF9Ry0icCF0Dv
        g9EN+A8HXpcbKrvZ6+AZu2St+KOdQWbNKw==
X-Google-Smtp-Source: ABdhPJzlNUVznVIK8k0WSeEaSXHf3cmgE4nufwWz909lJQ4gs2y3Nz27avR3xrONkGwNDP5WYe15uA==
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr2940853wmf.161.1643051635524;
        Mon, 24 Jan 2022 11:13:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm14783900wrq.11.2022.01.24.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:54 -0800 (PST)
Message-Id: <90c72a2df0c40e5b4f1ad925a73cf0bed334348d.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:39 +0000
Subject: [PATCH v7 11/16] reftable: make reftable-record.h function signatures
 const correct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c          | 14 +++++++-------
 reftable/reftable-record.h | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 53d83e4a41a..1ae344c745b 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -72,7 +72,7 @@ int reftable_is_block_type(uint8_t typ)
 	return 0;
 }
 
-uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec)
+uint8_t *reftable_ref_record_val1(const struct reftable_ref_record *rec)
 {
 	switch (rec->value_type) {
 	case REFTABLE_REF_VAL1:
@@ -84,7 +84,7 @@ uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec)
 	}
 }
 
-uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec)
+uint8_t *reftable_ref_record_val2(const struct reftable_ref_record *rec)
 {
 	switch (rec->value_type) {
 	case REFTABLE_REF_VAL2:
@@ -251,7 +251,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 	}
 }
 
-void reftable_ref_record_print(struct reftable_ref_record *ref,
+void reftable_ref_record_print(const struct reftable_ref_record *ref,
 			       uint32_t hash_id)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
@@ -881,8 +881,8 @@ static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
 	return !memcmp(a, b, sz);
 }
 
-int reftable_log_record_equal(struct reftable_log_record *a,
-			      struct reftable_log_record *b, int hash_size)
+int reftable_log_record_equal(const struct reftable_log_record *a,
+			      const struct reftable_log_record *b, int hash_size)
 {
 	if (!(null_streq(a->refname, b->refname) &&
 	      a->update_index == b->update_index &&
@@ -1150,8 +1150,8 @@ static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
 	return a == b;
 }
 
-int reftable_ref_record_equal(struct reftable_ref_record *a,
-			      struct reftable_ref_record *b, int hash_size)
+int reftable_ref_record_equal(const struct reftable_ref_record *a,
+			      const struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
 	if (!null_streq(a->refname, b->refname))
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 5370d2288c7..67104f8fbfe 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -49,25 +49,25 @@ struct reftable_ref_record {
 
 /* Returns the first hash, or NULL if `rec` is not of type
  * REFTABLE_REF_VAL1 or REFTABLE_REF_VAL2. */
-uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec);
+uint8_t *reftable_ref_record_val1(const struct reftable_ref_record *rec);
 
 /* Returns the second hash, or NULL if `rec` is not of type
  * REFTABLE_REF_VAL2. */
-uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec);
+uint8_t *reftable_ref_record_val2(const struct reftable_ref_record *rec);
 
 /* returns whether 'ref' represents a deletion */
 int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
 
 /* prints a reftable_ref_record onto stdout. Useful for debugging. */
-void reftable_ref_record_print(struct reftable_ref_record *ref,
+void reftable_ref_record_print(const struct reftable_ref_record *ref,
 			       uint32_t hash_id);
 
 /* frees and nulls all pointer values inside `ref`. */
 void reftable_ref_record_release(struct reftable_ref_record *ref);
 
 /* returns whether two reftable_ref_records are the same. Useful for testing. */
-int reftable_ref_record_equal(struct reftable_ref_record *a,
-			      struct reftable_ref_record *b, int hash_size);
+int reftable_ref_record_equal(const struct reftable_ref_record *a,
+			      const struct reftable_ref_record *b, int hash_size);
 
 /* reftable_log_record holds a reflog entry */
 struct reftable_log_record {
@@ -104,8 +104,8 @@ int reftable_log_record_is_deletion(const struct reftable_log_record *log);
 void reftable_log_record_release(struct reftable_log_record *log);
 
 /* returns whether two records are equal. Useful for testing. */
-int reftable_log_record_equal(struct reftable_log_record *a,
-			      struct reftable_log_record *b, int hash_size);
+int reftable_log_record_equal(const struct reftable_log_record *a,
+			      const struct reftable_log_record *b, int hash_size);
 
 /* dumps a reftable_log_record on stdout, for debugging/testing. */
 void reftable_log_record_print(struct reftable_log_record *log,
-- 
gitgitgadget

