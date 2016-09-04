Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4BA920193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbcIDUTG (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33990 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbcIDUTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id w12so958844wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uI6sCXEkVSbmKDtfECQBUgVl3sBaL63WMT9ZnZuZ8cg=;
        b=veS6Q+qoWnrqgNBw/+FRS7kZKVp78M5f52DnymoMBP6Hh0BSBnvd85V9Yfdl+N613L
         jBhnUFAr0d3alRxg8UvfCHihNMKpF7aqRLLb8qICMHBCiSbFNSzEFSUpLo4Xol9xiNNS
         DkRZUas6hV7+23NjSLuIccUCdSCjt37S1O3097dp0opc0kbXgjbqouAT2NeRQiOG/iU+
         aLb0mXNMU8KU5hZfeVbao6sGSULuE3ggyamiE3VvMA6r//nYEjKLBLDxuHj/uvANuWol
         B9noppVwjc2G2z8bTbT4qMc+xz2ie4xLXQIw+s9CsSvLgHuAb47QRXmVzyeQ5Aw/VPq9
         MLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uI6sCXEkVSbmKDtfECQBUgVl3sBaL63WMT9ZnZuZ8cg=;
        b=i4QLPQ1bP8Y7vx7IHxtyCXoGzre/VkVCVfH8Z/s+muRTGnOHbkabRAIXNIPBINinjM
         57CWCrxJa+5b7uGYNY6jQCyPsc5ErHZygEFtA+UZ6U+XHpArkAQbfQv4UzCoLFIo66e2
         +Q7SE6Flz7nPqAYWa16AJjbVGjaHzwAcLhlbhifDOrKtaTKJ7LJ8mjLrVGTQmMKRNMya
         Xo711NOii6jdMQ2YSeBlnYPiHL/oBKwwr0j13+O9nbjMcQwZT4O/cL0v79CX4xzIztMV
         E0sFZU6TsGV/rdkZYf4tgtQoun8Vy4UJh0ZnbAv41fE0ZvST9WuEjPaon0OCFUQHMf9+
         9TAQ==
X-Gm-Message-State: AE9vXwM4/CvfRM+iZbpDOZivEw5Y3MdCoVCqGuBcdeCoBJ0VftLlhWOsrmNVaST2TAd0VQ==
X-Received: by 10.194.239.196 with SMTP id vu4mr16316115wjc.124.1473020342540;
        Sun, 04 Sep 2016 13:19:02 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:01 -0700 (PDT)
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
Subject: [PATCH v14 12/41] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date:   Sun,  4 Sep 2016 22:18:04 +0200
Message-Id: <20160904201833.21676-13-chriscool@tuxfamily.org>
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
in "builtin/apply.c", check_apply_state() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 61fd316..bb89e07 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4551,17 +4551,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4569,16 +4569,18 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 	if (!state->lock_file)
-		die("BUG: state->lock_file should not be NULL");
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4747,7 +4749,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(128);
 
 	ret = apply_all_patches(&state, argc, argv, options);
 
-- 
2.10.0.41.g9df52c3

