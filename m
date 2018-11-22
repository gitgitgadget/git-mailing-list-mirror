Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA97F1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436859AbeKWAIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50690 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436841AbeKWAIE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so9018393wmh.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHMPppvw2cwK1TwF/gwukbkSuetWwFrHCi6J8hzYy14=;
        b=bqr7GwnyPLW9NYsmIgGC9Z33h4feZEYUzLiQllZAUCqFyI0vhIgy7TMkW9jhfQBf3+
         1sPtvF42FIHwmdrCzBtfxLae4GZgsRIV+6u9jAB5DttTyoquhoz3CjRw5UGm88yN1bdx
         MtsTz+zrsjVznyC72CJis9UsfpqCFY1ZPYx8YLl2NTeSZQfUswyO8Ofl12gpC0H1QzVs
         imty+OuVYS5ErgWc3RXHh4yBVZ8gfOthtl3+6tFGBJo1jFbHPnHcqDCIFruyWHemMUee
         Ttp+ztgiTU2l4eWlFK8HbpegeB1fhOS+4B6dMjTwCkuU4Q1v1X7BMC/D2OEB19prJ7ZF
         t1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHMPppvw2cwK1TwF/gwukbkSuetWwFrHCi6J8hzYy14=;
        b=jWwTDdhK/tyfuOywx15mY+ZeLvz4LoCsX2Vj7DdCRuJMhz/sA50Bc20sUtbwWqIHq9
         XXUJJcDY7JFMlE1ESQg21N+iJ0o60c+S/KUBXWslt6ipkVkPT5WqrmOsujpFuQwcxisL
         JsCRiNElkJsikHvVJNu3abeCi/nn7yPDNB2k8wcjvzzkoFis/GrUuirtX1onEr3uwCP+
         FgmowM1EdNeUZ5TXd8JEJcfjXxJpyRyVW96ImMhFYW4MYvbdpZgsvAjsrY8apYBFHyyK
         qeEWfzl0d2k67F8axBWZlW0Z2gVB3mAu9rBgzdwf78O01JcFWS4fg5BZhy3IWR/PmUNU
         lb4Q==
X-Gm-Message-State: AGRZ1gLesVQmPagang5DJpMp8qW8es4GGzPVwnEYfkDbPHXsAaYOWiao
        D2APBSr6uHnFyH3DsdU5M9OfB11U
X-Google-Smtp-Source: AJdET5eoqhPSZPz8e/o18hgwvdfkGsDZfGEldtMX16xj59VmdDsyBjZ3ImqXNeKyE33xUs5q972LVw==
X-Received: by 2002:a1c:9f8f:: with SMTP id i137mr9414190wme.30.1542893320154;
        Thu, 22 Nov 2018 05:28:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:39 -0800 (PST)
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
Subject: [PATCH v3 05/10] commit-graph write: more descriptive "writing out" output
Date:   Thu, 22 Nov 2018 13:28:18 +0000
Message-Id: <20181122132823.9883-6-avarab@gmail.com>
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

Make the "Writing out" part of the progress output more
descriptive. Depending on the shape of the graph we either make 4 or 5
passes over it.

Let's present this information to the user in case they're wondering
what this number, which is much larger than their number of commits,
has to do with writing out the commit graph. Now e.g. on linux.git we
emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph: 6365442, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph in 5 passes: 100% (3986110/3986110), done.

A note on i18n: Why are we using the Q_() function and passing a
number & English text for a singular which'll never be used? Because
the plural rules of translated languages may not match those of
English, and to use the plural function we need to use this format.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index e32a5cc1bc..8e5970f0b9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -780,6 +780,7 @@ void write_commit_graph(const char *obj_dir,
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
+	struct strbuf progress_title = STRBUF_INIT;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -962,8 +963,13 @@ void write_commit_graph(const char *obj_dir,
 		int graph_passes = 4;
 		if (num_large_edges)
 			graph_passes++;
+		strbuf_addf(&progress_title,
+			    Q_("Writing out commit graph in %d pass",
+			       "Writing out commit graph in %d passes",
+			       graph_passes),
+			    graph_passes);
 		progress = start_delayed_progress(
-			_("Writing out commit graph"),
+			progress_title.buf,
 			graph_passes * commits.nr);
 	}
 	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
@@ -973,6 +979,8 @@ void write_commit_graph(const char *obj_dir,
 		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
 	stop_progress(&progress);
 
+	strbuf_release(&progress_title);
+
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
-- 
2.20.0.rc0.387.gc7a69e6b6c

