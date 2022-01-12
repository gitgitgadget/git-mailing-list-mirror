Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D5C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356054AbiALSJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356050AbiALSIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:08:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF4C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e9so5771742wra.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+z3yk49eb9SiUj3sMvBsLD82Avj1LArAl/R1zWEclUg=;
        b=bxIEleTtmVMKEiBOxbT9L28hLMuVteC7Vdm80L7HdOKOUEs8CzE+UUzg1SQx+45vTQ
         2zdQlTxFE0qtya2n5B4bYZukBCgeDyCC5XkRb8fbCoEtl2nsQJGcXokicfJQQmDq4vus
         IST0VAHDh4oG6DNJuekxUB+NWKAVmi8J5+psdlwJU2s6j7EQzsLXzJ0/G1+HZ/S5gKti
         sAcYz0VNhSM1Q4GNwZqQVN9gxtkvYmZKIuClmdAoM1RoQ0kfnYYhLCDQa61OAWA/7hip
         Cj2hvUa446HIWopCos/QpUiCAHiCHdlZYlqRHPE1k11bIvpQaWkyQ0f80VQ+8bdNgxv5
         BGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+z3yk49eb9SiUj3sMvBsLD82Avj1LArAl/R1zWEclUg=;
        b=4eEgoIbzGrgoAJNDjwIOn/FzBYLgkuuDIjNx5LJeMkgYFGb/3Kguqgw0czsBKlfrwm
         xGKOAesLePKOjp4+GUN6MGummgeIOWbdwhfGGJRPS2sjaMEcRz2fAVy92vMYnvInmdO4
         jF+eGIRR2FQ4XG8V6Kv6cllOqtEApicf6XyCtJnfVBs3wiIOn5UxChI5MqEly0D0Gfco
         TImEccixn41eLATfqYyQ7W/DR25wxOR24/BoBLnyiVpr5a9LAWYjucFbOjqHDxx2nDod
         ct+Lk1c9Rpqr43R78NaY7EIl1C0m9CaqZDkLIcY6TF7aiDrAC82J47+RifFvucNSwJhD
         6m6w==
X-Gm-Message-State: AOAM531WSQIojzm56/2NnwriwwYOVFbX4RnT53lPEFJ4UsM7rMj8B90Q
        HcuO3SjdYUOQU8HzA5S53YV5OIwDWt4=
X-Google-Smtp-Source: ABdhPJxqDOVIZ4C/6WIbf27IPMbRzSvT9USpf7p39YrSN6meIVZZZ8O6Lc7t2vRlpnToebTCs7+Ohw==
X-Received: by 2002:adf:8b50:: with SMTP id v16mr864767wra.44.1642010884193;
        Wed, 12 Jan 2022 10:08:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm681559wrb.13.2022.01.12.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:08:03 -0800 (PST)
Message-Id: <37aa7744c844f040995eca93d3b794d3af3087a9.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:48 +0000
Subject: [PATCH 7/7] reftable: rename writer_stats to reftable_writer_stats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This function is part of the reftable API, so it should use the
reftable_ prefix

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c  | 8 ++++----
 reftable/reftable-writer.h | 2 +-
 reftable/writer.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f45cee39d6..b1ff46c18a9 100644
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
@@ -633,7 +633,7 @@ static void test_write_object_id_min_length(void)
 
 	err = reftable_writer_close(w);
 	EXPECT_ERR(err);
-	EXPECT(writer_stats(w)->object_id_len == 2);
+	EXPECT(reftable_writer_stats(w)->object_id_len == 2);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
@@ -670,7 +670,7 @@ static void test_write_object_id_length(void)
 
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
index f94af531351..495784e6294 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -688,7 +688,7 @@ static int writer_flush_block(struct reftable_writer *w)
 	return writer_flush_nonempty_block(w);
 }
 
-const struct reftable_stats *writer_stats(struct reftable_writer *w)
+const struct reftable_stats *reftable_writer_stats(struct reftable_writer *w)
 {
 	return &w->stats;
 }
-- 
gitgitgadget
