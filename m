Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66801F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbeGJShl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:37:41 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:58492 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390043AbeGJShl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:37:41 -0400
Received: by mail-it0-f73.google.com with SMTP id y13-v6so5610ita.8
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yURvk98iJ+tLD6mv0lGmDqEaEwSG39fBkQoICNzSIoQ=;
        b=dY5w21Hv+7cgKC+rnPxj15jdvFqiBgnzUeY3layyEU3H7q/VDfkLG+Jl73zRgvdMdO
         TrSDEG1+q/zXufjU/mCbOzSB0sgWIQKKtkCjC68GL4YmOnWsJPmNA3xG994IJtldmffp
         0yJM7VNsS6RKqte0ewLb1SU5KNLCKe59hfw3fXMozsXULJOboK/wqT1assrfGEe3ltim
         pNE36tH5LlnLJ/Qu/mPcElhoEnx90Zk/Yh5ZPU6oN0GI9NBn9V+bNLgUQR79uiQLQXPK
         ONhs5ckvdKOQFaRMAfyVKY1GJ4wCcZCFcEXO209tnaMiD568xpZbZdRBTMW/2faIac+k
         BtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yURvk98iJ+tLD6mv0lGmDqEaEwSG39fBkQoICNzSIoQ=;
        b=sgF2RmE1vpgxVebgO6c+cNIwmTppkiXWzGjKgBcwUrQg5HddSNtB5wmvE4vPfyWsvu
         8ioyo8OAZOQTeWbyb8qri3QcKNTbhG1aQbuqOUOVgymheENGENak0QDXwfh98lCuEwjA
         XwmaQCmTaAcovLALZ50G/luq9prQFk15Ulg6Pxt0oQ5hijyGxtAOWuCYM8SVKeVwjCkh
         Tc10p4SzeTULh9tcEoh3vasOIzOgkmbRNau1R4giBQXaXFU3+UIjEl19E4BXFoa2m7Qu
         YK6P6KkIxJurFLQFcLfmKlLxMvQwbaZ7N3QXlS/NC/pv12hB1Hd54NgidP7tfc5jP0e0
         bBaQ==
X-Gm-Message-State: AOUpUlHfd9+CHG0+PrFOFWAZHllE3BnhXYE6nZOg4dkE2iTjlXx/Kgpx
        wi2Mooi6m0pQu8K/BECkp5W54eubIbgN
X-Google-Smtp-Source: AAOMgpcbg4KyVM2qdW5KAD7WmEzC+o7Ee7QuRTgW6ii+GBy3L+5JN0AQwTMPL3mL9cBp02VI1g7JuMWH4w51
MIME-Version: 1.0
X-Received: by 2002:a6b:e0d:: with SMTP id 13-v6mr10943104ioo.91.1531244765052;
 Tue, 10 Jul 2018 10:46:05 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:45:52 -0700
In-Reply-To: <20180710174552.30123-1-sbeller@google.com>
Message-Id: <20180710174552.30123-3-sbeller@google.com>
References: <CAGZ79kb4RS-KxEX+x07XsFiGwgG+1AiRUha=zcxexe1=RLL8kg@mail.gmail.com>
 <20180710174552.30123-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 2/2] WIP diff.c: clarify emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This breaks t4034 (word diffs), but all other tests pass.

emit_line_0 grew complicated again, so here is an attempt to make it
a bit simpler. emit_line_0 is called for all lines that are added,
removed or context lines, and it follows the format:

 <sign color> <sign> <main color> <content of length 'len'> <reset> <CR> <LF>

with each of the components optional. However a few rules apply:
* The CR/LF is passed to the function as part of line/len, so we have
  to figure out if we need to separate them
* As the sign color is a rather recent addition, we do not optimize it
  yet
* the main color insertion is new, as the color used to be inserted before
  the sign
* another follow up cleanup (that also touches the tests) could be
  a stricter check to consolidate with ws_check_emit (and not emit the
  color/reset twice)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 78 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/diff.c b/diff.c
index 028d7d9a59c..7b649f57c27 100644
--- a/diff.c
+++ b/diff.c
@@ -563,44 +563,44 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
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
 
-	if (len || !nofirst) {
-		if (reverse && want_color(o->use_color))
-			fputs(GIT_COLOR_REVERSE, file);
-		fputs(set, file);
-		if (first && !nofirst)
-			fputc(first, file);
+	if (signcolor)
+		fputs(signcolor, file);
+	else if (maincolor)
+		fputs(maincolor, file);
+
+
+	if (sign)
+		fputs(sign, file);
+
+	/* only put main color here if it we did not color the sign the same way */
+	if (signcolor && maincolor && signcolor != maincolor)
+		fputs(maincolor, file);
+
+	if (len)
 		fwrite(line, len, 1, file);
+
+	if ((signcolor || maincolor) && reset)
 		fputs(reset, file);
-	}
+
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
+
 	if (has_trailing_newline)
 		fputc('\n', file);
 }
@@ -608,7 +608,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, NULL, line, len);
 }
 
 enum diff_symbol {
@@ -980,20 +980,16 @@ static void emit_line_ws_markup(struct diff_options *o,
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
@@ -1016,7 +1012,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, 0, reset, '\\',
+		emit_line_0(o, context, 0, reset, "\\",
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.203.gfac676dfb9-goog

