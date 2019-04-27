Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E731F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfD0M5y (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:57:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42465 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfD0M5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:57:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so5371877eda.9
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j7jW9vFrxebOw6LBpGm4dpt+vIwF6hXoqiEMXoBEklY=;
        b=H8FzUkUmBa/6eiGOARzQciukGx99o3WtQNbO5Bp0D+x8tBYERYXy3zPEuamqx13ap6
         TV75TR64H79PAb+VzZ8ImEp6Wm8nFQDk/9wYEl+0tLc20JI05dokukSBE4xHs2NHVvld
         YFSsWcIAPpt2m4EXxoRnYqqn469npxoJKy5U5lM0mT9t8AabQrFD7CdbSeESQLHQfkaA
         yGnM+VL89w/4BYpKoajvpuezb5UFAHw+Krv28B8wfpGcHAtbAIE5zL+NzrdMunBsS7nZ
         uuJX/7zqGiy1RUGVopaRb6u6bjuNKZ3f2QVDuqK7eyHxY0N8TsiZtWDzzdtkv0daHsGp
         IQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=j7jW9vFrxebOw6LBpGm4dpt+vIwF6hXoqiEMXoBEklY=;
        b=mmM3oTYoMCnTMheliirZBmXAFVPjeKmyWPtDyqpNoKYzBdYvOqF4Lm7a/u7kPUwF68
         87qBoulbn3tzJ9NdPZuAuuK0KSKlNYp/+eMBFY6OvQmYsJ2Xp/ODAxykFFhRs87SUIQb
         j/W+aHNvbwHaDJN96h3VBvoQbx3PH8rNshkCet5owj8UM8XUi5MX5r6KwZzW3+7wS5Iz
         Dv0r5dx5hDEwxZ2edjNL+VMYUrEYZ5oza3zZvZC6LvgRINW77aGBLU7SJKKmL35w+bHY
         pSZrneq8WDgpWPBjUVBwvD/GieCtBiKo+xx8q0WDQLIQWKC/p6q4tdPWsLmi9yMiIvqG
         qnmg==
X-Gm-Message-State: APjAAAU1pgJhPTTL2Pp671zL59M1leBmhtJ7NerELIOc3/Sj7qBL7NB2
        T5bcQIhW29xxGtyVY7aJJ5Q=
X-Google-Smtp-Source: APXvYqz92gmdeUDJ+BvfhC8mbFiDDdrXhgHPmjnhfZNAwFVmTl5roEAkyPJJL2FAH+B7Vq+mdWtAFA==
X-Received: by 2002:a50:b1d1:: with SMTP id n17mr5913640edd.131.1556369872116;
        Sat, 27 Apr 2019 05:57:52 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h60sm6882792edc.17.2019.04.27.05.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:57:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com> <pull.112.v2.git.gitgitgadget@gmail.com> <87a7gdspo4.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87a7gdspo4.fsf@evledraar.gmail.com>
Date:   Sat, 27 Apr 2019 14:57:50 +0200
Message-ID: <87zhobr4fl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 26 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> ...speaking of which, digging up outstanding stuff I have on the
> commit-graph I was reminded to finish up my "commit graph on clone"
> patch in:
> https://public-inbox.org/git/87in2hgzin.fsf@evledraar.gmail.com/
>
> And re #1 above: I guess we could also do that "let's make a graph" and
> call "gc --auto" if a) we have gc.writeCommitGraph b) we see it's not
> the "right" version. As long as older versions always write a "old" one
> if they can't grok the "new" one, and newer versions leave existing
> graphs alone even if they're older versions, so we don't flip-flop.
>
> One of the things that would make that "graph on clone/fetch/whatever"
> easier is having the graph store the total number of objects while it
> was at it, you indicated in
> https://public-inbox.org/git/934fa00e-f6df-c333-4968-3e9acffab22d@gmail.c=
om/
> that you already have an internal MSFT implementation of it that does
> it.
>
> Any reason not to make it part of v2 while we're at it? We already find
> out how many (packed) objects we have in "add_packed_commits", we just
> don't do anything with that information now.

I hacked up this plus general tag/tree/blob count stats in the WIP/RFC
patch below. I figured once I did objects I might as well do tags (note:
annotated tag objects, not # tag refs)/trees/blobs as well.

It passes all tests with GIT_TEST_COMMIT_GRAPH=3Dtrue, it fails on the
commit-graph's own test suite, but AFAICT only because the selective
corruption tests are thrown off by the location of this new chunk.

Since we now skip some commits found in the pack(s) (just duplicates?)
the new "num_commits_stat" is not the same as the current "num_commits",
but usually really close.

It's probably best if we do something like this to make this chunk be of
dynamic length, as long as we kept order we could keep adding new stats
to the file even within the same "version".

This as (ab)using the "commit-graph" to start storing arbitrary stats
about stuff we find the the packs during gc. Maybe that sucks, but OTOH
it's useful, and just having some new "last gc stats" format/file would
be overkill...

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 1485b4daaf..d9378f23d9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -114,7 +114,9 @@ static int graph_read(int argc, const char **argv)
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
-		*(unsigned char*)(graph->data + 5),
+		(getenv("STAT_ME")
+		 ? *(unsigned char*)(graph->data + 5)
+		 : (*(unsigned char*)(graph->data + 5) - 1)),
 		*(unsigned char*)(graph->data + 6),
 		*(unsigned char*)(graph->data + 7));

