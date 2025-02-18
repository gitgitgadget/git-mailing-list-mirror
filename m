Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AC2690C0
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893024; cv=none; b=rtQRTRjWDLDoENbeJ1/4S0Ac9zDLNr8QCAAs9sQslAgweiyWkH3UjqTtHJtHmTTZiwh/1JHSlH/cTXEir5BCjUP6KX4c5EPFlZohG7YTY/oDIanzyBB9Fj3qaT382vSMOiPkLvpl2M9suKs7SVJo0f9tCMT0QrFp3k6TlFxfk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893024; c=relaxed/simple;
	bh=0SBU/nbSG6UUjcnLl2fKRIS3WRnyQZoL8Q+NOPTBPNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls6RnoZN+JMaz6U7dNtAx1n6LneF1OYImsC8aLU0LvW+yYaQDnvp+arkL/SmTX4hHzmueGBvym80oFFZ7KKrX8Ss2xYGiNa5AvuBjkEVGXVBVt0EXOipbIWhjNr+Z85eJNk7gQIWSEVFykK8HI1dawL9dlmELRVi9MXG6+kIkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTi6pj25; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTi6pj25"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220dc3831e3so82726385ad.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739893022; x=1740497822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLE1onLxLxQb6/aNKyUCdXrsldIVtwpg7AV3HRNW85M=;
        b=YTi6pj25/QW8I/k6XLyP3lT/xhzeiWSV+2HVoFFzj7Gco6BOgbnluMrwswXqKDK0AH
         YfFVw8rlHwQuMOfsB+XAEYewUq0Ku0oddZBNrhmDxrYBvz03B60iDLNLbuZP6q92W499
         lSckk2IfUrURx+jBpVCrzN35semwuSVE3Y0y04Ij1SArQYcQSKo5sf/fDoCacrdB6VAZ
         06mDT+GMg9biJTPlxd4PqaoN8Lk+Mc6K37VJ8gdV/bd4JbmL391K6XByCSDp48aKbsA4
         K5LLnwRIt2xBW8Er3Bw2R9S6l+cROqYrfv+6LyS//3M0y9u8buVCCdyBadW+faMZkRy2
         o1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893022; x=1740497822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLE1onLxLxQb6/aNKyUCdXrsldIVtwpg7AV3HRNW85M=;
        b=uV86q/Tojey8FfaZdrEjJ0TzdEtE4v4/9zrm5dsS/64Gr8caP1m4kE/IOLAxahUb5F
         9rSPzap7rnQbOw/Uv1SbpJ81Gi0QcDj8NW44mFE2FZYWBLddum/Ao514C5uOED2m7NFz
         qY9Is31qnegTfRJjqYCPP0/sMlbF72sGwf8KzNWtiWn80M4tNMHtbuBEEu1nmKqptvJD
         RatIyMf/3I1HERWnFQDNtdDgciuLM8bTZZG0OvvaPpXk/ho+/k7X3kUjJp650WSsiOby
         ggNmEIp5IbmcLZ3i0yswDMhpDS8fzEbdtx4QUrQWpTpELEzi1oyiDejp/axVNXebGZ/u
         B6hw==
X-Gm-Message-State: AOJu0YwVyseZ4btI+wNSG4Jo/D97awHK7euPd+hb6GNeVjQ0O0qnB0PG
	REwKLGMYyUJONAQuz6cs5R1es5hQcbYHCNT5TIoHOD4+H0AN+C9ethiGNTfU
X-Gm-Gg: ASbGncvX0B9+IWZcZykUDj+pL3nnRPJ0B8NLzkCYh7YIjF7DPk8xi6exN3Wjfsd5Vl0
	r4RGY8OcrgT/CSLw71JItFaB402TW6uiK2brefTVFgld0vXWLxj8ZHkFxEh1+dL94mvobNspEwF
	SOtmVDoOLI/wiO5eQNPGRrO1H6TTmCg4zWNB+Lwmiev8j2oDtpkl1HHQbPCPFn9gvoHQPohj2FR
	R/KA5G0xh6MG7pZjR150pumcHc8E0IOmkL3p9Z+RJsvRGyF227TJ+h93zuKnOzHvog0wlY76fCs
	6a8NLc89F8E8A/Cws2rP2F7vonk=
X-Google-Smtp-Source: AGHT+IG8erWeL6H8otl2yRkxF/8P+xbSeNhYq1y62RvR88j+QN+WLV2ebxB45gWRokre4IXrIgurkQ==
X-Received: by 2002:a05:6a00:2e21:b0:724:db17:f975 with SMTP id d2e1a72fcca58-7329cf8db1fmr233787b3a.12.1739893021631;
        Tue, 18 Feb 2025 07:37:01 -0800 (PST)
Received: from localhost.localdomain ([171.60.234.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73285a7bfbfsm3333098b3a.154.2025.02.18.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:37:01 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>
Subject: [PATCH v2 1/1] userdiff: extend Bash pattern to cover more shell function forms
Date: Tue, 18 Feb 2025 21:05:27 +0530
Message-ID: <20250218153537.16320-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250218153537.16320-1-dhar61595@gmail.com>
References: <20250211114611.9334-1-dhar61595@gmail.com>
 <20250218153537.16320-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moumita Dhar <dhar61595@gmail.com>

The existing Bash userdiff pattern misses some shell function forms, such as
`function foo()`, multi-line definitions, and extra whitespace.

Extend the pattern to:
- Support `function foo()` syntax.
- Allow spaces in `foo ( )` definitions.
- Recognize multi-line definitions with backslashes.
- Broaden function body detection.

Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
---
 userdiff.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..194e28883d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -53,26 +53,38 @@ IPATTERN("ada",
 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
 PATTERNS("bash",
-	 /* Optional leading indentation */
+     /* Optional leading indentation */
 	 "^[ \t]*"
-	 /* Start of captured text */
+	 /* Start of captured function name */
 	 "("
 	 "("
-	     /* POSIX identifier with mandatory parentheses */
-	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
+		 /* POSIX identifier with mandatory parentheses (allow spaces inside) */
+		 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\)"
 	 "|"
-	     /* Bashism identifier with optional parentheses */
-	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
+		 /* Bash-style function definitions, allowing optional `function` keyword */
+		 "(?:function[ \t]+(?=[a-zA-Z_]))?[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))?"
 	 ")"
 	 /* Optional whitespace */
 	 "[ \t]*"
-	 /* Compound command starting with `{`, `(`, `((` or `[[` */
-	 "(\\{|\\(\\(?|\\[\\[)"
-	 /* End of captured text */
+	 /* Allow function body to start with `{`, `(` (subshell), `[[` */
+	 "(\\{|\\(|\\[\\[)"
+	 /* End of captured function name */
 	 ")",
 	 /* -- */
-	 /* Characters not in the default $IFS value */
-	 "[^ \t]+"),
+	 /* Identifiers: variable and function names */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 /* Numeric constants: integers and decimals */
+	 "|[-+]?[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
+	 /* Shell variables: `$VAR`, `${VAR}` */
+	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"
+	 /* Logical and comparison operators */
+	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
+	 /* Assignment and arithmetic operators */
+	 "|[-+*/%&|^!=<>]=?"
+	 /* Command-line options (to avoid splitting `-option`) */
+	 "|--?[a-zA-Z0-9_-]+"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("bibtex",
 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 /* -- */
-- 
2.48.0

