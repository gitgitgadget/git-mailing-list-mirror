Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466441F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162509AbeBNTBE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:04 -0500
Received: from mail-qt0-f202.google.com ([209.85.216.202]:56800 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162500AbeBNTBC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:02 -0500
Received: by mail-qt0-f202.google.com with SMTP id s42so5884069qta.23
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/lgIb7r602KIDHTBVfRQIFSQ7722zNw4THpBEymVDnk=;
        b=RRm6565HMBELyIdM3PnKb2LOcLNhSnl4lXxPGq1slt6eEy1XPRe9o61YDiP67A7xC8
         Rqk9sbJr4PZIuLqhEfCjFAFh7+6WsXR9rTgDVWQhLX/AEh7r3VU1orJsMmg7xMv9FkL4
         Vs5mUmxmMqa2ktZMad/wgE8K389Ol3CI5xqqrECiDx+WNZ+nuSG8Vt6RVxC8GlPWATNB
         nZ6dpVM+asIsLRITBfDr6LsNmyATNuM2HT8cWcsWClogSqntnrByNBcPTAGncG371/1g
         +FtIfpV4/L7EAFbjgYrf+G0jCeVPmnml/FTzQh+XRlUmjjdP/ne4m/qV7eW86JUvoxa+
         EvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/lgIb7r602KIDHTBVfRQIFSQ7722zNw4THpBEymVDnk=;
        b=NnY3c01PFkuAvB4H0qI3tpdOsavyXk0cV57djP6rrKsi27E18oQZw63I70iRgln+bE
         nxE1eynbHX1VLl6J6ijkwgROV19qS378gpyvGU6i7Dhyn5U28t2hmicwuDmbm7QmIaJb
         3ICMlQPKaxkjIsy9ZHSV9Q0oDMYRHI5XKkU2AzcQXaQuC8LgithDEBZI++pEeTinBSXd
         06CSvu3PJ7FDNcn0CqwYHvE4Mtkemjfsf1KDzalUDxw5pEkjghnqbj5DKd/LG+d3816j
         6oVlHk42sAaiybYsmdy2SMu3THR/TM6vkCFKaH7cmy6iSQyIlkPC46AToet7UYlkLdWd
         aJpQ==
X-Gm-Message-State: APf1xPDYk3erCqZX2gMYoXpwE/QWfB3+mkUilrFSuyV+mjl8r0newSkx
        Oi51047eiNjdvBDV4DiE2eKuInIyKzcqIobaKfZ2qAIZPzOtuiQx2jieRjCC9BZW7iL9xy0h9np
        A3GoktqRTFTCioiyXfGc1aExHvFzqaEWLIww+o8Y3vyfA25cnAluRHfGV3g==
X-Google-Smtp-Source: AH8x224j4/FgOxG1gnVWgOkzCnSzWDWFgpyaUPk+9CIJHqHHt/gZxI0HpOCG0rrTMF4akMfyr3pwOAdaIKY=
MIME-Version: 1.0
X-Received: by 10.55.103.11 with SMTP id b11mr38929qkc.56.1518634861323; Wed,
 14 Feb 2018 11:01:01 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:29 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-8-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 07/37] apply: rename 'try' variables
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
 apply.c | 68 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68..071f653c6 100644
