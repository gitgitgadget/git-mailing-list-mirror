Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9EA1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeA2WiX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:23 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:46844 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeA2WiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:21 -0500
Received: by mail-yw0-f202.google.com with SMTP id z193so6445339ywd.13
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=m2Gxyenwyc+3tt/3HikUs20SfeRr4E/AlqyGadDsU4s=;
        b=f9O2Gg6xFRAZIl/A+MhSsHCAghrj8H/uUCBABa3aLY+jHq8NduIBDn6T9cADIyO9AC
         OjoU3CauUD+ODK/cv6RyCcoYPQDsmkMBUkAJjj9cMfNxtFUSWnL5MLVkah543Crhe6LD
         q+7uT0Z+mymTq/JDDraZTeXGMKW/ZkPUAW8Y/+S589ASB/BHxpUq6Jg4dr3KJJXr8rWG
         PPZ3NAbTosdtNMFRM1yJz/0cshIlQNCdj059PGj4gL5UXZqqZDd3+r8zJhTm2ekvq9qz
         XQxmw2AirZ63AOME7BrbxJYR6IfdXuPJCBdiOTN0Rv9IRsWXYXcLUNZrD3i5wmCgbDNf
         DXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=m2Gxyenwyc+3tt/3HikUs20SfeRr4E/AlqyGadDsU4s=;
        b=igc6BuTGN4qZWEL3hrWZ9WcU4aw1hH4zY49gMJYtUn3/9YI5Wj1oOnWhluF/M6LzR5
         TtXjAeIixCW23GZNqLNGDFiUisiIevpLzedGZtrxVq5EqAb3hh5L0Gm8gJXsfWAvjkuk
         fpFCOIYSzl3BfCto4AMWyVI2E/5rTmtjL3Jvralwepcha//CmcWgis3iC4s29f0fNRTY
         jL2UnefVZS/1HvHy88Oy4ShE0vD3yHxjNtI38shhvnqZ8tqcgLEYhP4X1O59Qs1r+VHS
         04VKSgs2hJ1IyQ0U9iM3z440Gb9SHh694Tt9ve4f+VJLmlFXqYu5BppAenqFD9Ym1A6f
         zqMg==
X-Gm-Message-State: AKwxytd7yB1cbjc2nDsxLBF3+Rw6kdlgCyfo0ht0ImkTdq7/pCwg1xdS
        4dooh2J/Udos9x2J35VowoV+h1Il0wf2UsCB3sod1VBYg2aY2BSGLqqVrfWTTo9YgjEpbohFfCT
        L3Ps/s7gvOmazapOg7NISYe9Ov4sDM3QwPFEcCpd4KCIb9uO74zbtljnaMA==
X-Google-Smtp-Source: AH8x227czcpUeJV2wh57WrV6zSJA7vTdZvlxq5/g8jhZQB/Nb8pKFtNVBaXT8qiCG2IgB0wEgw6+veHaBwQ=
MIME-Version: 1.0
X-Received: by 10.13.232.137 with SMTP id r131mr10623683ywe.201.1517265500970;
 Mon, 29 Jan 2018 14:38:20 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:08 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-18-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 17/37] diff: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index d682d0d1f..d49732b3b 100644
--- a/diff.c
+++ b/diff.c
@@ -1504,7 +1504,7 @@ struct diff_words_style_elem {
 
 struct diff_words_style {
 	enum diff_words_type type;
-	struct diff_words_style_elem new, old, ctx;
+	struct diff_words_style_elem new_word, old, ctx;
 	const char *newline;
 };
 
@@ -1660,7 +1660,7 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 	if (plus_begin != plus_end) {
 		fn_out_diff_words_write_helper(diff_words->opt,
-				&style->new, style->newline,
+				&style->new_word, style->newline,
 				plus_end - plus_begin, plus_begin);
 	}
 
@@ -1884,7 +1884,7 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 	if (want_color(o->use_color)) {
 		struct diff_words_style *st = ecbdata->diff_words->style;
 		st->old.color = diff_get_color_opt(o, DIFF_FILE_OLD);
-		st->new.color = diff_get_color_opt(o, DIFF_FILE_NEW);
+		st->new_word.color = diff_get_color_opt(o, DIFF_FILE_NEW);
 		st->ctx.color = diff_get_color_opt(o, DIFF_CONTEXT);
 	}
 }
@@ -2048,7 +2048,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 static char *pprint_rename(const char *a, const char *b)
 {
 	const char *old = a;
-	const char *new = b;
+	const char *new_name = b;
 	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int pfx_adjust_for_slash;
@@ -2067,16 +2067,16 @@ static char *pprint_rename(const char *a, const char *b)
 
 	/* Find common prefix */
 	pfx_length = 0;
-	while (*old && *new && *old == *new) {
+	while (*old && *new_name && *old == *new_name) {
 		if (*old == '/')
 			pfx_length = old - a + 1;
 		old++;
-		new++;
+		new_name++;
 	}
 
 	/* Find common suffix */
 	old = a + len_a;
-	new = b + len_b;
+	new_name = b + len_b;
 	sfx_length = 0;
 	/*
 	 * If there is a common prefix, it must end in a slash.  In
@@ -2088,12 +2088,12 @@ static char *pprint_rename(const char *a, const char *b)
 	 */
 	pfx_adjust_for_slash = (pfx_length ? 1 : 0);
 	while (a + pfx_length - pfx_adjust_for_slash <= old &&
-	       b + pfx_length - pfx_adjust_for_slash <= new &&
-	       *old == *new) {
+	       b + pfx_length - pfx_adjust_for_slash <= new_name &&
+	       *old == *new_name) {
 		if (*old == '/')
 			sfx_length = len_a - (old - a);
 		old--;
-		new--;
+		new_name--;
 	}
 
 	/*
-- 
2.16.0.rc1.238.g530d649a79-goog

