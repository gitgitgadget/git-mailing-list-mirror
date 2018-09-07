Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2791F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIGXMX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:12:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35363 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIGXMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:12:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so15571864wmc.0
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SB6mz/h4X8j0bX8IG3yq+8KM4Jk5vQQgxzWqhS9jFt8=;
        b=YHVPm6NwIqnzRNYC3cOAU85kTk8W63HMTLnCiEAdcKJ3p8tXbgWFAHqQ1kZOJtLx2J
         7xgSNOnX3hP3ENGnUvXeJfP0z3hyafjSRb0zwtmjA2dtbTc5jRiivbQ79wnPjDVYRErj
         QuCnm4KErWJAa52bWpQYSY9vcvAbL7pXfYwA/GMaMkmNn22XUs0Zz2It9F7Fw61LH4C8
         3GbDR7tpszn5H3gQuaAYL6a+Tiv7Vh83MixaAWMXO/kCt04sp+o41Y4MaeiH2rzT5WLJ
         gBTmb/b6FA0TxgS9Orx14PYmakWJF7WoKlXB7CKhgY/XyKTIw+CgJMZtKupTbC9ODRYX
         UcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SB6mz/h4X8j0bX8IG3yq+8KM4Jk5vQQgxzWqhS9jFt8=;
        b=Dk87lCWDSDls1BaYWAOt7Szoljt1oA+csQRd7BrUTUhM2Ko0s2QqiN7KXuOhb6MpYM
         z+G80FUcPJWk6aHNnpEKpFFYevnJ7CPXMORCKP7MBuIjjI1e1Crc0yXnNJhGgpKks8V1
         +hoy6kVzoL9NhUziMx1xhOhS+YGIBt58wXlXyOkUYztSh09WZ7e9/GWzfm9NmgP7sjwv
         b8X5+CvmBJkPEI27Dy19fcPuGHbdS4KgJrG4uUKxicFulF4stVhpCb1bC/jTrRkhnxwW
         XsNIBIQBpu5AkkBVEpt7ilqpiz2WBvqaoOEJjgyqk1b2L7SGQSOr5xSrZ/6zglx8Hw7t
         LBcQ==
X-Gm-Message-State: APzg51D3opFaFttWNxlDM1TFvxKE+nBPiXIwgjfJjZTcYc7B5BHyGgsk
        9D+tSFWTAcyB0rcXBVQbHSRyqvJX
X-Google-Smtp-Source: ANB0VdZ4fCJHoUC/v5SxdgQbjr+Pz5lXYqTYIpHaiWWG+lT174AmACFwHWA20PivRUAeqN6zzcW9DA==
X-Received: by 2002:a1c:780c:: with SMTP id t12-v6mr5878821wmc.133.1536345009673;
        Fri, 07 Sep 2018 11:30:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m68-v6sm15396550wmb.10.2018.09.07.11.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:30:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] commit-graph write: add progress output
Date:   Fri,  7 Sep 2018 18:29:53 +0000
Message-Id: <20180907182954.2413-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180904202729.13900-1-avarab@gmail.com>
References: <20180904202729.13900-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change the "commit-graph write" command didn't report any
progress. On my machine this command takes more than 10 seconds to
write the graph for linux.git, and around 1m30s on the
2015-04-03-1M-git.git[1] test repository (a test case for a large
monorepository).

Furthermore, since the gc.writeCommitGraph setting was added in
d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27),
there was no indication at all from a "git gc" run that anything was
different. This why one of the progress bars being added here uses
start_progress() instead of start_delayed_progress(), so that it's
guaranteed to be seen. E.g. on my tiny 867 commit dotfiles.git
repository:

    $ git -c gc.writeCommitGraph=true gc
    Enumerating objects: 2821, done.
    [...]
    Computing commit graph generation numbers: 100% (867/867), done.

On larger repositories, such as linux.git the delayed progress bar(s)
will kick in, and we'll show what's going on instead of, as was
previously happening, printing nothing while we write the graph:

    $ git -c gc.writeCommitGraph=true gc
    [...]
    Annotating commits in commit graph: 1565573, done.
    Computing commit graph generation numbers: 100% (782484/782484), done.

Note that here we don't show "Finding commits for commit graph", this
is because under "git gc" we seed the search with the commit
references in the repository, and that set is too small to show any
progress, but would e.g. on a smaller repo such as git.git with
--stdin-commits:

    $ git rev-list --all | git -c gc.writeCommitGraph=true write --stdin-commits
    Finding commits for commit graph: 100% (162576/162576), done.
    Computing commit graph generation numbers: 100% (162576/162576), done.

