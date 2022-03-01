Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C644C4332F
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiCAU1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiCAU0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1448F62B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j17so22375192wrc.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9DBogxSaFTyTsGIWfubnq62UOyMlN/cANTvCvx2wkGI=;
        b=UG19Dx7hiBfPTQ1pIPqdnCBJQfPRye+apL0Kq7GEcug3PwU4GVR8uQh6iwd+ZGX4hd
         p31wVVFT62g8OqkO2aWdS9XS4QNppHkMGC0e710bgus4NLwldnFbDTN0OpeAyfwTiGok
         eqI1N+lFfDGPZokfNweNVuJSgIcoq+xl1qlcAMll0l98kOcFHCgPIObTCaVw3GazjLmo
         eaiTi9/1jqqn2elx+kl3ysVaIll3ygU5HatL+DuqVDp61xa4InAaY8JCQUp5I45z253V
         JhHNsx8YA3aa4++47MEdwRNMGi5EyBJf5zuod+KkiNbW3D4td43WkjNbUVfhY1u2N+lB
         yNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9DBogxSaFTyTsGIWfubnq62UOyMlN/cANTvCvx2wkGI=;
        b=EsObW3D5Ooxaaj5orMyCK9g4FUX5TIOSuSceBBejUIpnj48+rjLDLoC7MiNJNgrhta
         4kwqWSO56kq3FWgWM189NEaYyAzqpIIYuaZPqyJ4koat3iJgNlf08bIseNvANropY4JI
         npp4ddB91fCf1mTdZGRA7Bci1pilCQU5tllKdCLrPWj+huGQizGO+lhuxBjWehZCn6n3
         c27ZGAYzvWpFTWrLngg41vLJ2bnJVMUOdOB2M5EunGQ4OojEolRw3omm+Jy5VBu2zp4/
         DOdf4vB87AkQAOt44vS4jV6rma1DzCecbuG19dS2bICYqtmqawpapKLroSM4qY8k2Q7h
         t/lg==
X-Gm-Message-State: AOAM532XWAHvdVvZ+bAR/aBNvfdMtAw7Mi74fH+CgBSIl4NumWI3JFBd
        RVkh4KRMwRYyWWVgsjjhkyLsafdANe4=
X-Google-Smtp-Source: ABdhPJwQhbhVNPL0Cu6m7J5n4wUKWHgLBGM1fqUmkWUzGzKJn+aIftCOGuFxwgnXYrRHuqCtyW9nww==
X-Received: by 2002:a5d:5983:0:b0:1e5:7dd6:710 with SMTP id n3-20020a5d5983000000b001e57dd60710mr21647445wri.392.1646166277580;
        Tue, 01 Mar 2022 12:24:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c218400b003818133ab4dsm3359775wme.14.2022.03.01.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:37 -0800 (PST)
Message-Id: <1a9365c3bc5b810a60593612bfba97a8b0c1d657.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:29 +0000
Subject: [PATCH v3 6/8] read-tree: narrow scope of index expansion for
 '--prefix'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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

The behavior of 'git read-tree' with prefixes 1) inside of cone, 2) equal to
a sparse directory, and 3) inside a sparse directory are all tested as part
of the 't/t1092-sparse-checkout-compatibility.sh' test 'read-tree --prefix',
ensuring that the sparse index case works the way it did prior to this
change as well as matching non-sparse index sparse-checkout.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  3 +-
 t/t1092-sparse-checkout-compatibility.sh |  8 ++++-
 unpack-trees.c                           | 38 ++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 0a52cab7752..ec6d038242a 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -217,8 +217,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
-	/* TODO: audit sparse index behavior in unpack_trees */
-	if (opts.skip_sparse_checkout || opts.prefix)
+	if (opts.skip_sparse_checkout)
 		ensure_full_index(&the_index);
 
 	if (opts.merge) {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 86241b01a59..d98558f3238 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1417,7 +1417,13 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 	do
 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
 		ensure_not_expanded reset --hard || return 1
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
index 360844bda3a..f3667d85ec5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1693,6 +1693,41 @@ static void populate_from_existing_patterns(struct unpack_trees_options *o,
 		o->pl = pl;
 }
 
+static void update_sparsity_for_prefix(const char *prefix,
+				       struct index_state *istate)
+{
+	int prefix_len = strlen(prefix);
+	struct strbuf ce_prefix = STRBUF_INIT;
+
+	if (!istate->sparse_index)
+		return;
+
+	while (prefix_len > 0 && prefix[prefix_len - 1] == '/')
+		prefix_len--;
+
+	if (prefix_len <= 0)
+		BUG("Invalid prefix passed to update_sparsity_for_prefix");
+
+	strbuf_grow(&ce_prefix, prefix_len + 1);
+	strbuf_add(&ce_prefix, prefix, prefix_len);
+	strbuf_addch(&ce_prefix, '/');
+
+	/*
+	 * If the prefix points to a sparse directory or a path inside a sparse
+	 * directory, the index should be expanded. This is accomplished in one
+	 * of two ways:
+	 * - if the prefix is inside a sparse directory, it will be expanded by
+	 *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
+	 * - if the prefix matches an existing sparse directory entry,
+	 *   'index_name_pos(...)' will return its index position, triggering
+	 *   the 'ensure_full_index(...)' below.
+	 */
+	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
+	    index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >= 0)
+		ensure_full_index(istate);
+
+	strbuf_release(&ce_prefix);
+}
 
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
@@ -1739,6 +1774,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		setup_standard_excludes(o->dir);
 	}
 
+	if (o->prefix)
+		update_sparsity_for_prefix(o->prefix, o->src_index);
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-- 
gitgitgadget

