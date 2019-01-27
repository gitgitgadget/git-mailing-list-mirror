Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD2F1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfA0Ag3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41887 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0Ag3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so5681161pgq.8
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YeSH4y/rrZaM33uY2V0zkhcm8GCLbDmbmDsbun8+r0=;
        b=uAJTWjl+ISBJRc1yjklNjH+EmLOBpJznAAqnU4mqwgtJrOnhwVRkqhtjKvKPX54MPg
         K69f5qnzQb1wwe8xdpWeBEhwj/mQ3DXggn7TJ/Q2e4AOcrgphgTmhVY3iLYufgC4Twjx
         xnS4B1O67M2FN4cBQqk1vGeoam76SFpj/QaF/ZnUx/7T+na66QRNO4H3Qfam64+NactR
         C4C2NrJXCSC+5Wju6Aw19F2DmlFFb7YJfnffMPXlxLBuWfRGYvlwNFWdv9Nsbkt+jsUa
         LqkjbVbbDIT30pi01+p+Vq4ZxmL7DtwC6kuKYP1Y6onq8dMQEDRXU5tH3FkoXGRi6OPg
         BJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YeSH4y/rrZaM33uY2V0zkhcm8GCLbDmbmDsbun8+r0=;
        b=ix//WdaxkpYsf/tFXYHwWglHBfo5tT/yfncWDugqy4QJ1Fr0pCIUZtbjp7Ga0mdPaf
         sDltqpkw9Tj4NBN8beRQVehE4n0Hf7mA9HwM/5FSLAmo3OSbTke+3Iqq0rr0/0Itdmoh
         Q/4yB67pLpMKX6Bs4/DgpMmi+T9/pcNqLnfMT5JszxqykHqDol5JgeHYJRmBlJehLPdK
         pwvP97h4+jxFtD+YUgqhOydMcQuAYF+8NVnGSgMK0uq2mqmHUi4HfdnVRgQo82g/9yVn
         Qrni9R+gXB2CzwXYA4PvHNEEPwk2/7yK5EBEgZQuZi5Kb23ihXcre0Bxfd3wMIXOzbrN
         HK8A==
X-Gm-Message-State: AJcUukebCYrSmXH89iSjkJN638zu190bRMdp2gD0N/9+vvI8oNLkgl/D
        jm1A+4aNx4/GYykx6wREP8bk8As8
X-Google-Smtp-Source: ALg8bN4dlY9kb3Rzk+6gebTcJ/KqTLplbOR7308+yxsK7jwhIFd/ixPzfjblwa2yTVsGGSYKnktEOg==
X-Received: by 2002:a62:8add:: with SMTP id o90mr16482119pfk.210.1548549388331;
        Sat, 26 Jan 2019 16:36:28 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e123sm47778968pgc.58.2019.01.26.16.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/14] parse-options: stop abusing 'callback' for lowlevel callbacks
Date:   Sun, 27 Jan 2019 07:35:26 +0700
Message-Id: <20190127003535.28341-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lowlevel callbacks have different function signatures. Add a new field
in 'struct option' with the right type for lowlevel callbacks.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c        |  2 +-
 builtin/merge.c        |  2 +-
 builtin/update-index.c | 11 ++++++-----
 parse-options-cb.c     |  3 ++-
 parse-options.c        | 15 ++++++++++++++-
 parse-options.h        | 12 ++++++++----
 6 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6d798f9939..8dcc55dffa 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -814,7 +814,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 * and are only included here to get included in the "-h"
 		 * output:
 		 */
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
+		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental heuristic to improve diffs"), PARSE_OPT_NOARG, NULL, 0, parse_opt_unknown_cb },
 
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
diff --git a/builtin/merge.c b/builtin/merge.c
index dc0b7cc521..07839b0bb8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -261,7 +261,7 @@ static struct option builtin_merge_options[] = {
 		option_parse_message),
 	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
 		N_("read message from file"), PARSE_OPT_NONEG,
-		(parse_opt_cb *) option_read_message },
+		NULL, 0, option_read_message },
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e19da77edc..727a8118b8 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -985,7 +985,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("add the specified entry to the index"),
 			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
-			(parse_opt_cb *) cacheinfo_callback},
+			NULL, 0,
+			cacheinfo_callback},
 		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
 			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG,
@@ -1011,19 +1012,19 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &read_from_stdin, NULL,
 			N_("read list of paths to be updated from standard input"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			(parse_opt_cb *) stdin_callback},
+			NULL, 0, stdin_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &nul_term_line, NULL,
 			N_("add entries from standard input to the index"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			(parse_opt_cb *) stdin_cacheinfo_callback},
+			NULL, 0, stdin_cacheinfo_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &has_errors, NULL,
 			N_("repopulate stages #2 and #3 for the listed paths"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			(parse_opt_cb *) unresolve_callback},
+			NULL, 0, unresolve_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 'g', "again", &has_errors, NULL,
 			N_("only update entries that differ from HEAD"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			(parse_opt_cb *) reupdate_callback},
+			NULL, 0, reupdate_callback},
 		OPT_BIT(0, "ignore-missing", &refresh_args.flags,
 			N_("ignore files missing from worktree"),
 			REFRESH_IGNORE_MISSING),
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e2f3eaed07..e05bcea809 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -170,7 +170,8 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
  * "-h" output even if it's not being handled directly by
  * parse_options().
  */
-int parse_opt_unknown_cb(const struct option *opt, const char *arg, int unset)
+int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
+			 const struct option *opt, int unset)
 {
 	return -2;
 }
diff --git a/parse-options.c b/parse-options.c
index 62d94ca2e0..37a56d079a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -93,7 +93,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
-		return (*(parse_opt_ll_cb *)opt->callback)(p, opt, unset);
+		return opt->ll_callback(p, opt, unset);
 
 	case OPTION_BIT:
 		if (unset)
@@ -408,6 +408,19 @@ static void parse_options_check(const struct option *opts)
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
 				err |= optbug(opts, "should not accept an argument");
+			break;
+		case OPTION_CALLBACK:
+			if (!opts->callback)
+				BUG("OPTION_CALLBACK needs a callback");
+			if (opts->ll_callback)
+				BUG("OPTION_CALLBACK needs no ll_callback");
+			break;
+		case OPTION_LOWLEVEL_CALLBACK:
+			if (!opts->ll_callback)
+				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
+			if (opts->callback)
+				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
+			break;
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
diff --git a/parse-options.h b/parse-options.h
index c97324f576..f1f246387c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -100,13 +100,16 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *			 the option takes optional argument.
  *
  * `callback`::
- *   pointer to the callback to use for OPTION_CALLBACK or
- *   OPTION_LOWLEVEL_CALLBACK.
+ *   pointer to the callback to use for OPTION_CALLBACK
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
  *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
  *   CALLBACKS can use it like they want.
+ *
+ * `ll_callback`::
+ *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
+ *
  */
 struct option {
 	enum parse_opt_type type;
@@ -119,6 +122,7 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+	parse_opt_ll_cb *ll_callback;
 	intptr_t extra;
 };
 
@@ -137,7 +141,7 @@ struct option {
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
 					    PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, \
-					    (set), (clear) }
+					    (set), NULL, (clear) }
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
@@ -263,7 +267,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
-int parse_opt_unknown_cb(const struct option *, const char *, int);
+int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 
-- 
2.20.1.560.g70ca8b83ee

