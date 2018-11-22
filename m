Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CAC1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437793AbeKWCTg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55834 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391765AbeKWCTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so9325013wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZf8tHIfR2VnbHjVyP8iS3nGAFiLxSZPye6DQu92yEE=;
        b=aOXXfTcm5Pcy1xwR7b9LpPM5BqC2jas/eLNirQ9WIwfCGpPtNu6uQVi54/TpdyJehR
         B9Vvx5pDtIg550dKpU7yqUm/q5jAatcQLNnEghsRIqeBchqGaX9qkIo8kqo4/rrdcl1W
         5vAypIXg449S8CSPfWF7fyBklWDQAhFQ13oYVl+Ypo1lch+Dxm40WZTRiuekx55gGPR2
         A3lSb5UMv3SoQN2hBfCORcxgJNigi6jXzVdK7hVq0dtR6rPBN4noHPNEVTZZrXuOogPS
         wObT1ARTxrhM1MZjaqwU1Krkwi5Nr84NUdkGiSJG77IHOYbq0JdfXFZIFtdwXTHQl2Ak
         HaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZf8tHIfR2VnbHjVyP8iS3nGAFiLxSZPye6DQu92yEE=;
        b=HVTVr9UEzJZUbCXeUo2JYSdWiaNPh5m2OHaK0IoIqq+pwRzEHP6MtwL5sTzR01zGFR
         r725WSGVSK0y0VHPGphp3asB93R7zETuwtYIxeT17xHg6JcfUlCiH0bEOYn48LHg8HCU
         ejYDi41NWfNkIRtYZOxdijRWV2h5ikBYR/TkmU5w9zCjwbF1ojeuQpEJfAj5SzrDhsth
         fjkd3gHLj411AvxufT5BgM53oSidsDilvt/h/Ped9zHYuW9Hldmm2wm2UX0ACTZCXckW
         qOmPiQ5/TktUfHge0odbsy4Kp0cbZPfk0a84fTellD+uXsRzxJ1HRRXeErWKkjvnr08n
         YQsw==
X-Gm-Message-State: AA+aEWYPB3xHQuNmAeqKt6AcU2djTKIRAeTIvAuC92I+ahRiDHx1nOU8
        SW22F1jS3dFcJ7sNQJcwe/KHNRY02YE=
X-Google-Smtp-Source: AFSGD/UixAbK2LhqNHxg3N6nlYfmjkOM9rB9GWKsvHrnlmZmlr+Ha+brKvfA7A2ECy6T0PntDSVpXA==
X-Received: by 2002:a1c:adc9:: with SMTP id w192-v6mr10412224wme.103.1542901181531;
        Thu, 22 Nov 2018 07:39:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:40 -0800 (PST)
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
Subject: [PATCH v4 05/10] commit-graph write: more descriptive "writing out" output
Date:   Thu, 22 Nov 2018 15:39:17 +0000
Message-Id: <20181122153922.16912-6-avarab@gmail.com>
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

Make the "Writing out" part of the progress output more
descriptive. Depending on the shape of the graph we either make 3 or 4
passes over it.

Let's present this information to the user in case they're wondering
what this number, which is much larger than their number of commits,
has to do with writing out the commit graph. Now e.g. on linux.git we
emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph: 6365442, done.
    Annotating commit graph: 2391666, done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph in 4 passes: 100% (3188888/3188888), done.

A note on i18n: Why are we using the Q_() function and passing a
number & English text for a singular which'll never be used? Because
the plural rules of translated languages may not match those of
English, and to use the plural function we need to use this format.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index dc57b8fedc..3de65bc2e9 100644
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
 		int graph_passes = 3;
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