@@ -123,8 +125,20 @@ static int graph_read(int argc, const char **argv)
 		       get_be32(graph->data + 8));

 	printf("num_commits: %u\n", graph->num_commits);
+	if (getenv("STAT_ME")) {
+		printf(" pack num commits (st): %u\n", graph->num_commits_stat);
+		printf(" pack num commits - inferred diff (diff =3D duplicate (I think!)=
): %u\n", graph->num_commits_stat - graph->num_commits);
+		printf(" pack num objects: %u\n", graph->num_objects);
+		printf(" pack num tags: %u\n", graph->num_tags);
+		printf(" pack num trees: %u\n", graph->num_trees);
+		printf(" pack num blobs: %u\n", graph->num_blobs);
+	}
 	printf("chunks:");

+	if (getenv("STAT_ME")) {
+		if (graph->chunk_oid_numbers)
+			printf(" oid_numbers");
+	}
 	if (graph->chunk_oid_fanout)
 		printf(" oid_fanout");
 	if (graph->chunk_oid_lookup)
diff --git a/commit-graph.c b/commit-graph.c
index 14d6aebd99..3d0fb5193b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -18,6 +18,7 @@
 #include "progress.h"

 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
+#define GRAPH_CHUNKID_OIDNUMBERS 0x4f49444e  /* "OIDN" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
@@ -32,6 +33,7 @@
 #define GRAPH_LAST_EDGE 0x80000000

 #define GRAPH_HEADER_SIZE 8
+#define GRAPH_OIDNUMBERS_SIZE (4 * 5)
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
 #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
@@ -127,6 +129,10 @@ static int verify_commit_graph_lite(struct commit_grap=
h *g)
 	 * over g->num_commits, or runs a checksum on the commit-graph
 	 * itself.
 	 */
+	if (!g->chunk_oid_numbers) {
+		error("commit-graph is missing the OID Numbers chunk");
+		return 1;
+	}
 	if (!g->chunk_oid_fanout) {
 		error("commit-graph is missing the OID Fanout chunk");
 		return 1;
@@ -249,6 +255,18 @@ struct commit_graph *parse_commit_graph(void *graph_ma=
p, int fd,
 		}

 		switch (chunk_id) {
+		case GRAPH_CHUNKID_OIDNUMBERS:
+			if (graph->chunk_oid_numbers) {
+				chunk_repeated =3D 1;
+			} else {
+				graph->chunk_oid_numbers =3D data + chunk_offset;
+				graph->num_objects =3D get_be32(graph->chunk_oid_numbers + 0);
+				graph->num_commits_stat =3D get_be32(graph->chunk_oid_numbers + 4);
+				graph->num_tags    =3D get_be32(graph->chunk_oid_numbers + 8);
+				graph->num_trees   =3D get_be32(graph->chunk_oid_numbers + 12);
+				graph->num_blobs   =3D get_be32(graph->chunk_oid_numbers + 16);
+			}
+			break;
 		case GRAPH_CHUNKID_OIDFANOUT:
 			if (graph->chunk_oid_fanout)
 				chunk_repeated =3D 1;
@@ -545,6 +563,22 @@ struct tree *get_commit_tree_in_graph(struct repositor=
y *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }

+static void write_graph_chunk_numbers(struct hashfile *f,
+				      struct progress *progress,
+				      uint64_t *progress_cnt,
+				      uint32_t num_objects,
+				      uint32_t num_commits,
+				      uint32_t num_tags,
+				      uint32_t num_trees,
+				      uint32_t num_blobs)
+{
+	hashwrite_be32(f, num_objects);
+	hashwrite_be32(f, num_commits);
+	hashwrite_be32(f, num_tags);
+	hashwrite_be32(f, num_trees);
+	hashwrite_be32(f, num_blobs);
+}
+
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
 				     int nr_commits,
@@ -567,7 +601,6 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 			count++;
 			list++;
 		}
-
 		hashwrite_be32(f, count);
 	}
 }
@@ -732,6 +765,11 @@ struct packed_oid_list {
 	int alloc;
 	struct progress *progress;
 	int progress_done;
+	uint32_t num_objects;
+	uint32_t num_commits;
+	uint32_t num_tags;
+	uint32_t num_trees;
+	uint32_t num_blobs;
 };

 static int add_packed_commits(const struct object_id *oid,
@@ -751,6 +789,21 @@ static int add_packed_commits(const struct object_id *=
oid,
 	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));

