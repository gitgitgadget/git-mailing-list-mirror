Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB29920248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfDEAqi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:46:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44644 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbfDEAqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:46:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so5890317wrn.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqxMchivczxyI/DmHabW0zjrmbT9WqlVcNayh0Nt7Eo=;
        b=cAWXkWgMP/Kzol3GTvBHVHi+w4W5GR+MDShq0AG1gDyvdCHcrIdhXMZqh83riKkV2f
         OocF6onSal1IOlIqhlAYnDRr7FkH6wVqZjQ5sbqjwEEjgsBvab9r8xLMCpxDbNnRqk0Z
         yPkggGfKy7GsAWTOp1w+hjbDi0KhgwUPcmKA5oRWBtZ3gRY5BJp5A6N/lVVEM1/H3C7z
         Ql0tdONBZ1UaqIYrSWOzLY5BzLUuLrU65l0abzo58egUmwf9YnscwM9dKi0b4d/OcvhO
         1AVrf1vjZyz5RPIOy1PdcdKqG7asciIvuNllMPiJFS4gGZr5u56t8kRFvPIL/jTg8doF
         p/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqxMchivczxyI/DmHabW0zjrmbT9WqlVcNayh0Nt7Eo=;
        b=SBbrUzsBcnYL4z8CzqJCX4LhYZ9D6nf3gWzGnj7Ma0Hstw/xZe7czQFsJkcWCp1FSk
         RrRcfUfMn2QyRLYnsPvl5DwcOFSrwYnmhNvoAgXgp5/pH1HGQsqVb8YXOxcU6O2QC3Yr
         2NAw+ruMq9fx1xbJHfmpfAFVsoFctgM7EwKopEX0QyltSwvkoCiJK+wmXVMxhzfBzoX1
         YYPxfd/9zZaCqtNq3AtiBskJmtucE7SNDQaC7gjlfwX+xz/tdeXzvHPXbOSwLTHDQjWw
         U90LPtG/ZczKK3bGTzoVD+AFpmUp4J8jxiJ2T4r72wRlCLQNvuweicxoMLCSesnVk0uT
         m/pQ==
X-Gm-Message-State: APjAAAWs40KSSbaszrI+Hodl9mx//zQPB+7bZeJt5h+dFlcLdDWyEeQr
        YETsEnY65kgP0uohGVAIDzY=
X-Google-Smtp-Source: APXvYqzTnA/61HNU8tVwmIRX4CKcvKdkBBiZ9cNxwPpf4hLLNsycerDZrSrbUTId9sR0VeG66mtY2g==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr1439142wrx.93.1554425195729;
        Thu, 04 Apr 2019 17:46:35 -0700 (PDT)
Received: from localhost.localdomain (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id d17sm28137301wrw.88.2019.04.04.17.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 17:46:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/4] progress: break too long progress bar lines
Date:   Fri,  5 Apr 2019 02:45:39 +0200
Message-Id: <20190405004539.31467-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190405004539.31467-1-szeder.dev@gmail.com>
References: <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190405004539.31467-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the recently added progress indicators have quite long titles,
which might be even longer when translated to some languages, and when
they are shown while operating on bigger repositories, then the
progress bar grows longer than the default 80 column terminal width.

When the progress bar exceeds the width of the terminal it gets
line-wrapped, and after that the CR at the end doesn't return to the
beginning of the progress bar, but to the first column of its last
line.  Consequently, the first line of the previously shown progress
bar is not overwritten by the next, and we end up with a bunch of
truncated progress bar lines scrolling past:

  $ LANG=es_ES.UTF-8 git commit-graph write
  Encontrando commits para commit graph entre los objetos empaquetados:   2% (1599
  Encontrando commits para commit graph entre los objetos empaquetados:   3% (1975
  Encontrando commits para commit graph entre los objetos empaquetados:   4% (2633
  Encontrando commits para commit graph entre los objetos empaquetados:   5% (3292
  [...]

Prevent this by breaking progress bars after the title once they
exceed the width of the terminal, so the counter and optional
percentage and throughput, i.e. all changing parts, are on the last
line.  Subsequent updates will from then on only refresh the changing
parts, but not the title, and it will look like this:

  $ LANG=es_ES.UTF-8 ~/src/git/git commit-graph write
  Encontrando commits para commit graph entre los objetos empaquetados:
    100% (6584502/6584502), listo.
  Calculando números de generación de commit graph: 100% (824705/824705), listo.
  Escribiendo commit graph en 4 pasos: 100% (3298820/3298820), listo.

Note that the number of columns in the terminal is cached by
term_columns(), so this might not kick in when it should when a
terminal window is resized while the operation is running.
Furthermore, this change won't help if the terminal is so narrow that
the counters don't fit on one line, but I would put this in the "If it
hurts, don't do it" box.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index ca0945d2be..97e18671e5 100644
--- a/progress.c
+++ b/progress.c
@@ -8,11 +8,12 @@
  * published by the Free Software Foundation.
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
 #include "gettext.h"
 #include "progress.h"
 #include "strbuf.h"
 #include "trace.h"
+#include "utf8.h"
 
 #define TP_IDX_MAX      8
 
@@ -37,6 +38,8 @@ struct progress {
 	struct throughput *throughput;
 	uint64_t start_ns;
 	struct strbuf counters_sb;
+	int title_len;
+	int split;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -114,8 +117,24 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			const char *eol = done ? done : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len : 0;
-			fprintf(stderr, "%s: %s%-*s", progress->title,
-				counters_sb->buf, (int) clear_len, eol);
+			size_t progress_line_len = progress->title_len +
+						counters_sb->len + 2;
+			int cols = term_columns();
+
+			if (progress->split) {
+				fprintf(stderr, "  %s%-*s", counters_sb->buf,
+					(int) clear_len, eol);
+			} else if (!done && cols < progress_line_len) {
+				clear_len = progress->title_len + 1 < cols ?
+					    cols - progress->title_len - 1 : 0;
+				fprintf(stderr, "%s:%*s\n  %s%s",
+					progress->title, (int) clear_len, "",
+					counters_sb->buf, eol);
+				progress->split = 1;
+			} else {
+				fprintf(stderr, "%s: %s%-*s", progress->title,
+					counters_sb->buf, (int) clear_len, eol);
+			}
 			fflush(stderr);
 		}
 		progress_update = 0;
@@ -219,6 +238,8 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
 	strbuf_init(&progress->counters_sb, 0);
+	progress->title_len = utf8_strwidth(title);
+	progress->split = 0;
 	set_progress_signal();
 	return progress;
 }
-- 
2.21.0.539.g07239c3a71.dirty

