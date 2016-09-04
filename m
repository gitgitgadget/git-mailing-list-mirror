Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975A120193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbcIDUTz (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36293 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932271AbcIDUT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id l65so2666862wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fbCuNngN5jtxZnpI0/QQ58mHFBwT3UMwRpDlsnif7EI=;
        b=uakmvrdTv9AAROYQsagHECW/lepggoOMBqkREN1wRoVerOW2oA9YDDEcVIattr+lt0
         2kbUVJyqzWd6V149uBqWpb8AA3Y+K7IJ6BLLaTBuK8ofUBzOn5BBvM103bSCWhkbmZ34
         O/8pIW+3R+lL1uVbu4dm6nkVnpximgDI8ugZKQKD9SN6MfT7mIevS3SOU8B+b5hg78tc
         +RY7Kob1VvnVHxHk190BA/URAUbcC5Oa36sv0IPvOVHrMpMdvrUlfsbCnkrODEdz6ZhL
         uOMUUwkqOvKpo9Fk1TntpnU3RPEaUq78KtLUR8a5coqRciO95lugNhW3FuEArNP65PyK
         kFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fbCuNngN5jtxZnpI0/QQ58mHFBwT3UMwRpDlsnif7EI=;
        b=dZ8+QpeS0VsKIxGmSktZ6MoCWlwVIk6ahU1hV9ynrbZdYJR7fFlQ/fw/xdU+41mV8O
         FEtEDKMFyD6RE5fcwpUcCVicuhbjIE7QleFogQnO/0mnFXN+Ipazy25TBHstf7Kzbl1J
         wx7SilL97DZE37boYzjuIlVDqjf36tTrg7aJNrV+Tq4d9zvJc9VWG/kPeZR7DUpFkT6X
         zVTyenzdxseQ9FhMChri9klLOTGgXHForKTsmIE2/PbNA/JI9qyJB0H0V6GL8EAz7hN5
         w0gd2iDBDYsqa8WuieCoEM5qrk7ucsOZpUkXVWRecxbeqcRY1uBRSk5vXDGXOphiuss0
         6jNA==
X-Gm-Message-State: AE9vXwP7530sWlP9rBaoW2fsWaD/78Qj1dLxVcPLXLeeaIk1+VvEDrAu38XsP+0rXr8GCA==
X-Received: by 10.28.22.6 with SMTP id 6mr12571515wmw.55.1473020367822;
        Sun, 04 Sep 2016 13:19:27 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:26 -0700 (PDT)
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
Subject: [PATCH v14 28/41] builtin/apply: rename option parsing functions
Date:   Sun,  4 Sep 2016 22:18:20 +0200
Message-Id: <20160904201833.21676-29-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As these functions are going to be part of the libified
apply API, let's give them a name that is more specific
to the apply API.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5cd7fd8..1f56303 100644
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
2.10.0.41.g9df52c3

