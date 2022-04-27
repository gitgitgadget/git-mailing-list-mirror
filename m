Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA35C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiD0STw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiD0STk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55242AC60
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l16-20020a05600c1d1000b00394011013e8so1304155wms.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kmRhr3MUwD/F4lNde5G+0NGyyrjYIY/ktlBil4PtfRQ=;
        b=KFGeUclRI70t+y+BfGLsuqFB/ypydy7TZFcrdL2sjXw/bPdVG2urOy9+FAj2U2oRFi
         ImEZv9FitWvwVaVmhz9Aj0zfQ5ixGFxqRSuuOS0B2gnYJPHokZqvQBNRjlG3irEOJqno
         0X1fwepbA2UVwCKpQUfxd9OzuWNF9ukzeyhXcV9i2XHXNmz1tyLP07jGGJ8wPfjYE6Bb
         lDWpYmo6764Kqe0af/ST5keZqlc/Ia7GYIhht9EYOnsYAx+kAfZQRf5cjHqqEndMlchY
         7W8VGns2n5aNZ2Jm9XjwfalMcPzvVkiBWEBlqes109T2WjUWKe+ucpx0r7lkx8bu0Zgd
         Y7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kmRhr3MUwD/F4lNde5G+0NGyyrjYIY/ktlBil4PtfRQ=;
        b=VKtGlO1sIxJz7K+RdCXyPiG35TUxvCCC+dyOBKBYeGnDz5WQAZgIMjxL/81X/xeVLn
         s6TiBJqQlL6XW60PTsZppptIfpn7IjH6apOyASSL5yTbYQiOvwjKkXzh0VkmX2BxLass
         sAEGwcJMo/WwXqxCilv9wj5D8Kw7XAmpJ9nYjaMNCc/jHRjf42AveCENLQdjsHwDVt9J
         y7uXBj+H8RfG9Vr+4u3KwpRKnEXXYkizZHHjSOsVESKflNNgtlVPD+qyM4oG9y0NvXbz
         EKX1FMkFE2TkuMaYGn3LfmttEluwb0TaIFG+1XBNT4ieqrkheG+T8vhhdqVPXTrLPMee
         5cjw==
X-Gm-Message-State: AOAM5335DVtwuDYXlZ/PVQd8vnaXJ2D8bLJ7WmyCHzFocn5/lPEat69i
        q2j0adruZTPE3g7IFZqCfLzuCyQjzJc=
X-Google-Smtp-Source: ABdhPJx+F2y/lOQNgd/qVWqXyguqXeWBvrcF7LNKxRaQtSYIRsT5DpAasvriS3cM00czC2Z+uUem0A==
X-Received: by 2002:a05:600c:a47:b0:37c:965:2b6f with SMTP id c7-20020a05600c0a4700b0037c09652b6fmr27274655wmq.31.1651083386142;
        Wed, 27 Apr 2022 11:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e5ca446bcsm2091096wmp.5.2022.04.27.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:25 -0700 (PDT)
Message-Id: <42550f39a756c862222ab7ef2e665b87f727f8fa.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:15 +0000
Subject: [PATCH v2 4/7] read-cache: set sparsity when index is new
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When the index read in 'do_read_index()' does not exist on-disk, mark the
index "sparse" if the executing command does not require a full index and
sparse index is otherwise enabled.

Some commands (such as 'git stash -u') implicitly create a new index (when
the 'GIT_INDEX_FILE' variable points to a non-existent file) and perform
some operation on it. However, when this index is created, it isn't created
with the same sparsity settings as the repo index. As a result, while these
indexes may be sparse during the operation, they are always expanded before
being written to disk. We can avoid that expansion by defaulting the index
to "sparse", in which case it will only be expanded if the full index is
needed.

Note that the function 'set_new_index_sparsity()' is created despite having
only a single caller because additional callers will be added in a
subsequent patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 read-cache.c                             | 18 +++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4df97e185e9..60355f5ad6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2260,6 +2260,20 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 	return consumed;
 }
 
+static void set_new_index_sparsity(struct index_state *istate)
+{
+	/*
+	 * If the index's repo exists, mark it sparse according to
+	 * repo settings.
+	 */
+	if (istate->repo) {
+		prepare_repo_settings(istate->repo);
+		if (!istate->repo->settings.command_requires_full_index &&
+		    is_sparse_index_allowed(istate, 0))
+			istate->sparse_index = 1;
+	}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -2281,8 +2295,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (!must_exist && errno == ENOENT)
+		if (!must_exist && errno == ENOENT) {
+			set_new_index_sparsity(istate);
 			return 0;
+		}
 		die_errno(_("%s: index file open failed"), path);
 	}
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 75d844cd71d..85c6a56f1b7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1389,7 +1389,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash drop stash@{0} &&
 
 	echo >>sparse-index/deep/new &&
-	! ensure_not_expanded stash -u &&
+	ensure_not_expanded stash -u &&
 	(
 		WITHOUT_UNTRACKED_TXT=1 &&
 		! ensure_not_expanded stash pop
-- 
gitgitgadget

