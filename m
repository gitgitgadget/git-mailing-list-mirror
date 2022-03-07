Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA2FC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiCGVv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884397562F
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l10so6182215wmb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMqisOwNxGJZM+rj/78LU6orxR1EXwydOnTcmjLNxVs=;
        b=RXpJtRO5ltJNq9QcBKb2zMQbbiEwrR0cWNby/n+ohn+OWidJ1lStn+owQ5vcGtMy4Z
         SEO0eVNwURrWl4FyVSpRqjs0LQEWil9FewtTIDOPpU1+yMYMlf/+FlUIFwlO/AwYVsM1
         xY2P2DMZCSss+wuQkthNcPj/4GP5g0iCP6TzlMes97LHhwqq/t+TMS0GMzrEmyC+iche
         u2ZWOoEhax7xblNTxkj2ZvNzoN6AAY3/psY6tf450IK8Mk6+7ovGQOer/hZFQ2Z9q9qE
         Jldhe3DZihaPu1ijYpCTn+uTZvFHXl85Pzl0aK5wLUfOPzWtStCN21oQNmN4VYRdtTF3
         LdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QMqisOwNxGJZM+rj/78LU6orxR1EXwydOnTcmjLNxVs=;
        b=dEBi1vyEGlI44Q6yta+QcthUWDCzkOqoOUSBGpqy+pSA102yz5Quy1SZR9f2bSeEka
         2m7UPCLXE9AcSOCWV3tHcjbe4RVnsN7gCbNVCTGTu1sdiUB7vb1kktEqL2GnindE2imk
         zuiHcF847UkbxRqheFyPbFI25Z2h/TSPmOTMGo4YMTlCK5DgDgJdBye44YonRD5O/X09
         8ksCfnxXoFAZKBJRByarftPT/hSC2Gqs8l785tTZUagfOUIHAqYABQ9wb3m3yJ9EV7BE
         n0hBVMrlvw67ixqV3mfJbtN5BQZops5LRjUHdRsSekof5RIc2ufV9rXLDfKj85Uc57HT
         +rmQ==
X-Gm-Message-State: AOAM5305Mk1ez9mLCi8vepQePdGyUETrjm8Z26y2R72CrplwF0ysVz8z
        q1Z7lAUNJ3OXxX+rHr/WuDW3+ap3mfQ=
X-Google-Smtp-Source: ABdhPJwX25+i/TLYcPpuLQ0wmoGf0biRU2uq/VyFfqZqtPgfhLapSZXGGnW9gqdl3R9X3c6yxcs1dw==
X-Received: by 2002:a05:600c:1c25:b0:380:d306:1058 with SMTP id j37-20020a05600c1c2500b00380d3061058mr841675wms.150.1646689846703;
        Mon, 07 Mar 2022 13:50:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d56c1000000b001f0626c9360sm11013250wrw.44.2022.03.07.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:46 -0800 (PST)
Message-Id: <bcb76a065bf977c53e32bdb52fb59087adf09159.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:33 +0000
Subject: [PATCH v2 05/12] list-objects: consolidate
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

