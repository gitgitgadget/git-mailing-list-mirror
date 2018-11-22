Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FFE1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436856AbeKWAIC (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41887 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436848AbeKWAIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so9268227wrs.8
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjkpyCsUjNvBRqoes+ia/qjH7R472yJVcTCQuHGIOzU=;
        b=fA8j38jIkdGp6FEvR0KfwZUElJslhMt0UtB0o4nX+BOb1V1Zf3ZnN7IjGLLmGoI5s8
         HXgLaOubz9xiszjBVcTXEE1YwcyaU3HJx+bs2v7LCHJ6P3cN6YmqmI5WlnV+AwOyqnvO
         lmi6W1S3fWOOhqIsgYt9ZtK7yofrMLBpWKomS5aHUvV5i6Kz84ARE3f9701Y2MoXDagy
         bLOVjs/mFm6NnlC12aNGD3xVzuWr+t92EAZODCwSdMVw4u1iWQXd1gqcRkwrmwAVZNkE
         VRYqFIk56Hj7MiuuYj9coA9h5d9R2TB2an/MDWmOxwH1zaKp9giNQszJt4oWnFh6rUGQ
         hHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjkpyCsUjNvBRqoes+ia/qjH7R472yJVcTCQuHGIOzU=;
        b=PPODvi9+GN1DUFL5slX2eSQgxyCoFnktzC77fNljB2VI+PlryXJVWUSmrhoKmOT0Cg
         r7Vv+HvzBEZ38Mt58P1p3baVm4gF1fOH/soc1hUBe/3KIwodXOwyh52+V5WV/fZwXrgm
         6tKBmPcs28Iwi7SvgAKDfA5QYcZHS2pFgG+UGkNX+F6gwWWE/eGWNiTZNOaH+m8Sfums
         GaLFsmUgF32SHyoyJbZF/L6yLeA46gE6QUZ6+VQ0IpXyOn34uj9NNH1DRa4sFBQ4nwzk
         T6zkS9GRVqxwXPZrF5F2z01zLlA+PrcOS7Q/VrKP8eY7zGzyilkwJ9hTu7gfZEGgXp8Q
         Z0GQ==
X-Gm-Message-State: AA+aEWa+GYvbb60OSCeq5wmNrFXjcGihrbNjMngw337TxJXKlIbDocKb
        fIWkow4ZplfPgDvttVGcxZtO9/f8
X-Google-Smtp-Source: AFSGD/Xx6HVweimmaKD8ue9hCT/EDi0y2p/2YUU0w7Gte9LBSMjwpxIafEIz9WviTKHYWBGohf6X1w==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr10158489wro.78.1542893318475;
        Thu, 22 Nov 2018 05:28:38 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:37 -0800 (PST)
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
Subject: [PATCH v3 04/10] commit-graph write: add "Writing out" progress output
Date:   Thu, 22 Nov 2018 13:28:17 +0000
Message-Id: <20181122132823.9883-5-avarab@gmail.com>
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

Add progress output to be shown when we're writing out the
commit-graph, this adds to the output already added in 7b0f229222
("commit-graph write: add progress output", 2018-09-17).

As noted in that commit most of the progress output isn't displayed on
small repositories, but before this change we'd noticeably hang for
2-3 seconds at the end on medium sized repositories such as linux.git.

Now we'll instead show output like this, and have no human-observable
point at which we're not producing progress output:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph: 6365442, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph: 100% (3986110/3986110), done.

This "Writing out" number is 4x or 5x the number of commits, depending
on the graph we're processing. A later change will make this explicit
to the user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d11370a2b3..e32a5cc1bc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -433,7 +433,9 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
-				     int nr_commits)
+				     int nr_commits,
+				     struct progress *progress,
+				     uint64_t *progress_cnt)
 {
 	int i, count = 0;
 	struct commit **list = commits;
@@ -447,6 +449,7 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 		while (count < nr_commits) {
 			if ((*list)->object.oid.hash[0] != i)
 				break;
+			display_progress(progress, ++*progress_cnt);
 			count++;
 			list++;
 		}
@@ -456,12 +459,16 @@ static void write_graph_chunk_fanout(struct hashfile *f,
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
@@ -471,7 +478,9 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 }
 
 static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct commit **commits, int nr_commits)
+				   struct commit **commits, int nr_commits,
+				   struct progress *progress,
+				   uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -481,6 +490,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		struct commit_list *parent;
 		int edge_value;
 		uint32_t packedDate[2];
+		display_progress(progress, ++*progress_cnt);
 
 		parse_commit(*list);
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
@@ -542,7 +552,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 static void write_graph_chunk_large_edges(struct hashfile *f,
 					  struct commit **commits,
-					  int nr_commits)
+					  int nr_commits,
+					  struct progress *progress,
+					  uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -550,6 +562,9 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 
 	while (list < last) {
 		int num_parents = 0;
+
+		display_progress(progress, ++*progress_cnt);
+
 		for (parent = (*list)->parents; num_parents < 3 && parent;
 		     parent = parent->next)
 			num_parents++;
@@ -764,6 +779,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_large_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
+	uint64_t progress_cnt = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -937,11 +953,25 @@ void write_commit_graph(const char *obj_dir,
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
+		int graph_passes = 4;
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
2.20.0.rc0.387.gc7a69e6b6c

