Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC0D1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeKUGVi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37909 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeKUGVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id e3-v6so3263071wrs.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqwp0+d5r9LumO5f6VXtKaxV22S+qleUWqiRsciHBcQ=;
        b=WcYGGVLzqpYEUstQ0pUgN1DCMTwNnCmuxxtimtIqz082OtRMVAgmFm7ewnF5H/TWYS
         CqAyNdZd9DQedJ8RXKkWmG3wEslaY5/f5FenYfXRIYYMSGq+koXT5z4UddC1R9tydf9g
         CQ2AD4jSK+V2mAi4amQ7IKEqDWx0K6xxNpETYRvOm55++dY0JzkYeVM1MWaUmSh+mvG7
         dPSRW2WBnpdeIHti539u3H+Yd/b2F9AAuI77tgo/Q53miDnI6DB4ipvpMidYdGLCkzvv
         1+gd1+0jsY+UyAiZpvM/Crpeb9jo5e5Lu3l4LX8LVzJibVe8hiWp6qBi9m0fp5i9H0hW
         QTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqwp0+d5r9LumO5f6VXtKaxV22S+qleUWqiRsciHBcQ=;
        b=kKPmn0+IBt2DmXk1Pn8kGnWklNOPMtS5M9gf8WMwEUGn9ZhDrNeq0jR7WqCd6QKuR1
         8jVvxsrLIowZ46466XW+VGV4Wp2uuEMEBpGZEjcjkQL1EyBz3WXtD+FZNuhhSsznDrq2
         VLEA+pDMLNbQ3DyDiMUf04n4KX8A0n5amPSS3UXfaAsPVYDmHi/1AgnmrJsQcvldylJO
         Ahr/lM86mQKZn4kpGlZlMntR7tz5YoDGNnsjcVKKLgkify+JaMHeyShgmmmpIwVhfx/g
         NxdIPyp5gO493PCn9KY87ZjNZ+Bu/460GYvXkRZdUMmh94LzyzBI/ORyUn1Kmzrq+xWa
         lPHA==
X-Gm-Message-State: AA+aEWbI3SzN4iCTCztJy73hukGYeDDrUilppcxN9vl9ydLQf3sP7sXM
        peLhE+vmNmeSo/ddEOkTVB44E5GCBC4=
X-Google-Smtp-Source: AFSGD/XsIDSh3xm2CTpXHDkyIJdjtmzvX3QOGHhOGDRVemq4zeJc/lgLSwpG+SJqgTI/30lmu5sIkw==
X-Received: by 2002:a5d:488a:: with SMTP id g10-v6mr3366500wrq.122.1542743446958;
        Tue, 20 Nov 2018 11:50:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:46 -0800 (PST)
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
Subject: [PATCH v2 6/6] commit-graph write: add even more progress output
Date:   Tue, 20 Nov 2018 19:50:27 +0000
Message-Id: <20181120195027.3260-7-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more progress output to sections of code that can collectively
take 5-10 seconds on a large enough repository. On a test repository
with I have with ~7 million commits and ~50 million objects we'll now
emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (50026015/50026015), done.
    Annotating commit graph: 21567407, done.
    Counting distinct commits in commit graph: 100% (7189147/7189147), done.
    Finding extra edges in commit graph: 100% (7189147/7189147), done.
    Computing commit graph generation numbers: 100% (7144680/7144680), done.
    Writing out commit graph: 21434417, done.

Whereas on a medium-sized repository such as linux.git these new
progress bars won't have time to kick in and as before and we'll still
emit output like:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6365492/6365492), done.
    Annotating commit graph: 2391666, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph: 2399912, done.

The "Counting distinct commits in commit graph" phase will spend most
of its time paused at "0/*" as we QSORT(...) the list. That's not
optimal, but at least we don't seem to be stalling anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 0e98679bce..1ad9000060 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -887,12 +887,19 @@ void write_commit_graph(const char *obj_dir,
 
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
@@ -902,8 +909,13 @@ void write_commit_graph(const char *obj_dir,
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
 
@@ -920,6 +932,7 @@ void write_commit_graph(const char *obj_dir,
 		commits.nr++;
 	}
 	num_chunks = num_extra_edges ? 4 : 3;
+	stop_progress(&progress);
 
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
-- 
2.20.0.rc0.387.gc7a69e6b6c

