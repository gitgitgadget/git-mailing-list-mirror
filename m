Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C631F453
	for <e@80x24.org>; Wed, 24 Apr 2019 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfDXT6N (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 15:58:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41325 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfDXT6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 15:58:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id g6so17044478edc.8
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/6XmHzmf5UuErAREvYaEgOdQEWcGe8vwCyVDswBBhDQ=;
        b=YozRXM8v+tVmBf9Hvzm3HSwnT5Tq/c0eFf60x8Vah8D3fGGjZzHqx9jSlnxFL0cbPK
         xjpAbRqcreF5ri7E3Kt+nWjR5aFVo82uG1GOcFSf2LBMuv1HYQUmKVWtrl1M0gmh43HO
         zWE5gU8suuu+IIXxzOgeVqrhlWTi78FtutR2cBZe/HsfPLMw+Y74PIYkSFnx1DvDJvB2
         ihHosEaOfdRs4dPY1WW1bJYdRzbJe3MCtXpz5N9a9WABRxlHMhNgMAgO8FM3ESO7Z3Kp
         ZinNC+e7+pl9vT8lcwGjlu7QSNgiSQ2oNbr9VkoqZvHWun3SXQRgKJ8KzQ5t7OOLchjd
         aePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/6XmHzmf5UuErAREvYaEgOdQEWcGe8vwCyVDswBBhDQ=;
        b=lAqZ6EjBdeu+je7uDo+qaY+IgQjtKNnlDagTxa/QY+CfPULEwxsDp18uanrAEiMRH/
         fMoB6YPCW2r4NADJw3+jBlngAbGUIDTWsDVJAZnvCcxdQFG+F6fHJcwj0wj6xwcBHgu1
         d7D94FqbN4dyLn32Vnvu/RnEMTnNm0FDAL0mTomkdBDYAvngtfOAZv6V1OsQdz/etXdE
         dP5WNIfpb7Z1pcw0bS6YEhzeI0Un8pZDIefYCNaj246t4br4l2hiBCTEGD1MG+vZTh8N
         vSUG77cbBZwsh2I22oUgtudnkUGI90C5Om64EAjWkdicLm3oUvbT6SGKpN8icYkurHKz
         42Wg==
X-Gm-Message-State: APjAAAXLPYKEqI31ecZQonPS9iJbrn7iodf94FOt5hgkgTbQ7Dx19lLp
        jgqR8PoPpjfHPVMNvfRv/Xvtv7gX
X-Google-Smtp-Source: APXvYqzXSfZZlJ9G6vDneYudvHJjgn2w9qnTvKEnb/ECAxBFTEM0940qakeAGO/f/2ZiDRwi8o4NVw==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr21679336eds.77.1556135887537;
        Wed, 24 Apr 2019 12:58:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm3687333ejq.73.2019.04.24.12.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:58:07 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:58:07 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 19:58:01 GMT
Message-Id: <09362bda1b6c2e7f3292b634b9ed380fe2a5ccd5.1556135881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v2.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/5] commit-graph: implement file format version 2
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

Update the 'git commit-graph read' subcommand to display the new
data.

Set the default file format version to 2, and adjust the tests to
expect the new 'git commit-graph read' output.

Add explicit tests for the upgrade path from version 1 to 2. Users
with an existing commit-graph with version 1 will seamlessly
upgrade to version 2 on their next write.

While we converted the existing 'verify' tests to use a version 1
file to avoid recalculating data offsets, add explicit 'verify'
tests on a version 2 file that corrupt the new header values.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         | 26 +++++++-
 builtin/commit-graph.c                        |  9 +++
 commit-graph.c                                | 43 ++++++++++--
 commit-graph.h                                |  1 +
 t/t5318-commit-graph.sh                       | 66 +++++++++++++++++--
 5 files changed, 134 insertions(+), 11 deletions(-)

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
index 65ceb7a141..1485b4daaf 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -117,6 +117,11 @@ static int graph_read(int argc, const char **argv)
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
 
@@ -177,6 +182,10 @@ static int graph_write(int argc, const char **argv)
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
index e75e1655fb..14d6aebd99 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -152,7 +152,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	uint64_t last_chunk_offset;
 	uint32_t last_chunk_id;
 	uint32_t graph_signature;
-	unsigned char graph_version, hash_version;
+	unsigned char graph_version, hash_version, reach_index_version;
+	uint32_t hash_id;
 
 	if (!graph_map)
 		return NULL;
