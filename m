Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F382018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbcF0SZU (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32967 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcF0SZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id r201so26994174wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i6aaEjMySIobyVK05uzjDeiIEqvvykJ1pZgJqhvQy3o=;
        b=L7CnF9YW5el72TL5DNN3Y5jrmHsewAZEqw0fyvHf3rX55+q0VWcrf9cDtihIBMbXqU
         gtLQ0GPGgGCCpmOzCCCv+ERTR4npIeaiEVS2DmVd5//cUDIqlB8UQEgEyI2LsDqxD2BS
         SVy/MYMdWMYp+3gg3VL+u89nkZVDHJwv1oQKPKH0sMUfduGpAwIKwcQn/s+mmLTmAj6V
         qa5yDxTGEBfnpolRzLSg8vruSXD/zh5+2xfVzkMeayIw8lbhxIQ5vy7/ZqiER2vyRiTP
         W02fjtCpxyTx/PPwdHWOxFxW7Pv+Ni/E59pXh0UjIvKMchC48Tfge7Ybjm+1z+I9YNTI
         NnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i6aaEjMySIobyVK05uzjDeiIEqvvykJ1pZgJqhvQy3o=;
        b=mYjo3fQ92XRZy0qoylvJ/EYAFzrf6af0Ga9apB6So9+ZjuLmketI/jwfLTIaGhmbLn
         wjK9Cn8NblUC2TGEYxshURjUrjFZHmLA3JpDx3c/QUW8jTRHJutgMCv82bnfRJIgdDPk
         u11eXx/pUVmR3wApvUTD2iGMQ8uvLNAjWOKQhcj7FQiyUCE0VZJc8jyUIVMz9Ac7GA5K
         Xc7zMrYYpR78mwDq5efFFB6PkxbnnnXydEIYkBTUm7FTw4gEb0zliIfvehRa+AJ9IdoL
         ivHGED6yce98Onxj8gRS1/aXnlzPfDZwGOsUHEz4tKyLj5Cakggi15PNL5L6ucSUICzK
         X2fg==
X-Gm-Message-State: ALyK8tLB2WrROQRzPJerFHyC6HS8hLFZmIVzcAmwGO86lR7T0f6w7zIWhQxpTcwXiQQnPg==
X-Received: by 10.194.153.98 with SMTP id vf2mr2148855wjb.72.1467051908399;
        Mon, 27 Jun 2016 11:25:08 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:07 -0700 (PDT)
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
Subject: [PATCH v8 13/41] builtin/apply: move check_apply_state() to apply.c
Date:	Mon, 27 Jun 2016 20:24:01 +0200
Message-Id: <20160627182429.31550-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index c5a9ee2..84dae3d 100644
--- a/apply.c
+++ b/apply.c
@@ -90,3 +90,35 @@ void clear_apply_state(struct apply_state *state)
 
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
index 955e94a..18c5419 100644
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
2.9.0.172.gfb57a78

