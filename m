Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3B4AE13E
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197152; cv=none; b=F8roWiATJvP03vp+5U5mexLiQVILqMHYBT4q8If6JxMKAwYl7GK2XQdXzspjnAD4csByZGGwrRqjuVlJzJ2aSntffxA24/3ejkxvNzL3/yjg17B9YSUMH/QPewLvFXL/mcjmCqUdTaWEQbBRQLuCHT373kCUIWBGQX63kxW/3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197152; c=relaxed/simple;
	bh=p0h0N15DRfWKoSxZkZT6IQ5lzlzfXUTxr9mdpbwo+W8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XT0nD9tXdAehz6LW7CNYB8E9lQ+0fbiDsRZcs2p+pM5WdtyCwReXV1iUh45orkXPpb3nZ5obOXFRCZlBh/2zlUANxcBt3w1aHQCw4DfTB+B7LTUgGJN0RGHrteQ0eSmQ767PXrWH0MB66qgGYjKLVV6SeyZZVNWqEB6HC1V3SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DppaMOvj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DppaMOvj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5301db51586so7795081cf.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197150; x=1788801950; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N7ttduS0IQBPNsTpzGug6jzjS/N1/OJOy11S6MIdfu4=;
        b=DppaMOvjZ72eYj1SaaZV5+J7XuQAGoO6o/a3vkYDlnpv6WvkfwzghvOL11xZ9uPwW7
         v4Y3YbggtFgek2tOVKwBpqtNX1l+oMfy+O9wUwiNM8cWChMDjPfSD74TAqWxM/SyrZ4b
         Z/W7Z+79FJMi4Rk3dHGwWrNmdv+9928djoW43bcAahMF9O9kIGUKmAzBn2mQ+9SSKp5T
         cJvqM5yppBddln16XVjKCEdEDflls0CuNgMSgOM/uInihZyy7NNdJqczc2NpQ/WRe5GQ
         yEUGzFqabHM+ZYpWco21SyqffiGWX+4aEyVxv+XIdvGGSWQ3W+3DtxBmHtUwVgnpJ2Be
         XwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197150; x=1788801950;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7ttduS0IQBPNsTpzGug6jzjS/N1/OJOy11S6MIdfu4=;
        b=CsNb0G2WGrYsCW7X8+5eIVtf5fT4XSQradK2U8l6STgWi53XwqB7gdgjjL1q1FL5mq
         kgLY3SzPelSjt73c9h2a1NOxKhm9C1I/CBhfu8NVmP+tbSrNA23UXeaUb+pFif//KcNc
         gOth1+HHXMEIZkDJl4p+xjB4kde2TBXvW10W59pB5QVfPuIaepdfugwslmTvQZd8v8Jg
         PajPyjHLA7nvYT2wXJavB/Y4UvelKzB7Gii33nLoOKEEQy3e/IiEPb0zKpx0nowzjuJK
         n3ifNrubMDjIaPj8fEbFT5cC3MXuSpx6QREUDhQLDD0P4O9w2xYVGkdWIGYI40rrYsxR
         hLpg==
X-Gm-Message-State: AFuF++n6JLPuhaijd+/+GNXKqVNasL/VN0O66s4bqaCdkd55m+8Vad0b
	alJqyr7OkcePMDXV9E2TU1kDQsaG3n6WSuyoQmJUmH8JE3yPSXSL62wtWN6ECyjR
