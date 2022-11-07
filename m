Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F1AC4321E
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiKGShn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiKGShF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878527FF2
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j15so17560044wrq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaTWpV8iOTrU68jhsZKnAzcJGc1CKmBQdwvli0ieM6s=;
        b=J7OSXosLeQBeQmEaMmXwns/qKyCZnzH2eem3MlEekvd5QKNNcgst34xv0PJWdt4FOR
         cJAw04CUirx5AeWado0Bo+XJNJwxo5TkTv5q0YuOB+URW5/QKUBGPidEjkPmxDn+sUOv
         uQs9gDpcWFcw5U+2D/Y5ziGZtpcYcDMUWCOeIqEURZoD8/9S4QJ/pZtu8ljaDCvskXH8
         SuJj8k4IyV9tSikmeedOlc6SeyeOj0P46cPik944RSCKVvAhrScMHoHyvTSNcX3VklDW
         t//IKagqW5Uzx3gmu64B3dbNmjSCRMaJZHzfUB1YU80FeHW5AgkbMuDEF/P57UeGW/1D
         YfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaTWpV8iOTrU68jhsZKnAzcJGc1CKmBQdwvli0ieM6s=;
        b=ZZJ300EQqTNSbubpMCDQPJBI16IQnctMqvuDywrMFWwVQ6JxHAEHKZI0Q6aB66MfYV
         x5WztPiqM/4TE6itQ25uuLDJScsgNDJojfdVqvasc4zJ25w1g+UjeNq5yHq97MRKTL7m
         yIFpUbKVVTwjGgthp0zhqhV7znlAOSlSAc5Sx0eSxiq9HaiB7McaJVws0CkdXkrjWgGK
         pdizd5Szl4VVgCo7u4Qkb2/8ipXF54zNQzMDnGy4xoc47ODpGP8c/GwvAs3WP8/XqPwT
         Hvra4x2NfmBHwZkEq8G58Xn0hrQCimNDskgd+UVFLPC8x51IvtCGYUGauzp06dJpX20S
         b4YQ==
X-Gm-Message-State: ACrzQf27xU0C0JyQQ26Fe1MqOOE/Oyz1kvMfhKPNZVEnqtoCxSgHc+pb
        DxTirks7rbOye9ufykDvEGkTYKCyChk=
X-Google-Smtp-Source: AMsMyM7NSibu9CiZrIKcKCC12X/hhOfzonGxR75Ee4YgYjTgKSwbhzRbLD5ZeBBSEaPGQuSh2jLMDg==
X-Received: by 2002:a5d:5257:0:b0:236:8a38:4e08 with SMTP id k23-20020a5d5257000000b002368a384e08mr32236941wrc.118.1667846187614;
        Mon, 07 Nov 2022 10:36:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cac03000000b003c6f3e5ba42sm12274605wme.46.2022.11.07.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:26 -0800 (PST)
Message-Id: <36f9aa02ebfb967799036c4a0a648ab332c2612b.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:55 +0000
Subject: [PATCH 21/30] packed-refs: write prefix chunks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Tests already cover that we will start reading these prefixes.

TODO: discuss time and space savings over typical approach.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-format-v2.c | 103 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/refs/packed-format-v2.c b/refs/packed-format-v2.c
index 0ab277f7ad4..2cd45a5987a 100644
--- a/refs/packed-format-v2.c
+++ b/refs/packed-format-v2.c
@@ -398,6 +398,18 @@ struct write_packed_refs_v2_context {
 	uint64_t *offsets;
 	size_t nr;
 	size_t offsets_alloc;
+
+	int write_prefixes;
+	const char *cur_prefix;
+	size_t cur_prefix_len;
+
+	char **prefixes;
+	uint32_t *prefix_offsets;
+	uint32_t *prefix_rows;
+	size_t prefix_nr;
+	size_t prefixes_alloc;
+	size_t prefix_offsets_alloc;
+	size_t prefix_rows_alloc;
 };
 
 struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *refs,
