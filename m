Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4013C1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeC1R4c (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35822 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeC1R42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id t132-v6so4750329lfe.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kotmm39aZT1qvuWS9nNDWsiEl2Mo5i74m+gh4grAYdw=;
        b=DLYrGFQapCXEjP+6JFSvFZ0QTqRf/H709HYqMQFHYPLf6Z8NhdhnXLUAEUny8FxrNJ
         EVbZOVE+yfXCasYHa5c+ZL7MUHnVw5bQN6C+6ChiVLCtZQubdWwqffeu7cmMFSfa+DMs
         dThFYYl/AX+VoaLanfPWC1oy5UKWMPdyEFcZ1Fkb1KkStzbpPBcjrLcw6iYFmq7NV4z1
         s3qIW6D0eDOORFXimeRLFlOLtfFHFIjiPDH++lJESgJQWohRBHFC0ukzvnBC8mud0NVD
         N0Wgplf4pBzWcsqx7Yy2/tr2XJW1KX/B6nYkcZ+SpouLYngAXji0P1poHKm86OZiZwbk
         bBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kotmm39aZT1qvuWS9nNDWsiEl2Mo5i74m+gh4grAYdw=;
        b=UAOAXK+OhkNochp7pIUFRDAMEpcWSdv0eS0a0yVUqRQmZMyyr5VIxbKG/3zNY6SvID
         ioYsfDUnGlfpM0i+1M7xFPyyCovQUqRjNYKP8ng9+7WhR59wC/ngbpbhfO0bLiIPL5eO
         Y5oL1EYAnVQC85StBpyk/nk7y7d5QGToE3a2gqyjTktmxR7FTZkC1zIlBmogXyNgiWFd
         pEZXKKU/WEUGD2wKxl3B+2uECOi5IdbC8L6+RTRotQRzrSdtLllnknDbguBjPNnym7ds
         AcgRDIiM8czU0c3MOUExWdSaR/A3fQt0sMJ3/ZWpcx5omtRNqJSkkegAgrnGi+BTkVKQ
         FaVQ==
X-Gm-Message-State: AElRT7EhXbJIveJC+CdU+38iuzyAhV4W8SEEOZXbK8jWSsQuZV93/hTd
        kZC/Tz6WdYONJOLmIlq3e2xDVQ==
X-Google-Smtp-Source: AIpwx4/4jdLPTC8u916NBNZIyI1LJiVTrYTXZVFLK7KegwkUFTnQhbBY8tdQuq9eqtL5o2M/EPt0vg==
X-Received: by 10.46.144.72 with SMTP id n8mr3085114ljg.40.1522259786637;
        Wed, 28 Mar 2018 10:56:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/8] trace.c: export trace_setup_key
Date:   Wed, 28 Mar 2018 19:55:32 +0200
Message-Id: <20180328175537.17450-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is so that we can print traces based on this key outside trace.c.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 14 +++++++-------
 trace.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/trace.c b/trace.c
index 7f3b08e148..fc623e91fd 100644
--- a/trace.c
+++ b/trace.c
@@ -26,6 +26,7 @@
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
+struct trace_key trace_setup_key = TRACE_KEY_INIT(SETUP);
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
@@ -300,11 +301,10 @@ static const char *quote_crnl(const char *path)
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
 void trace_repo_setup(const char *prefix)
 {
-	static struct trace_key key = TRACE_KEY_INIT(SETUP);
 	const char *git_work_tree;
 	char *cwd;
 
-	if (!trace_want(&key))
+	if (!trace_want(&trace_setup_key))
 		return;
 
 	cwd = xgetcwd();
@@ -315,11 +315,11 @@ void trace_repo_setup(const char *prefix)
 	if (!prefix)
 		prefix = "(null)";
 
-	trace_printf_key(&key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf_key(&key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
-	trace_printf_key(&key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
-	trace_printf_key(&key, "setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf_key(&key, "setup: prefix: %s\n", quote_crnl(prefix));
+	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
+	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
+	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
+	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
 
 	free(cwd);
 }
diff --git a/trace.h b/trace.h
index 88055abef7..2b6a1bc17c 100644
--- a/trace.h
+++ b/trace.h
@@ -15,6 +15,7 @@ extern struct trace_key trace_default_key;
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
 extern struct trace_key trace_perf_key;
+extern struct trace_key trace_setup_key;
 
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
-- 
2.17.0.rc1.439.gca064e2955