With --stdin-packs we don't show any estimation of how much is left to
do. This is because we might be processing more than one pack. We
could be less lazy here and show progress, either by detecting that
we're only processing one pack, or by first looping over the packs to
discover how many commits they have. I don't see the point in doing
that work. So instead we get (on 2015-04-03-1M-git.git):

    $ echo pack-<HASH>.idx | git -c gc.writeCommitGraph=true --exec-path=$PWD commit-graph write --stdin-packs
    Finding commits for commit graph: 13064614, done.
    Annotating commits in commit graph: 3001341, done.
    Computing commit graph generation numbers: 100% (1000447/1000447), done.

No GC mode uses --stdin-packs. It's what they use at Microsoft to
manually compute the generation numbers for their collection of large
packs which are never coalesced.

The reason we need a "report_progress" variable passed down from "git
gc" is so that we don't report this output when we're running in the
process "git gc --auto" detaches from the terminal.

Since we write the commit graph from the "git gc" process itself (as
opposed to what we do with say the "git repack" phase), we'd end up
writing the output to .git/gc.log and reporting it to the user next
time as part of the "The last gc run reported the following[...]"
error, see 329e6e8794 ("gc: save log from daemonized gc --auto and
print it next time", 2015-09-19).

So we must keep track of whether or not we're running in that
demonized mode, and if so print no progress.

See [2] and subsequent replies for a discussion of an approach not
taken in compute_generation_numbers(). I.e. we're saying "Computing
commit graph generation numbers", even though on an established
history we're mostly skipping over all the work we did in the
past. This is similar to the white lie we tell in the "Writing
objects" phase (not all are objects being written).

Always showing progress is considered more important than
accuracy. I.e. on a repository like 2015-04-03-1M-git.git we'd hang
for 6 seconds with no output on the second "git gc" if no changes were
made to any objects in the interim if we'd take the approach in [2].

1. https://github.com/avar/2015-04-03-1M-git

2. <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
   (https://public-inbox.org/git/c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c |  5 ++--
 builtin/gc.c           |  3 ++-
 commit-graph.c         | 60 ++++++++++++++++++++++++++++++++++++------
 commit-graph.h         |  5 ++--
 4 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0bf0c48657..bc0fa9ba52 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -151,7 +151,7 @@ static int graph_write(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 
 	if (opts.reachable) {
-		write_commit_graph_reachable(opts.obj_dir, opts.append);
+		write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
 		return 0;
 	}
 
@@ -171,7 +171,8 @@ static int graph_write(int argc, const char **argv)
 	write_commit_graph(opts.obj_dir,
 			   pack_indexes,
 			   commit_hex,
-			   opts.append);
+			   opts.append,
+			   1);
 
 	string_list_clear(&lines, 0);
 	return 0;
diff --git a/builtin/gc.c b/builtin/gc.c
index 57069442b0..06ddd3aea5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -646,7 +646,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 
 	if (gc_write_commit_graph)
-		write_commit_graph_reachable(get_object_directory(), 0);
+		write_commit_graph_reachable(get_object_directory(), 0,
+					     !daemonized);
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/commit-graph.c b/commit-graph.c
index 8a1bec7b8a..2c5d996194 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -13,6 +13,7 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "alloc.h"
+#include "progress.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -548,6 +549,8 @@ struct packed_oid_list {
 	struct object_id *list;
 	int nr;
 	int alloc;
+	struct progress *progress;
+	int progress_done;
 };
 
 static int add_packed_commits(const struct object_id *oid,
@@ -560,6 +563,9 @@ static int add_packed_commits(const struct object_id *oid,
 	off_t offset = nth_packed_object_offset(pack, pos);
 	struct object_info oi = OBJECT_INFO_INIT;
 
+	if (list->progress)
+		display_progress(list->progress, ++list->progress_done);
+
 	oi.typep = &type;
 	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
@@ -587,12 +593,18 @@ static void add_missing_parents(struct packed_oid_list *oids, struct commit *com
 	}
 }
 
-static void close_reachable(struct packed_oid_list *oids)
+static void close_reachable(struct packed_oid_list *oids, int report_progress)
 {
 	int i;
 	struct commit *commit;
+	struct progress *progress = NULL;
+	int j = 0;
 
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Annotating commits in commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
+		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
@@ -604,6 +616,7 @@ static void close_reachable(struct packed_oid_list *oids)
 	 * closure.
 	 */
 	for (i = 0; i < oids->nr; i++) {
+		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit && !parse_commit(commit))
@@ -611,19 +624,28 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 
 	for (i = 0; i < oids->nr; i++) {
+		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit)
 			commit->object.flags &= ~UNINTERESTING;
 	}
+	stop_progress(&progress);
 }
 
-static void compute_generation_numbers(struct packed_commit_list* commits)
+static void compute_generation_numbers(struct packed_commit_list* commits, 
+				       int report_progress)
 {
 	int i;
 	struct commit_list *list = NULL;
+	struct progress *progress = NULL;
 
+	if (report_progress)
+		progress = start_progress(
+			_("Computing commit graph generation numbers"),
+			commits->nr);
 	for (i = 0; i < commits->nr; i++) {
+		display_progress(progress, i + 1);
 		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
 		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
 			continue;
@@ -655,6 +677,7 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
 			}
 		}
 	}
