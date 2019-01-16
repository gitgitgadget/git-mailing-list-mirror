Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F23C1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393173AbfAPNaT (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38119 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393158AbfAPNaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so2010897wml.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xAVNYoiuQrBWAz3Wo+k/zvFJLUkV5jlSsvAv3GlPnc=;
        b=H4iFLBOBmvZOalCRr8R7v4JzBf6rfzynjv6AbstEFZ9H8tberYaE57dgg9WZohsaW4
         HHk19KJwoCJvalS0yc7wHve31Ax0Nbk3//8Y4ncYmOjqPyoSwOOaEvqKa13dYlWdGVci
         ydsD5poTzRl7AMbZnkN2EhjNDT9+Tn+hsgnlwDne7NPUM/8w1FxORMcRrWzXq5b5QS6A
         h60fWFgvdcEV2b8DRLtqf5CuQ9lymtr2YJiVYJuM2CTR+gRLExeR1wT+W01P6PMS7d3U
         TbttXLhIxV/eOPRM8v9MX1djCtdKFaaBHjlTaGZIXD9giWYTsyeZRNJ/3U2zYW7R8mf9
         8YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xAVNYoiuQrBWAz3Wo+k/zvFJLUkV5jlSsvAv3GlPnc=;
        b=VidZtrkGIJLpuxcBZ4pbL8YwSjUTfW3eHP3e0L8BOl2mBEFdNK7rik6tdQzHQLnJiE
         2yhp6Us53Rv1YE9tmLCpZ881AlBahMSpcdImG6RFkeaKG6+CGffUJaR5tRS6+T65ZrUE
         D4bpZ/2wl2NAH8b/E+NS6UazeRZv2O+84r7q/Xj1azG0t1IMoqeeEt/gRznW873+sYEM
         9QT+DNgErqBsKYegN7HnmtUmLz4REWR3PMsIHgziNWvhcyVDczXo9zNolLjGY9ItaaR7
         mGHtHLrAZCTk0kBOk2s+TMfdofccC99UXwGIWaiq6ZlgcRYCRtsMTS+nVud3vVSLAyjE
         IbyQ==
X-Gm-Message-State: AJcUukf2m6ztq0ZQeNmkDEtdwHX0T8hAu3hb9DODQfzb7hMREPuJBuFM
        1HlRXy3FDZOJdh46EcmlfoHqEmMdtzE=
X-Google-Smtp-Source: ALg8bN7DKws5AahnRHtYZFAgTjtIkMa5BIvaeVl1+Eky2bAM0GuXwq3d2wisenFuucbxe8aZ9cMRsA==
X-Received: by 2002:a1c:8d53:: with SMTP id p80mr8023368wmd.68.1547645415753;
        Wed, 16 Jan 2019 05:30:15 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:12 -0800 (PST)
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
Subject: [PATCH v5 5/9] commit-graph write: show progress for object search
Date:   Wed, 16 Jan 2019 14:29:43 +0100
Message-Id: <20190116132947.26025-6-avarab@gmail.com>
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

Show the percentage progress for the "Finding commits for commit
graph" phase for the common case where we're operating on all packs in
the repository, as "commit-graph write" or "gc" will do.

Before we'd emit on e.g. linux.git with "commit-graph write":

    Finding commits for commit graph: 6529159, done.
    [...]

And now:

    Finding commits for commit graph: 100% (6529159/6529159), done.
    [...]

Since the commit graph only includes those commits that are packed
(via for_each_packed_object(...)) the approximate_object_count()
returns the actual number of objects we're going to process.

Still, it is possible due to a race with "gc" or another process
maintaining packs that the number of objects we're going to process is
lower than what approximate_object_count() reported. In that case we
don't want to stop the progress bar short of 100%. So let's make sure
it snaps to 100% at the end.

The inverse case is also possible and more likely. I.e. that a new
pack has been added between approximate_object_count() and
for_each_packed_object(). In that case the percentage will go beyond
100%, and we'll do nothing to snap it back to 100% at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7653c4e9d6..f0bcb3c690 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -785,12 +785,14 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
 	struct strbuf progress_title = STRBUF_INIT;
+	unsigned long approx_nr_objects;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 32;
+	approx_nr_objects = approximate_object_count();
+	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
@@ -870,8 +872,11 @@ void write_commit_graph(const char *obj_dir,
 	if (!pack_indexes && !commit_hex) {
 		if (report_progress)
 			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"), 0);
+				_("Finding commits for commit graph"),
+				approx_nr_objects);
 		for_each_packed_object(add_packed_commits, &oids, 0);
+		if (oids.progress_done < approx_nr_objects)
+			display_progress(oids.progress, approx_nr_objects);
 		stop_progress(&oids.progress);
 	}
 
-- 
2.20.1.153.gd81d796ee0

