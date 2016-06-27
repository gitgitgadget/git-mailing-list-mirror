Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417702018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcF0SZK (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35351 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcF0SZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id a66so26929074wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GZ+rFlOkyypoMhX2mpbNxMMI7TKrjYF4xVv5ptIM8QQ=;
        b=lco2mCrsji/Nr2i3SACNJmfpaMpwtwPzSx+34z9kKN4IBsx6WOLK5rzRS5A+5AGn+m
         FCMZRtfUhRpt0p2l9UuerL8FnvD3nTQfFivOxoQqPFcu4j8uiXjsegYeSlzBvjb+Fobv
         19lwhVcuWgaLODOXeO7mQbNpWX6B02Puy6QW/PdFG3BOEzOq/cQwE6MTOyRueNi3lyHq
         /rt7VZq2gXeCLLrGDwRg7M2wbWovCu697Tjvdh3oPLV3nJzj1udvQbtC10lNhqLCJfrt
         a7+Mldq8XxrRKkefeqAf196lqEeU83AQDabFhGjQG+uIJR0p+xT9C43Gf2a8BJREgB0w
         kQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GZ+rFlOkyypoMhX2mpbNxMMI7TKrjYF4xVv5ptIM8QQ=;
        b=O44zmVQpw5vxiusWauf7mpMjsDZKFFuL46+Dgv32GuHmnnV4axmUiD8cSSI/P8JesH
         5KhCVuREiqnmhm06qPZgKv5k+kZJi08MwesGgzOJHwCVwcXFXnVGtQwI3hxNRSV/QzLR
         ks1LUwLHQgtJQUBwNpb14JbQrgIo80gVMWKiwb7XnQqO2R2/Op7F4CEnR3sDiSnxfdcW
         6UJKiDPVuNagaCjlNFrSD8j6G5dhTYPnVvzqCpCRmBWZKcOqrgQVvlsqe2AAQ47lxImB
         HvKutIH2Iaa+fnKH4xPebtrBMq9a6sADwwhGam1Xn6HiQjGc3hQ8K359SclbyTxy86MA
         2oDA==
X-Gm-Message-State: ALyK8tJ8PchtEQEkcDtK+n70/FvM7G/CmvlUpjBLL0rty79MoTRe4tS4daCkn5ttzOAAmw==
X-Received: by 10.194.89.138 with SMTP id bo10mr2145015wjb.122.1467051907162;
        Mon, 27 Jun 2016 11:25:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:06 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 12/41] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date:	Mon, 27 Jun 2016 20:24:00 +0200
Message-Id: <20160627182429.31550-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 2a4a9d1..955e94a 100644
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
2.9.0.172.gfb57a78

