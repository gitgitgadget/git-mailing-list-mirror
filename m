Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE6D20193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbcHHVES (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33797 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbcHHVEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so17865957wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zo8idKSY8vRjH4eD+dvkipWnB2LgxvVfMrLPZRPWQsE=;
        b=uftrAq+NBzeKcLwnG6gYuZpl+9cmBIGLiIJrm9JT28/n27NEUH/T1V6W2Q0kesrWsU
         h6ADTkRFdKLF2TuRhPVMfbMZ9nEcBKm3sCj+N1oB3xjC3XY3fVBlTPwjUM9RWpYhoOTL
         nX/O4cwJQZgeXlQKjzGia6moOmXckkY9FTmYboTRhgNedFztDrH+EFXP7Cag0w6iVtdD
         N5eKhvPRqbcCRPqXYXZBKmI1NfNRcO97C0rtepaRoT7NFqLVGeluQjnZ4p38zdv0ihMS
         k0IwzR4GIrIs1Je1UqT15NpbmTacsb3SlY7RM6ui1R8YXldyiYEKTJqeHsLZl6kFo5+b
         iQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zo8idKSY8vRjH4eD+dvkipWnB2LgxvVfMrLPZRPWQsE=;
        b=KXdKM28UKtVNuGTiVik62xjZPLWgtvj+YiV55No8mZ7BmS3nZIvH1lpRQD1DCgH10d
         LUPbnTGUlvVOQYL0zgMi0L9oTB8ZHEsZlxqWjYoMJAD/cl5V0+pI5vm2+9VZ1eatdATo
         O16q8mtxME4SS0VIeymU5D+xTF/wOdwP89ZoK27GPSFgXKARXcM8SLPa/eSI5mVTspnd
         ETXyQ7xZ0nFrkeiLcbha4lvjcMxmRIswKxca67cGm7dCMFWwJsiWttm31AstCeg9Ym5i
         /3KhLiyLSyzgHkfD6JDjzPuD/Ves6MtEYL/kTVZgx8JEoWNk7r9yrE+BsMgeanVyHyWv
         E4zA==
X-Gm-Message-State: AEkooutUldc9DSXz9nqdviGlLzR8A8raFxFostbLXMKRD2EcOcp1M5V+MKdy6EfQf13aNQ==
X-Received: by 10.28.63.8 with SMTP id m8mr19147521wma.88.1470690249676;
        Mon, 08 Aug 2016 14:04:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:09 -0700 (PDT)
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
Subject: [PATCH v10 13/40] builtin/apply: move check_apply_state() to apply.c
Date:	Mon,  8 Aug 2016 23:03:10 +0200
Message-Id: <20160808210337.5038-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

