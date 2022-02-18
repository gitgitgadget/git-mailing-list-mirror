Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EBC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiBRSXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:23:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiBRSXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:23:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1648E42
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f3so15812366wrh.7
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=fF+8V4W9BhV4mM7LT6Ph2VtqW6ingO7e/Uc5ZuCjeWaaXMXso+ugptT0APbYS/Hsyw
         dwODCh+l7yfvjUqciJmC0SdFyW1G0C0Uo900Cu+z1g0eEa2kJMSdnJrKcoYrezEyznDD
         MmANpNHByP2Miru8LWFZR9GPy4Zh20EYz6vvCxzPLu1y0IeEKkT05Z6GJKBMIwOzPCOY
         L2B5CyeYnj98+oPIoQp4yKvgvQWItzhv3VgqhyLo1rCBsifXwaTfdVVp3CP8Yd9x9Dhz
         5WKuwk/uCkc31wXm/p+g41Nat1lBwnGipo+so4k45H9NHV8cm8S3/lDhXr7PFEz0Pg35
         gYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=M0sB+sm+x9Dz9/KBMhgRWcW0KYncsncj9nITUVsUOzWvaZbt7bj+k+vdAoBBS2GMjJ
         C0o+2tKb//FkJ0Xs7DFWGLY5aIIRFN+3o/uLHhVzjQWMTEbC5a9SOU2MC+2or3AM37OK
         PbgG2BXyQ2I2m/pJSM9Qshng+vqH7IHBXM0Ptv5qFJpDGpk307lPWTUBGWeSDx5s3k2p
         kKcZZZ9hAlXWm34AjdgeV/xf2IKkS8E0Y6bU3wskOkyTMGIiN4B9ThSuGNzqkQtCNnFi
         UuTdUcEjov5nel+WBWG5zyvXTBoG7OU44LZ/j1UJ4DPzSXgrZnwZGU9A7B9QFOAKQKgY
         ir1g==
X-Gm-Message-State: AOAM532lp3fIxM1/cj5SF3RdPpz/zQHERgMrGILGjasnZeM7SRS5GfkZ
        TMg5FJkzGx5eQGf1h3FzgVben7YDNEs=
X-Google-Smtp-Source: ABdhPJz+dj2gVcoqk1QjPIT+evQ5ncLOfGI477CmFU01u507a+4wD6elAI40SYq1hbxFlV/xu5eaug==
X-Received: by 2002:adf:8069:0:b0:1e3:24d2:21d2 with SMTP id 96-20020adf8069000000b001e324d221d2mr7100139wrk.415.1645208596806;
        Fri, 18 Feb 2022 10:23:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16sm12572026wrm.19.2022.02.18.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:23:16 -0800 (PST)
Message-Id: <76d6e4fe517ed78dc86ca70d6da5aa67f06bd5cf.1645208594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
        <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:23:11 +0000
Subject: [PATCH v10 1/4] cat-file: rename cmdmode to transform_mode
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

