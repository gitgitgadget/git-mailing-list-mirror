Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4209DC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiESRx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbiESRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14869DFFA
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r23so8279092wrr.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MJHguuq3EGZPe4+eLDHq9VlhYC9dDU+auiDeaDrogvE=;
        b=fwGE2h4uy4fuwI0i6TKuNFdmHkxJNgl2jQj0P3MBU9aUqAy0+F4E3RwN3uCphum9QN
         o7MkWotZJA2zcKScJw+MTkFfk6jg0/ChJ3O/Af/6QS0CqwREsVIGV/VNzjVq5vcDF0Tt
         2B+aXPLgH+b/+LW2+C1fJDB9VluQeGL9Zyt0rLE/UqAWMmTJ72m1hBtm/F5gs/xK9Rs/
         r+b8286+ljf/SGlqd4lW0pAaoc2XNdZK/JfCTqlnpisgMaJBZ6Vdf6Hh7/71A02XFXB6
         6YMWuJaE60QYEazFfKX+t9+a6UuufqEYDWDPOv6J1n0NSzkqNcuh/C/YQ6kd9+y7flsH
         c4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MJHguuq3EGZPe4+eLDHq9VlhYC9dDU+auiDeaDrogvE=;
        b=NSsph+GBfimB58xyMXf9ol9KrqxlJJapIJaosoKMT+Hn9zrmTpqzjiRUGpdO6CMKGm
         uJ9yuV31WsDQmj8LQLYa/GZsFbC4/CnTjnjdntkUHQSdFlSMya+rIoMque3NJ5yiMaU5
         vBwc+XhiHMI0wEb/Xd/nHqrpScGspxbSPh3Pei9pM6bYMGk/yrd5Tiew+NrOyfOy1q+h
         CzbTxOqvtiQ9Qqq2j0QL5/zOXu689OFCJqRPRdMI8Dry41NU8nx/grUFRbzfKbRsrk4B
         1Jq99ISvG/MsgG2thAR/o8Tb+ygNP7j8FvKeM7a5AARCiH6IRwtBFtXm7G0E0RyNQ5nI
         CjqA==
X-Gm-Message-State: AOAM531d41fy0wTGeriOrq1agd3CXguUtjXkYG9RxyAil6GQkqt0GedM
        KmPDQRnntH+uJ5StvEt2R38PKh+u63A=
X-Google-Smtp-Source: ABdhPJwFCNQq/9So/OSJWh34+CszVf5L0SfDgCdspBV0MUzSCohBABPCiT4PrHGOnpFRuXQaLFyDbg==
X-Received: by 2002:a5d:58d0:0:b0:20d:1176:bf1a with SMTP id o16-20020a5d58d0000000b0020d1176bf1amr5034699wrf.167.1652982768238;
        Thu, 19 May 2022 10:52:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c1c1200b0039429bfebeasm277649wms.2.2022.05.19.10.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:47 -0700 (PDT)
Message-Id: <346c56bf2560c5a89850ef4f8a58fbe17cde10fc.1652982759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:35 +0000
Subject: [PATCH v2 07/10] sparse-index: partially expand directories
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
 sparse-index.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index c2cd3bdb614..73b82e5017b 100644
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
@@ -231,18 +236,41 @@ static int add_path_to_index(const struct object_id *oid,
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
@@ -254,6 +282,7 @@ void expand_to_pattern_list(struct index_state *istate,
 	int i;
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
+	struct modify_index_context ctx;
 
 	/*
 	 * If the index is already full, then keep it full. We will convert
@@ -294,6 +323,9 @@ void expand_to_pattern_list(struct index_state *istate,
 	full->cache_nr = 0;
 	ALLOC_ARRAY(full->cache, full->cache_alloc);
 
+	ctx.write = full;
+	ctx.pl = pl;
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
@@ -319,7 +351,7 @@ void expand_to_pattern_list(struct index_state *istate,
 		strbuf_add(&base, ce->name, strlen(ce->name));
 
 		read_tree_at(istate->repo, tree, &base, &ps,
-			     add_path_to_index, full);
+			     add_path_to_index, &ctx);
 
 		/* free directory entries. full entries are re-used */
 		discard_cache_entry(ce);
-- 
gitgitgadget

