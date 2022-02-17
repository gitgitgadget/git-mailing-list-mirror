Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44029C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiBQN4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:56:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiBQNzt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A721274C8C
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so9177508wrc.6
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tlgoVWle0gi+6bs+gWGo0KCzoCzZ1VwyzTZVbVPDUtI=;
        b=G493jZIVnfsS+DVM7TpWtvtj7ZQC6bBC+PD9EVWo9WNKr8o0t29AKlTZrvOsm836R9
         DCXTKnsiW2PwxzOsbASFqCNQKI9C5URe9zrWkbU7H9xzQioEFC7expRE9NFngT0mNoLG
         yRO8A4tY48aR2B96jNf6hdN19aS3OCF1VWEl0Q9AxEydWEyuIzD+PEZWUkB+A+oY6qOt
         4YiS70knrE3756OSEBAxh3IZ5IaietFexdahFn9RB9UX1bKCJaXVoGoQxin/HFoqlbIc
         lT9fo2impf0hxhh6dNb1NQzc6nWVSzIlsl8lKSxyf8kwIMvAGSaFHeiNL0B9kfQReSmd
         mjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tlgoVWle0gi+6bs+gWGo0KCzoCzZ1VwyzTZVbVPDUtI=;
        b=Lm1F03WQybsofmtJf+9Bjd76m3hjZPYZQ/2uhTA+/FoMoiUNzo4YX8Yz5W8e3a2ZyV
         Etwkj3AZs4m5gk3SXBaNERqjvXpxU2rFZP+dI8l9ID0Fa3Rb72megNGOtIspmb5SIu+e
         jE1Rxne1lg4Z90jMB0y7Hvd5fR5BsiIVvF9/Lq1ZG50N7Jx2hbas3AXAxSHTX59K02dI
         9Nmy+T2kGE+eNmLxphhu6OVbLPoyNpBO0OrfMnUXB/VYFySnQqQ1I4UAhsrVEreswjiI
         bZhmEMEMtwnATMAU4NBLQ3OJYYVCGrTJMI0uA5yjop84oHMaRAH2T0Qqd81TSe5jCkGp
         z7XA==
X-Gm-Message-State: AOAM532eblzQGYr/9cBXUNu2HS0IEtS2z16xonsUkrNitj1ewtSBz/46
        lX9jofdrg7xa/vHR8JdODvlg191EYZs=
X-Google-Smtp-Source: ABdhPJwqb5Ds8vqbALh+DYGMg5oEX80eawnsDLGCquk9GCIMQUqtNThd4C/BjSu/PfFAWf4O42PT2w==
X-Received: by 2002:adf:dd92:0:b0:1e4:eee1:91be with SMTP id x18-20020adfdd92000000b001e4eee191bemr2474253wrl.414.1645106133654;
        Thu, 17 Feb 2022 05:55:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm1824960wmq.20.2022.02.17.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:33 -0800 (PST)
Message-Id: <c6ffdb3471c1280a7f3a4293e95d666cf839b192.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:24 +0000
Subject: [PATCH v2 7/7] reftable: rename writer_stats to reftable_writer_stats
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
