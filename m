Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B98C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbiCHOka (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347540AbiCHOkY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1058B38D8A
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so28854104wrg.11
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMqisOwNxGJZM+rj/78LU6orxR1EXwydOnTcmjLNxVs=;
        b=OnChC/RMfqrJ5BhRVTD4jcfvsKZ3kk/HYk9qC44bcR20sppo1E6q5Nc+HEqNyRH3xr
         AcFz2ixn1xqHJ4Zxk9DU9/PP08brvBe6ucVoUW+qg6DLKOtohp11FO0IRzaF7ro256ZH
         uko9Rfn6kKGUhsQ8e11+FQGoaOoarcEusi0YU2yB11XrCfkSZw9b+mJES5bLWIk4k9AO
         oic2g3XYHUT8HdCBMZAI3DYCEFBekG63TyRO3U7Lfi6f/tXRgreS7hp+grWvBfwHWYi+
         bGQUktOI0ie54Pu6mq/mrQn5N9Ri+/SX+NOGeA9jhGmfnEsli/A5q3VGYwdcFrpDBUnz
         1Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QMqisOwNxGJZM+rj/78LU6orxR1EXwydOnTcmjLNxVs=;
        b=0y1x0S3gi1eUqE1/q1aAgjY/c+6Nq2anBtzsGkdayizJsTSGKxBh2Asvk5GKa0zR18
         PoduzRnL6uPxy1r5ghUcqp9Y+/oG4RIsGN1Q1F8DU+oJ+BkJSpyPKDT9POoXfoF+FV3B
         Uu6nX+sgObQ06zKTeudpcfmd8OHOBDrqvpMHASIR4uHPuiDFyjOi7ntdBPpuG1Khnbyo
         MQsbPKdESIP248abNMMqjgRgfebfWkoIkexvzAwPZgEKHt6KnLNTB5ZAMK5YV1ts3uC1
         v4kZSrj6o/rsJindPgzbGuCOvVAPVLfCEOPN3hKxVNDXy+6ktRlIttF8h228Ej5k9/Wo
         uGsA==
X-Gm-Message-State: AOAM533Up6TsXjwH6r0Lmx2nl0REm8JW4q1eyJF4Bkc3tJRhsray9sN4
        UO4QJwzl4B/Zip8q58aviNDrch28dbE=
X-Google-Smtp-Source: ABdhPJyPIqduyQfiLMacFA6edcuDnZoEuv9GHNhQkH0eD91vVMCmF3ZCASuTCOz++G488O/R8HCoEA==
X-Received: by 2002:adf:ea0f:0:b0:1f0:61f6:c3df with SMTP id q15-20020adfea0f000000b001f061f6c3dfmr12504042wrm.543.1646750365449;
        Tue, 08 Mar 2022 06:39:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003897e440047sm2552400wmq.28.2022.03.08.06.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:25 -0800 (PST)
Message-Id: <bcb76a065bf977c53e32bdb52fb59087adf09159.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:12 +0000
Subject: [PATCH v3 05/12] list-objects: consolidate
 traverse_commit_list[_filtered]
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that all consumers of traverse_commit_list_filtered() populate the
'filter' member of 'struct rev_info', we can drop that parameter from
the method prototype to simplify things. In addition, the only thing
different now between traverse_commit_list_filtered() and
traverse_commit_list() is the presence of the 'omitted' parameter, which
is only non-NULL for one caller. We can consolidate these two methods by
having one call the other and use the simpler form everywhere the
'omitted' parameter would be NULL.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c |  6 +++---
 builtin/rev-list.c     |  2 +-
 list-objects.c         | 25 ++++++++-----------------
 list-objects.h         | 12 ++++++++++--
 pack-bitmap.c          |  6 +++---
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 57f2cf49696..0432ae1e499 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3778,9 +3778,9 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(revs.filter, &revs,
-				      show_commit, fn_show_object, NULL,
-				      NULL);
+	traverse_commit_list(&revs,
+			     show_commit, fn_show_object,
+			     NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 556e78aebb9..3ab727817fd 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -733,7 +733,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
 	traverse_commit_list_filtered(
-		revs.filter, &revs, show_commit, show_object, &info,
+		&revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
 
 	if (arg_print_omitted) {
diff --git a/list-objects.c b/list-objects.c
index 2f623f82115..9422625b39e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -416,22 +416,7 @@ static void do_traverse(struct traversal_context *ctx)
 	strbuf_release(&csp);
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *show_data)
-{
-	struct traversal_context ctx;
-	ctx.revs = revs;
-	ctx.show_commit = show_commit;
-	ctx.show_object = show_object;
-	ctx.show_data = show_data;
-	ctx.filter = NULL;
-	do_traverse(&ctx);
-}
-
 void traverse_commit_list_filtered(
-	struct list_objects_filter_options *filter_options,
 	struct rev_info *revs,
 	show_commit_fn show_commit,
 	show_object_fn show_object,
@@ -444,7 +429,13 @@ void traverse_commit_list_filtered(
 	ctx.show_object = show_object;
 	ctx.show_commit = show_commit;
 	ctx.show_data = show_data;
-	ctx.filter = list_objects_filter__init(omitted, filter_options);
+	if (revs->filter)
+		ctx.filter = list_objects_filter__init(omitted, revs->filter);
+	else
+		ctx.filter = NULL;
+
 	do_traverse(&ctx);
-	list_objects_filter__free(ctx.filter);
+
+	if (ctx.filter)
+		list_objects_filter__free(ctx.filter);
 }
diff --git a/list-objects.h b/list-objects.h
index a952680e466..9eaf4de8449 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -7,7 +7,6 @@ struct rev_info;
 
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
-void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *revs,
@@ -18,11 +17,20 @@ struct oidset;
 struct list_objects_filter_options;
 
 void traverse_commit_list_filtered(
-	struct list_objects_filter_options *filter_options,
 	struct rev_info *revs,
 	show_commit_fn show_commit,
 	show_object_fn show_object,
 	void *show_data,
 	struct oidset *omitted);
 
+static inline void traverse_commit_list(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	void *show_data)
+{
+	traverse_commit_list_filtered(revs, show_commit,
+				      show_object, show_data, NULL);
+}
+
 #endif /* LIST_OBJECTS_H */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 613f2797cdf..cbefaedbf43 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -822,9 +822,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
-		traverse_commit_list_filtered(revs->filter, revs,
-					      show_commit, show_object,
-					      &show_data, NULL);
+		traverse_commit_list(revs,
+				     show_commit, show_object,
+				     &show_data);
 
 		revs->include_check = NULL;
 		revs->include_check_obj = NULL;
-- 
gitgitgadget

