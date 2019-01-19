Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5363E1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfASUVt (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33800 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfASUVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so3361320wmd.1
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30+zpf+826Gpa9hdpefbBJ/1ds1oDDMk6l4d3mD0IRk=;
        b=uqCCGB7AzbuPHVaH1jyIyof45sVOApsHRuoaPwcgLk2I1BAdnI+rzc0bO4KnQwc7qN
         V93xpkXDpIeQ1kEswKTv7oAv8CvSoCxtGoN+SmwFn0H5kvsJGdlOQt/mHQo0aNB0zAU5
         BFvCVYpcz1BlWkXZaCJLvO5ROZ7J7Xr3gPjekLbXo0GfPP7u3Nl/N2MHhAPschtnMKP8
         5EVcbAiiQnczqv4aUctuCrWhv9KdXpW/hCWD0L7xN4BASeztuAT3tbd5s248BZe4xL8n
         JrBKTqVHPKlB+3pYmGub0z/15HF5Ns+u2gg8SWqg+zNPT5Vw7Bp/A2otk+vOvLQnG2co
         Jjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30+zpf+826Gpa9hdpefbBJ/1ds1oDDMk6l4d3mD0IRk=;
        b=gbfJqZckBmW2hH/NT0n+dkdt0fGleLx+Utc5H0htrXQlJ8V6oJN0SjRWvQKaa+uxAV
         Y5C8XUM46pOIPCs0oFETONY5z9JNRS919htMMqNANqGpx4rOcI7LjKhZ4XXeN1glRlxD
         ZQbHFWJ47adqAHjknPz318Be04p8Kq4VmxU3yz247nms3dLu58/200OfhxTxUsMYrYIM
         qApflwQIwwc6wByixKhvBlc1np2jVRDDyyHPGsV/uYwNQd6KqqMmLM0nUQNj/iEF3kd7
         dSPQzIfsldW5V/awA15Ir7JF7ri5285WO4c1OdI1AigqgwOTC9RsptsV8Y4VFTAmtCGf
         tuUw==
X-Gm-Message-State: AJcUukc/lV8FUedUbdL9HYBSpyZ422TGYP4zGPm/oIoTKY8K5oFUVmg3
        kjWilRJ81jnQ2KqsAWqHRVCmaKKPLBc=
X-Google-Smtp-Source: ALg8bN7YjWoHe4n7+sB1yzQ3YO8wELtSGmvJKtzqUZ4lT5JHbjfkQwR2mksqJJcvvXEEvc8ozSX27w==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr19231728wmh.46.1547929305609;
        Sat, 19 Jan 2019 12:21:45 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:45 -0800 (PST)
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
Subject: [PATCH v6 04/10] commit-graph write: add "Writing out" progress output
Date:   Sat, 19 Jan 2019 21:21:15 +0100
Message-Id: <20190119202121.3590-5-avarab@gmail.com>
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

Add progress output to be shown when we're writing out the
commit-graph, this adds to the output already added in 7b0f229222
("commit-graph write: add progress output", 2018-09-17).

As noted in that commit most of the progress output isn't displayed on
small repositories, but before this change we'd noticeably hang for
2-3 seconds at the end on medium sized repositories such as linux.git.

Now we'll instead show output like this, and reduce the
human-observable times at which we're not producing progress output:

    $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/2015-04-03-1M-git commit-graph write
    Finding commits for commit graph: 13064614, done.
    Expanding reachable commits in commit graph: 1000447, done.
    Computing commit graph generation numbers: 100% (1000447/1000447), done.
    Writing out commit graph: 100% (3001341/3001341), done.

This "Writing out" number is 3x or 4x the number of commits, depending
on the graph we're processing. A later change will make this explicit
to the user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e733ba180a..a407d5bff4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -430,7 +430,9 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
-				     int nr_commits)
+				     int nr_commits,
+				     struct progress *progress,
+				     uint64_t *progress_cnt)
 {
 	int i, count = 0;
 	struct commit **list = commits;
@@ -444,6 +446,7 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 		while (count < nr_commits) {
 			if ((*list)->object.oid.hash[0] != i)
 				break;
+			display_progress(progress, ++*progress_cnt);
 			count++;
 			list++;
 		}
@@ -453,12 +456,16 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 }
 
 static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
-				   struct commit **commits, int nr_commits)
+				   struct commit **commits, int nr_commits,
+				   struct progress *progress,
+				   uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	int count;
-	for (count = 0; count < nr_commits; count++, list++)
+	for (count = 0; count < nr_commits; count++, list++) {
+		display_progress(progress, ++*progress_cnt);
 		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+	}
 }
 
 static const unsigned char *commit_to_sha1(size_t index, void *table)
@@ -468,7 +475,9 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 }
 
 static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct commit **commits, int nr_commits)
+				   struct commit **commits, int nr_commits,
+				   struct progress *progress,
+				   uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -478,6 +487,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		struct commit_list *parent;
 		int edge_value;
 		uint32_t packedDate[2];
+		display_progress(progress, ++*progress_cnt);
 
 		parse_commit(*list);
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
@@ -539,7 +549,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 static void write_graph_chunk_extra_edges(struct hashfile *f,
 					  struct commit **commits,
-					  int nr_commits)
+					  int nr_commits,
+					  struct progress *progress,
+					  uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -547,6 +559,9 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 
 	while (list < last) {
 		int num_parents = 0;
+
+		display_progress(progress, ++*progress_cnt);
+
 		for (parent = (*list)->parents; num_parents < 3 && parent;
 		     parent = parent->next)
 			num_parents++;
@@ -768,6 +783,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_extra_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
+	uint64_t progress_cnt = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -943,11 +959,16 @@ void write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	write_graph_chunk_fanout(f, commits.list, commits.nr);
-	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Writing out commit graph"),
+			num_chunks * commits.nr);
+	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
 	if (num_extra_edges)
-		write_graph_chunk_extra_edges(f, commits.list, commits.nr);
+		write_graph_chunk_extra_edges(f, commits.list, commits.nr, progress, &progress_cnt);
+	stop_progress(&progress);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.153.gd81d796ee0

