Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154A81FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeAMGt7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:49:59 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:42897 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeAMGt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:49:59 -0500
Received: by mail-pl0-f53.google.com with SMTP id bd8so321381plb.9
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzuT0qihJDV3/LlbNjRlfDpVKBddyJ2JylupahNDHvc=;
        b=bluiW6HdCNaLyDtrNevjSyV8AVKEZyLnbh7/1GQHq6K107mEcSnALk8gdzZatirn3u
         00lOASzAeTRhRJ5D75FAgirZ0l+jn7u46mI3OT+64K7iyJ0cTTkFlzReDgvh57h0Zrj8
         A7irXF4Lize5sf5lp+/OpK8sFuJAJjig8UFF/h0MmTZFnSkhSBr/0Gfnd/mD6pOxPlZ+
         GtxrEcO6G44Wecv5CgO+rlwcYllmzaKVl0m3nIDtar9XVE+iCQuybMxJ5/oCDnCvnOKW
         5whmNZWEYP+GJjuzuxjoF7qI0inbuss6cDs7qHN3Q7FiQPb+ARrY3i/qeKDccnB93mv9
         sxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzuT0qihJDV3/LlbNjRlfDpVKBddyJ2JylupahNDHvc=;
        b=p6J5+rFUDVZPYkv/Nf66udZ6+FjZI64vp9TZsDuL3J0af8pXBI52LYbvVCHYXHj6ZJ
         zBslezgpu3uwy8s158H6JDJbxMJU0KXIMvQhGBH1fMBcsoPztot2kjfvtLo8xKGRNSKd
         OniIEDFWSlHXLyXg17xQHKIq3ydjSVtw4aBZ0dOTEWh1qGwxG/Yxo+cV1aWMNB4JTOIw
         CxEC2BSqwUvFInC+h1jhexgR9rIkFVEQUbWygBKvezmQJQAoqbWopjOTNAKRrDWR7UBU
         EtDHpTsTyNKx+z1qp0AwZ1ai4qUKSX5cE9y+YeJywIxNMniCqe95vh/sams9fwqNORSg
         Jt+w==
X-Gm-Message-State: AKGB3mLiQta2x95FhBNeoXOnxmR5wbWnhOdSlTxrymZeDejdlK5csVrZ
        llxjZwXCoiAn4lRsy/PRaS1nZQ==
X-Google-Smtp-Source: ACJfBots3HMfGjwP0fLGPp3QnAnhNg+5v/2mQMyeXfQSLmuY2fg+siGJnm+6N68cpbw50M7DiuxfQQ==
X-Received: by 10.84.240.71 with SMTP id h7mr28408592plt.418.1515826198144;
        Fri, 12 Jan 2018 22:49:58 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id l64sm25511055pfi.46.2018.01.12.22.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:49:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:49:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 0/7] Trace env variables in run_command()
Date:   Sat, 13 Jan 2018 13:49:42 +0700
Message-Id: <20180113064949.6043-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180112095607.18293-1-pclouds@gmail.com>
References: <20180112095607.18293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:

- incorporates Jeff patches and moves them on top
- removes strbuf release from print_trace_line
- prints 'unset a b c' instead of 'unset a; unset b; unset c'
- squashes v3 3/4 and 4/4 and Junio's patch into 6/7
- adds tests
- cwd is separated in 7/7

interdiff with what's on 'pu':

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index d24d157379..0ab71f14fb 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -56,6 +56,10 @@ int cmd_main(int argc, const char **argv)
 
 	if (argc < 3)
 		return 1;
+	while (!strcmp(argv[1], "env")) {
+		argv_array_push(&proc.env_array, argv[2]);
+		argv += 2;
+	}
 	proc.argv = (const char **)argv + 2;
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e4739170aa..e6208316c3 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -141,4 +141,26 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
 
+test_trace() {
+	local expected="$1"
+	shift
+	GIT_TRACE=1 test-run-command "$@" run-command true 2>&1 >/dev/null | \
+		sed 's/.* run_command: //' >actual &&
+	echo "$expected true" >expected &&
+	test_cmp expected actual
+}
+
+test_expect_success 'GIT_TRACE with environment variables' '
+	test_trace "abc=1 def=2" env abc=1 env def=2 &&
+	test_trace "abc=2" env abc env abc=1 env abc=2 &&
+	test_trace "abc=2" env abc env abc=2 &&
+	abc=1 test_trace "def=1" env abc=1 env def=1 &&
+	abc=1 test_trace "def=1" env abc env abc=1 env def=1 &&
+	test_trace "def=1" env non-exist env def=1 &&
+	test_trace "abc=2" env abc=1 env abc env abc=2 &&
+	abc=1 def=2 test_trace "unset abc def;" env abc env def &&
+	abc=1 def=2 test_trace "unset def; abc=3" env abc env def env abc=3 &&
+	abc=1 test_trace "unset abc;" env abc=2 env abc
+'
+
 test_done
