Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9392D061D
	for <git@vger.kernel.org>; Tue,  5 May 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022154; cv=none; b=sX/MhxY6ZfOuUUe7P0hALlhNTNBdP7kLB/RkCi1aw8rCWhVbta7uwkUHTDaUReXq+odTFDU79L4yaZ32Uf8AvbNw5hd9WRU9hKaYIBuQf3Bgp0wzIMJaY7Q4b94ETQEQpujTouw96Koathn2CBrY5jgt6srJuqNSK4Zqg32r8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022154; c=relaxed/simple;
	bh=945T+YgGioXWrLBlAGYCaCA4OedqWlnzbKO05SJqzMs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j7RpiISrjCa6fHzSnBimtNynenIjumuSZ2AG0lWm6JtZ1bKD/4SovKwsxPfdMC1J56azDpoT3WJ5tj3Mzc2PT6jwSSdH0UgsAKMUjXTrRNTM4TALejQZLYMyh8xJgWLp5DEayCzdQwO/4AKkungqpcIOL/WHdFSuAUrO6+pEo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFUHpnmn; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFUHpnmn"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12dfee30612so734366c88.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022152; x=1778626952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6sZa5uY9DQabCmC38lmMHEUJ2GkFbk9IjATtAWL4LM=;
        b=SFUHpnmnGfgbpDM8+4Li0TJE/OmFk+81nWPY4UWkwGFFi1D6al05GroyJF4D4+cmYi
         RtRJoc2WDz1Tzgsi3D9PMQXceCfbSDfuggtIHilhooq4QOqlwjLlXGtmWvSCNaqXPjRE
         ZlroVo8lPYdd1oVg5K/PphUFx6a92Ru6j2S/n5TFYpTQA36vxFwfuOsXEsib7hQfft64
         Haxa9bgDfhQStZN/HN3PZ0vii12sNlJRWRkB0gOCtDCOV3mIouv+FvHtsq+uCrO9yrxV
         ykW0meLbn2ApQWzmeDfcxswP6LGYzmv1OILXCsMuOlZwAg30CSklYKTsk0G06wKJYnEh
         BCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022152; x=1778626952;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R6sZa5uY9DQabCmC38lmMHEUJ2GkFbk9IjATtAWL4LM=;
        b=tLwBokcYsnhiNX0QzPCNIAQx06keQ9Xus7F1U7Tg3RlpGv4NSj3YzHMTWvZVlR58/T
         +k5DyOdVyAOkYj1HNyj/gaNePOjJYFYU7VupXSfBvUsiQ4UCdZ4/bT/YUlzkG+QUSWd0
         jABvMHHe5kF6o7YyG7rx9aSiFZuJDIHNoFKfFutbYJLC6srnLn5cY8bkNyi4lvjqOCjx
         90KdT7hIwA36kCFZ3UmDntcIRhP86NpTTeqUkaCZ3H1wKje4jZQkFeEnxPmd5kQ/YCjS
         n1dQI6UcecBKCOq7ZCwWSmxiwSz9MblEOuDAhQaUGELcJG/RYV5HVMdk33onyawNokvw
         8Whg==
X-Gm-Message-State: AOJu0YxxsoU8djzVoOgVtCJhQ+7fR+jLK4txGv4Ed6lyg1ugziG/NpOg
	puv2NOHd/xUntiTWSCsK+XGV4pS5o1itzuUP1PfI2cGLtzGr+X5/d1u3A4GHBeGZ
X-Gm-Gg: AeBDietmRawifbmB9+uHBbkRx+CkpEaa0Z7db6EJHfdxb4vjt2K5/NGJcXsVhUCOzur
	80i4Rb260rRR4kyIK0L1oo0kLqP/HGq/Cmz3CBPfns0dMOy6r5OhNlJJd2MbRMZb6C6L6Oleqqd
	gNSFHFwnrqO6AXfn4aXIVXDQrCZLSyqTMFDZZVWRD/2lW3ALcGTAfGahyzSsEXBzi1EqOCyKIGd
	QBQRRn38g9vQS92TZi700ZsH8mXCW3U+ngdpj2cN1cEegNoOxQNevLt5c6hiNU0NbhYBw7Vbm0T
	dEf9Dzc8b0nONY0vgp3Duv6xrvOFj+gBaR93pHu0/C9BPx0ehOSi0rDkfvFC8UyTbEXLPDOnV1M
	xyZaw1ZQp+43EKAwrSl0sVpKSzVjx30wFoI+VE6L6dHwLi+eN67JDbM1r1pvkPoMMzWEZ1WRt07
	lkBWZWZC6jjjGjaQRpU1RDNGtLrThi/q/h
X-Received: by 2002:a05:7022:4184:b0:12d:de3e:86a7 with SMTP id a92af1059eb24-131964ae31amr641594c88.37.1778022151745;
        Tue, 05 May 2026 16:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.4.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13202fbf850sm977542c88.14.2026.05.05.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:02:31 -0700 (PDT)
Message-Id: <05ff821e6ffec02a3bfc5aef542592de6a7add76.1778022144.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 23:02:24 +0000
Subject: [PATCH 4/4] parse-options: clarify PARSE_OPT_NONEG does not reject
 negative numbers
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The name "NONEG" can be misread as "no negative [values]" when it
actually means "no [boolean] negation" (the --no-* form).

When --inter-hunk-context and -U/--unified were converted from a
custom parser to OPT_INTEGER_F with PARSE_OPT_NONEG in d473e2e0e8
and 16ed6c97cc, the implicit rejection of negative values (via
isdigit() in the old opt_arg() parser) was silently lost. The
previous commits in this series fix the resulting bugs.

Add a clarifying note to the flag documentation.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 parse-options.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 706de9729f..c0a3a3dcae 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -116,7 +116,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
  *   mask of parse_opt_option_flags.
  *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option does not take an argument
- *   PARSE_OPT_NONEG: says that this option cannot be negated
+ *   PARSE_OPT_NONEG: says that this option cannot be negated (i.e.
+ *                   prevents --no-<option> boolean form). Does not reject
+ *                   negative numeric values like --option=-1. Use
+ *                   OPT_UNSIGNED for options that must be non-negative.
  *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
  *                     shown only in the full usage.
  *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the default
-- 
gitgitgadget
