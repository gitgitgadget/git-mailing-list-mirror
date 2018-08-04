Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9267C208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHDDwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:13 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:47262 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:12 -0400
Received: by mail-qt0-f201.google.com with SMTP id b7-v6so5771621qtp.14
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kwtfkIDEjYBpw967jgTVGwSQJvr3UNTZF0Wj+VFuSjk=;
        b=cHuzJhfj3/vOPk4OYjPn5fIKSB/2pYMDe6fZS5o8oUhMfM5D/r3UXjPo15EZ+fo9NQ
         OI9/ylyrPawDmUW53Taw9KtcfbdWK9la1NC2uUBtjOUOsZmWtwlG23xTts8jBHF4Fci/
         iaBcKznZyXRjxXVcFMHAcfUwjM0SW2vzyVon1rYlS0YFx1kwjHG/trPBRg3BkPZbtUt0
         uQCBq23Smn5YOWppg0M9o8ZRV1QkP0lG0NVVBEmQubYONwEl9aIYghi5F2UQDYG5Wc3D
         azJAhH4mxgArT6FXbcCvqko02QbnSDL77jddeMp9ItJXfnbZtVtERPkXddl3KX03PS0G
         LQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kwtfkIDEjYBpw967jgTVGwSQJvr3UNTZF0Wj+VFuSjk=;
        b=rOAOYRjKUVCSiyx53Q7oVNwk14WVlydon9HVtbgS+bX6mESpn7DpLbPge4wfN7B+Pl
         s3HW76S2fzNaXXKpQKQkNFC2rLnWJpR1fvY2SLOqn6wk5nk7qJi4qRyiRp3G903OJ80M
         nkQ1Y6TR4Mu2JBS4UWCMN/TJfHYfC2Op0mVRbQUbsKNW3WDh+qtqjiMEy7U1vQqJjMbx
         iBmGEtWMXhh6R7pYm0l87dYsEKYjpMX7dTixnaJdzt2KgSg6qo3C5W4SeVDWn21muoG4
         8dlD9vMhe2rLYnMj3GmlFsurzdAFJNKfNkD3YjnlQX1WdwiV1KbmeFJy/SmQle0tQLwT
         jI8g==
X-Gm-Message-State: AOUpUlFJlFpby2Zb8xdtQbfW4woUmgLZmYuzYvEDpe/DscWq1pArUpAo
        uUj0urti8W0mFY8STjIqQUOSsWEnUbb1YXu9BACzWBWgRUj6fH5hfdU2PXEaSADRQgAcHlMRYbb
        XNRvHgLrB+x7kixZNXBOKxeXbDkYM0X1svrsUozPWyCrw7Jo1Gwi7lf6yquAF
X-Google-Smtp-Source: AAOMgpdhg/smdEdaO3Cl4a11ms2qzG1FaT2XMq/N8ccq6yTdZozvMwMmyMI+whIR0Q6nihrOqoCZjpxgLQc8
X-Received: by 2002:a0c:adad:: with SMTP id w42-v6mr4955168qvc.7.1533347603565;
 Fri, 03 Aug 2018 18:53:23 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:11 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/7] diff.c: emit_line_0 to take string instead of first sign
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By providing a string as the first part of the emission we can extend
it later more easily.

While at it, document emit_line_0.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 2bd4d3d6839..57a8a38755e 100644
--- a/diff.c
+++ b/diff.c
@@ -575,9 +575,15 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
+/*
+ * Emits
+ * <set_sign> <first> <reset> <set> <second> <reset> LF
+ * if they are present. 'first' is a NULL terminated string,
+ * 'second' is a buffer of length 'len'.
+ */
 static void emit_line_0(struct diff_options *o,
 			const char *set_sign, const char *set, const char *reset,
-			int first, const char *line, int len)
+			const char *first, const char *second, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int reverse = !!set && !!set_sign;
@@ -587,11 +593,11 @@ static void emit_line_0(struct diff_options *o,
 
 	fputs(diff_line_prefix(o), file);
 
-	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	has_trailing_newline = (len > 0 && second[len-1] == '\n');
 	if (has_trailing_newline)
 		len--;
 
-	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	has_trailing_carriage_return = (len > 0 && second[len-1] == '\r');
 	if (has_trailing_carriage_return)
 		len--;
 
@@ -609,7 +615,7 @@ static void emit_line_0(struct diff_options *o,
 	}
 
 	if (first)
-		fputc(first, file);
+		fputs(first, file);
 
 	if (!len)
 		goto end_of_line;
@@ -620,7 +626,7 @@ static void emit_line_0(struct diff_options *o,
 		fputs(set, file);
 		needs_reset = 1;
 	}
-	fwrite(line, len, 1, file);
+	fwrite(second, len, 1, file);
 	needs_reset |= len > 0;
 
 end_of_line:
@@ -635,7 +641,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, reset, 0, line, len);
+	emit_line_0(o, set, NULL, reset, NULL, line, len);
 }
 
 enum diff_symbol {
@@ -996,7 +1002,7 @@ static void dim_moved_lines(struct diff_options *o)
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set_sign, const char *set,
 				const char *reset,
-				char sign, const char *line, int len,
+				const char *sign, const char *line, int len,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -1039,7 +1045,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, NULL, reset, '\\',
+		emit_line_0(o, context, NULL, reset, "\\",
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
@@ -1077,7 +1083,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1120,7 +1126,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags |= WS_IGNORE_FIRST_SPACE;
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset, "+", line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1163,7 +1169,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
+		emit_line_ws_markup(o, set_sign, set, reset, "-", line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.597.ga71716f1ad-goog

