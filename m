Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9203B1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHJU17 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 16:27:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38026 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 16:27:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id u190so10664454qkh.5
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNmCBAGkWtu3W2MOdb6EhCFlaFqoCcepeubQxKBrXtM=;
        b=dcq92GDpKYYeQAsdz2PTt6ojSOIdRz3wqqIKi1ZPvNPzuGs9VGNrG7A5ezSjjXIclJ
         tFgfyxQhWEqx+zZ+dmZHPgIMoYa33BhRnKViYzumU76FG9LB07cyYlbVQa4XnurWp7Eu
         SnA6Pzv6aTBP3mxENC4n1qjk17EdbcOpvQOz1y3+u/GHc1ahiqqoL7MTu+LHjclfktBV
         xvYnlxOBKF1iAC6dzjH4OQPqMXTq14DI+e0EtxPHrDaZgXjT6W88NVIofTXg4/HC0qHl
         jj1ZZghx6CxtrZespVbkst5l3LOwefnyHhKvRbaW87/hApFVQRVY0Vl5Xc5cVD0Mvij1
         dVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNmCBAGkWtu3W2MOdb6EhCFlaFqoCcepeubQxKBrXtM=;
        b=RGFiS4b3+GWmXD0RNMa806DIorYAXhAMgkw+q58G8W/zcpPegavZh+m5N5uz/cruVY
         YShQGWPbdcxVwzTI6MMqkIQvgHzA2/ZVJhKN62Qk1fwqLhYo39R/YNKJDZwpo6t01gd6
         90kXjIEmwlas8ueXY24iel6I9+WHSX5sa8B6ah/Bl8N4yNtGPhUDQk7NEw5CcI8ABCPj
         4NEL+sJwIQhp2ucU3oJrw1TG9X/FGevI3JrpYgu2jxtk7K9FoMZ6CJAdB5I07EAFcyjx
         zsu4ltqTAs72WO2HEO7E4U1q1rcqa7zxcUgR2ZBymVM3szmq1qZDCF8eHdpBH0K/nADb
         Civw==
X-Gm-Message-State: APjAAAXTld8vNq8inPTla/sjsJY8zDlEKTt738cAxqdKYP2kz/Vchnt5
        q+n0sEBQqhYtrHIssg5M3E6KVKYZpDk=
X-Google-Smtp-Source: APXvYqwahuu5tEJoCG26jOOX1zd6iD3WLJHiruygWapB8FiGMiWiK4quzcVltp+zzk0AJS7atOENLw==
X-Received: by 2002:a37:aa88:: with SMTP id t130mr24861590qke.12.1565468877814;
        Sat, 10 Aug 2019 13:27:57 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u1sm54384295qth.21.2019.08.10.13.27.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 13:27:57 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [GSoC][PATCH 2/4] grep: allow locks to be enabled individually
Date:   Sat, 10 Aug 2019 17:27:28 -0300
Message-Id: <235de7de2874bd089b106be75121e1616308ed55.1565468806.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565468806.git.matheus.bernardino@usp.br>
References: <cover.1565468806.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep has some internal locks to protect thread-unsafe operations
when running with threads. The usage of these locks can be toggled
through the variable 'grep_use_locks'. However, it's not currently
possible to enable each lock individually. And since object reading has
its own locks now, it is desirable to disable the respective grep lock
(and only that) in cases where we can do so. To do that, transform
'grep_use_locks' from a binary variable to a bitmask, which controls
each lock individually.

The actual disabling of grep_read_lock, when possible, will be done in
the following patch.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 2 +-
 grep.c         | 4 ++--
 grep.h         | 8 ++++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..a871bad8ad 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -205,7 +205,7 @@ static void start_threads(struct grep_opt *opt)
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
-	grep_use_locks = 1;
+	grep_use_locks = GREP_USE_ALL_LOCKS;
 
 	for (i = 0; i < ARRAY_SIZE(todo); i++) {
 		strbuf_init(&todo[i].out, 0);
diff --git a/grep.c b/grep.c
index cd952ef5d3..3aca0db435 100644
--- a/grep.c
+++ b/grep.c
@@ -1523,13 +1523,13 @@ pthread_mutex_t grep_attr_mutex;
 
 static inline void grep_attr_lock(void)
 {
-	if (grep_use_locks)
+	if (grep_use_locks & GREP_USE_ATTR_LOCK)
 		pthread_mutex_lock(&grep_attr_mutex);
 }
 
 static inline void grep_attr_unlock(void)
 {
-	if (grep_use_locks)
+	if (grep_use_locks & GREP_USE_ATTR_LOCK)
 		pthread_mutex_unlock(&grep_attr_mutex);
 }
 
diff --git a/grep.h b/grep.h
index 1875880f37..02bffacfa2 100644
--- a/grep.h
+++ b/grep.h
@@ -229,6 +229,10 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs);
 struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 int grep_threads_ok(const struct grep_opt *opt);
 
+#define GREP_USE_READ_LOCK (1 << 0)
+#define GREP_USE_ATTR_LOCK (1 << 1)
+#define GREP_USE_ALL_LOCKS (~0)
+
 /*
  * Mutex used around access to the attributes machinery if
  * opt->use_threads.  Must be initialized/destroyed by callers!
@@ -239,13 +243,13 @@ extern pthread_mutex_t grep_read_mutex;
 
 static inline void grep_read_lock(void)
 {
-	if (grep_use_locks)
+	if (grep_use_locks & GREP_USE_READ_LOCK)
 		pthread_mutex_lock(&grep_read_mutex);
 }
 
 static inline void grep_read_unlock(void)
 {
-	if (grep_use_locks)
+	if (grep_use_locks & GREP_USE_READ_LOCK)
 		pthread_mutex_unlock(&grep_read_mutex);
 }
 
-- 
2.22.0

