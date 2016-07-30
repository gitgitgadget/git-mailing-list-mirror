Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF821F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbcG3Ri1 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:38:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36090 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbcG3RiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:38:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so20048302wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:38:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hwzZ+tZgrA+Z+FzAtwpwPNR1Bz3mmlCMNnUQV1a94uk=;
        b=jqnvdsArpQYxDojMgaQ6PXPE7pe8sQ8/iNbXaBqM7dG0VxZCAdQzdljXgoTF2Wqd15
         56BzomyEUhSMQN7Ev//ckhMWs14HxP8ZD+XeV4U8D2OpiURBhVP/zlnpsLtmPhOZZ4J9
         As0PWBpbVb2umsIyL/n6pBWm+m8HAUYbQ6H2eK01jSqvM+zAzdexSkk4GwrgCqMa4y7w
         KlGLA9YqTGlKZcMShe5TO6M90qoKmfSjdItNmHmb092EevIc+uA/uzXfrQa0wS9qfLN0
         8vsA5MHKCF6hq5w2ib7cALXn3jO2QP4vCZR0fobw0bqjA7sKRPqbrcwl5lj6GblcJvqi
         oXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hwzZ+tZgrA+Z+FzAtwpwPNR1Bz3mmlCMNnUQV1a94uk=;
        b=izJamm61nZQ9sGe6PxF2KW64507uI7IA8+km6cKjboroRRgIdW+CkQ1oN8RdV+Oo5k
         bV8VTkd/Vfo9jo/JcjsF/lDhMB6uEGvfD+HSNzhfS83WSFbuvtWZR94vBOxF7F7goD+u
         J6reP9hd5y9oxmK2fPdwCLiFUOhOBsynIbrwqnhHNZJRjRY8UUsr/KJAYiPk3c4CALtE
         828y+tre9GHDtj5VwdDpNjVygojo6WIdkxIIa2IRLu/gfuPp0a2IwiU5qhP3kXg2swTQ
         pco52q1Hdd96VvHwId45/JTVnvRQfMOWxCmG9TkTt8+S/e9xDN4SnhxPtrXV/6yRTapz
         FZGA==
X-Gm-Message-State: AEkoousBpkb0AN8xZy/T3O/x543o9Vok8dRdfyclFUXmI24KSXHxqvKvLOSoJYSEcbFmhA==
X-Received: by 10.28.20.77 with SMTP id 74mr6841381wmu.1.1469899546598;
        Sat, 30 Jul 2016 10:25:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:45 -0700 (PDT)
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
Subject: [PATCH v9 13/41] builtin/apply: move check_apply_state() to apply.c
Date:	Sat, 30 Jul 2016 19:24:41 +0200
Message-Id: <20160730172509.22939-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 0dbc561..8f5e2fa 100644
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
2.9.2.558.gf53e569

