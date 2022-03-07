Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B17C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiCGVvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiCGVvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB05A7561C
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q20so7692859wmq.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sclOhVe4EV0U75UTToLOlsrVExWmGOlFRPY6iEbDWEo=;
        b=YVhm/mJtgPTB/EzD2bqVSc9kdI7JgxOKOXa6nbQ92+wxTfdxKLOSsb4hv0kRw3YfQ0
         q3zsSNC0XtjWrTYRm393NNwCJ5gpCPTXGe2Y0fyad4hvwAR/mNIk3KP8He1brApkxrrr
         bgkQ+KYZxw01cAMBH79dw5iI6OOe+auNNB8F6H1TzPeqWgjIqR3FEYKu024Ih2Bgpy7P
         fFAvGybiBZvE5ygHWGTCyXXwIyq6DS/8DwQyUrmiHQnSBpIWerrXxrjB6XxZ/t2yFeA+
         VGDUYXweeOO9ASxps/u5pB9aFGFX5OF+VzrDaNkpwfPGbykVnIscm0RQ3/xexIyjhzRd
         yeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sclOhVe4EV0U75UTToLOlsrVExWmGOlFRPY6iEbDWEo=;
        b=tQa8tcjl5p003NaWF4Y9P8llZESeDjh1m0WT/HyXNBewUKQe2b7VCtYoYdG7MtSTrP
         WjoGLIMHMRl8LFWBJXt0lIUVfAci2w4DvOXxeqpOvpgU92/Y8gC0rMKmF+H4PTtdxyXc
         i2Ybq9Naju4KMPYVm5YZZXk++xGUBePdgLxYQfSwufKdgAkl7nMxgP1xuOFYbblps0Mi
         shhfeAm9tutgf5eH1TyVuxFuSBejCc1MYM0ZCLpLZjVHiU1geoDFfiAMSAvyByeFMAyt
         6IC3uHEdiA5CakTX2DcUWZISYXYqmvSn+W7kuQS70QXoO+PyLjlrAGBk2jsaoie4cJ9n
         4Z+Q==
X-Gm-Message-State: AOAM533rBIV6zbfZz3MqAyLT8VEmHVEpdyZv981DfngJnl6zrlZfMsSt
        7tTjIHqvI6ahyAVk/yUpIo0TSdlosiY=
X-Google-Smtp-Source: ABdhPJwC1LePd70KXpuvWlPF30xGKItwkRBnWCd/mMB6V2TJYcRgR8ryT4y7AgECs62hnzLelrCWHA==
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr829179wmq.130.1646689844217;
        Mon, 07 Mar 2022 13:50:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h188-20020a1c21c5000000b00385699a8993sm476157wmh.11.2022.03.07.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:43 -0800 (PST)
Message-Id: <3a88c99d9bc765bf4728fe0f0df1eed86adace0e.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:30 +0000
Subject: [PATCH v2 02/12] revision: put object filter into struct rev_info
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

Placing a 'struct list_objects_filter_options' pointer within 'struct
rev_info' will assist making some bookkeeping around object filters in
the future.

For now, let's use this new member to remove a static global instance of
the struct from builtin/rev-list.c.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-list.c | 30 ++++++++++++++++--------------
 revision.h         |  4 ++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 777558e9b06..6f2b91d304e 100644
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
+	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
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
+	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
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
+	bitmap_git = prepare_bitmap_walk(revs, revs->filter, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -597,13 +595,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			parse_list_objects_filter(&filter_options, arg);
-			if (filter_options.choice && !revs.blob_objects)
+			if (!revs.filter)
+				CALLOC_ARRAY(revs.filter, 1);
+			parse_list_objects_filter(revs.filter, arg);
+			if (revs.filter->choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			list_objects_filter_set_no_filter(&filter_options);
+			if (!revs.filter)
+				CALLOC_ARRAY(revs.filter, 1);
+			list_objects_filter_set_no_filter(revs.filter);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
@@ -688,11 +690,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
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
 
@@ -733,7 +735,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
 	traverse_commit_list_filtered(
-		&filter_options, &revs, show_commit, show_object, &info,
+		revs.filter, &revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
 
 	if (arg_print_omitted) {
diff --git a/revision.h b/revision.h
index 3c58c18c63a..1ddb73ab82e 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,7 @@ struct rev_cmdline_info {
 
 struct oidset;
 struct topo_walk_info;
+struct list_objects_filter_options;
 
 struct rev_info {
 	/* Starting list */
@@ -94,6 +95,9 @@ struct rev_info {
 	/* The end-points specified by the end user */
 	struct rev_cmdline_info cmdline;
 
+	/* Object filter options. NULL for no filtering. */
+	struct list_objects_filter_options *filter;
+
 	/* excluding from --branches, --refs, etc. expansion */
 	struct string_list *ref_excludes;
 
-- 
gitgitgadget

