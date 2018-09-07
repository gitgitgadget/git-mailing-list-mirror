Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9443B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIGXMV (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:12:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGXMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:12:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so6803367wrt.3
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L475L5AK2pXk9tcvz42nOa/m9Hg/wrh67d9N+7bA2fs=;
        b=k+XKeBZ4S3cZdP7E3XDmMTTrHu2CmLYOyzR75AKfPZG0Ae3PbJy5WSokIQzS3Kfuz3
         3DYnbu6HyvxeVLNIk2afKfCt236kayJ1vr2n9ffQ8fnEZXsNBdAsOpNbg1afBM2eibFI
         UcHyd4pbmzMLouWM9/WEnNQ+ue8epmrjv5jNRcqwLodURh/t5rFra43mcxA/dICtULoz
         Eorzps9pR3z8IjPaIHENgKDm1nX3InANhfZuxDi1yDMen5TPvk1Drcqwy6BaFGwW0oid
         lEij5EVn4wG96+kMSzkpgi2yogaHgI/J/Z/TOvuyT/Jz1VpWPTQOneFSyCSgB27P0EiC
         8pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L475L5AK2pXk9tcvz42nOa/m9Hg/wrh67d9N+7bA2fs=;
        b=tY3eWEeBx0AZiFgREwt7BgMEq5ZDc+VuHK7f/FB0jV0CHaDkKJZjjkGgyyGvqvM3np
         L7ZDsWb6426+XRdBDy2BXNTL8SnTVdT7kR17fWOulDq5TBG8NW6y+xa1W63mar+58gCd
         2PcSZt4UAQv7gAZJV4GbOB0EnMGmKvMkzgdhq/DKPajanlqWsvbXvHuGvdGmefaigT8R
         abh4+CIkDqbJsYCPfSmwRV9fpcLpzajeQXp96+q1I/YP9ld67DJXTlWm4P3WBs9HCpG3
         keawrKKf4++Y6lmXXCczWnYm1ljgnRE94dGSCWc1+hrEnurCuF89brb9Rp4YbbE/Z62X
         XoOA==
X-Gm-Message-State: APzg51A6hU2guhTmwh0YQ6bIPHzbKRBqeGVe3W4uG6rMvfaENpxFbGM0
        36mHmqs/lFlkZvRLVL9/KvJ255Qi
X-Google-Smtp-Source: ANB0Vdai5ewmqXwWtUzeleWiYkYIvA2cPfQFvElVho2yriMJdFr9+58iiSgzkQEU5YsimcTlm9BXRA==
X-Received: by 2002:adf:80ea:: with SMTP id 97-v6mr6784042wrl.57.1536345007856;
        Fri, 07 Sep 2018 11:30:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m68-v6sm15396550wmb.10.2018.09.07.11.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:30:07 -0700 (PDT)
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
Subject: [PATCH v2 0/2] commit-graph: add progress output
Date:   Fri,  7 Sep 2018 18:29:52 +0000
Message-Id: <20180907182954.2413-1-avarab@gmail.com>
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

Based on feedback on v1, and the "this is yelling at my users through
gc.log" bug I found. Range-diff with v1:

1:  e0a09ad641 ! 1:  b2dcfa0f55 commit-graph write: add progress output
    @@ -5,8 +5,8 @@
         Before this change the "commit-graph write" command didn't report any
         progress. On my machine this command takes more than 10 seconds to
         write the graph for linux.git, and around 1m30s on the
    -    2015-04-03-1M-git.git[1] test repository, which is a test case for
    -    larger monorepos.
    +    2015-04-03-1M-git.git[1] test repository (a test case for a large
    +    monorepository).
     
         Furthermore, since the gc.writeCommitGraph setting was added in
         d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27),
    @@ -19,7 +19,6 @@
             $ git -c gc.writeCommitGraph=true gc
             Enumerating objects: 2821, done.
             [...]
    -        Total 2821 (delta 1670), reused 2821 (delta 1670)
             Computing commit graph generation numbers: 100% (867/867), done.
     
         On larger repositories, such as linux.git the delayed progress bar(s)
    @@ -27,6 +26,7 @@
         previously happening, printing nothing while we write the graph:
     
             $ git -c gc.writeCommitGraph=true gc
    +        [...]
             Annotating commits in commit graph: 1565573, done.
             Computing commit graph generation numbers: 100% (782484/782484), done.
     
    @@ -42,20 +42,90 @@
     
         With --stdin-packs we don't show any estimation of how much is left to
         do. This is because we might be processing more than one pack. We
    -    could be less lazy here and show progress, either detect by detecting
    -    that we're only processing one pack, or by first looping over the
    -    packs to discover how many commits they have. I don't see the point in
    -    doing that work. So instead we get (on 2015-04-03-1M-git.git):
    +    could be less lazy here and show progress, either by detecting that
    +    we're only processing one pack, or by first looping over the packs to
    +    discover how many commits they have. I don't see the point in doing
    +    that work. So instead we get (on 2015-04-03-1M-git.git):
     
             $ echo pack-<HASH>.idx | git -c gc.writeCommitGraph=true --exec-path=$PWD commit-graph write --stdin-packs
             Finding commits for commit graph: 13064614, done.
             Annotating commits in commit graph: 3001341, done.
             Computing commit graph generation numbers: 100% (1000447/1000447), done.
     
    +    No GC mode uses --stdin-packs. It's what they use at Microsoft to
    +    manually compute the generation numbers for their collection of large
    +    packs which are never coalesced.
    +
    +    The reason we need a "report_progress" variable passed down from "git
    +    gc" is so that we don't report this output when we're running in the
    +    process "git gc --auto" detaches from the terminal.
    +
    +    Since we write the commit graph from the "git gc" process itself (as
    +    opposed to what we do with say the "git repack" phase), we'd end up
    +    writing the output to .git/gc.log and reporting it to the user next
    +    time as part of the "The last gc run reported the following[...]"
    +    error, see 329e6e8794 ("gc: save log from daemonized gc --auto and
    +    print it next time", 2015-09-19).
    +
    +    So we must keep track of whether or not we're running in that
    +    demonized mode, and if so print no progress.
    +
    +    See [2] and subsequent replies for a discussion of an approach not
    +    taken in compute_generation_numbers(). I.e. we're saying "Computing
    +    commit graph generation numbers", even though on an established
    +    history we're mostly skipping over all the work we did in the
    +    past. This is similar to the white lie we tell in the "Writing
    +    objects" phase (not all are objects being written).
    +
    +    Always showing progress is considered more important than
    +    accuracy. I.e. on a repository like 2015-04-03-1M-git.git we'd hang
    +    for 6 seconds with no output on the second "git gc" if no changes were
    +    made to any objects in the interim if we'd take the approach in [2].
    +
         1. https://github.com/avar/2015-04-03-1M-git
     
    +    2. <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
    +       (https://public-inbox.org/git/c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com/)
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
    + --- a/builtin/commit-graph.c
    + +++ b/builtin/commit-graph.c
    +@@
    + 		opts.obj_dir = get_object_directory();
    + 
    + 	if (opts.reachable) {
    +-		write_commit_graph_reachable(opts.obj_dir, opts.append);
    ++		write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
    + 		return 0;
    + 	}
    + 
    +@@
    + 	write_commit_graph(opts.obj_dir,
    + 			   pack_indexes,
    + 			   commit_hex,
    +-			   opts.append);
    ++			   opts.append,
    ++			   1);
    + 
    + 	string_list_clear(&lines, 0);
    + 	return 0;
    +
    + diff --git a/builtin/gc.c b/builtin/gc.c
    + --- a/builtin/gc.c
    + +++ b/builtin/gc.c
    +@@
    + 		clean_pack_garbage();
    + 
    + 	if (gc_write_commit_graph)
    +-		write_commit_graph_reachable(get_object_directory(), 0);
    ++		write_commit_graph_reachable(get_object_directory(), 0,
    ++					     !daemonized);
    + 
    + 	if (auto_gc && too_many_loose_objects())
    + 		warning(_("There are too many unreachable loose objects; "
    +
      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
      +++ b/commit-graph.c
    @@ -87,14 +157,20 @@
      	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
      		die(_("unable to get type of object %s"), oid_to_hex(oid));
     @@
    + 	}
    + }
    + 
    +-static void close_reachable(struct packed_oid_list *oids)
    ++static void close_reachable(struct packed_oid_list *oids, int report_progress)
      {
      	int i;
      	struct commit *commit;
     +	struct progress *progress = NULL;
     +	int j = 0;
      
    -+	progress = start_delayed_progress(
    -+		_("Annotating commits in commit graph"), 0);
    ++	if (report_progress)
    ++		progress = start_delayed_progress(
    ++			_("Annotating commits in commit graph"), 0);
      	for (i = 0; i < oids->nr; i++) {
     +		display_progress(progress, ++j);
      		commit = lookup_commit(the_repository, &oids->list[i]);
    @@ -121,16 +197,20 @@
     +	stop_progress(&progress);
      }
      
    - static void compute_generation_numbers(struct packed_commit_list* commits)
    +-static void compute_generation_numbers(struct packed_commit_list* commits)
    ++static void compute_generation_numbers(struct packed_commit_list* commits, 
    ++				       int report_progress)
      {
      	int i;
      	struct commit_list *list = NULL;
     +	struct progress *progress = NULL;
      
    -+	progress = start_progress(
    -+		_("Computing commit graph generation numbers"), commits->nr);
    ++	if (report_progress)
    ++		progress = start_progress(
    ++			_("Computing commit graph generation numbers"),
    ++			commits->nr);
      	for (i = 0; i < commits->nr; i++) {
    -+		display_progress(progress, i);
    ++		display_progress(progress, i + 1);
      		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
      		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
      			continue;
    @@ -138,11 +218,34 @@
      			}
      		}
      	}
    -+	display_progress(progress, i);
     +	stop_progress(&progress);
      }
      
      static int add_ref_to_list(const char *refname,
    +@@
    + 	return 0;
    + }
    + 
    +-void write_commit_graph_reachable(const char *obj_dir, int append)
    ++void write_commit_graph_reachable(const char *obj_dir, int append,
    ++				  int report_progress)
    + {
    + 	struct string_list list;
    + 
    + 	string_list_init(&list, 1);
    + 	for_each_ref(add_ref_to_list, &list);
    +-	write_commit_graph(obj_dir, NULL, &list, append);
    ++	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
    + }
    + 
    + void write_commit_graph(const char *obj_dir,
    + 			struct string_list *pack_indexes,
    + 			struct string_list *commit_hex,
    +-			int append)
    ++			int append, int report_progress)
    + {
    + 	struct packed_oid_list oids;
    + 	struct packed_commit_list commits;
     @@
      	int num_chunks;
      	int num_extra_edges;
    @@ -160,9 +263,11 @@
      		int dirlen;
      		strbuf_addf(&packname, "%s/pack/", obj_dir);
      		dirlen = packname.len;
    -+		oids.progress = start_delayed_progress(
    -+			_("Finding commits for commit graph"), 0);
    -+		oids.progress_done = 0;
    ++		if (report_progress) {
    ++			oids.progress = start_delayed_progress(
    ++				_("Finding commits for commit graph"), 0);
    ++			oids.progress_done = 0;
    ++		}
      		for (i = 0; i < pack_indexes->nr; i++) {
      			struct packed_git *p;
      			strbuf_setlen(&packname, dirlen);
    @@ -175,14 +280,16 @@
      	}
      
      	if (commit_hex) {
    -+		progress = start_delayed_progress(
    -+			_("Finding commits for commit graph"), commit_hex->nr);
    ++		if (report_progress)
    ++			progress = start_delayed_progress(
    ++				_("Finding commits for commit graph"),
    ++				commit_hex->nr);
      		for (i = 0; i < commit_hex->nr; i++) {
      			const char *end;
      			struct object_id oid;
      			struct commit *result;
      
    -+			display_progress(progress, i);
    ++			display_progress(progress, i + 1);
      			if (commit_hex->items[i].string &&
      			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
      				continue;
    @@ -190,17 +297,48 @@
      				oids.nr++;
      			}
      		}
    -+		display_progress(progress, i);
     +		stop_progress(&progress);
      	}
      
     -	if (!pack_indexes && !commit_hex)
     +	if (!pack_indexes && !commit_hex) {
    -+		oids.progress = start_delayed_progress(
    -+			_("Finding commits for commit graph"), 0);
    ++		if (report_progress)
    ++			oids.progress = start_delayed_progress(
    ++				_("Finding commits for commit graph"), 0);
      		for_each_packed_object(add_packed_commits, &oids, 0);
     +		stop_progress(&oids.progress);
     +	}
      
    - 	close_reachable(&oids);
    +-	close_reachable(&oids);
    ++	close_reachable(&oids, report_progress);
    + 
    + 	QSORT(oids.list, oids.nr, commit_compare);
    + 
    +@@
    + 	if (commits.nr >= GRAPH_PARENT_MISSING)
    + 		die(_("too many commits to write graph"));
    + 
    +-	compute_generation_numbers(&commits);
    ++	compute_generation_numbers(&commits, report_progress);
    + 
    + 	graph_name = get_commit_graph_filename(obj_dir);
    + 	if (safe_create_leading_directories(graph_name))
    +
    + diff --git a/commit-graph.h b/commit-graph.h
    + --- a/commit-graph.h
    + +++ b/commit-graph.h
    +@@
    + 
    + struct commit_graph *load_commit_graph_one(const char *graph_file);
    + 
    +-void write_commit_graph_reachable(const char *obj_dir, int append);
    ++void write_commit_graph_reachable(const char *obj_dir, int append,
    ++				  int report_progress);
    + void write_commit_graph(const char *obj_dir,
    + 			struct string_list *pack_indexes,
    + 			struct string_list *commit_hex,
    +-			int append);
    ++			int append, int report_progress);
    + 
    + int verify_commit_graph(struct repository *r, struct commit_graph *g);
      
