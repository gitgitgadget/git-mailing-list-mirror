Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1722018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbcHHVFP (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35834 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcHHVES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so17866247wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4jt92rD4nld7J6raNJ/yNGOLvkv8nHrlYJ6Tq/v8RKc=;
        b=wQ6u2pDH+QoMHQ8asw8pz+hw+xk8hYW6piDitPq8VxTmVGH3WEfCiUs7wmk+HA82nb
         1b22DjMkI9MaSzbmzTbmHURro+iWe29RtYBU+y3HH3ZRjrjrLZXG4KhF+L+QMRP4mySb
         DYXm6CRbzcdmK8r4x0T8Rw/g2Zh7T/qktfi0jlDqZBlLD77oxky6Vs6g8gHBTN76skbn
         XMP5SIoDGwdd3pNSXZhgSWuZfGfLU0I4sN52v7LHxg8OiHSCNuOnpYGFTkawJTyz2nb+
         8rilvcXUrO6lLgmqoSwISnVpiTk4ejxXfd35/ByGzBxvbKrCkfryoPjo8M+NfxuEAZy+
         4LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4jt92rD4nld7J6raNJ/yNGOLvkv8nHrlYJ6Tq/v8RKc=;
        b=BReTEB80pbwopd7rh2F2kFnXNOt43maLwQbE2fBjxGVQ0UADVo+w1YGWx64Ps1gMwH
         J2q2jW3Kkdjl0Arv14Ot14/z1mhhN5xrVJWk9cVd0xM6MUeWsarTWqjQHuTJOwPJGqR3
         ZtQUaqI+tHIEhYF2naKMlQbuG6pF50cjAmc4UkGg78o2n+JJnmcmCSzE23Z8FsxVxq9I
         MvGq1fuC01N/H+/WXab2jr/chnmtRqHHZg2mV/AP2BAHokcUk9XyRxR0PGSZu7hetyao
         l/4PZeqP4aslLPMFFcd2OKGm3fCkBfRjm7rdvLfzMBZuVMvOdqzsVKGIKigN0Zh1G+w5
         zYew==
X-Gm-Message-State: AEkoouuo+HLKzdzO2/iAjzY1PeV1MUl5AilqpeiDgHFROkdqfqYSSL5hXBttaxjfG+OxbQ==
X-Received: by 10.194.238.42 with SMTP id vh10mr84795168wjc.111.1470690256183;
        Mon, 08 Aug 2016 14:04:16 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:15 -0700 (PDT)
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
Subject: [PATCH v10 18/40] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date:	Mon,  8 Aug 2016 23:03:15 +0200
Message-Id: <20160808210337.5038-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", die_on_unsafe_path() should return a negative
integer instead of calling die(), so while doing that let's change
its name to check_unsafe_path().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6b16173..166e94d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3704,7 +3704,7 @@ static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 	return ret;
 }
 
-static void die_on_unsafe_path(struct patch *patch)
+static int check_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
 	const char *new_name = NULL;
@@ -3716,9 +3716,10 @@ static void die_on_unsafe_path(struct patch *patch)
 		new_name = patch->new_name;
 
 	if (old_name && !verify_path(old_name))
-		die(_("invalid path '%s'"), old_name);
+		return error(_("invalid path '%s'"), old_name);
 	if (new_name && !verify_path(new_name))
-		die(_("invalid path '%s'"), new_name);
+		return error(_("invalid path '%s'"), new_name);
+	return 0;
 }
 
 /*
@@ -3808,8 +3809,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!state->unsafe_paths)
-		die_on_unsafe_path(patch);
+	if (!state->unsafe_paths && check_unsafe_path(patch))
+		return -128;
 
 	/*
 	 * An attempt to read from or delete a path that is beyond a
@@ -3837,10 +3838,14 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_symlink_changes(state, patch);
 	prepare_fn_table(state, patch);
 	while (patch) {
+		int res;
 		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
-		err |= check_patch(state, patch);
+		res = check_patch(state, patch);
+		if (res == -128)
+			return -128;
+		err |= res;
 		patch = patch->next;
 	}
 	return err;
@@ -4472,11 +4477,16 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if ((state->check || state->apply) &&
-	    check_patch_list(state, list) < 0 &&
-	    !state->apply_with_reject) {
-		res = -1;
-		goto end;
+	if (state->check || state->apply) {
+		int r = check_patch_list(state, list);
+		if (r == -128) {
+			res = -128;
+			goto end;
+		}
+		if (r < 0 && !state->apply_with_reject) {
+			res = -1;
+			goto end;
+		}
 	}
 
 	if (state->apply && write_out_results(state, list)) {
-- 
2.9.2.614.g4980f51

