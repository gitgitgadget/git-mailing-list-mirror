Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB7C1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJJCxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:53:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43379 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJCxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:53:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so3084525wrt.10
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N65XeswMtqVjLwWPRYG0+te3PxC5LX8fhp+zZkuGOgQ=;
        b=l1alD4QWXcUfIpVX/rZiKfEg5ivJCdeSYGepL/zLPZF4HA70llqReZvLEI1bcYpabY
         sCS0PaL811fm+s4VHK9DIRttrQv8fSUacrhlhR8d+1Jv6ohhKulCK8/yKOb1oI5AOsK2
         Uus3+mBC4nOOtu6TRXoX8kJst/tQ3TJShWYCguY/bO0cWPD7wfCh/LhCvEBKKPJCPDGS
         w08ItzPvguYMzliIh1U5AwOM9q8nIF3hObJe6RdYwKkNLIHcxUOripJPNsZQum/q/9El
         yjG2w0C9hq3oeHGyPS03mTUpTW9WEt8Lj4q+plm6cvG9hFVd7dD3nt5CbpAjqNPJwa9f
         JYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N65XeswMtqVjLwWPRYG0+te3PxC5LX8fhp+zZkuGOgQ=;
        b=K6TWLtDbrbK/VeHlcutyMU8fWQILSBnA5aAhnppbGk2nv+rXFGXNVpSCvLVCgSkczM
         nGAeSnecsD/7Yh+MoHXfuPhrEVgji/fs40ZQGO8y9jAPrI9rTjjxQEjfrO8mtVtvhdnU
         pQkMqTvO4MhEdUf07ZyuEXq/XzKH5QHn++WhhxGYWw5lMb8rJP+kVO7a3K3WAp4FXSFU
         RcQqobG6dA6miWA5k/aB+frk2yBxBPoP9lyoR7usXCvq2G77HqG8yuvuQ5xTCtxRPvu0
         94dJ6IFbHWVNQlmJ/h22CAJOadTngADmYTr7WHMgCzMKEU3jWosLFPkfttIj46p6r0bJ
         2rNA==
X-Gm-Message-State: ABuFfohbf4/VVTNwjOHpezXeP3I62pMvnH5vgzn6r3vrVnE7Sh9nEKoM
        uQ13sHUA+UKx9dQNhhnJeP6Gd8I7
X-Google-Smtp-Source: ACcGV62Z7g0RzisGYb4B0s/mqYHYHnPXlk1SPG0YtKRuWQWBkqGdiEj5v3lnzGH86u69ssclhSlu+Q==
X-Received: by 2002:adf:e752:: with SMTP id c18-v6mr22847115wrn.143.1539113715299;
        Tue, 09 Oct 2018 12:35:15 -0700 (PDT)
Received: from localhost.localdomain (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id e6-v6sm18823117wrc.70.2018.10.09.12.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 12:35:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] commit-graph: write a Bloom filter containing changed paths for each commit
Date:   Tue,  9 Oct 2018 21:34:43 +0200
Message-Id: <20181009193445.21908-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.409.g0a0ee5eb6b
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can create a Bloom filter containing changed paths for each commit
in the history by running:

  $ GIT_USE_POC_BLOOM_FILTER=$((8*1024*1024*8)) git commit-graph write

where the value of $GIT_USE_POC_BLOOM_FILTER must specify the number
of bits used in the Bloom filter's bitmap.

Writing the Bloom filter is tied into the 'git commit-graph' command,
mainly because that's where it might end up anyway, if it turns out to
be useful, but for now it's written to a different file
('object/info/bloom').  No incremental updates yet, the Bloom filter
is regenerated from scratch each time.

There is one single, big Bloom filter for the whole history (mainly
because that was the simplest way to get this PoC experiment up and
running).  The Bloom filter stores tuples of (path, parent-oid,
commit-oid) using the hash function:

  XOR(SHA1(path), XOR(parent-oid, commit-oid))

The resulting 20 bytes are turned into 5 unsigned 32 bit ints, which
then specify the positions of the bits to set or check in the Bloom
filter's bitmap (modulo the bitmap's size).

The parent oid is taken into account, because during revision walking
the diff is checked in rev_compare_tree(), which compares one commit
to _one_ of its parents, and in case of merge commits there are
multiple rev_compare_tree() calls with the same commit but with
different parent parameters.

Combining hashes with XOR is, in general, frowned upon, because of its
intrinsic properties:

  XOR(A, A) = 0
  XOR(A, B) = XOR(B, A)

In this case it should be fine, because all of XOR's operands are
cryptographic hashes, so we can safely assume that they'll never be
the same.

Add each leading directory of the changed file, i.e. for
'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so the Bloom
filter could be used to speed up commands like 'git log dir/subdir',
too.

Creating the Bloom filter is sloooow.  Running it on git.git takes
about 23s on my hardware, while

  git log --format='%H%n%P' --name-only --all >/dev/null

gathers all the information necessary for that in about 5.3s.

