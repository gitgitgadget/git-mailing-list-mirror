Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E980FC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbiCGVv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3651075C03
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i66so10016753wma.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RxrhDEZAKd1TxOQXR/q4fcpzONcBLxkiP9hpg49quRw=;
        b=TObw54wqsPynCm8Equ3SnoLUTrQFmbBGdG+B2hP+QUD6pjQ2kGbNywO2vCCJ/Cbbd0
         7Z6Ye3lIs7E1NPTA96OL3Dx4d0ncJVcnO3+FULCtbRPM94L4dCsUsQRv/L5K4PKLGdEj
         zmmeZshTf1RIBn+0+DyV1sNcW61Szvr07iPREVeyOKp6QGKrHXvk+HFLSBTrbBlJmjal
         9FHhC4keUWNw8eU0eDJGnNtg5+LBsZqPoLDLZhXCwJemHyMXSPDv2ATqchMIjZiilq1R
         /guSF0eQFndwAYR8OXnFXOq0KNkiLFU1sgMNDWJ8uacerr6kreNjMLUxe0O+617bTKVP
         CNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RxrhDEZAKd1TxOQXR/q4fcpzONcBLxkiP9hpg49quRw=;
        b=frqJ+xBv0wVSsJ8ubIxLG7gzS2HwNK6rSSUV0Rj0Qvvsun0DO9Na8dAJyGOQJvP2QA
         2mbBSDiVx/QJjl+QvztaTIXkk3MgPL/dAUYq1JPa15G8Ouvpni3OpFGzPPbicgJ+rI13
         c4jUYe63Qyh261+va9LLDGZiZWn2UKqRJEqJyQqOyeQStVToWkYFx5NfpcGzn8sJ66M4
         lq9g6VJP2W7nu6SUAPgPJEQp0KwVC6+htUJQg248O6InYyt2efuwKgLVS3shswoMFWRh
         j5r13P3BSrx+H9o/qH/OLmEz5p7fstEz9vOgub02Ko+hkvIr2yMs+2OYj0mQ9yyjTIfR
         50yg==
X-Gm-Message-State: AOAM532BCBDWyBcJp8oKnZZqwJzsm9YIlOallPAViF9ZfAD8u8Cr8mS4
        eZgt7Q59wRfSXljl3XEAVDg4s9vFFsE=
X-Google-Smtp-Source: ABdhPJwH4niTuJt9l1mVRlaXiMWwuImRvTXM0YWishQ3K6/iiTLZA2CBkbQ5k5+ap1Sa9DF38rPiAw==
X-Received: by 2002:a7b:cd90:0:b0:389:7e42:b5d1 with SMTP id y16-20020a7bcd90000000b003897e42b5d1mr832980wmj.55.1646689847631;
        Mon, 07 Mar 2022 13:50:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5-20020a1c3b05000000b00382871cf734sm436046wma.25.2022.03.07.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:47 -0800 (PST)
Message-Id: <efc03168818e9328d4d1f47f9d48fe2a46d1e2c9.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:34 +0000
Subject: [PATCH v2 06/12] MyFirstObjectWalk: update recommended usage
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

The previous change consolidated traverse_commit_list() and
traverse_commit_list_filtered(). This allows us to simplify the
recommended usage in MyFirstObjectWalk.txt to use this new set of
values.

While here, add some clarification on the difference between the two
methods.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/MyFirstObjectWalk.txt | 44 +++++++++++------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index ca267941f3e..8d9e85566e6 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -522,24 +522,25 @@ function shows that the all-object walk is being performed by
 `traverse_commit_list()` or `traverse_commit_list_filtered()`. Those two
 functions reside in `list-objects.c`; examining the source shows that, despite
 the name, these functions traverse all kinds of objects. Let's have a look at
-the arguments to `traverse_commit_list_filtered()`, which are a superset of the
-arguments to the unfiltered version.
+the arguments to `traverse_commit_list()`.
 
-- `struct list_objects_filter_options *filter_options`: This is a struct which
-  stores a filter-spec as outlined in `Documentation/rev-list-options.txt`.
-- `struct rev_info *revs`: This is the `rev_info` used for the walk.
+- `struct rev_info *revs`: This is the `rev_info` used for the walk. If
+  its `filter` member is not `NULL`, then `filter` contains information for
+  how to filter the object list.
 - `show_commit_fn show_commit`: A callback which will be used to handle each
   individual commit object.
 - `show_object_fn show_object`: A callback which will be used to handle each
   non-commit object (so each blob, tree, or tag).
 - `void *show_data`: A context buffer which is passed in turn to `show_commit`
   and `show_object`.
+
+In addition, `traverse_commit_list_filtered()` has an additional paramter:
+
 - `struct oidset *omitted`: A linked-list of object IDs which the provided
   filter caused to be omitted.
 
-It looks like this `traverse_commit_list_filtered()` uses callbacks we provide
-instead of needing us to call it repeatedly ourselves. Cool! Let's add the
-callbacks first.
+It looks like these methods use callbacks we provide instead of needing us
+to call it repeatedly ourselves. Cool! Let's add the callbacks first.
 
 For the sake of this tutorial, we'll simply keep track of how many of each kind
 of object we find. At file scope in `builtin/walken.c` add the following
@@ -712,20 +713,9 @@ help understand. In our case, that means we omit trees and blobs not directly
 referenced by `HEAD` or `HEAD`'s history, because we begin the walk with only
 `HEAD` in the `pending` list.)
 
-First, we'll need to `#include "list-objects-filter-options.h"` and set up the
-`struct list_objects_filter_options` at the top of the function.
-
-----
-static void walken_object_walk(struct rev_info *rev)
-{
-	struct list_objects_filter_options filter_options = { 0 };
-
-	...
-----
-
 For now, we are not going to track the omitted objects, so we'll replace those
 parameters with `NULL`. For the sake of simplicity, we'll add a simple
-build-time branch to use our filter or not. Replace the line calling
+build-time branch to use our filter or not. Preface the line calling
 `traverse_commit_list()` with the following, which will remind us which kind of
 walk we've just performed:
 
@@ -733,19 +723,17 @@ walk we've just performed:
 	if (0) {
 		/* Unfiltered: */
 		trace_printf(_("Unfiltered object walk.\n"));
-		traverse_commit_list(rev, walken_show_commit,
-				walken_show_object, NULL);
 	} else {
 		trace_printf(
 			_("Filtered object walk with filterspec 'tree:1'.\n"));
-		parse_list_objects_filter(&filter_options, "tree:1");
-
-		traverse_commit_list_filtered(&filter_options, rev,
-			walken_show_commit, walken_show_object, NULL, NULL);
+		CALLOC_ARRAY(rev->filter, 1);
+		parse_list_objects_filter(rev->filter, "tree:1");
 	}
+	traverse_commit_list(rev, walken_show_commit,
+			     walken_show_object, NULL);
 ----
 
-`struct list_objects_filter_options` is usually built directly from a command
+The `rev->filter` member is usually built directly from a command
 line argument, so the module provides an easy way to build one from a string.
 Even though we aren't taking user input right now, we can still build one with
 a hardcoded string using `parse_list_objects_filter()`.
@@ -784,7 +772,7 @@ object:
 ----
 	...
 
-		traverse_commit_list_filtered(&filter_options, rev,
+		traverse_commit_list_filtered(rev,
 			walken_show_commit, walken_show_object, NULL, &omitted);
 
 	...
-- 
gitgitgadget

