Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA3620248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfDEAqg (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:46:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35007 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDEAqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:46:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so5390918wmd.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tj2OMO8b4i6XbxQ95Hh4SROCmG40La+0KQuH82RAc0=;
        b=gplEbo27b7s4yRq6nW9v8iJaPQSb95u69pBNNZk5g/cnqFTwb4g+daOnURY/4ufQdX
         oyrsgmBKWc64L7yEx3SE+RT4TA1+nL/fr4kPMyJK/dEBOOHA3HUI4B8Yx2n3Wrut3FAN
         xkg2/+pFvoxWAJ751iu6l+XxzKHfQkF5wyOh5cdlmEQ+PzugTlIjJMyg0mrpjQPNFrJO
         TzK5lmNfv5O0h3VKydebOZA53PA3f28Nry2WaU21oU4aGJndjJc8s8CQ7WI6SplF+4dz
         iGdvjfTtCQLW7axBIeEXAfAa956C6PjeHG+nik1uYtgV2KuiGVp601RDGjgiuDFVLYb7
         1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tj2OMO8b4i6XbxQ95Hh4SROCmG40La+0KQuH82RAc0=;
        b=NnUXUaCs7EX3wh1XIRkfKt3PDsZW1Dvqme0quj9eOF80R4anEjwHguKDdAA9OQh1EL
         CCT+kcqONU4xbWS+R0L9LWedK4Y/yuVqrIiptVAV/Xb6A8Nr8rVvxr+7IhXRCDtYrODO
         YJIWP3DQl9lU4vWNzWfcSOVMkDLeFp10DWuS1M5b6kuIzMnJgiLNlwdx/HdM7Wuk5xS1
         /fUATOp2bfkTFmSmyjJxXdScQfJGPGIZQNm6z/yBR4DRqrInrakc1pp8Ec7CEpDlms5N
         rUmsrSVTDj1AtWACN04rkp+TTNCvs8o9zq8fakdv6dhq1yTd0oNOS9p+meI975rB5Cby
         NaFQ==
X-Gm-Message-State: APjAAAVpAbDt+CD+oc2/KwIhjq+dPafA0H7xoYLVQQEr8kQa4wdYa60a
        xldpt7EpWzqiXz5zKEO+UQ4=
X-Google-Smtp-Source: APXvYqw5Dib2Q5YucnsOYpQcH4a7Fep83yG5s0IbxMF9RXbnvkdU+gKLbHuUYZ7UhURjcmd9FC6GLw==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr5560116wmg.119.1554425193283;
        Thu, 04 Apr 2019 17:46:33 -0700 (PDT)
Received: from localhost.localdomain (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id d17sm28137301wrw.88.2019.04.04.17.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 17:46:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/4] progress: assemble percentage and counters in a strbuf before printing
Date:   Fri,  5 Apr 2019 02:45:37 +0200
Message-Id: <20190405004539.31467-3-szeder.dev@gmail.com>
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
2.21.0.539.g07239c3a71.dirty

