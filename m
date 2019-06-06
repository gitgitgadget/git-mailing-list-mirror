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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADE61F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFFOPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46156 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFFOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id h10so3519947edi.13
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/93N5xrF5R91o4Ab8n4KGWDAtV8HmhMIsk/J5lJfAKI=;
        b=c2w58/Bcmd6sJXJgETxZuN0dzyc4hHNsmDx0umOli0+1curFZsHP7pu2CU/0/gQ+Wr
         mo9clEx3lRR8xM2jAcRJb9NrqnyvFt1NpljF5xQGaXgB21oGbTlczQnQcJSy17+NER/7
         YDb+GslQgZki3yIyIS7UdVh8VB3pI26QRbaen3s01iSZz1n2d0FbDjZsjgngggpKKFl5
         +3rPNIVh4MlLanFnlP4EGz63G3IAAsP+JjRjINXuWIot45g7ImHmLQyf+EGvf7J011Tq
         TOn29Vl5kjPKn4UfTzNAqnu3pfqxGLcT8s/GX41SoafggOEoZA5U5hWILbRo7fp3Ps5W
         VJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/93N5xrF5R91o4Ab8n4KGWDAtV8HmhMIsk/J5lJfAKI=;
        b=H8CNHE8ksrketpBW1+Dciw9mCAOxdJJIr5emHzCd9skDZqjMmPkYqWMAxfqvw0xZnZ
         JtoKgoqHKLRrPC3sYcn5TH5Z6qLsCaCLdGunEtVgrZ09dEvGWSqXfmQkeTGvmUp+Fz2V
         2ApKfsztpABZ/G4f1AKKP3qb9HscccSqZMtGRuJZ1r75ouEO9hT9ZIRxCPaYmsLGnuRR
         aJgWJwEpLh/2KGOXDqxQzNtaroqlS+V/6gbRFbKquES5WvQRAHjEoP9mxST7vQI9qZt5
         /9Rb6yg+UOHInUB5FUPRZJ67A5q+2nY6WrH/OQ/UYOzhHvL2ppBmjwxMWL37acuVymN8
         BhGg==
X-Gm-Message-State: APjAAAVTnphZuQwFue2oCGQHFF7HMCxCv94uqU3eR+YBd8wKH51KIXR+
        9U5dMNPfJoE5jP7H3Et1UUVjQl38
X-Google-Smtp-Source: APXvYqws/lHml3Yg473cvXHztB51Gjzopqf1ZW0Voow8UsX2HvwHBfF5nK46fgOzdIf/sS10ThlSOw==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr42351182ejb.217.1559830529265;
        Thu, 06 Jun 2019 07:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k21sm351703ejk.86.2019.06.06.07.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:28 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:28 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:13 GMT
Message-Id: <pull.184.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/14] Commit-graph: Write incremental files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>
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
   
   

Updates in V4:

Johannes pointed out some test failures on the Windows platform. We found
that the tests were not running on Windows in the gitgitgadget PR builds,
which is now resolved.

 * We need to close commit-graphs recursively down the chain. This prevented
   an unlink() from working because of an open handle.
   
   
 * Creating the alternates file used a path-specification that didn't work
   on Windows.
   
   
 * Renaming a file to the same name failed, but is probably related to the
   unlink() error mentioned above.
   
   

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
 commit-graph.c                                | 794 +++++++++++++++++-
 commit-graph.h                                |  25 +-
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5323-split-commit-graph.sh                 | 240 ++++++
 10 files changed, 1283 insertions(+), 68 deletions(-)
 create mode 100755 t/t5323-split-commit-graph.sh


base-commit: 8520d7fc7c6edd4d71582c69a873436029b6cb1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-184%2Fderrickstolee%2Fgraph%2Fincremental-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-184/derrickstolee/graph/incremental-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/184

