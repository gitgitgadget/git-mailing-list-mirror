Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D7D20372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbdJFUMx (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33842 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdJFUMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id l10so9582420wmg.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTAWyL77NsbIu5IQ95FFU4UTxUUslPXoNqM5N4WwU4w=;
        b=Hu6jbTJD1YKezbGsjj8aWRIpi9+oGK3pU9WUF5nf85L4o9bW2goKt6QZ9mUxyucOEL
         KKYuIZE3iKI5hXAXXEgz1v+dreYYFR4DqKn01h5CYDxutdbXod7iINGLhREvxHe0da2f
         4tHfLvNSGSSnZ1ngsHqVDQgBecqiGiCprBnXDKuxYpBriTZ56OgswVx62jsJ2pXe0w56
         6uxuTAAzBUCawc1NpvdQc/hHumG/z/5cOHC6hNYzvsO0yO1OH0XATY9ufdX2xkX4/RId
         ugcLGitRjr0tG8Kemzrmz9KkKHWDDdZsmLl1mS4O4IWD/VpVVfnxeU/rghqUpZj6aQm6
         4Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTAWyL77NsbIu5IQ95FFU4UTxUUslPXoNqM5N4WwU4w=;
        b=Dmqag11DqW3wYhupcZes2/g+rWB6DaqfeXFnGIxNjd3O7laRQzDYBrkZrl2gBHFHr1
         WhbjRdlwDzVH5hSHw2gKhNDn3P+lp0MIvOG/QDCxwD58catPj3AmCSF4HsQGe6eSlvuu
         wY29eTMQyn9RwT65hGTmIX3OBZ34zZZn0V9atN7FTxiFLU8N4up2qpx+hVntCp1xN27Q
         Kp1vKUE4vWmKchtBbjA8cqJhgnfWVlqnNjmNqZEsiHRH+DZ/2KMAYgH8p3apIOv1XOtB
         sjV6C5icsHmODsyO6pQVIrc8DUdkEo7krFlvbPEPG32R4piFNm9e+E9+CK+hH2pYrA2u
         +WPA==
X-Gm-Message-State: AMCzsaVI3yps8ANTUJiuhAu0/nGz34BtmoNBLAjtbPB2HHX1J8+oMEru
        DoU/iivpzBJaDzqI/BTafy/eFhuz48s=
X-Google-Smtp-Source: AOwi7QCiRaXFpHp5aXmzWO/95wQKAWIqe+BWWgSEPNncieWAH3YmgkNRyCMTIm+IerNI1BTPmyDFnw==
X-Received: by 10.223.196.221 with SMTP id o29mr2122832wrf.210.1507320769872;
        Fri, 06 Oct 2017 13:12:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/12] apply: remove `newfd` from `struct apply_state`
Date:   Fri,  6 Oct 2017 22:12:10 +0200
Message-Id: <d13cd4c92760d8fe01fb51fbab556a4d1f3713b4.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a previous patch, we do not need to use `newfd` to signal
that we have a lockfile to clean up. We can just unconditionally call
`rollback_lock_file`. If we do not hold the lock, it will be a no-op.

Where we check `newfd` to decide whether we need to take the lock, we
can instead use `is_lock_file_locked()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 17 ++++++-----------
 apply.h |  3 +--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/apply.c b/apply.c
index 5a6ca10a7..d676debd5 100644
--- a/apply.c
+++ b/apply.c
@@ -79,7 +79,6 @@ int init_apply_state(struct apply_state *state,
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
-	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4705,13 +4704,13 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && state->newfd < 0) {
+	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
-			state->newfd = hold_lock_file_for_update(&state->lock_file,
-								 state->index_file,
-								 LOCK_DIE_ON_ERROR);
+			hold_lock_file_for_update(&state->lock_file,
+						  state->index_file,
+						  LOCK_DIE_ON_ERROR);
 		else
-			state->newfd = hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
+			hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
@@ -4913,16 +4912,12 @@ int apply_all_patches(struct apply_state *state,
 			res = -128;
 			goto end;
 		}
-		state->newfd = -1;
 	}
 
 	res = !!errs;
 
 end:
-	if (state->newfd >= 0) {
-		rollback_lock_file(&state->lock_file);
-		state->newfd = -1;
-	}
+	rollback_lock_file(&state->lock_file);
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		set_error_routine(state->saved_error_routine);
diff --git a/apply.h b/apply.h
index cf00cda17..dc4a01905 100644
--- a/apply.h
+++ b/apply.h
@@ -36,9 +36,8 @@ enum apply_verbosity {
 struct apply_state {
 	const char *prefix;
 
-	/* These are lock_file related */
+	/* Lock file */
 	struct lock_file lock_file;
-	int newfd;
 
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
-- 
2.15.0.rc0

