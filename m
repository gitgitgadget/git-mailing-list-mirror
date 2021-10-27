Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0BBC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA506610CA
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhJ0Hvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbhJ0Hvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906CC061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so2451622wrd.13
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ujbnv4+43ixUwHCk3jD1n5WL8u2kycVREyhlj89wnLE=;
        b=AALz/9KZlR+qpObunt/YDNAOzlgQqt5fdrnSHZCpau1e7FYkfcKO9RYH9vpC0396DT
         BX1R0y7s6he89J9q696OS78FSZVo4LoBR/uMBI8mlK85CVLbdTEILBj/a2C+vzMJ8Mxa
         LyerrgA+25Z3qWghivWf+aK92cz774I2hnh6JBiOtuySei1W8kPOPZZXzlG02UF64cEy
         kJYRsu4c13EOas4EFv7v+E3zHeofheNY99ahmqGeG2XvCmV56/whvjzDNz3oI0uTFEgT
         25MGPieyLSl3Y7yzXhDe1RZ+fR/h1QBvHYtYvY1eHygeqtN1SVH3IIS5kDlDvwawhWCg
         4dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ujbnv4+43ixUwHCk3jD1n5WL8u2kycVREyhlj89wnLE=;
        b=X1o8WZX+0t1Q5+ggqjYSUv0zl9ozcZVDfl9EEdu1gv7w3XcxT6tH+ikHcjmDur5Vyr
         bVRv2OAiv0RuTyGVTDXUnoxajul9VXePsCvJzb8ZUpTVpO7qqGzix9TF4WW/4K0MiAP6
         +OxtF2f1cFAAnBWoRhVu/Z3/FHqCvl7sIY9FgQlqudTjYKGz23h60t84Qf8I8D5G05BM
         1ktskilZ7MYQJdw/KnwKyLaZRnYJAg8C/vhCSSdOh7T+A1+EX26o+tRSBFYPaYqyS9br
         KhQO6xlbRynO28p5lfpUhRl2524Pf7kXqS/PKPqPpzcrHBYE10JeJGDwxHcnrFfIGbfC
         enWA==
X-Gm-Message-State: AOAM533xceyaXOfXdu3bAF6e6wMYGYj21khYUnwnO9zDHxZGX1UIyAM2
        gB3xUYbTlwVjz/GHenrEl6PAFVbya/Q=
X-Google-Smtp-Source: ABdhPJwlFaS0S3Bd/Btc3HC5QHnyX4M3tpc9JtrGR+astfWqZHNq1fKIvrwmB/kENFIca/KjkqYvbw==
X-Received: by 2002:a5d:6d51:: with SMTP id k17mr37770997wri.233.1635320955792;
        Wed, 27 Oct 2021 00:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm2653921wro.93.2021.10.27.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:49:15 -0700 (PDT)
Message-Id: <c81ee778b26310d1aee923671c07cbd53496297b.1635320952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 07:49:10 +0000
Subject: [PATCH 3/5] git-compat-util: introduce more size_t helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We will use them in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a35..7977720655c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,14 @@
 #define unsigned_mult_overflows(a, b) \
     ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
 
+/*
+ * Returns true if the left shift of "a" by "shift" bits will
+ * overflow. The types of "a" and "b" must be unsigned.
+ * Note that this macro evaluates "a" twice!
+ */
+#define unsigned_left_shift_overflows(a, shift) \
+    ((a) > maximum_unsigned_value_of_type(a) >> shift)
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
@@ -859,6 +867,23 @@ static inline size_t st_sub(size_t a, size_t b)
 	return a - b;
 }
 
+static inline size_t st_left_shift(size_t a, unsigned shift)
+{
+	if (unsigned_left_shift_overflows(a, shift))
+		die("size_t overflow: %"PRIuMAX" << %u",
+		    (uintmax_t)a, shift);
+	return a << shift;
+}
+
+static inline unsigned long cast_size_t_to_ulong(size_t a)
+{
+	if (a != (unsigned long)a)
+		die("object too large to read on this platform: %"
+		    PRIuMAX" is cut off to %lu",
+		    (uintmax_t)a, (unsigned long)a);
+	return (unsigned long)a;
+}
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
-- 
gitgitgadget

