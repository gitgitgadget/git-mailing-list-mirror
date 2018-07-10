Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C391F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbeGJUAA (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 16:00:00 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:37121 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbeGJUAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 16:00:00 -0400
Received: by mail-ua0-f201.google.com with SMTP id z33-v6so6719402uah.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SFwrLl0ajU01PltLpzFMpqiAx79mj/qhwpveuqBWqQw=;
        b=AtuHuOVQZVfKHVTF3WtRkQYc5/sY6VsvNl4Qf4cnAC2zQ24NWUqYzAAbkFQ0jcuI3j
         rRehJZo5et0rmX5EAN8T6RwJrB4m2EIoyZBvQgo3B0cUvigvW8+D3r3MxXi6QfqoQ4Rz
         1cIVA+QSJoHA7CvVp0oGDApvWjnZSAsC8RRPM3uBDUbvDB66l1hCzzkan0C2c/R0uhpC
         t9FYA5puRwp7ZE535KxJzPXBWX+2OaLrAjspGnIHkq7eRkllXnKbQOAoL3w7CU6WpLbb
         Lb/PUQ1NBubnqd4IoIMFFmO62tEV/E8TcA1y5MFWpplusn9lBOV2BvRKkW+70zXBE6nr
         nGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SFwrLl0ajU01PltLpzFMpqiAx79mj/qhwpveuqBWqQw=;
        b=Ow/D5FgybA4OaZ0PzOE2n2WYqrADK7HgpoqAdUlqUFAPkqW1YbpzMxOC2lWqDjaERi
         qqJha2onP+eXxrY/6mpmWJQGvTe3N95bdflsPnA+Pyj9QojsDImzKgxw+OzLh7CQB3u9
         ZFcxUIgNMMcSCJgVABtWaW6PORcXQtXwOEV5j3rCCQeEWnqYGSZAG+oFO7LoW33dh9OM
         3ZgFMZyiwHuiV/oeG8a4qXHl8nC1zNWXXZGpkoP8+T8ZH8eZq0nSsTjSkPHmSuaDiZK8
         M7HV0UZ/hhhiYkoQz4vKmjue/dUyVSespujItvZA3iBEwszAKeNpFlr8YgQ1im33DxYG
         SfTw==
X-Gm-Message-State: APt69E1F2upKmgApiCLMO5reNMZPh2kjfqXd8U7Lwk/c8fyO9LG4IHTQ
        dej7D5mwOA114kW6x3icHD89bnd5uvFB
X-Google-Smtp-Source: AAOMgpcEQCZTT0yS0aS+EOPTomPUymenyVpVnKVb6yMH450/gy84EfG8FMkelQnhsSvrJl9/u6RabkOR5oem
MIME-Version: 1.0
X-Received: by 2002:ab0:260a:: with SMTP id c10-v6mr13046294uao.12.1531252764958;
 Tue, 10 Jul 2018 12:59:24 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:59:21 -0700
In-Reply-To: <20180710174552.30123-3-sbeller@google.com>
Message-Id: <20180710195921.131548-1-sbeller@google.com>
References: <20180710174552.30123-3-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] diff.c: clarify emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emit_line_0 grew complicated again, so here is an attempt to make it
a bit simpler. emit_line_0 is called for all lines that are added,
removed or context lines, and it follows the format:

 <sign color> <sign> <main color> <content of length 'len'> <reset> \
    <CR> <LF>

with each of the components optional.

Another follow up cleanup (that also touches the tests) could be
a stricter check to consolidate with ws_check_emit (and not emit the
color/reset twice).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
 oops wrong patch, this one should do.
 Now this passes all tests. 

 diff.c                     | 84 +++++++++++++++++++-------------------
 t/t4015-diff-whitespace.sh | 10 ++---
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/diff.c b/diff.c
index 028d7d9a59c..0b00df7b3c8 100644
--- a/diff.c
+++ b/diff.c
@@ -563,42 +563,48 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set, unsigned reverse, const char *reset,
-			int first, const char *line, int len)
+			const char *maincolor, const char *signcolor,
+			const char *reset, const char *sign,
+			const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
 	FILE *file = o->file;
 
-	if (first)
-		fputs(diff_line_prefix(o), file);
-	else if (!len)
-		return;
+	fputs(diff_line_prefix(o), file);
 