Range-diff vs v3:

  1:  b184919255 =  1:  b184919255 commit-graph: document commit-graph chains
  2:  d0dc154a27 =  2:  d0dc154a27 commit-graph: prepare for commit-graph chains
  3:  f35b04224a =  3:  f35b04224a commit-graph: rename commit_compare to oid_compare
  4:  ca670536df =  4:  ca670536df commit-graph: load commit-graph chains
  5:  df44cbc1bf =  5:  df44cbc1bf commit-graph: add base graphs chunk
  6:  e65f9e841d =  6:  e65f9e841d commit-graph: rearrange chunk count logic
  7:  fe0aa343cd =  7:  fe0aa343cd commit-graph: write commit-graph chains
  8:  4f4ccc8062 !  8:  c42e683ef6 commit-graph: add --split option to builtin
     @@ -12,6 +12,7 @@
          Add a new test script (t5323-split-commit-graph.sh) that demonstrates this
          behavior.
      
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
     @@ -65,6 +66,32 @@
       	read_replace_refs = 0;
       
      
     + diff --git a/commit-graph.c b/commit-graph.c
     + --- a/commit-graph.c
     + +++ b/commit-graph.c
     +@@
     + 		}
     + 
     + 		if (ctx->base_graph_name) {
     +-			result = rename(ctx->base_graph_name,
     +-					ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
     ++			const char *dest = ctx->commit_graph_filenames_after[
     ++						ctx->num_commit_graphs_after - 2];
     + 
     +-			if (result) {
     +-				error(_("failed to rename base commit-graph file"));
     +-				return -1;
     ++			if (strcmp(ctx->base_graph_name, dest)) {
     ++				result = rename(ctx->base_graph_name, dest);
     ++
     ++				if (result) {
     ++					error(_("failed to rename base commit-graph file"));
     ++					return -1;
     ++				}
     + 			}
     + 		} else {
     + 			char *graph_name = get_commit_graph_filename(ctx->obj_dir);
     +
       diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
       new file mode 100755
       --- /dev/null
  9:  87fb895fe4 =  9:  d065758454 commit-graph: merge commit-graph chains
 10:  5cfd653d24 ! 10:  62b3fca582 commit-graph: allow cross-alternate chains
     @@ -195,7 +195,7 @@
      +	(
      +		cd fork &&
      +		rm .git/objects/info/commit-graph &&
     -+		echo "$TRASH_DIRECTORY/.git/objects" >.git/objects/info/alternates &&
     ++		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
      +		test_commit new-commit &&
      +		git commit-graph write --reachable --split &&
      +		test_path_is_file $graphdir/commit-graph-chain &&
     @@ -217,7 +217,7 @@
      +		cd fork &&
      +		git config core.commitGraph true &&
      +		rm -rf $graphdir &&
     -+		echo "$TRASH_DIRECTORY/.git/objects" >.git/objects/info/alternates &&
     ++		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
      +		test_commit 13 &&
      +		git branch commits/13 &&
      +		git commit-graph write --reachable --split &&
 11:  18d612be9e ! 11:  b5aeeed909 commit-graph: expire commit-graph files
     @@ -45,6 +45,26 @@
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
     +@@
     + 	return !!first_generation;
     + }
     + 
     ++static void close_commit_graph_one(struct commit_graph *g)
     ++{
     ++	if (!g)
     ++		return;
     ++
     ++	close_commit_graph_one(g->base_graph);
     ++	free_commit_graph(g);
     ++}
     ++
     + void close_commit_graph(struct repository *r)
     + {
     +-	free_commit_graph(r->objects->commit_graph);
     ++	close_commit_graph_one(r->objects->commit_graph);
     + 	r->objects->commit_graph = NULL;
     + }
     + 
      @@
       	deduplicate_commits(ctx);
       }
     @@ -109,7 +129,6 @@
      +
      +		if (!found)
      +			unlink(path.buf);
     -+
      +	}
      +}
      +
 12:  4de4bfba64 = 12:  ac5586a20f commit-graph: create options for split files
 13:  fe91ff5fca = 13:  548ec69d01 commit-graph: verify chains with --shallow mode
 14:  ca41bf08d0 = 14:  6084bbd164 commit-graph: clean up chains after flattened write

-- 
gitgitgadget
