Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA5C43219
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiCIQDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiCIQC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8135E17AEFD
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t11so3777834wrm.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SkhrWJVmdGpCICyM+CSYFhQSLcZUmg6mmBvJFAffoaU=;
        b=aUylwLurY8xoTeejrVWre2ubCwby31NWA2FRqTi3gZ6WDnmdFaGT9Xm3eTR1SnDgtD
         jlbVHr1is4tiT/dSgSXfbfAYgI7z9YB9Mcuwofaixw+oehn3NTrXf296fyJOQTcMD3JB
         /Kze16c9Ev6aNVIxAPR1pq3jl6K1RhgTMr59X4hzxWh/tnzXjazG/NfV/Jwg0+YIFSUq
         Bv+TGWa5pFJcen8H+AhU+8a0W5gUm4gfUukJcE6tjBbX56gtVP+pl5X7qZnzM4v8cgUv
         BCdDpcl/WuxLBe7h8rDWPfg9dyxTCWc1yyqAGnCiUxCeteOYvpDRlih4k0aKdNRXHQMd
         0OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SkhrWJVmdGpCICyM+CSYFhQSLcZUmg6mmBvJFAffoaU=;
        b=IEhnphRoXJ9BXxjUP1dw6YJ2Ai5Wql2sSmGTNdNqktNpmgh8Y0u0hI3stpGKkraCTQ
         AIUdnTYzLbnygoumri6T+wE+/FzyopLhjQkyUsi4+oX692VVbi/ESkkIj2ZHB+uiM9aC
         Z4AancH4MMQRVRmnA+BDXDzi+M/QJa53Z4B5dMEeNo67wE+rMgXEBM1RUHdLlEYPLAU/
         YLtEv+s7eqKXhqX/OUox9cI7vCvtBfjbGgJZYEBZrZ5c3jT3mp7Xrmv25/2bXYos0p2C
         CFufqhD1sjS1nNYD2l2/2k0DCFf3l8nieM9Y5deeAMZOsvS+4DQ/6vAv5Ip7dUYCxYPm
         MoGA==
X-Gm-Message-State: AOAM531FdPF9yjg+afxvNiNZdI0Xp9pj0qmOhu+2lt9f1qdtqrySQSMC
        lg8/StPnVagogD1CIYz1py7M38CjERE=
X-Google-Smtp-Source: ABdhPJzho6/w+On9q8bz+jXhZeCg/Tmxh/5QPa7h37EyAIoqKNsJxl+RWbVXrPXBaHrj4vSGrTp2OQ==
X-Received: by 2002:adf:c792:0:b0:1f0:769:9ef3 with SMTP id l18-20020adfc792000000b001f007699ef3mr236295wrg.336.1646841712564;
        Wed, 09 Mar 2022 08:01:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020adff144000000b001f022290737sm1962437wro.6.2022.03.09.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:52 -0800 (PST)
Message-Id: <34afea8fcd620e8dd1e95f3e2918b47e226fff23.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:36 +0000
Subject: [PATCH v4 06/13] list-objects: consolidate
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
 list-objects.c         | 34 ++++++++++++----------------------
 list-objects.h         | 12 ++++++++++--
 pack-bitmap.c          |  6 +++---
 5 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bafce542778..b18724e32a3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3778,9 +3778,9 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(&revs.filter, &revs,
-				      show_commit, fn_show_object, NULL,
-				      NULL);
+	traverse_commit_list(&revs,
+			     show_commit, fn_show_object,
+			     NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ab7558bd66a..ec433cb6d37 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -729,7 +729,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
 	traverse_commit_list_filtered(
-		&revs.filter, &revs, show_commit, show_object, &info,
+		&revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
 
 	if (arg_print_omitted) {
diff --git a/list-objects.c b/list-objects.c
index 2f623f82115..117f734398c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -416,35 +416,25 @@ static void do_traverse(struct traversal_context *ctx)
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
 	void *show_data,
 	struct oidset *omitted)
 {
-	struct traversal_context ctx;
+	struct traversal_context ctx = {
+		.revs = revs,
+		.show_object = show_object,
+		.show_commit = show_commit,
+		.show_data = show_data,
+	};
+
+	if (revs->filter.choice)
+		ctx.filter = list_objects_filter__init(omitted, &revs->filter);
 
-	ctx.revs = revs;
-	ctx.show_object = show_object;
-	ctx.show_commit = show_commit;
-	ctx.show_data = show_data;
-	ctx.filter = list_objects_filter__init(omitted, filter_options);
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
index 37fa4905796..97909d48da3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -822,9 +822,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
-		traverse_commit_list_filtered(&revs->filter, revs,
-					      show_commit, show_object,
-					      &show_data, NULL);
+		traverse_commit_list(revs,
+				     show_commit, show_object,
+				     &show_data);
 
 		revs->include_check = NULL;
 		revs->include_check_obj = NULL;
-- 
gitgitgadget

