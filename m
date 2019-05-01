Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C26E1F453
	for <e@80x24.org>; Wed,  1 May 2019 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEANLS (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:11:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44389 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEANLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:11:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so5816435edm.11
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O2JLC2rIVKc15DvNEsD51fxxMiilHgU3Kxgh5W9whvU=;
        b=bd8SEXwZF/mgcH5OfIEcQd294y10O6sp48EOI0Q6RtA1fTrBonbUykRGcTSEZem8ok
         Dv1ddfgVZIPpwocZB4BuW3IMTt1FDFK2Pnv48bi40oJvXS3fSR+mkKLYYoB1wJKyRLAQ
         Z1x7Go999Fc8R1AjxfHn5hF95AX+O/fkZMGuI+i8YjDVskOhOLS6gchoUWMLbQF2a1pY
         muxYjxlQyVOcC/lXa7/OuQoJpodDlnRovXZZAVtJnYXt5dsVg8U2RRLvXRJW4PyOhRx+
         2IVCkaQIflPO+ffYpr6Z/dCurjXZhsy8SswEiuLZdRr7iYbvTnxjwbpy1pQCriu2SfZT
         78Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O2JLC2rIVKc15DvNEsD51fxxMiilHgU3Kxgh5W9whvU=;
        b=avgvD8wCXk6+NYn5AzA1uTN+ihE0XXnULkQbsmTKc6DVs34e7d3tzNP7r4yltTI/W+
         OBndOyoRsaZSxUiJFFVOXa3ZI6ZaHsCR6qw6uSNoCAk5awu6I7J5FQXSTysCEBzcqwUN
         yzzawHxG5ipTHuTMUjL7rmfvXj4HuGshXleQiXhoafOiT+jMNNbYkpOTD4bi7B5sW2sp
         dY+NIbeS8JGD14dVOhIOadXR8m4VrIBjtrYmaacWdlLgnU1RGNYnkGfn8FkgXQVnBKh8
         KTR1m+lbZJCFN0zha9Nsc4MtYdux2HIpfuMpXHkkNjlyNXb4+LbaKWzw076kPzOfQDVu
         6+lw==
X-Gm-Message-State: APjAAAWJCXLvC+WitKZ6bFRVAbHDYuSOK2WSIOd15kW2B1tmDjx957zR
        c+H1c2qj2G+ZjyjNrwFe/9hgT2Ca
X-Google-Smtp-Source: APXvYqx2qg0WQFFzTsTMdH2+0iB2VixIK/iVRzrRF08pd5mNGKihFUgjfTDlIoAhU7AWD8C2yhKPWQ==
X-Received: by 2002:a50:b18e:: with SMTP id m14mr8852483edd.234.1556716274545;
        Wed, 01 May 2019 06:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm123744edb.23.2019.05.01.06.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:11:13 -0700 (PDT)
Date:   Wed, 01 May 2019 06:11:13 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 13:11:06 GMT
Message-Id: <pull.112.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v2.git.gitgitgadget@gmail.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/6] Create commit-graph file format v2
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

Updates in V3: Thanks for all the feedback so far!

 * Moved the version information into an unsigned char parameter, instead of
   a flag.
   
   
 * We no longer default to the v2 file format, as that will break users who
   downgrade. This required some changes to the test script.
   
   
 * Removed the "Future work" section from the commit-graph design document
   in a new patch.
   
   
 * I did not change the file name for v2 file formats, as Ævar suggested.
   I'd like the discussion to continue on this topic.
   
   

Thanks, -Stolee

[1] 
https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/

Derrick Stolee (6):
  commit-graph: return with errors during write
  commit-graph: collapse parameters into flags
  commit-graph: create new version parameter
  commit-graph: add --version=<n> option
  commit-graph: implement file format version 2
  commit-graph: remove Future Work section

 Documentation/git-commit-graph.txt            |   3 +
 .../technical/commit-graph-format.txt         |  26 ++-
 Documentation/technical/commit-graph.txt      |  17 --
 builtin/commit-graph.c                        |  33 ++--
 builtin/commit.c                              |   5 +-
 builtin/gc.c                                  |   8 +-
 commit-graph.c                                | 153 +++++++++++++-----
 commit-graph.h                                |  16 +-
 t/t5318-commit-graph.sh                       |  75 ++++++++-
 9 files changed, 250 insertions(+), 86 deletions(-)


