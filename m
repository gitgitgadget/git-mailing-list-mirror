Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2477820248
	for <e@80x24.org>; Mon,  1 Apr 2019 11:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDALwZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 07:52:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35105 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfDALwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 07:52:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so11652897wrp.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 04:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fQGLcsP8b0xhCiAE8VECvDgo9rLVdIlf6Wtt4kZfkM=;
        b=KbkjvsxmmDb53Qttl1Keac5yjD0cu4chRPJHepTB5f38w3WMDUrDQsQRJCVNylBLu7
         vHX++YsqJAdUD3+F0NmFbVcg6Fu8nGFV2Lvu4dxOD3HWk/FYe5Ayl7BCd0wozf3oo22s
         pasBa2FQLcUaiSJmeF3xVjTR241H3jxOYBrSC86GPlC2IMqSAc0//p5QtHkCyrgvpAjT
         jDo0bH02+xk62VMOxqSc1icTr4fcrYZ+2BL/8qtxg8E/U+8u6373sdd5h6bKCcqBOrso
         gyVx2dVOzEfSmmqIvnj+od2Xm/+Qp5CXIkF9Nl3rpdCsbrz/UOPutiCTj3WmULlCWc0+
         jkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fQGLcsP8b0xhCiAE8VECvDgo9rLVdIlf6Wtt4kZfkM=;
        b=jSJx4/vt0AT3biRAQKiBQKVLLbp8tENLVXTh0pAkCZNVsKv9ej4jHA3NZ48xfip2oS
         oCcSMZ1jBKCl8rUruvbPEYNrLNV8nVqKmOGnNy7/wU9R5DM7QFlT6z/PSw3qQUbiRUQR
         jwb5wqOGxB6Cthn4+qvC7eIOxF4nX3Xn0GnVUmZB77o4QJK4l0Yofz6RZfOUWMqmvvEB
         y6GzRqDAokYWLXQ7tdZl6lhQEj0XLF1e+ahFxNFCHO4ppwhLMw44WpZ2Q2FfeLo4tqGu
         jyQ/7eHtDorK/WgucqYFetDp9TWDdRuzdl+cIfyU773BtscAqSpTkOT0Cf4Gtd5bKcMS
         Xnug==
X-Gm-Message-State: APjAAAVm55qz1N/iTlQJSoGvTc8VK+Ds/yw60hc3NyLU/qOhqLvexjXO
        OGGwrQ2vOKJeefu8FOYScm/bM25R
X-Google-Smtp-Source: APXvYqyGebaYVpBZzUFBbfemWe0m2rREEfFxvQf0JguuGyua5XGux1UcKGNqbup7sGwOQQieh5HTyQ==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr38916430wrq.209.1554119542051;
        Mon, 01 Apr 2019 04:52:22 -0700 (PDT)
Received: from localhost.localdomain (x4db6660d.dyn.telefonica.de. [77.182.102.13])
        by smtp.gmail.com with ESMTPSA id f11sm11250970wrm.30.2019.04.01.04.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 04:52:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/4] Progress display fixes
