Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9ED01F404
	for <e@80x24.org>; Fri, 12 Jan 2018 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeALJ5S (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 04:57:18 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44777 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754350AbeALJ5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 04:57:16 -0500
Received: by mail-pf0-f196.google.com with SMTP id m26so4050739pfj.11
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJxh/1QuN99pEH0YFgX62TMYiMnE91SqeAc9LAiOLe0=;
        b=rfLMcnkWrDu8ZfwRvnhIwmJp9gaL/mTZK7ioZ8VL4Mikr5FatnERBEITXzZA0yHU8E
         n/AhRoQyOCVPz7MRbGtePtLb52CTcCOy4an8Pm0Zx+XrzB3GCJ3MjmrCeq/99iQuYyQE
         MMMJp0gQG9QX/KRXHD4lTtMHtO+/k/RVeA6r97IheEcmaNDO9qg3m0jDUYxhpsqZvwo3
         VOs+FPpVjX1TrzmUug4rJBAq5eULOwYWe3hLSUOQXQQLdrtTnUTyvSSn02oJbOWJgh7i
         WTEX9+kAnROZoINTi3bYzUZp+6xFtNii4mpm0z5likU7JrDRcFns/YBPoqNDlp3i1ubE
         BvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJxh/1QuN99pEH0YFgX62TMYiMnE91SqeAc9LAiOLe0=;
        b=XoapRN4dE89bCw6EsCKI5n5hZUIMLXpdO788CvrCvvc191flre6ulFU4SwgRGy630B
         tHjs0LKLbgKrH6en6DTM5Z5JwTj3NYnUOS+tqvBM9eYCN46ra364cs487ATuxGoEOHKj
         1U+4TNqocnwRbU6RNI4tuTzac/56i0qq5Vr9KdbKGyHLxK7TB5QJTv3tQHqvQGtzdnvv
         SjnGRLLoJBcgUDA7Qez+9EMbmzCDUBNUfrs10NeZraxysGIi91+Yk4BzlAxWA892BT64
         lm9HPmno5aSJzRLq7hYYSEZBqLyj0Hyf9p9ec/cQN/gyu2OXto2+Ty8gm64/CoH1Cmig
         aBZA==
X-Gm-Message-State: AKwxytefcSz1L4yyM9/ZDup4zNMCL2cLoZSYGD2ZDZpNlKV2ys5NbdFI
        1Ane8OGy3KI6b42AKXwfD09hSw==
X-Google-Smtp-Source: ACJfBovrt/pLyINkW9hIau+CslyiuqwIJJLqwfWaIEFuhT/HBDqxmlaDol1j6qbtpY/rm/VmmQQXPQ==
X-Received: by 10.84.218.69 with SMTP id f5mr13223385plm.431.1515751035883;
        Fri, 12 Jan 2018 01:57:15 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id d186sm29568144pfa.0.2018.01.12.01.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 01:57:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Jan 2018 16:57:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 4/4] trace.c: be smart about what env to print in trace_run_command()
Date:   Fri, 12 Jan 2018 16:56:07 +0700
Message-Id: <20180112095607.18293-5-pclouds@gmail.com>
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

The previous concatenate_env() is kinda dumb. It receives a env delta
in child_process and blindly follows it. If the run_command() user
"adds" more vars of the same value, or deletes vars that do not exist
in parent env in the first place (*), then why bother to print them?

This patch checks child_process.env against parent environment and
only print the actual differences. The unset syntax (and later on cwd)
follows closely shell syntax for easy reading/guessing and copy/paste.

There is an interesting thing with this change. In the previous patch,
we unconditionally print new vars. With submodule code we may have
something like this

    trace: ... GIT_DIR='.git' git 'status' '--porcelain=2'

but since parent's GIT_DIR usually has the same value '.git' too, this
change suppress that, now we can't see that the above command runs in
a separate repo. This is the run for printing cwd. Now we have

    trace: ... cd foo; git 'status' '--porcelain=2'

