Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5694D1F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbeARJpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:45:33 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40990 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754834AbeARJp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:45:29 -0500
Received: by mail-pf0-f195.google.com with SMTP id j3so14030704pfh.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srJCd7XmgPxvqpm5rPrKGFuWtX7lnq5ZHhDM0uDojtQ=;
        b=soHbHCGyJXjgfxx55ttee3taRTVnwgSbCWbgpZ1U1YhY1S7X8R37wm3N6ZVPTfJX30
         WqfCiDGuEIWxQ1jIB5qCrCQGYWCk08IrznCwxxoDoFwQsNPCmyTvZDg5F5gbHtgCYTiA
         MkvJJ1RJdvqickixyqWtUD2jMEaG5EelOJH3SkYflZEOtjtOhJtnBNZYdIXS1onispUc
         ZKmN7MXVwi9+lzUbixjJPp1CZszB74F0vP5jLe0Maxy3GRuHdLbXvuQTNMyvFIvBqhCG
         f9qI73cWRdXfsZYj7JLhXt+hd5aHOX193nusPEeFzIaHBTrFeB4/h2L4dTn48TiQ1lDq
         2YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srJCd7XmgPxvqpm5rPrKGFuWtX7lnq5ZHhDM0uDojtQ=;
        b=RCfgEBXZ9uC9lBE6alyDN6MLK5HIPHlyIH6N804+Stzl7WWqsd5IOlZefQaMoWNYDC
         Gd/VGVU8jluEprHvM1jQ6KKYbciDADUR09P4tTmzSRFEG9Vin0D+WGR3DSaHM7h0sEpb
         TVYxgnjFiJEP+lrGE8ONP+YCZmT1fNZhFD/Br0tJFvgITDxMz1bFMQNPeVTbhSnHc6ni
         HH4/3obN68n/WqArQX3sv+q3jm2MGIFtUXCEECjCnkG/093VpAMCyKwLmTLsN60nElLn
         x6LxHKIm3aAh9rEb/jTgG7dCX8Vf0W05I1Q5Pk6H6YFkbuhQHe9BV9ywcZLPshHAhly/
         vAlg==
X-Gm-Message-State: AKwxytdDmJUmxtY1OeNMZc1qXxgmR3JMqpwTBplj4VRv/SRImveEnZLo
        j6LSmm8bI5Og3l29LVDxiDBVRQ==
X-Google-Smtp-Source: ACJfBot0wto4DPsFsKs7E9o9GjDuc+nVf4b6xdiM+gTa8fuxve1udexGaqa1YgD55kPuns7uHwsDHQ==
X-Received: by 10.159.208.2 with SMTP id a2mr17247262plp.331.1516268728391;
        Thu, 18 Jan 2018 01:45:28 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id c83sm13332952pfk.8.2018.01.18.01.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 1/7] sq_quote_argv: drop maxlen parameter
Date:   Thu, 18 Jan 2018 16:45:06 +0700
Message-Id: <20180118094512.27849-2-pclouds@gmail.com>
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

No caller passes anything but "0" for this parameter, which
requests that the function ignore it completely. In fact, in
all of history there was only one such caller, and it went
away in 7f51f8bc2b (alias: use run_command api to execute
aliases, 2011-01-07).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c        | 2 +-
 builtin/rev-parse.c | 4 ++--
 quote.c             | 4 +---
 quote.h             | 2 +-
 trace.c             | 4 ++--
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..5bdd2d7578 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1061,7 +1061,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_state_text(state, "scissors", str);
 
-	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
+	sq_quote_argv(&sb, state->git_apply_opts.argv);
 	write_state_text(state, "apply-opt", sb.buf);
 
 	if (state->rebasing)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 74aa644cbb..96d06a5d01 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -516,7 +516,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_SHELL_EVAL);
 
 	strbuf_addstr(&parsed, " --");
-	sq_quote_argv(&parsed, argv, 0);
+	sq_quote_argv(&parsed, argv);
 	puts(parsed.buf);
 	return 0;
 }
@@ -526,7 +526,7 @@ static int cmd_sq_quote(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 
 	if (argc)
-		sq_quote_argv(&buf, argv, 0);
+		sq_quote_argv(&buf, argv);
 	printf("%s\n", buf.buf);
 	strbuf_release(&buf);
 
diff --git a/quote.c b/quote.c
index de2922ddd6..b2970da627 100644
--- a/quote.c
+++ b/quote.c
@@ -56,7 +56,7 @@ void sq_quotef(struct strbuf *dst, const char *fmt, ...)
 	strbuf_release(&src);
 }
 
-void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
+void sq_quote_argv(struct strbuf *dst, const char **argv)
 {
 	int i;
 
@@ -65,8 +65,6 @@ void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 	for (i = 0; argv[i]; ++i) {
 		strbuf_addch(dst, ' ');
 		sq_quote_buf(dst, argv[i]);
-		if (maxlen && dst->len > maxlen)
-			die("Too many or long arguments");
 	}
 }
 
diff --git a/quote.h b/quote.h
index 66f5644aa2..48a75a416b 100644
--- a/quote.h
+++ b/quote.h
@@ -30,7 +30,7 @@ struct strbuf;
  */
 
 extern void sq_quote_buf(struct strbuf *, const char *src);
-extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
+extern void sq_quote_argv(struct strbuf *, const char **argv);
 extern void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /* This unwraps what sq_quote() produces in place, but returns
diff --git a/trace.c b/trace.c
index b7530b51a9..fa9174fc4b 100644
--- a/trace.c
+++ b/trace.c
@@ -157,7 +157,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	strbuf_vaddf(&buf, format, ap);
 
-	sq_quote_argv(&buf, argv, 0);
+	sq_quote_argv(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
 }
 
@@ -426,6 +426,6 @@ void trace_command_performance(const char **argv)
 		atexit(print_command_performance_atexit);
 
 	strbuf_reset(&command_line);
-	sq_quote_argv(&command_line, argv, 0);
+	sq_quote_argv(&command_line, argv);
 	command_start_time = getnanotime();
 }
-- 
2.15.1.600.g899a5f85c6

