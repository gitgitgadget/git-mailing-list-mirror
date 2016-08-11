Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FE4203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbcHKSqk (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:46:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33386 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcHKSpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:45:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so875370wme.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:45:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aKbyk/UTuXqVunfx0HFQggG+zrevuYSFdP8CJzcrjzg=;
        b=h7jYs7zb14lioceDuNTBH6MrEcecBr0f8oEkobFoXUZn4PYVkRyRj0+FDybZO+DTXo
         tE/vvdn1eMYIT1E5hpgSG49lF4JLKVUWUuuds9TX5fBEYLKyHhU91YAk5V50Uc1mawZh
         5Lnjuok4NQ6mNlCVTCtalHa5FAkjOgDAoF+bTnTL9ZZAuzSYP62d3m5aOyy6jhyKvgA/
         02u9yUuebomQR51M05hRnxsyNqIEyd+WusJwVdGVW0p0M1GcoY2WF2pGKaUNRgRCDuHH
         /J2VqrsoZf6ESxbM7z9GN5rpVkF+v3WD3tBZB+mvt3MVwyN0IRyTf251MwMNk1yV+KBG
         2O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aKbyk/UTuXqVunfx0HFQggG+zrevuYSFdP8CJzcrjzg=;
        b=COf4e9dhWJKkfGrd7gE1hRm9kOkbcQAJE0wrjhENSN1W3Diq4ERqIpHrruV6Rg8bvq
         8hhaoux28GTdONPOBofsquazhTua+3eTO+XQwaLk4n4GiGIXsAEekFfA2kFGROiyWy/p
         6GtXi6GfxzUIDbjpC55Ff+vEENCwRGscM/0naFfNqtiatCUfJNSEAAbzIhx4iW5lNgMX
         EhNvsrHivECrZO2pB4t/4Y/QDnGm3EINnLKeowAmOR+t9Gg1l0or9W5I44xYCLcJRvEH
         /B1Uvnutw/mSc3g1v/H7QGgyxHiNTGAWcW+jK86730aoiJ0QTZ334c358BHEehi76Nm9
         AmHg==
X-Gm-Message-State: AEkoouviL3tYNO41PUbYMSTWcGiy64MMezdG+My2SyWs4kAReySbv/VIJnMyBySjLWdDqQ==
X-Received: by 10.194.104.106 with SMTP id gd10mr12956874wjb.55.1470941148286;
        Thu, 11 Aug 2016 11:45:48 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:45:47 -0700 (PDT)
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
Subject: [PATCH v12 02/13] apply: rename and move opt constants to apply.h
Date:	Thu, 11 Aug 2016 20:44:50 +0200
Message-Id: <20160811184501.384-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The constants for the "inaccurate-eof" and the "recount" options will
be used in both "apply.c" and "builtin/apply.c", so they need to go
into "apply.h", and therefore they need a name that is more specific
to the API they belong to.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         |  3 +++
 builtin/apply.c | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.h b/apply.h
index 53f09b5..ca1dcee 100644
--- a/apply.h
+++ b/apply.h
@@ -108,4 +108,7 @@ extern int init_apply_state(struct apply_state *state,
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+#define APPLY_OPT_INACCURATE_EOF	(1<<0)
+#define APPLY_OPT_RECOUNT		(1<<1)
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 429fe44..9c396bb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4463,9 +4463,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 
 static struct lock_file lock_file;
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4495,8 +4492,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4811,10 +4808,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
-			INACCURATE_EOF),
+			APPLY_OPT_INACCURATE_EOF),
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
-			RECOUNT),
+			APPLY_OPT_RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, apply_option_parse_directory },
-- 
2.9.2.769.gc0f0333

