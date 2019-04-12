Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D0820248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLTpb (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:45:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35585 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDLTp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:45:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so518252wmd.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2zrRzh0ukW6xdQB0tx7LizrEPsvtXEb1ciGM3vAoos0=;
        b=ZGUIsAeHXyTlbAIKAHNScsyKW+g7I/h1X0OLLf/QP9hwAaEYlvePDrU1ek7mFQ4RZR
         0pjdceTEySb6yrLtGuWCEWY5yhA+htrZmev1H+Z4lRBmk31kO5wO6HR1ioGnS1r81cIj
         IYxU3gL2E+KIqsYaEp1v6ornGOyzSbRrZ9+PtmGfi3EauxTL8xzQEHx+Cwb+CzvRvsO9
         c98fbmdKo7q2dRVuuMW7alh850uXtWhQxIThLLVtf7ztoU70e2CwwThj8x9ZbiwWP1Bz
         DKjVOvySRk9ootqDgz7cMHJwDnqQvOxdMilQracxujgbMySFXQ5be/nZgMzawVEp4gYT
         enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zrRzh0ukW6xdQB0tx7LizrEPsvtXEb1ciGM3vAoos0=;
        b=KDiNOOsURVNdrCKGc2j3/SW8XczCqmJ33h1spWd1fn0zaSwoELxgS5VrLwIdBGgc96
         OJLbUfHp/OD7F1JsVx9KjFMi0mVOltskyeYxsQEiGuWkgVQlePn6+sPtNhTVmCUuL5Wg
         V9OwzPpv3YPIvZ+lXLCE8aGB67mhzdHbvOSuAeY9KaVIUAU6SAh0cUQrV5MbRhDGMdSO
         2TnP4Cr4B/zLi54N8mbb81im95qnLxytXvmppG13/axFktTtWcJJl1zY+k6436d6fawf
         ZYWYNYICufgHFu5h6IJCEeu4x6xLcvNEWKI7u9s9DUzaXCGsGte6Ny8E4uwLlGfotr3r
         09wg==
X-Gm-Message-State: APjAAAW9C0Ksb/ZR4CGQXqcv3AlHTPmlKe8sTMR+2xq5qKSP4GOqbp/2
        /2bxk71wkGRt4G0Uk4rEK7Bxjkmh
X-Google-Smtp-Source: APXvYqw7cWtoDO7H6++YpcaduCdyuTjbnsopMjOFvwo8Ll9LbKp7BsTwT2NIE7TocAVHXvaf2irR3A==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr12820862wmg.14.1555098326200;
        Fri, 12 Apr 2019 12:45:26 -0700 (PDT)
Received: from localhost.localdomain (x4dbe3614.dyn.telefonica.de. [77.190.54.20])
        by smtp.gmail.com with ESMTPSA id x5sm33503081wru.12.2019.04.12.12.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 12:45:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 4/4] progress: break too long progress bar lines
Date:   Fri, 12 Apr 2019 21:45:15 +0200
Message-Id: <20190412194515.6244-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.746.gd74f1657d3
In-Reply-To: <20190412194515.6244-1-szeder.dev@gmail.com>
References: <20190405004539.31467-1-szeder.dev@gmail.com>
 <20190412194515.6244-1-szeder.dev@gmail.com>
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
index 949a2a576d..2d8022a622 100644
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
@@ -115,8 +118,24 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len + 1 :
 					0;
-			fprintf(stderr, "%s: %s%*s", progress->title,
-				counters_sb->buf, (int) clear_len, eol);
+			size_t progress_line_len = progress->title_len +
+						counters_sb->len + 2;
+			int cols = term_columns();
+
+			if (progress->split) {
+				fprintf(stderr, "  %s%*s", counters_sb->buf,
+					(int) clear_len, eol);
+			} else if (!done && cols < progress_line_len) {
+				clear_len = progress->title_len + 1 < cols ?
+					    cols - progress->title_len : 0;
+				fprintf(stderr, "%s:%*s\n  %s%s",
+					progress->title, (int) clear_len, "",
+					counters_sb->buf, eol);
+				progress->split = 1;
+			} else {
+				fprintf(stderr, "%s: %s%*s", progress->title,
+					counters_sb->buf, (int) clear_len, eol);
+			}
 			fflush(stderr);
 		}
 		progress_update = 0;
@@ -220,6 +239,8 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
 	strbuf_init(&progress->counters_sb, 0);
+	progress->title_len = utf8_strwidth(title);
+	progress->split = 0;
 	set_progress_signal();
 	return progress;
 }
-- 
2.21.0.746.gd74f1657d3

