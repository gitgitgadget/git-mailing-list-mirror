Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42921F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeKUBek (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeKUBek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so2324686wrt.7
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYf935D3Ojg/RBEynRDtmTVxulEr7XF9D2DlULrMO+8=;
        b=Lffs47fpaG/q8XL3aM3YCbkyDQN0ps9CnGIubavkwKwGY/hnOUQJRKYbrRPFIKDUKC
         S91bERly+Od3nGN0LmDwn48d1gDf/HS2z0qpIMdThO+6YQ0C2toZXNdEst1FnzCSP0uu
         joVZGW+djjtga30t6g4zztlB9r/GaXmVmOCb2yZhIG0i5lYBtt9mGX5ELnw4jLXZFU/J
         tkoZhMQ96+CZey9u+OKkO/W3M3R5pcRvI0bQLPSLfh1RThLQuhnYEiNyL8HZN+L5vxAh
         y1VWUbqJVKFUUp72xxIfPC0OD5OQ0nOhFwELmeO0BaH6IwhQb6O6uanjKIHrHBfjNo3Y
         HRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYf935D3Ojg/RBEynRDtmTVxulEr7XF9D2DlULrMO+8=;
        b=Ll68+bBN8i7jF7aqfjWLJkka5AvVQLJnhmpvjpThrDAuIBOALwgbDAh4uKyQz9BkuI
         DY2iOUTz484LdMKSM5AiShKtodslP/boM4D1lzVEDFJOJP7ayWZ9+exlr6DTyGtFf+fY
         YJGOXOT8G6WRdwiJ3UNIbZFsBlyogFvoelXptkqQr9K4OLc/kZdPja6fOSlhXUiKc40f
         QOqhJjh6vs8a084is+yE7UfhyVwC0gVp9sLvBQ0Cn+kRdZ7++SmjL77H7RiTqCF1iKI+
         86DL8R3yx+vCdFYgoAkZK2yTBLxam2I6eFe3f91AdN2xsvSp/NUH45hI14OmSTFzJCjK
         B9lg==
X-Gm-Message-State: AA+aEWYFkiiR67gcFkcVmx5Xh6QY3Goq5+0zDOJWfWmJT5QEKxhOK27p
        etTUpObGWbByhaidt8NtQNurBj87dYs=
X-Google-Smtp-Source: AFSGD/Whurfgd9/kR706REKkzxLEOb9ZVj/NCQuE5AJlZG/L0Yy2On6geZFkCghJxux16AxulP89/Q==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr2226208wrq.69.1542726303178;
        Tue, 20 Nov 2018 07:05:03 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:05:02 -0800 (PST)
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
Subject: [PATCH 6/6] commit-graph write: add even more progress output
Date:   Tue, 20 Nov 2018 15:04:43 +0000
Message-Id: <20181120150443.12997-7-avarab@gmail.com>
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

Add more progress output to sections of code that can collectively
take 5-10 seconds on a large enough repository. On a test repository
with 7141512 commits (see earlier patches for details) we'll now emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (50009986/50009986), done.
    Annotating commit graph: 21564240, done.
    Counting distinct commits in commit graph: 100% (7188080/7188080), done.
    Finding extra edges in commit graph: 100% (7188080/7188080), done.
    Computing commit graph generation numbers: 100% (7143635/7143635), done.
    Writing out commit graph chunks: 21431282, done.

Whereas on a medium-sized repository such as linux.git we'll still
emit output like:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6365328/6365328), done.
    Annotating commit graph: 2391621, done.
    Computing commit graph generation numbers: 100% (797207/797207), done.
    Writing out commit graph chunks: 2399867, done.

The "Counting distinct commits in commit graph" phase will spend most
of its time paused at "0/*" as we QSORT(...) the list. That's not
optimal, but at least we don't seem to be stalling anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index d0961e89df..2e2eaa24ca 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -893,12 +893,19 @@ void write_commit_graph(const char *obj_dir,
 
 	close_reachable(&oids, report_progress);
 
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Counting distinct commits in commit graph"),
+			oids.nr);
+	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(oids.list, oids.nr, commit_compare);
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
+		display_progress(progress, i + 1);
 		if (!oideq(&oids.list[i - 1], &oids.list[i]))
 			count_distinct++;
 	}
+	stop_progress(&progress);
 
 	if (count_distinct >= GRAPH_PARENT_MISSING)
 		die(_("the commit graph format cannot write %d commits"), count_distinct);
@@ -908,8 +915,13 @@ void write_commit_graph(const char *obj_dir,
 	ALLOC_ARRAY(commits.list, commits.alloc);
 
 	num_extra_edges = 0;
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Finding extra edges in commit graph"),
+			oids.nr);
 	for (i = 0; i < oids.nr; i++) {
 		int num_parents = 0;
+		display_progress(progress, i + 1);
 		if (i > 0 && oideq(&oids.list[i - 1], &oids.list[i]))
 			continue;
 
@@ -926,6 +938,7 @@ void write_commit_graph(const char *obj_dir,
 		commits.nr++;
 	}
 	num_chunks = num_extra_edges ? 4 : 3;
+	stop_progress(&progress);
 
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
-- 
2.20.0.rc0.387.gc7a69e6b6c

