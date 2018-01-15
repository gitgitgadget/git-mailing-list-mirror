Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6061F404
	for <e@80x24.org>; Mon, 15 Jan 2018 11:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeAOLAh (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 06:00:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33704 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbeAOLAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 06:00:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id i196so7831466pgd.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhfUthBodWVHwSwHTFeOxgLmiDTVB8ir0sEWmrMsqqg=;
        b=uzegyldfGwf+uVY9K0hMRuyrdRkW2AuhHUKFUcqRHkR+6HNC043KTrYdSHZ4QxsyuJ
         LbzlbVVXTNtzIyNKp6j28moaLjYYtDlG44l3PnoidVFz/ZbsFtZWfDiprRQTemqgiWXW
         onceQ8WyaOCDRsy6++WlK+SNM/k56MKJrepLp3zAQYm3DQQ+0+pUTQW8Qg+rf990044Q
         izkJ2/fxTGc0z6EzID5jMQseEfugJHFBxWRY9mSQg7lL0niBtqr/xCqINYSezyWeHxPv
         5Aef1dWCqw6DCMSPDRfBkyk/hVr6CmmdimM5QIFMe08hskxkvfbIjZzgwJTQp+pcKSnP
         sD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhfUthBodWVHwSwHTFeOxgLmiDTVB8ir0sEWmrMsqqg=;
        b=OtDmoHDdd9yQKuEcfBV84PP3UKQhg2451e30a5dhTMDCiOT+oddqa5wsnRXqweXaRp
         gmc7SnnLZVXyDpj6K3XlAE2cCn8wXPydsD8ycKFjsZSqepZdwIwIz2J/HYfhTykfS0gR
         anwSR1Rd/ikcFaHGzZ/6eZsPdPXcrVCqe8BdPC58903FnFpHy/krRDC33ZOI7tkLLRwH
         v3YKZqXuF/2O24xIcnxFdhEZpWFifgpPX6CSxdGQ0HFxWfUIP7dd6lbGiIVtQLOnXmr3
         KeOcPdp9FEsw9lp3A2Kl7wD54p6VMQWK/PBiOjNp49U7Fy1ia6Hh82bhFEvEIiqrZTrL
         dXRA==
X-Gm-Message-State: AKwxytfKdCC/v8Ww8pWG6QIqtLeFR1QxmmNxTIj2L944PRxGQgViASYU
        b9DFkVjjiuwoAnszap5XxAq7lA==
X-Google-Smtp-Source: ACJfBouN1ZVnMoRzn6NIFG4i0jc/q26HbZcfp0iH1hdDIAjFIBrhng76M2Uc4mJm42tPyq1PLTWRHA==
X-Received: by 10.99.189.17 with SMTP id a17mr12565606pgf.434.1516014035646;
        Mon, 15 Jan 2018 03:00:35 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id x15sm52026805pfh.27.2018.01.15.03.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 03:00:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 15 Jan 2018 18:00:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 6/7] trace.c: print env vars in trace_run_command()
Date:   Mon, 15 Jan 2018 17:59:48 +0700
Message-Id: <20180115105949.18328-7-pclouds@gmail.com>
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

Occasionally submodule code could execute new commands with GIT_DIR set
to some submodule. GIT_TRACE prints just the command line which makes it
hard to tell that it's not really executed on this repository.

Print the env delta (compared to parent environment) in this case.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/helper/test-run-command.c |  9 +++++++
 t/t0061-run-command.sh      | 22 ++++++++++++++++
 trace.c                     | 63 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index d24d157379..153342e44d 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -54,6 +54,15 @@ int cmd_main(int argc, const char **argv)
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
 
+	if (argc < 3)
+		return 1;
+	while (!strcmp(argv[1], "env")) {
+		if (!argv[2])
+			die("env specifier without a value");
+		argv_array_push(&proc.env_array, argv[2]);
+		argv += 2;
+		argc -= 2;
+	}
 	if (argc < 3)
 		return 1;
 	proc.argv = (const char **)argv + 2;
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
index 98bee2c259..8db5bbf3c9 100644
--- a/trace.c
+++ b/trace.c
@@ -275,6 +275,62 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 #endif /* HAVE_VARIADIC_MACROS */
 
+static void add_env(struct strbuf *dst, const char *const *deltaenv)
+{
+	struct string_list envs = STRING_LIST_INIT_DUP;
+	const char *const *e;
+	int i;
+	int printed_unset = 0;
+
+	/* Last one wins, see run-command.c:prep_childenv() for context */
+	for (e = deltaenv; e && *e; e++) {
+		struct strbuf key = STRBUF_INIT;
+		char *equals = strchr(*e, '=');
+
+		if (equals) {
+			strbuf_add(&key, *e, equals - *e);
+			string_list_insert(&envs, key.buf)->util = equals + 1;
+		} else {
+			string_list_insert(&envs, *e)->util = NULL;
+		}
+		strbuf_release(&key);
+	}
+
+	/* "unset X Y...;" */
+	for (i = 0; i < envs.nr; i++) {
+		const char *var = envs.items[i].string;
+		const char *val = envs.items[i].util;
+
+		if (val || !getenv(var))
+			continue;
+
+		if (!printed_unset) {
+			strbuf_addstr(dst, " unset");
+			printed_unset = 1;
+		}
+		strbuf_addf(dst, " %s", var);
+	}
+	if (printed_unset)
+		strbuf_addch(dst, ';');
+
+	/* ... followed by "A=B C=D ..." */
+	for (i = 0; i < envs.nr; i++) {
+		const char *var = envs.items[i].string;
+		const char *val = envs.items[i].util;
+		const char *oldval;
+
+		if (!val)
+			continue;
+
+		oldval = getenv(var);
+		if (oldval && !strcmp(val, oldval))
+			continue;
+
+		strbuf_addf(dst, " %s=", var);
+		sq_quote_buf_pretty(dst, val);
+	}
+	string_list_clear(&envs, 0);
+}
 
 void trace_run_command(const struct child_process *cp)
 {
@@ -286,6 +342,13 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	/*
+	 * The caller is responsible for initializing cp->env from
+	 * cp->env_array if needed. We only check one place.
+	 */
+	if (cp->env)
+		add_env(&buf, cp->env);
+
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 
-- 
2.15.1.600.g899a5f85c6

