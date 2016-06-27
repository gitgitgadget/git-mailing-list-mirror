Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527B22018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbcF0SZ6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35454 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcF0SZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so26935307wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBQ86SlNeICh+R1ovgkKt2clNp9Acny1toZzvTqGYAY=;
        b=tUBMQblwYWT/V9XS/7+ymUJaaR59em+BRi+Z2Sg2L4R4qVCyjQDcLIu52Mzfy8Pusf
         zNiKC4hDa0cO7oweg8VbMsO5adgkcJeB34rgmRU4eMosBut5CPUcDL8unutHbKr/93Ed
         RUcpjzu/qfGbH3hcD3kYGF18NLS8ZsM0rByht7JJ4aufb4i1m4W7k8ChBKorPB3HnjKG
         LJ2+zhy28j3vSXubauSUfHZwfeG3lyd3ASUGY/lXmoa8J+0GFyZhkBTXvPieXbrpi7Bf
         uf0XYYWsIdZpsTYwIqx/Yrtb6ZJ/ZuYnhAjDJ7NMTwBies8fOrFjqFIzEcs2mW1Zvoow
         Pn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBQ86SlNeICh+R1ovgkKt2clNp9Acny1toZzvTqGYAY=;
        b=Uhja0b6MgugC+f5tbQfTD6W4ibjy8wrNcU8HH9FrZX5+P6nN/6dn5gI+HZi8ZNxP9W
         Xr1NcBqF/3SjxxJqhXD5NrjrrinPYfaZ7IW2+EYnhWniZV13f0ywnzMlYx+FwtM9IMy8
         72btaXvbrW22P4j7cOhx9CMM1YPhNtqENF3WheOcWq2xPP9l2CMbmSpOz8OfdDMINzbg
         VlmNX6zklwQZRAqqgyXQcObs1qqQPY7gaH+6GkEuoeTHYoezAn0nJo/AdFUBI9XsP7fP
         CIhYEMCGPDsxQLGN4eCEKuomOhIbrxrZ7r+2Hq6bhlxJDyf7uZfAkP6+VDEhQhflIGB2
         jqtg==
X-Gm-Message-State: ALyK8tLfGLx+IB5co+4AMgIK0la4Kc6LAShOdc/zEaTyR/y6G3JR6PoQJDxmhE5JK3FgKQ==
X-Received: by 10.194.242.37 with SMTP id wn5mr2103783wjc.135.1467051953193;
        Mon, 27 Jun 2016 11:25:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:52 -0700 (PDT)
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
Subject: [PATCH v8 39/41] apply: change error_routine when be_silent is set
Date:	Mon, 27 Jun 2016 20:24:27 +0200
Message-Id: <20160627182429.31550-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To avoid printing anything when applying with be_silent set,
let's save the existing warn and error routines before
applying and replace them with a routine that does nothing.

Then after applying, let's restore the saved routines.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 21 ++++++++++++++++++++-
 apply.h |  4 ++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index e2acc18..de86f40 100644
--- a/apply.c
+++ b/apply.c
@@ -109,6 +109,11 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
+static void mute_routine(const char *bla, va_list params)
+{
+	/* do nothing */
+}
+
 int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
@@ -143,6 +148,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (!state->lock_file)
 		return error("BUG: state->lock_file should not be NULL");
 
+	if (state->be_silent) {
+		state->saved_error_routine = get_error_routine();
+		state->saved_warn_routine = get_warn_routine();
+		set_error_routine(mute_routine);
+		set_warn_routine(mute_routine);
+	}
+
 	return 0;
 }
 
@@ -4860,7 +4872,7 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
-	return !!errs;
+	res = !!errs;
 
 end:
 	if (state->newfd >= 0) {
@@ -4868,5 +4880,12 @@ end:
 		state->newfd = -1;
 	}
 
+	if (state->be_silent) {
+		set_error_routine(state->saved_error_routine);
+		set_warn_routine(state->saved_warn_routine);
+	}
+
+	if (res > -1)
+		return res;
 	return (res == -1 ? 1 : 128);
 }
diff --git a/apply.h b/apply.h
index 44bed19..51a930a 100644
--- a/apply.h
+++ b/apply.h
@@ -89,6 +89,10 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	/* This is to save some reporting routines */
+	void (*saved_error_routine)(const char *err, va_list params);
+	void (*saved_warn_routine)(const char *warn, va_list params);
+
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
 	enum apply_ws_ignore ws_ignore_action;
-- 
2.9.0.172.gfb57a78

