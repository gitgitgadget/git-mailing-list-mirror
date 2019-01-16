Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61431F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbfAPNa1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39380 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393158AbfAPNa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so1983708wmi.4
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUNZq2p4g1oEJp/fK3u2S6boTXD082ZPe8FfGc0PDqs=;
        b=ObmsebVZZ8ETdce5+vwD64xgOeLRWcyWkAsCH2Hh6KUE651+ibX4v3ExnASMPh0yqp
         fGtUZ6IxvcE7HyrMqOeBayCEXOBrE6uxx2i4lRbZLEl1agFwN45aR1U5fO5IEA551NsU
         0EMo7CGoymAgkEIi0cXdqk040+C+Qhiu6bPO6c4pIKVN7s4kb9tMlyrnfNpcWZQybxbd
         s9vyekf5tQx9pTx5U/OfmTcGOVuVqYiG5hLZPK36MIsg23ln/H0ZCNjf2B53UOHxfhom
         PH3yMRsstvy3CItomVuyREMcdf6RrktuZWGEgoMiNePoQNScr+YdxjN5Q7qHUCQHdGvH
         3ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUNZq2p4g1oEJp/fK3u2S6boTXD082ZPe8FfGc0PDqs=;
        b=hYrD0zGYkxJ7wFsMWt86/Ejv++xWdavu0GEMwdt+8hWfueR1JUgS2Ej6ixgzPAZows
         aNF2iMh9xvFu4u6rjc7L3Vc1hTeySWVtXvnEyyD5rH1n/gIegUZwYrN5QmXMHrkTBdSL
         a8a8kAiZ+nTLkdFPaSDge79uM6wR6TxDv3GO69WuNLxf/cJlm563EwhTV+E6Yb8wZW3u
         um34e/yKakEzPA7SZPwsPnbOxQ9xdhBAbUlapY0/8CQSfzpqXiqfNgI8CVfvynYR8QJx
         UU8Zo33BIckKX7xcyCiyUh8qIh6Yq+oDWzv0N3GzvILjC2e99JhM+5zgi9hCTDomJKRC
         LzQQ==
X-Gm-Message-State: AJcUukdyeEnDiqpvomXEfwVwt20z2T3e43F+wrXx57N7ATp5OWuZyPTQ
        xXffVKDWnhkdrdgubOHCQkJoZigXSd0=
X-Google-Smtp-Source: ALg8bN4sQgGySF9fMlWa/BYO6qThokhJv6+HUNsplj++y08Vjh/PsijQHOl/qVHg5beu1WM4BYvRtg==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr8112989wmg.13.1547645424350;
        Wed, 16 Jan 2019 05:30:24 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:22 -0800 (PST)
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
Subject: [PATCH v5 8/9] commit-graph write: add itermediate progress
Date:   Wed, 16 Jan 2019 14:29:46 +0100
Message-Id: <20190116132947.26025-9-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add progress output to sections of code between "Annotating[...]" and
"Computing[...]generation numbers". This can collectively take 5-10
seconds on a large enough repository.

On a test repository with I have with ~7 million commits and ~50
million objects we'll now emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (124763727/124763727), done.
    Loading known commits in commit graph: 100% (18989461/18989461), done.
    Expanding reachable commits in commit graph: 100% (18989507/18989461), done.
    Clearing commit marks in commit graph: 100% (18989507/18989507), done.
    Counting distinct commits in commit graph: 100% (18989507/18989507), done.
    Finding extra edges in commit graph: 100% (18989507/18989507), done.
    Computing commit graph generation numbers: 100% (7250302/7250302), done.
    Writing out commit graph in 4 passes: 100% (29001208/29001208), done.

Whereas on a medium-sized repository such as linux.git these new
progress bars won't have time to kick in and as before and we'll still
emit output like:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    Expanding reachable commits in commit graph: 815990, done.
    Computing commit graph generation numbers: 100% (815983/815983), done.
    Writing out commit graph in 4 passes: 100% (3263932/3263932), done.

The "Counting distinct commits in commit graph" phase will spend most
of its time paused at "0/*" as we QSORT(...) the list. That's not
optimal, but at least we don't seem to be stalling anymore most of the
time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 7138bbd02f..60ec7c1b22 100644
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
 
 	num_large_edges = 0;
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
 	num_chunks = num_large_edges ? 4 : 3;
+	stop_progress(&progress);
 
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
-- 
2.20.1.153.gd81d796ee0

