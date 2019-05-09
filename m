Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B991F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEIOWp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37849 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfEIOWn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id w37so2205336edw.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WApkO7gw8Q6Vx5z25239OQBkt/ImHB6i0jsiyxFuzMw=;
        b=YODXR850p4yTh+J/A3MhC9Ebvl/k5c0ApnzCE0N3zRlrg9b15x+4Hp1lOSgLYOG+Jo
         CeF8ZJYpUidZMJz7IdWHNvwfI56B4nlOOpeQ/LXqZkRZvfUYDft93S+a1OI5rZiDyZ/i
         re5wA3nTbMJwPjWEfs5irmi6ysnq4y5ZIZotqiNeluigO+6hZB17zEn9MPBlOjzQ3hVO
         IMa4Fb4fVk9u2/EWUW1u7x9Qtdjz2Ry13NyJ0uTTMvZ7E8WrYDUDxyuBbyoJD7s3BsUV
         uDqLkMQPEbTyqJhZ31qIHFzYDM7IGTBXM/GVwz8ChklyHiTJitFOEBP3JsAL2w9vkorr
         0oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WApkO7gw8Q6Vx5z25239OQBkt/ImHB6i0jsiyxFuzMw=;
        b=DTm6JS+zydHIY60uXeyfyrGXKAdhFu5jHOXzlIT4Y1RCE37MzbTQdBt9RnQp2QK40C
         MSRO/9v0+FtpB3TjaPwEWQTw5zbeuOmpqiHTRfs7L+Tg3csNZksW1aKqwZXSlerbX1P4
         3+dYXVquLHOSwYrgP2FzDw19fdedJu88HvOyB8S8ZhQhhou4yMSuNG9YsFpB267g6BK3
         rK1iYxlBqQbFfPgfozOjPpJnGz7QqqQHIC5DtJN6BCoBQ9JdAu5bPQHyd6t5a4I3lO2C
         whPUb1+Exq6N66kR1JBPF/kRUyDmHquuzK794tJsKsCn8rp8jXILrU/AGRj3tsZDZmsY
         tHCw==
X-Gm-Message-State: APjAAAVZUJn4ZHQHUvx4mF4FyUiPoAonzYx83b0Yto83+LhWjvwEvsES
        1jsfCgW5xizZ5SoJX8bmA93IAXJz
X-Google-Smtp-Source: APXvYqyiEtRolEsw2CGwoz7tTKMmtoY1dqzKwZgVQF6Jax5ilti8LdWH1mQ7Xxq68wM3tp/RfRZyDg==
X-Received: by 2002:a50:e442:: with SMTP id e2mr4150064edm.227.1557411760681;
        Thu, 09 May 2019 07:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm596525edq.65.2019.05.09.07.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:40 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:40 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:29 GMT
Message-Id: <fc81c8946dd53d926b03ac94e1d9e11b4f9b8fc3.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 11/11] commit-graph: extract write_commit_graph_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

Extract write_commit_graph_file() that takes all of the information
in the context struct and writes the data to a commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 155 +++++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 75 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 16cdd7afb2..7723156964 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1015,21 +1015,91 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-int write_commit_graph(const char *obj_dir,
-		       struct string_list *pack_indexes,
-		       struct string_list *commit_hex,
-		       unsigned int flags)
+static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
-	struct write_commit_graph_context *ctx;
+	uint32_t i;
 	struct hashfile *f;
-	uint32_t i, count_distinct = 0;
-	char *graph_name = NULL;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
-	int num_chunks;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
+	int num_chunks = ctx->num_extra_edges ? 4 : 3;
+
+	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+	if (safe_create_leading_directories(ctx->graph_name)) {
+		UNLEAK(ctx->graph_name);
+		error(_("unable to create leading directories of %s"),
+			ctx->graph_name);
+		return errno;
+	}
+
+	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
+	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+
+	hashwrite_be32(f, GRAPH_SIGNATURE);
+
+	hashwrite_u8(f, GRAPH_VERSION);
+	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, 0); /* unused padding byte */
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	if (ctx->num_extra_edges)
+		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
+	else
+		chunk_ids[3] = 0;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
+
+	for (i = 0; i <= num_chunks; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		hashwrite(f, chunk_write, 12);
+	}
+
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Writing out commit graph in %d pass",
+			       "Writing out commit graph in %d passes",
+			       num_chunks),
+			    num_chunks);
+		ctx->progress = start_delayed_progress(
+			progress_title.buf,
+			num_chunks * ctx->commits.nr);
+	}
+	write_graph_chunk_fanout(f, ctx);
+	write_graph_chunk_oids(f, hashsz, ctx);
+	write_graph_chunk_data(f, hashsz, ctx);
+	if (ctx->num_extra_edges)
+		write_graph_chunk_extra_edges(f, ctx);
+	stop_progress(&ctx->progress);
+	strbuf_release(&progress_title);
+
+	close_commit_graph(ctx->r);
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	commit_lock_file(&lk);
+
+	return 0;
+}
+
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       unsigned int flags)
+{
+	struct write_commit_graph_context *ctx;
+	uint32_t i, count_distinct = 0;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
@@ -1096,75 +1166,10 @@ int write_commit_graph(const char *obj_dir,
 
 	compute_generation_numbers(ctx);
 
-	num_chunks = ctx->num_extra_edges ? 4 : 3;
-
-	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
-	if (safe_create_leading_directories(ctx->graph_name)) {
-		UNLEAK(ctx->graph_name);
-		error(_("unable to create leading directories of %s"),
-			ctx->graph_name);
-		res = errno;
-		goto cleanup;
-	}
-
-	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
-	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
-
-	hashwrite_be32(f, GRAPH_SIGNATURE);
-
-	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0); /* unused padding byte */
-
-	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
-	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
-	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (ctx->num_extra_edges)
-		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
-	else
-		chunk_ids[3] = 0;
-	chunk_ids[4] = 0;
-
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
-
-	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunk_ids[i]);
-		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
-		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
-	}
-
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Writing out commit graph in %d pass",
-			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
-		ctx->progress = start_delayed_progress(
-			progress_title.buf,
-			num_chunks * ctx->commits.nr);
-	}
-	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
-	if (ctx->num_extra_edges)
-		write_graph_chunk_extra_edges(f, ctx);
-	stop_progress(&ctx->progress);
-	strbuf_release(&progress_title);
-
-	close_commit_graph(ctx->r);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-	commit_lock_file(&lk);
+	res = write_commit_graph_file(ctx);
 
 cleanup:
-	free(graph_name);
+	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
 	free(ctx);
-- 
gitgitgadget
