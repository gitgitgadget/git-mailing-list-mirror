Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83880C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHGC5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGC5S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:57:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF28B34
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:57:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so7329377wrh.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oyrQE6FVXaEt+jquEbYsdAUH9nWe19rHeEkyJVthEdI=;
        b=FhuTBD995TAZNR40o33HJ1BuAmCtG1jH12dR6W+7vmOYsuJdfCmSKbcsGdqEEN7MSt
         0/usqY1WsedH3iPY3Rvrtq1rTTROyb5l8sRIf1Sqbvi0oPiQL3JCBZ0uj9ZrqXjTrOTI
         X6dhpBDBaBZNS7rMo3CuRuum3fADyYMqynbrV/wFI+lSgPYJHQl71WuaLPNGrTj5MG4r
         Gj7IrS8JVc5t5PU0sLidhM1JbCUFEVvN2QwD2ZbnlYLRkT8x2GTCjyonGthwvxMzbdad
         TCNJKk6w1U+cg8ak1CwrAL4+vVfr64i2rfmR2dUFOvGixvCwULWlVV4QwA6id+XY/N1Y
         ss6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oyrQE6FVXaEt+jquEbYsdAUH9nWe19rHeEkyJVthEdI=;
        b=0llP4vQvDolnCQdk7LphQKphTPA22W1kvMz/kWzwZKHGprReyu8seqegsPwpTUAoMi
         kKCAjqPcikc4JJrd87vL++WyiKPqYbLhd9zYuIw0zMQxvduyxW6D5lSa1evSzpWVZWsn
         oijEbwcV9dYdF5tRsL5aK9CuUx8gLsAHGKE/y1ia2cND2DjFAoXGjSn27HJfMzwgSh5i
         azwmWUy6/4TJPZ9ZGQa9zUB9YB7C3tMpQIcEhPVV28VASjxrg1rizTapfuWmS0vHl7yo
         CNBwjoJ/btXM6wNAtjIWxJKkJ4/sBeQ8lwLktxS0HkaaQXykpUe70g5mVJrychvZF9p/
         yJSQ==
X-Gm-Message-State: ACgBeo2nWBluW85e3KnSWqvq3Q+Lwdv+4R4gw5p7i6rtSlB74P5VTOh8
        Mf/FjTjcEGAkLG4Aj0HYssx6OaNCzgY=
X-Google-Smtp-Source: AA6agR790X/ceJJRn3ntkhRAzYWnuj5f4GoVC8oytVxH1ALtOoISf3XS6exTXjtVzBbpjY1mSRTetQ==
X-Received: by 2002:a5d:6d0c:0:b0:21f:ba0:ff7f with SMTP id e12-20020a5d6d0c000000b0021f0ba0ff7fmr8577070wrq.76.1659841035678;
        Sat, 06 Aug 2022 19:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c414a00b003a32167b8d4sm15386390wmm.13.2022.08.06.19.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:57:15 -0700 (PDT)
Message-Id: <55c77ba4b291fffe3031fbef67dcee9aa91a105c.1659841030.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Aug 2022 02:57:07 +0000
Subject: [PATCH v2 2/4] oneway_diff: handle removed sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'do_oneway_diff()' to perform a 'diff_tree_oid()' on removed sparse
directories, as it does for added or modified sparse directories (see
9eb00af562 (diff-lib: handle index diffs with sparse dirs, 2021-07-14)).

At the moment, this update is unreachable code because 'unpack_trees()'
(currently the only way 'oneway_diff()' can be called, via 'diff_cache()')
will always traverse trees down to the individual removed files of a deleted
sparse directory. A subsequent patch will change this to better preserve a
sparse index in other uses of 'unpack_tree()', e.g. 'git reset --hard'.
However, making that change without this patch would result in (among other
issues) 'git status' printing only the name of a deleted sparse directory,
not its contents. To avoid introducing that bug, 'do_oneway_diff()' is
updated before modifying 'unpack_trees()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 diff-lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 7eb66a417aa..2edea41a234 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -466,6 +466,11 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
+		if (S_ISSPARSEDIR(tree->ce_mode)) {
+			diff_tree_oid(&tree->oid, NULL, tree->name, &revs->diffopt);
+			return;
+		}
+
 		diff_index_show_file(revs, "-", tree, &tree->oid, 1,
 				     tree->ce_mode, 0);
 		return;
-- 
gitgitgadget