2:  a364297d15 ! 2:  775237cffb commit-graph verify: add progress output
    @@ -23,6 +23,10 @@
             real    0m7.813s
             [...]
     
    +    Since the "commit-graph verify" subcommand is never called from "git
    +    gc", we don't have to worry about passing some some "report_progress"
    +    progress variable around for this codepath.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/commit-graph.c b/commit-graph.c
    @@ -47,7 +51,7 @@
      		struct commit_list *graph_parents, *odb_parents;
      		uint32_t max_generation = 0;
      
    -+		display_progress(progress, i);
    ++		display_progress(progress, i + 1);
      		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
      
      		graph_commit = lookup_commit(r, &cur_oid);
    @@ -55,7 +59,6 @@
      				     graph_commit->date,
      				     odb_commit->date);
      	}
    -+	display_progress(progress, i);
     +	stop_progress(&progress);
      
      	return verify_commit_graph_error;

Ævar Arnfjörð Bjarmason (2):
  commit-graph write: add progress output
  commit-graph verify: add progress output

 builtin/commit-graph.c |  5 ++--
 builtin/gc.c           |  3 +-
 commit-graph.c         | 65 ++++++++++++++++++++++++++++++++++++------
 commit-graph.h         |  5 ++--
 4 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.19.0.rc1.350.ge57e33dbd1

