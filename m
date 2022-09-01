Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C16EECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiIAJlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiIAJlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:41:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D7130627
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:41:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e20so21519180wri.13
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gU1Fn+L+0RDtC1OZCd5rrkOyjVxmCDcYGKf/sTgNgIE=;
        b=MWj2ZOt1fpIyHUZTRmm+hO/6CkW/IDFNeb1g13fxY6/xpdkfSB4W4zkUfqeg/H7Hf1
         K7CHw0m4zKKc6lr588H7PqjUTGEheCdEwy8+pCHGqM16ZchC3ax62Ozxx8EKqCUw15Ny
         DbW0bih/lXfZ5T+Kv1xKJeGErI24d8brAmIbAYsCxr6l+aymWByYM/Lh1xASkP0cTDo3
         JDfmVq2hWEB3xlyTQ3pNGICyJAc1j6LvHLhTz3AvwyXKjH7BzKhICnj+1OAO7erDA2kj
         ikwWWLYNwk9hGiTaxAL/mI1tClF8XRzOQi0EFVy7O+UX71s5OQWNxYok6cca50N/mW2u
         XQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gU1Fn+L+0RDtC1OZCd5rrkOyjVxmCDcYGKf/sTgNgIE=;
        b=dOydkolB8FCRMMiZ4VGCTXhoyQ9KhnnlBN45k/nmqg30vNP2CoyCt6+vlAGzECH0mq
         WvdrbPXkDvpF8EQ1e182w2l2qjVN/zuDotrnJMK8lrfecQrFV46wjIvXOAjyjBvV4rNm
         vpqM6b5TDRWkOyB8ZFZ0Z1ZHuNKJuQ+OLK6WFe2M8zvs/P1/HcV0Jc7/bDd4/ytZJmsq
         q+ltAaqzQ4croCYwLzDBRMRaA0lJ2HYmreuUov1cYdl8Si3OW9XcBISZ3fXWTnnPA+CJ
         kD+/9wG77KPeMXtSm7Paf6k0YRXkrm1JEj334LJ0ThKJQM35P80Yuu6MJ/OzFQn1asYa
         eImw==
X-Gm-Message-State: ACgBeo1ouxbxRh09QuwClmKjtXxqixf3vHk9YknCuEJpi5A/lijhxEed
        +tq845v269fnsgGH4C9HsazLVG/meuc=
X-Google-Smtp-Source: AA6agR7mOYTVZVGJREwNso4kGgJWfMU9x/ln3uZNkIc90ScPYUdwQSqw+ndRxrOY1LDgPmCYJfTs1w==
X-Received: by 2002:a5d:40d1:0:b0:226:d793:ccac with SMTP id b17-20020a5d40d1000000b00226d793ccacmr11539445wrq.238.1662025276324;
        Thu, 01 Sep 2022 02:41:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0021e13efa17esm14523729wro.70.2022.09.01.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:41:15 -0700 (PDT)
Message-Id: <0df61091c194ed46fda4d70272fcbcfdbedc8770.1662025272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:41:11 +0000
Subject: [PATCH 2/3] list-object-filter: pass traversal_context in
 filter_init_fn
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Pass traversal_context to all filter init functions, so that
we can read or modify the rev_info of traversal_context in the
filter initialization function.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 list-objects-filter.c | 12 ++++++++++--
 list-objects-filter.h |  2 ++
 list-objects.c        | 10 +---------
 list-objects.h        |  8 ++++++++
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1c1ee3d1bb1..76e8659ea73 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -112,6 +112,7 @@ static enum list_objects_filter_result filter_blobs_none(
 }
 
 static void filter_blobs_none__init(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
@@ -249,6 +250,7 @@ static void filter_trees_free(void *filter_data) {
 }
 
 static void filter_trees_depth__init(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
@@ -336,6 +338,7 @@ include_it:
 }
 
 static void filter_blobs_limit__init(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
@@ -519,6 +522,7 @@ static void filter_sparse_free(void *filter_data)
 }
 
 static void filter_sparse_oid__init(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
@@ -609,6 +613,7 @@ static enum list_objects_filter_result filter_object_type(
 }
 
 static void filter_object_type__init(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
@@ -734,6 +739,7 @@ static void filter_combine__finalize_omits(
 }
 
 static void filter_combine__init(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter* filter)
 {
@@ -744,7 +750,7 @@ static void filter_combine__init(
 	CALLOC_ARRAY(d->sub, d->nr);
 	for (sub = 0; sub < d->nr; sub++)
 		d->sub[sub].filter = list_objects_filter__init(
-			filter->omits ? &d->sub[sub].omits : NULL,
+			ctx, filter->omits ? &d->sub[sub].omits : NULL,
 			&filter_options->sub[sub]);
 
 	filter->filter_data = d;
@@ -754,6 +760,7 @@ static void filter_combine__init(
 }
 
 typedef void (*filter_init_fn)(
+	struct traversal_context *ctx,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter);
 
@@ -771,6 +778,7 @@ static filter_init_fn s_filters[] = {
 };
 
 struct filter *list_objects_filter__init(
+	struct traversal_context *ctx,
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options)
 {
@@ -792,7 +800,7 @@ struct filter *list_objects_filter__init(
 
 	CALLOC_ARRAY(filter, 1);
 	filter->omits = omitted;
-	init_fn(filter_options, filter);
+	init_fn(ctx, filter_options, filter);
 	return filter;
 }
 
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 9e98814111c..0a3cb500976 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -5,6 +5,7 @@ struct list_objects_filter_options;
 struct object;
 struct oidset;
 struct repository;
+struct traversal_context;
 
 /*
  * During list-object traversal we allow certain objects to be
@@ -72,6 +73,7 @@ struct filter;
  * filter *`.
  */
 struct filter *list_objects_filter__init(
+	struct traversal_context *ctx,
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options);
 
diff --git a/list-objects.c b/list-objects.c
index 250d9de41cb..698e4dbe8ff 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -13,14 +13,6 @@
 #include "object-store.h"
 #include "trace.h"
 
-struct traversal_context {
-	struct rev_info *revs;
-	show_object_fn show_object;
-	show_commit_fn show_commit;
-	void *show_data;
-	struct filter *filter;
-};
-
 static void show_commit(struct traversal_context *ctx,
 			struct commit *commit)
 {
@@ -448,7 +440,7 @@ void traverse_commit_list_filtered(
 	};
 
 	if (revs->filter.choice)
-		ctx.filter = list_objects_filter__init(omitted, &revs->filter);
+		ctx.filter = list_objects_filter__init(&ctx, omitted, &revs->filter);
 
 	do_traverse(&ctx);
 
diff --git a/list-objects.h b/list-objects.h
index 9eaf4de8449..44c598e9ce8 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -16,6 +16,14 @@ void mark_edges_uninteresting(struct rev_info *revs,
 struct oidset;
 struct list_objects_filter_options;
 
+struct traversal_context {
+	struct rev_info *revs;
+	show_object_fn show_object;
+	show_commit_fn show_commit;
+	void *show_data;
+	struct filter *filter;
+};
+
 void traverse_commit_list_filtered(
 	struct rev_info *revs,
 	show_commit_fn show_commit,
-- 
gitgitgadget

