Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E272620248
	for <e@80x24.org>; Mon,  1 Apr 2019 11:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDALwZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 07:52:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40065 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 07:52:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so11600682wre.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaky29/FccbXURdWIlAx4/1oV9df5zw19GK3KRzD4Xk=;
        b=rQ7Dl9b4CakaHB532zPW/Mfth1dQr5EpqykGACv3/owLudq4Lm65fFjpiGyAdl+xzF
         /cvvQmY2R71Wq+ZzaeLhQbGMgcEtSoZnzOax7He0jOX92GyGKn0tiUHwlX97uaGrq/dT
         VSSqHtPSAnjTSXvMZQFNmmgusDqjo3DsA+sw5wdBPB0Zk9V9t4JMrvBeOHYIj1giOmG9
         V54PRefttYu7k5bttEAjWcvU/VngcBmmN5TbcIp0/XQLaWB5y2yZsTtnNqC8Y24jvsxs
         YNcZd6P0kG0J72S7UnxjXDHhLZ5AH7bfSoTS3Xj2xXpWcQXALkc3VQdeqNXHpvaPYvzM
         hDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaky29/FccbXURdWIlAx4/1oV9df5zw19GK3KRzD4Xk=;
        b=aiMo46NY1jz0vyH0wILWu1yUHlAbYKeKow2DTotqxWOFJvwQQbd7G26ek9Nc7eI92n
         dLVQ2Si5v9Bvh6871JCYzQ3Ulug1p65z/H+9wkw75GFTIpqDRwyuH41iV44MR75F5GUO
         hm7n0sLpRnHS3QvQLse9zxAVKq+26Xv/3Q/2UjsyiLDj9nL0nFTRqo7gIUB/NLl5Wp5p
         qphThiamvKV4bEQSRJ7JywAYhJMvtLX+Ge4BfYhiIuSK7mkh3mBxmw3g5x9YsI0jiZao
         KJGDqDTsfmTf9TmTkN82APl86w4+q4rqiqdYDpb8s30SUjoGoCLoouQwiwDq990nQhDt
         5//A==
X-Gm-Message-State: APjAAAXyfBcYS5JsCL0lBJwP5FmaRyiI+R+4GgQKDO2QOJXoX9UKy0oz
        FGbU+Z50MRKj6qBhStzq0PE=
X-Google-Smtp-Source: APXvYqw6Fbj3SnVClEDAtFzyORjZMfv/jmCSyloYlXf5a887kxvYRStuJrI4AJ0km/n9tPU9jbpe9A==
X-Received: by 2002:adf:dcce:: with SMTP id x14mr29846162wrm.315.1554119543244;
        Mon, 01 Apr 2019 04:52:23 -0700 (PDT)
Received: from localhost.localdomain (x4db6660d.dyn.telefonica.de. [77.182.102.13])
        by smtp.gmail.com with ESMTPSA id f11sm11250970wrm.30.2019.04.01.04.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 04:52:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/4] progress: make display_progress() return void
Date:   Mon,  1 Apr 2019 13:52:14 +0200
Message-Id: <20190401115217.3423-2-szeder.dev@gmail.com>
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

Let's make display_progress() return void, too.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 15 ++++++++-------
 progress.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..02a20e7d58 100644
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
@@ -100,7 +100,7 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 				fflush(stderr);
 			}
 			progress_update = 0;
-			return 1;
+			return;
 		}
 	} else if (progress_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
@@ -109,10 +109,10 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 			fflush(stderr);
 		}
 		progress_update = 0;
-		return 1;
+		return;
 	}
 
-	return 0;
+	return;
 }
 
 static void throughput_string(struct strbuf *buf, uint64_t total,
@@ -188,9 +188,10 @@ void display_throughput(struct progress *progress, uint64_t total)
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

