Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C061F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeARJqD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:46:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38959 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeARJqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:46:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id e11so14023944pff.6
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ic7BoxPOHtQSvIhIYTZOS83TGp3X5VRphyZmzkOKs+E=;
        b=O6pgiX71Padv28zMfYle1VfGkU09fmGwsdf78UVIYAh2mxJbgmQ40hbGaxt8OVFqOD
         TzV2dQ1IuPlNILXr32I2li31TZp/bVskUTr2rByfY9/L0k0SzieZgu3FJXUBFwM90Aw3
         HOuK9fCXvD0kWs/Mv3lhZBFRTYwB3mAXvoWZUEQ0J7NGIdF0AnY2O1G2JfmAvvix/JfT
         c2Qih/998YD7gF5+K4+vSIOfOgroqMuLiEUyjw6HElwtgM5iAMyt8QlpqwojjbgZx8NG
         n4gsOdHlYYi/eieqZT16sTwppTSSSz73WOyWlRpDIHWxzvGV+z12eZVnfDlHquslbG6H
         qLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ic7BoxPOHtQSvIhIYTZOS83TGp3X5VRphyZmzkOKs+E=;
        b=trBn9GkQq5Dnwi4Spt/Ht14HQv2u8BeY756s1nZX18RuMoLAQcPaVJ8M+d85f77L59
         u59oPiTmujqDkfmfDYFlA7U6ml/UAHY5e3olaWKNMHoV6fwXo7ZsNWUa8zMVh3rG5zUm
         juI/3AUOTGcD0H/mPNWhV2SJVTU+q+S/tKcmIiHQXJRJLi+v5fs1hTptYLVFRemeyIe1
         OfWNGCG+BzSchtHgDlI+pNpHq5Jte+5ONVj2BOYIvQOC3IuMcyMfRsHxEZKyjGwxo88+
         Cu9uxgvM50cjwndiXC538Z4o7vqFtViQ/z1JzPhGoqz11T6Rr65WpRwtehxcTB/N//rW
         ZPCA==
X-Gm-Message-State: AKGB3mJzCMVdKShwa3K0K3tDKO/Te88JCM16ZGmMxeobroa+QEoRBUrl
        rtOBdqPSEx2CDwEctI7artJ3gA==
X-Google-Smtp-Source: ACJfBoupLciYXDeudM+9R0hV6NQy0SxvrzATB7PPRxgkMZdvdSIcXs1G7hh9PsjZCxQ3rw0hhYnuQA==
X-Received: by 10.99.97.137 with SMTP id v131mr31576359pgb.243.1516268759791;
        Thu, 18 Jan 2018 01:45:59 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id 137sm4850351pge.74.2018.01.18.01.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 6/7] run-command.c: print env vars in trace_run_command()
Date:   Thu, 18 Jan 2018 16:45:11 +0700
Message-Id: <20180118094512.27849-7-pclouds@gmail.com>
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

Occasionally submodule code could execute new commands with GIT_DIR set
to some submodule. GIT_TRACE prints just the command line which makes it
hard to tell that it's not really executed on this repository.

Print the env delta (compared to parent environment) in this case.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.c               | 63 +++++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-run-command.c |  9 +++++++
 t/t0061-run-command.sh      | 37 ++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/run-command.c b/run-command.c
index 326c33e3cd..1301b878c7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -557,6 +557,63 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	return code;
 }
 
+static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
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
+
 static void trace_run_command(const struct child_process *cp)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -565,6 +622,12 @@ static void trace_run_command(const struct child_process *cp)
 		return;
 
 	strbuf_addf(&buf, "trace: run_command:");
+	/*
+	 * The caller is responsible for initializing cp->env from
+	 * cp->env_array if needed. We only check one place.
+	 */
+	if (cp->env)
+		trace_add_env(&buf, cp->env);
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 	sq_quote_argv_pretty(&buf, cp->argv);
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
index e4739170aa..24c92b6cd7 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -141,4 +141,41 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
 
+test_trace () {
+	expect="$1"
+	shift
+	GIT_TRACE=1 test-run-command "$@" run-command true 2>&1 >/dev/null | \
+		sed 's/.* run_command: //' >actual &&
+	echo "$expect true" >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'GIT_TRACE with environment variables' '
+	test_trace "abc=1 def=2" env abc=1 env def=2 &&
+	test_trace "abc=2" env abc env abc=1 env abc=2 &&
+	test_trace "abc=2" env abc env abc=2 &&
+	(
+		abc=1 && export abc &&
+		test_trace "def=1" env abc=1 env def=1
+	) &&
+	(
+		abc=1 && export abc &&
+		test_trace "def=1" env abc env abc=1 env def=1
+	) &&
+	test_trace "def=1" env non-exist env def=1 &&
+	test_trace "abc=2" env abc=1 env abc env abc=2 &&
+	(
+		abc=1 def=2 && export abc def &&
+		test_trace "unset abc def;" env abc env def
+	) &&
+	(
+		abc=1 def=2 && export abc def &&
+		test_trace "unset def; abc=3" env abc env def env abc=3
+	) &&
+	(
+		abc=1 && export abc &&
+		test_trace "unset abc;" env abc=2 env abc
+	)
+'
+
 test_done
-- 
2.15.1.600.g899a5f85c6

