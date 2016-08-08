Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CA6203BD
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcHHVEr (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34065 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbcHHVEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so17868399wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RB4/swBCmjQWex+fWraasJAYDAJ1prG8p1XNihni4d8=;
        b=CHqXdcJcps8OZbb6gMKzHxgdEyY8dem+ZXEMDov6MTpVkOJHxRjAnJbOMkIqzmW735
         kPPH8hFeGoZtXpHQUshBEiAiRnlkno9/XGHn6k7a+lEf5HMPuE8M/oe9yEQXlYEbcfFL
         Woi3mszUDSjOyrLpOA4ej5lVbJ/Kcf1Hjfedf4QYI6q3YI2u+YwG5IFlpAyB8DEHq9Sl
         7FmklADqO818b/GVeNChH0AdryE2m/jVFDflDY8tHMer/Yekd42cGw7ZAT8EZYcurZUl
         YzouXAU4Xw+BdihxQVHwlOtaAI5wLNvkAHmCvptgvF3ymLcbd8YHuQNxP6tz5FgbNAbk
         Z17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RB4/swBCmjQWex+fWraasJAYDAJ1prG8p1XNihni4d8=;
        b=K0uzqVv6yFVRC7wqpcCGnap+8xDtGUZKmU1F2iWDZAoyNZITziE01G0e8+p3h5sgtt
         thNTMWkrGWHxruRWIMHM0ft4iyxCM3ccJqF/Id9ZbicrNtdsf1XXXubAaKLHEVovFwPM
         L7Ds2Ih9+jNz/bi7KhpFiHK/j0WZpHAuhefY7Sj9DcGT6gsIVzXz5j5K2wDctvU2kqK0
         UICgqcyRH9VEz2+DJIJnPBcAPscGZaVCfYGR1zH0Nn3gWC90SZK4+v8+jFHvt5tD1mw1
         7z/2RAP5DbjIDYtZdSWysE60q+y2h4FB33g9l7Di6veP6zoLsHi6PbOcYekumBAB1Kgc
         hr4w==
X-Gm-Message-State: AEkoouuQsVIYny4nOq3p/HL/HeXw39WRz09VihogxaN2SzvhnGeXObfm0BNVwqFZYxHCTg==
X-Received: by 10.194.38.9 with SMTP id c9mr23816140wjk.78.1470690283806;
        Mon, 08 Aug 2016 14:04:43 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:43 -0700 (PDT)
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
Subject: [PATCH v10 31/40] apply: make some parsing functions static again
Date:	Mon,  8 Aug 2016 23:03:28 +0200
Message-Id: <20160808210337.5038-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index 7b96130..c0cb3f5 100644
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
2.9.2.614.g4980f51

