Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08E51F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeKUGVd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54179 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeKUGVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so67069wmi.3
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0pOw61XeH3TwdSCCELAuqFQL7BRaBHhJP9x+Pydiyc=;
        b=S84feLwiWxe2k2Nch/0Trbm8MQw/2kxPfFxmgK6E6z8E4KSPxgAufZBSa/xkZZTkDk
         2jhTUF/cJ+FrQMNeZ0l7+5Zpuduo2Md7YW3li9x4Kg03Y9y+ZRVkyE9/FrK15Pyni+XY
         XoymELUyAH5YeaXP8blcPAVP74fVm4hm8QQsq1yvGHnkAnDsOeBFQpm5CUQHtLFdIfJ5
         Dv/jTIVi9k9R37g3SyfloRZ+ao1Un95lynEvXJ4Y/yC1epDjcLXmiNfI3BgudhXzcayi
         +7DPaJjXcFRHaaXiRdv0RROxnHLYfHOLWpNphw8nte1OL/H6BPXtycXui/triwJ6dBqC
         XvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0pOw61XeH3TwdSCCELAuqFQL7BRaBHhJP9x+Pydiyc=;
        b=YJFV9KuCkBsCEc3Fsq5d3BLJrGUmBmheWdZWsY+VF2/bZxXJ02lWsOcbS9b4FYnlY/
         R5Ps12Vss2fZjLQ/5ydNdjDmkcBRxrJReMpGf+VIBLZKve/3F0OHWnzX9xMsZ1d1oejJ
         B4AAWxfHUovJCmcvEP+AVHQjiibxW8A3Wct49pNEzrldXyixq7PwrY+LZTICm7Ix1xdr
         0i0SekAmCBKc5Q0q7h5r0o7Fh3CSfWIfdB1fMtRRSSRPZtR9iiwnWmfXG30imlhqlODW
         oxCcKC+Hs7m6edv3gZaO+bYGaDZEBocX7SWMY+50Gw7aQJDAwWzkyb87Rm7VrYeyIeQt
         V4RQ==
X-Gm-Message-State: AGRZ1gLiDt8+4JL9f6XH97Iv75IvnBUh9gXSZh5CyS3qYcH5kmcR1pSQ
        Xzbj2R+qTWODW151/8PSJCfS4+dw0Mk=
X-Google-Smtp-Source: AJdET5fZKzJmnn4qma/1kOIaGBnlh0o8kRMwd82S+X5mxZ5yIYE6HqieySM4M3Y0fDFPcvT65GtWpQ==
X-Received: by 2002:a7b:c003:: with SMTP id c3-v6mr3077410wmb.133.1542743442021;
        Tue, 20 Nov 2018 11:50:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:41 -0800 (PST)
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
Subject: [PATCH v2 3/6] commit-graph write: show progress for object search
Date:   Tue, 20 Nov 2018 19:50:24 +0000
Message-Id: <20181120195027.3260-4-avarab@gmail.com>
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
index 6f6409b292..7c1afa4704 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -778,12 +778,14 @@ void write_commit_graph(const char *obj_dir,
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
+	unsigned long approx_nr_objects;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 32;
+	approx_nr_objects = approximate_object_count();
+	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
@@ -863,8 +865,11 @@ void write_commit_graph(const char *obj_dir,
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

