Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6351F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeIOViZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:25 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35853 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeIOViY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:24 -0400
Received: by mail-lj1-f180.google.com with SMTP id v26-v6so9861321ljj.3
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RreB7C2s0RQRPC2xhjfXHjpJXDvnywzkF4p0gfPUbDQ=;
        b=ZcenQ1Ec5BKNtU4wChLwwcyEhzK7uWKskYtEoi61wxuAyPrCdyWMhFy6wTvrWmiosw
         azXRO1PX0jRxMxuvb9T52ChvZb4Do6pt1wiouqOlxT+noSEo5szeojwqXzWh1OJXaK1a
         SDzhVnMiCltQjjSXn4qR/hABv6mgKoTfar3M3C8drcajRa4gOdNZ3yr9/yEMX3zGuZje
         0be/en3KDH4bNMax+v7WCKZglxx4ki4jRTDicKRyncRelhFocJpyh7LwjHxHnVqRavi4
         +D6vIqn7w1F04oTo8OiZpGfe+5heKDvcZ61AD6YTpfxlz8fflizHZ53jKO1VDZcMndn5
         hV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RreB7C2s0RQRPC2xhjfXHjpJXDvnywzkF4p0gfPUbDQ=;
        b=XcXnu8bcB729FIoFj7blEVUQu+URgT9clfKafuE+rmV4nFcV6M9fsofm7Ktf37XKd1
         ieJKeFXbgNo5w9sf+vsyWIM1kEgb9Hndin3XMaqyCO8uDmN3beWWvQ7jPFHpPCGYJE9O
         ntaM1/qEiglyc+edhhdnGeGV9q9VzRuoADy/KylpGKl8sJVKfY0KWRFhPGK6cxh8iwDN
         j46YaRodGxvA/pX+JtjYVxJl9fs/KnYkjV5MjEFlrSjJSEbm0wkpBaPNy/Tt5FyAIFhS
         KGXovRUjuQGd+W3+1u94YmBiQp9pByB58wjmQYziTxJKJJJxAYVY/Q9cNvu7DsRJf0ha
         hMKA==
X-Gm-Message-State: APzg51D+kTlFKvdrqfIUiNjAdBy+4fekZP0/Mhjo5NiJpohBQJMGKkCR
        HZwWARWK+yHpLIbqcCKyP/Cr4SYo
X-Google-Smtp-Source: ANB0VdZHRRhpIlxFzY0T260sWXcaRsOy4VUkCjD90v+tWYdV4k4Ds3ROo1iSLXhOSTF9vRYMLEJSNw==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr10709855ljf.67.1537028333420;
        Sat, 15 Sep 2018 09:18:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 14/23] patch-ids.c: remove implicit dependency on the_index
Date:   Sat, 15 Sep 2018 18:17:50 +0200
Message-Id: <20180915161759.8272-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c | 2 +-
 patch-ids.c   | 4 ++--
 patch-ids.h   | 3 ++-
 revision.c    | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4b602236d6..978fe7c10f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -914,7 +914,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
 
-	init_patch_ids(ids);
+	init_patch_ids(the_repository, ids);
 
 	/* given a range a..b get all patch ids for b..a */
 	init_revisions(&check_rev, rev->prefix);
diff --git a/patch-ids.c b/patch-ids.c
index 342950c79d..7da86047d9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -56,10 +56,10 @@ static int patch_id_cmp(const void *cmpfn_data,
 	return oidcmp(&a->patch_id, &b->patch_id);
 }
 
-int init_patch_ids(struct patch_ids *ids)
+int init_patch_ids(struct repository *r, struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	repo_diff_setup(the_repository, &ids->diffopts);
+	repo_diff_setup(r, &ids->diffopts);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/patch-ids.h b/patch-ids.h
index 79ac9a8498..82a12b66f8 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -6,6 +6,7 @@
 
 struct commit;
 struct object_id;
+struct repository;
 
 struct patch_id {
 	struct hashmap_entry ent;
@@ -20,7 +21,7 @@ struct patch_ids {
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int);
-int init_patch_ids(struct patch_ids *);
+int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/revision.c b/revision.c
index 0c6dc8c163..d70587678c 100644
--- a/revision.c
+++ b/revision.c
@@ -877,7 +877,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		return;
 
 	left_first = left_count < right_count;
-	init_patch_ids(&ids);
+	init_patch_ids(the_repository, &ids);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
 
 	/* Compute patch-ids for one side */
-- 
2.19.0.rc0.337.ge906d732e7