Date:   Mon,  1 Apr 2019 13:52:13 +0200
Message-Id: <20190401115217.3423-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190325103844.26749-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes two progress display issues:

  - When showing throughput, and the both the total and the throughput
    change units in the same update, than the previously shown
    progress bar is not cleaned up properly:

      Receiving objects:  25% (2901/11603), 772.01 KiB | 733.00 KiB/s
      Receiving objects:  27% (3133/11603), 1.43 MiB | 1.16 MiB/s   s

  - When the progress bar is longer than the width of the terminal,
    then we end up with a bunch of truncated progress bar lines
    scrolling past:

      $ LANG=es_ES.UTF-8 git commit-graph write
      Encontrando commits para commit graph entre los objetos empaquetados:   2% (1599
      Encontrando commits para commit graph entre los objetos empaquetados:   3% (1975
      Encontrando commits para commit graph entre los objetos empaquetados:   4% (2633
      Encontrando commits para commit graph entre los objetos empaquetados:   5% (3292
      [...]

Patches 3 and 4 fix these two issues, while the first three are
minor preparatory cleanups and refactorings.


Changes since v1:

  - Use utf8_strwidth().

  - Dropped patch 2/5 (progress: return early when in the background).

    Consequently, the new patch 2/4 (progress: assemble percentage and
    counters in a strbuf before printing; was patch 3/5 in v1) moves
    the is_foreground_fd() check around a bit, resulting in enough
    changes that range-diff can't match the new patch 3/4 to the old
    4/5.  With increased '--creation-factor' it's able to line up
    those two patches, and shows the updates to the commit message,
    but the resulting diff-of-a-diff looks utterly unreadable to me.
    I've included an interdiff as well, as I find it much more
    telling.

  - Commit message updates.


SZEDER Gábor (4):
  progress: make display_progress() return void
  progress: assemble percentage and counters in a strbuf before printing
  progress: clear previous progress update dynamically
  progress: break too long progress bar lines

 progress.c | 73 +++++++++++++++++++++++++++++++++++++++---------------
 progress.h |  2 +-
 2 files changed, 54 insertions(+), 21 deletions(-)

Interdiff:
diff --git a/progress.c b/progress.c
index 97bc4b04e8..e28ccdafd2 100644
--- a/progress.c
+++ b/progress.c
@@ -86,19 +86,13 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 {
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
-	int update = 0;
+	int show_update = 0;
 	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
 
 	progress->last_value = n;
-
-	if (!is_foreground_fd(fileno(stderr)) && !done) {
-		progress_update = 0;
-		return;
-	}
-
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
@@ -110,35 +104,39 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
 				    (uintmax_t)n, (uintmax_t)progress->total,
 				    tp);
-			update = 1;
+			show_update = 1;
 		}
 	} else if (progress_update) {
 		strbuf_reset(counters_sb);
 		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
-		update = 1;
+		show_update = 1;
 	}
 
-	if (update) {
-		const char *eol = done ? done : "\r";
-		int clear_len = counters_sb->len < last_count_len ?
-				last_count_len - counters_sb->len : 0;
-		int cols = term_columns();
-
-		if (progress->split) {
-			fprintf(stderr, "  %s%-*s", counters_sb->buf, clear_len,
-				eol);
-		} else if (!done &&
-			   cols < progress->title_len + counters_sb->len + 2) {
-			clear_len = progress->title_len + 1 < cols ?
-				    cols - progress->title_len - 1 : 0;
-			fprintf(stderr, "%s:%*s\n  %s%s", progress->title,
-					clear_len, "", counters_sb->buf, eol);
-			progress->split = 1;
-		} else {
-			fprintf(stderr, "%s: %s%-*s", progress->title,
-				counters_sb->buf, clear_len, eol);
+	if (show_update) {
+		if (is_foreground_fd(fileno(stderr)) || done) {
+			const char *eol = done ? done : "\r";
+			int clear_len = counters_sb->len < last_count_len ?
+					last_count_len - counters_sb->len : 0;
+			int progress_line_len = progress->title_len +
+						counters_sb->len + 2;
+			int cols = term_columns();
+
+			if (progress->split) {
+				fprintf(stderr, "  %s%-*s", counters_sb->buf,
+					clear_len, eol);
+			} else if (!done && cols < progress_line_len) {
+				clear_len = progress->title_len + 1 < cols ?
+					    cols - progress->title_len - 1 : 0;
+				fprintf(stderr, "%s:%*s\n  %s%s",
+					progress->title, clear_len, "",
+					counters_sb->buf, eol);
+				progress->split = 1;
+			} else {
+				fprintf(stderr, "%s: %s%-*s", progress->title,
+					counters_sb->buf, clear_len, eol);
+			}
+			fflush(stderr);
 		}
-		fflush(stderr);
 		progress_update = 0;
 	}
 
@@ -242,7 +240,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
 	strbuf_init(&progress->counters_sb, 0);
-	progress->title_len = strlen(title);
+	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
 	set_progress_signal();
 	return progress;
Range-diff:
1:  dea36bd2a7 = 1:  dea36bd2a7 progress: make display_progress() return void
2:  159a0b9561 < -:  ---------- progress: return early when in the background
3:  ecd6b0fd68 ! 2:  97de2a98a0 progress: assemble percentage and counters in a strbuf before printing
    @@ -4,10 +4,11 @@
     
         The following patches in this series want to handle the progress bar's
         title and changing parts (i.e. the counter and the optional percentage
    -    and throughput combined) differently.
    +    and throughput combined) differently, and need to know the length
    +    of the changing parts of the previously displayed progress bar.
     
         To prepare for those changes assemble the changing parts in a separate
    -    strbuf before printing.
    +    strbuf kept in 'struct progress' before printing.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
    @@ -29,24 +30,25 @@
     -	const char *eol, *tp;
     +	const char *tp;
     +	struct strbuf *counters_sb = &progress->counters_sb;
    -+	int update = 0;
    ++	int show_update = 0;
      
      	if (progress->delay && (!progress_update || --progress->delay))
      		return;
    -@@
    - 	}
      
    + 	progress->last_value = n;
      	tp = (progress->throughput) ? progress->throughput->display.buf : "";
     -	eol = done ? done : "   \r";
      	if (progress->total) {
      		unsigned percent = n * 100 / progress->total;
      		if (percent != progress->last_percent || progress_update) {
      			progress->last_percent = percent;
    --			fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
    --				progress->title, percent,
    --				(uintmax_t)n, (uintmax_t)progress->total,
    --				tp, eol);
    --			fflush(stderr);
    +-			if (is_foreground_fd(fileno(stderr)) || done) {
    +-				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
    +-					progress->title, percent,
    +-					(uintmax_t)n, (uintmax_t)progress->total,
    +-					tp, eol);
    +-				fflush(stderr);
    +-			}
     -			progress_update = 0;
     -			return;
     +
    @@ -55,22 +57,24 @@
     +				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
     +				    (uintmax_t)n, (uintmax_t)progress->total,
     +				    tp);
    -+			update = 1;
    ++			show_update = 1;
      		}
      	} else if (progress_update) {
    --		fprintf(stderr, "%s: %"PRIuMAX"%s%s",
    --			progress->title, (uintmax_t)n, tp, eol);
     +		strbuf_reset(counters_sb);
     +		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
    -+		update = 1;
    ++		show_update = 1;
     +	}
     +
    -+	if (update) {
    -+		const char *eol = done ? done : "   \r";
    ++	if (show_update) {
    + 		if (is_foreground_fd(fileno(stderr)) || done) {
    +-			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
    +-				progress->title, (uintmax_t)n, tp, eol);
    ++			const char *eol = done ? done : "   \r";
     +
    -+		fprintf(stderr, "%s: %s%s", progress->title, counters_sb->buf,
    -+			eol);
    - 		fflush(stderr);
    ++			fprintf(stderr, "%s: %s%s", progress->title,
    ++				counters_sb->buf, eol);
    + 			fflush(stderr);
    + 		}
      		progress_update = 0;
     -		return;
      	}
