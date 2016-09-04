Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E0F1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbcIDUUS (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34204 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbcIDUTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id w12so960698wmf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KsMyojotEt5MAbE6vw2zUyX43IaqgtkI/7yBxFk0o5g=;
        b=dL8Al9h/XGz2g1KKAkEvCWKkRifDUGjmArFar/OYazLS9OPPAeW476cGe9Mp+c1+yT
         g4IFBdlCG6/UJ5SYXVuyAFwwhg6+8oFv+xphPdZJ7Z6xLFDMFfi1zD5CznTKOhuwEGUb
         EFhEYjc0pYQkHmZHJeKQChWKvgeuz5PYbqeBxLcChASR/cNwC5BuEhC0AO+I7E5gEc60
         GMkyTsqm1Q/6NXAYYSbrB5YOuKprX6bYYEt3IRSg1/nXBqN0sLMUXtJlBKtoqdaa2d8n
         fPOM6GSmwET8sJo8s6kALCu6nn/Cb2N3Y5NyvfMYIvrfx4N0X7RWKSTuCqktoAk7WYI5
         SW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KsMyojotEt5MAbE6vw2zUyX43IaqgtkI/7yBxFk0o5g=;
        b=i4KUlkhTVCNxdJFWSkXkGWfQp9x2kzkHi96/Vz/rdO5MPP1uRlhq7lYFdM6pmCl8px
         RYkXZXYbyS0qml96gECtPiHKDzl3aOZdWqs/DINL7S7MqTTQZuwOYsjvrRyaNyQiCJbX
         cMVFQnogqEvElNMjCx2he2okhLDarWKzWnBOJBdXhSTUFQrlAuLjSJsa+l7PpgSzf44S
         qlMZZoC5JRf+K05g7Di5j6aco7pKumAEunqXd2VIXEt0H68ITbU0yp/xkkzwcQAeB9ke
         jBq6tEb+XJVwiZcopj+BaJ+Pw7OAw6qYz4FzWrSfCSNIbMlBby1A/xIJirq3MxbO6Kf2
         xzNg==
X-Gm-Message-State: AE9vXwMkTdxsoB+rTJZBd+LlK0Gu75taVfXXkldyN0GYtwGqG8/eroSDwQ8iAneBsP0tAg==
X-Received: by 10.28.149.137 with SMTP id x131mr8153296wmd.79.1473020390735;
        Sun, 04 Sep 2016 13:19:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:49 -0700 (PDT)
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
Subject: [PATCH v14 37/41] apply: change error_routine when silent
Date:   Sun,  4 Sep 2016 22:18:29 +0200
Message-Id: <20160904201833.21676-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid printing anything when applying with
`state->apply_verbosity == verbosity_silent`, let's save the
existing warn and error routines before applying, and let's
replace them with a routine that does nothing.

Then after applying, let's restore the saved routines.

Note that, as we need to restore the saved routines in all
cases, we cannot return early any more in apply_all_patches().

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 21 ++++++++++++++++++++-
 apply.h |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index ddbb0a2..27baf0e 100644
--- a/apply.c
+++ b/apply.c
@@ -112,6 +112,11 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
+static void mute_routine(const char *msg, va_list params)
+{
+	/* do nothing */
+}
+
 int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
@@ -144,6 +149,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (!state->lock_file)
 		return error("BUG: state->lock_file should not be NULL");
 
+	if (state->apply_verbosity <= verbosity_silent) {
+		state->saved_error_routine = get_error_routine();
+		state->saved_warn_routine = get_warn_routine();
+		set_error_routine(mute_routine);
+		set_warn_routine(mute_routine);
+	}
+
 	return 0;
 }
 
@@ -4864,7 +4876,7 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
-	return !!errs;
+	res = !!errs;
 
 end:
 	if (state->newfd >= 0) {
@@ -4872,5 +4884,12 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
+	if (state->apply_verbosity <= verbosity_silent) {
+		set_error_routine(state->saved_error_routine);
+		set_warn_routine(state->saved_warn_routine);
+	}
+
+	if (res > -1)
+		return res;
 	return (res == -1 ? 1 : 128);
 }
diff --git a/apply.h b/apply.h
index f015403..902346b 100644
--- a/apply.h
+++ b/apply.h
@@ -94,6 +94,14 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	/*
+	 * This is to save reporting routines before using
+	 * set_error_routine() or set_warn_routine() to install muting
+	 * routines when in verbosity_silent mode.
+	 */
+	void (*saved_error_routine)(const char *err, va_list params);
+	void (*saved_warn_routine)(const char *warn, va_list params);
+
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
 	enum apply_ws_ignore ws_ignore_action;
-- 
2.10.0.41.g9df52c3

