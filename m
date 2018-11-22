Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871E11F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437791AbeKWCTg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33694 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437785AbeKWCTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so4053403wrr.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MsPsI8bHqBNYFMY/FR3ifeWBR4iK6UnAFxDMi3VsCfU=;
        b=qpGcJOtepDuy35zXvoFtjLPYrTqdvJV7Rm3L5ozqmc7OnBRGtnqqcnluG+4sCWA9W4
         KN9K49q8WbG2sN7tHnpQsiY/XHjF8rjePbwlj3NOtLpwsBQ+B3hH1H0TvIimIbIr6xs1
         5IJ7smZy2JWMV6zwrrvo5VWnxiuVjrk2P7Dib43P2KXTT1rFcq9WfS1Sx4fc3wA0JSKd
         L8f5EjJFdn9/Z4bj0C8zd65b+jM9NFm+7rfVZVY8wFPkYFd/NNZ99Xdp63+o4B481Tj5
         Xe+kLI+kLL54EqmmQ0dKkt842+3rZtb1sFX2UvI8NuaXnM+j6/K5SwQLjKXCBBMwovX+
         5JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsPsI8bHqBNYFMY/FR3ifeWBR4iK6UnAFxDMi3VsCfU=;
        b=k8QLAqPduUY6x32kD5QnySqsSP55NCFXVJ2/XRMowhCNpvMgQuTYvpI78Qrj3nWvDH
         UV4FLcxGxG+EKjCK/J0yuY0N3/LfFm8I7D0ha6ZWpSdJxegfj9waT7k3NWzjpGJIElIH
         CzhQtDK7SHJ3OGuRWaLXmmIVuPT+XiD4OU4GYs5RHUgT2IARywvBFSHZtSALDXk6DUa4
         rrY20xP7YWkVY/LfZU7obUSO2jmEassl8JlDSnJ4l/ivu+eWJUT/5E2vrMptKbTPIxgq
         gyXNBubhyp5IF8BCr9UxxyjSDHFfYLK11WeXkP8f97bxlYPaHqj74wvv1T2KgaIHdsUd
         bxZw==
X-Gm-Message-State: AA+aEWbq9R+CQJ3AWoH0FM9NXOMz9kOkP2TNK0JYE6zIHvKEf1y9D05P
        reNJ9sMisbjIigNzn8ihDfT27twmk8s=
X-Google-Smtp-Source: AFSGD/XjGI19Op3JlkTTbcIL5zUsiFJqjLCve083G9r5UjleI07uxF3wO3n7I4KE1sQ9DwZDVG1uJw==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr10830208wrp.92.1542901179984;
        Thu, 22 Nov 2018 07:39:39 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:39 -0800 (PST)
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
Subject: [PATCH v4 04/10] commit-graph write: add "Writing out" progress output
Date:   Thu, 22 Nov 2018 15:39:16 +0000
Message-Id: <20181122153922.16912-5-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
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
    Annotating commit graph: 2391666, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph: 100% (3188888/3188888), done.

This "Writing out" number is 3x or 4x the number of commits, depending
on the graph we're processing. A later change will make this explicit
to the user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d11370a2b3..dc57b8fedc 100644
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
2.20.0.rc0.387.gc7a69e6b6c

