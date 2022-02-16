Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF4AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiBPAxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:53:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiBPAxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:53:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D1C7D4F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q7so749237wrc.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=JnMBN6oaP5Y7ECnetei3gASVaTigmcPdil4sM+KFvgxWfpS86lmsBGfjA0ojpQOiES
         /YSiTFnPki03VJczMtmMbxrAxeDwbHGKvrHFBgkoc5YHy86HzT3hXKJyxtRsVUPoLF5T
         rb83ONaN7k43VWPPJFv2jmkydgbKG07Qh+ovH5AFAOB8fEf+dnfx8b7ctVsjHVxOaQWv
         x0rgc/Ix3C6A+4X5DmAGyf9ZfrsJK/PygQnMN14FbtvzB+rNTf4V/AuCdxgFxbe7/4fd
         GuP5QIf+9B1weq+W68M1oYMBTmcpH9Vmhjwir45i/r6/gA6givkSuJc85Tu870CwX9jr
         rhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=mhRSJg/Ywvs2QAAAEUvGUjfYBy0+cW96vwD3EmnVmA2ZIQb/RB1Y7ozQU9vc1f5q6l
         +G8PoCaNTIptW7sVEH3zGBcEgF/2Eu/qWlY6HZavPR+/ZXnYjkD5zWlZD2o+wFFjUmH/
         X3OwWuRZRkUR01Lw4V9xUc3jHR9b3E7p2fS7FrP4pMRbsMkHxgw3rUiCEkqvuw4TuoXH
         rh/pt+Rc9PpgznYvYa3bGBJ3X8t7VWT2mXpvfKUvPVXaZ1hJ8B0LCwJvgFcF3zeD5URH
         qQKTVsBfs2C3//8+m1e7WxgMOBY3VF6URZ1iL8WuRC8Vc96HP1gD5huNYMuqptMPpQq5
         Tgog==
X-Gm-Message-State: AOAM533hE3ffKd9V1HP5oEI3eC06H9TXUH8dToyoTnrec5Vi34Mb+SNB
        W0fWUSyfCf8wuM0MnKWrgp7I5aKnrO4=
X-Google-Smtp-Source: ABdhPJzgF8uESX6RocpMOGAXjojpePN1nh0KogX1Ygcec2+n88morwQUGxSNFK7rxOe/HBGoIKDtNg==
X-Received: by 2002:a5d:64c8:0:b0:1d9:1020:1b45 with SMTP id f8-20020a5d64c8000000b001d910201b45mr341912wri.393.1644972812085;
        Tue, 15 Feb 2022 16:53:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm27930522wro.106.2022.02.15.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:53:31 -0800 (PST)
Message-Id: <fa6294387ab223d56e6ab66448f1ebe1ec370cd7.1644972810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
        <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 00:53:27 +0000
Subject: [PATCH v7 1/4] cat-file: rename cmdmode to transform_mode
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

