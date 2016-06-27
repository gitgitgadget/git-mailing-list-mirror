Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FEF2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbcF0S0w (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33110 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcF0SZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so26994949wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VXf0cngDFYDDoaVMVShf3SOCUfPG/sUB4a47IgkRjeo=;
        b=tQh6sml0RltMNl3f4j5RCdJaUgWdeuT4biYHzBglZpb3AyujYKb4T9GUnHaLPGpKBq
         Ku/OgMRTnje7Hv5bJyH5PLJOHTpOyRi15IDmeTTDbvnrGwvtiD9OxQ6FdRffIyyJZAzb
         5i7T5Bfl1A3Soi8FwKt732dKN0iRT4vxV7umbC/ZEO0MKgpH7dpgonzlYQ83ahNIM0aV
         4IPhGJb9ggLzs7d8u7nHzmuuyVoGuJe6VkQZlDcE/vpeh/XFfUieO0zYOxxLbPaV8+ao
         0JRaOylidpTwQiEihD8XCLKAXCD8sBA0pyTKILnJdpqo20ZI8VE/7bIliTKzfJqqOIsx
         6juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VXf0cngDFYDDoaVMVShf3SOCUfPG/sUB4a47IgkRjeo=;
        b=GC21pGW0xZMphXrvmaHVV/Nltw+VaIn/Fx23hwewc8YGYu2Ip39aorPqKHQNbGsjDW
         ay9HFtZCwyDX497JrEil4ON6LlAeWFttnL6ZLifk4mBzuNQcLarNN0wtv1TLbIGQ89RS
         T5nsgOf05MZ9NpFSHwqyrORcgLD82T/f7Jv+VW5689ouebPVrjo80B+hjbIWs6QpBWxJ
         26REWO+90tSAf5JaaRGN4U0wfnWndJ2PEXDM2nI+OOe7AaMqbnoBPlEBDYq4AgKsQOQA
         w1E9BzjwN42lTLwzX231uLvnBJZWPbYlP26zgU0Q6joey96A2nYY8U4Ry7HmMnkisqXN
         OjMQ==
X-Gm-Message-State: ALyK8tJDRPf7bjdMuTKO4EX2Dz3NM/ZtHdkqnvrihMSqTTPTeK5ICJJwwr8rtx0gfHYNnw==
X-Received: by 10.28.209.13 with SMTP id i13mr12734094wmg.93.1467051915063;
        Mon, 27 Jun 2016 11:25:15 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:14 -0700 (PDT)
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
Subject: [PATCH v8 18/41] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date:	Mon, 27 Jun 2016 20:24:06 +0200
Message-Id: <20160627182429.31550-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index b48b526..d3a9da2 100644
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
2.9.0.172.gfb57a78

