Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821AA1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393168AbfAPNaN (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34028 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393163AbfAPNaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so1056292wmd.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2F8GwpdTG04fhJY3muUz/i65P/oT1SE+CLTsfyKjXic=;
        b=CrT4F5QgJCSVv62PA0WsSHUJAlOedHaBtWLNct895yMoCPs8pWtEPe56sDvrll14Uo
         jhMhy8ZTcmYGD/eo3E08PxFV0IkgyLCC8FOjWxkOu0Z3jZfu7s/PkS82knXzAfSUEag5
         eGNjSjj4VDy7tH5HfmlythUoRbc4cV+wctK0/mBoYAi2Q1iSTYJ4mGDSEooIWHrblnmK
         y23EGo+yP6n/n8U9j1hA3Fp6lRvIGrp0wGkwVvUFQeBksC7G8cg/Pi6/6JJpKJSGMFru
         HnTMffJ7S/6htO93KEovCDwOZLlq44idmvbu76DpM2sapVt6y6c3nUlptItPhF2pZeWB
         8Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2F8GwpdTG04fhJY3muUz/i65P/oT1SE+CLTsfyKjXic=;
        b=jhLAIiaiAf+rGH3BWf7KsnlknNKxjK9IAKU+PHFU3AmrZthjLGGnMi9WIyzDRfEaYx
         xbY0t2sTtPWrALxpAis0P1Pu/9KneuFqAy7bw4dyp41QDbho6Y72voCsuJFHG3a1WJgV
         fglT4wJ6NAlTbuZa+mPHFsPzImZlyyz8clULlbknho+bTlcS94LOC4rC10CL2nOuv13z
         1/flljouV+s2h0o0GNrtIiPzagia6n0klMqVp5xks4DZC4WovtXiwUqClphsvbsIwQaK
         caiYCMXf83gMrjJOa/W19bsSwU2HKfAT47Sk/5MbC9j412odGIHgHye7N3dkjEHmVbrT
         NBSQ==
X-Gm-Message-State: AJcUukf0lgJ+kVrQHOKbxQt10dw6iRmJ2NfhBxWGbS8eQRjA2O2VCZeD
        sK3gubTtfO+8O3ZsdXM57k2EQaov
X-Google-Smtp-Source: ALg8bN5EBz/tEkE/ZHhCZiKZuhqBRwZkZT/EzNKCIrHdDJRuBR7qslnk68ddNXS0Rs94VffLW771SQ==
X-Received: by 2002:a1c:5a42:: with SMTP id o63mr7494311wmb.88.1547645409328;
        Wed, 16 Jan 2019 05:30:09 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:08 -0800 (PST)
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
Subject: [PATCH v5 3/9] commit-graph write: add "Writing out" progress output
Date:   Wed, 16 Jan 2019 14:29:41 +0100
Message-Id: <20190116132947.26025-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
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
 commit-graph.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 38b62051c2..0c3af28399 100644
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
 
 static void write_graph_chunk_large_edges(struct hashfile *f,
 					  struct commit **commits,
-					  int nr_commits)
+					  int nr_commits,
+					  struct progress *progress,
+					  uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -547,6 +559,9 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 
 	while (list < last) {
 		int num_parents = 0;
+
+		display_progress(progress, ++*progress_cnt);
+
 		for (parent = (*list)->parents; num_parents < 3 && parent;
 		     parent = parent->next)
 			num_parents++;
@@ -768,6 +783,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_large_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
+	uint64_t progress_cnt = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -941,11 +957,25 @@ void write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	write_graph_chunk_fanout(f, commits.list, commits.nr);
-	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	if (report_progress) {
+		/*
+		 * Each of the write_graph_chunk_*() functions just
+		 * below loops over our N commits. This number must be
+		 * kept in sync with the number of passes we're doing.
+		 */
+		int graph_passes = 3;
+		if (num_large_edges)
+			graph_passes++;
+		progress = start_delayed_progress(
+			_("Writing out commit graph"),
+			graph_passes * commits.nr);
+	}
+	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
 	if (num_large_edges)
-		write_graph_chunk_large_edges(f, commits.list, commits.nr);
+		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
+	stop_progress(&progress);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.153.gd81d796ee0

