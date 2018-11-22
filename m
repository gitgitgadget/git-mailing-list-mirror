Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF311F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437810AbeKWCTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44893 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437805AbeKWCTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so5384048wrt.11
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRsu+hhayZOTgX5M/9t+10UQVp0RfgvqwjzWEveLhJg=;
        b=n7PpXEZOzH8BlLzqhRLzo9Ti8Q2p9aIloTLCGDoRRndQ26xzqRr848tfPwpuSC2i20
         M4XIMv8i9svRDPsKlhAdB27u298iZjkoelwbxzmSqCaBbquHvhsxt4XbNJLO/gXdEqDu
         aaEvhJdNcY4a1fg2M1qTTxWE39odGjglQ3L8U5jECDmrucq2pqtg8OY9zgvlo6fbTaV7
         0gHRIj+DTkHzMYmr9QtPKGPo01nwLGKtABun2ExlGtlftPeoYxYbfWbp0vL9zazcW3UV
         /7xKud959x/keBWGWZ6FIs82bvHJlDUxLvNjOeDVCRxOWD6zanyHh8+S24vgIIezTITl
         QAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRsu+hhayZOTgX5M/9t+10UQVp0RfgvqwjzWEveLhJg=;
        b=W3q9+W0L47R6vbU/LXfgPuNeiSP9J7SXi9vQB1dW+2OYAwiPbxDHxSyR2LoTnEPdXC
         ln5AvJXB6TSNM5dIg3PfnWDQGjXiIyFdFx+B7E4Rw3NuDi+wr76s6N9WFGzPwrS3SNJa
         oSn8yVTlBMCizNPKHGQXXQo+mSNNXjKBQ00vdBJkRHkU5K08kO1OqZU4vymIfhPx7/Yp
         1P5okdLZOefh3W+UkuxDhmsH/UHvpPSNAQSc2Ot+C4s2TJkAZpxPa5JGAdvs4/oobynM
         +wunJmphqNt1fiZRMiuTnyjEIQk+h+TWHPY1MsM7p4VvqUUZ2S3jtV/BYqgxr5NkGRiX
         QSXw==
X-Gm-Message-State: AA+aEWYfirV2RJAOniy0ilZo0GGsomFIskY0RNPvX4453A+Tb+CQHVDo
        VCk9/j6H8k6eNRzJ8BWdul37ogBH3aY=
X-Google-Smtp-Source: AFSGD/WYM1zPXIzYd7B3cm3wevocLRBP2h5hkm6CrS6gdIeOLcbwY5cxSMwzSfsIOzIVYL4+UJ2Fhw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr10805888wrr.67.1542901187588;
        Thu, 22 Nov 2018 07:39:47 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:46 -0800 (PST)
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
Subject: [PATCH v4 09/10] commit-graph write: add itermediate progress
Date:   Thu, 22 Nov 2018 15:39:21 +0000
Message-Id: <20181122153922.16912-10-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
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
    Finding commits for commit graph among packed objects: 100% (48333911/48333911), done.
    Annotating commit graph: 21435984, done.
    Counting distinct commits in commit graph: 100% (7145328/7145328), done.
    Finding extra edges in commit graph: 100% (7145328/7145328), done.
    Computing commit graph generation numbers: 100% (7145328/7145328), done.
    Writing out commit graph in 4 passes: 100% (28581312/28581312), done.

Whereas on a medium-sized repository such as linux.git these new
progress bars won't have time to kick in and as before and we'll still
emit output like:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    Annotating commit graph: 2391666, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph in 4 passes: 100% (3188888/3188888), done.

The "Counting distinct commits in commit graph" phase will spend most
of its time paused at "0/*" as we QSORT(...) the list. That's not
optimal, but at least we don't seem to be stalling anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 199155bd68..80f201adf4 100644
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

