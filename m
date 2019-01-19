Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F8D1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfASUV5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39517 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfASUVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so7434930wmi.4
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZFJBP3YOkKMxljZXP6hYMQ1ADwUWWww3gQINewC3QE=;
        b=kx0gIF8scuURoPpGp7x+ZOG4FkaOZEBH8qcq1EX/19fZ2vtmAjYwnLEdHxJm5uSyJR
         UfBg3IGWnlmLBg9BziG6RMWB0RzmswW7UplBych34c2QYkNSTdnFrBiOaS4Ig1vHoxVM
         62RmXQeeo5pdJOlDATmn9FGhm9OI5POYWEUZUOVEzJxCrP+UUwHrOS7Qx3GeishGG/tj
         ZAaABrXHN3yYm+t0z/FkT8wwkuDyGFpmAIBtg+7kZj+m033bzhWm7ScAI60RaEJAiYTz
         V1HUzeyaM4rwmWvbZJDOEp2UTxFreOu/JtqrDlEx3qffCTp8b9XOX6q6vVWxJKjAL+hd
         zhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZFJBP3YOkKMxljZXP6hYMQ1ADwUWWww3gQINewC3QE=;
        b=D8lWNv/7Z4rrCUg4FgJO6qGR8srOtYh/1edoFRQ8PiMwVHIpv5Ud/NcY7ZgrU3e0WF
         YLTaCY184EggNlLfWqApXmV84XQ3zpx5fU/R0OWlVpdZv4/OisjTxleksnYypOPtSkHq
         nBu5um7gdKm4eQnk8nQQyv/mgIB1mELr7AFZJQ+eM+2VzwGzOiWkMZt8MVSxQhlyUdk9
         Rw26kluabMWpkF43PvrwlNwMC4WelftWoEB8EQpiAmSEm2M3v1OexEPahjj9ScaTUnub
         GLih7cLiX+1qZriYrLEzHW/G8eRpIUqVYZg4RV/45gJAsKygexcYvMTMQz3OPk9VT8+i
         P9lw==
X-Gm-Message-State: AJcUukdBFJLpFBUjaICWuzRtQA4YLzYNL7+vMxe2QMuKIn0mRHuQX2Lg
        QeY1EUFtnCVXApxR3z8Cdtl/s3iWUQ4=
X-Google-Smtp-Source: ALg8bN7Xfz1Ko3CNAtmGfacQm8n86iZFv/Yguqz6ZUUfOUS4Tn8FS1rIYLIBKM6slK0dhvI+XG5ing==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr20240119wme.41.1547929312463;
        Sat, 19 Jan 2019 12:21:52 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:51 -0800 (PST)
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
Subject: [PATCH v6 09/10] commit-graph write: add itermediate progress
Date:   Sat, 19 Jan 2019 21:21:20 +0100
Message-Id: <20190119202121.3590-10-avarab@gmail.com>
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
index d4a7280fa1..889cdefc49 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -895,12 +895,19 @@ void write_commit_graph(const char *obj_dir,
 
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
@@ -910,8 +917,13 @@ void write_commit_graph(const char *obj_dir,
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
 
@@ -928,6 +940,7 @@ void write_commit_graph(const char *obj_dir,
 		commits.nr++;
 	}
 	num_chunks = num_extra_edges ? 4 : 3;
+	stop_progress(&progress);
 
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
-- 
2.20.1.153.gd81d796ee0

