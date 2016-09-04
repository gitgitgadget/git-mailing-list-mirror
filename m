Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B03820193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbcIDUTR (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32807 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbcIDUTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so10455755wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TlesdSrgGv0pU4ElSy2qCv3u1qVdTsZgpYxHaFjUKrE=;
        b=VUND3+m/yYOuf+ALurZsdMu41H8ufYWwzisMUYxV9mQU9RhbqXh3i2iwULM67sQNjg
         GuQVoztXG/JCDW9tSfDLGyZeAexagbkxmCw/j/aQZRvFJM4p8ANjVp5htY5OVbyKXGST
         ltBPuhcnAtJZNcXIP/EsVtYImrGVe+M+HWriTlJzp9yVgeqSuaTnNdKzJGWlD4V0OWFa
         ogSrYOspot7A7VtckJuucbsnRrfBMr3eE+s7dOohkLjYLPx3GSI2pdnDOn8Nh77X9vvv
         vGNGwZ5hQbnDTD0XuvXAURAom2cMzsHHAIkK4z5Pc8c/8yWMzP7GCm1gkwicdJD0/4nn
         LhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TlesdSrgGv0pU4ElSy2qCv3u1qVdTsZgpYxHaFjUKrE=;
        b=Pt46MW4A09ca0iBZ2bKOOjAjuljlJ0H2pdCXptg5C7rB16KV05mFMoMLKlhqoEpvU6
         txRSvcL/EBlp7p/iI9fvBn7dZ7YwTUtDeRWfdkINU2PmKCf9tOy86qOA9K6GE3KwZX8D
         3G/i48yzW3pWUmYv1Qasbbr/Q6v7JNS+WDqvw5DuAL/cK1+9VUoWv2wxoUIo8d1efDWU
         Bi4cubuV896uyiPq//nD/s1hH3MNfDai8EkUBop6G/7YV+Bb3YgvvmfyNhhiVV2nrG7K
         V2WKrJrPNLcyw3RnbKarIBGdCrf5h4OwjxN1dokIfyjkHTJ+ltkq2ucL1nHT8DpB/X+2
         FmNQ==
X-Gm-Message-State: AE9vXwN7L7Eo6bprFmvp/zRxnMyl+dazM8T7T23nOKgVWotGJC1cSoyRCWWnGUGx/sqsIQ==
X-Received: by 10.28.28.70 with SMTP id c67mr12668475wmc.8.1473020344365;
        Sun, 04 Sep 2016 13:19:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:03 -0700 (PDT)
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
Subject: [PATCH v14 13/41] builtin/apply: move check_apply_state() to apply.c
Date:   Sun,  4 Sep 2016 22:18:05 +0200
Message-Id: <20160904201833.21676-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we must make check_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 32 ++++++++++++++++++++++++++++++++
 apply.h         |  1 +
 builtin/apply.c | 32 --------------------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/apply.c b/apply.c
index 6e0e992..2eac3e3 100644
--- a/apply.c
+++ b/apply.c
@@ -93,3 +93,35 @@ void clear_apply_state(struct apply_state *state)
 
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
+
+int check_apply_state(struct apply_state *state, int force_apply)
+{
+	int is_not_gitdir = !startup_info->have_repository;
+
+	if (state->apply_with_reject && state->threeway)
+		return error("--reject and --3way cannot be used together.");
+	if (state->cached && state->threeway)
+		return error("--cached and --3way cannot be used together.");
+	if (state->threeway) {
+		if (is_not_gitdir)
+			return error(_("--3way outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->apply_with_reject)
+		state->apply = state->apply_verbosely = 1;
+	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
+		state->apply = 0;
+	if (state->check_index && is_not_gitdir)
+		return error(_("--index outside a repository"));
+	if (state->cached) {
+		if (is_not_gitdir)
+			return error(_("--cached outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->check_index)
+		state->unsafe_paths = 0;
+	if (!state->lock_file)
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
+}
diff --git a/apply.h b/apply.h
index e18a18a..53f09b5 100644
--- a/apply.h
+++ b/apply.h
@@ -106,5 +106,6 @@ extern int init_apply_state(struct apply_state *state,
 			    const char *prefix,
 			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
+extern int check_apply_state(struct apply_state *state, int force_apply);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index bb89e07..075ada4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4551,38 +4551,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static int check_apply_state(struct apply_state *state, int force_apply)
-{
-	int is_not_gitdir = !startup_info->have_repository;
-
-	if (state->apply_with_reject && state->threeway)
-		return error("--reject and --3way cannot be used together.");
-	if (state->cached && state->threeway)
-		return error("--cached and --3way cannot be used together.");
-	if (state->threeway) {
-		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
-	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
-		state->apply = 0;
-	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
-	if (state->cached) {
-		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->check_index)
-		state->unsafe_paths = 0;
-	if (!state->lock_file)
-		return error("BUG: state->lock_file should not be NULL");
-
-	return 0;
-}
-
 static int apply_all_patches(struct apply_state *state,
 			     int argc,
 			     const char **argv,
-- 
2.10.0.41.g9df52c3

