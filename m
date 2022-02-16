Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD41C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbiBPAxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:53:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiBPAxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:53:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93075C7D5B
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o24so821720wro.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=kQFTl2S0bimWNt2jTNg9zquLwLJIcHTXTOvKwpKc7wBSJEIz25ImelXO46bh6ZItTq
         wE+i3yAMSi6Nrf6YnGvsueaXR3FpXU47wdYBnMCYeKzY8UgE4WXlW6EUU+kA84ByKKSn
         B5M5NhJay8MjjJ4QdD/h5DhgJZoe2vvCY7NipZMg4feEUlslOvbcFZqBqrRfP9m489Z6
         +d3WXbJOXE4CApk++ko/oThJCd7PGmomxVGQ7ScaJctiTlHmAyzhMtRB2l6Buc//NMLH
         +GQQpcEaIhIelVHSUgaRYW4W/Ah5DWZXNKlBu1N2MeQE/WCgS5WSGyjjPTJ0Sv2iCE0q
         CiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=JlmZ4kMNTC7Te78wigud4HUfp4cHb0LNCOdlWiezuiksXj1ePU4LKvZfIxea0M8jq4
         pHbCPQDVJvU+ktt5xYjVE8M3ohtcHKuSeAe2spuZkfGPpF9Mxx3rL4VWt/v7hJd8e9u5
         5Rm5/UA1pN0AMxG7xfe6wdB14ULyU6gPNlPw2LsejAMl4dorUgkJESIhTHE7Xc6A8qtu
         +DxUvE9cmfouZzNBHqAPHe63xF5VAI2vY0L/z1Wcil/9Sj40t/0oeH1i6R38IlbsMaP/
         3J6b3qjxiTTIyUCLRLmeOOpaVwsJY1UxgsaytBllhAArKHorn2A2wxaNBBdu5lFJhlgf
         3E4A==
X-Gm-Message-State: AOAM5305Nxwe6CcVJ33BN3alMy/V2jFV3a9KnUD59EcWF5JJYxxLRSE0
        E74+KsOCkY9kPcIPqmZQksZWlpR+Bws=
X-Google-Smtp-Source: ABdhPJzKt5r0XdO6qARLv4fLZYf02CtvuBQZDg08Th4hEtotv1eNjp+89MaizLQ5L5WaQScCCI+ITw==
X-Received: by 2002:adf:f38b:0:b0:1e6:2961:99b2 with SMTP id m11-20020adff38b000000b001e6296199b2mr364673wro.700.1644972813038;
        Tue, 15 Feb 2022 16:53:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm16151500wmi.47.2022.02.15.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:53:32 -0800 (PST)
Message-Id: <1a038097bfc1e0e7dc7737e4fb664e8f79a2da50.1644972810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
        <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 00:53:28 +0000
Subject: [PATCH v7 2/4] cat-file: introduce batch_mode enum to replace
 print_contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

A future patch introduces a new --batch-command flag. Including --batch
and --batch-check, we will have a total of three batch modes. print_contents
is the only boolean on the batch_options sturct used to distinguish
between the different modes. This makes the code harder to read.

To reduce potential confusion, replace print_contents with an enum to
help readability and clarity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..5e38af82af1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,10 +17,15 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
+enum batch_mode {
+	BATCH_MODE_CONTENTS,
+	BATCH_MODE_INFO,
+};
+
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
-	int print_contents;
+	enum batch_mode batch_mode;
 	int buffer_output;
 	int all_objects;
 	int unordered;
@@ -386,7 +391,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->print_contents) {
+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
@@ -536,7 +541,7 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
@@ -635,7 +640,14 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	if (!strcmp(opt->long_name, "batch"))
+		bo->batch_mode = BATCH_MODE_CONTENTS;
+	else if (!strcmp(opt->long_name, "batch-check"))
+		bo->batch_mode = BATCH_MODE_INFO;
+	else
+		BUG("%s given to batch-option-callback", opt->long_name);
+
 	bo->format = arg;
 
 	return 0;
-- 
gitgitgadget

