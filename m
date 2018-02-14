Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBA51F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162491AbeBNTBd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:33 -0500
Received: from mail-io0-f202.google.com ([209.85.223.202]:36977 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162538AbeBNTB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:28 -0500
Received: by mail-io0-f202.google.com with SMTP id q4so8338301ioh.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=E1XOl+ZMH3zI4K02jHiZa2FaxJLxcmc530uuzOwQWwI=;
        b=fTXBjYjQTb0gZirrKELaPIoy0rS0AUVJo1FvorRl4kAMe4WOsHgOBfkZgbnrWHj+PT
         zcMQW0tg7KoLoThV4mvBBWVH31PvNgkOJ0ksh/xFHe8vR4h3Xsqqktm5FQ+pCcYQnOgv
         ucP5gSj1nF92o2o6/oFXsvz4p2YyfxuJqOpiO1BthaHsuV+ghczOGyUvrsDJp7Vk02Jw
         Y9kQu6ifVyrrwyLb/M2S+3AEW0a7k54yvliLD1hq1RHI99gPm1WQ3Z3Ro8WxHf3jXR/f
         W0KHZlOMFRWxm1INR4OwSHZsvKCn/BeN4ASS5nWpfJb8go0qjFgAEXp9Mg9p3bRv4dIK
         6gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=E1XOl+ZMH3zI4K02jHiZa2FaxJLxcmc530uuzOwQWwI=;
        b=kCuFaDWjKizr+D3pSF3acshLjF5UNCZ2DoBb4teCSRAwedNOj1LLBmAGx38b4V7dvY
         jcm9t0tJyLRvYDHQf8TwtiZKeam85uR5kpbH6YcRQjekKzf5WM28wA1YonswWypL2fvw
         DaZEKNIwtxyeK9Xh7PCtU7A6CzNCgFwdNjSbnx/otFUc450h3P6qMDZpDyErM8VmuEvf
         wQV/OaGExvDG7CSbieE55d9W1Q2vdGfRUEuS3gZGOD5OrCU0SGwlsVmI8qXwbLdmrjcd
         DM6hQ7kVjf1A8oGkn08Mqv27aMO3m8Mjtoo8msBDdIFX7SXRk7RaxomVGzeNbR5vKap+
         ua/Q==
X-Gm-Message-State: APf1xPBTWXck0/6O343oZ4K4SFcnV2XNHM2S8zpKrnNE4kkLpMDN+cuG
        xJdAiAyEX/iR7A/0QxfXACPU9QSpZkrffAzvUGIsH7f5KUkeFtRmRc5XxbUAVBPKKTlVGPuQGMu
        gKhifLsHmp0ifqvW9/1xfR9f2uWpgkrmQp0zAxz9W25l3LsasMKLwOG3Eqg==
X-Google-Smtp-Source: AH8x226tcJVSmPvjN78eEsOx0wk73iFKQP8vNYb2/on3UIm30oYvJZbozcaGjP9xJCOcyw4XzBJgM6mah2Q=
MIME-Version: 1.0
X-Received: by 10.36.172.107 with SMTP id m43mr14971iti.8.1518634887984; Wed,
 14 Feb 2018 11:01:27 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:39 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-18-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 17/37] diff: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index d682d0d1f..2de9c5ed2 100644
--- a/diff.c
+++ b/diff.c
@@ -1504,7 +1504,7 @@ struct diff_words_style_elem {
 
 struct diff_words_style {
 	enum diff_words_type type;
-	struct diff_words_style_elem new, old, ctx;
+	struct diff_words_style_elem new_word, old_word, ctx;
 	const char *newline;
 };
 
@@ -1655,12 +1655,12 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 	if (minus_begin != minus_end) {
 		fn_out_diff_words_write_helper(diff_words->opt,
-				&style->old, style->newline,
+				&style->old_word, style->newline,
 				minus_end - minus_begin, minus_begin);
 	}
 	if (plus_begin != plus_end) {
 		fn_out_diff_words_write_helper(diff_words->opt,
-				&style->new, style->newline,
+				&style->new_word, style->newline,
 				plus_end - plus_begin, plus_begin);
 	}
 
@@ -1758,7 +1758,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 		emit_diff_symbol(diff_words->opt, DIFF_SYMBOL_WORD_DIFF,
 				 line_prefix, strlen(line_prefix), 0);
 		fn_out_diff_words_write_helper(diff_words->opt,
-			&style->old, style->newline,
+			&style->old_word, style->newline,
 			diff_words->minus.text.size,
 			diff_words->minus.text.ptr);
 		diff_words->minus.text.size = 0;
@@ -1883,8 +1883,8 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 	}
 	if (want_color(o->use_color)) {
 		struct diff_words_style *st = ecbdata->diff_words->style;
-		st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
-		st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
+		st->old_word.color = diff_get_color_opt(o, DIFF_FILE_OLD);
+		st->new_word.color = diff_get_color_opt(o, DIFF_FILE_NEW);
 		st->ctx.color = diff_get_color_opt(o, DIFF_CONTEXT);
 	}
 }
@@ -2047,8 +2047,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 static char *pprint_rename(const char *a, const char *b)
 {
-	const char *old = a;
-	const char *new = b;
+	const char *old_name = a;
+	const char *new_name = b;
 	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int pfx_adjust_for_slash;
@@ -2067,16 +2067,16 @@ static char *pprint_rename(const char *a, const char *b)
 
 	/* Find common prefix */
 	pfx_length = 0;
-	while (*old && *new && *old == *new) {
-		if (*old == '/')
-			pfx_length = old - a + 1;
-		old++;
-		new++;
+	while (*old_name && *new_name && *old_name == *new_name) {
+		if (*old_name == '/')
+			pfx_length = old_name - a + 1;
+		old_name++;
+		new_name++;
 	}
 
 	/* Find common suffix */
-	old = a + len_a;
-	new = b + len_b;
+	old_name = a + len_a;
+	new_name = b + len_b;
 	sfx_length = 0;
 	/*
 	 * If there is a common prefix, it must end in a slash.  In
@@ -2087,13 +2087,13 @@ static char *pprint_rename(const char *a, const char *b)
 	 * underrun the input strings.
 	 */
 	pfx_adjust_for_slash = (pfx_length ? 1 : 0);
-	while (a + pfx_length - pfx_adjust_for_slash <= old &&
-	       b + pfx_length - pfx_adjust_for_slash <= new &&
-	       *old == *new) {
-		if (*old == '/')
-			sfx_length = len_a - (old - a);
-		old--;
-		new--;
+	while (a + pfx_length - pfx_adjust_for_slash <= old_name &&
+	       b + pfx_length - pfx_adjust_for_slash <= new_name &&
+	       *old_name == *new_name) {
+		if (*old_name == '/')
+			sfx_length = len_a - (old_name - a);
+		old_name--;
+		new_name--;
 	}
 
 	/*
-- 
2.16.1.291.g4437f3f132-goog

