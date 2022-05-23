Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D881CC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiEWNtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiEWNtC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:49:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F9562FB
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so9841470wrc.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZwGBv26UQuQjTkeZyhJ6Y4Vk30CsxCnxhBwP/Ig2btk=;
        b=d7pJDgTDfjNLo+Hxyyo4wZZH6hSYdxmLcZmg1wBg1fFI3eTs1FBqukLvtjRNdqFE21
         8Y6+dPcUJNFsgLlOKbgYK+NERj8arTt/Mh746bs3/19HdBZMCZy6CBi5XEHv443+Dns3
         H7K1yW7yh5vc8UnPe2O6tSUWEyxUcWpbL7T5+mYehUbqwW/uf0QeMWbTsCbR1nax0H2l
         F8ErnOcHSlP/4ewzaWuYo/XTRqzd6HRj9Y/lUvYtRh3sa7oPLSi8aOr8xeBy2ninbZDE
         oGKj+LVTo0MzBcMnj8+roSREgnJbgB+wwQOMUF6OgrswKBOEfkyu/Bc5IXlaCIkSzjKc
         w1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZwGBv26UQuQjTkeZyhJ6Y4Vk30CsxCnxhBwP/Ig2btk=;
        b=wn8MMYmOS75Ip+8BzDwkSrbr4A8Ym3hhmul8Oj8sLNsLcO7FGmEIep6in6w/xBY4RR
         VDZ2g7L6KvIUvLKhPjc8Ntate5IDvlJUlfLediuz8WK4k+qo9A6ooiMVZYFBQEFwVlQt
         b1WV54nx5XcKHWHbz3kjETgdCdgsYLEsEf1OobZUYEOwZMiJOvMijCX5zfnn8zPyZ5Pe
         knWrHAtALbmGYFUq1w6PuPkOZC5hehZ1Xh4/QKGRPQy97W4sxFiS5dXTzkt6reLsZmb7
         uMlVelsIJx3p/cGdZOQStr8uvKLm6lvkfCnXhOIVoN8a/FWJOzR3Kdlmm/BrYNEitDHD
         DXgg==
X-Gm-Message-State: AOAM531CRLhtewPyr/rfATv2749jdBxisXCwhiQZlwk7oGdR3A7HFsYz
        bN2F4QCEpiCLERnYDUIVs0rMH7ffhd0=
X-Google-Smtp-Source: ABdhPJwlF+je2wq6EnFLAsPzpKjZd1JLlHfUCcjEDl/MbKzz507GMqesUrn4clG3L75ExYGi1pu1+A==
X-Received: by 2002:a05:6000:1d93:b0:20c:58f8:f530 with SMTP id bk19-20020a0560001d9300b0020c58f8f530mr19236099wrb.254.1653313737131;
        Mon, 23 May 2022 06:48:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1-20020adfc001000000b0020e5b2afb3bsm10190613wre.23.2022.05.23.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:56 -0700 (PDT)
Message-Id: <310e59d9f0e9cf6b88ced10c80e982606fe7632a.1653313727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:43 +0000
Subject: [PATCH v3 07/10] sparse-index: partially expand directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The expand_to_pattern_list() method expands sparse directory entries
to their list of contained files when either the pattern list is NULL or
the directory is contained in the new pattern list's cone mode patterns.

It is possible that the pattern list has a recursive match with a
directory 'A/B/C/' and so an existing sparse directory 'A/B/' would need
to be expanded. If there exists a directory 'A/B/D/', then that
directory should not be expanded and instead we can create a sparse
directory.

To implement this, we plug into the add_path_to_index() callback for the
call to read_tree_at(). Since we now need access to both the index we
are writing and the pattern list we are comparing, create a 'struct
modify_index_context' to use as a data transfer object. It is important
that we use the given pattern list since we will use this pattern list
to change the sparse-checkout patterns and cannot use
istate->sparse_checkout_patterns.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 57 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 7848910c154..a881f851810 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -9,6 +9,11 @@
 #include "dir.h"
 #include "fsmonitor.h"
 
+struct modify_index_context {
+	struct index_state *write;
+	struct pattern_list *pl;
+};
+
 static struct cache_entry *construct_sparse_dir_entry(
 				struct index_state *istate,
 				const char *sparse_dir,
@@ -231,18 +236,52 @@ static int add_path_to_index(const struct object_id *oid,
 			     struct strbuf *base, const char *path,
 			     unsigned int mode, void *context)
 {
-	struct index_state *istate = (struct index_state *)context;
+	struct modify_index_context *ctx = (struct modify_index_context *)context;
 	struct cache_entry *ce;
 	size_t len = base->len;
 
-	if (S_ISDIR(mode))
-		return READ_TREE_RECURSIVE;
+	if (S_ISDIR(mode)) {
+		int dtype;
+		size_t baselen = base->len;
+		if (!ctx->pl)
+			return READ_TREE_RECURSIVE;
 
-	strbuf_addstr(base, path);
+		/*
+		 * Have we expanded to a point outside of the sparse-checkout?
+		 *
+		 * Artificially pad the path name with a slash "/" to
+		 * indicate it as a directory, and add an arbitrary file
+		 * name ("-") so we can consider base->buf as a file name
+		 * to match against the cone-mode patterns.
+		 *
+		 * If we compared just "path", then we would expand more
+		 * than we should. Since every file at root is always
+		 * included, we would expand every directory at root at
+		 * least one level deep instead of using sparse directory
+		 * entries.
+		 */
+		strbuf_addstr(base, path);
+		strbuf_add(base, "/-", 2);
+
+		if (path_matches_pattern_list(base->buf, base->len,
+					      NULL, &dtype,
+					      ctx->pl, ctx->write)) {
+			strbuf_setlen(base, baselen);
+			return READ_TREE_RECURSIVE;
+		}
 
-	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
+		/*
+		 * The path "{base}{path}/" is a sparse directory. Create the correct
+		 * name for inserting the entry into the index.
+		 */
+		strbuf_setlen(base, base->len - 1);
+	} else {
+		strbuf_addstr(base, path);
+	}
+
+	ce = make_cache_entry(ctx->write, mode, oid, base->buf, 0, 0);
 	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
-	set_index_entry(istate, istate->cache_nr++, ce);
+	set_index_entry(ctx->write, ctx->write->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
 	return 0;
@@ -254,6 +293,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
 	const char *tr_region;
+	struct modify_index_context ctx;
 
 	/*
 	 * If the index is already full, then keep it full. We will convert
@@ -293,6 +333,9 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	full->cache_nr = 0;
 	ALLOC_ARRAY(full->cache, full->cache_alloc);
 
+	ctx.write = full;
+	ctx.pl = pl;
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
@@ -318,7 +361,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 		strbuf_add(&base, ce->name, strlen(ce->name));
 
 		read_tree_at(istate->repo, tree, &base, &ps,
-			     add_path_to_index, full);
+			     add_path_to_index, &ctx);
 
 		/* free directory entries. full entries are re-used */
 		discard_cache_entry(ce);
-- 
gitgitgadget

