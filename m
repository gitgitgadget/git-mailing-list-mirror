Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB62C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiD0ST5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiD0STw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D732DD66
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d5so3641832wrb.6
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnGSgwjzx6yg1za1Z1HzxytFQ9bIIkcKN0GE008i7mY=;
        b=inPXdryFSAKAv9ZPGpcSWLt/jGCvzE0cXw+XHnoqXmyCze/wyTNUL38/skiu/c5cdr
         9mFyvRL6bgt3A56h7Y2iRv4OOO3WVG+evIOsk/g/6BWOLfv7NNa7K+OGpRVrRozhZvGL
         qoYPPtwE6K0Pc4qXq9y9+cOBb59ItV2HPI8cb59VkC6/F7OxmTjRXuwP9MawfeOPrPgL
         pM5A4sDIIcYsOnQGByZFn9CRR14pWiWTaY06fW9bfMEJE1todtFQe0XJ7SLyLmrUgaTs
         kdhzTIvBQCYXF0U1XnpAR7EYtbTRqxNJau4W+DJYXQHLaKYCcJb3t0TqkGjWiKWH9bCU
         vq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YnGSgwjzx6yg1za1Z1HzxytFQ9bIIkcKN0GE008i7mY=;
        b=vfsWyGEv8jsHH7WjM8X1Z+Fv/cQxYin8GwWG6mj3cOCTVIuPdgDR2rTVyo0LHOf0q8
         R21Rjbl8LN6pqU7pMk7BkvwDlfe8XFHosqiOSRBXwPdKsX86KKL1ZfOtHK6Aqegxkde/
         iDYTo6GtyUNFriUVBZhj4/j3JEVU2ewB6/+YSejfzjMbRleozalowgPaGYOWEGHL5iop
         U6vtJmL307ooiZfpplxsKvi4lL+7I8UBi5drO1aHJJscKGy3/dmnWGOSakq9bjH/jJw5
         GV8K7ibIS5r85MNP6hc16L1OTQbkenLU3BZ0MSKQ7WnJVi8xAMpSZP7qYElyZvXGPTuw
         SDJw==
X-Gm-Message-State: AOAM533hJJ8xKhaYmE+hrJ8Upw3oaezownCI1Tvhz5tzfGsXT3cX4O42
        Anr9bt5BMBd0GmCRhKLqGsF8HWP3PcA=
X-Google-Smtp-Source: ABdhPJzHFhWOpQATPXxPgsYCBbtYl8yNR9fQAw7wZ+WyLv5RSeMDOdiTYhUv/zbOPi9HpNRZP23y6g==
X-Received: by 2002:a5d:6d05:0:b0:20a:91e4:4b7f with SMTP id e5-20020a5d6d05000000b0020a91e44b7fmr25029986wrq.190.1651083389890;
        Wed, 27 Apr 2022 11:16:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26-20020adfa29a000000b0020ad8b99d5dsm9414219wra.109.2022.04.27.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:29 -0700 (PDT)
Message-Id: <3179018a8cb72c09c091a58eca4f59f71f90845a.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:18 +0000
Subject: [PATCH v2 7/7] unpack-trees: preserve index sparsity
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

When unpacking trees, set the default sparsity of the resultant index based
on repo settings and 'is_sparse_index_allowed()'.

Normally, when executing 'unpack_trees', the output index is marked sparse
when (and only when) it unpacks a sparse directory. However, an index may be
"sparse" even if it contains no sparse directories - when all files fall
inside the sparse-checkout definition or otherwise have SKIP_WORKTREE
disabled. Therefore, the output index may be marked "full" even when it is
"sparse", resulting in unnecessary 'ensure_full_index' calls when writing to
disk. Avoid this by setting the "default" index sparsity to match what is
expected for the repository.

As a consequence of this fix, the (non-merge) 'read-tree' performed when
applying a stash with untracked files no longer expands the index. Update
the corresponding test in 't1092'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 unpack-trees.c                           | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index aaf4d880dbc..19221c14225 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1392,7 +1392,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash -u &&
 	(
 		WITHOUT_UNTRACKED_TXT=1 &&
-		! ensure_not_expanded stash pop
+		ensure_not_expanded stash pop
 	) &&
 
 	ensure_not_expanded stash create &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7f528d35cc2..a1d0ff3a4d3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "fsmonitor.h"
@@ -1839,6 +1840,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
 
+	if (!o->src_index->initialized &&
+	    !repo->settings.command_requires_full_index &&
+	    is_sparse_index_allowed(&o->result, 0))
+		o->result.sparse_index = 1;
+
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
-- 
gitgitgadget
