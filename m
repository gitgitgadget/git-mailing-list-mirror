Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C0920248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDEAqe (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:46:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50314 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDEAqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:46:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so5001457wmi.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fv2+ni98qlEn9Slgzoh/T32rH9AcMrLWQIXQEuo6/q8=;
        b=ZCgUWZAAsRHV2auM6ztnWooIoTab/oJGkV118CP+9Ky5lGkKTtqHcOa1B9Oxlz1eas
         V6ujzXOQVXl9MNUYTB1S1SLwMlQiHhHAWoDXWb21Nj4GMuxqfNV+54TSN6zym8b9LG8s
         4jiG5n9uw05FDvSfbkHq1WKPSyhr8ey+HTy6yDgtKH9EfDQ/iDgOyuhXRE+A9rGnegr+
         kGT8xCKQgYQXSzkd3NzcqbLsQagVkQal+WOE1+1QUfp2GaOuLyYyQIoiVm27OVCo9A7d
         FJ1wcz6J1RHpEVA3jlyUcQEb0PIJIE8+dFVo00tz4l4JaOyjl3ZgKRjmy3v6Ykxyof19
         cpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fv2+ni98qlEn9Slgzoh/T32rH9AcMrLWQIXQEuo6/q8=;
        b=fFDmKj0n1pNGsqwJrsgagav0Dv9+vFHdFPixvpETqoLNoPuGCtRQJ07oyKM3Yh0YqJ
         YAOU4rc6HEm0ZxYObGOOvpEA1hF8ynd3Epvey8Zpsjyh13K2BMCf/pmHdEjsO6Sq56sy
         H7sV1H7SWf5wBi3xKPLFDu711kznhS6LILapK6H6oox7VOwxxVcR4xkQ4e2pSjLau9ZF
         NHpTu1iRQa3vhSSgAk3HgS/45RGs1elwRQ2bywdvxHp4LH9pq390WzWjoYgW2QfZLKkV
         2vEu4rPCoomO4wdGVSv3HS8DPKdTl2i8uP4sH8yJ5ZvYPOQRp3oDFOAtER5gHNadr1Tu
         3WRQ==
X-Gm-Message-State: APjAAAWiQO5hDAjamBccxicnWz5Nel3uHWQivPt2yZTen1+nl7eAO+WS
        cqRX0l7iNyiu1JVG3EzaOgI=
X-Google-Smtp-Source: APXvYqzIqtwmFnuowB1/lvv/Rl3SCCdq8XLwGyWU7XNdsBocO6OsPlKHby59O8kQsDw63DVhTGWxbQ==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr6088351wmm.80.1554425192034;
        Thu, 04 Apr 2019 17:46:32 -0700 (PDT)
Received: from localhost.localdomain (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id d17sm28137301wrw.88.2019.04.04.17.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 17:46:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/4] progress: make display_progress() return void
Date:   Fri,  5 Apr 2019 02:45:36 +0200
Message-Id: <20190405004539.31467-2-szeder.dev@gmail.com>
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
2.21.0.539.g07239c3a71.dirty