base-commit: 93b4405ffe4ad9308740e7c1c71383bfc369baaa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-112%2Fderrickstolee%2Fgraph%2Fv2-head-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-112/derrickstolee/graph/v2-head-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/112

Range-diff vs v2:

 1:  91f300ec0a = 1:  91f300ec0a commit-graph: return with errors during write
 2:  04f5df1135 ! 2:  924b22f990 commit-graph: collapse parameters into flags
     @@ -86,7 +86,7 @@
       
      -int write_commit_graph_reachable(const char *obj_dir, int append,
      -				 int report_progress)
     -+int write_commit_graph_reachable(const char *obj_dir, int flags)
     ++int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
       {
       	struct string_list list = STRING_LIST_INIT_DUP;
       	int result;
     @@ -103,7 +103,7 @@
       		       struct string_list *pack_indexes,
       		       struct string_list *commit_hex,
      -		       int append, int report_progress)
     -+		       int flags)
     ++		       unsigned int flags)
       {
       	struct packed_oid_list oids;
       	struct packed_commit_list commits;
     @@ -129,12 +129,12 @@
      +#define COMMIT_GRAPH_APPEND     (1 << 0)
      +#define COMMIT_GRAPH_PROGRESS   (1 << 1)
      +
     -+int write_commit_graph_reachable(const char *obj_dir, int flags);
     ++int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
       int write_commit_graph(const char *obj_dir,
       		       struct string_list *pack_indexes,
       		       struct string_list *commit_hex,
      -		       int append, int report_progress);
     -+		       int flags);
     ++		       unsigned int flags);
       
       int verify_commit_graph(struct repository *r, struct commit_graph *g);
       
 3:  4ddb829163 ! 3:  8446011a43 commit-graph: create new version flags
     @@ -1,12 +1,12 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    commit-graph: create new version flags
     +    commit-graph: create new version parameter
      
          In anticipation of a new commit-graph file format version, create
     -    a flag for the write_commit_graph() and write_commit_graph_reachable()
     +    a parameter for the write_commit_graph() and write_commit_graph_reachable()
          methods to take a version number.
      
     -    When there is no specified version, the implementation selects a
     +    When the given version is zero, the implementation selects a
          default value. Currently, the only valid value is 1.
      
          The file format will change the header information, so place the
     @@ -14,6 +14,55 @@
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
     + --- a/builtin/commit-graph.c
     + +++ b/builtin/commit-graph.c
     +@@
     + 	read_replace_refs = 0;
     + 
     + 	if (opts.reachable)
     +-		return write_commit_graph_reachable(opts.obj_dir, flags);
     ++		return write_commit_graph_reachable(opts.obj_dir, flags, 0);
     + 
     + 	string_list_init(&lines, 0);
     + 	if (opts.stdin_packs || opts.stdin_commits) {
     +@@
     + 	result = write_commit_graph(opts.obj_dir,
     + 				    pack_indexes,
     + 				    commit_hex,
     +-				    flags);
     ++				    flags, 0);
     + 
     + 	UNLEAK(lines);
     + 	return result;
     +
     + diff --git a/builtin/commit.c b/builtin/commit.c
     + --- a/builtin/commit.c
     + +++ b/builtin/commit.c
     +@@
     + 		      "not exceeded, and then \"git reset HEAD\" to recover."));
     + 
     + 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
     +-	    write_commit_graph_reachable(get_object_directory(), 0))
     ++	    write_commit_graph_reachable(get_object_directory(), 0, 0))
     + 		return 1;
     + 
     + 	repo_rerere(the_repository, 0);
     +
     + diff --git a/builtin/gc.c b/builtin/gc.c
     + --- a/builtin/gc.c
     + +++ b/builtin/gc.c
     +@@
     + 
     + 	if (gc_write_commit_graph &&
     + 	    write_commit_graph_reachable(get_object_directory(),
     +-					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
     ++					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
     ++					 0))
     + 		return 1;
     + 
     + 	if (auto_gc && too_many_loose_objects())
     +
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
     @@ -74,18 +123,43 @@
       	for (i = 0; i < graph->num_chunks; i++) {
       		uint32_t chunk_id;
       		uint64_t chunk_offset;
     +@@
     + 	return 0;
     + }
     + 
     +-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
     ++int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
     ++				 unsigned char version)
     + {
     + 	struct string_list list = STRING_LIST_INIT_DUP;
     + 	int result;
     + 
     + 	for_each_ref(add_ref_to_list, &list);
     + 	result = write_commit_graph(obj_dir, NULL, &list,
     +-				    flags);
     ++				    flags, version);
     + 
     + 	string_list_clear(&list, 0);
     + 	return result;
     +@@
     + int write_commit_graph(const char *obj_dir,
     + 		       struct string_list *pack_indexes,
     + 		       struct string_list *commit_hex,
     +-		       unsigned int flags)
     ++		       unsigned int flags,
     ++		       unsigned char version)
     + {
     + 	struct packed_oid_list oids;
     + 	struct packed_commit_list commits;
      @@
       	int res = 0;
       	int append = flags & COMMIT_GRAPH_APPEND;
       	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
     -+	int version = 0;
      +	int header_size = 0;
       
       	if (!commit_graph_compatible(the_repository))
       		return 0;
       
     -+	if (flags & COMMIT_GRAPH_VERSION_1)
     -+		version = 1;
      +	if (!version)
      +		version = 1;
      +	if (version != 1) {
     @@ -132,10 +206,18 @@
       --- a/commit-graph.h
       +++ b/commit-graph.h
      @@
     - 
       #define COMMIT_GRAPH_APPEND     (1 << 0)
       #define COMMIT_GRAPH_PROGRESS   (1 << 1)
     -+#define COMMIT_GRAPH_VERSION_1  (1 << 2)
       
     - int write_commit_graph_reachable(const char *obj_dir, int flags);
     +-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
     ++int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
     ++				 unsigned char version);
       int write_commit_graph(const char *obj_dir,
     + 		       struct string_list *pack_indexes,
     + 		       struct string_list *commit_hex,
     +-		       unsigned int flags);
     ++		       unsigned int flags,
     ++		       unsigned char version);
     + 
     + int verify_commit_graph(struct repository *r, struct commit_graph *g);
     + 
 4:  b1b0c76eb4 ! 4:  6a0e99f9f9 commit-graph: add --version=<n> option
     @@ -62,18 +62,29 @@
       	};
       
      @@
     + 	if (!opts.obj_dir)
     + 		opts.obj_dir = get_object_directory();
       	if (opts.append)
     - 		flags |= COMMIT_GRAPH_APPEND;
     +-		flags |= COMMIT_GRAPH_APPEND;
     ++		flags |= COMMIT_GRAPH_APPEND;	
       
     -+	switch (opts.version) {
     -+	case 1:
     -+		flags |= COMMIT_GRAPH_VERSION_1;
     -+		break;
     -+	}
     -+
       	read_replace_refs = 0;
       
       	if (opts.reachable)
     +-		return write_commit_graph_reachable(opts.obj_dir, flags, 0);
     ++		return write_commit_graph_reachable(opts.obj_dir, flags, opts.version);
     + 
     + 	string_list_init(&lines, 0);
     + 	if (opts.stdin_packs || opts.stdin_commits) {
     +@@
     + 	result = write_commit_graph(opts.obj_dir,
     + 				    pack_indexes,
     + 				    commit_hex,
     +-				    flags, 0);
     ++				    flags, opts.version);
     + 
     + 	UNLEAK(lines);
     + 	return result;
      
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
 5:  09362bda1b ! 5:  cca8267dfe commit-graph: implement file format version 2
     @@ -23,14 +23,8 @@
          non-zero.
      
          Update the 'git commit-graph read' subcommand to display the new
     -    data.
     -
     -    Set the default file format version to 2, and adjust the tests to
     -    expect the new 'git commit-graph read' output.
     -
     -    Add explicit tests for the upgrade path from version 1 to 2. Users
     -    with an existing commit-graph with version 1 will seamlessly
     -    upgrade to version 2 on their next write.
     +    data, and check this output in the test that explicitly writes a
     +    v2 commit-graph file.
      
          While we converted the existing 'verify' tests to use a version 1
          file to avoid recalculating data offsets, add explicit 'verify'
     @@ -103,17 +97,6 @@
       	printf("num_commits: %u\n", graph->num_commits);
       	printf("chunks:");
       
     -@@
     - 	case 1:
     - 		flags |= COMMIT_GRAPH_VERSION_1;
     - 		break;
     -+
     -+	case 2:
     -+		flags |= COMMIT_GRAPH_VERSION_2;
     -+		break;
     - 	}
     - 
     - 	read_replace_refs = 0;
      
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
     @@ -170,14 +153,9 @@
       	graph->hash_len = the_hash_algo->rawsz;
      @@
       
     - 	if (flags & COMMIT_GRAPH_VERSION_1)
     - 		version = 1;
     -+	if (flags & COMMIT_GRAPH_VERSION_2)
     -+		version = 2;
       	if (!version)
     --		version = 1;
     + 		version = 1;
      -	if (version != 1) {
     -+		version = 2;
      +	if (version <= 0 || version > 2) {
       		error(_("unsupported commit-graph version %d"),
       		      version);
     @@ -198,18 +176,6 @@
       
       	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
      
     - diff --git a/commit-graph.h b/commit-graph.h
     - --- a/commit-graph.h
     - +++ b/commit-graph.h
     -@@
     - #define COMMIT_GRAPH_APPEND     (1 << 0)
     - #define COMMIT_GRAPH_PROGRESS   (1 << 1)
     - #define COMMIT_GRAPH_VERSION_1  (1 << 2)
     -+#define COMMIT_GRAPH_VERSION_2  (1 << 3)
     - 
     - int write_commit_graph_reachable(const char *obj_dir, int flags);
     - int write_commit_graph(const char *obj_dir,
     -
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
       +++ b/t/t5318-commit-graph.sh
     @@ -238,37 +204,37 @@
       	OPTIONAL=""
       	NUM_CHUNKS=3
       	if test ! -z $2
     -@@
     - 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
     - 	fi
     - 	cat >expect <<- EOF
     --	header: 43475048 1 1 $NUM_CHUNKS 0
     -+	header: 43475048 2 $NUM_CHUNKS 1 0
     -+	hash algorithm: 73686131
     - 	num_commits: $1
     - 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
     - 	EOF
      @@
       	)
       '
       
     -+test_expect_success 'write v1 graph' '
     -+	git commit-graph write --reachable --version=1 &&
     -+	git commit-graph verify
     -+'
     -+
     -+graph_git_behavior 'version 1 graph, commit 8 vs merge 2' full commits/8 merge/2
     -+graph_git_behavior 'version 1 graph, commit 8 vs merge 2' full commits/8 merge/2
     ++graph_read_expect_v2 () {
     ++	OPTIONAL=""
     ++	NUM_CHUNKS=3
     ++	if test ! -z $2
     ++	then
     ++		OPTIONAL=" $2"
     ++		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
     ++	fi	
     ++	cat >expect <<- EOF
     ++	header: 43475048 2 $NUM_CHUNKS 1 0
     ++	hash algorithm: 73686131
     ++	num_commits: $1
     ++	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
     ++	EOF
     ++	git commit-graph read >output &&
     ++	test_cmp expect output
     ++}
      +
     -+test_expect_success 'upgrade from v1 to v2' '
     -+	git checkout -b new-commit-for-upgrade &&
     -+	test_commit force-upgrade &&
     ++test_expect_success 'write v2 graph' '
     ++	cd "$TRASH_DIRECTORY/full" &&
      +	git commit-graph write --reachable --version=2 &&
     ++	graph_read_expect_v2 11 extra_edges &&
      +	git commit-graph verify
      +'
      +
     -+graph_git_behavior 'upgraded graph, commit 8 vs merge 2' full commits/8 merge/2
     -+graph_git_behavior 'upgraded graph, commit 8 vs merge 2' full commits/8 merge/2
     ++graph_git_behavior 'version 2 graph, commit 8 vs merge 2' full commits/8 merge/2
     ++graph_git_behavior 'version 2 graph, commit 8 vs merge 2' full commits/8 merge/2
      +
       # the verify tests below expect the commit-graph to contain
       # exactly the commits reachable from the commits/8 branch.
 -:  ---------- > 6:  e72bca6c78 commit-graph: remove Future Work section

-- 
gitgitgadget
