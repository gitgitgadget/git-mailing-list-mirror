Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E3F1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965460AbeAMGul (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:41 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44042 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965425AbeAMGuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:40 -0500
Received: by mail-pf0-f193.google.com with SMTP id m26so5887221pfj.11
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ije6Yir/0BtEpWEtvrl+JDE4cVoLkVIrNL7tZ26mkz4=;
        b=VLn/t/qD1/v4j+lHWgwPnSvSm3n4sldjALb2/ZK5Z5utU57Bfe4sx+co/r+QdnCebf
         m1EFb1qyHD9oHrfukKYn6m/Y8jx1txOgpW/jkG1iGaXDbzu9c1ep3gvbq4p7idPLk4te
         Jwl4BL2Zfze1k0PvvCrUPO0tN7FcVBACN8CuW7uY41JRtHGkLXNqRgXEXKHdlk/W0AQD
         ykKde1lZcpTUsSfm+m6bqSJ0lT5l/r4iojXAkSK5/6uB70SY4m6bNHyUCjs2LDoktgBM
         ZWZNFkxvLLi0ZLQh22LPAwD/C1wfxNW3YDL32BA4hnNvFQYt53XoAi0WyWCdCfA2LMPP
         BXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ije6Yir/0BtEpWEtvrl+JDE4cVoLkVIrNL7tZ26mkz4=;
        b=dKhR3+Li06iIAr2KyChHYod7eHL49TS9pLMsWgDuVaqKhpAzIbbpoojt3q0aSIYHYr
         vDOqTcCoNK8BisL/1AhZ6PGqlI5flUIq7MXdbDx1Lip9BUXe+SyGB4jStKEeW7NL8gTi
         blJaewuCgtYqRdVEXzPis0xy2vMAP86lRAlYrGmwECD4KOvAZB0A1r41PHHvZDft6BTd
         ajy70dwpHipPrcP9f0RYfjUiQe80C+SbVTKlAeia0kp8wW+23VEmTnSMrjzvH/n6g/gb
         X9fSXbzZEKAODhc9djbPVfCulqgEv4fnXLea9mFuV078Um6SvzPrdgcR1UaS7Tpmtf2m
         xVHw==
X-Gm-Message-State: AKwxytf9Puye2rw1MC5r2odYJYTSXqw2+Y73L/Jj4vBUpUYbDAhecUFc
        yBxYrxtRUR7kVMTD+3zFXji7ow==
X-Google-Smtp-Source: ACJfBosQo54diCBBRuoeD1V+NqjMcOKfyOzePv/3V6eNWwU9DQJCOEZiJar6jBAf1iInz41Fmgbrqg==
X-Received: by 10.98.150.20 with SMTP id c20mr2981932pfe.200.1515826240088;
        Fri, 12 Jan 2018 22:50:40 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id t71sm20007126pfg.115.2018.01.12.22.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:50:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 6/7] trace.c: print env vars in trace_run_command()
Date:   Sat, 13 Jan 2018 13:49:48 +0700
Message-Id: <20180113064949.6043-7-pclouds@gmail.com>
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

Occasionally submodule code could execute new commands with GIT_DIR set
to some submodule. GIT_TRACE prints just the command line which makes it
hard to tell that it's not really executed on this repository.

Print the env delta (compared to parent environment) in this case.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/helper/test-run-command.c |  4 +++
 t/t0061-run-command.sh      | 22 ++++++++++++++++
 trace.c                     | 63 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

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
index 7f43da211a..ffa1cf9b91 100644
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
+		if (equals) {
+			strbuf_reset(&key);
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

