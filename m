Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F641F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfASUVi (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36632 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfASUVh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so18990982wrp.3
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyEzrfLzAB7ky6/JYOwofgHxbjOnnL0nkUk5e5/RmMU=;
        b=V/U4GuEhfvblvDdw7dluB+HoVioTP+WsgjTJUYoDJjCj4WTWgkR9RqFgzLFagsl1C5
         Hv5av8aopH7laGeQ8f8D9JKMyQAs5jlcDYh0KiOlKQGuwrQ0DOeZ8zwbor6yFQi5J/fn
         zuY9pb01ItCqaNuAjhJk2PrTyR5iqGnp9hJATwC3G0+fCBR/38NYhzfsNomMDXC1isi5
         Tyn2qtV6j3+Q2v33gnwzNItmu2UdjGIcXYBEmgPpcXMS/1oYAxO3erMEA4LMWTjpmUb5
         PoA/rkZLc6QIL9p4Kcr3xZpTfUzvgdkIaoCmamMVPPXZK6PNiELL988YdE0zvi+YvI71
         e3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyEzrfLzAB7ky6/JYOwofgHxbjOnnL0nkUk5e5/RmMU=;
        b=rt7U7hBoqIpcLFzv5aTS21dMeqdfXoipHt5Sza93Gpd1IEjAZJn767LqI36qF79Jmr
         2Hn+gqbHamoC9tjN2GRNGfNRvG7m/ujRu8Cu4P0A+TpZfhLveg91OQge5s/eMH5PnONW
         rDDU8l2pB2TAz8MVP8Jb/zXa6psdt1VfyGaBnVV2WPzDy35z3wHS7V3KxZ2y2WIHrYQH
         jnyNnZcYrqxy5abKyNppyLXifuCJFfCNg4AH5FKewAOm5gzHkh1J4UneSBXYwHViCQHU
         lycqDYMSiaE/3tktDcVPawBxzVkQEiJQpmtF3b+20asO8QG2NHQPVI7doAEcpfuNcjRe
         PFzw==
X-Gm-Message-State: AJcUukfV30HdWo2DL8q8V7aY5+Ro7Y0GsQDqLC3a+rEFJSt4dE221ol+
        dQzkkQIa3p5ADI1HrtoiyX+BUkJpJtw=
X-Google-Smtp-Source: ALg8bN60d4/s27S2qk1N6gIJ92fSWu4VduJ3MdhvRv5gvna1YNJSNzmgvMnEmBoMxvuuJEcAAqGfMQ==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr20953630wrx.248.1547929293693;
        Sat, 19 Jan 2019 12:21:33 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/10] commit-graph write: progress output improvements
Date:   Sat, 19 Jan 2019 21:21:11 +0100
Message-Id: <20190119202121.3590-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190116132947.26025-1-avarab@gmail.com>
References: <20190116132947.26025-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improvements since v6:

 * Integrate my "commit-graph write: use pack order when finding
   commits" patch, and per Junio's suggestion put it at the start so
   it's easier to split the two apart.

 * A signed-off-by of mine was missing on that patch. Fixed.

 * Replace SZEDER's two patches with his re-roll at
   https://public-inbox.org/git/20190118170549.30403-1-szeder.dev@gmail.com/
   for convenienc, since mine needed rebasing on top of his.

 * SZEDER rightly pointed out that I was doing some work for nothing
   in https://public-inbox.org/git/20190118171605.GM840@szeder.dev/;
   fixed.

SZEDER Gábor (2):
  commit-graph: rename "large edges" to "extra edges"
  commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

Ævar Arnfjörð Bjarmason (8):
  commit-graph write: use pack order when finding commits
  commit-graph write: add "Writing out" progress output
  commit-graph write: more descriptive "writing out" output
  commit-graph write: show progress for object search
  commit-graph write: add more descriptive progress output
  commit-graph write: remove empty line for readability
  commit-graph write: add itermediate progress
  commit-graph write: emit a percentage for all progress

 .../technical/commit-graph-format.txt         |   4 +-
 builtin/commit-graph.c                        |   4 +-
 commit-graph.c                                | 136 +++++++++++++-----
 commit-graph.h                                |   2 +-
 t/t5318-commit-graph.sh                       |  14 +-
 5 files changed, 110 insertions(+), 50 deletions(-)