About 30% of the runtime is wasted by naively hashing and rehashing
the same paths over and over again.  A hash function faster than SHA1
could help with that; I just haven't yet bothered with spicing up
memhash() and friends to produce 5 ints, and neither wanted to
introduce another hash function with wideer output just yet.  Or
perhaps our hashmap mapping paths of files to their SHAs and the SHAs
of their leading directories...

That's not the only factor though.  After ripping out all the loops
from add_changes_to_bloom_filter() there are no repeated SHA1(path)
calculations and no writes to the Bloom filter at all, i.e. all what
remains is revision walking and diffing, yet it still takes about 16s,
i.e. aroung 3 times more than the above mentioned 'git log' command.
I guess some other fields in 'struct rev_info' or 'struct
diff_options' need to be set, but both of those are huge, and I
haven't yet spotted which ones.
---
 commit-graph.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index a1454c52a6..f415d3b41f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -14,6 +14,9 @@
 #include "object-store.h"
 #include "alloc.h"
 #include "progress.h"
+#include "bloom-filter.h"
+#include "diff.h"
+#include "diffcore.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -709,6 +712,117 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
+static void add_changes_to_bloom_filter(struct bloom_filter *bf,
+					struct commit *parent,
+					struct commit *commit,
+					struct diff_options *diffopt)
+{
+	unsigned char p_c_hash[GIT_MAX_RAWSZ];
+	int i;
+
+	hashxor(parent->object.oid.hash, commit->object.oid.hash, p_c_hash);
+
+	diff_tree_oid(&parent->object.oid, &commit->object.oid, "", diffopt);
+	diffcore_std(diffopt);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		const char *path = diff_queued_diff.queue[i]->two->path;
+		const char *p = path;
+
+		/*
+		 * Add each leading directory of the changed file, i.e. for
+		 * 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
+		 * the Bloom filter could be used to speed up commands like
+		 * 'git log dir/subdir', too.
+		 *
+		 * Note that directories are added without the trailing '/'.
+		 */
+		do {
+			git_hash_ctx ctx;
+			unsigned char name_hash[GIT_MAX_RAWSZ];
+			unsigned char hash[GIT_MAX_RAWSZ];
+
+			p = strchrnul(p + 1, '/');
+
+			/*
+			 * Beware all the wasted CPU cycles!
+			 *
+			 * Most paths change (a lot) more than once in the
+			 * history of a repository, so this hashes the same
+			 * paths over and over again, accounting for almost
+			 * 40% of the runtime.
+			 */
+			the_hash_algo->init_fn(&ctx);
+			the_hash_algo->update_fn(&ctx, path, p - path);
+			the_hash_algo->final_fn(name_hash, &ctx);
+
+			hashxor(name_hash, p_c_hash, hash);
+			bloom_filter_add_hash(bf, hash);
+		} while (*p);
+
+		diff_free_filepair(diff_queued_diff.queue[i]);
+	}
+
+	free(diff_queued_diff.queue);
+	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+}
+
+static void fill_bloom_filter(struct bloom_filter *bf,
+				    struct progress *progress)
+{
+	struct rev_info revs;
+	const char *revs_argv[] = {NULL, "--all", NULL};
+	struct commit *commit;
+	int i = 0;
+
+	/* We (re-)create the bloom filter from scratch every time for now. */
+	init_revisions(&revs, NULL);
+	revs.diffopt.flags.recursive = 1;
+	setup_revisions(2, revs_argv, &revs, NULL);
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed while preparing bloom filter");
+
+	while ((commit = get_revision(&revs))) {
+		struct commit_list *parent;
+
+		for (parent = commit->parents; parent; parent = parent->next)
+			add_changes_to_bloom_filter(bf, parent->item, commit,
+						    &revs.diffopt);
+
+		display_progress(progress, ++i);
+	}
+}
+
+static void write_bloom_filter(int report_progress, int commit_nr)
+{
+	struct bloom_filter bf;
+	struct progress *progress = NULL;
+	const char *v = getenv("GIT_USE_POC_BLOOM_FILTER");
+	unsigned int bitsize;
+	char *end;
+
+	if (!v)
+		return;
+
+	bitsize = strtol(v, &end, 10);
+	if (*end)
+		die("GIT_USE_POC_BLOOM_FILTER must specify the number of bits in the bloom filter (multiple of 8, n < 2^32)");
+
+	bloom_filter_init(&bf, bitsize);
+
+	if (report_progress)
+		progress = start_progress(_("Computing bloom filter"),
+					  commit_nr);
+
+	fill_bloom_filter(&bf, progress);
+
+	bloom_filter_write(&bf);
+	bloom_filter_free(&bf);
+
+	stop_progress(&progress);
+}
+
 void write_commit_graph_reachable(const char *obj_dir, int append,
 				  int report_progress)
 {
@@ -916,6 +1030,8 @@ void write_commit_graph(const char *obj_dir,
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
+	write_bloom_filter(report_progress, commits.nr);
+
 	free(graph_name);
 	free(commits.list);
 	free(oids.list);
-- 
2.19.1.409.g0a0ee5eb6b

