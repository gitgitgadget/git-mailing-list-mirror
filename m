Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11821F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbeARJpm (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:45:42 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43123 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755330AbeARJpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:45:38 -0500
Received: by mail-pf0-f196.google.com with SMTP id y26so6460018pfi.10
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmOTMZ3A/kkOpnvdpc01TYMKoLRPPbVHyPWxUmF64Sc=;
        b=SSqssW8J8oWfIph1fYShRLBE7b2Ou2sQzOZXGoxFy5kEJm97VyyUHcLezxMz5pFAfj
         meM+SgSCOstvpXLekHHW0bDhzgRVkp+2ruPNQugHWij1HHOuMdULIBwe8RqRxXV6zSSY
         jzaiURGxkMB+A2YgHlT21CUlLM2VrNc6OLvBQuzMOyjKXn2I7RH9bFYKURPbVrYk8GGw
         Mc9mcTwrtqL9hWqRJxOmO4zV722+5x7fl8SpcwhsYUF2IcD3e3QBu/enFK2lvnjbVUC2
         DAAouiFMe7lPBAY/rrfy1bXqOhS/cAVu7auPlAMqwWlrghMYhjeKAiUyAQtM9G7TtyLO
         OzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmOTMZ3A/kkOpnvdpc01TYMKoLRPPbVHyPWxUmF64Sc=;
        b=g/903dzl2iutGRefunSQDbAas6oCWSTZE6nDIwHs7Q1s8mFhqgTN+6qVv8oAgLOYsz
         YpFgokXJphWlywxT1x6elnh7GzFQCHBRJgc7n0hl4/wV6npmzSf+dKW7ApvLzoV9jzRQ
         7f80iugE7SAJrg1yIPTCBgEGU9wLfE7a563gddjHPMC/B8VbScVg11xP9eGNsvSeQXv5
         jRUz/HQqAcvawDgnVxsTwdzm0Sv8MiqxdA2iHE1fPIydjR44S/oGo4F3msEiP15OiPZM
         RBwp56DR2LDeok4Lt+NloTrTPVRwbclpb2nbQhaUezkB0vAAsEZGc+Zt3n/g/y34+vPz
         G7sQ==
X-Gm-Message-State: AKwxytdFSfM7h/nVngQRv1jewDc8+KYSNZYZ49F7HAxb110xFi4/lau0
        FoGtTYGxchik68ylNspNGOR+DA==
X-Google-Smtp-Source: ACJfBouHHDLEQfzXjMqSk0kngn+Dq1GHHNjJGo2Ax/SX2oeT23w4aHPzfuGeVMxinvEyEqt5qjvNpQ==
X-Received: by 10.98.156.71 with SMTP id f68mr22157346pfe.29.1516268737851;
        Thu, 18 Jan 2018 01:45:37 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id l8sm10721397pgc.58.2018.01.18.01.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 2/7] trace: avoid unnecessary quoting
Date:   Thu, 18 Jan 2018 16:45:07 +0700
Message-Id: <20180118094512.27849-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180118094512.27849-1-pclouds@gmail.com>
References: <20180115105949.18328-1-pclouds@gmail.com>
 <20180118094512.27849-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

