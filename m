Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D413A1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeAMGuF (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:05 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43802 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeAMGuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:04 -0500
Received: by mail-pf0-f196.google.com with SMTP id e3so5885433pfi.10
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YF9uDYFOHxF4PkI2tXglwEBRgeeA3DropXjNk/VgWQM=;
        b=SERe7znRdLfWVIF1icPLJwA8c395XLXINTyP5djG1Ct5TAuXFs+G2kUzGDTTMezF8q
         I/IY1fpo+1YUrJGXcGZ2UZ48MdAaSUc37pAD8W2DLhDhf25rdvjMkaEunm/LtGdZLpMw
         VlIrAf7Vk77JldkAq/nZtT4QcunTtwOALsA2JyYpJA6FRIEPsfz0ByQPTj/tXeja8Yjq
         fdJ29yBkn0K1CyuBhb7FYI2Mn3Q8IXXFFNEVvl6biwDxIucH4JbpCOIRoaAiRPexfcfb
         gBWa5557/CWPFVFRMdgdNgSCWnkWWms031ZPqY7hZSvX1BkjKxszPfnvhk2DwOdKwwDY
         dh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YF9uDYFOHxF4PkI2tXglwEBRgeeA3DropXjNk/VgWQM=;
        b=QxhqbDrHfIseH/0Bo1313gUXLrRRS/c6PTYw8fp6Awoq78a1AKYypAMl0JcIyUFYYe
         9QNFsLSx+O/j79g2tBu1k2v3yW11YgNwFmi+O4fka0bNh6iYYa0n8CPpUJ8Tz6rv1so0
         S/EMM+QNh3HwO1WvuLL6B7zsGOk9qQEX59ptpmNAyG3W4MK9frzUIemWx+W4yJI37r0l
         HKw46LsRufJubQPIvhtnb2blJvQla41X/C0cW12D8ErHg49oTWomV64c/CHx/TxXP5WL
         0EJsfokJwig1mEWDqjUTtWhHnNuwMwG6v4wey0PPy0bqN03ShHPGqvKw7xG3bspWVpum
         sqkg==
X-Gm-Message-State: AKGB3mJUKfsAXYfJR1ji7BGuHVchX8sh/iVF4QmZeI4naLOfRNITzsgE
        yOnC2hXLMoiXx90XuQzDDq27pQ==
X-Google-Smtp-Source: ACJfBovaoXuj9ALWnoCp7vUAEPPz5rQ3gqbjlv+VFbWLMc70pfs1uIT4rR9cvWm0yiwbh03BjM/WGQ==
X-Received: by 10.101.77.207 with SMTP id q15mr22283278pgt.368.1515826203788;
        Fri, 12 Jan 2018 22:50:03 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id m65sm46174756pfm.41.2018.01.12.22.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:49:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 1/7] sq_quote_argv: drop maxlen parameter
Date:   Sat, 13 Jan 2018 13:49:43 +0700
Message-Id: <20180113064949.6043-2-pclouds@gmail.com>
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

No caller passes anything but "0" for this parameter, which
requests that the function ignore it completely. In fact, in
all of history there was only one such caller, and it went
away in 7f51f8bc2b (alias: use run_command api to execute
aliases, 2011-01-07).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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

