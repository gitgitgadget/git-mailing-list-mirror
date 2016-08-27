Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943F42018E
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754910AbcH0SqL (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33450 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754795AbcH0SqF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:05 -0400
Received: by mail-it0-f67.google.com with SMTP id d65so2941834ith.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q7+E+/0jRYKqE2xZ7YAI1VbsZPUlAKzkWB61RcgQGOw=;
        b=uUEJ9e0AtHwQCYIhddj2Z5uHASSPnNc7Qq7YmECPtdx+IDE8oXkdnebItW8EIPf0at
         dj72HoyCSB3AKw7iMAryTgodm6E9BlG1sL85KQl1G56LTHmRA5+1V7t9Yhib0HcTSoog
         fNoOm24+oocvGFuq73Lo9LJhLkJKEADto8jfbKK4MCVEtPxpclRMzt8mt4FVAQ3K5VQF
         pgBqbqHRsPoP6Yd672bMdak9f92iMudWs2M83Nmtu09MSb1jfJtLK9FeJopQP4MPJqTQ
         i6SfEr9BnSugdr83+yUg9ZszTuMlfV4nNUJ2LT3/HXfx2tR/olw1YwTS1lbvUZ4IINXp
         B1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q7+E+/0jRYKqE2xZ7YAI1VbsZPUlAKzkWB61RcgQGOw=;
        b=Ti8QsYYbbxGx+p+PzIzYTpLAi9kNYmV1D1AzjZJrgMzO6GPin6xTmbgGrDR47Ho4aI
         yPBhT0B63XKeOveHv5PJewJLZCfKcs8jlF9dXyBTMGUseMpY/ChVV8XfFz2QnkxH2YoN
         XxzmtFOrW1sSgypfcnYK/J7IT8bCDu/xEUrEGAFajnT8QUcMyCBL4cclZXlfBM0xDBgx
         RRMvMUfRDhibhqVgzTZHBoXxD38og/xBkS5jlOeml9+uEg7tdkm+UjY8k4rRQVUKuqYJ
         fHWxtZVwGuGqE19oHLgmybDMxi88hnaiLJff4nAo7L53+cQ7Ww72XiGasccDXn4bkwKn
         3uqw==
X-Gm-Message-State: AE9vXwOA5BQ4mt/6HvkESfX1lKZcYQEU6sM2M/pZwbQA9/VjobdNgQJ02o+fthaYHnOgCw==
X-Received: by 10.36.103.214 with SMTP id u205mr5770434itc.88.1472323564605;
        Sat, 27 Aug 2016 11:46:04 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:04 -0700 (PDT)
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
Subject: [PATCH v13 05/14] apply: use error_errno() where possible
Date:   Sat, 27 Aug 2016 20:45:38 +0200
Message-Id: <20160827184547.4365-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid possible mistakes and to uniformly show the errno
related messages, let's use error_errno() where possible.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index c0cb3f5..41a33d3 100644
--- a/apply.c
+++ b/apply.c
@@ -3497,7 +3497,7 @@ static int load_current(struct apply_state *state,
 	ce = active_cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
-			return error(_("%s: %s"), name, strerror(errno));
+			return error_errno("%s", name);
 		if (checkout_target(&the_index, ce, &st))
 			return -1;
 	}
@@ -3647,7 +3647,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
-			return error(_("%s: %s"), old_name, strerror(errno));
+			return error_errno("%s", old_name);
 	}
 
 	if (state->check_index && !previous) {
@@ -3669,7 +3669,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
 			goto is_new;
-		return error(_("%s: %s"), old_name, strerror(errno));
+		return error_errno("%s", old_name);
 	}
 
 	if (!state->cached && !previous)
@@ -3728,7 +3728,7 @@ static int check_to_create(struct apply_state *state,
 
 		return EXISTS_IN_WORKTREE;
 	} else if ((errno != ENOENT) && (errno != ENOTDIR)) {
-		return error("%s: %s", new_name, strerror(errno));
+		return error_errno("%s", new_name);
 	}
 	return 0;
 }
@@ -4247,9 +4247,9 @@ static int add_index_file(struct apply_state *state,
 		if (!state->cached) {
 			if (lstat(path, &st) < 0) {
 				free(ce);
-				return error(_("unable to stat newly "
-					       "created file '%s': %s"),
-					     path, strerror(errno));
+				return error_errno(_("unable to stat newly "
+						     "created file '%s'"),
+						   path);
 			}
 			fill_stat_cache_info(ce, &st);
 		}
@@ -4306,7 +4306,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0 && !res)
-		return error(_("closing file '%s': %s"), path, strerror(errno));
+		return error_errno(_("closing file '%s'"), path);
 
 	return res ? -1 : 0;
 }
@@ -4503,7 +4503,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
+		return error_errno(_("cannot open %s"), namebuf);
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
-- 
2.9.2.770.g14ff7d2

