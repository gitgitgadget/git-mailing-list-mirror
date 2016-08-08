Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2499D2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbcHHVEA (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32849 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbcHHVD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:03:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so17870089wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:03:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t2LqWxh1I2oUBrtHU8exPr4EzbXryAryleWwOmpl1l4=;
        b=DDk+2QnXkCx/+NMrJzv+9a+2viPQ2dqZKEbg1i3NTxwz8LzqUwc7R3EtZSYPaS4d0f
         Rxvh4Tsr0j+21fBss6uPl7ksly2TOs3+Yq+IKYyosFaHILKa2m0Yg3zzjebXxGqPB1+Z
         lmUINcsSIWB5CvXc1mFWeNn7v+ohvzN/qGxBDXywqJgGHVYiv5Gb8iGQQMm4VvqcUMI9
         zuZDcJD1DzCAIWBcF2pfbQknEyydLMHywY/rr5KP5fDvNH0rk7Tg09X9jy6g6YjivsAV
         ZrZU4aQ7NNprx+kpqeOwLgWuBIoOY7AkFi8LemlZrwTJJJk2akmn++TE8Ywkfq3tWzho
         SgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t2LqWxh1I2oUBrtHU8exPr4EzbXryAryleWwOmpl1l4=;
        b=TITjLh32OfCTlURtGrYXWXBdnfjAnA7UmV6bLjHUhh+zuDztRFctMTtLfoLAxisGqC
         QhQPs7g4O32OHz4qFnIbDrb5/Dd5Xj7DqgLG6Ro884OMEW/uAZcATJZBxdaQPo+cVqPZ
         CERD+zjcXSBPQrjskS9oJvaHNemgGnxhk1fVz9e2Hq57cD+1uNb6hNGZD1CfMRvCvyUz
         RlHf+oXvtNmkbYxJlyY1hBq+34UqNQSL8HXz7oDkbuoaxHWx2CCUdc0io3P1HofAeruS
         +d02h6wWKDSRf/MFygTfKYkOYjXqtA1Q80lVWkQNwsesrGxHw+XVhLrWG1cDib0RUt3r
         /TSQ==
X-Gm-Message-State: AEkooutRm6aTSfScZxv/KAdq/thzXg6VITZxlUG3MNCrprg9edJELS841OZ7zKsLCbIS+A==
X-Received: by 10.194.67.198 with SMTP id p6mr85184159wjt.138.1470690236205;
        Mon, 08 Aug 2016 14:03:56 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:03:55 -0700 (PDT)
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
Subject: [PATCH v10 03/40] builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
Date:	Mon,  8 Aug 2016 23:03:00 +0200
Message-Id: <20160808210337.5038-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors
to the caller instead of die()ing.

As a first step in this direction, let's make apply_patch() return
-1 or -128 in case of errors instead of dying. For now its only
caller apply_all_patches() will exit(128) when apply_patch()
return -128 and it will exit(1) when it returns -1.

We exit() with code 128 because that was what die() was doing
and we want to keep the distinction between exiting with code 1
and exiting with code 128.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 60 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ed923ca..435030a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4404,6 +4404,15 @@ static struct lock_file lock_file;
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
+/*
+ * Try to apply a patch.
+ *
+ * Returns:
+ *  -128 if a bad error happened (like patch unreadable)
+ *  -1 if patch did not apply and user cannot deal with it
+ *   0 if the patch applied
+ *   1 if the patch did not apply but user might fix it
+ */
 static int apply_patch(struct apply_state *state,
 		       int fd,
 		       const char *filename,
@@ -4413,6 +4422,7 @@ static int apply_patch(struct apply_state *state,
 	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
+	int res = 0;
 
 	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -4445,8 +4455,11 @@ static int apply_patch(struct apply_state *state,
 		offset += nr;
 	}
 
-	if (!list && !skipped_patch)
-		die(_("unrecognized input"));
+	if (!list && !skipped_patch) {
+		error(_("unrecognized input"));
+		res = -128;
+		goto end;
+	}
 
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
@@ -4455,21 +4468,23 @@ static int apply_patch(struct apply_state *state,
 	if (state->update_index && state->newfd < 0)
 		state->newfd = hold_locked_index(state->lock_file, 1);
 
-	if (state->check_index) {
-		if (read_cache() < 0)
-			die(_("unable to read index file"));
+	if (state->check_index && read_cache() < 0) {
+		error(_("unable to read index file"));
+		res = -128;
+		goto end;
 	}
 
 	if ((state->check || state->apply) &&
 	    check_patch_list(state, list) < 0 &&
-	    !state->apply_with_reject)
-		exit(1);
+	    !state->apply_with_reject) {
+		res = -1;
+		goto end;
+	}
 
 	if (state->apply && write_out_results(state, list)) {
-		if (state->apply_with_reject)
-			exit(1);
 		/* with --3way, we still need to write the index out */
-		return 1;
+		res = state->apply_with_reject ? -1 : 1;
+		goto end;
 	}
 
 	if (state->fake_ancestor)
@@ -4484,10 +4499,11 @@ static int apply_patch(struct apply_state *state,
 	if (state->summary)
 		summary_patch_list(list);
 
+end:
 	free_patch_list(list);
 	strbuf_release(&buf);
 	string_list_clear(&state->fn_table, 0);
-	return 0;
+	return res;
 }
 
 static void git_apply_config(void)
@@ -4628,6 +4644,7 @@ static int apply_all_patches(struct apply_state *state,
 			     int options)
 {
 	int i;
+	int res;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4636,7 +4653,10 @@ static int apply_all_patches(struct apply_state *state,
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(state, 0, "<stdin>", options);
+			res = apply_patch(state, 0, "<stdin>", options);
+			if (res < 0)
+				goto end;
+			errs |= res;
 			read_stdin = 0;
 			continue;
 		} else if (0 < state->prefix_length)
@@ -4649,12 +4669,19 @@ static int apply_all_patches(struct apply_state *state,
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
-		errs |= apply_patch(state, fd, arg, options);
+		res = apply_patch(state, fd, arg, options);
+		if (res < 0)
+			goto end;
+		errs |= res;
 		close(fd);
 	}
 	set_default_whitespace_mode(state);
-	if (read_stdin)
-		errs |= apply_patch(state, 0, "<stdin>", options);
+	if (read_stdin) {
+		res = apply_patch(state, 0, "<stdin>", options);
+		if (res < 0)
+			goto end;
+		errs |= res;
+	}
 
 	if (state->whitespace_error) {
 		if (state->squelch_whitespace_errors &&
@@ -4690,6 +4717,9 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	return !!errs;
+
+end:
+	exit(res == -1 ? 1 : 128);
 }
 
 int cmd_apply(int argc, const char **argv, const char *prefix)
-- 
2.9.2.614.g4980f51

