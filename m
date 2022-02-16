Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D1C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiBPPCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:02:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiBPPCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:02:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285B2982F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v12so3972140wrv.2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=WlM9IuvK53NeYZg3rmRoNPRrkVUrrfi3R+llzFSTQJ7MtRCmaU0zT5S1yLppI/o3ro
         +X3ItFdggO5RfdwFb5Js2c/FmPKQN7Xz5tGjyp44FuFt/gkauyu+ytPVUTYKUSi9d9sK
         lwCYBOVpCitu7QxxK+2Sz+NzE+9s9DJwSFOfazmnCTJS8oZb3oul2SReDkWG21hEjGO7
         hoa4mKqdVG6OqKOMPHUUj2aCkmZ2UINoW8SVp23joE+p9rk6yMsMRiyWqxrYwf0rxvfI
         +sOsnjwxzdYODTDfJfWG403XmgrwRc8h/J3gqqm3+LK77INabcbr/jJwK95yQCEM9YKJ
         X+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=794hPAGxUKV9QrWNyu/szhQpQsg/vRTaDfJ1ewwkpPWHGOE52h6lM3NQerheciUTYR
         pO6JYFyydiNH/sjD+ln4KMKc4OzH0KwsyAqz6Xxgcfz7AdGkbZtWFfJgWSkl+AnMZics
         27N0Txyzh3nJxPsJmwrR5+yCp5rEcsHwNRZveSdoEHRgZOyiTIV+imv8pQEw8tXkSk6B
         R0AKsJFprwH2ThCp/KOYGtGthebSVHaGbb4G0BENXwwTEjft+CXs7H46y+JZv2d/qjXl
         c9/AmBjo43EJ9utG9N4tvOSqW9eVX4feJjEBjMBVmYw17C4yFIYAg505/lB2gKWXfkLu
         SC6A==
X-Gm-Message-State: AOAM5316gsMnqMnz/H2LVNJOQEzOfDR6n9TVWYr3ZMXC6VDamNfKhjbb
        p+ebeHiahLr+C1zjtjO9Ly/+EjKTmAU=
X-Google-Smtp-Source: ABdhPJxwHGUBusaYaNcY9xGCXVQkcgjrMDR5vi75ggxgaE3eDtlUsxwwXcVP6Rjyw8SMGXsLEFQIYw==
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id i5-20020adfb645000000b001e30bab7594mr2661767wre.346.1645023743045;
        Wed, 16 Feb 2022 07:02:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm40354735wrd.8.2022.02.16.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:02:22 -0800 (PST)
Message-Id: <fa6294387ab223d56e6ab66448f1ebe1ec370cd7.1645023740.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
        <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 15:02:17 +0000
Subject: [PATCH v8 1/4] cat-file: rename cmdmode to transform_mode
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