4:  e360365f18 ! 3:  edfe0157a7 progress: clear previous progress update dynamically
    @@ -10,7 +10,7 @@
         Alas, covering only three characters is not quite enough: when both
         the total and the throughput happen to change units from KiB to MiB in
         the same update, then the progress bar's length is shortened by four
    -    characters:
    +    characters (or maybe even more!):
     
           Receiving objects:  25% (2901/11603), 772.01 KiB | 733.00 KiB/s
           Receiving objects:  27% (3133/11603), 1.43 MiB | 1.16 MiB/s   s
    @@ -21,11 +21,10 @@
         the length of the current progress bar with the previous one, and
         cover up as many characters as needed.
     
    -    Sure, it would be much simpler to just print four spaces instead of
    -    three at the end of the progress bar, but this approach is more
    -    future-proof, and it won't print extra spaces when none are needed,
    -    notably when the progress bar doesn't show throughput and thus never
    -    shrinks.
    +    Sure, it would be much simpler to just print more spaces at the end of
    +    the progress bar, but this approach is more future-proof, and it won't
    +    print extra spaces when none are needed, notably when the progress bar
    +    doesn't show throughput and thus never shrinks.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
    @@ -35,24 +34,24 @@
     @@
      	const char *tp;
      	struct strbuf *counters_sb = &progress->counters_sb;
    - 	int update = 0;
    + 	int show_update = 0;
     +	int last_count_len = counters_sb->len;
      
      	if (progress->delay && (!progress_update || --progress->delay))
      		return;
     @@
    - 	}
      
    - 	if (update) {
    --		const char *eol = done ? done : "   \r";
    + 	if (show_update) {
    + 		if (is_foreground_fd(fileno(stderr)) || done) {
    +-			const char *eol = done ? done : "   \r";
     -
    --		fprintf(stderr, "%s: %s%s", progress->title, counters_sb->buf,
    --			eol);
    -+		const char *eol = done ? done : "\r";
    -+		int clear_len = counters_sb->len < last_count_len ?
    -+				last_count_len - counters_sb->len : 0;
    -+		fprintf(stderr, "%s: %s%-*s", progress->title,
    -+			counters_sb->buf, clear_len, eol);
    - 		fflush(stderr);
    +-			fprintf(stderr, "%s: %s%s", progress->title,
    +-				counters_sb->buf, eol);
    ++			const char *eol = done ? done : "\r";
    ++			int clear_len = counters_sb->len < last_count_len ?
    ++					last_count_len - counters_sb->len : 0;
    ++			fprintf(stderr, "%s: %s%-*s", progress->title,
    ++				counters_sb->buf, clear_len, eol);
    + 			fflush(stderr);
    + 		}
      		progress_update = 0;
    - 	}
5:  cbd3be1c6d ! 4:  d53de231ee progress: break too long progress bar lines
    @@ -69,35 +69,37 @@
      
      static volatile sig_atomic_t progress_update;
     @@
    - 		const char *eol = done ? done : "\r";
    - 		int clear_len = counters_sb->len < last_count_len ?
    - 				last_count_len - counters_sb->len : 0;
    --		fprintf(stderr, "%s: %s%-*s", progress->title,
    --			counters_sb->buf, clear_len, eol);
    -+		int cols = term_columns();
    + 			const char *eol = done ? done : "\r";
    + 			int clear_len = counters_sb->len < last_count_len ?
    + 					last_count_len - counters_sb->len : 0;
    +-			fprintf(stderr, "%s: %s%-*s", progress->title,
    +-				counters_sb->buf, clear_len, eol);
    ++			int progress_line_len = progress->title_len +
    ++						counters_sb->len + 2;
    ++			int cols = term_columns();
     +
    -+		if (progress->split) {
    -+			fprintf(stderr, "  %s%-*s", counters_sb->buf, clear_len,
    -+				eol);
    -+		} else if (!done &&
    -+			   cols < progress->title_len + counters_sb->len + 2) {
    -+			clear_len = progress->title_len + 1 < cols ?
    -+				    cols - progress->title_len - 1 : 0;
    -+			fprintf(stderr, "%s:%*s\n  %s%s", progress->title,
    -+					clear_len, "", counters_sb->buf, eol);
    -+			progress->split = 1;
    -+		} else {
    -+			fprintf(stderr, "%s: %s%-*s", progress->title,
    -+				counters_sb->buf, clear_len, eol);
    -+		}
    - 		fflush(stderr);
    ++			if (progress->split) {
    ++				fprintf(stderr, "  %s%-*s", counters_sb->buf,
    ++					clear_len, eol);
    ++			} else if (!done && cols < progress_line_len) {
    ++				clear_len = progress->title_len + 1 < cols ?
    ++					    cols - progress->title_len - 1 : 0;
    ++				fprintf(stderr, "%s:%*s\n  %s%s",
    ++					progress->title, clear_len, "",
    ++					counters_sb->buf, eol);
    ++				progress->split = 1;
    ++			} else {
    ++				fprintf(stderr, "%s: %s%-*s", progress->title,
    ++					counters_sb->buf, clear_len, eol);
    ++			}
    + 			fflush(stderr);
    + 		}
      		progress_update = 0;
    - 	}
     @@
      	progress->throughput = NULL;
      	progress->start_ns = getnanotime();
      	strbuf_init(&progress->counters_sb, 0);
    -+	progress->title_len = strlen(title);
    ++	progress->title_len = utf8_strwidth(title);
     +	progress->split = 0;
      	set_progress_signal();
      	return progress;
-- 
2.21.0.539.g07239c3a71.dirty

