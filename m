Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A431FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbeAMGuL (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:11 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46679 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeAMGuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:10 -0500
Received: by mail-pl0-f68.google.com with SMTP id 66so319559plc.13
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTgD6tY7cnOfsxspTAjPbYHoYLthvu7ZU/9/7IBlw2k=;
        b=g2Srxo2faBAfgXXMP95VeG7sJOjvW4u7zmOby1rCN6sGwHOXr0KZ0dgXB5jD3hm+fV
         E4R1gDy9a1HqG1yvpOmxq0aTTpsVUlxLmq5rSDjzzzdxUX5aLYkC6yl9bQ/SzTHm9HG4
         0lKfOgTCPTo9e6s6LInpHrErp8YUID13UCF8ioJhyP2Wu7phAvi91sxYaXeQhN28FRqm
         P1uGPux9I65snkGT9ys1Kk/sAX0pwjrW7HYFVE1GiODZkXVkQIDJtlBxG3WeJMyIykZA
         NlUZo0dN4fugBYzcbaPlfF6/QZJ/Igpwq8yVWY/TMS8FOFRGQBZz3j0ue/JIaY1Hf9co
         AI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTgD6tY7cnOfsxspTAjPbYHoYLthvu7ZU/9/7IBlw2k=;
        b=fQp3DI+SaE38s6BQkhUhESiOinBlpoajOYYMdDDmOioTJ0qJt4MtV0uFyY4QFmYtYC
         xDprfrjxuIwjIjx/I4+Lddw7agN7HbjSESaSzzWEE8Dqg4BS1H6FgWf9eDUB6uMvyLHC
         FQ2r/9ymfWHdi29LIdLFxAWaWLNfrDOQ/iGHRQfXdYPHzZV5JE3s+pFd5I/QXW58G851
         rJd043BksYdPkAdggiDpDmxUd9UZhN/0InJsN0R1c3RBsfUooyz2kfoL7CiQ/RbIUQzn
         npntGeRkY/UX9IPuYsuKEPI49ldLDT2JXxcUd1e1PSLyGsGG54koCMdozwpVxb2DZlj4
         /mJQ==
X-Gm-Message-State: AKGB3mKM/kJ1QJ3+AQaW1CrPHPVoAmd6Io087qEysCC/p8MTIcioqn3c
        PpqnS+Su9x/kVrzjPU+dJ6cJWw==
X-Google-Smtp-Source: ACJfBosr7Vjc1iaL7EgHOz6ipohcjtOALVklW84luh+K7vvdc8rTx8E+LtgCBOHeyY/uXkKR6R7Wag==
X-Received: by 10.159.242.199 with SMTP id x7mr20020723plw.94.1515826209832;
        Fri, 12 Jan 2018 22:50:09 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id j11sm20887071pgc.41.2018.01.12.22.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:50:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 2/7] trace: avoid unnecessary quoting
Date:   Sat, 13 Jan 2018 13:49:44 +0700
Message-Id: <20180113064949.6043-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180113064949.6043-1-pclouds@gmail.com>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Trace output which contains arbitrary strings (e.g., the
arguments to commands which we are running) is always passed
through sq_quote_buf(). That function always adds
single-quotes, even if the output consists of vanilla
characters. This can make the output a bit hard to read.

Let's avoid the quoting if there are no characters which a
shell would interpret. Trace output doesn't necessarily need
to be shell-compatible, but:

  - the shell language is a good ballpark for what humans
    consider readable (well, humans versed in command line
    tools)

  - the run_command bits can be cut-and-pasted to a shell,
    and we'll keep that property

  - it covers any cases which would make the output
    visually ambiguous (e.g., embedded whitespace or quotes)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 quote.c | 26 ++++++++++++++++++++++++++
 quote.h |  8 ++++++++
 trace.c |  4 ++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/quote.c b/quote.c
index b2970da627..37d2686865 100644
--- a/quote.c
+++ b/quote.c
@@ -43,6 +43,22 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }
 
+void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
+{
+	static const char ok_punct[] = "+,-./:=@_^";
+	const char *p;
+
+	for (p = src; *p; p++) {
+		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
+			sq_quote_buf(dst, src);
+			return;
+		}
+	}
+
+	/* if we get here, we did not need quoting */
+	strbuf_addstr(dst, src);
+}
+
 void sq_quotef(struct strbuf *dst, const char *fmt, ...)
 {
 	struct strbuf src = STRBUF_INIT;
@@ -68,6 +84,16 @@ void sq_quote_argv(struct strbuf *dst, const char **argv)
 	}
 }
 
+void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
+{
+	int i;
+
+	for (i = 0; argv[i]; i++) {
+		strbuf_addch(dst, ' ');
+		sq_quote_buf_pretty(dst, argv[i]);
+	}
+}
+
 static char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst = arg;
diff --git a/quote.h b/quote.h
index 48a75a416b..ea992dcc91 100644
--- a/quote.h
+++ b/quote.h
@@ -33,6 +33,14 @@ extern void sq_quote_buf(struct strbuf *, const char *src);
 extern void sq_quote_argv(struct strbuf *, const char **argv);
 extern void sq_quotef(struct strbuf *, const char *fmt, ...);
 
+/*
+ * These match their non-pretty variants, except that they avoid
+ * quoting when there are no exotic characters. These should only be used for
+ * human-readable output, as sq_dequote() is not smart enough to dequote it.
+ */
+void sq_quote_buf_pretty(struct strbuf *, const char *src);
+void sq_quote_argv_pretty(struct strbuf *, const char **argv);
+
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
  * produced.
diff --git a/trace.c b/trace.c
index fa9174fc4b..9784915be1 100644
--- a/trace.c
+++ b/trace.c
@@ -157,7 +157,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	strbuf_vaddf(&buf, format, ap);
 
-	sq_quote_argv(&buf, argv);
+	sq_quote_argv_pretty(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
 }
 
@@ -426,6 +426,6 @@ void trace_command_performance(const char **argv)
 		atexit(print_command_performance_atexit);
 
 	strbuf_reset(&command_line);
-	sq_quote_argv(&command_line, argv);
+	sq_quote_argv_pretty(&command_line, argv);
 	command_start_time = getnanotime();
 }
-- 
2.15.1.600.g899a5f85c6