--- a/apply.c
+++ b/apply.c
@@ -2386,8 +2386,8 @@ static void update_pre_post_images(struct image *preimage,
 static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *preimage,
 				    struct image *postimage,
-				    unsigned long try,
-				    int try_lno,
+				    unsigned long current,
+				    int current_lno,
 				    int preimage_limit)
 {
 	int i;
@@ -2404,9 +2404,9 @@ static int line_by_line_fuzzy_match(struct image *img,
 
 	for (i = 0; i < preimage_limit; i++) {
 		size_t prelen = preimage->line[i].len;
-		size_t imglen = img->line[try_lno+i].len;
+		size_t imglen = img->line[current_lno+i].len;
 
-		if (!fuzzy_matchlines(img->buf + try + imgoff, imglen,
+		if (!fuzzy_matchlines(img->buf + current + imgoff, imglen,
 				      preimage->buf + preoff, prelen))
 			return 0;
 		if (preimage->line[i].flag & LINE_COMMON)
@@ -2443,7 +2443,7 @@ static int line_by_line_fuzzy_match(struct image *img,
 	 */
 	extra_chars = preimage_end - preimage_eof;
 	strbuf_init(&fixed, imgoff + extra_chars);
-	strbuf_add(&fixed, img->buf + try, imgoff);
+	strbuf_add(&fixed, img->buf + current, imgoff);
 	strbuf_add(&fixed, preimage_eof, extra_chars);
 	fixed_buf = strbuf_detach(&fixed, &fixed_len);
 	update_pre_post_images(preimage, postimage,
@@ -2455,8 +2455,8 @@ static int match_fragment(struct apply_state *state,
 			  struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
-			  unsigned long try,
-			  int try_lno,
+			  unsigned long current,
+			  int current_lno,
 			  unsigned ws_rule,
 			  int match_beginning, int match_end)
 {
@@ -2466,12 +2466,12 @@ static int match_fragment(struct apply_state *state,
 	size_t fixed_len, postlen;
 	int preimage_limit;
 
-	if (preimage->nr + try_lno <= img->nr) {
+	if (preimage->nr + current_lno <= img->nr) {
 		/*
 		 * The hunk falls within the boundaries of img.
 		 */
 		preimage_limit = preimage->nr;
-		if (match_end && (preimage->nr + try_lno != img->nr))
+		if (match_end && (preimage->nr + current_lno != img->nr))
 			return 0;
 	} else if (state->ws_error_action == correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF)) {
@@ -2482,7 +2482,7 @@ static int match_fragment(struct apply_state *state,
 		 * match with img, and the remainder of the preimage
 		 * must be blank.
 		 */
-		preimage_limit = img->nr - try_lno;
+		preimage_limit = img->nr - current_lno;
 	} else {
 		/*
 		 * The hunk extends beyond the end of the img and
@@ -2492,27 +2492,27 @@ static int match_fragment(struct apply_state *state,
 		return 0;
 	}
 
-	if (match_beginning && try_lno)
+	if (match_beginning && current_lno)
 		return 0;
 
 	/* Quick hash check */
 	for (i = 0; i < preimage_limit; i++)
-		if ((img->line[try_lno + i].flag & LINE_PATCHED) ||
-		    (preimage->line[i].hash != img->line[try_lno + i].hash))
+		if ((img->line[current_lno + i].flag & LINE_PATCHED) ||
+		    (preimage->line[i].hash != img->line[current_lno + i].hash))
 			return 0;
 
 	if (preimage_limit == preimage->nr) {
 		/*
 		 * Do we have an exact match?  If we were told to match
-		 * at the end, size must be exactly at try+fragsize,
-		 * otherwise try+fragsize must be still within the preimage,
+		 * at the end, size must be exactly at current+fragsize,
+		 * otherwise current+fragsize must be still within the preimage,
 		 * and either case, the old piece should match the preimage
 		 * exactly.
 		 */
 		if ((match_end
-		     ? (try + preimage->len == img->len)
-		     : (try + preimage->len <= img->len)) &&
-		    !memcmp(img->buf + try, preimage->buf, preimage->len))
+		     ? (current + preimage->len == img->len)
+		     : (current + preimage->len <= img->len)) &&
+		    !memcmp(img->buf + current, preimage->buf, preimage->len))
 			return 1;
 	} else {
 		/*
@@ -2543,7 +2543,7 @@ static int match_fragment(struct apply_state *state,
 	 */
 	if (state->ws_ignore_action == ignore_ws_change)
 		return line_by_line_fuzzy_match(img, preimage, postimage,
-						try, try_lno, preimage_limit);
+						current, current_lno, preimage_limit);
 
 	if (state->ws_error_action != correct_ws_error)
 		return 0;
@@ -2577,10 +2577,10 @@ static int match_fragment(struct apply_state *state,
 	 */
 	strbuf_init(&fixed, preimage->len + 1);
 	orig = preimage->buf;
-	target = img->buf + try;
+	target = img->buf + current;
 	for (i = 0; i < preimage_limit; i++) {
 		size_t oldlen = preimage->line[i].len;
-		size_t tgtlen = img->line[try_lno + i].len;
+		size_t tgtlen = img->line[current_lno + i].len;
 		size_t fixstart = fixed.len;
 		struct strbuf tgtfix;
 		int match;
@@ -2666,8 +2666,8 @@ static int find_pos(struct apply_state *state,
 		    int match_beginning, int match_end)
 {
 	int i;
-	unsigned long backwards, forwards, try;
-	int backwards_lno, forwards_lno, try_lno;
+	unsigned long backwards, forwards, current;
+	int backwards_lno, forwards_lno, current_lno;
 
 	/*
 	 * If match_beginning or match_end is specified, there is no
@@ -2687,25 +2687,25 @@ static int find_pos(struct apply_state *state,
 	if ((size_t) line > img->nr)
 		line = img->nr;
 
-	try = 0;
+	current = 0;
 	for (i = 0; i < line; i++)
-		try += img->line[i].len;
+		current += img->line[i].len;
 
 	/*
 	 * There's probably some smart way to do this, but I'll leave
 	 * that to the smart and beautiful people. I'm simple and stupid.
 	 */
-	backwards = try;
+	backwards = current;
 	backwards_lno = line;
-	forwards = try;
+	forwards = current;
 	forwards_lno = line;
-	try_lno = line;
+	current_lno = line;
 
 	for (i = 0; ; i++) {
 		if (match_fragment(state, img, preimage, postimage,
-				   try, try_lno, ws_rule,
+				   current, current_lno, ws_rule,
 				   match_beginning, match_end))
-			return try_lno;
+			return current_lno;
 
 	again:
 		if (backwards_lno == 0 && forwards_lno == img->nr)
@@ -2718,8 +2718,8 @@ static int find_pos(struct apply_state *state,
 			}
 			backwards_lno--;
 			backwards -= img->line[backwards_lno].len;
-			try = backwards;
-			try_lno = backwards_lno;
+			current = backwards;
+			current_lno = backwards_lno;
 		} else {
 			if (forwards_lno == img->nr) {
 				i++;
@@ -2727,8 +2727,8 @@ static int find_pos(struct apply_state *state,
 			}
 			forwards += img->line[forwards_lno].len;
 			forwards_lno++;
-			try = forwards;
-			try_lno = forwards_lno;
+			current = forwards;
+			current_lno = forwards_lno;
 		}
 
 	}
-- 
2.16.1.291.g4437f3f132-goog

