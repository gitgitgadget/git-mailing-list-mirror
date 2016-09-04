Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E649D20193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbcIDUTH (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32790 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbcIDUTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so10455618wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ph9mmIhN5yqDFPCsgYOWCtS9Xu8LtXYcxnEnuTjJao=;
        b=jpqLKipUWi52ZWmcixujlzHynpnFBkB4nb1YjRWBPLL1ORB4+PLtx+vNkJF1cwg4p+
         C3dKi1LkC+vvqkODhlWn+LS7tZCkQ8F0lhoWr7o1hPASWV948E+yUmQFX+HlOUB6qKuv
         c0JCiRZHG7qGpI1jIgEJoJ12FrcK1O9S+03YcJzWZz0vXw5AJThVhKVE0m4GpjcZb0vF
         nw/XzSNQW18kw3tjG06rHMQLaoaa6H/3a20Fy+DEYdQMw08XGkOrRzRe+4lCadC9D4aj
         S1TfDMETFahTDmYk0byVS+iQkVul8pwStFSE/IHysj4QcGtOHl75ieunfF/gGuA8bx0L
         +2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ph9mmIhN5yqDFPCsgYOWCtS9Xu8LtXYcxnEnuTjJao=;
        b=ZZKQKHn40ka+dDySAk+gn9MoYiYFPUK84EmydEH/QFjGfI3xA3GxTyl5QLhWe5Qj4f
         avobwQU+UU5EzUltg+RcFJ/bQRMFGPlbp6mDgDPo+ql95XdiT3aPcKeCvtSQ7tVgJ3X8
         /qLuoe7nyQQwd33Ol8vuZgjzqpDzqwqhu3iCQQZk6R8BV76gjP0u/zf16I+ygnps/+us
         9a0EYo2rC2g5I//PwFHWpyrMqcj1ST9U5K4M+APDti0hlcHB03tN0VQq3OOr9szxAKuh
         fcx4JQ2xWEiUaUhLVjKbJmd9AVo30bdoM+UR5RNEAGgQMdvmN2YIS1BLyJ4dUHdEVxb2
         qNFw==
X-Gm-Message-State: AE9vXwOhcFES8twPpUu9LiQ9D/qpLiDl47hRsBVhHyFv/gKK0nrsmPdiDI5ptDBr6Um/3w==
X-Received: by 10.194.85.18 with SMTP id d18mr27476384wjz.43.1473020340579;
        Sun, 04 Sep 2016 13:19:00 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:59 -0700 (PDT)
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
Subject: [PATCH v14 11/41] apply: make init_apply_state() return -1 instead of exit()ing
Date:   Sun,  4 Sep 2016 22:18:03 +0200
Message-Id: <20160904201833.21676-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", init_apply_state() should return -1 instead of
calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 11 ++++++-----
 apply.h         |  6 +++---
 builtin/apply.c |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index c858ca4..6e0e992 100644
--- a/apply.c
+++ b/apply.c
@@ -55,9 +55,9 @@ int parse_ignorewhitespace_option(struct apply_state *state,
 	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-void init_apply_state(struct apply_state *state,
-		      const char *prefix,
-		      struct lock_file *lock_file)
+int init_apply_state(struct apply_state *state,
+		     const char *prefix,
+		     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
@@ -79,9 +79,10 @@ void init_apply_state(struct apply_state *state,
 
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
+		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
+		return -1;
+	return 0;
 }
 
 void clear_apply_state(struct apply_state *state)
diff --git a/apply.h b/apply.h
index 08c0a25..e18a18a 100644
--- a/apply.h
+++ b/apply.h
@@ -102,9 +102,9 @@ extern int parse_whitespace_option(struct apply_state *state,
 extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
-extern void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file);
+extern int init_apply_state(struct apply_state *state,
+			    const char *prefix,
+			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index bb6ff77..61fd316 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4741,7 +4741,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix, &lock_file);
+	if (init_apply_state(&state, prefix, &lock_file))
+		exit(128);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.10.0.41.g9df52c3

