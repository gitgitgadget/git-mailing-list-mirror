Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4389BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 20:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiBPU7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:59:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBPU7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 15:59:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4D20204F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2521709wml.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=gTjqod9geJh+E+uZs4/B94ai4CeVmIrQsUB0XKv3Rzu/VenUlbJAsv4M1pGQr/ZkQd
         jsF1OkNWhL2eAtdb27fKTgcLJcGM9OiRGvVcveeMlARxJniY0J6mBu7Bt+OgtsLGs/II
         H132+VDGf7i2w/cg8LqbedmUbNcKmf4wpPZsFscBQzwek581E5N4JJE6hYSGKwoufGPC
         rVipM01RAGgAkRuwRz42bKqjwsaLjNNjNQZZ963LCab1dI40FlgVQRwHXgRBl6dQMqWc
         OMvvCRN0ml+yMn6hX+H7nr4qSvkzOMGysMxc6s7bnxOvQvu6pCg47JXN87cn/7qHHXPU
         +iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=0LsFIYdvX9V8u2TJGSb6IKrBjlBrS1/H3nkILd2DbS5NFZbf2SNli6QYV/xCjmwl5c
         ivRPvr1EmsZm8N9in2fhM23XQB7s89QhLjpuq9G2+bj3mImZGKYVNcjYnCe+2dGibdWB
         gNT/0FaXE6lhpUDCTKy35lfu4FvECArvDNwNJg1W6zzndHIp86GsXnM3Ay7HP6iJs7ST
         VCMVHudK30gd3TImeMWJguNBnOnXJiuQzQEQzMGGcanL6kqXtG0BHekoKu/vcIpRNl7v
         wQDBt3ycNFdjuV3Gj25qfBy4NSXOv58IP3V1pQyG+6btsr6Od9AI67TnycMAhZ2gQpMW
         HIDA==
X-Gm-Message-State: AOAM531hMgxSeLxM2Z6fr1AlZoUCCONUB4p4kHMeHkyfOo+EfY1VCu1t
        0mvfFlDPPemTQsa870/sTWg6tcAY+DI=
X-Google-Smtp-Source: ABdhPJx4OzYqBdQUpG0Gvwl8iU9P/gsSHikOlTAn5KkJAR5fzMTYOzIQ2m0sQVcQLkUbLkpjuUGcxQ==
X-Received: by 2002:a1c:720c:0:b0:37b:eb64:4fa3 with SMTP id n12-20020a1c720c000000b0037beb644fa3mr3233117wmc.93.1645045160334;
        Wed, 16 Feb 2022 12:59:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm8042155wri.74.2022.02.16.12.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:59:19 -0800 (PST)
Message-Id: <76d6e4fe517ed78dc86ca70d6da5aa67f06bd5cf.1645045157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
        <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 20:59:14 +0000
Subject: [PATCH v9 1/4] cat-file: rename cmdmode to transform_mode
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

In the next patch, we will add an enum on the batch_options struct that
indicates which type of batch operation will be used: --batch,
--batch-check and the soon to be  --batch-command that will read
commands from stdin. --batch-command mode might get confused with
the cmdmode flag.

There is value in renaming cmdmode in any case. cmdmode refers to how
the result output of the blob will be transformed, either according to
--filter or --textconv. So transform_mode is a more descriptive name
for the flag.

Rename cmdmode to transform_mode in cat-file.c

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950ec..5f015e71096 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -24,7 +24,7 @@ struct batch_options {
 	int buffer_output;
 	int all_objects;
 	int unordered;
-	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
+	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
 };
 
@@ -302,19 +302,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
-		if (opt->cmdmode) {
+		if (opt->transform_mode) {
 			char *contents;
 			unsigned long size;
 
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
 
-			if (opt->cmdmode == 'w') {
+			if (opt->transform_mode == 'w') {
 				if (filter_object(data->rest, 0100644, oid,
 						  &contents, &size))
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
-			} else if (opt->cmdmode == 'c') {
+			} else if (opt->transform_mode == 'c') {
 				enum object_type type;
 				if (!textconv_object(the_repository,
 						     data->rest, 0100644, oid,
@@ -326,7 +326,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
 			} else
-				BUG("invalid cmdmode: %c", opt->cmdmode);
+				BUG("invalid transform_mode: %c", opt->transform_mode);
 			batch_write(opt, contents, size);
 			free(contents);
 		} else {
@@ -529,7 +529,7 @@ static int batch_objects(struct batch_options *opt)
 	strbuf_expand(&output, opt->format, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
-	if (opt->cmdmode)
+	if (opt->transform_mode)
 		data.split_on_whitespace = 1;
 
 	/*
@@ -742,7 +742,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
 		if (opt_cw)
-			batch.cmdmode = opt;
+			batch.transform_mode = opt;
 		else if (opt && opt != 'b')
 			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
 				       usage, options, opt);
-- 
gitgitgadget

