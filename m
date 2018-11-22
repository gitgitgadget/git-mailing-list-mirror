Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71CAC1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436871AbeKWAIK (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46143 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436848AbeKWAIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so9260094wrt.13
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6mJ0t/Zb/Wi0jbx1rqh2NIxMQCo9d2/KTrbCgWLXmA=;
        b=trXRbFFFnUYbMnnLImjQJ8ECNm1G9RZkykp45lKtdKX/OrBd03jb5V3AafPjNYavDz
         FoMdPm+Vw7Rxq3jZq+JpA9DPNXncepEthpLTI6TmLt67E01ZxO5xcumWi7VvwYlb5xPP
         YqEu9ayEIpsS9sO+WTV92oADXo9JNXYqhuim/tjK4d6+DNmjtZO3E9c2Y17j2RGIIMQ+
         rNmQyq6FVh+VVg1KsPar6Hs5FhhWqBZzu/q42Y/kThReEgAcmGAMmaNIZANF1hf9x7F9
         5mPPX1WiczMCAdp64fNY56xRaXnRnCb1MQgs0MCspBUGNBt6idGfkLi/7FM2QbiYTnjp
         OjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6mJ0t/Zb/Wi0jbx1rqh2NIxMQCo9d2/KTrbCgWLXmA=;
        b=JqJTfQ4u9+P1sbfwNeEE2mWzKlvcrPYIKF0L12qEnmFLDoidm/R3DWxu8wgmpgc9M6
         wXafTIqsx/r+4GsLJ0sMQOUtngS2i5dvnaLHEGtSwn8JFF0MyzFcc9WHIBFUtwfaMeJY
         HbRfPLC5/0y0YyUCxYoNk5XQ+beLNSFmb8Qr6xWdWK5UHwaCY0gjzrGQpO2h4a/pYLbO
         bwlr7MOlptXB6GVoygiyz1035Pzxtbh0EBnNWdaxg8aBahE6MrBmApdU/KmzxjIHfFFx
         df6fcqbSmO+UDMtDXXURRzadEsqD+clPlL4Xwoiux8xf8hh8vTQtaMr9QgvwvR5xeSxc
         t7eg==
X-Gm-Message-State: AA+aEWZRjyB+hAo3d8rADZRBpdaQN2hT2YCrNuys/XLLrVDz+GKq6pr7
        b0OsC+mWSq5cvSZfyV4KKXwa5b2POJs=
X-Google-Smtp-Source: AFSGD/W1wSmM3bYVe8SbA3apGjaAjfTmcbAHTRQFvjaPk443e1N1v41tWkp6qCB+RxQ2JL/MJ/rMXA==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr9171412wrn.157.1542893326295;
        Thu, 22 Nov 2018 05:28:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:45 -0800 (PST)
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
Subject: [PATCH v3 09/10] commit-graph write: add itermediate progress
Date:   Thu, 22 Nov 2018 13:28:22 +0000
Message-Id: <20181122132823.9883-10-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
References: <20181121012600.26951-1-szeder.dev@gmail.com>
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
index 21751231e0..a6e6eeb56b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -889,12 +889,19 @@ void write_commit_graph(const char *obj_dir,
 
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
@@ -904,8 +911,13 @@ void write_commit_graph(const char *obj_dir,
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
 
@@ -922,6 +934,7 @@ void write_commit_graph(const char *obj_dir,
 		commits.nr++;
 	}
 	num_chunks = num_large_edges ? 4 : 3;
+	stop_progress(&progress);
 
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
-- 
2.20.0.rc0.387.gc7a69e6b6c

