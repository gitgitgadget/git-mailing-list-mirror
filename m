Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AAF1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfFCQDw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:03:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50599 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfFCQDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so7797822wme.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uY9xfQR3h14lMjOEvt75tDOcww3d5KkmO3Vb8Ejl5II=;
        b=gim80pMqxRl+xypFVsGOfO+7VHnD9upIoeYuwX/yysziYScF9krPJYEQ2fUtxOjd/N
         tSt+oNZovVyrGGXCDyBU2QbHwQbdGjSznSykh85IetZT7UhgK/QXlKsQiud4dyJca3nn
         RUrEMLU1dcyZmEYqzB0VEM5Vb4YtjtIQx344SgxtlFcU9q0ZkQnW2RVNBwZoRmahXehf
         rhHR5MIA0aG3P3E2/DlMY61D5y49pnRfZ77RCunqCp2oq/mV5EJwoDSjONgaazq56Fk5
         ZFY/J3eAgVOGkzAG8ShgERlH/506FLec/yPnqXlo3VtZh+jz9PpPYTawJ4tNcOWDJSpj
         Un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uY9xfQR3h14lMjOEvt75tDOcww3d5KkmO3Vb8Ejl5II=;
        b=n5jO7hw6ALq+NtVM2wjyM9LPbK+IvH60u4TIdYF8RhK8RRF2Wt78HbuCpPVhR1MZjE
         3sXLrgOvawe64ejZOfJoAjwBHTvcIEn071zIOs/NsVu45/5pUTKVggHXDj8av/KdLMXp
         cuKfHYpxBSSrEd/WEXZxjehiMHIJVjMEGuzlzR9ltztv2hN/rB0gjpAl0va8yyLwPPVN
         5Mp37IrzJaiZAkm/I8rML8xSJeuzSMBiIyC0SwomQn8Nvt+wd/R448aeheHxK3rQryFT
         9CGluiXEoz/ffxROoiGdU2qHXcJ9hroKdVXkC/R4USb4P1VFSeAAI6GZPU7wQXrztrYb
         6/Kw==
X-Gm-Message-State: APjAAAVU+wodHlcmVevnbZn5gyY29eUGO8zAJwHWyY2cJLEnHPRPoDb6
        xHsOuONiM3qS/p1oBgRcvRgTc1+d
X-Google-Smtp-Source: APXvYqzv3ikA3Z4GxHFXhe5w3ZcpxYyf5fE2uW2zXFY13anNeTBNQFofdp5L/Uyjb0/peE1UqGQ8YQ==
X-Received: by 2002:a1c:3d41:: with SMTP id k62mr13655502wma.61.1559577828406;
        Mon, 03 Jun 2019 09:03:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm5867742wrp.57.2019.06.03.09.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:47 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:47 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:32 GMT
Message-Id: <pull.184.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/14] Commit-graph: Write incremental files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version is now ready for review.

The commit-graph is a valuable performance feature for repos with large
commit histories, but suffers from the same problem as git repack: it
rewrites the entire file every time. This can be slow when there are
millions of commits, especially after we stopped reading from the
commit-graph file during a write in 43d3561 (commit-graph write: don't die
if the existing graph is corrupt).

Instead, create a "chain" of commit-graphs in the
.git/objects/info/commit-graphs folder with name graph-{hash}.graph. The
list of hashes is given by the commit-graph-chain file, and also in a "base
graph chunk" in the commit-graph format. As we read a chain, we can verify
that the hashes match the trailing hash of each commit-graph we read along
the way and each hash below a level is expected by that graph file.

When writing, we don't always want to add a new level to the stack. This
would eventually result in performance degradation, especially when
searching for a commit (before we know its graph position). We decide to
merge levels of the stack when the new commits we will write satisfy two
conditions:

 1. The expected size of the new file is more than half the size of the tip
    of the stack.
 2. The new file contains more than 64,000 commits.

