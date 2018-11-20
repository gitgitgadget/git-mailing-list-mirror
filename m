Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2251F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeKUBed (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKUBed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so2311738wrr.12
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RBjbS9UWyBG7EL+W1rQzpOPsz3LTYjLwKIl9Nh6EVI=;
        b=erLmhyWpvCQnH4a8bZYwocQaNzHi/W5imoRf218PTmex9K8kvYzO3RoSj6NrudY4VK
         POzDB2/5/rWn1iwdkSyBzg7+SfAbVt0GMFPHc9AwpKPpxck8ZdCdeiqtuQQx9VCjFc/n
         T6Mg2vbR6iO7huK2R0ivHqzV+Ah2PgFsVYmTCKweqxf55IFBmvV42W6H8DgRkggcLzAt
         kCmHmZJb9eJ064AmsNHIC2/ZUrSyuRYv2veTvllesZfj0iAXtm2lPV3qPvc+smPerha5
         KewBysYMrQS6GbyNv7zl527MX4teZy9JlETzIZWSXf9tnJnXLniuy/4Tu21wa1zD/RvX
         MXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RBjbS9UWyBG7EL+W1rQzpOPsz3LTYjLwKIl9Nh6EVI=;
        b=cqtQIAwRXneYIAT1NXR+wHvzE3oslqW044oM03DnpHKEu+c6LJ22FByKFcd99L20jr
         oqZoQQ3yo/KBA+yFMiE7vBJsHHGiqNklHd2RyRlz3V0BSgfCBzoAncyTh5i7Wwf02CDg
         WZfAj1ahOZOOaD9X0PVR7vmvtj1IG8VT7BR8fY+9WrbzN5j+2Nywr98HdUp3vzEX/moX
         JTIQBieJFcSJqxop7QKhpTDUmwxy4LRmhjA0RfBbsH3tmzyGMO6YHGqJRo4Peg7NhBEn
         b+ccMu8Oichr6W1tgVoAdCyG1puVpJnjjah7MDT+3q5aO7gw2/ZkUj027ouGycuuIktc
         Zf5A==
X-Gm-Message-State: AA+aEWa6p3c+4THazdGvYFQROtWebb7UVgRu0ocTWNU4GCmeOUWG02z8
        Lq6k6IClUbS8teaD774Yk/y/FoJouUU=
X-Google-Smtp-Source: AFSGD/WECGpXBJUTZTEFHs8+/G79czTSSvoWMFMWKvyeBADYCCIUG8OwMQFixbRu9eMFE/kX5SaRCw==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr2273806wrg.183.1542726296258;
        Tue, 20 Nov 2018 07:04:56 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:04:55 -0800 (PST)
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
Subject: [PATCH 2/6] commit-graph write: add more progress output
Date:   Tue, 20 Nov 2018 15:04:39 +0000
Message-Id: <20181120150443.12997-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181119225720.GV30222@szeder.dev>
References: <20181119225720.GV30222@szeder.dev>
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
    Finding commits for commit graph: 6418991, done.
    Computing commit graph generation numbers: 100% (797205/797205), done.
    Writing out commit graph chunks: 2399861, done.

This "graph chunks" number is not meant to be meaningful to the user,
but just to show that we're doing work and the command isn't
hanging.

On a much larger in-house repository I have we'll show (note how we
also say "Annotating[...]"):

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph: 48271163, done.
    Annotating commit graph: 21424536, done.
    Computing commit graph generation numbers: 100% (7141512/7141512), done.
    Writing out commit graph chunks: 21424913, done.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e6d0d7722b..afce20dd4d 100644
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
@@ -445,6 +447,8 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 	 */
 	for (i = 0; i < 256; i++) {
 		while (count < nr_commits) {
+			if (progress)
+				display_progress(progress, ++*progress_cnt);
 			if ((*list)->object.oid.hash[0] != i)
 				break;
 			count++;
@@ -456,12 +460,17 @@ static void write_graph_chunk_fanout(struct hashfile *f,
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
+		if (progress)
+			display_progress(progress, ++*progress_cnt);
 		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+	}
 }
 
 static const unsigned char *commit_to_sha1(size_t index, void *table)
@@ -471,7 +480,9 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 }
 
 static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct commit **commits, int nr_commits)
+				   struct commit **commits, int nr_commits,
+				   struct progress *progress,
+				   uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -482,6 +493,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		int edge_value;
 		uint32_t packedDate[2];
 
+		if (progress)
+			display_progress(progress, ++*progress_cnt);
+
 		parse_commit(*list);
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
 
@@ -542,7 +556,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 static void write_graph_chunk_large_edges(struct hashfile *f,
 					  struct commit **commits,
-					  int nr_commits)
+					  int nr_commits,
+					  struct progress *progress,
+					  uint64_t *progress_cnt)
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
@@ -566,6 +582,9 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 						  nr_commits,
 						  commit_to_sha1);
 
+			if (progress)
+				display_progress(progress, ++*progress_cnt);
+
 			if (edge_value < 0)
 				edge_value = GRAPH_PARENT_MISSING;
 			else if (!parent->next)
@@ -764,6 +783,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_extra_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
+	uint64_t progress_cnt;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -937,10 +957,19 @@ void write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	write_graph_chunk_fanout(f, commits.list, commits.nr);
-	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Writing out commit graph chunks"),
+			progress_cnt = 0);
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

