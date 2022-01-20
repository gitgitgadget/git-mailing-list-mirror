Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6120C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376561AbiATPMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346200AbiATPM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76BDC06173F
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso8127962wmh.4
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ifvX/FZZWEtWmoSJwuxEfFvFGzduSB4zEMVZ/LX8/Lk=;
        b=AQiu6wbZg3aOPnNBszIaA0qMeQa9tYTvnUzGE7uRcIDy+TUIt1AmWjSroSH85GZ1aV
         0ihUnMH+kleIud9kCXFcd0Zkde7cQS7QRRZaCft6ZJQQKH5HtlQeRCprbT5v4K82Szhe
         78RZAarcKOnaTtfkRslv1qBjO4We/IGCaFWU9Rm6RD/LiUQYxhnhM1aPNWlYlV8UUveo
         L4sXo8KD28cG/l8/3LsatMcagpgpjRuVAkVu9I69wb8+TYthDGT5DrDy8PaJ02p7z8zL
         yLC8wpn83cFsqq2e2/qllhXuhF376+i4bvUbE+DPc3ptbXKxky/8gWz/+OU+pfBRA4oP
         Ak8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ifvX/FZZWEtWmoSJwuxEfFvFGzduSB4zEMVZ/LX8/Lk=;
        b=6xqgB71LIHJDayxTSVNIaDmvK9R4jgRY/INvJiI1uPlnjsxDyBp4CBwaVcKHhf6SeB
         DrUn3eR6Gg1izr2YWKsErAKW37GoKxlKk0cUZ60EYJYyEzWnu6pBAbzNnhjnkuiiMpVD
         sy2DKkXtagZluXSbLJ4dFTfDbUB322G9BhsjNXYwN/cgAi2o4zwm4dwhbbGe8Z5ji2b+
         rACpR2hNlChWKlkMzwf4UHAyd9+yvb0D4kCwuSjZNobwvzgIQipYfQN9YVwy+TqS+yCw
         7fEx237SqxqN1L+RBttunqlEYG/rdesFVRisshNI1R3TS22Zne2Qlq82TZXeVSr4xBO3
         MabA==
X-Gm-Message-State: AOAM532ISd8L6/Cwg76yCQa6Lkn/DFBMzCDgKYZvif1EI0nQQ2vKTSJu
        xPZcyiMhyeuAs4pN7BIrid1LruVdKXA=
X-Google-Smtp-Source: ABdhPJy572aN8Q+9KmHLSEJXW3q5NiVsYIXNNB/4ESw7xo9fEAB7cz7zITFnZbSIIgGtVa62ZumXNw==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr34652685wrr.19.1642691545153;
        Thu, 20 Jan 2022 07:12:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm2870246wrf.111.2022.01.20.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:24 -0800 (PST)
Message-Id: <6385e449ba714e3ce41f10276fc60e9757519492.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:11 +0000
Subject: [PATCH v6 12/15] reftable: implement record equality generically
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

This simplifies unittests a little, and provides further coverage for
reftable_record_copy().

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c      | 57 +++++++++++++++++++++++++++++++++++++++++-
 reftable/record.h      |  5 +++-
 reftable/record_test.c | 23 +++--------------
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index f7c77c51539..2a9e41a992e 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -430,6 +430,15 @@ static int reftable_ref_record_is_deletion_void(const void *p)
 		(const struct reftable_ref_record *)p);
 }
 
+
+static int reftable_ref_record_equal_void(const void *a,
+					  const void *b, int hash_size)
+{
+	struct reftable_ref_record *ra = (struct reftable_ref_record *) a;
+	struct reftable_ref_record *rb = (struct reftable_ref_record *) b;
+	return reftable_ref_record_equal(ra, rb, hash_size);
+}
+
 static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.key = &reftable_ref_record_key,
 	.type = BLOCK_TYPE_REF,
@@ -439,6 +448,7 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.decode = &reftable_ref_record_decode,
 	.release = &reftable_ref_record_release_void,
 	.is_deletion = &reftable_ref_record_is_deletion_void,
+	.equal = &reftable_ref_record_equal_void,
 };
 
 static void reftable_obj_record_key(const void *r, struct strbuf *dest)
@@ -572,6 +582,25 @@ static int not_a_deletion(const void *p)
 	return 0;
 }
 
+static int reftable_obj_record_equal_void(const void *a, const void *b, int hash_size)
+{
+	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
+	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
+
+	if (ra->hash_prefix_len != rb->hash_prefix_len
+	    || ra->offset_len != rb->offset_len)
+		return 0;
+
+	if (ra->hash_prefix_len &&
+	    memcmp(ra->hash_prefix, rb->hash_prefix, ra->hash_prefix_len))
+		return 0;
+	if (ra->offset_len &&
+	    memcmp(ra->offsets, rb->offsets, ra->offset_len * sizeof(uint64_t)))
+		return 0;
+
+	return 1;
+}
+
 static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.key = &reftable_obj_record_key,
 	.type = BLOCK_TYPE_OBJ,
