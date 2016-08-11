Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2EC1F859
	for <e@80x24.org>; Thu, 11 Aug 2016 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbcHKIxJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 04:53:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36452 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbcHKIxG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 04:53:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so53719wmf.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 01:53:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XVVhTQGkr0kQ5dH0uGj2mHxYA7uOlaQx1FRAiP1LZAI=;
        b=kDWvae/SqqLTQgnWF1GtIhdZ8o5+8zjRyDRdIuMh28rEzupqvqamqiHtI/ChNAQB5F
         CfIazHftRv+OUi3tYqlGSBbp300nz0sCoYbuXr0JexxXVKHuhgvrRKes5QT8CbDHj4AZ
         JhkjOlD4/zqoOron+PO+zNK4j+RLiLx5BDOfHZd2GGt9M3t4GkQOatL2CZ/zZkL7eikG
         Jug4UCIuOoIiKs2NNJrw+lT/8XQyHdagj/9l317RnFc3wWJlwSCBnNydvKkOIOXW+PRd
         pLyLWA/VDt9bhHG/ctlzegxUgQZ6K4cCEykR8FQi7mp8SU03GDBjbyIJtjaYm1rTgzmQ
         OtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XVVhTQGkr0kQ5dH0uGj2mHxYA7uOlaQx1FRAiP1LZAI=;
        b=elLExjiMj+Q88eHvR1j17Cq19icyk+16CirTUc9BE9oHlRm3UJiJBxn/+xOiMWPcls
         rPyWUUpaVzSAbadSYQIfj4cnLHhn6w/pklMeCIltu/wTH9a1rGLjzKNBauKQIfpcBs9B
         zmktdlnrsi9NMeEcCe2r5RFsuKSynKyDONaprdK4UglL8uRb87QDEKJCsMwbyVXjQ2PY
         a2RhlrQkuzNVLT88GspgDNkyxISoVjH+nuoQkw2Ye1/dfq4V+NnX4rZ6t6VDW6SFwtxX
         Ue+w1M6VPjvZWlYoL5pQScmDN97GHDPFoBk2Am/A9NXgfksyt2Vcpipm32w50I1rXGM2
         Vh3Q==
X-Gm-Message-State: AEkoouvawiksrg6mtIuxg/DB5YIfK5bJmcUtD9u8lojOw+GJOHHc4n0sOlxF8JyL8WxGPA==
X-Received: by 10.194.65.72 with SMTP id v8mr9499459wjs.103.1470905584462;
        Thu, 11 Aug 2016 01:53:04 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 142sm2087544wmh.12.2016.08.11.01.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 01:53:03 -0700 (PDT)
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
Subject: [PATCH v11 28/40] builtin/apply: rename option parsing functions
Date:	Thu, 11 Aug 2016 10:52:53 +0200
Message-Id: <20160811085253.19086-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As these functions are going to be part of the libified
apply api, let's give them a name that is more specific
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
2.9.2.614.g5428e0c

