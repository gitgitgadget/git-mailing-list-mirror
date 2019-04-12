Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B63520248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDLTpZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:45:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37931 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDLTpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:45:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so13395921wro.5
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQdtYMQw2ijGNwYIodyEzRfbTyeUhP+cu9lR9r/otxM=;
        b=YPysQ39woNpIQH9XytJAcdVQNycQva3tH7OD4ZmY1vjJUPY4HP90Qeoozon3K5zrq3
         Kbw3k7DuRzhUKJjVWl5McbXYOwXuEDAsbR27REUzuXfa6LFuLkV2Jduy+I6k7xvzttQS
         wbTexBeM9rFNooNT3oyRAiomu9orOQ8m2Zfg2ddWSM4ZXLSsRYAnZC4RZVuA92b9CBV1
         msp+sIQn0SwULa/f8n7DRUN7WFU0dh00hRDxH+u0hLDL3ULlS8rt9X/zuVoKQxNP84FZ
         thSg8Eu5LG1QAg37IldxjzNcN9D+JNGw+YsJWSIknMvBvlDtOBwYQNPhKpJ4Q2gQV7tS
         Qggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQdtYMQw2ijGNwYIodyEzRfbTyeUhP+cu9lR9r/otxM=;
        b=n+/KRDFb6E7QasoowGDkB0/7F+cmW0bW+qCKjscFZDpHmBH9x/1CpdYpdB8Ym15UBr
         /mnOeM+pGW2kNYdOZUt2HOoFdKqrpoWt4mEP6x5nJmZ5AnV8UHrgK79hgjBzp3496TED
         KyRHRFS7zZkA86R2fObaGgieDIF+IxRMSk7mF4AzTsyrYCEOnz+vY4KiS+udgIbe8M/U
         8ugbcpO40MdujCFv2R2QjQ/oJ54tLLG1wNsusfaUiYqWGJi3f4CGhXuNOxXEcFiCd2Mb
         T+lT+JcuIyXHsRb7ma4ju7bYCRBWAE3C6hY4BeYH72vFrblijqZW9/C2FYr7MGPrF6lf
         53rA==
X-Gm-Message-State: APjAAAXkiyjnvkmq6PA3BeeSn4UKoIvrXIJYBlfSWeV5eIsJlijQyTyx
        P3hebseMokk1EmzK9SlYT40=
X-Google-Smtp-Source: APXvYqxSSOnLi/DzRI0ZafaL3XJmzeOjLu3zU7UCFkuVhMRbDZgv+/YtpR8tjydZhLnUBmfuxytI1g==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr34913597wra.226.1555098322927;
        Fri, 12 Apr 2019 12:45:22 -0700 (PDT)
Received: from localhost.localdomain (x4dbe3614.dyn.telefonica.de. [77.190.54.20])
        by smtp.gmail.com with ESMTPSA id x5sm33503081wru.12.2019.04.12.12.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 12:45:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/4] progress: make display_progress() return void
Date:   Fri, 12 Apr 2019 21:45:12 +0200
Message-Id: <20190412194515.6244-2-szeder.dev@gmail.com>
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

Ever since the progress infrastructure was introduced in 96a02f8f6d
(common progress display support, 2007-04-18), display_progress() has
returned an int, telling callers whether it updated the progress bar
or not.  However, this is:

  - useless, because over the last dozen years there has never been a
    single caller that cared about that return value.

  - not quite true, because it doesn't print a progress bar when
    running in the background, yet it returns 1; see 85cb8906f0
    (progress: no progress in background, 2015-04-13).

The related display_throughput() function returned void already upon
its introduction in cf84d51c43 (add throughput to progress display,
2007-10-30).

Let's make display_progress() return void, too.  While doing so
several return statements in display() become unnecessary, remove
them.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 13 +++++--------
 progress.h |  2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..9010032446 100644
--- a/progress.c
+++ b/progress.c
@@ -78,12 +78,12 @@ static int is_foreground_fd(int fd)
 	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
-static int display(struct progress *progress, uint64_t n, const char *done)
+static void display(struct progress *progress, uint64_t n, const char *done)
 {
 	const char *eol, *tp;
 
 	if (progress->delay && (!progress_update || --progress->delay))
-		return 0;
+		return;
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
@@ -100,7 +100,6 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 				fflush(stderr);
 			}
 			progress_update = 0;
-			return 1;
 		}
 	} else if (progress_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
@@ -109,10 +108,7 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 			fflush(stderr);
 		}
 		progress_update = 0;
-		return 1;
 	}
-
-	return 0;
 }
 
 static void throughput_string(struct strbuf *buf, uint64_t total,
@@ -188,9 +184,10 @@ void display_throughput(struct progress *progress, uint64_t total)
 		display(progress, progress->last_value, NULL);
 }
 
-int display_progress(struct progress *progress, uint64_t n)
+void display_progress(struct progress *progress, uint64_t n)
 {
-	return progress ? display(progress, n, NULL) : 0;
+	if (progress)
+		display(progress, n, NULL);
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
diff --git a/progress.h b/progress.h
index 70a4d4a0d6..59e40cc4fd 100644
--- a/progress.h
+++ b/progress.h
@@ -4,7 +4,7 @@
 struct progress;
 
 void display_throughput(struct progress *progress, uint64_t total);
-int display_progress(struct progress *progress, uint64_t n);
+void display_progress(struct progress *progress, uint64_t n);
 struct progress *start_progress(const char *title, uint64_t total);
 struct progress *start_delayed_progress(const char *title, uint64_t total);
 void stop_progress(struct progress **progress);
-- 
2.21.0.746.gd74f1657d3

