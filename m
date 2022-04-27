Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiD0STy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbiD0STv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B428DFE2
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so3631137wrh.7
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NwM11leLomJ0EMFRKgFW6eInxFBvynd9pc3vZL4CJe4=;
        b=oq4WWC38j+82jR511mgGhQ0E6Y2QnKYLwTCqSxhwcO6BhXjPDLzc7i4i453Jgiz3Mq
         pk+TxwXzNeCtI3l5LupOenlWLUEAxC/Qh5GTFnPZ7cG1fh7Wfx9tfWEHFpjhbSgvmLJE
         I9M973GZ7Ps0lw1Xcy55OpnX2+KCmeXSFmv6n8MeUUOBmfykyHXJpjrZFPsfdM4gL335
         2H4XJnm7vOPTvjtYXPi7pMpB7sX4p3nrYiiG3ZmhkXw0Y8F0exOr4PZxoifdimvY0Mvs
         a4TLYHV7uJmpsmbQha8Cq2Sp1wN4v9X+4sNwXTs8+DQ+ALSm6m6qMulFa1sAkHIJGnp/
         hhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NwM11leLomJ0EMFRKgFW6eInxFBvynd9pc3vZL4CJe4=;
        b=VAB/NH7iz3d3m4QWpo4TzQasNu1+EQ8RjaYINE42Rief2QXdYXBsELN9V+cTliOEhF
         yQyd8iT8qPEi4RnxxhdVbe8rnyaM4og9xZYRAwoj8eSIb4gjM5c4YtlZ/SMoo3Nm4J6d
         CH1G7UDdVlieZSvK1nWAOtV/MLTeJdQJdmB4spo/lfMefy5LrO/W/Z+gb3h9+v9BJLty
         kWU716Xt4wswxJuJr6AH+7DCv2M+uLbK9TYZPBikkXv0DtrknzXYDwBYECGZ9Go3Fri3
         x8ZGvPbalXEBxNZPc9MEYGFz6UUsUlFoRntdMiuaGamRBuAniRL6DOO8MIus2vXGDcTh
         ZIGg==
X-Gm-Message-State: AOAM533GCBw6jCjANBRuPANPysa5ZwTK1yURja1ynl4BVSRU+I8uWAvJ
        2Wid9nDtbMg+tlgm+NXFhqLegm/xM7Y=
X-Google-Smtp-Source: ABdhPJwTgRv2xsUJvyD2qxaXm8gwsT1W2w2qay2Jb9fhyrJAkW18atMZgjH6nnhLILr0YDQmUU9BJA==
X-Received: by 2002:a5d:6792:0:b0:20a:d352:10de with SMTP id v18-20020a5d6792000000b0020ad35210demr18168762wru.326.1651083388564;
        Wed, 27 Apr 2022 11:16:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020aa79d55b5sm17065071wrb.35.2022.04.27.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:27 -0700 (PDT)
Message-Id: <22fee0732ad7f4bb355a96bc514b084195f312bc.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:17 +0000
Subject: [PATCH v2 6/7] stash: merge applied stash with merge-ort
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

Change the merge function used in 'do_apply_stash()' from 'merge_recursive'
to 'merge_ort_recursive'. In addition to aligning with the default merge
strategy used by 'git merge' (6a5fb96672 (Change default merge backend from
recursive to ort, 2021-08-04)), this allows 'git stash <apply|pop>' to
operate without expanding the index by default. Update tests in 't1092'
verifying index expansion for 'git stash' accordingly.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c                          | 3 ++-
 t/t1092-sparse-checkout-compatibility.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 16171eb1dab..cd77d448546 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -7,6 +7,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "dir.h"
@@ -554,7 +555,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	bases[0] = &info->b_tree;
 
 	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
-				      merge_recursive, &result);
+				      merge_ort_recursive, &result);
 	if (ret) {
 		rerere(0);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 85c6a56f1b7..aaf4d880dbc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1385,7 +1385,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash &&
 	ensure_not_expanded stash list &&
 	ensure_not_expanded stash show stash@{0} &&
-	! ensure_not_expanded stash apply stash@{0} &&
+	ensure_not_expanded stash apply stash@{0} &&
 	ensure_not_expanded stash drop stash@{0} &&
 
 	echo >>sparse-index/deep/new &&
@@ -1399,7 +1399,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	oid=$(git -C sparse-index stash create) &&
 	ensure_not_expanded stash store -m "test" $oid &&
 	ensure_not_expanded reset --hard &&
-	! ensure_not_expanded stash pop
+	ensure_not_expanded stash pop
 '
 
 test_expect_success 'sparse index is not expanded: diff' '
-- 
gitgitgadget

