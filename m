Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3578DC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiBJEBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBJEBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:01:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC924587
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:01:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so7190170wrg.12
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=Yg0cIQpDlzP2XAf6PZq47V/eFCrMoCQqd40ENbXXCC/Zp3i5FbCxqn8YmJVp5U3FZY
         kYcsExU/5lQAWTUgoZBWJ/aJ7hQ4CzTxM6CPRDkcVIXgjIaYJQKtLDzmrQz7q/Kaf/d5
         xZbOMkmVe++59UJbhqTDOAxgo7L3KIVTO3lCg/7+nx+hFZWqydI2KmpD9c2+D35RSZZh
         wjIs4tajIJEXswH9LVqmXBxpBkbmOEmeEI6EYxH1c+qJRMzkbDZnJrjTFROGAGTOUzT7
         gXSN25m9PwJARGh4RuLF2aqWIVqambHFGm3wY2tlx5ru7+kQWgbfoMIC0de2BpybVfnY
         1ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=ee9bjdG5GcIgY2UPK4UESa627g2avwPBVFAJY/+WQtb2OBTcxTlOfrDiTrnG9U8rWc
         2utJETk7/LKDqpfE865yEOdK1j00+cQPne4TKArJqRewWLF9XKEOme+EDPRnxNzlhHxp
         96WQNflRuj7ENij4Mukqy9LOI0EV2aNej2GSHZUHZdfQ14jRIBhupBhfREJnwQVgI1Uf
         xxTt7G0usCuB4Y3o4926+80L7H9DskCZEHzdkSqmVyMZcoFxX/YCoZb1wlm+3T3o/kTh
         FfVGuGri1jU8YPlS5KUjS58SsKU7xDLkGA2S65mv5bm8HzUw/GNSMc55yutjJZCw2JhH
         Zrjg==
X-Gm-Message-State: AOAM5317AfQ6qIOQvel9ZHYm3qMnHmPglfPZDEjIy30M+2F1hfYSvE1o
        zVmV8aZYn/PDaZz+hWU8DODLrq+3Dv4=
X-Google-Smtp-Source: ABdhPJwbC4QqkXGSUZBrE9blDAovp6Bi7aHRfhH8yjQ/jSNXcA7fRsemsD5U6R19MW8CxeSETtfkmQ==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr4516282wrs.458.1644465707833;
        Wed, 09 Feb 2022 20:01:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm6014791wro.89.2022.02.09.20.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:01:47 -0800 (PST)
Message-Id: <fa6294387ab223d56e6ab66448f1ebe1ec370cd7.1644465706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Feb 2022 04:01:44 +0000
Subject: [PATCH v4 1/3] cat-file: rename cmdmode to transform_mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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

