Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA6C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiGSP01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiGSP0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:26:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4C47B9F
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so9275838wrc.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L0VgCE7BNwD2RRZldiUuB5UO+HFFNItEiJ81+HhosQM=;
        b=j/E+KWmblagTzLKK3+7cUyKFf6I4WHYsE7EBsyOxsNUd4Zv7K4j3YbAu3NJuztc9l8
         tbSEQEzIbnvot+CY7eUr3ASoEWldFqnSsS+lTKlzb5Umrl3BwP2i3fGXYa0DiyfnhokX
         32PMAberPnluGJsp0n9scWuhXwn9t1c1bv8LpRRE2iUusumWXjVl3XmgDLybDdGdnJTb
         mKdWWe7J+FiAcIk9iDPCjcEZfK1nGSgv34AOha82JWVE/lADJ9lICfWLHRsXdCqQC+zs
         uCkr2v3dxujOGz3QSeFcabiVQqYOIZkC25jxUpV/bRAgwy4zMZUX9NJkL2Rr52ZbxhzF
         wohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L0VgCE7BNwD2RRZldiUuB5UO+HFFNItEiJ81+HhosQM=;
        b=Ys7eFRbxVkSzWD3f+i3M/5LEMNYbJVJxXgIoGBcBG8iJ0+9dCt3jVgqmpTaNW6eXof
         LSsKLReYrL8TpYASxSRD/8NydXwlv3qLlNauYeR9AWN/SQZJ+zMHkOAnJ+hlqbAyzN+r
         kHQlUfnv2iPjl2p6m+CtK/PVsp7Q3iUIVN7Q53x7WHxkmIl/+dDox6IJQLTz448wN0+2
         DG/3aLIz3BW6XAEELQlAxQ6+Kr6I22mpM8/FWt7S57BIHKB2pHg1nipImeUKp9Q0ZPi8
         3fD60PhiHILHl1DlWLMsAYPfPxD1BkLw28uYrhGrdcLRrHuazsSTsmfM3NaDf/h2lE1k
         ZXRg==
X-Gm-Message-State: AJIora94qPodW8Ztuuslo1IuGQYHz1hnnR59W5DU8EBTcIdYAylv23QK
        YDA5YDRf/PIbbtuQxpo9RYn0J3cm5eQ=
X-Google-Smtp-Source: AGRyM1sMXmhn1/OlluUCOU9Nd3AalkWJ5N/GWvHmXd7hRkLSRGY/aoZKoHPnoXrwa2oPzL13DVHgrw==
X-Received: by 2002:a05:6000:185:b0:21d:7ffc:4916 with SMTP id p5-20020a056000018500b0021d7ffc4916mr27601194wrx.692.1658244370682;
        Tue, 19 Jul 2022 08:26:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b0021d6d9c0bd9sm2182469wrb.82.2022.07.19.08.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:26:10 -0700 (PDT)
Message-Id: <4dfb7ae5112ebf69de779d59522477cfe6f3b210.1658244366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
        <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 15:26:05 +0000
Subject: [PATCH v2 2/3] midx: extract bitmap write setup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        chakrabortyabhradeep79@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The write_midx_bitmap() method is a long method that does a lot of
steps. It requires the write_midx_context struct for use in
prepare_midx_packing_data() and find_commits_for_midx_bitmap(), but
after that only needs the pack_order array.

This is a messy, but completely non-functional refactoring. The code is
only being moved around to reduce visibility of the write_midx_context
during the longest part of computing reachability bitmaps.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 midx.c | 56 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/midx.c b/midx.c
index 5f0dd386b02..e2dd808b35d 100644
--- a/midx.c
+++ b/midx.c
@@ -1053,40 +1053,35 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	return cb.commits;
 }
 
-static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
-			     struct write_midx_context *ctx,
+static int write_midx_bitmap(const char *midx_name,
+			     const unsigned char *midx_hash,
+			     struct packing_data *pdata,
+			     struct commit **commits,
+			     uint32_t commits_nr,
+			     uint32_t *pack_order,
 			     const char *refs_snapshot,
 			     unsigned flags)
 {
-	struct packing_data pdata;
-	struct pack_idx_entry **index;
-	struct commit **commits = NULL;
-	uint32_t i, commits_nr;
+	int ret, i;
 	uint16_t options = 0;
-	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
-	int ret;
-
-	if (!ctx->entries_nr)
-		BUG("cannot write a bitmap without any objects");
+	struct pack_idx_entry **index;
+	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
+					hash_to_hex(midx_hash));
 
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
 
-	prepare_midx_packing_data(&pdata, ctx);
-
-	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
-
 	/*
 	 * Build the MIDX-order index based on pdata.objects (which is already
 	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
 	 * this order).
 	 */
-	ALLOC_ARRAY(index, pdata.nr_objects);
-	for (i = 0; i < pdata.nr_objects; i++)
-		index[i] = &pdata.objects[i].idx;
+	ALLOC_ARRAY(index, pdata->nr_objects);
+	for (i = 0; i < pdata->nr_objects; i++)
+		index[i] = &pdata->objects[i].idx;
 
 	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
-	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
+	bitmap_writer_build_type_index(pdata, index, pdata->nr_objects);
 
 	/*
 	 * bitmap_writer_finish expects objects in lex order, but pack_order
@@ -1101,16 +1096,16 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	 * happens between bitmap_writer_build_type_index() and
 	 * bitmap_writer_finish().
 	 */
-	for (i = 0; i < pdata.nr_objects; i++)
-		index[ctx->pack_order[i]] = &pdata.objects[i].idx;
+	for (i = 0; i < pdata->nr_objects; i++)
+		index[pack_order[i]] = &pdata->objects[i].idx;
 
 	bitmap_writer_select_commits(commits, commits_nr, -1);
-	ret = bitmap_writer_build(&pdata);
+	ret = bitmap_writer_build(pdata);
 	if (ret < 0)
 		goto cleanup;
 
 	bitmap_writer_set_checksum(midx_hash);
-	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, options);
+	bitmap_writer_finish(index, pdata->nr_objects, bitmap_name, options);
 
 cleanup:
 	free(index);
@@ -1443,8 +1438,21 @@ static int write_midx_internal(const char *object_dir,
 	if (flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
 		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
+
 	if (flags & MIDX_WRITE_BITMAP) {
-		if (write_midx_bitmap(midx_name.buf, midx_hash, &ctx,
+		struct packing_data pdata;
+		struct commit **commits;
+		uint32_t commits_nr;
+
+		if (!ctx.entries_nr)
+			BUG("cannot write a bitmap without any objects");
+
+		prepare_midx_packing_data(&pdata, &ctx);
+
+		commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &ctx);
+
+		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
+				      commits, commits_nr, ctx.pack_order,
 				      refs_snapshot, flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
-- 
gitgitgadget

