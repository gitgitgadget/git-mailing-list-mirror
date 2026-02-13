Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2660285CB9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012513; cv=none; b=GNDIeNc/4O1F2X4c0F/9zWCviCWu5uh27Hj3nbw/oVvFj/7J0xNYdxIwq5aXKSijKuYSJc+JtMMPslFX0mu+e2XByZm7umsnDBp3VXaQFghTrAF4BFS+ZlbaNXA30Clcq7zkJRbgjyLUbk/6ZueaKWnIJTSEZZ/lEJU5BBpPBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012513; c=relaxed/simple;
	bh=J2O0ShHuWYRr+6DVUCR03uhb4CbNzBMdnSsHr1aLVSo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cnWQ4ltRtfkWpqX6iGLHHbmsZ4gmCFrfJr5TvFg3gvU61OnAhXeWamrd+x58lYTk9bZXN6CpZULVhRUU416QLjb6oHiZ5TKTCI9WRdz+Ofnt3sdhRDsixRhlc5DUvx6f0K7Sg0jhscvTE7y2EraD1HCwJScV7YtpBEC1fGWdcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re0l0Cdz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re0l0Cdz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb40149037so127377585a.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012510; x=1771617310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTHzUiVDSSKpImL8t99Ru8wkMDp7JooUDs11kYxy5OY=;
        b=Re0l0CdzOG1L0u+hZ49awUFxxpkgcazw9qhFkPc/mtKsaWldvm32FYplCv6TfxwH5T
         IW8PJ2sRJyWtClW+Eezb088Teb3lzjESrTq158TuhtjCTwrypLReSk5quIb1V8TT2Ked
         JZJTmY48yXA2glFy9F6QRXNK9BfYm+/Yiwn2MhdYqim/mIWxydvQ5offfGPIEoSo8Fr8
         JwqgsaBUmdRZXfaryE1f+Shg6JzflBKYtv/eBOS4rrVBEmDyr+NMMzJpjEYT/ExlWs+s
         BIzzqiPtDlT6+M/TK0kksPZWoX4wrDXWAjwLLMCaZyNCeB0H5AXj/YTy7CIH+d3Vjai6
         8Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012510; x=1771617310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTHzUiVDSSKpImL8t99Ru8wkMDp7JooUDs11kYxy5OY=;
        b=DMDSLzoniWQOql+Vx7C9eo/uMltGJzJOReJCf70goEbVrWuBoFO9PF5TRjQFT5vwZs
         S0F+zb40T2fpscyOElK32X7pax9j/lNqSEK+z6ezb1tNs+r8s7b8s0dlY+ege/jUMH7z
         78rWTPsDgHT5XIqdwIRzylVNOT5SqDY9pbzUQEf3ic475RONweVMHYFUEAGMNcLeGPrM
         gm6fPnSztVCSAtn4kaWJqJgUWz5dTt70fcPGEQr4uDMvjJktG9ju5FKNQJG+f141k2M8
         UiomXou3HN8+jTcj2AAwoSe7kYGt23BD0O/rl0G1UfPr54OGuOkHs2XbnDCsUPeUyd4V
         Dd5g==
X-Gm-Message-State: AOJu0YxpZQw0rDtUNO1x8h5qOBHWyHorOr6zHQjNXtA/FmjlNsnTTPXk
	S8/FF+nDB40NPAnQBNohEV9E7Q5+1FlNINciow8RPPQ6Z1n6R5G0NczmCfqPRQ==
X-Gm-Gg: AZuq6aLrjXvGvT1z6PdqDCTm6Ad8wvl1ofvlEGElU2ydpVipO2qtXlMMmLbRwsjbJlK
	riPjiXCOSVTjr1QuD3Xj7YrMjAbGLFV8ARRlE9VnieijgZTl5JkVXOL7pJfi+84QyBlsD13gEt5
	ucBNgdRg1bOSJpIBTeUorBvLPPUEN2zgV04WKL5cVhQO9I69ZiYI0e0Uj9Lo4TknRlBCOrWIAus
	LSSanIKiJIdoqtvqElQP/xh8VdrFP0A+hrNS1mbleAvRZ1ZJRXuA91Mkws/DpKJxtJntB+94ADj
	ZcPjnPhfGKsgLDYj6yg9+1rss3OmH3ytewsbtzzro/K/thPlfl9WpbSKEHrkHb2sGEZLuWrLn9b
	5OLFxHmqi+tcpCPCVlxD4a8bqTvvrWdqCwTXUls8t29pCFV/sGWzekETsUgOi+myp7Dow4Duw9x
	xeoS8TsS0JEQE1rKE0wNuEBmmx9sI2vURsAjc=
