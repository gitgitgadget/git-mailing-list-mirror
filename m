Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096A11F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393170AbfAPNaP (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40172 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393158AbfAPNaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so1978315wmf.5
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sC2qNZzmj+8JLaFcC1APTX7BuXGegsoDQvpreSQl+KM=;
        b=HXQCqPFb9y1RzDUM9zEUfvalO09NBfGq1nRNnowMnsS0+V4hHHC7T+o6v+owcJbdjd
         8WFo3JOGpsQuWk9Xhfa+wI/UaltbECKzzVl9dYPv6nUqjBMqbmBdeAPx/eMWOX8NQPTG
         xpz5qlm+4QoW6GECEancDw/mJSNHQIACrlv7wbcKYQj+RaQUU6xUEdRdJGtGOhVVpDah
         WNxHQqKmbye50DgY+0OcXj76qftXXbAZYnrd8ra0tC39WxplI/de8Z867CO8gAYYJ7rE
         rp5dCXPcRdxNLWLdz48dgilael3946V3L8ITSYT/9eUPdJgHFY8/8Tl2gCHic9U3JKOZ
         oQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC2qNZzmj+8JLaFcC1APTX7BuXGegsoDQvpreSQl+KM=;
        b=mEGnvxKdMeaj6ewAKxhSVEglPuAs8AkjHF8IF5N2bl/AivSEUK4Fy5JMQ/5GDtn1EQ
         cx0js4OX33LN7ReZrV0yRdqcyVnNCHgiokxPS18UIApKK/b7gykGlpOM/T/vR4svX6+n
         j6DZZzG4AJG+DUqPU683LlFFCtoUELmriJy2q+DxM8JVHMG6sX3JEvdHBPuuIi1PkZ9G
         SYIMZ6/CjLgyT3NpzIkwC6MYoAR3Dk8Ks7JIEQtMMmLgEF3Ic5n4EXv2j948FQ2hXefS
         k7slnhH4cqSyt4Qmeeql2lo3Q3xPOkGFL7YLGFCvfaXgxka+7R+27K08ymP4zj7iUXUh
         Rxxw==
X-Gm-Message-State: AJcUukegBD+0U8t8PWYlWGJuHe+hnlp/K8oOugrm6hYMBuulvnmykoPk
        PMemwdzKTwBmx0haegK2oQ+0/zqKvwI=
X-Google-Smtp-Source: ALg8bN731EEZKp81qFsZHu0djTF/7VZD+x2gnsJnbQ4V77XAbGBHg984O5UxCF0I/kDMvnk2vNSo8Q==
X-Received: by 2002:a7b:cf0f:: with SMTP id l15mr8104532wmg.30.1547645411895;
        Wed, 16 Jan 2019 05:30:11 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:10 -0800 (PST)
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
Subject: [PATCH v5 4/9] commit-graph write: more descriptive "writing out" output
Date:   Wed, 16 Jan 2019 14:29:42 +0100
Message-Id: <20190116132947.26025-5-avarab@gmail.com>
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

Make the "Writing out" part of the progress output more
descriptive. Depending on the shape of the graph we either make 3 or 4
passes over it.

Let's present this information to the user in case they're wondering
what this number, which is much larger than their number of commits,
has to do with writing out the commit graph. Now e.g. on linux.git we
emit:

    $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/linux commit-graph write
    Finding commits for commit graph: 6529159, done.
    Expanding reachable commits in commit graph: 815990, done.
    Computing commit graph generation numbers: 100% (815983/815983), done.
    Writing out commit graph in 4 passes: 100% (3263932/3263932), done.

A note on i18n: Why are we using the Q_() function and passing a
number & English text for a singular which'll never be used? Because
the plural rules of translated languages may not match those of
English, and to use the plural function we need to use this format.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0c3af28399..7653c4e9d6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -784,6 +784,7 @@ void write_commit_graph(const char *obj_dir,
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
+	struct strbuf progress_title = STRBUF_INIT;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -966,8 +967,13 @@ void write_commit_graph(const char *obj_dir,
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
@@ -976,6 +982,7 @@ void write_commit_graph(const char *obj_dir,
 	if (num_large_edges)
 		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
 	stop_progress(&progress);
+	strbuf_release(&progress_title);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.153.gd81d796ee0