Range-diff:
 1:  07d06c50c0 <  -:  ---------- commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
 -:  ---------- >  1:  9ca0b5573b commit-graph write: use pack order when finding commits
 -:  ---------- >  2:  4370ea7591 commit-graph: rename "large edges" to "extra edges"
 2:  904dda1e7a !  3:  3468e30c89 commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
    @@ -10,19 +10,19 @@
         there won't be a 'Large Edge List' chunk written, only the three
         mandatory chunks.
     
    -    However, when it comes to writing chunk data, write_commit_graph()
    -    unconditionally invokes write_graph_chunk_large_edges(), even when it
    -    was decided earlier that that chunk won't be written.  Strictly
    -    speaking there is no bug here, because write_graph_chunk_large_edges()
    -    won't write anything because it won't find any commits with more than
    -    two parents, but then it unnecessarily and in vain looks through all
    -    commits once again in search for such commits.
    +    However, when it later comes to writing actual chunk data,
    +    write_commit_graph() unconditionally invokes
    +    write_graph_chunk_large_edges(), even when it was decided earlier that
    +    that chunk won't be written.  Strictly speaking there is no bug here,
    +    because write_graph_chunk_large_edges() won't write anything if it
    +    doesn't find any commits with more than two parents, but then it
    +    unnecessarily and in vain looks through all commits once again in
    +    search for such commits.
     
         Don't call write_graph_chunk_large_edges() when that chunk won't be
         written to spare an unnecessary iteration over all commits.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
    @@ -31,9 +31,9 @@
      	write_graph_chunk_fanout(f, commits.list, commits.nr);
      	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
      	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
    --	write_graph_chunk_large_edges(f, commits.list, commits.nr);
    -+	if (num_large_edges)
    -+		write_graph_chunk_large_edges(f, commits.list, commits.nr);
    +-	write_graph_chunk_extra_edges(f, commits.list, commits.nr);
    ++	if (num_extra_edges)
    ++		write_graph_chunk_extra_edges(f, commits.list, commits.nr);
      
      	close_commit_graph(the_repository);
      	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 3:  1126c7e29d <  -:  ---------- commit-graph write: rephrase confusing progress output
 4:  9c17f56ed3 !  4:  1860fa606e commit-graph write: add "Writing out" progress output
    @@ -10,14 +10,14 @@
         small repositories, but before this change we'd noticeably hang for
         2-3 seconds at the end on medium sized repositories such as linux.git.
     
    -    Now we'll instead show output like this, and have no human-observable
    -    point at which we're not producing progress output:
    +    Now we'll instead show output like this, and reduce the
    +    human-observable times at which we're not producing progress output:
     
    -        $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 6365442, done.
    -        Annotating commit graph: 2391666, done.
    -        Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph: 100% (3188888/3188888), done.
    +        $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/2015-04-03-1M-git commit-graph write
    +        Finding commits for commit graph: 13064614, done.
    +        Expanding reachable commits in commit graph: 1000447, done.
    +        Computing commit graph generation numbers: 100% (1000447/1000447), done.
    +        Writing out commit graph: 100% (3001341/3001341), done.
     
         This "Writing out" number is 3x or 4x the number of commits, depending
         on the graph we're processing. A later change will make this explicit
    @@ -87,7 +87,7 @@
      		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
     @@
      
    - static void write_graph_chunk_large_edges(struct hashfile *f,
    + static void write_graph_chunk_extra_edges(struct hashfile *f,
      					  struct commit **commits,
     -					  int nr_commits)
     +					  int nr_commits,
    @@ -107,7 +107,7 @@
      		     parent = parent->next)
      			num_parents++;
     @@
    - 	int num_large_edges;
    + 	int num_extra_edges;
      	struct commit_list *parent;
      	struct progress *progress = NULL;
     +	uint64_t progress_cnt = 0;
    @@ -121,25 +121,16 @@
     -	write_graph_chunk_fanout(f, commits.list, commits.nr);
     -	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
     -	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
    -+	if (report_progress) {
    -+		/*
    -+		 * Each of the write_graph_chunk_*() functions just
    -+		 * below loops over our N commits. This number must be
    -+		 * kept in sync with the number of passes we're doing.
    -+		 */
    -+		int graph_passes = 3;
    -+		if (num_large_edges)
    -+			graph_passes++;
    ++	if (report_progress)
     +		progress = start_delayed_progress(
     +			_("Writing out commit graph"),
    -+			graph_passes * commits.nr);
    -+	}
    ++			num_chunks * commits.nr);
     +	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
     +	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
     +	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
    - 	if (num_large_edges)
    --		write_graph_chunk_large_edges(f, commits.list, commits.nr);
    -+		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
    + 	if (num_extra_edges)
    +-		write_graph_chunk_extra_edges(f, commits.list, commits.nr);
    ++		write_graph_chunk_extra_edges(f, commits.list, commits.nr, progress, &progress_cnt);
     +	stop_progress(&progress);
      
      	close_commit_graph(the_repository);
 5:  79b0a467d9 !  5:  cc36909add commit-graph write: more descriptive "writing out" output
    @@ -11,11 +11,11 @@
         has to do with writing out the commit graph. Now e.g. on linux.git we
         emit:
     
    -        $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 6365442, done.
    -        Annotating commit graph: 2391666, done.
    -        Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
    +        $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/linux commit-graph write
    +        Finding commits for commit graph: 6529159, done.
    +        Expanding reachable commits in commit graph: 815990, done.
    +        Computing commit graph generation numbers: 100% (815983/815983), done.
    +        Writing out commit graph in 4 passes: 100% (3263932/3263932), done.
     
         A note on i18n: Why are we using the Q_() function and passing a
         number & English text for a singular which'll never be used? Because
    @@ -36,26 +36,28 @@
      	if (!commit_graph_compatible(the_repository))
      		return;
     @@
    - 		int graph_passes = 3;
    - 		if (num_large_edges)
    - 			graph_passes++;
    + 		hashwrite(f, chunk_write, 12);
    + 	}
    + 
    +-	if (report_progress)
    ++	if (report_progress) {
     +		strbuf_addf(&progress_title,
     +			    Q_("Writing out commit graph in %d pass",
     +			       "Writing out commit graph in %d passes",
    -+			       graph_passes),
    -+			    graph_passes);
    ++			       num_chunks),
    ++			    num_chunks);
      		progress = start_delayed_progress(
     -			_("Writing out commit graph"),
     +			progress_title.buf,
    - 			graph_passes * commits.nr);
    - 	}
    + 			num_chunks * commits.nr);
    ++	}
      	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
    -@@
    - 		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
    + 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
    + 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
    + 	if (num_extra_edges)
    + 		write_graph_chunk_extra_edges(f, commits.list, commits.nr, progress, &progress_cnt);
      	stop_progress(&progress);
    - 
     +	strbuf_release(&progress_title);
    -+
    + 
      	close_commit_graph(the_repository);
      	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
    - 	commit_lock_file(&lk);
 6:  b32be83b38 !  6:  9a4aec16ca commit-graph write: show progress for object search
    @@ -8,12 +8,12 @@
     
         Before we'd emit on e.g. linux.git with "commit-graph write":
     
    -        Finding commits for commit graph: 6365442, done.
    +        Finding commits for commit graph: 6529159, done.
             [...]
     
         And now:
     
    -        Finding commits for commit graph: 100% (6365442/6365442), done.
    +        Finding commits for commit graph: 100% (6529159/6529159), done.
             [...]
     
         Since the commit graph only includes those commits that are packed
    @@ -59,7 +59,8 @@
     -				_("Finding commits for commit graph"), 0);
     +				_("Finding commits for commit graph"),
     +				approx_nr_objects);
    - 		for_each_packed_object(add_packed_commits, &oids, 0);
    + 		for_each_packed_object(add_packed_commits, &oids,
    + 				       FOR_EACH_OBJECT_PACK_ORDER);
     +		if (oids.progress_done < approx_nr_objects)
     +			display_progress(oids.progress, approx_nr_objects);
      		stop_progress(&oids.progress);
 7:  54276723c0 !  7:  6b523d0f0d commit-graph write: add more descriptive progress output
    @@ -10,17 +10,17 @@
         we support:
     
             $ git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    +        Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
             [...]
     
             # Actually we don't emit this since this takes almost no time at
             # all. But if we did (s/_delayed//) we'd show:
             $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    -        Finding commits for commit graph from 584 refs: 100% (584/584), done.
    +        Finding commits for commit graph from 630 refs: 100% (630/630), done.
             [...]
     
             $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    -        Finding commits for commit graph in 2 packs: 6365442, done.
    +        Finding commits for commit graph in 3 packs: 6529159, done.
             [...]
     
         The middle on of those is going to be the output users might see in
    @@ -89,5 +89,5 @@
     -				_("Finding commits for commit graph"),
     +				_("Finding commits for commit graph among packed objects"),
      				approx_nr_objects);
    - 		for_each_packed_object(add_packed_commits, &oids, 0);
    - 		if (oids.progress_done < approx_nr_objects)
    + 		for_each_packed_object(add_packed_commits, &oids,
    + 				       FOR_EACH_OBJECT_PACK_ORDER);
 8:  0e847366e1 =  8:  582f6f477f commit-graph write: remove empty line for readability
 9:  c388aff73e !  9:  2c9fa68210 commit-graph write: add itermediate progress
    @@ -10,26 +10,29 @@
         million objects we'll now emit:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (48333911/48333911), done.
    -        Annotating commit graph: 21435984, done.
    -        Counting distinct commits in commit graph: 100% (7145328/7145328), done.
    -        Finding extra edges in commit graph: 100% (7145328/7145328), done.
    -        Computing commit graph generation numbers: 100% (7145328/7145328), done.
    -        Writing out commit graph in 4 passes: 100% (28581312/28581312), done.
    +        Finding commits for commit graph among packed objects: 100% (124763727/124763727), done.
    +        Loading known commits in commit graph: 100% (18989461/18989461), done.
    +        Expanding reachable commits in commit graph: 100% (18989507/18989461), done.
    +        Clearing commit marks in commit graph: 100% (18989507/18989507), done.
    +        Counting distinct commits in commit graph: 100% (18989507/18989507), done.
    +        Finding extra edges in commit graph: 100% (18989507/18989507), done.
    +        Computing commit graph generation numbers: 100% (7250302/7250302), done.
    +        Writing out commit graph in 4 passes: 100% (29001208/29001208), done.
     
         Whereas on a medium-sized repository such as linux.git these new
         progress bars won't have time to kick in and as before and we'll still
         emit output like:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    -        Annotating commit graph: 2391666, done.
    -        Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
    +        Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    +        Expanding reachable commits in commit graph: 815990, done.
    +        Computing commit graph generation numbers: 100% (815983/815983), done.
    +        Writing out commit graph in 4 passes: 100% (3263932/3263932), done.
     
         The "Counting distinct commits in commit graph" phase will spend most
         of its time paused at "0/*" as we QSORT(...) the list. That's not
    -    optimal, but at least we don't seem to be stalling anymore.
    +    optimal, but at least we don't seem to be stalling anymore most of the
    +    time.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -59,7 +62,7 @@
     @@
      	ALLOC_ARRAY(commits.list, commits.alloc);
      
    - 	num_large_edges = 0;
    + 	num_extra_edges = 0;
     +	if (report_progress)
     +		progress = start_delayed_progress(
     +			_("Finding extra edges in commit graph"),
    @@ -73,7 +76,7 @@
     @@
      		commits.nr++;
      	}
    - 	num_chunks = num_large_edges ? 4 : 3;
    + 	num_chunks = num_extra_edges ? 4 : 3;
     +	stop_progress(&progress);
      
      	if (commits.nr >= GRAPH_PARENT_MISSING)
10:  fd692499e0 <  -:  ---------- commit-graph write: emit a percentage for all progress
 -:  ---------- > 10:  e69bb1be2c commit-graph write: emit a percentage for all progress
-- 
2.20.1.153.gd81d796ee0

