Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E8A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWV7V (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:59:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45530 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:59:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so2925496edb.12
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=te36t15TrASYJqeyEOeqASgjlyBGrxQZs5+2iwyGOBU=;
        b=L6Lpd1GTiG7W9VUegmHLcLs0UGJCBM0AAf4SnMbpKuuuYZeGa2WWQr/Z2xAv4q9wfJ
         CwWMkWnFuZmKwD9i7PDQl5gIHnW8LSVG+SJPBQMWiBqg9dqjaHk2+/vxds+dnQWMOaA9
         vODYoZCOdCqthniB1Xdx/uT+gt3eeJSUfPr3GR/EmAn9ZuyZYxIT/IO0dGWI3fpk6+U2
         Z9LmnBJbF9pVh0VoRsQ4f6vFBdqTuxEguYHfbgt8z3wW+CzqOo+8+Jiv/Q3pZBm2fu0t
         VCquYN8DFBqk6y2rnQnMSDPoXhrrpH3UHfgznHpKeEMxyrx+7Momit+AtMfXdmw+Tn1o
         9TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=te36t15TrASYJqeyEOeqASgjlyBGrxQZs5+2iwyGOBU=;
        b=nnway7dbNyBaCBfKwIZsHnO0B85hjbG+bEkl7Df5+U0i6VlSArliZCAJuYx9r7b80J
         ZxlD641GF+FynQ6EhcgFuFpdSlgsg1Dj5IrN5TNbVG1ipQ4YfqTvSXNdjZzfx9oPiBAP
         IMqX9ehM7woEW5SZ4LljN2zrmwtIrPABHi9cmok11Db4bH09zqvUTdBGGbytzlwyjrih
         gh+cgQnJUJGQtuiw+DRJuInYDc/KCSlJQMJRSavV3/4z4vY3w1/MPEEchqNoN2VuuDSA
         IH9jCbw1XXhTctBB/xtYMKDOUtIPj6Lm81x6yWUL7MFsNMdDkpA3F0lcUFMtGIGh98lF
         rn5Q==
X-Gm-Message-State: AJcUukfwjC1Nj3zUN/oUS3ChFaX39LnJ5hajABA6aqoo7u0U690Sfazx
        7b+imHPvsn8LIIT1F0yjgOKN54Yr
X-Google-Smtp-Source: ALg8bN6PLFjBH7Evsxi7E9IyyBkQHnoGPjX6MMIL4/wcQnbTSRhCoErhjw7dHXaoTahcvr2AjTahUQ==
X-Received: by 2002:a50:8689:: with SMTP id r9mr4029140eda.227.1548280757770;
        Wed, 23 Jan 2019 13:59:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-v6sm5616066ejg.41.2019.01.23.13.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:59:17 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:59:17 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 21:59:10 GMT
Message-Id: <39319e36bc35dc89aff7640a11c0819c3bce8b2f.1548280753.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/6] commit-graph: create new version flags
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
index 28fe2378be..f7f45893fd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -25,9 +25,6 @@
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
-#define GRAPH_VERSION_1 0x1
-#define GRAPH_VERSION GRAPH_VERSION_1
-
 #define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
 #define GRAPH_PARENT_MISSING 0x7fffffff
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
@@ -118,30 +115,35 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != GRAPH_VERSION) {
+	if (graph_version != 1) {
 		error(_("graph version %X does not match version %X"),
-		      graph_version, GRAPH_VERSION);
-		goto cleanup_fail;
-	}
-
-	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version()) {
-		error(_("hash version %X does not match version %X"),
-		      hash_version, oid_version());
+		      graph_version, 1);
 		goto cleanup_fail;
 	}
 
 	graph = alloc_commit_graph();
 
+	switch (graph_version) {
+	case 1:
+		hash_version = *(unsigned char*)(data + 5);
+		if (hash_version != oid_version()) {
+			error(_("hash version %X does not match version %X"),
+			      hash_version, oid_version());
+			goto cleanup_fail;
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
 		uint32_t chunk_id = get_be32(chunk_lookup + 0);
 		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
@@ -792,10 +794,22 @@ int write_commit_graph(const char *obj_dir,
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
@@ -980,10 +994,16 @@ int write_commit_graph(const char *obj_dir,
 
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
@@ -994,7 +1014,7 @@ int write_commit_graph(const char *obj_dir,
 		chunk_ids[3] = 0;
 	chunk_ids[4] = 0;
 
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[0] = header_size + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
 	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
diff --git a/commit-graph.h b/commit-graph.h
index 83fa548138..e03df54e33 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -62,6 +62,7 @@ int generation_numbers_enabled(struct repository *r);
 
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
+#define COMMIT_GRAPH_VERSION_1  (1 << 2)
 
 int write_commit_graph_reachable(const char *obj_dir, int flags);
 int write_commit_graph(const char *obj_dir,
-- 
gitgitgadget

