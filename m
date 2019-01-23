Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08181F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfAWV7X (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:59:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44675 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfAWV7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:59:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so2930621edd.11
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NivCbGUJB6WuorAbciQo5yG9ezlDC6l30RyY88tvGkg=;
        b=R899/X827Q0PCNtTxm1O0ApEPolCBpW6JfV87/0xtLFze6t3Q99BlM3qUc6BZwg1Jl
         0rFTns4Zmku158efp1El95BaVQbeDCD6zOmZhfSTfWe67492YRk5G+wov6esD8kDjPqX
         qBN7jlr1C6+h2O+LbJEFnfHUdjeo2JeusKxBVb3Lb0U+jZ5Naup1sGfa+BdnjMoFTqGM
         NWTdBpzt9WC/ZAF5u3qB3Ino0X3x9aZSBrKWuwt2mhtBpBQSMX7GgW945X7uBdgKqlb5
         obpj6eJLPNlgZyz/9y3tkz4Y1K2lGLEykXj10j0mlxo1n71EPnwCrKaeqmHfptMQKBYv
         z/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NivCbGUJB6WuorAbciQo5yG9ezlDC6l30RyY88tvGkg=;
        b=hSzSPvCVAkKSgKK30A+y+BNX8O9DCX9sgF4+iIXlc+fE4Xqg2xtdItW62mXVkiARoi
         MFtijj+uGbg3QagTQQOw0Etb7P2F5SFIa2RyJapX+MMrazu6YillXfw96j2l5tdx4HEa
         LPXhfNlctygZmqW5Z3C9aw7j0TSpRCEplLQhcZPng0uJElzpYy5Uv8tXTkgqs21oP3Ml
         IHOEX37Z/W0HPQbCmgx91vomrbQfFbzXKJyaz3dnSEmf3U1P/X5cBjyalkHUnyt4SjUY
         ESKmwEXKse3fDi5wDE3/wsWwbs1LUil4ly0V1mqE9tLwLuWe0lX6FB5GXR7ibQwbQEVd
         58Tg==
X-Gm-Message-State: AJcUukcRdqSk0ZPmPl96ki3skrlDhtCgZElMrX5n9CdO18FqdvzXVhxT
        a1Rbu6jP261kbJWLEi0+hsQajJUc
X-Google-Smtp-Source: ALg8bN56pE6mzZgCDVKqjLcVIEjWafVRjPV06Fa4tJlzvXleYvMlP9ON0gGRThiecZiN01LnrvX8Ng==
X-Received: by 2002:a50:87d9:: with SMTP id 25mr4161714edz.259.1548280759815;
        Wed, 23 Jan 2019 13:59:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm925182ejr.17.2019.01.23.13.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:59:19 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:59:19 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 21:59:12 GMT
Message-Id: <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/6] commit-graph: implement file format version 2
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

The commit-graph file format had some shortcomings which we now
correct:

  1. The hash algorithm was determined by a single byte, instead
     of the 4-byte format identifier.

  2. There was no way to update the reachability index we used.
     We currently only support generation numbers, but that will
     change in the future.

  3. Git did not fail with error if the unused eighth byte was
     non-zero, so we could not use that to indicate an incremental
     file format without breaking compatibility across versions.

The new format modifies the header of the commit-graph to solve
these problems. We use the 4-byte hash format id, freeing up a byte
in our 32-bit alignment to introduce a reachability index version.
We can also fail to read the commit-graph if the eighth byte is
non-zero.

The 'git commit-graph read' subcommand needs updating to show the
new data.

Set the default file format version to 2, and adjust the tests to
expect the new 'git commit-graph read' output.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         | 26 +++++++++-
 builtin/commit-graph.c                        |  9 ++++
 commit-graph.c                                | 47 ++++++++++++++++---
 commit-graph.h                                |  1 +
 t/t5318-commit-graph.sh                       |  9 +++-
 5 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 16452a0504..e367aa94b1 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -31,13 +31,22 @@ and hash type.
 
 All 4-byte numbers are in network order.
 
+There are two versions available, 1 and 2. These currently differ only in
+the header.
+
 HEADER:
 
+All commit-graph files use the first five bytes for the same purpose.
+
   4-byte signature:
       The signature is: {'C', 'G', 'P', 'H'}
 
   1-byte version number:
-      Currently, the only valid version is 1.
+      Currently, the valid version numbers are 1 and 2.
+
+The remainder of the header changes depending on the version.
+
+Version 1:
 
   1-byte Hash Version (1 = SHA-1)
       We infer the hash length (H) from this value.
@@ -47,6 +56,21 @@ HEADER:
   1-byte (reserved for later use)
      Current clients should ignore this value.
 
