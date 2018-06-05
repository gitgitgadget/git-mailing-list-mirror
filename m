Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10B11F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFEPnr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:43:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42783 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFEPnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so4320908lfa.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thQbJXqpuFNPW8DoFZHV2AIjxHE6jl1KheAP1i8O9Ds=;
        b=L+W1h0915yWmT8oIYet7E8aMjnqWSFKssJqN611Tg33tsO5HHi67T0nijn0k+EcVTQ
         C5HMcs/Cu077wvaOlvsHFEQpyGKg+lL+rtqUIB4WLkahejND9IWGt07Ha7F0xvI/XdDB
         myLAmEcVZkCv1N39feUDmDQxOlk/8tWDlAVZyQpaJIrCZzmGf4ehwWDTtxUdBRyACb08
         ZuZIn2pN1K3bU6fomJm5Z5PpI2Vtc2T7MnGW5VhuLKhdb2ngnplMWrkBPjBYn4RPD4bb
         Po+0vj1bY2LHoy35TEhhk2uPAxEBxNhvLuFTUbKNu0Fls9mAhojtPBEgqVt+lrSKH43l
         +R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thQbJXqpuFNPW8DoFZHV2AIjxHE6jl1KheAP1i8O9Ds=;
        b=ZftTEW+8ELt+jLuWuzL0smhMImPx7eCjFOAWqPC+V0UYo0JPKJQJZ9hRcScSa663um
         9zsSpHs1gtaXnS1WVivnnlM3+9MeZPFzr8SZgYUNPFFt1CZaeAQj6RtDejVjp5HTVJtw
         ygJADFV+ZBS/TsKjc7ZUsA4tCv2nVHxOvEjoS9KYyVbtUlL+X3Pqjatkmbh+hKCJOxUf
         zM3NPSgy6K99FGEvcz05yxJHKX6EJpep6jqPuOKIOTcEQvf+sv7o2eUeT00tb9jSOMHs
         dXqCCuXmyb3EgbLJpZICJ2ZHWjlxvAg+k4WkIAyFwXsV/115K2b2vwstwC/XfeHBSLGw
         OV2Q==
X-Gm-Message-State: APt69E2Z8joKavwVOP6Km84EhS0GNi4psgWYly2wqG7UcncqgwWKFvif
        21QROKgEe5jZY81ufl1bO4TjYA==
X-Google-Smtp-Source: ADUXVKIyZzHmStQx8o75c/d5VjBwCryHVXG1nVzv45tLbTemrL1IDssbG+5RDbtRsctXIl1neVTeMA==
X-Received: by 2002:a19:4355:: with SMTP id m21-v6mr2061456lfj.121.1528213423788;
        Tue, 05 Jun 2018 08:43:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/6] unpack-trees: don't shadow global var the_index
Date:   Tue,  5 Jun 2018 17:43:31 +0200
Message-Id: <20180605154334.22613-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function mark_new_skip_worktree() has an argument named the_index
which is also the name of a global variable. While they have different
types (the global the_index is not a pointer) mistakes can easily
happen and it's also confusing for readers. Rename the function
argument to something other than the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5d06aa9c98..60d1138e08 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1231,7 +1231,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
 static void mark_new_skip_worktree(struct exclude_list *el,
-				   struct index_state *the_index,
+				   struct index_state *istate,
 				   int select_flag, int skip_wt_flag)
 {
 	int i;
@@ -1240,8 +1240,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 1. Pretend the narrowest worktree: only unmerged entries
 	 * are checked out
 	 */
-	for (i = 0; i < the_index->cache_nr; i++) {
-		struct cache_entry *ce = the_index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
@@ -1256,8 +1256,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(the_index->cache, the_index->cache_nr,
-		       select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
-- 
2.18.0.rc0.333.g22e6ee6cdf

