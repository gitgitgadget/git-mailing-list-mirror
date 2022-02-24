Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC16C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiBXWfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiBXWfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24D1E0171
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso635682wmb.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GS3guX4JeL6g22B1VqhKzTS5zc/tR36UdzmLu842dCU=;
        b=YB+i8IpaFocInIrSmfbBWenZrdL1FreziJcN5rRNq65iSQLOMfv7B7e0MdHAEAiGbN
         HfH1Q5TMz5vhgEwGJCeN4K2UR8Kl20uxZQPPNYowa4RpTl6poiIA2zIvnm1WD5nzeexK
         jTlSYDxC2XYuMSIbVVBEn8Hn8qUC36zpFL31z6wu4SWaTXzbSrHdXHCtbFYkcmY0xxQI
         09/JFkTlcSST/AN2TAb6/SPQyB1KIzwshl2L1P+C2P4VS5QJgR69oR0dYvSQ8Mw6ru2T
         01lOWAwg21XRH45hxEJMikQRd7cumEH+UTZEvCZ0za15f0/THRgJqCqQMWTNRj6fGZZJ
         pEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GS3guX4JeL6g22B1VqhKzTS5zc/tR36UdzmLu842dCU=;
        b=TDycIFxLK2yJisdi7gTvqjlLJILmaDI4D4d8EDt/bX7Flm3BcQX99ZGjA9epZJnoeM
         3SiKNsXMBmnA5eUHU0Ys85KYoe2k5KoVjH/iD5cqZc00YFEI+NG8/j58rNsizS28nCtI
         YJt1Qga0gcR5vgdKnM2A60kdKLdu3eOKpsKu+CrSZk8oN46qMpOhtnzAGLo9XBT5p0sK
         KSm9W8DW0icpT6T/GegsdVYNb0RU/fyQzzN5uGoJy2RudmLa4sXnSQsTiAKVwGQmlKWf
         6Uk6QigLXp+5aZG+eNGaN853VLYSmTbowIeUnCDK/EJOUIG13Bf/Lop+YJvgCVHsXfxB
         kcaQ==
X-Gm-Message-State: AOAM532BubhHJjM6CTwLvhF6Jb3lBMOkxhi8DWFb3Qog708Xmm0MoDUD
        8P9Xlau6JaRQVwrV8L9S0KBwRKHGBMw=
X-Google-Smtp-Source: ABdhPJzep/ezI6zOx+B0/mPuAXm1K8TyYUM197l4UJpJXDueueYhfBPxgVFDD156erzLXYJcxbVwpg==
X-Received: by 2002:a05:600c:1da7:b0:381:2262:56d2 with SMTP id p39-20020a05600c1da700b00381226256d2mr187107wms.133.1645742075700;
        Thu, 24 Feb 2022 14:34:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm511946wrw.91.2022.02.24.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:35 -0800 (PST)
Message-Id: <744668eeece68a8cfe98b91c50d1cadb6988b993.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:27 +0000
Subject: [PATCH v2 1/7] sparse-index: prevent repo root from becoming sparse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Prevent the repository root from being collapsed into a sparse directory by
treating an empty path as "inside the sparse-checkout". When collapsing a
sparse index (e.g. in 'git sparse-checkout reapply'), the root directory
typically could not become a sparse directory due to the presence of in-cone
root-level files and directories. However, if no such in-cone files or
directories were present, there was no explicit check signaling that the
"repository root path" (an empty string, in the case of
'convert_to_sparse(...)') was in-cone, and a sparse directory index entry
would be created from the repository root directory.

The documentation in Documentation/git-sparse-checkout.txt explicitly states
that the files in the root directory are expected to be in-cone for a
cone-mode sparse-checkout. Collapsing the root into a sparse directory entry
violates that assumption, as sparse directory entries are expected to be
outside the sparse cone and have SKIP_WORKTREE enabled. This invalid state
in turn causes issues with commands that interact with the index, e.g.
'git status'.

Treating an empty (root) path as in-cone prevents the creation of a root
sparse directory in 'convert_to_sparse(...)'. Because the repository root is
otherwise never compared with sparse patterns (in both cone-mode and
non-cone sparse-checkouts), the new check does not cause additional changes
to how sparse patterns are applied.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 dir.c                                    |  7 ++++---
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..a136377eb49 100644
--- a/dir.c
+++ b/dir.c
@@ -1463,10 +1463,11 @@ static int path_in_sparse_checkout_1(const char *path,
 	const char *end, *slash;
 
 	/*
-	 * We default to accepting a path if there are no patterns or
-	 * they are of the wrong type.
+	 * We default to accepting a path if the path is empty, there are no
+	 * patterns, or the patterns are of the wrong type.
 	 */
-	if (init_sparse_checkout_patterns(istate) ||
+	if (!*path ||
+	    init_sparse_checkout_patterns(istate) ||
 	    (require_cone_mode &&
 	     !istate->sparse_checkout_patterns->use_cone_patterns))
 		return 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f3a059e5af5..9ef7cd80885 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -244,6 +244,24 @@ test_expect_success 'expanded in-memory index matches full index' '
 	test_sparse_match git ls-files --stage
 '
 
+test_expect_success 'root directory cannot be sparse' '
+	init_repos &&
+
+	# Remove all in-cone files and directories from the index, collapse index
+	# with `git sparse-checkout reapply`
+	git -C sparse-index rm -r . &&
+	git -C sparse-index sparse-checkout reapply &&
+
+	# Verify sparse directories still present, root directory is not sparse
+	cat >expect <<-EOF &&
+	folder1/
+	folder2/
+	x/
+	EOF
+	git -C sparse-index ls-files --sparse >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_sparse_match ls &&
-- 
gitgitgadget

