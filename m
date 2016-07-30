Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA29D1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbcG3RoT (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:44:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34140 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbcG3RoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:44:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20097816wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:44:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npY22mTRL3RzQKM4rcpOI4mig5zb9lEDKT5AQo828+4=;
        b=sZe/1S9pgg2feVPSAfGWzub7ZUOUxDgUnMxBz+NnGKiyGRL3TQzn7o2v6C2JhXE59C
         U87zCj5yjFl6vaCJNUJR8L2guyHuVlTi9LSejP5sLdx1aQ/MLyaSFaLS9cxRrh83xRjR
         sjF+6uZrSpnIS3M9v1vVtq1RJCORQXruk97oydCLMHfiFVUcGONU7WD7cC86ughF0YTT
         Wt8+YUESqxHmq0Q/idXBvM6PcDR1pI+tlopCc0aBA8gXvD6VtCvrrL3RqmzczU7y/FfD
         hUt41iNOHbHpSEPcXnNfjp4eRPW/pZ9E0v+ik2FpztrOLG5RPgk8bLwpWT+vsakl9Ds6
         R1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npY22mTRL3RzQKM4rcpOI4mig5zb9lEDKT5AQo828+4=;
        b=EB3ofRUWnZ37v+QGj/+RUi5VrODj2d0siWio2Lh+AQtdxlbzpNKlHC9r6Sy5KxiGf6
         6UNhPf49jGj2cBJOkojZnxOa/xzJu9SdJMmHtt/rYJ5beM/Z3O9nw/sfUaq2nFdgTzLP
         YUS+y/aquT+XB0IV7LxC9UjbRvIMar25PFRxotJJs3w8IuoU7+mE66hhr7IFbxGYDmj6
         H76hnel1LK3h95EyAEcjlJC8JwICtMmZ0c+RXynqrVROd+74Hmwg9DXzsNaLoA/jVgzt
         ENWiaINs/7o053RM/tqYUPCQ/Qu2KknbrbKASCww9sELPkmA4yxzItschV4U04sVa/qc
         qKgg==
X-Gm-Message-State: AEkoousfQvZgNYZanB9IWCLl6sCgpDMGhoPNix5mHgBD6Xtdlvy94JaJ204DqRnetSHi+Q==
X-Received: by 10.28.64.86 with SMTP id n83mr51771314wma.52.1469899537947;
        Sat, 30 Jul 2016 10:25:37 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:36 -0700 (PDT)
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
Subject: [PATCH v9 09/41] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date:	Sat, 30 Jul 2016 19:24:37 +0200
Message-Id: <20160730172509.22939-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_ignorewhitespace_option() should return
-1 instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index be32dfd..4b18916 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,20 +57,20 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-static void parse_ignorewhitespace_option(struct apply_state *state,
-					  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
 	    !strcmp(option, "none")) {
 		state->ws_ignore_action = ignore_ws_none;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "change")) {
 		state->ws_ignore_action = ignore_ws_change;
-		return;
+		return 0;
 	}
-	die(_("unrecognized whitespace ignore option '%s'"), option);
+	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
 static void set_default_whitespace_mode(struct apply_state *state)
@@ -4629,8 +4629,8 @@ static void init_apply_state(struct apply_state *state,
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
 		exit(1);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
 }
 
 static void clear_apply_state(struct apply_state *state)
-- 
2.9.2.558.gf53e569

