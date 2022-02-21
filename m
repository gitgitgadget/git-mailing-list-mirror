Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387DBC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiBUSq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:46:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiBUSqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD119D97
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso14521wmj.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EJMTl4RYf8XttOYhM1W6xIcCDcfqzEssxfiBN7t2fsM=;
        b=BzPtLDeEtl8MIFjHTHW/XvJXRiw8tXonUzgfcDS5QN5CmzMhFqxzsvaayw8ZLgW2Vp
         0eWnWUip4rVDN6UWew94fLQRA4nQmEy4Ost4/H90nvz/LBLHlB+x8rEbJ7c1K1pwkhSQ
         oqq7U+gl/JeMh/Px5Epam/rUkWYZyKB1xNsmODb8eRWvgOHthiuAMewHQO49iwasgtkG
         a7Vs/HhaBwNaAlwXTcc2cRhxBZJAUgWK/E6eMGzRinccG+4cfIBwGN9PITu0rPp0XdGF
         Pc0534SJYZsqJqICPF49Osm6DOHToxhCzsdk6Lo+3xzQ4RtYlyeeCVDj9wxZt4BSl12b
         0ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EJMTl4RYf8XttOYhM1W6xIcCDcfqzEssxfiBN7t2fsM=;
        b=sAiC76NHOK5djPBIHOiVCMPRi3+5Nb6J+Cc7xBXcO5Z6KQjlfCR6xqCR6LLF56BmaM
         awqe/Fe/sLgPSkN3Rnr070kxpQRDgyr8h0qnSN4grFiO8TG5sFUbNC3lM5w4iNbXFLA/
         Lsnal+i/HW7DXO+VcEzEmwEttT1ND7tOzhjv8FE5W+KIYmZQCyI5Q/UPu2hZ/UF1rkPM
         3lmc0Uv4f2NjfyEv5ek05YrS3M7GlT+oFCxQivR+aZnYOkpKSyrgBBZ41lqcifUZlaHY
         eeryaO/apxqRkbre8DPkoNHWOl8CHT1ANkIpLvteL2lnXkAAy8SIKjTfdbxPRSF+4gE1
         XqNw==
X-Gm-Message-State: AOAM532M4EIoc0TPSFb3Sruyt+onVCjVCeDv0uSdbGwFm0eiftxvyrd4
        BZCt1ghCbehfo3SsVSJn3N3gXgsF24E=
X-Google-Smtp-Source: ABdhPJzjzoj8T09Ig68VAAzjcgm065b7h//Kuln+6d3vmBiFVjv/6Wy8nNqe9U+QrCoQ1EdC+6Cg/Q==
X-Received: by 2002:a1c:5445:0:b0:34f:30d6:99b9 with SMTP id p5-20020a1c5445000000b0034f30d699b9mr301039wmi.76.1645469174311;
        Mon, 21 Feb 2022 10:46:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk5sm37356333wrb.10.2022.02.21.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:13 -0800 (PST)
Message-Id: <a9372cacd1b7f62530df948c0ba99cf276d34cad.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:07 +0000
Subject: [PATCH v3 4/7] reftable: avoid writing empty keys at the block layer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The public interface (reftable_writer) already ensures that keys are
written in strictly increasing order, and an empty key by definition
fails this check.

However, by also enforcing this at the block layer, it is easier to
verify that records (which are written into blocks) never have to
consider the possibility of empty keys.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c      | 27 +++++++++++++++++----------
 reftable/block_test.c |  5 +++++
 reftable/writer.c     |  3 +--
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 2170748c5e9..34d4d073692 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -88,8 +88,9 @@ uint8_t block_writer_type(struct block_writer *bw)
 	return bw->buf[bw->header_off];
 }
 
-/* adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
-   success */
+/* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
+   success. Returns REFTABLE_API_ERROR if attempting to write a record with
+   empty key. */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 {
 	struct strbuf empty = STRBUF_INIT;
@@ -105,8 +106,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	int is_restart = 0;
 	struct strbuf key = STRBUF_INIT;
 	int n = 0;
+	int err = -1;
 
 	reftable_record_key(rec, &key);
+	if (!key.len) {
+		err = REFTABLE_API_ERROR;
+		goto done;
+	}
+
 	n = reftable_encode_key(&is_restart, out, last, key,
 				reftable_record_val_type(rec));
 	if (n < 0)
@@ -118,16 +125,11 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 		goto done;
 	string_view_consume(&out, n);
 
-	if (block_writer_register_restart(w, start.len - out.len, is_restart,
-					  &key) < 0)
-		goto done;
-
-	strbuf_release(&key);
-	return 0;
-
+	err = block_writer_register_restart(w, start.len - out.len, is_restart,
+					    &key);
 done:
 	strbuf_release(&key);
-	return -1;
+	return err;
 }
 
 int block_writer_finish(struct block_writer *w)
@@ -332,6 +334,9 @@ int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 	if (n < 0)
 		return -1;
 
+	if (!key.len)
+		return REFTABLE_FORMAT_ERROR;
+
 	string_view_consume(&in, n);
 	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
 	if (n < 0)
@@ -358,6 +363,8 @@ int block_reader_first_key(struct block_reader *br, struct strbuf *key)
 	int n = reftable_decode_key(key, &extra, empty, in);
 	if (n < 0)
 		return n;
+	if (!key->len)
+		return REFTABLE_FORMAT_ERROR;
 
 	return 0;
 }
diff --git a/reftable/block_test.c b/reftable/block_test.c
index fa2ee092ec0..cb88af4a563 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -42,6 +42,11 @@ static void test_block_read_write(void)
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
 
+	rec.u.ref.refname = "";
+	rec.u.ref.value_type = REFTABLE_REF_DELETION;
+	n = block_writer_add(&bw, &rec);
+	EXPECT(n == REFTABLE_API_ERROR);
+
 	for (i = 0; i < N; i++) {
 		char name[100];
 		uint8_t hash[GIT_SHA1_RAWSZ];
diff --git a/reftable/writer.c b/reftable/writer.c
index 944c2329ab5..d54215a50dc 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -240,14 +240,13 @@ static int writer_add_record(struct reftable_writer *w,
 
 	writer_reinit_block_writer(w, reftable_record_type(rec));
 	err = block_writer_add(w->block_writer, rec);
-	if (err < 0) {
+	if (err == -1) {
 		/* we are writing into memory, so an error can only mean it
 		 * doesn't fit. */
 		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
 
-	err = 0;
 done:
 	strbuf_release(&key);
 	return err;
-- 
gitgitgadget