+Version 2:
+
+  1-byte number (C) of "chunks"
+
+  1-byte reachability index version number:
+      Currently, the only valid number is 1.
+
+  1-byte (reserved for later use)
+      Current clients expect this value to be zero, and will not
+      try to read the commit-graph file if it is non-zero.
+
+  4-byte format identifier for the hash algorithm:
+      If this identifier does not agree with the repository's current
+      hash algorithm, then the client will not read the commit graph.
+
 CHUNK LOOKUP:
 
   (C + 1) * 12 bytes listing the table of contents for the chunks:
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index b1bed84260..28787d0c9c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -102,6 +102,11 @@ static int graph_read(int argc, const char **argv)
 		*(unsigned char*)(graph->data + 5),
 		*(unsigned char*)(graph->data + 6),
 		*(unsigned char*)(graph->data + 7));
+
+	if (*(unsigned char *)(graph->data + 4) == 2)
+		printf("hash algorithm: %X\n",
+		       get_be32(graph->data + 8));
+
 	printf("num_commits: %u\n", graph->num_commits);
 	printf("chunks:");
 
@@ -162,6 +167,10 @@ static int graph_write(int argc, const char **argv)
 	case 1:
 		flags |= COMMIT_GRAPH_VERSION_1;
 		break;
+
+	case 2:
+		flags |= COMMIT_GRAPH_VERSION_2;
+		break;
 	}
 
 	read_replace_refs = 0;
diff --git a/commit-graph.c b/commit-graph.c
index f7f45893fd..aeb6cae656 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -90,7 +90,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	uint64_t last_chunk_offset;
 	uint32_t last_chunk_id;
 	uint32_t graph_signature;
-	unsigned char graph_version, hash_version;
+	unsigned char graph_version, hash_version, reach_index_version;
+	uint32_t hash_id;
 
 	if (fd < 0)
 		return NULL;
@@ -115,9 +116,9 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != 1) {
-		error(_("graph version %X does not match version %X"),
-		      graph_version, 1);
+	if (!graph_version || graph_version > 2) {
+		error(_("unsupported graph version %X"),
+		      graph_version);
 		goto cleanup_fail;
 	}
 
@@ -135,6 +136,30 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		graph->num_chunks = *(unsigned char*)(data + 6);
 		chunk_lookup = data + 8;
 		break;
+
+	case 2:
+		graph->num_chunks = *(unsigned char *)(data + 5);
+
+		reach_index_version = *(unsigned char *)(data + 6);
+		if (reach_index_version != 1) {
+			error(_("unsupported reachability index version %d"),
+			      reach_index_version);
+			goto cleanup_fail;
+		}
+
+		if (*(unsigned char*)(data + 7)) {
+			error(_("unsupported value in commit-graph header"));
+			goto cleanup_fail;
+		}
+
+		hash_id = get_be32(data + 8);
+		if (hash_id != the_hash_algo->format_id) {
+			error(_("commit-graph hash algorithm does not match current algorithm"));
+			goto cleanup_fail;
+		}
+
+		chunk_lookup = data + 12;
+		break;
 	}
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -802,9 +827,11 @@ int write_commit_graph(const char *obj_dir,
 
 	if (flags & COMMIT_GRAPH_VERSION_1)
 		version = 1;
+	if (flags & COMMIT_GRAPH_VERSION_2)
+		version = 2;
 	if (!version)
-		version = 1;
-	if (version != 1) {
+		version = 2;
+	if (version <= 0 || version > 2) {
 		error(_("unsupported commit-graph version %d"),
 		      version);
 		return 1;
@@ -1003,6 +1030,14 @@ int write_commit_graph(const char *obj_dir,
 		hashwrite_u8(f, 0); /* unused padding byte */
 		header_size = 8;
 		break;
+
+	case 2:
+		hashwrite_u8(f, num_chunks);
+		hashwrite_u8(f, 1); /* reachability index version */
+		hashwrite_u8(f, 0); /* unused padding byte */
+		hashwrite_be32(f, the_hash_algo->format_id);
+		header_size = 12;
+		break;
 	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
diff --git a/commit-graph.h b/commit-graph.h
index e03df54e33..050137063b 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -63,6 +63,7 @@ int generation_numbers_enabled(struct repository *r);
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
 #define COMMIT_GRAPH_VERSION_1  (1 << 2)
+#define COMMIT_GRAPH_VERSION_2  (1 << 3)
 
 int write_commit_graph_reachable(const char *obj_dir, int flags);
 int write_commit_graph(const char *obj_dir,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b79d6263e9..3ff5e3b48d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -65,7 +65,8 @@ graph_read_expect() {
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
 	fi
 	cat >expect <<- EOF
-	header: 43475048 1 1 $NUM_CHUNKS 0
+	header: 43475048 2 $NUM_CHUNKS 1 0
+	hash algorithm: 73686131
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	EOF
@@ -390,10 +391,14 @@ test_expect_success 'detect bad signature' '
 '
 
 test_expect_success 'detect bad version' '
-	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\03" \
 		"graph version"
 '
 
+test_expect_success 'detect version 2 with version 1 data' '
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+		"reachability index version"
+'
 test_expect_success 'detect bad hash version' '
 	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
 		"hash version"
-- 
gitgitgadget