+	/*
+	 * Aggregate object statistics
+	 */
+	list->num_objects++;
+	if (type =3D=3D OBJ_COMMIT)
+		list->num_commits++;
+	else if (type =3D=3D OBJ_TAG)
+		list->num_tags++;
+	else if (type =3D=3D OBJ_TREE)
+		list->num_trees++;
+	else if (type =3D=3D OBJ_BLOB)
+		list->num_blobs++;
+	else
+		BUG("should not encounter internal-only object_type %d value here!", typ=
e);
+
 	if (type !=3D OBJ_COMMIT)
 		return 0;

@@ -939,6 +992,8 @@ int write_commit_graph(const char *obj_dir,
 	oids.progress =3D NULL;
 	oids.progress_done =3D 0;
 	commits.list =3D NULL;
+	oids.num_objects =3D oids.num_commits =3D oids.num_tags =3D
+		oids.num_trees =3D oids.num_blobs =3D 0;

 	if (append) {
 		prepare_commit_graph_one(the_repository, obj_dir);
@@ -1092,7 +1147,7 @@ int write_commit_graph(const char *obj_dir,

 		commits.nr++;
 	}
-	num_chunks =3D num_extra_edges ? 4 : 3;
+	num_chunks =3D num_extra_edges ? 5 : 4;
 	stop_progress(&progress);

 	if (commits.nr >=3D GRAPH_EDGE_LAST_MASK) {
@@ -1136,20 +1191,22 @@ int write_commit_graph(const char *obj_dir,
 		break;
 	}

-	chunk_ids[0] =3D GRAPH_CHUNKID_OIDFANOUT;
-	chunk_ids[1] =3D GRAPH_CHUNKID_OIDLOOKUP;
-	chunk_ids[2] =3D GRAPH_CHUNKID_DATA;
+	chunk_ids[0] =3D GRAPH_CHUNKID_OIDNUMBERS;
+	chunk_ids[1] =3D GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[2] =3D GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[3] =3D GRAPH_CHUNKID_DATA;
 	if (num_extra_edges)
-		chunk_ids[3] =3D GRAPH_CHUNKID_EXTRAEDGES;
+		chunk_ids[4] =3D GRAPH_CHUNKID_EXTRAEDGES;
 	else
-		chunk_ids[3] =3D 0;
-	chunk_ids[4] =3D 0;
+		chunk_ids[4] =3D 0;
+	chunk_ids[5] =3D 0;

 	chunk_offsets[0] =3D header_size + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_W=
IDTH;
-	chunk_offsets[1] =3D chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] =3D chunk_offsets[1] + hashsz * commits.nr;
-	chunk_offsets[3] =3D chunk_offsets[2] + (hashsz + 16) * commits.nr;
-	chunk_offsets[4] =3D chunk_offsets[3] + 4 * num_extra_edges;
+	chunk_offsets[1] =3D chunk_offsets[0] + GRAPH_OIDNUMBERS_SIZE;
+	chunk_offsets[2] =3D chunk_offsets[1] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[3] =3D chunk_offsets[2] + hashsz * commits.nr;
+	chunk_offsets[4] =3D chunk_offsets[3] + (hashsz + 16) * commits.nr;
+	chunk_offsets[5] =3D chunk_offsets[4] + 4 * num_extra_edges;

 	for (i =3D 0; i <=3D num_chunks; i++) {
 		uint32_t chunk_write[3];
@@ -1170,6 +1227,10 @@ int write_commit_graph(const char *obj_dir,
 			progress_title.buf,
 			num_chunks * commits.nr);
 	}
+	write_graph_chunk_numbers(f, progress, &progress_cnt,
+				  oids.num_objects, oids.num_commits,
+				  oids.num_tags, oids.num_trees,
+				  oids.num_blobs);
 	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress=
_cnt);
 	write_graph_chunk_oids(f, hashsz, commits.list, commits.nr, progress, &pr=
ogress_cnt);
 	write_graph_chunk_data(f, hashsz, commits.list, commits.nr, progress, &pr=
ogress_cnt);
diff --git a/commit-graph.h b/commit-graph.h
index 2c461770e8..ef9eb0b6cb 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -45,10 +45,16 @@ struct commit_graph {

 	unsigned char hash_len;
 	unsigned char num_chunks;
+	uint32_t num_objects;
 	uint32_t num_commits;
+	uint32_t num_commits_stat;
+	uint32_t num_tags;
+	uint32_t num_trees;
+	uint32_t num_blobs;
 	struct object_id oid;

 	const uint32_t *chunk_oid_fanout;
+	const unsigned char *chunk_oid_numbers;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;


Opel Vivaro
