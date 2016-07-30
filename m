Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293461F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbcG3R1W (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33370 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so20040935wme.0
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MD4872U/vV/vNgG4bibKSJGDJM6Vb+zSBg3lzZW09i0=;
        b=AfBpTQS0lZantLCHeAjD03j0IUuhT/ccM/tQUMW3+rw0rkrdqvki+KsI7retbem22d
         JBHAqi6jypnnYDmBp5E6p6Bagaj9VM70OU/BZLxrXrNvQNmACLdUlIC2O2NXSwWdpHKX
         ro3QRW0t2zrKp5OY+rbqO3UfHGHLGVsFEcdObsdL/WRCdAVJyJZyjt9VT27P6wAhYxDj
         ayQloWwjxZ3p1h0mIUjcVxQlgJaUtIXAjK4v/Hngd28QykPtgYZpkWpsXQCb8qs6AGIF
         QygZ02RdPy1mGoWfsQ7B/DbTWXbPrO/HVE2t0QgzJYdRwelXs+xeQcKIgN/ef5F3/WhE
         HKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MD4872U/vV/vNgG4bibKSJGDJM6Vb+zSBg3lzZW09i0=;
        b=OFFZ6SR21vgATX9pEHvkp8hqAR7e+3FxOKnbpoctE3o04kmP7JBYGTis+goz78P+6G
         QEzOvXkFxC3wUU2BQ6Y+pNSV+hllQptbrD2D63j6tCPx13iW9L45VUM9ZBaPjMCdU6aL
         CHWWrxcz2vCbQ3bqK1H4dpJ/DKwdaBg1tVDecuSCSyM1QXa3bqnybzO0/0FriGfktC+C
         RkDAr2m3O0oV/o8Fz3fFtaLSWR9Ry9ngRjbPW4n7pIZv3fHFVnXFVp3JAKJLwH8aKTje
         RdBhmjNnZ25ViFvGtVWWrn/Z4Bn0gcDx+4KeLmodI3yMx3iSqmDHVwb5LFVX+FKy23RN
         JPyg==
X-Gm-Message-State: AEkoouuK2HmFQIvz1l071JlA8fT0Kxm6eVWQXPSQBnwRmEtXimC9wTO6Ww591Js73K1m1A==
X-Received: by 10.194.61.205 with SMTP id s13mr42675737wjr.86.1469899582464;
        Sat, 30 Jul 2016 10:26:22 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:21 -0700 (PDT)
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
Subject: [PATCH v9 31/41] apply: make some parsing functions static again
Date:	Sat, 30 Jul 2016 19:24:59 +0200
Message-Id: <20160730172509.22939-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some parsing functions that were used in both "apply.c" and
"builtin/apply.c" are now only used in the former, so they
can be made static to "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 5a56541..12cad24 100644
--- a/apply.c
+++ b/apply.c
@@ -27,7 +27,7 @@ static void git_apply_config(void)
 	git_config(git_default_config, NULL);
 }
 
-int parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
@@ -57,8 +57,8 @@ int parse_whitespace_option(struct apply_state *state, const char *option)
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-int parse_ignorewhitespace_option(struct apply_state *state,
-				  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+						 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
diff --git a/apply.h b/apply.h
index 5ec022c..df44b51 100644
--- a/apply.h
+++ b/apply.h
@@ -97,11 +97,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int parse_whitespace_option(struct apply_state *state,
-				   const char *option);
-extern int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option);
-
 extern int apply_option_parse_exclude(const struct option *opt,
 				      const char *arg, int unset);
 extern int apply_option_parse_include(const struct option *opt,
-- 
2.9.2.558.gf53e569