@@ -434,6 +446,56 @@ static int write_packed_entry_v2(const char *refname,
 
 	ALLOC_GROW(ctx->offsets, i + 1, ctx->offsets_alloc);
 
+	if (ctx->write_prefixes) {
+		if (ctx->cur_prefix && starts_with(refname, ctx->cur_prefix)) {
+			/* skip ahead! */
+			refname += ctx->cur_prefix_len;
+			reflen -= ctx->cur_prefix_len;
+		} else {
+			size_t len;
+			const char *slash, *slashslash = NULL;
+			if (ctx->prefix_nr) {
+				/* close out the old prefix. */
+				ctx->prefix_rows[ctx->prefix_nr - 1] = ctx->nr;
+			}
+
+			/* Find the new prefix. */
+			slash = strchr(refname, '/');
+			if (slash)
+				slashslash = strchr(slash + 1, '/');
+			/* If there are two slashes, use that. */
+			slash = slashslash ? slashslash : slash;
+			/*
+			 * If there is at least one slash, use that,
+			 * and include the slash in the string.
+			 * Otherwise, use the end of the ref.
+			 */
+			slash = slash ? slash + 1 : refname + strlen(refname);
+
+			len = slash - refname;
+			ALLOC_GROW(ctx->prefixes, ctx->prefix_nr + 1, ctx->prefixes_alloc);
+			ALLOC_GROW(ctx->prefix_offsets, ctx->prefix_nr + 1, ctx->prefix_offsets_alloc);
+			ALLOC_GROW(ctx->prefix_rows, ctx->prefix_nr + 1, ctx->prefix_rows_alloc);
+
+			if (ctx->prefix_nr)
+				ctx->prefix_offsets[ctx->prefix_nr] = ctx->prefix_offsets[ctx->prefix_nr - 1] + len + 1;
+			else
+				ctx->prefix_offsets[ctx->prefix_nr] = len + 1;
+
+			ctx->prefixes[ctx->prefix_nr] = xstrndup(refname, len);
+			ctx->cur_prefix = ctx->prefixes[ctx->prefix_nr];
+			ctx->prefix_nr++;
+
+			refname += len;
+			reflen -= len;
+			ctx->cur_prefix_len = len;
+		}
+
+		/* Update the last row continually. */
+		ctx->prefix_rows[ctx->prefix_nr - 1] = i + 1;
+	}
+
+
 	/* Write entire ref, including null terminator. */
 	hashwrite(ctx->f, refname, reflen);
 	hashwrite(ctx->f, oid->hash, the_hash_algo->rawsz);
@@ -483,13 +545,54 @@ static int write_refs_chunk_offsets(struct hashfile *f,
 	return 0;
 }
 
+static int write_refs_chunk_prefix_data(struct hashfile *f,
+					void *data)
+{
+	struct write_packed_refs_v2_context *ctx = data;
+	size_t i;
+
+	trace2_region_enter("refs", "prefix-data", the_repository);
+	for (i = 0; i < ctx->prefix_nr; i++) {
+		size_t len = strlen(ctx->prefixes[i]) + 1;
+		hashwrite(f, ctx->prefixes[i], len);
+
+		/* TODO: assert the prefix lengths match the stored offsets? */
+	}
+
+	trace2_region_leave("refs", "prefix-data", the_repository);
+	return 0;
+}
+
+static int write_refs_chunk_prefix_offsets(struct hashfile *f,
+				    void *data)
+{
+	struct write_packed_refs_v2_context *ctx = data;
+	size_t i;
+
+	trace2_region_enter("refs", "prefix-offsets", the_repository);
+	for (i = 0; i < ctx->prefix_nr; i++) {
+		hashwrite_be32(f, ctx->prefix_offsets[i]);
+		hashwrite_be32(f, ctx->prefix_rows[i]);
+	}
+
+	trace2_region_leave("refs", "prefix-offsets", the_repository);
+	return 0;
+}
+
 int write_packed_refs_v2(struct write_packed_refs_v2_context *ctx)
 {
 	unsigned char file_hash[GIT_MAX_RAWSZ];
 
+	ctx->write_prefixes = git_env_bool("GIT_TEST_WRITE_PACKED_REFS_PREFIXES", 1);
+
 	add_chunk(ctx->cf, CHREFS_CHUNKID_REFS, 0, write_refs_chunk_refs);
 	add_chunk(ctx->cf, CHREFS_CHUNKID_OFFSETS, 0, write_refs_chunk_offsets);
 
+	if (ctx->write_prefixes) {
+		add_chunk(ctx->cf, CHREFS_CHUNKID_PREFIX_DATA, 0, write_refs_chunk_prefix_data);
+		add_chunk(ctx->cf, CHREFS_CHUNKID_PREFIX_OFFSETS, 0, write_refs_chunk_prefix_offsets);
+	}
+
 	hashwrite_be32(ctx->f, PACKED_REFS_SIGNATURE);
 	hashwrite_be32(ctx->f, 2);
 	hashwrite_be32(ctx->f, the_hash_algo->format_id);
-- 
gitgitgadget

