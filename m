Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44EDE1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436844AbeKWAHz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:07:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44647 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436840AbeKWAHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:07:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so4976772wrt.11
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wr6mJYdMLg3v1G8cQvNiyW5r2PJEbhXMst8+d2UH2HA=;
        b=fz+juDPr6hLXpNNQU+m9p+0yKQmiTvMRKAnozaLfgRIDdGT5IgCwIL/1a5pZ8Swn+y
         zfJ5GUwxcg5WamPkOh/aD5XX4NdPX7zVdfkTsdekex6+PQs9LBUhQzAqpyO5j3BroGd2
         3C9uzPN81V8Nzei0Z0CD2ufRw9Jlv4c9Q+HN2hVZsZPG2TQcUGRMwEpKXpBKP+tWAyvf
         7MG48DzCthIPPaj4umZleeX1TT4oJdg90L5phQwFTRq1HjXNFNsenhIAy0nCnD7p0/a3
         WIJ1E3J3/eJqmxxOZRyFQG2iNZSEqNNa7AREd7rNleN7h2b6rTGnVSdxu5g3UkK1lFI5
         JS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wr6mJYdMLg3v1G8cQvNiyW5r2PJEbhXMst8+d2UH2HA=;
        b=XssCEEk369wKCHsD7/BjYHe593j7RkI4knKJMEiqTzbBw8riVLGL4sfFNqGTYs6VtZ
         qfesHEOgmscb/EVDUwuz3GDP7c+DecBLddlOK/BZe1S/LeKLbhTjIPTqUDTmNJHrpWiK
         PuW24FVdLPUNy0a4Md4TKDMnr3T5JrmWuzcXW8kpbxXK96dEzmq/mVJFjBckFvLL2Wcb
         3tx54pcnwpIVIDYnGavPzNTxxedHcd6Z8utJqdFq3X7vunfJzIUGOUqysEc/mcr1y/tM
         huX1E6tjOiZ+7XMdMI2TCx2UHDawHfIUuadmHiVygG0qR6vAv3INhvFIFw8x7ZaurpdG
         fa+w==
X-Gm-Message-State: AA+aEWZ+NaIJ8+ZcpawT3QfsWCwJynRwz+VwfXy78wVwQzNk997PMs13
        62ad4Zl+h/8Ws+9G2bGAF0s7zwF4
X-Google-Smtp-Source: AFSGD/UE5/66iW8hp5ErJ15/sBx4d7C1cPeax/FY5ZTU0f+OHHH+4fu5CNWK0R05rH8thiRcrYfJFA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr3936145wru.222.1542893311597;
        Thu, 22 Nov 2018 05:28:31 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:30 -0800 (PST)
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
Subject: [PATCH v3 00/10] commit-graph write: progress output improvements
Date:   Thu, 22 Nov 2018 13:28:13 +0000
Message-Id: <20181122132823.9883-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
References: <20181121012600.26951-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This incorporates SZEDER's recent two-part series, rebases mine on
top, and fixes a few things while I'm at it. Now there's no progress
output where we don't show a completion percentage.

SZEDER Gábor (2):
  commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
  commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

Ævar Arnfjörð Bjarmason (8):
  commit-graph write: rephrase confusing progress output
  commit-graph write: add "Writing out" progress output
  commit-graph write: more descriptive "writing out" output
  commit-graph write: show progress for object search
  commit-graph write: add more descriptive progress output
  commit-graph write: remove empty line for readability
  commit-graph write: add itermediate progress
  commit-graph write: emit a percentage for all progress

 commit-graph.c | 130 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 28 deletions(-)

Range-diff:

By the way, is there any way to....

 [.. snipped lots of irrelevant commits...]
 -:  ---------- > 14:  07d06c50c0 commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
 -:  ---------- > 15:  904dda1e7a commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

