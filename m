Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1F3B636A
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684197; cv=none; b=JDzcCgnNK+bkYqlvU1C2pW73XVc4OkuM12t1UQXrSjrRfDoew9pd2IbxTa3bH79l5+/DaDPcXgEqrv5ANMCQQh2zYJ3jpR6QuH1JQ2u6ZJjfK+8zduVvnP0S8m4hdBY+Zf6ng3C3GKCR2lJyjScAbQfSm6zKz7uwJ/5nddmc84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684197; c=relaxed/simple;
	bh=TxohoPRazEHjQ35DXH1GbSbgmYLZf7cWMzbEkMWPy2A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ArlMIHSIke8x8c5tA/E0BZM79gcrx/Psc+QpTiudnNAHHEY+rvQGJ87kw7z4sb6hFiISaeFy4hv3SK2wXxzOTqsO3TFQ3Er6QrQrXEsh4jLschVhImGsXuZNDtGib26my2tbddY+b3AT0IBoZyw+69MGtV7pmpG349r2Ogp2jVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSQchPW3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSQchPW3"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so266099a91.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684190; x=1788288990; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=metu9WbUQqerOjlJF/andVTWxEoUgcDq4lweRFlh2mw=;
        b=VSQchPW3g7F5Y3VFruURI1YAINkfuo5Gdb2zjMUldlNvQKPvLcgik5jK1QjWEElpja
         ObfKAtfVTEAQh14KFhL9mtVK0RCfFTW+HtF7OgrnXwaHUlTWzJ/50yDgjxxHoc4a3YQh
         kbdG2HZPwcFFnu7tHLCJ3kWT6m3IBHp5HSLkrBMD+khyOR1k9obN4+1RvQIWeLEjfCUx
         N8k86OyPP/Gdb7PeVPpWlw6mh77ZIISMu8GOXjXqK/wH/oo95qadM8gRsoHTKmXRdVk6
         3XH8UQl6sJ5S2uX23arpzHVu8Efc1mPKEQWDPRvUu9YcLOnU0kye3IL4Ri77jRRGYCm8
         KbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684190; x=1788288990;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=metu9WbUQqerOjlJF/andVTWxEoUgcDq4lweRFlh2mw=;
        b=S5z/MMrsSdQGmBPkPczYHnTfMtyGI3V8CFeEoPLLOn/10K/XpUP6dteSYy9hdstyUM
         +FtwBSQV6f0GGOrLKD6Qv7VQrs/4mBxeQ+DXhDZ2fmaygF/RmdwpDSWs4lp9knCtMGY6
         KEvTsoFgEZQVtlKdFDnAtB/6c2bPCqDzaUu2Q4vh02DRSisn7ZcSnZVfd2PPfFnCHtMo
         NF29QGVIbSP6y1qnWITRx2uEClvpeCL5Bd3+8P3seMmhAye2Qg+ypnaDQPokE/OTPiKI
         EakkxQs4v8jswqTU9jdaMYtKfLVXyGdGn/P/0Rg/hkSZz0SPT2PPJuSia5Hr06ON6mtr
         Itnw==
X-Gm-Message-State: AFuF++nxx8lNHc9NjL97xNmH31sL9sI/ELrx2nbVHcJ2uUKXbgWhKA1R
	SEfhvNLwtlUk+pH/kvuB5o0npfyzZF+O3PLrPuNdsy7yL3PDierJ8arvkRUZoO+N
X-Gm-Gg: AR+sD11A6ec+v9BEdrXN0YuHYvePKZUpGGjYgEKYZVZFRBOibwJGX68QIE/bVIzeZLN
	jt5pfTPwKZKUG7NkCwa6OWdz9O1F9AJGlnq9sYohdv9j+DtGAIfAUrgsQeTHqe16+gbjtBEq0B5
	ugw4Pj5tk9/uxOJ7tktenHwF8kKL4JTUEseLVuqU2rG4Bj5DvWJgZLTP4VA9e1XYPJZ0kHwAynl
	TXDNfxr75X9PTxRh283btU9b8qMyfJO4zZ+bmlxMFQaqgFgWwlo4eGfRQXffd+/U0MxK1NFpkEG
	CSNAbSwltjGsmL9kFGNs85grp7G7wUGnAzsJmjnKdXUpNOgqSlcmyzM0UuRiNwphJpbhH1xo3Oo
	3LV0NdRC6rddTYsYsfXD2a1yXD0oN9jqehe7afn/eY1Clq6taj29LOGs+gszG7Q/rYTSz+nmhX8
	NBhoMvvVi1Wu1vJ/5gktsE8rdOaNMU54d7rtV6xvIbVuLfcr709VgwbYrcIiKJRr61QQK0vh/PQ
	A==
X-Received: by 2002:a17:90a:dfd0:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-3966d144247mr2682618a91.1.1787684189486;
        Tue, 25 Aug 2026 11:56:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm1086842c88.10.2026.08.25.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:28 -0700 (PDT)
Message-Id: <db6858d3811c8cfdd136a0069f0ace33b95888ae.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:18 +0000
Subject: [PATCH v2 4/7] trace2: remove use of ALLOC_ARRAY()
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
index 2e16c4899c..cb2eed75cd 100644
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
index 1d0ed2db2b..7044276435 100644
--- a/trace2.c
+++ b/trace2.c
@@ -304,7 +304,11 @@ static const char **redact_argv(const char **argv)
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
@@ -345,6 +349,8 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv)
 	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
 
 	redacted = redact_argv(argv);
+	if (!redacted)
+		return;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_start_fl)
@@ -513,6 +519,7 @@ void trace2_child_start_fl(const char *file, int line,
 	uint64_t us_now;
 	uint64_t us_elapsed_absolute;
 	const char **orig_argv = cmd->args.v;
+	const char **redacted;
 
 	if (!trace2_enabled)
 		return;
@@ -530,7 +537,10 @@ void trace2_child_start_fl(const char *file, int line,
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
@@ -622,6 +632,8 @@ int trace2_exec_fl(const char *file, int line, const char *exe,
 	exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
 
 	redacted = redact_argv(argv);
+	if (!redacted)
+		return exec_id;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_exec_fl)
-- 
gitgitgadget

