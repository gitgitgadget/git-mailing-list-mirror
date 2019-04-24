Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79F21F453
	for <e@80x24.org>; Wed, 24 Apr 2019 19:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfDXT6K (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 15:58:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46718 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfDXT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 15:58:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so17020006edd.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DgC9KrWThR7Gae7zyi+aJ3mpctAAVHMm8G1U10OCpnk=;
        b=bJ6iBaUqUseGp/mAZEYARrekTvK77qd937alw5Dy9MIlkq8F5KZjQSkZTePmqmZvAl
         FAPIkralT6+VXmmeFWIUAst45VjjEi+fI1iL2+IrWtK3rQwqyagmthJFgMpyRgvS9IjS
         6CJjLpsVCWOxnSas4wQLmUr6MkLVFJgquftqRa4uy2E8vj82DycZcaHs3M6114/dkLsg
         QO/xWHTV1IsDKy88JAhrbQxi1+yChgHLbaKmhXU8yGKnkUwoGHHht+yaZGTBTTSFSgci
         uTm08PRn6gwYkMfMJTo1dfmQ3QYZj1FQ99GCy77+A6I+5GnU1C7oAn1J3i/1rqgSaJCd
         CqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DgC9KrWThR7Gae7zyi+aJ3mpctAAVHMm8G1U10OCpnk=;
        b=E5Yt5qnBRtkeZpVYZQ3NImatOqRpRlkmllK+/QIgtENhrIlTF+xaowTQC+izWjoT2m
         RY5euXQ/wLD+fmcqslyvhbCgMMUQJWMVLfsxTp74B3rB1r4eHD02yKAxBOuLJyPqmwdB
         TvUrghmcyhXEUHJeEs6BcOSABzqJtdsIrLayXMv7B5pIzaByBCvY7UC4o0qzidZJUdWA
         T49iWy1UJRykldaB0yK4P4c33F6BHFth6JL7wq/qrmVIxWSwaqeqJ+dd7H0wZTYb1g9Y
         Suv/7wu7e9oCGn7jfz+QLit5hUCGzlNYFX6lnUssDowKSUJV/+oX3UmKX+lmTF5gGwor
         Xb5g==
X-Gm-Message-State: APjAAAUhkxxxVjiWB41J4fAsIAV25EIfAJUNTPnsVeuiJc+l7kbH3GXs
        Jx7pEff48TSIG6jxeETYf2DfByFs
X-Google-Smtp-Source: APXvYqxjLtADHmHwz/4ZFiyJjALFvrMj5sc3Voaolk3M9Z/DkjdvqOczdaCCgwGcHbuNd0opjYS2kg==
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr17483135ejb.215.1556135886022;
        Wed, 24 Apr 2019 12:58:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 30sm5905493edr.2.2019.04.24.12.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:58:05 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:58:05 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 19:57:59 GMT
Message-Id: <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v2.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/5] commit-graph: create new version flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of a new commit-graph file format version, create
a flag for the write_commit_graph() and write_commit_graph_reachable()
methods to take a version number.

When there is no specified version, the implementation selects a
default value. Currently, the only valid value is 1.

The file format will change the header information, so place the
existing header logic inside a switch statement with only one case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 58 +++++++++++++++++++++++++++++++++-----------------
 commit-graph.h |  1 +
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b16c71fd82..e75e1655fb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -25,9 +25,6 @@
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
-#define GRAPH_VERSION_1 0x1
-#define GRAPH_VERSION GRAPH_VERSION_1
-
 #define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
 #define GRAPH_PARENT_NONE 0x70000000
@@ -173,30 +170,35 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != GRAPH_VERSION) {
+	if (graph_version != 1) {
 		error(_("commit-graph version %X does not match version %X"),
-		      graph_version, GRAPH_VERSION);
-		return NULL;
-	}
-
-	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version()) {
-		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version());
+		      graph_version, 1);
 		return NULL;
 	}
 
 	graph = alloc_commit_graph();
 
+	switch (graph_version) {
+	case 1:
+		hash_version = *(unsigned char*)(data + 5);
+		if (hash_version != oid_version()) {
+			error(_("commit-graph hash version %X does not match version %X"),
+			      hash_version, oid_version());
+			return NULL;
+		}
+
+		graph->num_chunks = *(unsigned char*)(data + 6);
+		chunk_lookup = data + 8;
+		break;
+	}
+
 	graph->hash_len = the_hash_algo->rawsz;
-	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->graph_fd = fd;
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
 	last_chunk_id = 0;
 	last_chunk_offset = 8;
-	chunk_lookup = data + 8;
 	for (i = 0; i < graph->num_chunks; i++) {
 		uint32_t chunk_id;
 		uint64_t chunk_offset;
@@ -888,10 +890,22 @@ int write_commit_graph(const char *obj_dir,
 	int res = 0;
 	int append = flags & COMMIT_GRAPH_APPEND;
 	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
+	int version = 0;
+	int header_size = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
 
+	if (flags & COMMIT_GRAPH_VERSION_1)
+		version = 1;
+	if (!version)
+		version = 1;
+	if (version != 1) {
+		error(_("unsupported commit-graph version %d"),
+		      version);
+		return 1;
+	}
+
 	oids.nr = 0;
 	approx_nr_objects = approximate_object_count();
 	oids.alloc = approx_nr_objects / 32;
@@ -1076,10 +1090,16 @@ int write_commit_graph(const char *obj_dir,
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
-	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0); /* unused padding byte */
+	hashwrite_u8(f, version);
+
+	switch (version) {
+	case 1:
+		hashwrite_u8(f, oid_version());
+		hashwrite_u8(f, num_chunks);
+		hashwrite_u8(f, 0); /* unused padding byte */
+		header_size = 8;
+		break;
+	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
@@ -1090,7 +1110,7 @@ int write_commit_graph(const char *obj_dir,
 		chunk_ids[3] = 0;
 	chunk_ids[4] = 0;
 
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[0] = header_size + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
 	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
diff --git a/commit-graph.h b/commit-graph.h
index 390474047c..d7cd13deb3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -67,6 +67,7 @@ int generation_numbers_enabled(struct repository *r);
 
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
+#define COMMIT_GRAPH_VERSION_1  (1 << 2)
 
 int write_commit_graph_reachable(const char *obj_dir, int flags);
 int write_commit_graph(const char *obj_dir,
-- 
gitgitgadget

