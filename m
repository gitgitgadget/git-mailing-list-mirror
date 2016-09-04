Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653831F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbcIDUTh (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35489 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbcIDUTY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id c133so10466310wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PdIpiKKNbeS8o5MLM5r8i3UEZEwmnY+uY0VJq6SOFgM=;
        b=JV4lUtQaqNrVJRF7JYuxDagH8Mynj1o4pNLrY7/zwOB84RxCVrJ6FEQAKEXrjurY7O
         tmWkSb0Lz0AvTT9+cK+VfMqM5pMO7umXMMzWDkqv8sl3xfo8WPfR4YEd8yQDFDaxJy4m
         /qEUSGSTRDLi+TO9p3YGxygLlo7uQZhwzkC+fcdcGfbU2I7RmdSPu9fCdbeEJU24BSdk
         FONc+8mR/HDNaPLVw1iPTYhanKG++r/NdxnxiceSDpMJrwZHe9hAPnMw2/DWqxzLPLH+
         bZNHq2YSY3MXyBpZA+2IabBIT61y66bZgeosayNUnNsyN5lBP7BsR1BZr1tU/OLPmEWr
         svhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PdIpiKKNbeS8o5MLM5r8i3UEZEwmnY+uY0VJq6SOFgM=;
        b=OyqBAALPtvkD/xDq7SqyPHtu1thYjXRhHie0l8xKvX4pHbYFg+sG24M7bVXeM85H6S
         kn0tRwQyi4givYx7geXvLU1OpJgacTdhEpKFLP3kvIk2WKBLGHTusoz2RVQaz85BfLHo
         TFXh6J/QnnO78mrP2s7B0N22Gb5GpfYZCUpj0I3H6v+S9XxIMm8uvYNh6zlo923SPTVp
         nhsnL93GnYHyqfZZDjEZsuvMxLnJaP3eBltswo+kigQi9Dl4o+mePsmfpz3NAqiRV+k4
         5RFNUzGJMD3faZYJWDhsLzpubddMhjGTVHdczjLZeU+R7BUxWnR+N/QdbN099AHBf0ql
         ubKw==
X-Gm-Message-State: AE9vXwNrl6+mvyG8s20ntf5e5lf3hHARgc0RvDwqoJqxvmqbvkg0EUD1pvBHFBs+fVihQw==
X-Received: by 10.194.235.69 with SMTP id uk5mr27646173wjc.53.1473020357971;
        Sun, 04 Sep 2016 13:19:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 21/41] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date:   Sun,  4 Sep 2016 22:18:13 +0200
Message-Id: <20160904201833.21676-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_conflicted_stages_file() should return -1
instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 27fb6e2..ad0b875 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4224,7 +4224,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4232,7 +4232,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4247,9 +4247,14 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+			free(ce);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
+		}
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4263,9 +4268,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(state, patch);
-	else
+	if (patch->conflicted_threeway) {
+		if (add_conflicted_stages_file(state, patch))
+			exit(128);
+	} else
 		add_index_file(state, path, mode, buf, size);
 }
 
-- 
2.10.0.41.g9df52c3