Pass the equivalent of "git range-diff origin/master topic-2 topic-3"
to git-format-patch?

 1:  9f7fb459bd = 16:  1126c7e29d commit-graph write: rephrase confusing progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
 2:  093c63e99f ! 17:  2b52ad2284 commit-graph write: add more progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -1,9 +1,10 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    commit-graph write: add more progress output
    +    commit-graph write: add "Writing out" progress output
     
    -    Add more progress output to the output already added in
    -    7b0f229222 ("commit-graph write: add progress output", 2018-09-17).
    +    Add progress output to be shown when we're writing out the
    +    commit-graph, this adds to the output already added in 7b0f229222
    +    ("commit-graph write: add progress output", 2018-09-17).
     
         As noted in that commit most of the progress output isn't displayed on
         small repositories, but before this change we'd noticeably hang for
    @@ -13,30 +14,13 @@
         point at which we're not producing progress output:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 6365492, done.
    +        Finding commits for commit graph: 6365442, done.
             Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph: 2399912, done.
    +        Writing out commit graph: 100% (3986110/3986110), done.
     
    -    This "writing out" number is not meant to be meaningful to the user,
    -    but just to show that we're doing work and the command isn't
    -    hanging.
    -
    -    In the current implementation it's approximately 4x the number of
    -    commits. As noted in on-list discussion[1] we could add the loops up
    -    and show percentage progress here, but I don't think it's worth it. It
    -    would make the implementation more complex and harder to maintain for
    -    very little gain.
    -
    -    On a much larger in-house repository I have we'll show (note how we
    -    also say "Annotating[...]"):
    -
    -        $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph: 50026015, done.
    -        Annotating commit graph: 21567407, done.
    -        Computing commit graph generation numbers: 100% (7144680/7144680), done.
    -        Writing out commit graph: 21434417, done.
    -
    -    1. https://public-inbox.org/git/20181120165800.GB30222@szeder.dev/
    +    This "Writing out" number is 4x or 5x the number of commits, depending
    +    on the graph we're processing. A later change will make this explicit
    +    to the user.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -55,13 +39,13 @@
      	int i, count = 0;
      	struct commit **list = commits;
     @@
    - 	 */
    - 	for (i = 0; i < 256; i++) {
      		while (count < nr_commits) {
    -+			display_progress(progress, ++*progress_cnt);
      			if ((*list)->object.oid.hash[0] != i)
      				break;
    ++			display_progress(progress, ++*progress_cnt);
      			count++;
    + 			list++;
    + 		}
     @@
      }
      
    @@ -112,15 +96,17 @@
      	struct commit **list = commits;
      	struct commit **last = commits + nr_commits;
     @@
    - 						  commits,
    - 						  nr_commits,
    - 						  commit_to_sha1);
    -+			display_progress(progress, ++*progress_cnt);
      
    - 			if (edge_value < 0)
    - 				edge_value = GRAPH_PARENT_MISSING;
    + 	while (list < last) {
    + 		int num_parents = 0;
    ++
    ++		display_progress(progress, ++*progress_cnt);
    ++
    + 		for (parent = (*list)->parents; num_parents < 3 && parent;
    + 		     parent = parent->next)
    + 			num_parents++;
     @@
    - 	int num_extra_edges;
    + 	int num_large_edges;
      	struct commit_list *parent;
      	struct progress *progress = NULL;
     +	uint64_t progress_cnt = 0;
    @@ -134,19 +120,25 @@
     -	write_graph_chunk_fanout(f, commits.list, commits.nr);
     -	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
     -	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
    --	write_graph_chunk_large_edges(f, commits.list, commits.nr);
    -+	if (report_progress)
    ++	if (report_progress) {
    ++		/*
    ++		 * Each of the write_graph_chunk_*() functions just
    ++		 * below loops over our N commits. This number must be
    ++		 * kept in sync with the number of passes we're doing.
    ++		 */
    ++		int graph_passes = 4;
    ++		if (num_large_edges)
    ++			graph_passes++;
     +		progress = start_delayed_progress(
     +			_("Writing out commit graph"),
    -+			0);
    -+	write_graph_chunk_fanout(f, commits.list, commits.nr, progress,
    -+				 &progress_cnt);
    -+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr,
    -+			       progress, &progress_cnt);
    -+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr,
    -+			       progress, &progress_cnt);
    -+	write_graph_chunk_large_edges(f, commits.list, commits.nr, progress,
    -+				      &progress_cnt);
    ++			graph_passes * commits.nr);
    ++	}
    ++	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
    ++	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
    ++	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
    + 	if (num_large_edges)
    +-		write_graph_chunk_large_edges(f, commits.list, commits.nr);
    ++		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
     +	stop_progress(&progress);
      
      	close_commit_graph(the_repository);
 -:  ---------- > 18:  b1773677b1 commit-graph write: more descriptive "writing out" output
 3:  6c71de9460 ! 19:  3138b00a2c commit-graph write: show progress for object search
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -37,9 +37,9 @@
      --- a/commit-graph.c
      +++ b/commit-graph.c
     @@
    - 	struct commit_list *parent;
      	struct progress *progress = NULL;
      	uint64_t progress_cnt = 0;
    + 	struct strbuf progress_title = STRBUF_INIT;
     +	unsigned long approx_nr_objects;
      
      	if (!commit_graph_compatible(the_repository))
 4:  c665dbdacb ! 20:  f41e3b3eb3 commit-graph write: add more describing progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -1,6 +1,6 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    commit-graph write: add more describing progress output
    +    commit-graph write: add more descriptive progress output
     
         Make the progress output shown when we're searching for commits to
         include in the graph more descriptive. This amends code I added in
    @@ -36,14 +36,6 @@
      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
      +++ b/commit-graph.c
    -@@
    - 	struct progress *progress = NULL;
    - 	uint64_t progress_cnt = 0;
    - 	unsigned long approx_nr_objects;
    -+	struct strbuf progress_title = STRBUF_INIT;
    - 
    - 	if (!commit_graph_compatible(the_repository))
    - 		return;
     @@
      		strbuf_addf(&packname, "%s/pack/", obj_dir);
      		dirlen = packname.len;
    @@ -99,12 +91,3 @@
      				approx_nr_objects);
      		for_each_packed_object(add_packed_commits, &oids, 0);
      		if (oids.progress_done < approx_nr_objects)
    -@@
    - 				      &progress_cnt);
    - 	stop_progress(&progress);
    - 
    -+	strbuf_release(&progress_title);
    -+
    - 	close_commit_graph(the_repository);
    - 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
    - 	commit_lock_file(&lk);
 5:  f70fc5045d = 21:  74037032d3 commit-graph write: remove empty line for readability
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
 6:  2e943fa925 ! 22:  502da68d14 commit-graph write: add even more progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -1,11 +1,13 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    commit-graph write: add even more progress output
    +    commit-graph write: add itermediate progress
     
    -    Add more progress output to sections of code that can collectively
    -    take 5-10 seconds on a large enough repository. On a test repository
    -    with I have with ~7 million commits and ~50 million objects we'll now
    -    emit:
    +    Add progress output to sections of code between "Annotating[...]" and
    +    "Computing[...]generation numbers". This can collectively take 5-10
    +    seconds on a large enough repository.
    +
    +    On a test repository with I have with ~7 million commits and ~50
    +    million objects we'll now emit:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
             Finding commits for commit graph among packed objects: 100% (50026015/50026015), done.
    @@ -57,7 +59,7 @@
     @@
      	ALLOC_ARRAY(commits.list, commits.alloc);
      
    - 	num_extra_edges = 0;
    + 	num_large_edges = 0;
     +	if (report_progress)
     +		progress = start_delayed_progress(
     +			_("Finding extra edges in commit graph"),
    @@ -71,7 +73,7 @@
     @@
      		commits.nr++;
      	}
    - 	num_chunks = num_extra_edges ? 4 : 3;
    + 	num_chunks = num_large_edges ? 4 : 3;
     +	stop_progress(&progress);
      
      	if (commits.nr >= GRAPH_PARENT_MISSING)
 -:  ---------- > 23:  dfaf840983 commit-graph write: emit a percentage for all progress
-- 
2.20.0.rc0.387.gc7a69e6b6c