+	stop_progress(&progress);
 }
 
 static int add_ref_to_list(const char *refname,
@@ -667,19 +690,20 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-void write_commit_graph_reachable(const char *obj_dir, int append)
+void write_commit_graph_reachable(const char *obj_dir, int append,
+				  int report_progress)
 {
 	struct string_list list;
 
 	string_list_init(&list, 1);
 	for_each_ref(add_ref_to_list, &list);
-	write_commit_graph(obj_dir, NULL, &list, append);
+	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
 }
 
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
 			struct string_list *commit_hex,
-			int append)
+			int append, int report_progress)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -692,9 +716,12 @@ void write_commit_graph(const char *obj_dir,
 	int num_chunks;
 	int num_extra_edges;
 	struct commit_list *parent;
+	struct progress *progress = NULL;
 
 	oids.nr = 0;
 	oids.alloc = approximate_object_count() / 4;
+	oids.progress = NULL;
+	oids.progress_done = 0;
 
 	if (append) {
 		prepare_commit_graph_one(the_repository, obj_dir);
@@ -721,6 +748,11 @@ void write_commit_graph(const char *obj_dir,
 		int dirlen;
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen = packname.len;
+		if (report_progress) {
+			oids.progress = start_delayed_progress(
+				_("Finding commits for commit graph"), 0);
+			oids.progress_done = 0;
+		}
 		for (i = 0; i < pack_indexes->nr; i++) {
 			struct packed_git *p;
 			strbuf_setlen(&packname, dirlen);
@@ -733,15 +765,21 @@ void write_commit_graph(const char *obj_dir,
 			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
 			close_pack(p);
 		}
+		stop_progress(&oids.progress);
 		strbuf_release(&packname);
 	}
 
 	if (commit_hex) {
+		if (report_progress)
+			progress = start_delayed_progress(
+				_("Finding commits for commit graph"),
+				commit_hex->nr);
 		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
 			struct commit *result;
 
+			display_progress(progress, i + 1);
 			if (commit_hex->items[i].string &&
 			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
 				continue;
@@ -754,12 +792,18 @@ void write_commit_graph(const char *obj_dir,
 				oids.nr++;
 			}
 		}
+		stop_progress(&progress);
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commit_hex) {
+		if (report_progress)
+			oids.progress = start_delayed_progress(
+				_("Finding commits for commit graph"), 0);
 		for_each_packed_object(add_packed_commits, &oids, 0);
+		stop_progress(&oids.progress);
+	}
 
-	close_reachable(&oids);
+	close_reachable(&oids, report_progress);
 
 	QSORT(oids.list, oids.nr, commit_compare);
 
@@ -799,7 +843,7 @@ void write_commit_graph(const char *obj_dir,
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
 
-	compute_generation_numbers(&commits);
+	compute_generation_numbers(&commits, report_progress);
 
 	graph_name = get_commit_graph_filename(obj_dir);
 	if (safe_create_leading_directories(graph_name))
diff --git a/commit-graph.h b/commit-graph.h
index eea62f8c0e..f50712a973 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -52,11 +52,12 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
-void write_commit_graph_reachable(const char *obj_dir, int append);
+void write_commit_graph_reachable(const char *obj_dir, int append,
+				  int report_progress);
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
 			struct string_list *commit_hex,
-			int append);
+			int append, int report_progress);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
2.19.0.rc1.350.ge57e33dbd1

