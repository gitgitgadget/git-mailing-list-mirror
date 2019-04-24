Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E57F1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 19:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfDXT6G (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 15:58:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38056 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfDXT6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 15:58:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1so11098574edk.5
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4jXrEH3u6+2ASJDSdYR/l4MRYJmovDJ2Ro/5uCjMYwo=;
        b=eaoD3SOrHoYJPEJ/MF7B+0avdU7pzfBmmHpHcYT1zLduJgG/eiTJpu05QuM30tBSuC
         d7ZJBsfqYAK6X9lF2gI+t9yKSvFo6ki5fYYB/k5zwAH0WdfoBv6H0MjAzbbOR7BsR4wd
         jqHIIemPC1qxze6Tg7yXBES3b1RZj+7yPt8S0bZJhS4XkEJuT8sfoCE3gmnRyeCJTLFj
         APMdfmWEFQIg7nbLGC2TJWvwhVApWUQLEJBIGWoihyt6gnifU1PJYJJowYYjbwNEOh4h
         Ie3MtZGfa2L9sWm2ig1XFE11KKJO8mbJXe36quP7xSIosZlO5hGoFdGqh97EHOpvIvhY
         0SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4jXrEH3u6+2ASJDSdYR/l4MRYJmovDJ2Ro/5uCjMYwo=;
        b=oNZcAWvbk5v3FNNvUol3TSLZvLbQRXSLJLPohzRYfLVhTuG121nvV3E0nNPnwi3zJJ
         Gie4xvSdj7DhWn8XGMiJXmWAC9skMrls5wurBhzi6qh045pKmqH262H/PVmRjA4ijY4u
         IpORYMsxsiw/og50qoeSybGirfKDhw9U4PKCY1cLfjEKcQ9gpCU3Jo6xPw1XnaYZkPwE
         YQ1Mo8iUYCtAE6JEJRJ+atsRsPp7/w57x5i0lanqLcLpi+2dmy+a3jwFdEG1Dv/ir1mv
         d1JI8/idp2FlY7VkB/XytnXds9e9cmZjTPbIJg/rvEk5qtTFhSZu5AdFlVWgxgKV59f8
         NMPA==
X-Gm-Message-State: APjAAAU7HDBjvd5dyVf/iDbbvz9ONQPVHAkNStid7K4jqqH9Fj8yeA0R
        G8yaF8790Pnc2kmRabZqSeMIadi/
X-Google-Smtp-Source: APXvYqx9ZeyllF+9Kx/2QpmUxkcVveQU2TSF+g5WL+ogbcAU0CMunbGtyUe3uhagw6AYgcQ8tcb1uQ==
X-Received: by 2002:a17:906:a3d3:: with SMTP id ca19mr16840065ejb.78.1556135883303;
        Wed, 24 Apr 2019 12:58:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm1223783edd.43.2019.04.24.12.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:58:02 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:58:02 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 19:57:56 GMT
Message-Id: <pull.112.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/5] Create commit-graph file format v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file format has some shortcomings that were discussed
on-list:

 1. It doesn't use the 4-byte format ID from the_hash_algo.
    
    
 2. There is no way to change the reachability index from generation numbers
    to corrected commit date [1].
    
    
 3. The unused byte in the format could be used to signal the file is
    incremental, but current clients ignore the value even if it is
    non-zero.
    
    

This series adds a new version (2) to the commit-graph file. The fifth byte
already specified the file format, so existing clients will gracefully
respond to files with a different version number. The only real change now
is that the header takes 12 bytes instead of 8, due to using the 4-byte
format ID for the hash algorithm.

The new bytes reserved for the reachability index version and incremental
file formats are now expected to be equal to the defaults. When we update
these values to be flexible in the future, if a client understands
commit-graph v2 but not those new values, then it will fail gracefully.

NOTE: this series was rebased onto ab/commit-graph-fixes, as the conflicts
were significant and subtle.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/