-	if (len == 0) {
-		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
-		nofirst = has_trailing_newline || has_trailing_carriage_return;
-	} else {
-		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-		if (has_trailing_newline)
-			len--;
-		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-		if (has_trailing_carriage_return)
-			len--;
-		nofirst = 0;
-	}
+	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	if (has_trailing_newline)
+		len--;
+	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_carriage_return)
+		len--;
+
+	/*
+	 * Color the sign differently if requested, otherwise use the main
+	 * color.
+	 */
+	if (signcolor)
+		fputs(signcolor, file);
+	else if (maincolor)
+		fputs(maincolor, file);
+
+	if (sign)
+		fputs(sign, file);
+
+	/*
+	 * Only put the main color here if it we did not color the sign the
+	 * same way already
+	 */
+	if (signcolor && maincolor && strcmp(signcolor, maincolor))
+		fputs(maincolor, file);
 
-	if (len || !nofirst) {
-		if (reverse && want_color(o->use_color))
-			fputs(GIT_COLOR_REVERSE, file);
-		fputs(set, file);
-		if (first && !nofirst)
-			fputc(first, file);
+	if (len)
 		fwrite(line, len, 1, file);
+
+	if (((maincolor && *maincolor) || (signcolor && *signcolor) || len > 0)
+	    && reset)
 		fputs(reset, file);
-	}
+
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
 	if (has_trailing_newline)
@@ -608,7 +614,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, NULL, line, len);
 }
 
 enum diff_symbol {
@@ -980,20 +986,16 @@ static void emit_line_ws_markup(struct diff_options *o,
 			ws = NULL;
 	}
 
-	if (!ws && !set_sign)
-		emit_line_0(o, set, 0, reset, sign[0], line, len);
-	else if (!ws) {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign[0], "", 0);
-		emit_line_0(o, set, 0, reset, 0, line, len);
-	} else if (blank_at_eof)
+	if (!ws)
+		emit_line_0(o, set, set_sign, reset,
+			    sign, line, len);
+	else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, 0, reset, sign[0], line, len);
+		emit_line_0(o, ws, set_sign, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign[0], "", 0);
+		emit_line_0(o, set, set_sign, reset,
+			    sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1016,7 +1018,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, 0, reset, '\\',
+		emit_line_0(o, context, 0, reset, "\\",
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3ab..95baf237a83 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -945,7 +945,7 @@ test_expect_success 'ws-error-highlight test setup' '
 	<BOLD>--- a/x<RESET>
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
-	 <RESET>0. blank-at-eol<RESET><BLUE> <RESET>
+	 0. blank-at-eol<RESET><BLUE> <RESET>
 	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
 	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
 	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
@@ -1140,7 +1140,7 @@ test_expect_success 'detect malicious moved code, inside file' '
 	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
 	 printf("World\n");<RESET>
 	 }<RESET>
-	 <RESET>
+	 
 	<BRED>-int secure_foo(struct user *u)<RESET>
 	<BRED>-{<RESET>
 	<BLUE>-if (!u->is_allowed_foo)<RESET>
@@ -1158,7 +1158,7 @@ test_expect_success 'detect malicious moved code, inside file' '
 	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
 	 printf("Hello World, but different\n");<RESET>
 	 }<RESET>
-	 <RESET>
+	 
 	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
 	<BGREEN>+<RESET><BGREEN>{<RESET>
 	<GREEN>+<RESET><GREEN>foo(u);<RESET>
@@ -1189,7 +1189,7 @@ test_expect_success 'plain moved code, inside file' '
 	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
 	 printf("World\n");<RESET>
 	 }<RESET>
-	 <RESET>
+	 
 	<BRED>-int secure_foo(struct user *u)<RESET>
 	<BRED>-{<RESET>
 	<BRED>-if (!u->is_allowed_foo)<RESET>
@@ -1207,7 +1207,7 @@ test_expect_success 'plain moved code, inside file' '
 	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
 	 printf("Hello World, but different\n");<RESET>
 	 }<RESET>
-	 <RESET>
+	 
 	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
 	<BGREEN>+<RESET><BGREEN>{<RESET>
 	<BGREEN>+<RESET><BGREEN>foo(u);<RESET>
-- 
2.18.0.203.gfac676dfb9-goog

