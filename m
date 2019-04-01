Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4317D20248
	for <e@80x24.org>; Mon,  1 Apr 2019 11:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDALw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 07:52:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55986 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfDALw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 07:52:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so10070815wmf.5
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3Tio5fjCwPDnH5z24dGZajGLAF5zsfpLL1cnXKmJWY=;
        b=EUNAKkqtGq4bPpccCv/qeysnFfcaYDEY/jt/JsQ0iVZL9wLWI/jzMXajJXJdAFyeBa
         bcDPSBU+aZjgQ4fLVZsAg0+Qssy8XiXB1lb/XhN0MqdCsXSQWWXHCeFY4z3u3Sgvj/4c
         RJeT0pKTi3yrnqSmadgaJSpmGghEdMGrnsvn02u1t706qr1rPxdeiKWUUYtvwH8INJv7
         BowNM7rE0JdfsBimK32DQ2n+s4wSh4TRM1ZG1/XzZbU6M4DH/tDmFOpIvDXPrFj4FrjE
         T7nojz3V1FoOj0Svj349tvokBUEkARggXcrxpZ5xwXBIBzkpIQwRNuo6U5p9AWvYEnhZ
         QhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3Tio5fjCwPDnH5z24dGZajGLAF5zsfpLL1cnXKmJWY=;
        b=sCDr6JFIpAgjkFXChu/8DwsEfNBqk8nzTrmiaAuZWRWH6E7sT2DGey/4HmWQ6zgWZk
         cyYsYmYPI9DRtozult/QbOY8YpYWOKXSu5k/BoORtPPsEWrWORiZoJWMmqzkow0zs2Ek
         bwtaYFFvxK6oUVcPg0u514uu5VNY5RDYGSCibMgkOoP6CoZVGAumRzT3Q2nJ0v9nYYnv
         uXlRcPZyjNV5Sdg3SlM62xAh9LnT/yXIugzXBCbGLW0kjdvcxYlsV77H6xdaMQ4etIrm
         6v2i84GAaZAzjb7uM4mpJ7uADb1cRlllxDaiXImSCjCR64EKil9tgnZAFpWjS/AWJ8IK
         ueuQ==
X-Gm-Message-State: APjAAAVhwIUf4Bh4Rq50V1fdQEZIdRKjkoyRwX/ucfQ6vNq/hE9Jn261
        R/EWN+a8rdU2COvZ9LtYa1s7kwV8
X-Google-Smtp-Source: APXvYqzDInJPUcoDbPh88b0haXW+svG6IZwAFrT4fawN7Yg4hMo0c2wVAaTH7Cij8MA5c1RjOtw6Gw==
X-Received: by 2002:a1c:c101:: with SMTP id r1mr11630809wmf.123.1554119544400;
        Mon, 01 Apr 2019 04:52:24 -0700 (PDT)
Received: from localhost.localdomain (x4db6660d.dyn.telefonica.de. [77.182.102.13])
        by smtp.gmail.com with ESMTPSA id f11sm11250970wrm.30.2019.04.01.04.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 04:52:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/4] progress: assemble percentage and counters in a strbuf before printing
Date:   Mon,  1 Apr 2019 13:52:15 +0200
Message-Id: <20190401115217.3423-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190401115217.3423-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190401115217.3423-1-szeder.dev@gmail.com>
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
 progress.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/progress.c b/progress.c
index 02a20e7d58..842db14b72 100644
--- a/progress.c
+++ b/progress.c
@@ -36,6 +36,7 @@ struct progress {
 	unsigned delay;
 	struct throughput *throughput;
 	uint64_t start_ns;
+	struct strbuf counters_sb;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -80,36 +81,42 @@ static int is_foreground_fd(int fd)
 
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
-			return;
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
-		return;
 	}
 
 	return;
@@ -211,6 +218,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
+	strbuf_init(&progress->counters_sb, 0);
 	set_progress_signal();
 	return progress;
 }
@@ -254,6 +262,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		free(buf);
 	}
 	clear_progress_signal();
+	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
 	free(progress->throughput);
-- 
2.21.0.539.g07239c3a71.dirty

