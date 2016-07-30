Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167AB1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbcG3RoE (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:44:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33088 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbcG3RoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:44:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so20084439wme.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:44:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5kRxYTeCA+aTPYshmuRb8hqrpmO+vU3Li4kvRSWpiM=;
        b=Q4kKC0cgwp8VAKy3IE0Wvz76O3VR2dcRgMorzeYp7VtrVVPl2sRfxxCuQ4OaMGA8rd
         QCs8vYn/b++I9PwIiq7sX1LcDN2MkYfEY/9LeMSEb1WQeXKoYwo31r9PQvZ/bTv1gihf
         To02tnamIgkNoFx/+PpbMGctGmTHsdmnaoIcMfhNwf2fhUnQHBlPFZ8kw3bS3xK0eVyq
         uvDz30K3gRaHOltIrFh8xdOHRz4bjfL8Zw/GiCS620neaS/llOzT146D3K7ycaX1PhQ5
         kH9LcG/qfamwucbiddGSXxlVSx/sBdBNdp3R3WUaTMPJFWpL8Q0MivU4RgN7BU3fW31T
         m1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5kRxYTeCA+aTPYshmuRb8hqrpmO+vU3Li4kvRSWpiM=;
        b=TRpfPsjqzkzn/iuB4JnlrgcPQkkMmPlIy8R9GJn59W6G+GiMHk+GBuiVq+nbYGT02m
         nu4kJMRdGVu/Yrd06LnMAejoG+UMqBPncvz9ld9rT1oguTuBoOAMGsV1dJJSToLwAq4u
         waQ7SO4hoopoM8F7N7rUDShwZPrm3geaMwYlo7uJMNkEkM8tM6AomhCF8T6GYFh0gLKj
         FPrrFIE17jWja9beEBWiBt3B26Qopgx1kMqpPEyN+hMlKEPRl7UDGdio7kSxRHEUQ6oK
         KkvHtWUP/Ni7qx+x02+ZvYPi4nsSRveOIaecR/em12AdNsRhwo3lb5wz2Y3DHLzrBZLt
         yORg==
X-Gm-Message-State: AEkoouuoVrf6hFF5Y7Sj7gh9963h9+paY3keQs1vw6Ye6DLxWIjVtnQPIX2aB7KPlImTVQ==
X-Received: by 10.28.142.135 with SMTP id q129mr49472156wmd.41.1469899543961;
        Sat, 30 Jul 2016 10:25:43 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:43 -0700 (PDT)
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
Subject: [PATCH v9 11/41] apply: make init_apply_state() return -1 instead of exit()ing
Date:	Sat, 30 Jul 2016 19:24:39 +0200
Message-Id: <20160730172509.22939-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index b36f3fd..7e5869d 100644
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
2.9.2.558.gf53e569

