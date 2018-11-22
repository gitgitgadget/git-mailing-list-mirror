Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EAC1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436862AbeKWAIF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436848AbeKWAIE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so9259852wrt.13
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/xAnDNxiCtlcN8Xo7pDlABad5Y+n5wEiU3JWnre2NY=;
        b=sdFsdHpq260VWDs2GBcqAgh1MDY/+HUEBPFvXmRToy/bk7S0lHMq4zi7YH/np+4XqB
         k1ZSNlwdyQk/Cg+coct3zkxYBoiI5gkXaMiLSdH5G20U5vgk1V+1r1QW98MOrwJZ91Kv
         ZoHV257kI23Rm+Yc/OrDz+kx3Km9J5jZ2YsGBJq/Ec+97QHVlgxmO1i0RqT462Jf4q6R
         Od7u+corIOG2jdjLAQBhgem0AyfxlKek86nistx2VPQWgesCuMyFBQqinFxQDoKHUH8l
         mzTImfxyQHaixKT+x/B3WhK7/1ttcJTwD2dmMpjJoBEIRcVvqlIgIELGSvzgZNFLkgGE
         en2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/xAnDNxiCtlcN8Xo7pDlABad5Y+n5wEiU3JWnre2NY=;
        b=TW9ssiUZ4N2UlroQd66bA1ynrxn9gfCqlXI/KN9bX9EyD93T+BSagt3pl98qcFfGTF
         iapvqvRKXHRJjSCUPMpakrbQCguquJTkt4VnQmOH+gfxmM9IB5MQs4CoxGNrQQgevd3G
         74CZRYeGVHIIaEBFMyJEVOpEr0+0ChWQ+OtzKf0462JTmOFpipQ5YDXPHJn6uorAX95A
         EiVYZil7j8UCxam9sXaNscQMLJs5DYidgOvqneBkAFEqwPtwavFDRRGWQJ6Afmmijsb4
         5cJ8Fm770NB4FlulpjMJOAxqsjrSuFbro0aga3YggNrpyAHTnzsWL+ZHVjymt37ZMtAT
         NJvw==
X-Gm-Message-State: AA+aEWakVQ6I0MCK5JD9ajFxGvHycMt6hBRr6JO8TNmjOQdY8nzNOe0o
        buvNTVQ+YiuTz23tn2pqsYRAR7v3
X-Google-Smtp-Source: AFSGD/Wp8AwLfS9Vl3vu+SOZj07r7WRCyRvtEQeowFqnr75600l7ZJr6Tw8fytnBSp7n9WMbfWA1cg==
X-Received: by 2002:adf:e983:: with SMTP id h3mr6107471wrm.232.1542893321563;
        Thu, 22 Nov 2018 05:28:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:40 -0800 (PST)
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
Subject: [PATCH v3 06/10] commit-graph write: show progress for object search
Date:   Thu, 22 Nov 2018 13:28:19 +0000
Message-Id: <20181122132823.9883-7-avarab@gmail.com>
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

Show the percentage progress for the "Finding commits for commit
graph" phase for the common case where we're operating on all packs in
the repository, as "commit-graph write" or "gc" will do.

Before we'd emit on e.g. linux.git with "commit-graph write":

    Finding commits for commit graph: 6365492, done.
    [...]

And now:

    Finding commits for commit graph: 100% (6365492/6365492), done.
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
index 8e5970f0b9..d6166beb19 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -781,12 +781,14 @@ void write_commit_graph(const char *obj_dir,
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
 
@@ -866,8 +868,11 @@ void write_commit_graph(const char *obj_dir,
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
2.20.0.rc0.387.gc7a69e6b6c

