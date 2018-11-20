Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADFC1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeKUGVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54175 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeKUGVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so67001wmi.3
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGe4mOB8QOEXA7LyBopPmkkIkbTMRdkwIEWvtatKrQc=;
        b=dR/waV4ApDmIT1MwePXeNHWeYA1P5gB4eFjCH5Puc7Asnyx7juix0SK6IaYuL/zxqm
         vLTvIcPgQbWt+/goXAbpxiMFufHvPtxo/cn4qwcQoSqNWJvnttKX44wIGlAm/qB6+IpG
         DGK4e1cm7qg2HGBmGOmwE8osf29Oh9RJZAYPl3NXgQIpv2gV5LB7rZYFdzWUYeWgJ2hk
         qqcHDnLEGQOQYJ7mOGVmBmIfn52cQF47ILAJvuUF4FJ4L8ACmLSzPJOlKKXIvsIVOo0G
         xg1bv5+PA4/Bn5yzQC7vqNTt1crB7PHWyywQb++TTdWKf4DpQkKGFx6zXBCthQOTS0rO
         ynuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGe4mOB8QOEXA7LyBopPmkkIkbTMRdkwIEWvtatKrQc=;
        b=DoXxD8Q7IoD3m/Ybhe34qSNml31NmpT/vIkrYxZa6A7SpMITccuOl/8IFNXbH5J4Ni
         V3VximYtkOn+Rkwv2m9vjRzRKqV8vxncmW3GJVGYjIW0sAK2IHCk+N7DTrbkF8hDAV2h
         rknwro6/xdGhGGuctxqGbKIf/GEsz0iLjzKlSRi2RT+TnctqN9nrzzuDhgQ610dGPSfG
         L1xF7ak3SF6Plm7Y+5L6WaiQnQBy5hAdpAI3E229y/9tauN++7k/xKrC09xfnJPaAWnK
         h7BL4+6SXlbfyyaWXWThVHXUSKWMY6itw1kG2cewReObOA5Jzu6vk761K6+tF46hwLO6
         6Ukg==
X-Gm-Message-State: AGRZ1gIg3nHHz9U6ExmeKXxp6PheMEi7Bz0k2CKpfwVSqplWhmUOVFbM
        hZInmtOf6FFe+r+luGG4iv0dAaq8l80=
X-Google-Smtp-Source: AJdET5eBH8INu+mmVUuO/GsXk8zxGuOj0MdDx02PYJo+UPzBU4hlo87X51cEs4t+VrSM5XD8OgpWZQ==
X-Received: by 2002:a1c:81d3:: with SMTP id c202mr3053561wmd.133.1542743440494;
        Tue, 20 Nov 2018 11:50:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:39 -0800 (PST)
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
Subject: [PATCH v2 2/6] commit-graph write: add more progress output
Date:   Tue, 20 Nov 2018 19:50:23 +0000
Message-Id: <20181120195027.3260-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more progress output to the output already added in
7b0f229222 ("commit-graph write: add progress output", 2018-09-17).

As noted in that commit most of the progress output isn't displayed on
small repositories, but before this change we'd noticeably hang for
2-3 seconds at the end on medium sized repositories such as linux.git.

Now we'll instead show output like this, and have no human-observable
point at which we're not producing progress output:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph: 6365492, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph: 2399912, done.

This "writing out" number is not meant to be meaningful to the user,
but just to show that we're doing work and the command isn't
hanging.

In the current implementation it's approximately 4x the number of
commits. As noted in on-list discussion[1] we could add the loops up
and show percentage progress here, but I don't think it's worth it. It
would make the implementation more complex and harder to maintain for
very little gain.

On a much larger in-house repository I have we'll show (note how we
also say "Annotating[...]"):

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph: 50026015, done.
    Annotating commit graph: 21567407, done.
    Computing commit graph generation numbers: 100% (7144680/7144680), done.
    Writing out commit graph: 21434417, done.

1. https://public-inbox.org/git/20181120165800.GB30222@szeder.dev/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e6d0d7722b..6f6409b292 100644
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
@@ -445,6 +447,7 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 	 */
 	for (i = 0; i < 256; i++) {
 		while (count < nr_commits) {
+			display_progress(progress, ++*progress_cnt);
 			if ((*list)->object.oid.hash[0] != i)
 				break;
 			count++;
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
@@ -565,6 +577,7 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 						  commits,
 						  nr_commits,
 						  commit_to_sha1);
+			display_progress(progress, ++*progress_cnt);
 
 			if (edge_value < 0)
 				edge_value = GRAPH_PARENT_MISSING;
@@ -764,6 +777,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_extra_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
+	uint64_t progress_cnt = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -937,10 +951,19 @@ void write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	write_graph_chunk_fanout(f, commits.list, commits.nr);
-	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Writing out commit graph"),
+			0);
+	write_graph_chunk_fanout(f, commits.list, commits.nr, progress,
+				 &progress_cnt);
+	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr,
+			       progress, &progress_cnt);
+	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr,
+			       progress, &progress_cnt);
+	write_graph_chunk_large_edges(f, commits.list, commits.nr, progress,
+				      &progress_cnt);
+	stop_progress(&progress);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.0.rc0.387.gc7a69e6b6c

