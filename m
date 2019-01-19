Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92441F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfASUVy (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35491 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbfASUVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so7511329wmt.0
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e54Zak99FFaDrZFsHZQS8t0t3aOw3lHqNbIw9RsP3mk=;
        b=ZVLiWucNp9Oe+bdDyZnYmoG6VvAWk2BsU7nVDhjrEzfBtekEe2JJKQ305jCLzygy3S
         cLSjRwXkWK24l9JmqGtsTRKG1jiySr8JSEnbYQ2QWoEsR4vaSdfLFkq4vT14Mo3wzXlH
         eEgD7mQW+5gAiX//Hj/OALfyyuJFN5EdcD6Fs+eWjoAh41ObC4lWWRl5xGrRPEX0MHfw
         PeiGTlz3yZoHovI+9RbAr7UbChKf71temMT96MVqo/oN4QFTfNsIERjHhcuBjNjljDVr
         aIwrTqJa+QFrUvxVGGC8k31CGNZ5zqFiUIvaIjDNv2jfMtIY53ZZOmmuPYuSp6DJEV/h
         jQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e54Zak99FFaDrZFsHZQS8t0t3aOw3lHqNbIw9RsP3mk=;
        b=antk3TW3jpGh3lTgJ+BCluG8AmH+SQJ2548nO3VQ2Ry/2rmwZ2d7jim8FjQVUFmE52
         lawuc/wKdD1Ae3m3rq5XVcnFbNK8+0pgn0mjiQUzQlLItZqWAsMwpV56fKxk9023jzki
         /1ovXWlyNZGkkaswy18e4dLt57w2C7yhy/2qHdw+1nwbvddVFMYADDdNMf3Jb0d+M0wN
         cowRfaVjv/Slz+OuPV/KqQkMSY8NKLEBnRh2pOnTiElLhyC46e12v95vWfovdflQyxii
         OtOTWVkEth7BUOEV2f5/k+CTaGSuQWbuK1uOF4YDraU99ECaOCiTwCTpNWgN9bJiiZak
         4HlA==
X-Gm-Message-State: AJcUukfhfmZUQRXsmM602Af87zEH2t/oHn27t6X+l12FO6e7STf/oPCo
        LbhYk4vY8p9kvmrqp6/n14qx1LVYiXU=
X-Google-Smtp-Source: ALg8bN4iGODKhQ/Kpfl23jq7GrNRE8/JwYAYG5knZqB6DTCPLJQFmRgxzTEE8ZE2ZWllZssNNdnQ7w==
X-Received: by 2002:a1c:b53:: with SMTP id 80mr18494107wml.121.1547929309361;
        Sat, 19 Jan 2019 12:21:49 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:48 -0800 (PST)
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
Subject: [PATCH v6 07/10] commit-graph write: add more descriptive progress output
Date:   Sat, 19 Jan 2019 21:21:18 +0100
Message-Id: <20190119202121.3590-8-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190116132947.26025-1-avarab@gmail.com>
References: <20190116132947.26025-1-avarab@gmail.com>
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
    Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    [...]

    # Actually we don't emit this since this takes almost no time at
    # all. But if we did (s/_delayed//) we'd show:
    $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    Finding commits for commit graph from 630 refs: 100% (630/630), done.
    [...]

    $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    Finding commits for commit graph in 3 packs: 6529159, done.
    [...]

The middle on of those is going to be the output users might see in
practice, since it'll be emitted when they get the commit graph via
gc.writeCommitGraph=true. But as noted above you need a really large
number of refs for this message to show. It'll show up on a test
repository I have with ~165k refs:

    Finding commits for commit graph from 165203 refs: 100% (165203/165203), done.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3124dfae13..936119b1f9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -822,8 +822,12 @@ void write_commit_graph(const char *obj_dir,
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
@@ -841,14 +845,20 @@ void write_commit_graph(const char *obj_dir,
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
+				    Q_("Finding commits for commit graph from %d ref",
+				       "Finding commits for commit graph from %d refs",
+				       commit_hex->nr),
+				    commit_hex->nr);
+			progress = start_delayed_progress(progress_title.buf,
+							  commit_hex->nr);
+		}
 		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
@@ -868,12 +878,13 @@ void write_commit_graph(const char *obj_dir,
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
 		for_each_packed_object(add_packed_commits, &oids,
 				       FOR_EACH_OBJECT_PACK_ORDER);
-- 
2.20.1.153.gd81d796ee0

