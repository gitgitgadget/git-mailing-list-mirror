Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB611F404
	for <e@80x24.org>; Fri, 12 Jan 2018 09:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbeALJ5C (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 04:57:02 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39859 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754350AbeALJ5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 04:57:00 -0500
Received: by mail-pf0-f194.google.com with SMTP id e11so4046217pff.6
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RTY1iL+VzykFjARjy0hJf9X4BdZDFJuWiOPIrM1s8U=;
        b=qGlw+L3Vrw/EYMXyx+czBzhXTCw+Wi7egDwcyZsXBvwBTeqttdpXXHwQaSWYttqxMO
         B9S9v0IyVuOq/PHIW/jfq0Y68ApfqoD8pHqeFubcZr8VXj2EtXyaoLQreVs0jmzus+t3
         agXTZcKLUSC8Bdin93g45xQME1zz44G9JFs83sjV5bH5dvC3Kv3D8I1MdIat9r2qnbqI
         /Ba5iddIyMT3WjROUKX0mVT7lExwsTrkKMpDjipcHsnJA9xCgv35SR65Ba+Oejv6sT3O
         1T/vOFf3RZjRJI0+8ttByZ6+FnSQiYuRPOor8glrIq779LDR3H8kyKRF/kP9rfTHWVGa
         3k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RTY1iL+VzykFjARjy0hJf9X4BdZDFJuWiOPIrM1s8U=;
        b=mRUJ8G5zblyn8rgW/p2H0Ue76sSh7gM6j7V+vxmNqeeNKEEbFpwN/uKW8ttcITqi6/
         Zy6yXY3e8FcN0Qpz5wmPEInu6LrayAyLU9TC6NZlTbYhDCT96z6t8z+ImGbpYSJWz6qL
         TCr1XbplI3acMYcwQKSTT1xAZ4Yb3V9afm7w6bbEqFwDjdNXNzfYeauiSWW3rGiN1dBH
         MpsKm+/YXk/HlmWkCd9nNCqzH+U3w9kmLNK18JzFJ1dXo0TPHzcFkQx94PsPd2F0da3C
         YKfnnQtxmBNf6QY0s1hjtbWkMfVX4M9Bt1MR6lh7w4d1JH8bLlEHXqp6jO9DL59QabEg
         bwzQ==
X-Gm-Message-State: AKGB3mJ4iq29swvg7t8+UwElRf9OfdT40RnDr8Rrr+JCiPs1H1HeXAXC
        eVDWYuDKFRp1owVsW0GgwGTWIA==
X-Google-Smtp-Source: ACJfBotn803OGnIBd8OtCgA57HhGu+p4UiOWW6IisWuUNRC0FjkAjTMyXl4m/8r4yPj2LeWp4wK8CA==
X-Received: by 10.98.73.89 with SMTP id w86mr23183087pfa.31.1515751018888;
        Fri, 12 Jan 2018 01:56:58 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id j6sm43565573pfg.85.2018.01.12.01.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 01:56:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Jan 2018 16:56:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/4] trace.c: introduce trace_run_command()
Date:   Fri, 12 Jan 2018 16:56:04 +0700
Message-Id: <20180112095607.18293-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180112095607.18293-1-pclouds@gmail.com>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same as the old code that uses trace_argv_printf() in
run-command.c. This function will be improved in later patches to
print more information from struct child_process.

A slight regression: the old code would print run-command.c:xxx as the
trace location site while the new code prints trace.c:xxx. This should
be fine until the second call site is added, then we might need a macro
wrapper named trace_run_command() to capture the right source location.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.c |  3 ++-
 trace.c       | 15 +++++++++++++++
 trace.h       |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 31fc5ea86e..002074b128 100644
--- a/run-command.c
+++ b/run-command.c
@@ -624,7 +624,8 @@ int start_command(struct child_process *cmd)
 		cmd->err = fderr[0];
 	}
 
-	trace_argv_printf(cmd->argv, "trace: run_command:");
+	trace_run_command(cmd);
+
 	fflush(NULL);
 
 #ifndef GIT_WINDOWS_NATIVE
diff --git a/trace.c b/trace.c
index b7530b51a9..f08c673b51 100644
--- a/trace.c
+++ b/trace.c
@@ -23,6 +23,7 @@
 
 #include "cache.h"
 #include "quote.h"
+#include "run-command.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
@@ -272,6 +273,20 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 #endif /* HAVE_VARIADIC_MACROS */
 
 
+void trace_run_command(const struct child_process *cp)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!prepare_trace_line(__FILE__, __LINE__,
+				&trace_default_key, &buf))
+		return;
+
+	strbuf_addf(&buf, "trace: run_command:");
+
+	sq_quote_argv(&buf, cp->argv, 0);
+	print_trace_line(&trace_default_key, &buf);
+}
+
 static const char *quote_crnl(const char *path)
 {
 	static struct strbuf new_path = STRBUF_INIT;
diff --git a/trace.h b/trace.h
index 88055abef7..e54c687f26 100644
--- a/trace.h
+++ b/trace.h
@@ -4,6 +4,8 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
+struct child_process;
+
 struct trace_key {
 	const char * const key;
 	int fd;
@@ -17,6 +19,7 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 
 extern void trace_repo_setup(const char *prefix);
+extern void trace_run_command(const struct child_process *cp);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
-- 
2.15.1.600.g899a5f85c6

