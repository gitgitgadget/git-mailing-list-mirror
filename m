Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E1C4321E
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiCIQDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiCIQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6FE17F6A6
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l10so1669320wmb.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pltF+US/IVTKHV5tEnt42SamcuMBECOoZ121AD99wBA=;
        b=MDbZniDFT1GEqOypZqyZhFLcfKb/l1eXzODQLOeFaxl1A+0CtRwLByxzPjjEtPwYrO
         ClKz/nTxZBPqWjUSvutTzxsWg/qI9Nc4yglSCkhsjniaGK341aiXTjQKtvz5upmPvACi
         RYdjZhl2XJr2FxO3SvN8ZA7m1lhbmRstW+7GngRQQEmMU+9gqvqHX6ktElBI1KKONOJt
         yegbGvr+Wio4ElLw+y3KbiSJLkC/NuTKXbiDUD0+qa8pLzK7NwcfOBi4OrMSfvsSo5tX
         DLoCh9RswaPLPJLLKwMvOe/RkOKsJ6rEvndOy97I+GyY1ZcD3a8VUqn9lYYfOlwZsbgo
         WPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pltF+US/IVTKHV5tEnt42SamcuMBECOoZ121AD99wBA=;
        b=2R8eaQwqPk47EhsDW38RyozCyGrxmJH593PWZXDNLH+whmjIDDZGpc7Twk203Guh/A
         VZZPaMlsFsHgE2SilUrbtdXWETZXmU1jy2cIB7S0apLG115xHWHwETPjly1Ra5BOUaRr
         xKuKOrmYl+ndvZY04dh3UEOd9JYqplMavhNfOecIY11CXw8mTOt8AtJyuK5uFY5CTIZC
         /ZsYj6sffNRszbqgF866gf9ICWpL0sQn5RFdDPB8L1dYMD3ZS9kl/HkOn0M6/LHyl0nb
         rrU6ozauorTxGdNLtAh9YIvKtIQT+5CxAtAJX3YAb2ExGUrQe2Yx32X8fTq3Ck1gw8Py
         6QrA==
X-Gm-Message-State: AOAM531v+4F6iD5M726TL/wnn0lRI1UkJXO/8pv9T7410jcawxUidEw7
        XdDLjrjPJFmHWZDSkoOWdwfILhAEcvc=
X-Google-Smtp-Source: ABdhPJwefZyqvltdQz0dPoxCQ0e6dl2birMZU7q5a0KvZ/dRUMY1eDrpzOmCqUdl2eMSdPDwj6b/sw==
X-Received: by 2002:a05:600c:1c09:b0:389:d0a8:d3b7 with SMTP id j9-20020a05600c1c0900b00389d0a8d3b7mr50653wms.92.1646841709675;
        Wed, 09 Mar 2022 08:01:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020adf9cca000000b001f0236ba918sm1997660wre.35.2022.03.09.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:48 -0800 (PST)
Message-Id: <4ac09ddbfaa3f8aad2b77c7b250f6953a3ff9f24.1646841703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:33 +0000
Subject: [PATCH v4 03/13] revision: put object filter into struct rev_info
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

Placing a 'struct list_objects_filter_options' within 'struct rev_info'
will assist making some bookkeeping around object filters in the future.

For now, let's use this new member to remove a static global instance of
the struct from builtin/rev-list.c.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-list.c | 26 ++++++++++++--------------
 revision.h         |  7 +++++++
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 777558e9b06..1beb578cc51 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -62,7 +62,6 @@ static const char rev_list_usage[] =
 static struct progress *progress;
 static unsigned progress_counter;
 
-static struct list_objects_filter_options filter_options;
 static struct oidset omitted_objects;
 static int arg_print_omitted; /* print objects omitted by filter */
 
@@ -400,7 +399,6 @@ static inline int parse_missing_action_value(const char *value)
 }
 
 static int try_bitmap_count(struct rev_info *revs,
-			    struct list_objects_filter_options *filter,
 			    int filter_provided_objects)
 {
 	uint32_t commit_count = 0,
@@ -436,7 +434,8 @@ static int try_bitmap_count(struct rev_info *revs,
 	 */
 	max_count = revs->max_count;
 
-	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, &revs->filter,
+					 filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -453,7 +452,6 @@ static int try_bitmap_count(struct rev_info *revs,
 }
 
 static int try_bitmap_traversal(struct rev_info *revs,
-				struct list_objects_filter_options *filter,
 				int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
@@ -465,7 +463,8 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >= 0)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, &revs->filter,
+					 filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -475,7 +474,6 @@ static int try_bitmap_traversal(struct rev_info *revs,
 }
 
 static int try_bitmap_disk_usage(struct rev_info *revs,
-				 struct list_objects_filter_options *filter,
 				 int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
@@ -483,7 +481,7 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!show_disk_usage)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, &revs->filter, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -597,13 +595,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			parse_list_objects_filter(&filter_options, arg);
-			if (filter_options.choice && !revs.blob_objects)
+			parse_list_objects_filter(&revs.filter, arg);
+			if (revs.filter.choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			list_objects_filter_set_no_filter(&filter_options);
+			list_objects_filter_set_no_filter(&revs.filter);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
@@ -688,11 +686,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		progress = start_delayed_progress(show_progress, 0);
 
 	if (use_bitmap_index) {
-		if (!try_bitmap_count(&revs, &filter_options, filter_provided_objects))
+		if (!try_bitmap_count(&revs, filter_provided_objects))
 			return 0;
-		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_objects))
+		if (!try_bitmap_disk_usage(&revs, filter_provided_objects))
 			return 0;
-		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_objects))
+		if (!try_bitmap_traversal(&revs, filter_provided_objects))
 			return 0;
 	}
 
@@ -733,7 +731,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
 	traverse_commit_list_filtered(
-		&filter_options, &revs, show_commit, show_object, &info,
+		&revs.filter, &revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
 
 	if (arg_print_omitted) {
diff --git a/revision.h b/revision.h
index 3c58c18c63a..b1669a8cc33 100644
--- a/revision.h
+++ b/revision.h
@@ -8,6 +8,7 @@
 #include "pretty.h"
 #include "diff.h"
 #include "commit-slab-decl.h"
+#include "list-objects-filter-options.h"
 
 /**
  * The revision walking API offers functions to build a list of revisions
@@ -94,6 +95,12 @@ struct rev_info {
 	/* The end-points specified by the end user */
 	struct rev_cmdline_info cmdline;
 
+	/*
+	 * Object filter options. No filtering is specified
+	 * if and only if filter.choice is zero.
+	 */
+	struct list_objects_filter_options filter;
+
 	/* excluding from --branches, --refs, etc. expansion */
 	struct string_list *ref_excludes;
 
-- 
gitgitgadget

