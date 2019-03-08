Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFFF20248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCHKR3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36060 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCHKR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so13831544pfa.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPcyt3ATNNs6Zbx3l64JaMumtK7vxUYyn01vhtDpGds=;
        b=uvMIDxFvngg6D39US1tGYdPd+64x2qyy6GJLdKkJVHlsNDTXNJAcC3ayYv/oB54R9g
         +1PfpZBCEar2Bmu8yTOHbqbvVTLTTRi1CkpbFoFwYKTLu3BvyuMpgals4EBjtpT07wTR
         RSAo9yiefZLCyGYnYOy1sbs0RRuOyQjG0GYVCzu3n33Rn8o1Tok7VKvTWJpPa9wzCD7q
         NAZN5eIT76jE1MzO+pkxx+Az2rPnq0GH1qVSQR3eYeHRz/LxK6FNlQVLcqsgK7tpyfCR
         koYY3kI3dleN5EKzVTpB4v0Y2J8YXyQVioIzQAgfvRhMDd8xjcYGKSb7KVyqRXUlEcaa
         0Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPcyt3ATNNs6Zbx3l64JaMumtK7vxUYyn01vhtDpGds=;
        b=pbrSp5LnMu3xx2AhYG+wzGU2jZsPINFWMyYbC05ogcJz8XI8ASe4VW6NykwCfEvbtI
         Wd9fffqeyBusvofE6c578eVmlypYyi2m8RNqeigYdC88PzcUP62wu84tSbnGP9XtyQAJ
         4ZhXdsIeeGAl1/HI9pXIvCTrArT9mPoW0viJs25K4DqJGeGNEMbiXQLAV03LO3YwTzid
         X6x01PYeSkYn7zxQWN+pRM5PlJng6gs3rYNPrbU/S7Ilzp7Nqy3wAO2nPLWvxkqsmvXM
         bCx8VguSzbnSW6Qjq8ZTABvi4xAM4fWv6m885it5Wb3XcjSheJ71Vc9u4SfBbbRp9/al
         u5uQ==
X-Gm-Message-State: APjAAAUNfv3qXPtQ6nEPjtKym8YtYh6u+z6+J4QNKPxVu/FDWBkI736H
        cyvFVHsyZiozaamVFzH9JkiZ0uA4
X-Google-Smtp-Source: APXvYqyKM1fYnOTqauTm+Nr8ramjkbdh2Z+pFpz483qP2xZH7ovyqG2sF2SO3W+rNzbCs885PDmM4Q==
X-Received: by 2002:aa7:90c7:: with SMTP id k7mr17500827pfk.186.1552040247831;
        Fri, 08 Mar 2019 02:17:27 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id q86sm24501018pfi.171.2019.03.08.02.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 05/11] checkout: factor out worktree checkout code
Date:   Fri,  8 Mar 2019 17:16:49 +0700
Message-Id: <20190308101655.9767-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 108 +++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9e59bf792f..5fb85e7b73 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -326,17 +326,73 @@ static void mark_ce_for_checkout_no_overlay(struct cache_entry *ce,
 	}
 }
 
+static int checkout_worktree(const struct checkout_opts *opts)
+{
+	struct checkout state = CHECKOUT_INIT;
+	int nr_checkouts = 0, nr_unmerged = 0;
+	int errs = 0;
+	int pos;
+
+	state.force = 1;
+	state.refresh_cache = 1;
+	state.istate = &the_index;
+
+	enable_delayed_checkout(&state);
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+		if (ce->ce_flags & CE_MATCHED) {
+			if (!ce_stage(ce)) {
+				errs |= checkout_entry(ce, &state,
+						       NULL, &nr_checkouts);
+				continue;
+			}
+			if (opts->writeout_stage)
+				errs |= checkout_stage(opts->writeout_stage,
+						       ce, pos,
+						       &state,
+						       &nr_checkouts, opts->overlay_mode);
+			else if (opts->merge)
+				errs |= checkout_merged(pos, &state,
+							&nr_unmerged);
+			pos = skip_same_name(ce, pos) - 1;
+		}
+	}
+	remove_marked_cache_entries(&the_index, 1);
+	remove_scheduled_dirs();
+	errs |= finish_delayed_checkout(&state, &nr_checkouts);
+
+	if (opts->count_checkout_paths) {
+		if (nr_unmerged)
+			fprintf_ln(stderr, Q_("Recreated %d merge conflict",
+					      "Recreated %d merge conflicts",
+					      nr_unmerged),
+				   nr_unmerged);
+		if (opts->source_tree)
+			fprintf_ln(stderr, Q_("Updated %d path from %s",
+					      "Updated %d paths from %s",
+					      nr_checkouts),
+				   nr_checkouts,
+				   find_unique_abbrev(&opts->source_tree->object.oid,
+						      DEFAULT_ABBREV));
+		else if (!nr_unmerged || nr_checkouts)
+			fprintf_ln(stderr, Q_("Updated %d path from the index",
+					      "Updated %d paths from the index",
+					      nr_checkouts),
+				   nr_checkouts);
+	}
+
+	return errs;
+}
+
 static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
 	int pos;
-	struct checkout state = CHECKOUT_INIT;
 	static char *ps_matched;
 	struct object_id rev;
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
-	int nr_checkouts = 0, nr_unmerged = 0;
 
 	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
 
@@ -422,53 +478,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return 1;
 
 	/* Now we are committed to check them out */
-	state.force = 1;
-	state.refresh_cache = 1;
-	state.istate = &the_index;
-
-	enable_delayed_checkout(&state);
-	for (pos = 0; pos < active_nr; pos++) {
-		struct cache_entry *ce = active_cache[pos];
-		if (ce->ce_flags & CE_MATCHED) {
-			if (!ce_stage(ce)) {
-				errs |= checkout_entry(ce, &state,
-						       NULL, &nr_checkouts);
-				continue;
-			}
-			if (opts->writeout_stage)
-				errs |= checkout_stage(opts->writeout_stage,
-						       ce, pos,
-						       &state,
-						       &nr_checkouts, opts->overlay_mode);
-			else if (opts->merge)
-				errs |= checkout_merged(pos, &state,
-							&nr_unmerged);
-			pos = skip_same_name(ce, pos) - 1;
-		}
-	}
-	remove_marked_cache_entries(&the_index, 1);
-	remove_scheduled_dirs();
-	errs |= finish_delayed_checkout(&state, &nr_checkouts);
-
-	if (opts->count_checkout_paths) {
-		if (nr_unmerged)
-			fprintf_ln(stderr, Q_("Recreated %d merge conflict",
-					      "Recreated %d merge conflicts",
-					      nr_unmerged),
-				   nr_unmerged);
-		if (opts->source_tree)
-			fprintf_ln(stderr, Q_("Updated %d path from %s",
-					      "Updated %d paths from %s",
-					      nr_checkouts),
-				   nr_checkouts,
-				   find_unique_abbrev(&opts->source_tree->object.oid,
-						      DEFAULT_ABBREV));
-		else if (!nr_unmerged || nr_checkouts)
-			fprintf_ln(stderr, Q_("Updated %d path from the index",
-					      "Updated %d paths from the index",
-					      nr_checkouts),
-				   nr_checkouts);
-	}
+	errs |= checkout_worktree(opts);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
-- 
2.21.0.rc1.337.gdf7f8d0522

