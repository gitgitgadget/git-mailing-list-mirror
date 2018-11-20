Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FE31F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeKUBeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39910 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeKUBeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so2591795wmc.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3k4WGKA2Pzr1aqumWsHUcz4rMhV5DYZ29HRIxuo3RE=;
        b=dCwnd1ZfUSx6395FPx+y2CmjjN8+XqBBdGKXRF6acGNEkPILMsfDJwz+LRFMijx57Y
         6nC84oqG8pGqf+T2yEkXjU4HGJkPCo3aWZR8B8QvnfXW1xhyOvd41YUNfDGwgWXXjcs2
         Q3ySsIlHufzzL0j9zNuGhn8FPA14CiYJGFZLY5Y6LBHTiwnwdRTDrKFXZ8az6cH9Xd4B
         uBxwPjuJTmeHOwiYX11Qy9HD2BgJIlCen39OUrG/Khe76U8KbNJgMELaeNvqnTmpL9sd
         6mmjixBIbz4NYPJ+0yZExeYuo98XUKvYBCSHl0dVF8BeLmB23XIrGa4RlE3wY1pqJgDA
         iLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3k4WGKA2Pzr1aqumWsHUcz4rMhV5DYZ29HRIxuo3RE=;
        b=hnVNDcg+4aWXwRXuCuoJMbA6q0xnBYDFbtNn8UZIWcoALXNMiVaIOKUiNHSfBmbOKy
         Wsw4iLwfa35oRG1pX/7/l8tEiL/qgZfN/t2Akcc1Z6YJXPmT28M4qsfX0w4qWByohBWU
         KqrI5IGdN5JgV64YrPIGh6NaPAVT9CnRRiZc/H68i3E1k78fSJKItPd4wuAV1M6JJLjM
         WNul6ZL3QiwimgVMXE6txYFjLPcTD+Gcq/EOzKYCT11W1QT9kaOT5RAbdiAgVwq3O2U6
         ibnXAJups9ZaqHBiMRnewSTwb1K1Fne88qaFwInmgisOmb+1KVErCkyokY6//2hyer6n
         Twfg==
X-Gm-Message-State: AA+aEWZZr5fJhovfehVKSgFnezBcom8Gcpe25nxYYFJBVDp2kRfiIuag
        piDPUr70rAqkmf15DrzUbi7cffWoE8Q=
X-Google-Smtp-Source: AFSGD/XzbAvShggaSjm8KuXn6iVEhDeanTCZFQMwWaVvh+XxZwkXW+LvyVBgVnO1Ke3no7WG+Cc3xA==
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr2414490wmh.124.1542726299383;
        Tue, 20 Nov 2018 07:04:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:04:58 -0800 (PST)
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
Subject: [PATCH 4/6] commit-graph write: add more describing progress output
Date:   Tue, 20 Nov 2018 15:04:41 +0000
Message-Id: <20181120150443.12997-5-avarab@gmail.com>
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

Make the progress output shown when we're searching for commits to
include in the graph more descriptive. This amends code I added in
7b0f229222 ("commit-graph write: add progress output", 2018-09-17).

Now, on linux.git, we'll emit this sort of output in the various modes
we support:

    $ git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6418991/6418991), done.
    [...]
    $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    Finding commits for commit graph from 584 ref tips: 100% (584/584), done.
    [...]
    $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    Finding commits for commit graph in 4 packs: 6418991, done.
    [...]

The middle on of those is going to be the output users will most
commonly see, since it'll be emitted when they get the commit graph
via gc.writeCommitGraph=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4d03f8aa7f..a0aea850f1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -785,6 +785,7 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 	uint64_t progress_cnt;
 	unsigned long approx_nr_objects;
+	struct strbuf progress_title = STRBUF_INIT;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -821,8 +822,12 @@ void write_commit_graph(const char *obj_dir,
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen = packname.len;
 		if (report_progress) {
-			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"), 0);
+			strbuf_addf(&progress_title,
+				    Q_("Finding commits for commit graph in %d pack",
+				       "Finding commits for commit graph in %d packs",
+				       pack_indexes->nr),
+				    pack_indexes->nr);
+			oids.progress = start_delayed_progress(progress_title.buf, 0);
 			oids.progress_done = 0;
 		}
 		for (i = 0; i < pack_indexes->nr; i++) {
@@ -839,14 +844,20 @@ void write_commit_graph(const char *obj_dir,
 			free(p);
 		}
 		stop_progress(&oids.progress);
+		strbuf_reset(&progress_title);
 		strbuf_release(&packname);
 	}
 
 	if (commit_hex) {
-		if (report_progress)
-			progress = start_delayed_progress(
-				_("Finding commits for commit graph"),
-				commit_hex->nr);
+		if (report_progress) {
+			strbuf_addf(&progress_title,
+				    Q_("Finding commits for commit graph from %d ref tip",
+				       "Finding commits for commit graph from %d ref tips",
+				       commit_hex->nr),
+				    commit_hex->nr);
+			progress = start_delayed_progress(progress_title.buf,
+							  commit_hex->nr);
+		}
 		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
@@ -866,12 +877,13 @@ void write_commit_graph(const char *obj_dir,
 			}
 		}
 		stop_progress(&progress);
+		strbuf_reset(&progress_title);
 	}
 
 	if (!pack_indexes && !commit_hex) {
 		if (report_progress)
 			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"),
+				_("Finding commits for commit graph among packed objects"),
 				approx_nr_objects);
 		for_each_packed_object(add_packed_commits, &oids, 0);
 		if (oids.progress_done < approx_nr_objects)
@@ -976,6 +988,8 @@ void write_commit_graph(const char *obj_dir,
 				      &progress_cnt);
 	stop_progress(&progress);
 
+	strbuf_release(&progress_title);
+
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
-- 
2.20.0.rc0.387.gc7a69e6b6c