diff --git a/trace.c b/trace.c
index 9f49bcdd03..4bfd3fce10 100644
--- a/trace.c
+++ b/trace.c
@@ -132,7 +132,6 @@ static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 {
 	strbuf_complete_line(buf);
 	trace_write(key, buf->buf, buf->len);
-	strbuf_release(buf);
 }
 
 static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
@@ -145,6 +144,7 @@ static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
 
 	strbuf_vaddf(&buf, format, ap);
 	print_trace_line(key, &buf);
+	strbuf_release(&buf);
 }
 
 static void trace_argv_vprintf_fl(const char *file, int line,
@@ -160,6 +160,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	sq_quote_argv_pretty(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
+	strbuf_release(&buf);
 }
 
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
@@ -172,6 +173,7 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 
 	strbuf_addbuf(&buf, data);
 	print_trace_line(key, &buf);
+	strbuf_release(&buf);
 }
 
 static void trace_performance_vprintf_fl(const char *file, int line,
@@ -191,6 +193,7 @@ static void trace_performance_vprintf_fl(const char *file, int line,
 	}
 
 	print_trace_line(&trace_perf_key, &buf);
+	strbuf_release(&buf);
 }
 
 #ifndef HAVE_VARIADIC_MACROS
@@ -272,17 +275,17 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 #endif /* HAVE_VARIADIC_MACROS */
 
-static void concatenate_env(struct strbuf *dst, const char *const *deltaenv)
+static void add_env(struct strbuf *dst, const char *const *deltaenv)
 {
 	struct string_list envs = STRING_LIST_INIT_DUP;
 	const char *const *e;
 	int i;
+	int printed_unset = 0;
 
-	/* Last one wins... */
+	/* Last one wins, see run-command.c:prep_childenv() for context */
 	for (e = deltaenv; e && *e; e++) {
 		struct strbuf key = STRBUF_INIT;
 		char *equals = strchr(*e, '=');
-
 		if (equals) {
 			strbuf_reset(&key);
 			strbuf_add(&key, *e, equals - *e);
@@ -290,30 +293,39 @@ static void concatenate_env(struct strbuf *dst, const char *const *deltaenv)
 		} else {
 			string_list_insert(&envs, *e)->util = NULL;
 		}
+		strbuf_release(&key);
 	}
 
-	/* series of "unset X; unset Y;..." */
+	/* "unset X Y...;" */
 	for (i = 0; i < envs.nr; i++) {
 		const char *var = envs.items[i].string;
 		const char *val = envs.items[i].util;
 
-		if (val)
+		if (val || !getenv(var))
 			continue;
-		if (getenv(var))
-			strbuf_addf(dst, " unset %s;", var);
+
+		if (!printed_unset) {
+			strbuf_addstr(dst, " unset");
+			printed_unset = 1;
+		}
+		strbuf_addf(dst, " %s", var);
 	}
+	if (printed_unset)
+		strbuf_addch(dst, ';');
 
 	/* ... followed by "A=B C=D ..." */
 	for (i = 0; i < envs.nr; i++) {
 		const char *var = envs.items[i].string;
 		const char *val = envs.items[i].util;
-		const char *old_value;
+		const char *oldval;
 
 		if (!val)
 			continue;
-		old_value = getenv(var);
-		if (old_value && !strcmp(old_value, val))
+
+		oldval = getenv(var);
+		if (oldval && !strcmp(val, oldval))
 			continue;
+
 		strbuf_addf(dst, " %s=", var);
 		sq_quote_buf_pretty(dst, val);
 	}
@@ -328,8 +340,6 @@ void trace_run_command(const struct child_process *cp)
 				&trace_default_key, &buf))
 		return;
 
-	strbuf_grow(&buf, 255);
-
 	strbuf_addf(&buf, "trace: run_command:");
 
 	if (cp->dir) {
@@ -343,7 +353,7 @@ void trace_run_command(const struct child_process *cp)
 	 * cp->env_array if needed. We only check one place.
 	 */
 	if (cp->env)
-		concatenate_env(&buf, cp->env);
+		add_env(&buf, cp->env);
 
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
-- 
2.15.1.600.g899a5f85c6

