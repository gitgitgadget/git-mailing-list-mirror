Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D481F404
	for <e@80x24.org>; Mon, 15 Jan 2018 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeAOLAI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 06:00:08 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46291 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755004AbeAOLAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 06:00:07 -0500
Received: by mail-pg0-f68.google.com with SMTP id s9so5998118pgq.13
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 03:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YF9uDYFOHxF4PkI2tXglwEBRgeeA3DropXjNk/VgWQM=;
        b=rYzzryj8CFm4JpXj02aHZ5e1r4nxHgAOSGji8B1WwLXNPCLd61J6WUJBEXVVzWGb2c
         sEzcbvtpKn6QOtgD/Qfg22E3pO7gMpcRqNOxJsQMY87t4XNWONzLAU8ek2fih9yfZlGR
         GXizsZswQ5LfoYXnV8nttYzfPar8UqjG62uDjghz4X4ITTwNF8O6QDXmzOEaqNCWiX3+
         jAvt59QbqL6h+qbh2QqdjNBLCc0oIh4SaGuO4ZDu5tgLrDvHcblLivGAwR1cx+T/zOYB
         PIEvXRp6kBaJ6U46kvrcgJQroNfg3xDfxlkHdEzpuAcrlIChHGMpmrxAdT85Jkgdjl1Z
         sA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YF9uDYFOHxF4PkI2tXglwEBRgeeA3DropXjNk/VgWQM=;
        b=dBL09NNuLP+ad4NvbeePpmG3JPRKfB1ywJ1ghpdyZCt7ZHuvulEOrYkCD4VGuo+ZCg
         OMwXlbn2rE9uKQUstz3C6xW6mDRWhFLUlw8Nw4KTQu9wGfl7llPVt0qVA91qNB4JGQx/
         oIF9LD3Hwl7x3bEW3NHXQ6mvvTkKAitg7A9ddULKASmB4NcFUWmZ1ZTfgw4XSFYazQBj
         eRsmDhpgrXty5OgGqExMaj5Rej63UI6CeC+lj+LbHrEEGDh54S3KUXfiWQR4gQFItFS0
         5RBwiRJGnOoOL7EPOvhp5soYq4hqjdDPDnMnkuN4xiVecNBLwKZxBSa4mVO+5N1U2sNh
         8Fcg==
X-Gm-Message-State: AKwxytfb2Ai8V8yZWeZ1F4LfM+VQ91e6o57WZ7yfrGS6+AMI0Sa51bXE
        htfrz7py7HGJoEtKSL1GvU1EEA==
X-Google-Smtp-Source: ACJfBotu9ZFk0pCruSqUa1TJOUpn05tHet6E9ZDEyKiJAQcCsIWLfhXtv03/l4lhWSq9+Bj80OxStg==
X-Received: by 10.99.124.2 with SMTP id x2mr14918772pgc.184.1516014006979;
        Mon, 15 Jan 2018 03:00:06 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id 126sm26370574pfe.134.2018.01.15.03.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 03:00:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 15 Jan 2018 18:00:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 1/7] sq_quote_argv: drop maxlen parameter
Date:   Mon, 15 Jan 2018 17:59:43 +0700
Message-Id: <20180115105949.18328-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180115105949.18328-1-pclouds@gmail.com>
References: <20180113064949.6043-1-pclouds@gmail.com>
 <20180115105949.18328-1-pclouds@gmail.com>
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

