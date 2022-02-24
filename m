Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0DFC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiBXWfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiBXWfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846761ED4D7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b5so1830622wrr.2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fqoCza8Vg8xn4hC9kZQfbeXf7/jb1S/78yAQODWVUcE=;
        b=HkIShwSy4FAXA03ZT8nxgHsYYSi0XePdBllySv5r9n9ZxqkqYw6dP0VUTO/Lel5ufs
         xArEulLXR4nZjvoFFFJxRZYbf6MbyhkRaG8rfl8ERanxgGemLfz4iDLAUYWMJmX278pG
         1GGnX3t8bsXcOSXtrTpzXidwxMnWIW/db3tqqRNTFu6kzk5e8qjb2vzqtnFCLgbZb4QF
         xiSTE3qqYQFRupT0Iu8jKFpAuZqa2cWV0xNtPvVJoPKjLByZVuSFIvj8ghJysbZzyar8
         YTxyRorKProvHIzj29y9twYAtUtFjGeJQeWrIjRxkgZvs3/ICNxow20LTO3nLjWgf/C2
         WfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fqoCza8Vg8xn4hC9kZQfbeXf7/jb1S/78yAQODWVUcE=;
        b=p9vQEH6mHUDH8QRtKBz8hAszYB4J/IptQnd/H0tKqKrH3T0GyEYSgmGV8pd+vP/5JB
         3PMHasK3x7QBuzvm51RPBMeoxoyoduhTYKwRSgEsFvlPFgdjX0fnqdl9L2y2MJ+3d9ti
         kGP00VgtC3HZUnUR39r8irNaZvJoNY3FNp8t1G1RVjQPjEgvekDrJJjJQrTYwKXQOI1z
         90tC9XlcZSwMGM827Wz0llrehqE5zNAeSCR//kc3mf3rw5Q/q7VdiULcfFN8AfH2XEHa
         aC3+qdNU1q5oFBxkm43Ga2X/B7Yh9feZhOlRPV9jmYO39OugHD+DP0juFYwTPwG40oFP
         ZOqg==
X-Gm-Message-State: AOAM533HgE8RJVAsFmOydrypu7Ng6I00p6I4bdKZFFQ8+SHkSf3sRz6d
        7iRpXA7KB31hK8uuHO3oID9Aqc0GTiE=
X-Google-Smtp-Source: ABdhPJwl0699XcHcpGQyYfypld66O+dyECrQ0Val0Z7IJTn37QUTz1OQc027kW09PkTi0uACcAsvMw==
X-Received: by 2002:adf:e6c7:0:b0:1ed:9f7c:c99e with SMTP id y7-20020adfe6c7000000b001ed9f7cc99emr3803525wrm.0.1645742078883;
        Thu, 24 Feb 2022 14:34:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdccb000000b001e57922b8b6sm561880wrm.43.2022.02.24.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:38 -0800 (PST)
Message-Id: <4f05fa70209768fb20284bd4018a1364567cad5a.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:31 +0000
Subject: [PATCH v2 5/7] read-tree: narrow scope of index expansion for
 '--prefix'
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

When 'git read-tree' is provided with a prefix, expand the index only if the
prefix is equivalent to a sparse directory or contained within one. If the
index is not expanded in these cases, 'ce_in_traverse_path' will indicate
that the relevant sparse directory is not in the prefix/traverse path,
skipping past it and not unpacking the appropriate tree(s).

If the prefix is in-cone, its sparse subdirectories (if any) will be
traversed correctly without index expansion.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  3 +--
 t/t1092-sparse-checkout-compatibility.sh |  8 ++++++-
 unpack-trees.c                           | 30 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index c2fdbc2657f..a7b7f822281 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -213,8 +213,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
-	/* TODO: audit sparse index behavior in unpack_trees */
-	if (opts.skip_sparse_checkout || opts.prefix)
+	if (opts.skip_sparse_checkout)
 		ensure_full_index(&the_index);
 
 	if (opts.merge) {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ae44451a0a9..a404be0a10f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1415,7 +1415,13 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 	do
 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
 		ensure_not_expanded reset --hard HEAD || return 1
-	done
+	done &&
+
+	rm -rf sparse-index/deep/deeper2 &&
+	ensure_not_expanded add . &&
+	ensure_not_expanded commit -m "test" &&
+
+	ensure_not_expanded read-tree --prefix=deep/deeper2 -u deepest
 '
 
 test_expect_success 'ls-files' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3a..dba122a02bb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1739,6 +1739,36 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		setup_standard_excludes(o->dir);
 	}
 
+	/*
+	 * If the prefix is equal to or contained within a sparse directory, the
+	 * index needs to be expanded to traverse with the specified prefix.
+	 */
+	if (o->prefix && o->src_index->sparse_index) {
+		int prefix_len = strlen(o->prefix);
+
+		while (prefix_len > 0 && o->prefix[prefix_len - 1] == '/')
+			prefix_len--;
+
+		if (prefix_len > 0) {
+			struct strbuf ce_prefix = STRBUF_INIT;
+			strbuf_grow(&ce_prefix, prefix_len + 1);
+			strbuf_add(&ce_prefix, o->prefix, prefix_len);
+			strbuf_addch(&ce_prefix, '/');
+
+			/*
+			 * If the prefix is not inside the sparse cone, then the
+			 * index is explicitly expanded if it is found as a sparse
+			 * directory, or implicitly expanded (by 'index_name_pos')
+			 * if the path is inside a sparse directory.
+			 */
+			if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, o->src_index) &&
+			    index_name_pos(o->src_index, ce_prefix.buf, ce_prefix.len) >= 0)
+				ensure_full_index(o->src_index);
+
+			strbuf_release(&ce_prefix);
+		}
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-- 
gitgitgadget

