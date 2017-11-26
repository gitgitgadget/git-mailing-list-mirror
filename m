Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E050A20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 20:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdKZUL2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 15:11:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36575 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdKZUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 15:11:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so31142917wmr.1
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0JoYMWlEUzMcv2YLTwPptGnaPBcBDVuBsQ3+z5anssQ=;
        b=g+dSZMjUUjKofYvJmQSh28ulNeRSKx92xhuiMn2o0+bF9msTi5KO1+ixHRd19MSfbP
         vy8z7MT+T2xV6lsafmEpDyPxdOA3fgCjIA8A19mIgZIPXYNWMp1lGQBa87vnYTnFtC1t
         1g8zRB83skU1xLwU23BiGAvrhN75bqCvwE4fruhWdstV0WPTheb5DzlNnhxfcCfxA4Pf
         h0MN7GyOj5WtDiyx+Qp2BInR4GnApNQWQ+6x6/ihomLNO0kBibtQPMN+nqP4vR/EjLxY
         rWK7jQ2Fg1fRWjDRohkG3g3SHWy8pDkyRRVQ4ZCPC5P4cRgh9cLi1WIvD7xFTBuzrDP8
         UDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0JoYMWlEUzMcv2YLTwPptGnaPBcBDVuBsQ3+z5anssQ=;
        b=NXeKPPIPF4Gt/s3dRmMOYhiOn4oMvZpfFR2V7a87DTc7/WKe/3fgaiZMydEJQWptPG
         h2plxgA/4l6UZdsP70CEeEq4PXxIUBE26nHz8zgaS8B/Roo7vRoyz9U/REipv0PpMuee
         i0lG/qPjBej5z8EdhRaKQCisUpFMKcnJhIx+iHsqudlac5Xocf0V8z6iMbeFry4TfKYJ
         JZ/upLPL4iy6+U0j2XPnMHNwsvt6HA5w8SBD/JrBQSb4ChbdvRP/nFyGe9zk1DM/J3Ya
         rU698RMCWDRC3i+1iFQUhnj9vuswTj1bXG0GG+CZ/e6XKxBtgpXxMCchoVXFRm8XRDZU
         Q2rw==
X-Gm-Message-State: AJaThX7PCtF/nqB457aEv6U+CHMzUORgi01dCQ9xzKmclIbF+OZl6s2X
        8wDmQ9dzVGc/y6AtW5Sr1/zJiQ==
X-Google-Smtp-Source: AGs4zMZRn51lwEXcXasu0at4FC2lS4IwAyTh3D8x7MxGyzhKQPUek/A0LEYxQ+4qBG5TP6SSwKMtsw==
X-Received: by 10.28.153.150 with SMTP id b144mr14303619wme.93.1511727085316;
        Sun, 26 Nov 2017 12:11:25 -0800 (PST)
Received: from p50-debian.bsdmn (cpc93788-hari17-2-0-cust762.20-2.cable.virginm.net. [82.39.98.251])
        by smtp.gmail.com with ESMTPSA id v195sm7495558wmf.25.2017.11.26.12.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 12:11:24 -0800 (PST)
From:   gennady.kupava@gmail.com
To:     git@vger.kernel.org
Cc:     Gennady Kupava <gkupava@bloomberg.net>
Subject: [PATCH 1/2] trace: remove trace key normalization
Date:   Sun, 26 Nov 2017 20:11:18 +0000
Message-Id: <20171126201119.24313-1-gennady.kupava@gmail.com>
X-Mailer: git-send-email 2.15.0.319.gd8415edcf
In-Reply-To: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
References: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gennady Kupava <gkupava@bloomberg.net>

Trace key normalization is not used, not strictly necessary,
complicates the code and would negatively affect compilation speed if
moved to header.

New trace_default_key key or existing separate marco could be used
instead of passing NULL as a key.

Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
---
 trace.c | 24 ++++--------------------
 trace.h |  4 +++-
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/trace.c b/trace.c
index cb1293ed3..d47ea28e8 100644
--- a/trace.c
+++ b/trace.c
@@ -24,26 +24,13 @@
 #include "cache.h"
 #include "quote.h"
 
-/*
- * "Normalize" a key argument by converting NULL to our trace_default,
- * and otherwise passing through the value. All caller-facing functions
- * should normalize their inputs in this way, though most get it
- * for free by calling get_trace_fd() (directly or indirectly).
- */
-static void normalize_trace_key(struct trace_key **key)
-{
-	static struct trace_key trace_default = { "GIT_TRACE" };
-	if (!*key)
-		*key = &trace_default;
-}
+struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
 {
 	const char *trace;
 
-	normalize_trace_key(&key);
-
 	/* don't open twice */
 	if (key->initialized)
 		return key->fd;
@@ -81,8 +68,6 @@ static int get_trace_fd(struct trace_key *key)
 
 void trace_disable(struct trace_key *key)
 {
-	normalize_trace_key(&key);
-
 	if (key->need_close)
 		close(key->fd);
 	key->fd = 0;
@@ -128,7 +113,6 @@ static int prepare_trace_line(const char *file, int line,
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
 	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
-		normalize_trace_key(&key);
 		warning("unable to write trace for %s: %s",
 			key->key, strerror(errno));
 		trace_disable(key);
@@ -167,13 +151,13 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!prepare_trace_line(file, line, NULL, &buf))
+	if (!prepare_trace_line(file, line, &trace_default_key, &buf))
 		return;
 
 	strbuf_vaddf(&buf, format, ap);
 
 	sq_quote_argv(&buf, argv, 0);
-	print_trace_line(NULL, &buf);
+	print_trace_line(&trace_default_key, &buf);
 }
 
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
@@ -215,7 +199,7 @@ void trace_printf(const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_vprintf_fl(NULL, 0, NULL, format, ap);
+	trace_vprintf_fl(NULL, 0, &trace_default_key, format, ap);
 	va_end(ap);
 }
 
diff --git a/trace.h b/trace.h
index 179b249c5..24b32f8f4 100644
--- a/trace.h
+++ b/trace.h
@@ -11,6 +11,8 @@ struct trace_key {
 	unsigned int  need_close : 1;
 };
 
+extern struct trace_key trace_default_key;
+
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
 
 extern void trace_repo_setup(const char *prefix);
@@ -78,7 +80,7 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
  */
 
 #define trace_printf(...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
+	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, &trace_default_key, __VA_ARGS__)
 
 #define trace_printf_key(key, ...) \
 	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
-- 
2.14.1