Another equally interesting thing is, some caller can do "unset GIT_DIR;
set GIT_DIR=.git". Since parent env can have the same value '.git', we
don't re-print GIT_DIR=.git. In that case must NOT print "unset GIT_DIR"
or the user will be misled to think the new command has no GIT_DIR.

A note about performance. Yes we're burning a lot more cycles for
displaying something this nice. But because it's protected by
$GIT_TRACE, and run_command() should not happen often anyway, it should
not feel any slower than before.

(*) this is the case with submodule code where all local_repo_env[]
vars are to be deleted even though many of them do not exist in the
first place. Printing all these is too noisy and that leads to
ignoring variable deletion in the previous patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/trace.c b/trace.c
index e499074d39..a1f871e720 100644
--- a/trace.c
+++ b/trace.c
@@ -272,23 +272,78 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 #endif /* HAVE_VARIADIC_MACROS */
 
+static void sort_deltaenv(struct string_list *envs,
+			  const char *const *deltaenv)
+{
+	struct strbuf key = STRBUF_INIT;
+	const char *const *e;
+
+	for (e = deltaenv; e && *e; e++) {
+		char *equals = strchr(*e, '=');
+
+		if (equals) {
+			strbuf_reset(&key);
+			strbuf_add(&key, *e, equals - *e);
+			string_list_append(envs, key.buf)->util = equals + 1;
+		} else {
+			string_list_append(envs, *e)->util = NULL;
+		}
+	}
+	string_list_sort(envs);
+	strbuf_release(&key);
+}
 
-static void concatenate_env(struct strbuf *dst, const char *const *envs)
+
+static void concatenate_env(struct strbuf *dst, const char *const *deltaenv)
 {
+	struct string_list envs = STRING_LIST_INIT_DUP;
 	int i;
 
-	for (i = 0; envs[i]; i++) {
-		const char *env = envs[i];
-		const char *p = strchr(env, '=');
+	/*
+	 * Construct a sorted string list consisting of the delta
+	 * env. We need this to detect the case when the same var is
+	 * deleted first, then added again.
+	 */
+	sort_deltaenv(&envs, deltaenv);
+
+	/*
+	 * variable deletion first because it's printed like separate
+	 * shell commands
+	 */
+	for (i = 0; i < envs.nr; i++) {
+		const char *env = envs.items[i].string;
+		const char *p = envs.items[i].util;
+
+		if (p || !getenv(env))
+			continue;
 
-		if (!p) /* ignore var deletion for now */
+		/*
+		 * Do we have a sequence of "unset GIT_DIR; GIT_DIR=foo"?
+		 * Then don't bother with the unset thing.
+		 */
+		if (i + 1 < envs.nr &&
+		    !strcmp(env, envs.items[i + 1].string))
 			continue;
-		p++;
 
-		strbuf_addch(dst, ' ');
-		strbuf_add(dst, env, p - env);
+		strbuf_addf(dst, " unset %s;", env);
+	}
+
+	for (i = 0; i < envs.nr; i++) {
+		const char *env = envs.items[i].string;
+		const char *p = envs.items[i].util;
+		const char *old_value;
+
+		if (!p)
+			continue;
+
+		old_value = getenv(env);
+		if (old_value && !strcmp(old_value, p))
+			continue;
+
+		strbuf_addf(dst, " %s=", env);
 		sq_quote_buf(dst, p);
 	}
+	string_list_clear(&envs, 0);
 }
 
 void trace_run_command(const struct child_process *cp)
@@ -303,6 +358,12 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	if (cp->dir) {
+		strbuf_addstr(&buf, " cd ");
+		sq_quote_buf(&buf, cp->dir);
+		strbuf_addch(&buf, ';');
+	}
+
 	/*
 	 * The caller is responsible for initializing cp->env from
 	 * cp->env_array if needed. We only check one place.
-- 
2.15.1.600.g899a5f85c6