X-Received: by 2002:a05:620a:319f:b0:8c2:faed:ded3 with SMTP id af79cd13be357-8cb424de722mr351114485a.89.1771012510350;
        Fri, 13 Feb 2026 11:55:10 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdb19b6sm77054246d6.40.2026.02.13.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:09 -0800 (PST)
Message-Id: <b9a94291a6238bfe8d4fd05d479b4d6d8ab6efc1.1771012500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:54:59 +0000
Subject: [PATCH v2 5/6] test-tool: extend trace2 helper with 400ancestry
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add a new test helper "400ancestry" to the trace2 test-tool that
spawns a child process with a controlled trace2 environment, capturing
only the child's trace2 output (including cmd_ancestry events) in
isolation.

The helper clears all inherited GIT_TRACE2* variables in the child
and enables only the requested target (normal, perf, or event),
directing output to a specified file. This gives the test suite a
reliable way to capture cmd_ancestry events: the child always sees
"test-tool" as its immediate parent in the process ancestry, providing
a predictable value to verify in tests.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-trace2.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 415df078c1..3b12f4173e 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -466,6 +466,63 @@ static int ut_303redact_def_param(int argc, const char **argv)
 	return 0;
 }
 
+/*
+ * Run a child process with specific trace2 environment settings so that
+ * we can capture its trace2 output (including cmd_ancestry) in isolation.
+ *
+ * test-tool trace2 400ancestry <target> <output_file> [<child_command_line>]
+ *
+ * <target> is one of: normal, perf, event
+ *
+ * For example:
+ *     test-tool trace2 400ancestry normal out.normal test-tool trace2 001return 0
+ *
+ * The child process inherits a controlled trace2 environment where only
+ * the specified target is directed to <output_file>. The parent's trace2
+ * environment variables are cleared in the child so that only the child's
+ * events are captured.
+ *
+ * This is used by t0213-trace2-ancestry.sh to test cmd_ancestry events.
+ * The child process will see "test-tool" as its immediate parent in the
+ * process ancestry, giving us a predictable value to verify.
+ */
+static int ut_400ancestry(int argc, const char **argv)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	const char *target;
+	const char *outfile;
+	int result;
+
+	if (argc < 3)
+		die("expect <target> <output_file> <child_command_line>");
+
+	target = argv[0];
+	outfile = argv[1];
+	argv += 2;
+	argc -= 2;
+
+	/* Clear all trace2 environment variables in the child. */
+	strvec_push(&cmd.env, "GIT_TRACE2=");
+	strvec_push(&cmd.env, "GIT_TRACE2_PERF=");
+	strvec_push(&cmd.env, "GIT_TRACE2_EVENT=");
+	strvec_push(&cmd.env, "GIT_TRACE2_BRIEF=1");
+
+	/* Set only the requested target. */
+	if (!strcmp(target, "normal"))
+		strvec_pushf(&cmd.env, "GIT_TRACE2=%s", outfile);
+	else if (!strcmp(target, "perf"))
+		strvec_pushf(&cmd.env, "GIT_TRACE2_PERF=%s", outfile);
+	else if (!strcmp(target, "event"))
+		strvec_pushf(&cmd.env, "GIT_TRACE2_EVENT=%s", outfile);
+	else
+		die("invalid target '%s', expected: normal, perf, event",
+		    target);
+
+	strvec_pushv(&cmd.args, argv);
+	result = run_command(&cmd);
+	exit(result);
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -497,6 +554,8 @@ static struct unit_test ut_table[] = {
 	{ ut_301redact_child_start, "301redact_child_start", "<argv...>" },
 	{ ut_302redact_exec,        "302redact_exec",        "<exe> <argv...>" },
 	{ ut_303redact_def_param,   "303redact_def_param",   "<key> <value>" },
+
+	{ ut_400ancestry,           "400ancestry",           "<target> <output_file> [<child_command_line>]" },
 };
 /* clang-format on */
 
-- 
gitgitgadget