X-Gm-Gg: AR+sD10UrigoCI//J4PzR0EUyjjW13kb1IShX9WUgcdQdSlHnJeEqsjogTWh/YMa+8p
	31U55T5zebZLglECYZxK/f87bRL2fJQIqkOwL0gPHCPtZuvteLu3hFjeTCbdjYwXhHPHqP9ZAxX
	+o1ez+eMPlWlT9yvu95DRjaQFtV+XwNKaigmBgawkAo2Qtcs88o2FZE2BWbgSxsKSMpfA88uHb6
	BGMFwVZdcovvVs/Gzf2keBYTktdF6AT2QBsMp43qgHWtneWy+EViNNJ6FSNxYoS6Ob4kmrseWfY
	hygnyBaOfh0iEKiDBJLrib4U4hYqta1JUK3lVCynpJggCClMhZg/9og1bOBALzuy6Zo+sPGLGKb
	M790ItofhApz++0fubdG6Z+Qv1+/Pu5OjcBQRWiaMQV9knH5nRVmAZMDsQOGR+RY2oofoducopj
	dFw8bAd0SZPNBRSeUjMGR7kza87r0V5yeMXCZ8Nxyaplsqi2yUnLHVjzmMLS2Av5cG
X-Received: by 2002:a05:622a:4d93:b0:51b:fe3c:6c1 with SMTP id d75a77b69052e-52fb95f114dmr368471181cf.27.1788197150111;
        Mon, 31 Aug 2026 10:25:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe582b98sm76868701cf.8.2026.08.31.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:49 -0700 (PDT)
Message-Id: <5bf6ab91f37cd80dba5e50eee85f9f3258f34be3.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:40 +0000
Subject: [PATCH v3 4/7] trace2: remove use of ALLOC_ARRAY()
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
    Taylor Blau <ttaylorr@openai.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The banned-die.h header is used to prevent use of helper methods that
call die(). Remove use of the ALLOC_ARRAY() helper, which calls die() on
allocation failures. Replace the use in trace2.c with a more direct
allocation and soft failure when allocation fails. This prevents die()
recursion loops when memory allocation fails and trace2 logs are
enabled.

The tricky part about this change is how to handle the results from
redact_arg(), which is a 'const char *' result because it might be a
pointer directly to the externally-controlled argument. When it is
different from the argument, then it is indeed a newly-allocated string
that we need to free before returning. This requires using a (char *)
cast to allow a change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h |  3 +++
 trace2.c     | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index bf16ec5ba9..0ad9a6c492 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -17,4 +17,7 @@
 #undef xstrdup
 #define xstrdup(str) BANNED(xstrdup)
 
+#undef ALLOC_ARRAY
+#define ALLOC_ARRAY(x, alloc) BANNED(ALLOC_ARRAY)
+
 #endif /* BANNED_DIE_H */
diff --git a/trace2.c b/trace2.c
index 8c974dee87..ea021c602e 100644
--- a/trace2.c
+++ b/trace2.c
@@ -305,7 +305,11 @@ static const char **redact_argv(const char **argv)
 	for (j = 0; argv[j]; j++)
 		; /* keep counting */
 
-	ALLOC_ARRAY(ret, j + 1);
+	ret = calloc(j + 1, sizeof(*ret));
+	if (!ret) {
+		free((char *)redacted);
+		return NULL;
+	}
 	ret[j] = NULL;
 
 	for (j = 0; j < i; j++)
@@ -346,6 +350,8 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv)
 	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
 
 	redacted = redact_argv(argv);
+	if (!redacted)
+		return;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_start_fl)
@@ -514,6 +520,7 @@ void trace2_child_start_fl(const char *file, int line,
 	uint64_t us_now;
 	uint64_t us_elapsed_absolute;
 	const char **orig_argv = cmd->args.v;
+	const char **redacted;
 
 	if (!trace2_enabled)
 		return;
@@ -531,7 +538,10 @@ void trace2_child_start_fl(const char *file, int line,
 	 * temporarily replace the original argv (inside the `strvec`)
 	 * with a possibly redacted version.
 	 */
-	cmd->args.v = redact_argv(orig_argv);
+	redacted = redact_argv(orig_argv);
+	if (!redacted)
+		return;
+	cmd->args.v = redacted;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_child_start_fl)
@@ -623,6 +633,8 @@ int trace2_exec_fl(const char *file, int line, const char *exe,
 	exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
 
 	redacted = redact_argv(argv);
+	if (!redacted)
+		return exec_id;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_exec_fl)
-- 
gitgitgadget

