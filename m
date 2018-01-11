Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6721F406
	for <e@80x24.org>; Thu, 11 Jan 2018 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbeAKJrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 04:47:31 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45700 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbeAKJra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 04:47:30 -0500
Received: by mail-pf0-f196.google.com with SMTP id u19so1272154pfa.12
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kerjlB6nO3SuGt+YKNPvp6QZ7XFQGObjlFbYPYBBBI=;
        b=CoTeOj2x2K+LumFQYf2pe6qFxoTZYEH08V81VzXV4hG0BY5WIZnU+4sShmENLq+44d
         EuVNeHGziCYS4aazmokKqQk4mR9IzsyH8aMOuKxCjFq+SX12Ho/9hnQX86YTsVztY6dG
         YOJs9BXCZlTG1QbwJ7tr4oyHoWFEDRaSfh+EENbWcMwFquYwnr11qFwfYyy2fTg6SOA7
         2NDD6U2uT2XzEVlyrjNoJBfw8ahY2qIaV3NVMjNb+bVo+SMWqk8Yp1QPLJOGLMv6crrP
         k0y1svjOLk6vi2x1UVP8+pIJ4YgVweR6Iidqs4QxbWW1+TDhSUEKQnRA0zoKsprjfsrJ
         3L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kerjlB6nO3SuGt+YKNPvp6QZ7XFQGObjlFbYPYBBBI=;
        b=tTh7xFQKMueNgAyEVm9ouRWTzCGHV73xUZU8+ii8J/RjeMNKw5zZdamD/mML1GAgmY
         mDOOhRQu9VKnfLhuodW+Cy9oN46/fcUJXRFNszJ8afAsELqKNmaSkXjAJB5JSxWC7nfW
         QRXtQr+kJJ1K5Y/SDJYSoiALvUEMrdQN1Ih3h2XI1YSTdpqPb3E13Ox5jP/cjTJ/HGun
         12rJ3UHl/HpqZHfiuWFC6IzKD+Ic3s1LTCBfBj9//JZtC/VrZL7ulWtdZPyIGx8Lc4oV
         OB/pNi2TNMH8FXdDcWsGxvbNqjFS7IVtXLhgGNJaqH7fT/Dln7U3am7vgK7hzANfHF2r
         TN1w==
X-Gm-Message-State: AKGB3mJiVONZFHua0qIVUeOYZz+AIxlobTwGeyQrE4X7DoJfBwZ9UeWl
        2YydaGBkMEbGWZSfCJnHosNivA==
X-Google-Smtp-Source: ACJfBotXJ9skhrzmjHhOhslG6u4b/2bBskVDhUDzbN36xletMumfjxQvHpFDHdWm6OAFS8jIA6r/yA==
X-Received: by 10.98.48.194 with SMTP id w185mr19638065pfw.52.1515664049369;
        Thu, 11 Jan 2018 01:47:29 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id 77sm39876371pfh.43.2018.01.11.01.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jan 2018 01:47:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Jan 2018 16:47:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] run-command.c: print env vars when GIT_TRACE is set
Date:   Thu, 11 Jan 2018 16:47:12 +0700
Message-Id: <20180111094712.2551-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180110104835.22905-1-pclouds@gmail.com>
References: <20180110104835.22905-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally submodule code could execute new commands with GIT_DIR set
to some submodule. GIT_TRACE prints just the command line which makes it
hard to tell that it's not really executed on this repository.

Print modified env variables (compared to parent environment) in this
case. Actually only modified or new variables are printed. Variable
deletion is suppressed because they are often used to clean up
repo-specific variables that git passes around between processes. When
submodule code executes commands on another repo, it clears all these
variables, _many_ of these, that make the output really noisy.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 fixes up commit message to clarify about "env delta" and why var
 deletion is not printed.

 It also keeps child_process tracing in one place/function, this
 should make it easier to trace more e.g. cwd and stuff.

 Though, Stefan, while i'm not opposed to trace every single setting
 in child_process, including variable deletion, cwd and even more, it
 may be not that often needed for a "casual" developer.
 
 I suggest we have something like $GIT_TRACE_EXEC instead that could
 be super verbose when we need it and leave $GIT_TRACE with a
 reasonable subset.

 run-command.c |  3 ++-
 trace.c       | 39 +++++++++++++++++++++++++++++++++++++++
 trace.h       |  3 +++
 3 files changed, 44 insertions(+), 1 deletion(-)

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
index b7530b51a9..e5e46e2a09 100644
--- a/trace.c
+++ b/trace.c
@@ -23,6 +23,7 @@
 
 #include "cache.h"
 #include "quote.h"
+#include "run-command.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
@@ -272,6 +273,44 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 #endif /* HAVE_VARIADIC_MACROS */
 
 
+static void concatenate_env(struct strbuf *dst, const char *const *env)
+{
+	int i;
+
+	/* Copy into destination buffer. */
+	strbuf_grow(dst, 255);
+	for (i = 0; env[i]; ++i) {
+		/*
+		 * the main interesting is setting new vars
+		 * e.g. GIT_DIR, ignore the unsetting to reduce noise.
+		 */
+		if (!strchr(env[i], '='))
+			continue;
+		strbuf_addch(dst, ' ');
+		sq_quote_buf(dst, env[i]);
+	}
+}
+
+void trace_run_command(const struct child_process *cp)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!prepare_trace_line(NULL, 0, &trace_default_key, &buf))
+		return;
+
+	strbuf_addf(&buf, "trace: run_command:");
+
+	/*
+	 * caller is responsible for setting this if the main source
+	 * is actually in cp->env_array
+	 */
+	if (cp->env)
+		concatenate_env(&buf, cp->env);
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

