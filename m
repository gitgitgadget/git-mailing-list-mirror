Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AD920193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbcIDUTl (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34112 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbcIDUTa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id w12so959881wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wJ3a40J/TCP2GgYsvo2phqRKXASXn2bsOTHNNLjEXN0=;
        b=XXHIMSTnzRZZ5jrCJBDvZtakf8Am+O2mD4/o4DnuyFC3lg70Fep3Qw1NmlStQzi2hx
         sQxFu+kE5pL8R6Fx3FpXMOgieZH8oXJCRRZ1hktx8A9BOnAz0i0BequNSGcHUmfCh0os
         sAOrX1TZkvi+f6YsnQEYWSKYvqIYm+yzqi8JqMRDguyOMI1atM1riOZFQmjRlSIHXSfx
         NmoDr77jUk0Yao3Da7rEM6I50upHuCsrZsQh6oescCy7mxM0ZAFjpWfdSKpegP0rDa68
         UokMOhzcTqfzZiwqFmbtm84Hj0j/Y8Qj1kgY7H9Zw2pvyOgFdr+Vv1FOy+Z50W7PBG2x
         JrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wJ3a40J/TCP2GgYsvo2phqRKXASXn2bsOTHNNLjEXN0=;
        b=bW3zkmkMz2QeaVVB7HX+vJOE42ldIxO8nfH/zZL4Cv/m9XXzEriswfDDDIT3s+4We1
         wCk2lm0HYlGkKja9DenE6/BFRYGiU3RITP+HccDXB+MY3yDmO2G1Xr4DEWYAIkUtHJHQ
         TsBBa76tjVrYFLrYVttO63HXjD7UTewKlAqiYsNe7Mde7MEYFa8wgByIdrORUH6IM4AQ
         57zQD71DvndOWVoEuRRsMx+JFlPg8fbXmjjKVKJ4X3t8l02ObjKUOViE3LPsXkoZu3S6
         TCzkSWDINF7awKgag+GUc1fbzJZ92TpvjI+tTvD9qXR56Wmtb0nWHsnLldXen84WpJZ4
         cfgA==
X-Gm-Message-State: AE9vXwOVBDUMubL8OfPX2U0t4ulk4C4budttQa3LV9tKigeurlRfuisGrgEK0FiF789bxA==
X-Received: by 10.28.54.5 with SMTP id d5mr8506236wma.91.1473020369141;
        Sun, 04 Sep 2016 13:19:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:28 -0700 (PDT)
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
Subject: [PATCH v14 29/41] apply: rename and move opt constants to apply.h
Date:   Sun,  4 Sep 2016 22:18:21 +0200
Message-Id: <20160904201833.21676-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The constants for the "inaccurate-eof" and the "recount" options will
be used in both "apply.c" and "builtin/apply.c", so they need to go
into "apply.h", and therefore they need a name that is more specific
to the API they belong to.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         |  7 +++++++
 builtin/apply.c | 11 ++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/apply.h b/apply.h
index 53f09b5..48abd8e 100644
--- a/apply.h
+++ b/apply.h
@@ -108,4 +108,11 @@ extern int init_apply_state(struct apply_state *state,
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+/*
+ * Some aspects of the apply behavior are controlled by the following
+ * bits in the "options" parameter passed to apply_all_patches().
+ */
+#define APPLY_OPT_INACCURATE_EOF	(1<<0) /* accept inaccurate eof */
+#define APPLY_OPT_RECOUNT		(1<<1) /* accept inaccurate line count */
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 1f56303..da31af2 100644
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
2.10.0.41.g9df52c3