The first condition alone would prevent more than a logarithmic number of
levels. The second condition is a stop-gap to prevent performance issues
when another process starts reading the commit-graph stack as we are merging
a large stack of commit-graph files. The reading process could be in a state
where the new file is not ready, but the levels above the new file were
already deleted. Thus, the commits that were merged down must be parsed from
pack-files.

The performance is necessarily amortized across multiple writes, so I tested
by writing commit-graphs from the (non-rc) tags in the Linux repo. My test
included 72 tags, and wrote everything reachable from the tag using 
--stdin-commits. Here are the overall perf numbers:

write --stdin-commits:         8m 12s
write --stdin-commits --split:    28s
write --split && verify --shallow: 60s

Updates in V3:

 * git commit-graph verify now works on commit-graph chains. We do a simple
   test to check the behavior of a new --shallow option.
   
   
 * When someone writes a flat commit-graph, we now expire the old chain
   according to the expire time.
   
   
 * The "max commits" limit is no longer enabled by default, but instead is
   enabled by a --max-commits=<n> option. Ignored if n=0.
   
   

This is based on ds/commit-graph-write-refactor.

Thanks, -Stolee

[1] 
https://github.com/git/git/commit/43d356180556180b4ef6ac232a14498a5bb2b446
commit-graph write: don't die if the existing graph is corrupt

Derrick Stolee (14):
  commit-graph: document commit-graph chains
  commit-graph: prepare for commit-graph chains
  commit-graph: rename commit_compare to oid_compare
  commit-graph: load commit-graph chains
  commit-graph: add base graphs chunk
  commit-graph: rearrange chunk count logic
  commit-graph: write commit-graph chains
  commit-graph: add --split option to builtin
  commit-graph: merge commit-graph chains
  commit-graph: allow cross-alternate chains
  commit-graph: expire commit-graph files
  commit-graph: create options for split files
  commit-graph: verify chains with --shallow mode
  commit-graph: clean up chains after flattened write

 Documentation/git-commit-graph.txt            |  26 +-
 .../technical/commit-graph-format.txt         |  11 +-
 Documentation/technical/commit-graph.txt      | 195 +++++
 builtin/commit-graph.c                        |  53 +-
 builtin/commit.c                              |   2 +-
 builtin/gc.c                                  |   3 +-
 commit-graph.c                                | 780 +++++++++++++++++-
 commit-graph.h                                |  25 +-
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5323-split-commit-graph.sh                 | 240 ++++++
 10 files changed, 1270 insertions(+), 67 deletions(-)
 create mode 100755 t/t5323-split-commit-graph.sh


base-commit: 8520d7fc7c6edd4d71582c69a873436029b6cb1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-184%2Fderrickstolee%2Fgraph%2Fincremental-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-184/derrickstolee/graph/incremental-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/184