@@ -170,7 +171,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != 1) {
+	if (!graph_version || graph_version > 2) {
 		error(_("commit-graph version %X does not match version %X"),
 		      graph_version, 1);
 		return NULL;
@@ -190,6 +191,30 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
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
+			return NULL;
+		}
+
+		if (*(unsigned char*)(data + 7)) {
+			error(_("unsupported value in commit-graph header"));
+			return NULL;
+		}
+
+		hash_id = get_be32(data + 8);
+		if (hash_id != the_hash_algo->format_id) {
+			error(_("commit-graph hash algorithm does not match current algorithm"));
+			return NULL;
+		}
+
+		chunk_lookup = data + 12;
+		break;
 	}
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -898,9 +923,11 @@ int write_commit_graph(const char *obj_dir,
 
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
@@ -1099,6 +1126,14 @@ int write_commit_graph(const char *obj_dir,
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
index d7cd13deb3..2c461770e8 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -68,6 +68,7 @@ int generation_numbers_enabled(struct repository *r);
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
 #define COMMIT_GRAPH_VERSION_1  (1 << 2)
+#define COMMIT_GRAPH_VERSION_2  (1 << 3)
 
 int write_commit_graph_reachable(const char *obj_dir, int flags);
 int write_commit_graph(const char *obj_dir,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4eb5a09ef3..0c766e7cdb 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -33,13 +33,13 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-graph_git_two_modes() {
+graph_git_two_modes () {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
 	test_cmp expect output
 }
 
-graph_git_behavior() {
+graph_git_behavior () {
 	MSG=$1
 	DIR=$2
 	BRANCH=$3
@@ -56,7 +56,7 @@ graph_git_behavior() {
 
 graph_git_behavior 'no graph' full commits/3 commits/1
 
-graph_read_expect() {
+graph_read_expect () {
 	OPTIONAL=""
 	NUM_CHUNKS=3
 	if test ! -z $2
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
@@ -320,6 +321,24 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 	)
 '
 
+test_expect_success 'write v1 graph' '
+	git commit-graph write --reachable --version=1 &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'version 1 graph, commit 8 vs merge 2' full commits/8 merge/2
+graph_git_behavior 'version 1 graph, commit 8 vs merge 2' full commits/8 merge/2
+
+test_expect_success 'upgrade from v1 to v2' '
+	git checkout -b new-commit-for-upgrade &&
+	test_commit force-upgrade &&
+	git commit-graph write --reachable --version=2 &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'upgraded graph, commit 8 vs merge 2' full commits/8 merge/2
+graph_git_behavior 'upgraded graph, commit 8 vs merge 2' full commits/8 merge/2
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
@@ -392,7 +411,7 @@ corrupt_graph_verify() {
 # starting at <zero_pos>, then runs 'git commit-graph verify'
 # and places the output in the file 'err'. Test 'err' for
 # the given string.
-corrupt_graph_and_verify() {
+corrupt_graph_and_verify () {
 	pos=$1
 	data="${2:-\0}"
 	grepstr=$3
@@ -424,10 +443,14 @@ test_expect_success 'detect bad signature' '
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
@@ -532,6 +555,37 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'rewrite commmit-graph with version 2' '
+	rm -f .git/objects/info/commit-graph &&
+	git commit-graph write --reachable --version=2 &&
+	git commit-graph verify
+'
+
+GRAPH_BYTE_CHUNK_COUNT=5
+GRAPH_BYTE_REACH_INDEX=6
+GRAPH_BYTE_UNUSED=7
+GRAPH_BYTE_HASH=8
+
+test_expect_success 'detect low chunk count (v2)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
+		"missing the .* chunk"
+'
+
+test_expect_success 'detect incorrect reachability index' '
+	corrupt_graph_and_verify $GRAPH_BYTE_REACH_INDEX "\03" \
+		"reachability index version"
+'
+
+test_expect_success 'detect non-zero unused byte' '
+	corrupt_graph_and_verify $GRAPH_BYTE_UNUSED "\01" \
+		"unsupported value"
+'
+
+test_expect_success 'detect bad hash version (v2)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\00" \
+		"hash algorithm"
+'
+
 test_expect_success 'setup non-the_repository tests' '
 	rm -rf repo &&
 	git init repo &&
-- 
gitgitgadget
