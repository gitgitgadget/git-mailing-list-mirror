Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 982BD20248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDLTp1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:45:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41198 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLTpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:45:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so13331668wrq.8
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtGi14H31MVdAWUDvYP8E9KP5n7HnfreKENwnOcmBxw=;
        b=QBjDJGx9GFmTGLkKhbSd56HDoshPb8bWRtiT0xpX5WpYEKUEAG+2qMr1MJrqGi8PQg
         yfE6xS3Qi++JjmZKblVaT9OnltcPNxk5w3Y2KDhVzH99/ciZHUOZ30uuC76hmUo1QIiP
         Pc+2XSdjv5vxY8qGRqrCAYRK5KC+PfCRjNzUd58TPWe+CeRgejOn0GJFicAonzfeImWZ
         Fo1KsKEnF17I+KGO+hqNSjIDli42TvS6V4LoksTq0QvjavFnBnvmsPICMhnJrS5xqqC7
         QbXK2YEcrinpmEDmMdPtdeCZ8ACemu+/5AEjfnf+CuHbcAHEkdTHUrT236KzOrr4PqBK
         17mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtGi14H31MVdAWUDvYP8E9KP5n7HnfreKENwnOcmBxw=;
        b=PpvJthEO11gw6Ph8UJhAPSPJmSd+1aM8R/kTU7IRo5MRlCgfl9PQHUtAWC2OFlAtLG
         lypIk31Xqm0HZio9WHoxACt0Xku8oEbiaKzlapMFkayC/ZxORHGodZ6uCHmZiCxcdrI6
         KujtsCCrSVLd7kdRp8RIrm8fUQXd5KtN2oucw0c2DVa3yqwYPadV99zLLM0dL1PgUTXH
         83Db8gIRM6IdSdMyU+6HtUKu8GDhEvdYE9ToB2wuxJt6zasOx2mnFjt4TWp0PGkd7y7m
         0dLI3LXUpevTIIdeDvjINQ3CRRxtraX4KimAPzasb0jj/OKtsHL9E6VQ6iK0STWJZUXB
         mqeg==
X-Gm-Message-State: APjAAAWQANjEM8j6yjrgfFbBuTM0aeTi5hLwthQKmrNfIZJB62WZ0jVg
        o7i8zWVI83wz36MHBtLk6uk=
X-Google-Smtp-Source: APXvYqyroW3C9DQf5ES8iE2oEshMtl2g5srAHsSjORM/7HytVTcxF2H+G01GUf7PVXuDtZFqoIWJFg==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr26957557wrl.214.1555098324032;
        Fri, 12 Apr 2019 12:45:24 -0700 (PDT)
Received: from localhost.localdomain (x4dbe3614.dyn.telefonica.de. [77.190.54.20])
        by smtp.gmail.com with ESMTPSA id x5sm33503081wru.12.2019.04.12.12.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 12:45:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 2/4] progress: assemble percentage and counters in a strbuf before printing
Date:   Fri, 12 Apr 2019 21:45:13 +0200
Message-Id: <20190412194515.6244-3-szeder.dev@gmail.com>
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

The following patches in this series want to handle the progress bar's
title and changing parts (i.e. the counter and the optional percentage
and throughput combined) differently, and need to know the length
of the changing parts of the previously displayed progress bar.

To prepare for those changes assemble the changing parts in a separate
strbuf kept in 'struct progress' before printing.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/progress.c b/progress.c
index 9010032446..564845a36b 100644
--- a/progress.c
+++ b/progress.c
@@ -36,6 +36,7 @@ struct progress {
 	unsigned delay;
 	struct throughput *throughput;
 	uint64_t start_ns;
+	struct strbuf counters_sb;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -80,31 +81,39 @@ static int is_foreground_fd(int fd)
 
 static void display(struct progress *progress, uint64_t n, const char *done)
 {
-	const char *eol, *tp;
+	const char *tp;
+	struct strbuf *counters_sb = &progress->counters_sb;
+	int show_update = 0;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
-	eol = done ? done : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			if (is_foreground_fd(fileno(stderr)) || done) {
-				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
-					progress->title, percent,
-					(uintmax_t)n, (uintmax_t)progress->total,
-					tp, eol);
-				fflush(stderr);
-			}
-			progress_update = 0;
+
+			strbuf_reset(counters_sb);
+			strbuf_addf(counters_sb,
+				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
+				    (uintmax_t)n, (uintmax_t)progress->total,
+				    tp);
+			show_update = 1;
 		}
 	} else if (progress_update) {
+		strbuf_reset(counters_sb);
+		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
+		show_update = 1;
+	}
+
+	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
-			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
-				progress->title, (uintmax_t)n, tp, eol);
+			const char *eol = done ? done : "   \r";
+
+			fprintf(stderr, "%s: %s%s", progress->title,
+				counters_sb->buf, eol);
 			fflush(stderr);
 		}
 		progress_update = 0;
@@ -207,6 +216,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
+	strbuf_init(&progress->counters_sb, 0);
 	set_progress_signal();
 	return progress;
 }
@@ -250,6 +260,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		free(buf);
 	}
 	clear_progress_signal();
+	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
 	free(progress->throughput);
-- 
2.21.0.746.gd74f1657d3

