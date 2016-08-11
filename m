Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A756320193
	for <e@80x24.org>; Thu, 11 Aug 2016 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbcHKSql (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:46:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34572 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbcHKSpp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:45:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so862981wma.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:45:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffzyat2FX5NYXKVfXEpffEimY+OFOGt1GvdHW1WJNuc=;
        b=j3/BWxXhby3iuCkuWB5A7pGrQplwsreszsyzLomYlvG4U9HY+eF39HkcOwKx8a0GNf
         HffsPORMaQ2YWJre92teTNmsAswKJlL1d2Aj64dSxFdgfZX738pCH6PPNs+1D62wRIEk
         MQ+8zT1IKJJK+zxG9pfkk2Nq0TZ9QTZEpbfkLjUXl/sLkikZjHiJL8M48029s1TzZ+gH
         TxdQ08cApm4GQ1+mR9+tRx/hQQgvfU3x0ttdXdUSxnY9hZxDCdKj/6tFCeQIYCqtXGsz
         aEavtf+PLbJDhElH+GYVrYfrTO0uqvTGo7nQXxSVpA5d+p5T1tTXH07Eun5Wj9S0HaY0
         3LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffzyat2FX5NYXKVfXEpffEimY+OFOGt1GvdHW1WJNuc=;
        b=HZoNfBJhudifgsmBmi/QRvtbAEov9zW0vXlitvVDP26mREaaS2Yhc+oJKRRn900fCD
         Q4tJ3Ba+s9K5uwG/4oO91XXNh2Gd9iWxZCFlxU5nS8XAKBRMqhWAq8rrOpACFUn27hNI
         5LlgT6jIWjR1r4GhfG0kvFg69hatYG8MB3IHy2uvtckePjbU/1kZ3AIp2n8Diw1ow+PN
         MvOy9Zjf8OO8+h4wIBtsYY3QxsyZA2xV6w7EiGSeuw6YRNHPEGe4/fy9E2osk2bXdCRa
         ILxCLxusqDQ0NHdpyEKaluvrVU2I7IUnxEJbHUAeFezI38pW4hOHuyhC9BP06ZTbxAch
         oxLQ==
X-Gm-Message-State: AEkooutfbpkIuWkF4L7UzEVAyih3/2eFyra3G9PIH4ogWyyx/EY+ldcWsIeS+Cc43d0mWw==
X-Received: by 10.28.203.136 with SMTP id b130mr10376701wmg.13.1470941144149;
        Thu, 11 Aug 2016 11:45:44 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:45:43 -0700 (PDT)
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
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 01/13] builtin/apply: rename option parsing functions
Date:	Thu, 11 Aug 2016 20:44:49 +0200
Message-Id: <20160811184501.384-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As these functions are going to be part of the libified
apply API, let's give them a name that is more specific
to the apply API.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ad403f8..429fe44 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4588,16 +4588,16 @@ static int apply_patch(struct apply_state *state,
 	return res;
 }
 
-static int option_parse_exclude(const struct option *opt,
-				const char *arg, int unset)
+static int apply_option_parse_exclude(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 1);
 	return 0;
 }
 
-static int option_parse_include(const struct option *opt,
-				const char *arg, int unset)
+static int apply_option_parse_include(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
@@ -4605,9 +4605,9 @@ static int option_parse_include(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_p(const struct option *opt,
-			  const char *arg,
-			  int unset)
+static int apply_option_parse_p(const struct option *opt,
+				const char *arg,
+				int unset)
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
@@ -4615,8 +4615,8 @@ static int option_parse_p(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_space_change(const struct option *opt,
-				     const char *arg, int unset)
+static int apply_option_parse_space_change(const struct option *opt,
+					   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	if (unset)
@@ -4626,8 +4626,8 @@ static int option_parse_space_change(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_whitespace(const struct option *opt,
-				   const char *arg, int unset)
+static int apply_option_parse_whitespace(const struct option *opt,
+					 const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
@@ -4636,8 +4636,8 @@ static int option_parse_whitespace(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_directory(const struct option *opt,
-				  const char *arg, int unset)
+static int apply_option_parse_directory(const struct option *opt,
+					const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	strbuf_reset(&state->root);
@@ -4755,13 +4755,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
-			0, option_parse_exclude },
+			0, apply_option_parse_exclude },
 		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
-			0, option_parse_include },
+			0, apply_option_parse_include },
 		{ OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
-			0, option_parse_p },
+			0, apply_option_parse_p },
 		OPT_BOOL(0, "no-add", &state.no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state.diffstat,
@@ -4793,13 +4793,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
-			0, option_parse_whitespace },
+			0, apply_option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, option_parse_space_change },
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, option_parse_space_change },
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
 		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
@@ -4817,7 +4817,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
-			0, option_parse_directory },
+			0, apply_option_parse_directory },
 		OPT_END()
 	};
 
-- 
2.9.2.769.gc0f0333

