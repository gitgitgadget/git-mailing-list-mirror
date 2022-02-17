Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1268C433FE
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiBQNzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiBQNzq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C52D273774
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f3so9027341wrh.7
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NsrdF5h2PxUorHU1VNro3oVuNlc4F0V+1ZFMTw9yO6Y=;
        b=AhZRJYmZ3o3t9VkIVYJdzNnmPOt9yCpALcPjUAgLgFqR6oaimmNFuDH9kbhlR7o5jR
         cFTIut+PEqMCujwd+l0lzZGOdTCUBsXR2Xz7LLNuDzXcF3KhluotmXcs9gG+7kbY0ZR3
         wsXcEy2D6m4DeWsKwc+EMwRtqKfQv+fe2H00Xww7D5PlOrM4RpKZtpegasjPB+LDTesi
         mKwW2rbolVais4KHNKSX8XVqq5ryh/ZU7CriOgGD6xkhBGgfDwjwLe/FZNTQGjegjaup
         KwhZviFnzNPv6Div3MGc2G6PRdPIgGVjLkv3CaYF83S+uPc2pNWnwV6RoghfftHaUGE5
         xPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NsrdF5h2PxUorHU1VNro3oVuNlc4F0V+1ZFMTw9yO6Y=;
        b=ogW0prNZoSzfYjp9OU8xgG5+O9gzI08R+nE1LGj4/yPneNDJjFfOVDI2ryaRMu65i7
         CBJ5TDLIClsGlAlWDYSSBb19dCBaaXlCe2ec8Y5t7n0rkmVgVykjuWXAzPAsxDDriP44
         grkFuFXaKOrABcwd5z4Jnvbd/FhItO4VlBNqbIUkwIIv/3V4Tp5xINbpyv487010IJIj
         nvqjt2od4IQi0fFyv53T9iPdn/nBTojifGn+talsTyCQxXsbZt11ZOs9GmtxyEs+duOd
         qL4+U2mEAnv/CJsLDhZtm5i+cJjJZ6NLmyVjrlLVdz3iQDVTXVmIpfrWvgvCp6FEhs7W
         h4pQ==
X-Gm-Message-State: AOAM532IxCbaNDwSRXC3nJawrCVtzgnltfud2UQJr6PtzARw9Q8e1u8V
        GAd/aAd8b1WCP7x09sWmi2c967dnTS0=
X-Google-Smtp-Source: ABdhPJwtOpDqCPlYoKupYqPV93+m7Qa0H0RGf+X5ciHy7fpp9dJaWgpHoqAHpLUN3csXYZKknLnZgQ==
X-Received: by 2002:a5d:4b4c:0:b0:1dc:f34a:548 with SMTP id w12-20020a5d4b4c000000b001dcf34a0548mr2417797wrs.554.1645106130918;
        Thu, 17 Feb 2022 05:55:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm20630336wrn.60.2022.02.17.05.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:30 -0800 (PST)
Message-Id: <ba036ee8543b2dc28ac046eb0c8c0aef9e751c80.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:21 +0000
Subject: [PATCH v2 4/7] reftable: avoid writing empty keys at the block layer
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
index 2170748c5e9..4a095afe1e2 100644
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
+		return -1;
 
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

