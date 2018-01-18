Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965491F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755385AbeARJpv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:45:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44358 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755382AbeARJpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:45:50 -0500
Received: by mail-pg0-f67.google.com with SMTP id m20so13628144pgc.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTMLQJKgPpf1OsgfhnuUOnQgjpTdqKZvMSu6IYAjf5Q=;
        b=jgppXxcpoPe6sefETfWlYwSDzFYc4ErWWT0spEM/hDnole47y9JOora4w8ovlkNxqi
         sml74MTSmmj3kdrSMJnz0Y+z4lBlxgJv4v7itOupR5A+bYfAHt508I629c0D4gtRJgNM
         hq8CyQPpA1s4k7fDkLDBlYgIpk9ZTTr1BuFI+BlIsobDTNFJXngsUsRL3ck5rS+veMoK
         MY+UefgQzLyZzHstip401pBkr3RslwRM+ga4nn8j7xsI3Ok8IjNiPDyuv7P6ftolRFLL
         Hg9aYqL1/1Fh8iD/qVR8zgEBeAsS4o4LbzJKBDmdSbO9oDYBn9xrHlMNkjDeQhP80ur3
         0M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTMLQJKgPpf1OsgfhnuUOnQgjpTdqKZvMSu6IYAjf5Q=;
        b=DWSJybUhXEnkEbaxPguKNUsjV26OyC0wrVc+JJCJr8/gdb2WUJqDNg/JstJjsEb3XQ
         tXngTetWs8pkSnUVze9IJPaEGQF4I2LVjTUCXTQq27UAhOU74SPpAoevm5eV7h47KOXK
         eFQOl+Xy2cyUoFonM8nQXwAwkXbaAH4J1B+5aXlANieYiTXLsEZUAJ6VUFubhxwUeARl
         ydgFebbu+hPm2Vb0d3Uj00y1cGfh9jdgb4wIooiLs7m46lWpp7FmhyfUNlJoLq/pHgkd
         2q7WLQShe1knkA5TXWMPpp1sOFVLhku2YqhbNW1n3JRFsR/Sj9ghLNt739VCGCE9R0hi
         /rqA==
X-Gm-Message-State: AKwxytdqCVdCTRuQTy04F9oLNAgufJcg17lHlTPgv/WSZpjXDoFhQ0qf
        H3DyIoiV1FPD5qNk5DY55SUGpw==
X-Google-Smtp-Source: ACJfBoulSKzs57RqdY1lYYeAbOFXDqzDiGQ9u8Qmgtiz2EZ4RlUZU1k7St7EKF8hGbhc8DSpITJnCg==
X-Received: by 10.84.178.37 with SMTP id y34mr22182182plb.399.1516268749667;
        Thu, 18 Jan 2018 01:45:49 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id u21sm11558510pfl.114.2018.01.18.01.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 4/7] run-command.c: introduce trace_run_command()
Date:   Thu, 18 Jan 2018 16:45:09 +0700
Message-Id: <20180118094512.27849-5-pclouds@gmail.com>
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

This is the same as the old code that uses trace_argv_printf() in
run-command.c. This function will be improved in later patches to
print more information from struct child_process.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 31fc5ea86e..eadba8cb0d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -6,6 +6,7 @@
 #include "thread-utils.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "quote.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -556,6 +557,20 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	return code;
 }
 
+static void trace_run_command(const struct child_process *cp)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!trace_want(&trace_default_key))
+		return;
+
+	strbuf_addf(&buf, "trace: run_command:");
+	sq_quote_argv_pretty(&buf, cp->argv);
+
+	trace_printf("%s", buf.buf);
+	strbuf_release(&buf);
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -624,7 +639,8 @@ int start_command(struct child_process *cmd)
 		cmd->err = fderr[0];
 	}
 
-	trace_argv_printf(cmd->argv, "trace: run_command:");
+	trace_run_command(cmd);
+
 	fflush(NULL);
 
 #ifndef GIT_WINDOWS_NATIVE
-- 
2.15.1.600.g899a5f85c6

