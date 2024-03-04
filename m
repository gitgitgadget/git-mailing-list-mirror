Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0466535A5
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566817; cv=none; b=HgwzPdlPcLO3CTcmmXz7YcdS4njnu12FCKRDcJAJDGVkS2l4WGNLy0+Dw/6RTpH7e0BWKD1IbyKV/2ZJNySiOGUPJWW2wvTlrB73qjgQV/55QHUOTqOqmm9TuHk9FFm2HseNHgUCmXQZ3hw6m9W6hOWWCVnJG1EgarqoaVybUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566817; c=relaxed/simple;
	bh=/6XjPCQfCK88zqSmtHg4thraqzB32RUGnA5qkqUfD1k=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MPq2PJho1wcFbwboC03Hrw6Hwep5umQhAiG1nnCfQRl5aGl3FSOTRYiGpzMiVQETpBMuRBxXio65JiTCbkWPtBDQdQ1eKunWyVVsTYDLcs7luadvK1bKTLOeh/Cblh5DH2VRKpzQsxD1Yq1R6Z6HVITfOyosFzJzlklOcRCH10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqDUlFnG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqDUlFnG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2316550f8f.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566813; x=1710171613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUC3q276op1jsCHLT3RlYgbnu50CJW0BM6mhbg0YK4s=;
        b=fqDUlFnGcPDZR8qZUD+lOnXwP7CWledUYMbbGxx59e5BptaQ7dXEa/P20JWH4myaiB
         yjQ6PYxVMNA7om7x/Lq2vX0OMxdL6xytoggEBlL2kPkSwdSNJvc4Lut7xpxLZA1ea835
         Dk5f6aWrlTG1bmIyfkKvmBuNuskhhq1S847mwnCpgRKpUAOCDbkiXJ/m0r2YOzD1Lry0
         Re0MaowzPzHdT6U/IBlgUJA9qWucVJ/Cepe1JePhN9WlHn+8F6sYB0jDWS1cu4kn30EN
         TxbyAwq7JRnuWiH+8GWxj49AplGlkXbkWQqyh9Zq4IApXaekm0XyHsQ9WB3Zs7PdBlDJ
         ncnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566813; x=1710171613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUC3q276op1jsCHLT3RlYgbnu50CJW0BM6mhbg0YK4s=;
        b=ED8RDicXp/ncher712SN+63YCCiNqxcXgKSAou19xQeQKzZYmzshPbFiaAw2l0c/+b
         PMvvuSudn6cysA93OMaPEpVFLoiAunJLrrndo/r1D225O9CwpkUzdRTh4+jXBExN/Qbf
         ghXpTg0AqEai1phxY9cjLz55vPRK1qkut/UjZt3G39m3nU07dfHc/e8c1in7ydScrXV6
         mauxFNrBY0MaRh9R5kiyGPhrVvobKFFdVyZ9smcbUXoV/sb5tB900b7AB6kictbN5H/e
         sdX6DfMIKBLY6Y6e/wIxL2lixXoxpz+NMPH2L3GrarazHh8g+u9rmuU0FCjBjhchc9fd
         m5Bw==
X-Gm-Message-State: AOJu0YxPnjAUVPTVTVbkbhTznDTkiSQRFeDO7q3mlhOI90TW9DXb7ZBB
	f7Z5ARi0uMM7q1YThHL678ZRJJ6L1idlRDaGXDQXtSXc7jScu3nIaxG15egA
X-Google-Smtp-Source: AGHT+IFleJ2pwCZkJ47cznuOmkz/TMzgx1rgh0qFQ8SKTO2S6EspUbXInUhd8L3RKL29T/nOOU/PgA==
X-Received: by 2002:a5d:4b07:0:b0:33d:8ef8:c10c with SMTP id v7-20020a5d4b07000000b0033d8ef8c10cmr6355956wrq.23.1709566813562;
        Mon, 04 Mar 2024 07:40:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033d6bc17d0esm12832598wrb.74.2024.03.04.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:40:13 -0800 (PST)
Message-ID: <e8528715ebf97c12622c2e73f914ab4228a0927c.1709566808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 15:40:08 +0000
Subject: [PATCH 4/4] trace2: remove unneeded calls to generate 'def_param' set
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Now that "trace2_cmd_name()" implicitly calls "trace2_cmd_list_config()"
and "trace2_cmd_list_env_vars()", we don't need to explicitly call them.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 git.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/git.c b/git.c
index 7068a184b0a..a769d72ab8f 100644
--- a/git.c
+++ b/git.c
@@ -373,8 +373,6 @@ static int handle_alias(int *argcp, const char ***argv)
 			strvec_pushv(&child.args, (*argv) + 1);
 
 			trace2_cmd_alias(alias_command, child.args.v);
-			trace2_cmd_list_config();
-			trace2_cmd_list_env_vars();
 			trace2_cmd_name("_run_shell_alias_");
 
 			ret = run_command(&child);
@@ -411,8 +409,6 @@ static int handle_alias(int *argcp, const char ***argv)
 		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
 
 		trace2_cmd_alias(alias_command, new_argv);
-		trace2_cmd_list_config();
-		trace2_cmd_list_env_vars();
 
 		*argv = new_argv;
 		*argcp += count - 1;
@@ -462,8 +458,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	trace_argv_printf(argv, "trace: built-in: git");
 	trace2_cmd_name(p->cmd);
-	trace2_cmd_list_config();
-	trace2_cmd_list_env_vars();
 
 	validate_cache_entries(the_repository->index);
 	status = p->fn(argc, argv, prefix);
-- 
gitgitgadget
