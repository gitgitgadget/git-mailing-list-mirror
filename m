Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F3A1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965446AbeAMGu1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:27 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44032 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965440AbeAMGu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:26 -0500
Received: by mail-pf0-f193.google.com with SMTP id m26so5887082pfj.11
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAI88EtK0D7fbtcppLHSKw3dNOm3tLt5K+Kih80Das4=;
        b=BKwbFto/1pbZ/ZgT2rKBnr4BbFeuv+2bbumnQHAykOqkkPaHKlGN+TBBk/i/eCEluT
         8n5tYmdurEuyH6ol5Lm/Cu0Z3FMUPbWvua5zB8k5EMLxL3oaQLUW+PFYTsJSayG5DNua
         DVU+CBA9CZNVFFtfy7TjdCMsEjSVuPAzB3fDB9fxowPoQBgQu7rMIPYZpt8steoPidYv
         eHQ+dk+mNP/+GUSPdfEFC+cizpMA8mq+gu53OOyKy/50MXKBi7g5FRa77+dXbivSuGu+
         v3fZzN2tyPfxP83D3hLLAaeJQ4HicOIyv0qFKweGK7/nPedJVl/QOjV+SdJMlKSWX96G
         O7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAI88EtK0D7fbtcppLHSKw3dNOm3tLt5K+Kih80Das4=;
        b=Hj4FYfiUtUrKvwzIurpImKlXvwBooDTw2kDtVgPh8Bjl7fz59U5KeN5oh0RIrvSTw7
         ZPF7GFhalEXSWzb82sCKmbfR6GOvi1TX5ZIIVV1Rm7fQEuEgkfX6o0sq6ABGoKPOJkgS
         njhoSHFJE29eiizE03ftqKLms84w3HMV7b848MN4kHM8yQvtzVQt/N/gEyqQuQrjIju8
         Vfzqgr1oxN4HlZTXoeC610ol/7TfEHYVreePJA8ERn5EE6cMwQqcm1BvpYIZ/vcbe99v
         ukFLzGjt6zRVaYpliWnZRvkXAOMZ/zoEo5OXIiCY7FMpxQg7y72fFglHBsmAaFNT20U+
         jYew==
X-Gm-Message-State: AKwxyte4wQhdkQpYxWI9zXEI+tYFKrFVC0doHXlSlLoJsDC+jrbF5/5+
        t1MkLM3a7C2pYa+D/l0QSmFiww==
X-Google-Smtp-Source: ACJfBotQs4Fo7YJ4ZRebYgL/SA8B4bHipI+t+au0YiY9uJbUWKf67Gkyhr95OG+O5Oee7Q4uCJsm8w==
X-Received: by 10.99.115.67 with SMTP id d3mr7726499pgn.223.1515826225810;
        Fri, 12 Jan 2018 22:50:25 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id e62sm13557353pfa.173.2018.01.12.22.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:50:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 4/7] trace.c: introduce trace_run_command()
Date:   Sat, 13 Jan 2018 13:49:46 +0700
Message-Id: <20180113064949.6043-5-pclouds@gmail.com>
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
index 7f3b08e148..25c333709b 100644
--- a/trace.c
+++ b/trace.c
@@ -23,6 +23,7 @@
 
 #include "cache.h"
 #include "quote.h"
+#include "run-command.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
@@ -275,6 +276,20 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
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
+	sq_quote_argv_pretty(&buf, cp->argv);
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