Derrick Stolee (5):
  commit-graph: return with errors during write
  commit-graph: collapse parameters into flags
  commit-graph: create new version flags
  commit-graph: add --version=<n> option
  commit-graph: implement file format version 2

 Documentation/git-commit-graph.txt            |   3 +
 .../technical/commit-graph-format.txt         |  26 ++-
 builtin/commit-graph.c                        |  43 +++--
 builtin/commit.c                              |   5 +-
 builtin/gc.c                                  |   7 +-
 commit-graph.c                                | 156 +++++++++++++-----
 commit-graph.h                                |  16 +-
 t/t5318-commit-graph.sh                       |  68 +++++++-
 8 files changed, 254 insertions(+), 70 deletions(-)


base-commit: 93b4405ffe4ad9308740e7c1c71383bfc369baaa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-112%2Fderrickstolee%2Fgraph%2Fv2-head-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-112/derrickstolee/graph/v2-head-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/112

Range-diff vs v1:

 1:  e72498d0c5 ! 1:  91f300ec0a commit-graph: return with errors during write
     @@ -82,8 +82,8 @@
       --- a/builtin/gc.c
       +++ b/builtin/gc.c
      @@
     - 	if (pack_garbage.nr > 0)
       		clean_pack_garbage();
     + 	}
       
      -	if (gc_write_commit_graph)
      -		write_commit_graph_reachable(get_object_directory(), 0,
     @@ -182,9 +182,9 @@
       	}
       	stop_progress(&progress);
       
     --	if (count_distinct >= GRAPH_PARENT_MISSING)
     +-	if (count_distinct >= GRAPH_EDGE_LAST_MASK)
      -		die(_("the commit graph format cannot write %d commits"), count_distinct);
     -+	if (count_distinct >= GRAPH_PARENT_MISSING) {
     ++	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
      +		error(_("the commit graph format cannot write %d commits"), count_distinct);
      +		res = 1;
      +		goto cleanup;
     @@ -196,9 +196,9 @@
       	num_chunks = num_extra_edges ? 4 : 3;
       	stop_progress(&progress);
       
     --	if (commits.nr >= GRAPH_PARENT_MISSING)
     +-	if (commits.nr >= GRAPH_EDGE_LAST_MASK)
      -		die(_("too many commits to write graph"));
     -+	if (commits.nr >= GRAPH_PARENT_MISSING) {
     ++	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
      +		error(_("too many commits to write graph"));
      +		res = 1;
      +		goto cleanup;
 2:  43a40d0c43 ! 2:  04f5df1135 commit-graph: collapse parameters into flags
     @@ -66,7 +66,7 @@
       --- a/builtin/gc.c
       +++ b/builtin/gc.c
      @@
     - 		clean_pack_garbage();
     + 	}
       
       	if (gc_write_commit_graph &&
      -	    write_commit_graph_reachable(get_object_directory(), 0,
 3:  39319e36bc ! 3:  4ddb829163 commit-graph: create new version flags
     @@ -25,25 +25,25 @@
      -#define GRAPH_VERSION GRAPH_VERSION_1
      -
       #define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
     - #define GRAPH_PARENT_MISSING 0x7fffffff
       #define GRAPH_EDGE_LAST_MASK 0x7fffffff
     + #define GRAPH_PARENT_NONE 0x70000000
      @@
       	}
       
       	graph_version = *(unsigned char*)(data + 4);
      -	if (graph_version != GRAPH_VERSION) {
      +	if (graph_version != 1) {
     - 		error(_("graph version %X does not match version %X"),
     + 		error(_("commit-graph version %X does not match version %X"),
      -		      graph_version, GRAPH_VERSION);
     --		goto cleanup_fail;
     +-		return NULL;
      -	}
      -
      -	hash_version = *(unsigned char*)(data + 5);
      -	if (hash_version != oid_version()) {
     --		error(_("hash version %X does not match version %X"),
     +-		error(_("commit-graph hash version %X does not match version %X"),
      -		      hash_version, oid_version());
      +		      graph_version, 1);
     - 		goto cleanup_fail;
     + 		return NULL;
       	}
       
       	graph = alloc_commit_graph();
     @@ -52,9 +52,9 @@
      +	case 1:
      +		hash_version = *(unsigned char*)(data + 5);
      +		if (hash_version != oid_version()) {
     -+			error(_("hash version %X does not match version %X"),
     ++			error(_("commit-graph hash version %X does not match version %X"),
      +			      hash_version, oid_version());
     -+			goto cleanup_fail;
     ++			return NULL;
      +		}
      +
      +		graph->num_chunks = *(unsigned char*)(data + 6);
     @@ -72,8 +72,8 @@
       	last_chunk_offset = 8;
      -	chunk_lookup = data + 8;
       	for (i = 0; i < graph->num_chunks; i++) {
     - 		uint32_t chunk_id = get_be32(chunk_lookup + 0);
     - 		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
     + 		uint32_t chunk_id;
     + 		uint64_t chunk_offset;
      @@
       	int res = 0;
       	int append = flags & COMMIT_GRAPH_APPEND;
 4:  e7ae3007f5 ! 4:  b1b0c76eb4 commit-graph: add --version=<n> option
     @@ -2,7 +2,7 @@
      
          commit-graph: add --version=<n> option
      
     -    Allo the commit-graph builtin to specify the file format version
     +    Allow the commit-graph builtin to specify the file format version
          using the '--version=<n>' option. Specify the version exactly in
          the verification tests as using a different version would change
          the offsets used in those tests.
 5:  c55e0a738c ! 5:  09362bda1b commit-graph: implement file format version 2
     @@ -22,12 +22,20 @@
          We can also fail to read the commit-graph if the eighth byte is
          non-zero.
      
     -    The 'git commit-graph read' subcommand needs updating to show the
     -    new data.
     +    Update the 'git commit-graph read' subcommand to display the new
     +    data.
      
          Set the default file format version to 2, and adjust the tests to
          expect the new 'git commit-graph read' output.
      
     +    Add explicit tests for the upgrade path from version 1 to 2. Users
     +    with an existing commit-graph with version 1 will seamlessly
     +    upgrade to version 2 on their next write.
     +
     +    While we converted the existing 'verify' tests to use a version 1
     +    file to avoid recalculating data offsets, add explicit 'verify'
     +    tests on a version 2 file that corrupt the new header values.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
     @@ -118,21 +126,17 @@
      +	unsigned char graph_version, hash_version, reach_index_version;
      +	uint32_t hash_id;
       
     - 	if (fd < 0)
     + 	if (!graph_map)
       		return NULL;
      @@
       	}
       
       	graph_version = *(unsigned char*)(data + 4);
      -	if (graph_version != 1) {
     --		error(_("graph version %X does not match version %X"),
     --		      graph_version, 1);
      +	if (!graph_version || graph_version > 2) {
     -+		error(_("unsupported graph version %X"),
     -+		      graph_version);
     - 		goto cleanup_fail;
     - 	}
     - 
     + 		error(_("commit-graph version %X does not match version %X"),
     + 		      graph_version, 1);
     + 		return NULL;
      @@
       		graph->num_chunks = *(unsigned char*)(data + 6);
       		chunk_lookup = data + 8;
     @@ -145,18 +149,18 @@
      +		if (reach_index_version != 1) {
      +			error(_("unsupported reachability index version %d"),
      +			      reach_index_version);
     -+			goto cleanup_fail;
     ++			return NULL;
      +		}
      +
      +		if (*(unsigned char*)(data + 7)) {
      +			error(_("unsupported value in commit-graph header"));
     -+			goto cleanup_fail;
     ++			return NULL;
      +		}
      +
      +		hash_id = get_be32(data + 8);
      +		if (hash_id != the_hash_algo->format_id) {
      +			error(_("commit-graph hash algorithm does not match current algorithm"));
     -+			goto cleanup_fail;
     ++			return NULL;
      +		}
      +
      +		chunk_lookup = data + 12;
     @@ -209,6 +213,31 @@
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
       +++ b/t/t5318-commit-graph.sh
     +@@
     + 	git repack
     + '
     + 
     +-graph_git_two_modes() {
     ++graph_git_two_modes () {
     + 	git -c core.commitGraph=true $1 >output
     + 	git -c core.commitGraph=false $1 >expect
     + 	test_cmp expect output
     + }
     + 
     +-graph_git_behavior() {
     ++graph_git_behavior () {
     + 	MSG=$1
     + 	DIR=$2
     + 	BRANCH=$3
     +@@
     + 
     + graph_git_behavior 'no graph' full commits/3 commits/1
     + 
     +-graph_read_expect() {
     ++graph_read_expect () {
     + 	OPTIONAL=""
     + 	NUM_CHUNKS=3
     + 	if test ! -z $2
      @@
       		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
       	fi
     @@ -219,6 +248,40 @@
       	num_commits: $1
       	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
       	EOF
     +@@
     + 	)
     + '
     + 
     ++test_expect_success 'write v1 graph' '
     ++	git commit-graph write --reachable --version=1 &&
     ++	git commit-graph verify
     ++'
     ++
     ++graph_git_behavior 'version 1 graph, commit 8 vs merge 2' full commits/8 merge/2
     ++graph_git_behavior 'version 1 graph, commit 8 vs merge 2' full commits/8 merge/2
     ++
     ++test_expect_success 'upgrade from v1 to v2' '
     ++	git checkout -b new-commit-for-upgrade &&
     ++	test_commit force-upgrade &&
     ++	git commit-graph write --reachable --version=2 &&
     ++	git commit-graph verify
     ++'
     ++
     ++graph_git_behavior 'upgraded graph, commit 8 vs merge 2' full commits/8 merge/2
     ++graph_git_behavior 'upgraded graph, commit 8 vs merge 2' full commits/8 merge/2
     ++
     + # the verify tests below expect the commit-graph to contain
     + # exactly the commits reachable from the commits/8 branch.
     + # If the file changes the set of commits in the list, then the
     +@@
     + # starting at <zero_pos>, then runs 'git commit-graph verify'
     + # and places the output in the file 'err'. Test 'err' for
     + # the given string.
     +-corrupt_graph_and_verify() {
     ++corrupt_graph_and_verify () {
     + 	pos=$1
     + 	data="${2:-\0}"
     + 	grepstr=$3
      @@
       '
       
     @@ -235,3 +298,41 @@
       test_expect_success 'detect bad hash version' '
       	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
       		"hash version"
     +@@
     + 	test_must_fail git fsck
     + '
     + 
     ++test_expect_success 'rewrite commmit-graph with version 2' '
     ++	rm -f .git/objects/info/commit-graph &&
     ++	git commit-graph write --reachable --version=2 &&
     ++	git commit-graph verify
     ++'
     ++
     ++GRAPH_BYTE_CHUNK_COUNT=5
     ++GRAPH_BYTE_REACH_INDEX=6
     ++GRAPH_BYTE_UNUSED=7
     ++GRAPH_BYTE_HASH=8
     ++
     ++test_expect_success 'detect low chunk count (v2)' '
     ++	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
     ++		"missing the .* chunk"
     ++'
     ++
     ++test_expect_success 'detect incorrect reachability index' '
     ++	corrupt_graph_and_verify $GRAPH_BYTE_REACH_INDEX "\03" \
     ++		"reachability index version"
     ++'
     ++
     ++test_expect_success 'detect non-zero unused byte' '
     ++	corrupt_graph_and_verify $GRAPH_BYTE_UNUSED "\01" \
     ++		"unsupported value"
     ++'
     ++
     ++test_expect_success 'detect bad hash version (v2)' '
     ++	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\00" \
     ++		"hash algorithm"
     ++'
     ++
     + test_expect_success 'setup non-the_repository tests' '
     + 	rm -rf repo &&
     + 	git init repo &&
 6:  693900b4c5 < -:  ---------- commit-graph: test verifying a corrupt v2 header

-- 
gitgitgadget
