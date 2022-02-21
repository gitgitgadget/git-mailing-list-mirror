Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D7C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiBUSrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:47:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBUSql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484DBCDF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so2231032wrg.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tlgoVWle0gi+6bs+gWGo0KCzoCzZ1VwyzTZVbVPDUtI=;
        b=SQeOOqyl5/TLoJCfJgKcimQRNtnf4hCsylEolIHnSrZN2w6UwJiAA3W1urFrFMScq+
         5sdhgiF6SfyIqiBTFQHpKrrx+ilK0wzp1+yzz5KjWtSd+PXxGZLKMFmRC0U9m3tVvKmF
         fZ4P7F5btwZe9cv1PSLCns1lS8McfltULOLkIW+qMCjiAA+/wptBVuC6/V2Oqrj7R8Rj
         lTAx4U+gs/JvKkfcIQGLQUrRfbOPE4IW0QrVBXzJUbGCMg4fOvJE63s4o01QzRpiwUzZ
         68XZbx4bLsW4iKkZcZ410u9qGynzfmEcMxpDkC50rE6xue8GyIL+FVEbS9CpDSF3EPsm
         2wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tlgoVWle0gi+6bs+gWGo0KCzoCzZ1VwyzTZVbVPDUtI=;
        b=OgFQq4GISE7Zxm6D+PJcEF08gG6uwyOdClqJVzy6nnpe0LQYVmtncU2XV1Sl+e8Dnx
         +8SbE+P0Kjr+uIS4a7HLHTshswyrF6buaxOtZQBIHF8hB6pqtqPPWxKbpbAhJFs+I0bE
         Oq8HOu2WRSKIS40quiEoCx66hPG0VGjVA7YWVorDSkvuUGMjkFlAVrWPYPhfcP/Xo4+Y
         SO3mkgwdsgAl7f8MS+CtVL8L7/y4ZAAoCXrlU+z+SdusPXy0lDpHpyGHT84wmaTOs9vt
         Yw74bILVOCsM/BQGUTZqk7ClQw9pL9hl+athsk1UHNE1jKOLpNmtqvezypKKeKh/dUr1
         WRHw==
X-Gm-Message-State: AOAM533evRxAdD4o9udneQhcSwDVzwz78NeiIxHxdQq8CfgvHoyQLY6O
        59yfRtdvH1RE1U93pH0A/ibiHkr12m8=
X-Google-Smtp-Source: ABdhPJzbqunMDa8hU6mzDDz/kceQN4qJjw6fJcATw2Yf+qk3EqcM6wnOUjpyK13NxNrRsSj3qezLMQ==
X-Received: by 2002:a5d:6a0f:0:b0:1e5:53db:4ddd with SMTP id m15-20020a5d6a0f000000b001e553db4dddmr16749816wru.614.1645469176740;
        Mon, 21 Feb 2022 10:46:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15sm5313567wrp.109.2022.02.21.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:16 -0800 (PST)
Message-Id: <72499a14e383ef81e717692002ed68959774c7da.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:10 +0000
Subject: [PATCH v3 7/7] reftable: rename writer_stats to reftable_writer_stats
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

This function is part of the reftable API, so it should use the
reftable_ prefix

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c  | 10 +++++-----
 reftable/reftable-writer.h |  2 +-
 reftable/writer.c          |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a1b835785a3..469ab79a5ad 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -100,7 +100,7 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 	n = reftable_writer_close(w);
 	EXPECT(n == 0);
 
-	stats = writer_stats(w);
+	stats = reftable_writer_stats(w);
 	for (i = 0; i < stats->ref_stats.blocks; i++) {
 		int off = i * opts.block_size;
 		if (off == 0) {
@@ -239,7 +239,7 @@ static void test_log_write_read(void)
 	n = reftable_writer_close(w);
 	EXPECT(n == 0);
 
-	stats = writer_stats(w);
+	stats = reftable_writer_stats(w);
 	EXPECT(stats->log_stats.blocks > 0);
 	reftable_writer_free(w);
 	w = NULL;
@@ -330,7 +330,7 @@ static void test_log_zlib_corruption(void)
 	n = reftable_writer_close(w);
 	EXPECT(n == 0);
 
-	stats = writer_stats(w);
+	stats = reftable_writer_stats(w);
 	EXPECT(stats->log_stats.blocks > 0);
 	reftable_writer_free(w);
 	w = NULL;
@@ -698,7 +698,7 @@ static void test_write_object_id_min_length(void)
 
 	err = reftable_writer_close(w);
 	EXPECT_ERR(err);
-	EXPECT(writer_stats(w)->object_id_len == 2);
+	EXPECT(reftable_writer_stats(w)->object_id_len == 2);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
@@ -735,7 +735,7 @@ static void test_write_object_id_length(void)
 
 	err = reftable_writer_close(w);
 	EXPECT_ERR(err);
-	EXPECT(writer_stats(w)->object_id_len == 16);
+	EXPECT(reftable_writer_stats(w)->object_id_len == 16);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index a560dc17255..db8de197f6c 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -143,7 +143,7 @@ int reftable_writer_close(struct reftable_writer *w);
 
    This struct becomes invalid when the writer is freed.
  */
-const struct reftable_stats *writer_stats(struct reftable_writer *w);
+const struct reftable_stats *reftable_writer_stats(struct reftable_writer *w);
 
 /* reftable_writer_free deallocates memory for the writer */
 void reftable_writer_free(struct reftable_writer *w);
diff --git a/reftable/writer.c b/reftable/writer.c
index 5e4e6e93416..6d979e245ff 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -695,7 +695,7 @@ static int writer_flush_block(struct reftable_writer *w)
 	return writer_flush_nonempty_block(w);
 }
 
-const struct reftable_stats *writer_stats(struct reftable_writer *w)
+const struct reftable_stats *reftable_writer_stats(struct reftable_writer *w)
 {
 	return &w->stats;
 }
-- 
gitgitgadget