@@ -580,7 +609,8 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.encode = &reftable_obj_record_encode,
 	.decode = &reftable_obj_record_decode,
 	.release = &reftable_obj_record_release,
-	.is_deletion = not_a_deletion,
+	.is_deletion = &not_a_deletion,
+	.equal = &reftable_obj_record_equal_void,
 };
 
 void reftable_log_record_print(struct reftable_log_record *log,
@@ -881,6 +911,14 @@ static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
 	return !memcmp(a, b, sz);
 }
 
+static int reftable_log_record_equal_void(const void *a,
+					  const void *b, int hash_size)
+{
+	return reftable_log_record_equal((struct reftable_log_record *) a,
+					 (struct reftable_log_record *) b,
+					 hash_size);
+}
+
 int reftable_log_record_equal(const struct reftable_log_record *a,
 			      const struct reftable_log_record *b, int hash_size)
 {
@@ -924,6 +962,7 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.decode = &reftable_log_record_decode,
 	.release = &reftable_log_record_release_void,
 	.is_deletion = &reftable_log_record_is_deletion_void,
+	.equal = &reftable_log_record_equal_void
 };
 
 struct reftable_record reftable_new_record(uint8_t typ)
@@ -1042,6 +1081,14 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	return start.len - in.len;
 }
 
+static int reftable_index_record_equal(const void *a, const void *b, int hash_size)
+{
+	struct reftable_index_record *ia = (struct reftable_index_record *) a;
+	struct reftable_index_record *ib = (struct reftable_index_record *) b;
+
+	return ia->offset == ib->offset && !strbuf_cmp(&ia->last_key, &ib->last_key);
+}
+
 static struct reftable_record_vtable reftable_index_record_vtable = {
 	.key = &reftable_index_record_key,
 	.type = BLOCK_TYPE_INDEX,
@@ -1051,6 +1098,7 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.decode = &reftable_index_record_decode,
 	.release = &reftable_index_record_release,
 	.is_deletion = &not_a_deletion,
+	.equal = &reftable_index_record_equal,
 };
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
@@ -1098,6 +1146,13 @@ int reftable_record_is_deletion(struct reftable_record *rec)
 	return rec->ops->is_deletion(rec->data);
 }
 
+int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size)
+{
+	if (a->ops != b->ops)
+		return 0;
+	return a->ops->equal(a->data, b->data, hash_size);
+}
+
 void reftable_record_from_ref(struct reftable_record *rec,
 			      struct reftable_ref_record *ref_rec)
 {
diff --git a/reftable/record.h b/reftable/record.h
index 498e8c50bf4..da75d7d1f11 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -58,6 +58,9 @@ struct reftable_record_vtable {
 
 	/* is this a tombstone? */
 	int (*is_deletion)(const void *rec);
+
+	/* Are two records equal? This assumes they have the same type. Returns 0 for non-equal. */
+	int (*equal)(const void *a, const void *b, int hash_size);
 };
 
 /* record is a generic wrapper for different types of records. */
@@ -98,7 +101,7 @@ struct reftable_obj_record {
 };
 
 /* see struct record_vtable */
-
+int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
 uint8_t reftable_record_type(struct reftable_record *rec);
 void reftable_record_copy_from(struct reftable_record *rec,
diff --git a/reftable/record_test.c b/reftable/record_test.c
index f4ad7cace41..92680848156 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -21,18 +21,7 @@ static void test_copy(struct reftable_record *rec)
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
-	switch (reftable_record_type(&copy)) {
-	case BLOCK_TYPE_REF:
-		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
-						 reftable_record_as_ref(rec),
-						 GIT_SHA1_RAWSZ));
-		break;
-	case BLOCK_TYPE_LOG:
-		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
-						 reftable_record_as_log(rec),
-						 GIT_SHA1_RAWSZ));
-		break;
-	}
+	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
 	reftable_record_destroy(&copy);
 }
 
@@ -346,13 +335,7 @@ static void test_reftable_obj_record_roundtrip(void)
 					   GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
-		EXPECT(in.offset_len == out.offset_len);
-
-		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
-			       in.hash_prefix_len));
-		EXPECT(0 == memcmp(in.offsets, out.offsets,
-				   sizeof(uint64_t) * in.offset_len));
+		EXPECT(reftable_record_equal(&rec, &rec_out, GIT_SHA1_RAWSZ));
 		strbuf_release(&key);
 		reftable_record_release(&rec_out);
 	}
@@ -390,7 +373,7 @@ static void test_reftable_index_record_roundtrip(void)
 	m = reftable_record_decode(&out_rec, key, extra, dest, GIT_SHA1_RAWSZ);
 	EXPECT(m == n);
 
-	EXPECT(in.offset == out.offset);
+	EXPECT(reftable_record_equal(&rec, &out_rec, GIT_SHA1_RAWSZ));
 
 	reftable_record_release(&out_rec);
 	strbuf_release(&key);
-- 
gitgitgadget