Range-diff vs v2:

  1:  a423afbfdd =  1:  b184919255 commit-graph: document commit-graph chains
  2:  249668fc92 =  2:  d0dc154a27 commit-graph: prepare for commit-graph chains
  3:  809fa7ad80 =  3:  f35b04224a commit-graph: rename commit_compare to oid_compare
  4:  a8c0b47c8a !  4:  ca670536df commit-graph: load commit-graph chains
     @@ -47,13 +47,13 @@
       	return load_commit_graph_one_fd_st(fd, &st);
       }
       
     -+static int prepare_commit_graph_v1(struct repository *r, const char *obj_dir)
     ++static struct commit_graph *load_commit_graph_v1(struct repository *r, const char *obj_dir)
      +{
      +	char *graph_name = get_commit_graph_filename(obj_dir);
     -+	r->objects->commit_graph = load_commit_graph_one(graph_name);
     ++	struct commit_graph *g = load_commit_graph_one(graph_name);
      +	free(graph_name);
      +
     -+	return r->objects->commit_graph ? 0 : -1;
     ++	return g;
      +}
      +
      +static int add_graph_to_chain(struct commit_graph *g,
     @@ -76,8 +76,9 @@
      +	return 1;
      +}
      +
     -+static void prepare_commit_graph_chain(struct repository *r, const char *obj_dir)
     ++static struct commit_graph *load_commit_graph_chain(struct repository *r, const char *obj_dir)
      +{
     ++	struct commit_graph *graph_chain = NULL;
      +	struct strbuf line = STRBUF_INIT;
      +	struct stat st;
      +	struct object_id *oids;
     @@ -85,17 +86,21 @@
      +	char *chain_name = get_chain_filename(obj_dir);
      +	FILE *fp;
      +
     -+	if (stat(chain_name, &st))
     -+		return;
     ++	if (stat(chain_name, &st)) {
     ++		free(chain_name);
     ++		return NULL;
     ++	}
      +
     -+	if (st.st_size <= the_hash_algo->hexsz)
     -+		return;
     ++	if (st.st_size <= the_hash_algo->hexsz) {
     ++		free(chain_name);
     ++		return NULL;
     ++	}
      +
      +	fp = fopen(chain_name, "r");
      +	free(chain_name);
      +
      +	if (!fp)
     -+		return;
     ++		return NULL;
      +
      +	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
      +
     @@ -114,14 +119,26 @@
      +		g = load_commit_graph_one(graph_name);
      +		free(graph_name);
      +
     -+		if (g && add_graph_to_chain(g, r->objects->commit_graph, oids, i))
     -+			r->objects->commit_graph = g;
     ++		if (g && add_graph_to_chain(g, graph_chain, oids, i))
     ++			graph_chain = g;
      +		else
      +			valid = 0;
      +	}
      +
      +	free(oids);
      +	fclose(fp);
     ++
     ++	return graph_chain;
     ++}
     ++
     ++static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
     ++{
     ++	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
     ++
     ++	if (!g)
     ++		g = load_commit_graph_chain(r, obj_dir);
     ++
     ++	return g;
      +}
      +
       static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
     @@ -134,11 +151,9 @@
      -	graph_name = get_commit_graph_filename(obj_dir);
      -	r->objects->commit_graph =
      -		load_commit_graph_one(graph_name);
     -+	if (!prepare_commit_graph_v1(r, obj_dir))
     -+		return;
     - 
     +-
      -	FREE_AND_NULL(graph_name);
     -+	prepare_commit_graph_chain(r, obj_dir);
     ++	r->objects->commit_graph = read_commit_graph_one(r, obj_dir);
       }
       
       /*
  5:  4fefd0a654 =  5:  df44cbc1bf commit-graph: add base graphs chunk
  6:  a595a1eb65 =  6:  e65f9e841d commit-graph: rearrange chunk count logic
  7:  9cbfb656b3 !  7:  fe0aa343cd commit-graph: write commit-graph chains
     @@ -51,7 +51,7 @@
      +	return g;
       }
       
     - static int prepare_commit_graph_v1(struct repository *r, const char *obj_dir)
     + static struct commit_graph *load_commit_graph_v1(struct repository *r, const char *obj_dir)
      @@
       	struct progress *progress;
       	int progress_done;
  8:  5ad14f574b !  8:  4f4ccc8062 commit-graph: add --split option to builtin
     @@ -104,7 +104,7 @@
      +	for i in $(test_seq 3)
      +	do
      +		test_commit $i &&
     -+		git branch commits/$i
     ++		git branch commits/$i || return 1
      +	done &&
      +	git commit-graph write --reachable &&
      +	test_path_is_file $infodir/commit-graph &&
     @@ -135,7 +135,7 @@
      +verify_chain_files_exist() {
      +	for hash in $(cat $1/commit-graph-chain)
      +	do
     -+		test_path_is_file $1/graph-$hash.graph
     ++		test_path_is_file $1/graph-$hash.graph || return 1
      +	done
      +}
      +
     @@ -144,13 +144,13 @@
      +	for i in $(test_seq 4 5)
      +	do
      +		test_commit $i &&
     -+		git branch commits/$i
     ++		git branch commits/$i || return 1
      +	done &&
      +	git reset --hard commits/2 &&
      +	for i in $(test_seq 6 10)
      +	do
      +		test_commit $i &&
     -+		git branch commits/$i
     ++		git branch commits/$i || return 1
      +	done &&
      +	git reset --hard commits/2 &&
      +	git merge commits/4 &&
  9:  9567daa0b8 !  9:  87fb895fe4 commit-graph: merge commit-graph chains
     @@ -105,8 +105,7 @@
      +  1. The expected file size for level N + 1 is at least half the file size for
      +     level N.
      +
     -+  2. Level N + 1 contains more than MAX_SPLIT_COMMITS commits (64,0000
     -+     commits).
     ++  2. Level N + 1 contains more than 64,0000 commits.
      +
      +This decision cascades down the levels: when we merge a level we create a new
      +set of commits that then compares to the next level.
     @@ -290,13 +289,7 @@
      +		current_graph_number--;
      +
      +		if (ctx->report_progress) {
     -+			if (current_graph_number)
     -+				strbuf_addf(&progress_title,
     -+					    _("Merging commit-graph-%d"),
     -+					    current_graph_number);
     -+			else
     -+				strbuf_addstr(&progress_title,
     -+					      _("Merging commit-graph"));
     ++			strbuf_addstr(&progress_title, _("Merging commit-graph"));
      +			ctx->progress = start_delayed_progress(progress_title.buf, 0);
      +		}
      +
 10:  4cfe19a933 ! 10:  5cfd653d24 commit-graph: allow cross-alternate chains
     @@ -81,13 +81,13 @@
       --- a/commit-graph.c
       +++ b/commit-graph.c
      @@
     - 	r->objects->commit_graph = load_commit_graph_one(graph_name);
     + 	struct commit_graph *g = load_commit_graph_one(graph_name);
       	free(graph_name);
       
     -+	if (r->objects->commit_graph)
     -+		r->objects->commit_graph->obj_dir = obj_dir;
     ++	if (g)
     ++		g->obj_dir = obj_dir;
      +
     - 	return r->objects->commit_graph ? 0 : -1;
     + 	return g;
       }
       
      @@
     @@ -111,8 +111,8 @@
      +			char *graph_name = get_split_graph_filename(odb->path, line.buf);
      +			struct commit_graph *g = load_commit_graph_one(graph_name);
       
     --		if (g && add_graph_to_chain(g, r->objects->commit_graph, oids, i))
     --			r->objects->commit_graph = g;
     +-		if (g && add_graph_to_chain(g, graph_chain, oids, i))
     +-			graph_chain = g;
      -		else
      -			valid = 0;
      +			free(graph_name);
     @@ -120,8 +120,8 @@
      +			if (g) {
      +				g->obj_dir = odb->path;
      +
     -+				if (add_graph_to_chain(g, r->objects->commit_graph, oids, i))
     -+					r->objects->commit_graph = g;
     ++				if (add_graph_to_chain(g, graph_chain, oids, i))
     ++					graph_chain = g;
      +				else
      +					valid = 0;
      +
 11:  72fc0a1f17 ! 11:  18d612be9e commit-graph: expire commit-graph files
     @@ -45,15 +45,6 @@
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
     -@@
     - 	unsigned append:1,
     - 		 report_progress:1,
     - 		 split:1;
     -+
     -+	time_t expire_window;
     - };
     - 
     - static void write_graph_chunk_fanout(struct hashfile *f,
      @@
       	deduplicate_commits(ctx);
       }
     @@ -81,7 +72,7 @@
      +	DIR *dir;
      +	struct dirent *de;
      +	size_t dirnamelen;
     -+	time_t expire_time = time(NULL) - ctx->expire_window;
     ++	time_t expire_time = time(NULL);
      +
      +	strbuf_addstr(&path, ctx->obj_dir);
      +	strbuf_addstr(&path, "/info/commit-graphs");
  -:  ---------- > 12:  4de4bfba64 commit-graph: create options for split files
  -:  ---------- > 13:  fe91ff5fca commit-graph: verify chains with --shallow mode
  -:  ---------- > 14:  ca41bf08d0 commit-graph: clean up chains after flattened write

-- 
gitgitgadget
