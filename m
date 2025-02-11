Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF431F8BBF
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274462; cv=none; b=Xd9S1OcdcmKYgS2by9hngAble3Z4bg21wSHpF/GlG8G1CnG4d/axUb0C1EaxfKmdo0DxIj8pfR7GnrWdqkgRQ7CiYEC7IKGT5IgeGGqwMGSIb5wsX96DIotcd0Ub5CdW8RwdtHA7QqxNWPTJpfu9ppwQFpAUHZ4zzbLW4qpGdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274462; c=relaxed/simple;
	bh=PP5lMhfJpXTZGn1ID7FvDXyzZo/n6IrhX7GyTcnf9fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=du3sq7p3f/j/m/17mVMtxbDS3GLHA7DxFaySAQSR92DVP3FPvmhHjsw3ifD9F78SzShmsZ6pTig8Qv96VHccwgJClb8ZhPzh6MQpn6R9GDMtZwfINWMpbCL+qKX84uWYeCJJnD/ZdPruDpj7ACoJjzXBXfamdaNjyGPBzIPYgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgaOGvTN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgaOGvTN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6a47d617so49546855ad.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 03:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739274460; x=1739879260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPaQ/zyfIUreesLHQVSHbPkrSn16upwYcQ2pXJASj5U=;
        b=QgaOGvTNhxWcz0nD/4QDuRxatJKGC0JbemIPxwFcdF5JPWruz4MpGVjLqf8oRBDZ91
         0v1IQ29860UCSOm9s0CFR1GYoQVShn5XtWjfAGdh4JsNxW+MNxSSK3+eILnLh8m8Otk0
         HvHd0NglefbN8tZr0m/af4Zfyr/zeYpkg3iL5yq5rIG0Dw4YukQFKBgCQ3SygSRxdiF0
         SGaJ2Dc8euSJmEVV8d1j646NlmyZqXXNYPCkUaUZqduCJKGF9ca0m7CK9fjkPeferr0c
         RhgWaqkhhBLfvJqrpKvgZPrN1arP86KifWRC6WCq7ZyyDkoq2k+U2UE6wNzqxUDayaEF
         RhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274460; x=1739879260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPaQ/zyfIUreesLHQVSHbPkrSn16upwYcQ2pXJASj5U=;
        b=W+shVJpp1z/t+HljngSlyAqGVYlcWv3mkJO9wJCIlcOlCKwHgocQuCrd8qBgf20oTY
         eSe68eyTmjUxE5absTigXK1ymbMBFKus7MC51VZ28LPcJ4jF2o/hxWFi7wbEOYsn/MTB
         hWp02RFAZGPpx2+aV8aObnSTqOI1A2+ohOm0R08xspR5etro9uHmynvXknQgp5ixg+nw
         tUhI7QtZF8uQy2GVOs7D9LDbuzSToulQMWzmavF+Uj7lKXpDAzCwQf+Eqfp7swik1xqC
         3qH3Sv7VM26RsqHG65Cq7foMcsHwXy+tv2pVVvwMCklmlAYzCVE9sdqSsSui2AxZLHQG
         1C9g==
X-Gm-Message-State: AOJu0YxRo98Nb+HaE53o9LdsmqDaoCYy6AlhctW4+V386HwZc8g6TbPM
	yLSg1Vxye9R011ow1QZOkWEKbOL4fqx3gSmjH4QL3LSloB75Ha541sjMmg==
X-Gm-Gg: ASbGncv4alU7zreT25teFa5xtc4mrJBssMjeislJSDYX711OmTrMtEWaYQB+2qlNuA3
	0QjfI4238YwffBOYuEpvBcDlvek9AmXnfSmNkvjrt0B+feQi4itX26pI2KVOZfUn9wMGP+GgIME
	+813uJWQ3t5eRlgujIurMP/OqzsalRVKUuv/2Pm397yi6JDLUbpCvCUil3NaO/kw8Imf6IhD3nB
	MC7tPiTpgNbgnipTRvCmZj7yzm61sSyVcBvrngYrTn8p/+KWPoAdUZucQOiPgVz4atrmtUpYtvO
	pKpkH0HfLnAbYnmtGuLrkJsI2b22
X-Google-Smtp-Source: AGHT+IGJIPblACnZnjGZ81A3POj5Kxdhbul0W5bcbdKm6+w3GyiFbYUxNMzPt5jzK4RCU6KJdWB50g==
X-Received: by 2002:a17:902:c94c:b0:21d:cd54:c7ef with SMTP id d9443c01a7336-21f4e6a05f9mr273673155ad.9.1739274459883;
        Tue, 11 Feb 2025 03:47:39 -0800 (PST)
Received: from localhost.localdomain ([171.60.229.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653afb6sm95279915ad.53.2025.02.11.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:47:39 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Atharva Raykar <raykar.ath@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH 1/1] Added built in function recognition for shell
Date: Tue, 11 Feb 2025 17:16:10 +0530
Message-ID: <20250211114611.9334-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250211114611.9334-1-dhar61595@gmail.com>
References: <20250211114611.9334-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduced a built-in userdiff driver for shell scripts, enabling
accurate function name recognition in `git diff` hunk headers.

Enhancements include:
- Function name detection for both POSIX and Bash/Ksh-style functions:
  - `function_name() { ... }`
  - `function function_name { ... }`
- Exclusion of shell keywords that can resemble function names,
  preventing false matches (e.g., `if`, `for`, `while`, `return`, etc.).
- Improved tokenization support for:
  - Identifiers (variable and function names)
  - Numeric constants (integers and decimals)
  - Shell variables (`$VAR`, `${VAR}`)
  - Logical (`&&`, `||`, `==`, `!=`, `<=`, `>=`) and arithmetic operators
  - Assignment and redirection operators
  - Brackets and grouping symbols

This update improves Git’s diff readability for shell scripts,
bringing it in line with existing built-in userdiff drivers.

Signed-off-by: Moumita <dhar61595@gmail.com>
---
 userdiff.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..a8c14807c6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -334,6 +334,26 @@ PATTERNS("scheme",
 	 "\\|([^\\\\]*)\\|"
 	 /* All other words should be delimited by spaces or parentheses */
 	 "|([^][)(}{[ \t])+"),
+PATTERNS("shell",
+	 /* Negate shell keywords that can look like functions */
+	 "!^[ \t]*(if|elif|else|fi|for|while|until|case|esac|then|do|done|return|break|continue)\\b\n"
+	 /* POSIX-style shell functions: function_name() { ... } */
+	 "^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\(\\)[ \t]*\\{\n"
+	 /* Bash/Ksh-style functions: function function_name { ... } */
+	 "^[ \t]*function[ \t]+([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\{\n",
+	 /* -- */
+	 /* Identifiers: variable and function names */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 /* Numeric constants: integers and decimals */
+	 "|[-+]?[0-9]+(\\.[0-9]*)?"
+	 /* Shell variables: $VAR and ${VAR} */
+	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"
+	 /* Logical and comparison operators */
+	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
+	 /* Assignment and arithmetic operators */
+	 "|[-+*/%&|^!=<>]=?"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
 { .name = "default", .binary = -1 },
-- 
2.48.0

