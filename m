Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738DC433FE
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhLNLsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhLNLsB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CDC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so16098672wme.0
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5WQciBJg+b+a7i06YFpIhdeArC43KJcMStyqTq1E0/E=;
        b=m92/UolKfX69IfWzNCjK0FEoG3pM6/USzOEmIwArs0DaLwXaXqxjB7AXHDX2x4XN1b
         OGQ+St7w2a865tetpAI76S48x82MVWFhsug5GjE7S1j9SAodYyOsV1t7FJR8ZMCIFu/X
         cmd5BaBoLymO3REnHOYo34xm+Z4TkmJK0xLu6VpycKUbVcsfowdRxRQmebnKeOVFZ2rZ
         aZMUOFDPA6z4N+aw+LKAcYFyVFkw8nGvSh81fX3D75wBxU9m51bIpluQdNoAtBGP8NeH
         j3edkBBtbAkYDLRdRq3yFkVKMAm1wUap0PDYnNb4N8KtG98a30Gu7LxqlMsgO3D5Zo9u
         THJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5WQciBJg+b+a7i06YFpIhdeArC43KJcMStyqTq1E0/E=;
        b=Wm5HN/XKk+D/S5Gl5ilWWZiyRLRSvbRvZSHKL+zBc6/IdXkGmjqa2eosafq2AXonHl
         cDsBa46teWhSEYJoGQR7YeXAcHH8lXaZuVuqhO8rFptKaGsDzJoZFWLBEEAAd7LkoEPC
         OY2xc5JNfPQyCbVvKdBLtfRUfefYN/uLaBLL5XOy4ROVLRFp9BRBsNZRD6bKjZu1khEH
         as5W4IVR/+IIY+uG8S9xYcEvvIs7rD/qg5CrgmtTAZxaepPItttzzwrAKn7jcJOgxFxp
         UA1G8Iny/hQIlFTVUk5ZAwUjchf/ebcQv/xPVfzC3Fav4VSDfOjVY+Vn5fEtB3PKh9hj
         p9bw==
X-Gm-Message-State: AOAM530CZpFMFYuUQesUFyvejm7Tqk7aVAlfKCsTaeS7GH79Nai/GW25
        SB2dtLrjMFVES1IvPiQlgmkGT6EdGp4=
X-Google-Smtp-Source: ABdhPJyPlu32O34kHgw/sy15OAf+6z+Jy664otxpiEMBoSTGw9EP8y23NKFyffrs30UwhcciUFbctQ==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr6375411wml.194.1639482479612;
        Tue, 14 Dec 2021 03:47:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm13327936wru.51.2021.12.14.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:47:59 -0800 (PST)
Message-Id: <923293b79b4a450df1b6577a0e6a696496ce46db.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:47 +0000
Subject: [PATCH v4 02/11] reftable: fix resource leak in block.c error path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add test coverage for corrupt zlib data.

This problem was discovered by a Coverity scan.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c          | 26 +++++++++------
 reftable/readwrite_test.c | 66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..6c8e8705205 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
 	uint32_t sz = get_be24(block->data + header_off + 1);
-
+	int err = 0;
 	uint16_t restart_count = 0;
 	uint32_t restart_start = 0;
 	uint8_t *restart_bytes = NULL;
+	uint8_t *uncompressed = NULL;
 
-	if (!reftable_is_block_type(typ))
-		return REFTABLE_FORMAT_ERROR;
+	if (!reftable_is_block_type(typ)) {
+		err =  REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	if (typ == BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + header_off;
@@ -203,7 +206,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		uLongf src_len = block->len - block_header_skip;
 		/* Log blocks specify the *uncompressed* size in their header.
 		 */
-		uint8_t *uncompressed = reftable_malloc(sz);
+		uncompressed = reftable_malloc(sz);
 
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(uncompressed, block->data, block_header_skip);
@@ -212,16 +215,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		if (Z_OK !=
 		    uncompress2(uncompressed + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
-			reftable_free(uncompressed);
-			return REFTABLE_ZLIB_ERROR;
+			err = REFTABLE_ZLIB_ERROR;
+			goto done;
 		}
 
-		if (dst_len + block_header_skip != sz)
-			return REFTABLE_FORMAT_ERROR;
+		if (dst_len + block_header_skip != sz) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
 
 		/* We're done with the input data. */
 		reftable_block_done(block);
 		block->data = uncompressed;
+		uncompressed = NULL;
 		block->len = sz;
 		block->source = malloc_block_source();
 		full_block_size = src_len + block_header_skip;
@@ -251,7 +257,9 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	br->restart_count = restart_count;
 	br->restart_bytes = restart_bytes;
 
-	return 0;
+done:
+	reftable_free(uncompressed);
+	return err;
 }
 
 static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f6bcc2f775..6e88182a83a 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -254,6 +254,71 @@ static void test_log_write_read(void)
 	reader_close(&rd);
 }
 
+static void test_log_zlib_corruption(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
+	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
+	char message[100] = { 0 };
+	int err, i, n;
+
+	struct reftable_log_record log = {
+		.refname = "refname",
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.new_hash = hash1,
+				.old_hash = hash2,
+				.name = "My Name",
+				.email = "myname@invalid",
+				.message = message,
+			},
+		},
+	};
+
+	for (i = 0; i < sizeof(message)-1; i++)
+		message[i] = (uint8_t)(rand() % 64 + ' ');
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_log(w, &log);
+	EXPECT_ERR(err);
+
+	n = reftable_writer_close(w);
+	EXPECT(n == 0);
+
+	stats = writer_stats(w);
+	EXPECT(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	/* corrupt the data. */
+	buf.buf[50] ^= 0x99;
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.log");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_log(&rd, &it, "refname");
+	EXPECT(err == REFTABLE_ZLIB_ERROR);
+
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	strbuf_release(&buf);
+	reader_close(&rd);
+}
+
 static void test_table_read_write_sequential(void)
 {
 	char **names;
@@ -633,6 +698,7 @@ static void test_corrupt_table(void)
 
 int readwrite_test_main(int argc, const char *argv[])
 {
+	RUN_TEST(test_log_zlib_corruption);
 	RUN_TEST(test_corrupt_table);
 	RUN_TEST(test_corrupt_table_empty);
 	RUN_TEST(test_log_write_read);
-- 
gitgitgadget

