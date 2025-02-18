Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415626D5A5
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893016; cv=none; b=UyHFw8RGi+Z56M7mB9XfI7kxPGgIp41DRaxWiCJqK2NEDDdRLe9gmMoaJPNND6pGzfk23DUGSlamHyShYEsj5Rdg5O7XI8Rg/DVg4wvnmsatW93fbGUnIAeCD0JPdVzaODMSFkWYSYSkAQyiLmSlOFFa0xJUg9WX8TnAqoLW+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893016; c=relaxed/simple;
	bh=SLQo09GoZAKGjyh0m+HuBBbeviVJGMPd7tHghT0qhiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxre6ho+uIeReODpKdJUPSthUMLiEawAGVEjyWsP8XCwXK0nhD2UlVLVoatavoidc0Jy33GTuhWBCkGLotEoCXfBVOPNCV86AjdSkhG8CxHED0hSCGz5O6tkBDhhzhjWXuXdRDDvaia6KGVoo+MY4V2MfzCw0MTN3CS8KjH6hBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEhsO+aF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEhsO+aF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2212a930001so59563995ad.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739893014; x=1740497814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icW/FiHT3YkxgOPxCTeQwEZ8VfVy63WXCF94BhereEI=;
        b=IEhsO+aFaH1kRxNt0lfsDIIGYgQXJk+csVrGoESxPD2CrDRlKUp1+qQZR+MmLu2CPv
         68VlO7GFyVj85xleq3vAEKJZDNKCFHFs2hBquwouxdvZDvTRvpcbc60DIhhhogTy/ZoG
         lSID0HBS2AyeKHyPP16B3QCdBdXziehIK7bEVRryPwF0nH69RR9Gy0MOyd4RbwadZMZ2
         bCzHi2c799cBP9QXbh0veIHdFQStMpbx4XBPxDCG43JX9QpLbdpNZQeFiVBwXcXCRW8u
         xzJ9AglNkmp+susLHvFfIACAleNTmAiwv0CnSyilszAeNzlopasspNyziAZLHW1/rSzR
         PXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893014; x=1740497814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icW/FiHT3YkxgOPxCTeQwEZ8VfVy63WXCF94BhereEI=;
        b=p5OEgKINvqol2wqOeggjv7Uzd7UPO7WKhVbasnP3WnAf2P/2UMDCOva7k+loAvG5FF
         KO1DOtuCc80cc+WO5bpN+4vSHbLVqNRM++tuxYF11uXeWKIYqozuUtSis3CgVlfVr8Mj
         YrpU1iLH72/LICmzrM6QaS6oXqJE93Z4cz2caWWSp1iFEK+nMHDczkRzce9xMzIP2+9D
         j5IbBXbJ59AWeo9X5OuBK6CCYcEHhgHwm+xVyQdMjsZOo7CMeYIwvlhg0bVvPomZcrDb
         HUzvoEGcTXC5xP0/0zNxZGYagwcrY5Ont2mLcd7iCxfij9vZ3iAzknmXessUhemlijs0
         jB3g==
X-Gm-Message-State: AOJu0Yw6V0LhdB4HOrOW3ywpoKNncCueVB4SIkR8ZPfddNsdTPzVfM2Q
	+x5vVTb4MRdp/W2puna+sga14bC9eIEzHy4o4sSR/0C3d1rWRlqSCVjkN1bV
X-Gm-Gg: ASbGnctqpzBxxsd4aoQSZ3U6pUpE42DVUCboT/I42bzJDO2bst61jiymbr8rLv0W+HH
	RRwL8AGnTZGfpiqfJ/Mku/RXvGaHvZ63kk/qGG/nN30DBarl8c4va6uuD+yyIPbskLtxnQNWsiH
	Qagr/lnbNGMFiHQ4gwmOWxpOeQ8Q0QIraXQo9l/9O0y1NU76PhsV1RDWtHdz2tRPsJXJaB4p0Jb
	JQLzuz5jbLIGE83HbKg0YgCrMCJ/knps8uPRT9sG+aqyhP3MRQcoCpn8MkAuo2POc8iIWdwSDWm
	bTBMA75yFspVuZ05Yx9/GSfoNHw=
X-Google-Smtp-Source: AGHT+IFtmmt+pGNdMcty8x4DKmmCHVJ1lMqVIrKUJPKebbPRk+TzT6e9MlnGY33o7FOMZK4t5NnpAA==
X-Received: by 2002:a05:6a00:929a:b0:72a:8bb6:2963 with SMTP id d2e1a72fcca58-732617c3c17mr21543040b3a.13.1739893013479;
        Tue, 18 Feb 2025 07:36:53 -0800 (PST)
Received: from localhost.localdomain ([171.60.234.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73285a7bfbfsm3333098b3a.154.2025.02.18.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:36:53 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Atharva Raykar <raykar.ath@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 0/1] [PATCH v2 0/1] [GSOC 2025] [Newbie] userdiff: add built-in pattern for shell scripts
Date: Tue, 18 Feb 2025 21:05:26 +0530
Message-ID: <20250218153537.16320-1-dhar61595@gmail.com>
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

The modifications that I made were -
"^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\([ \t]*\\)[ \t]*"  - so that is allows foo() and foo ( ).
"^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\([ \t]*\\)[ \t]*(\\{|\\(|\\[\\[)" - so that it recognises {, (, or [[ as function bodies
"^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\([ \t]*\\)[ \t]*(\\{|\\(|\\[\\[)|\\\\\n"-  so that it matches "function foo \
  { echo "hello"; }"
"(?:function[ \t]+(?=[a-zA-Z_]))?[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))?" - so that it matches function foo() { echo "hello"; }
and also function bar { echo "no parens"; }
"|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"- It seperates ${} expansions
"|--?[a-zA-Z0-9_-]+" - It ensures -opt and --long-opt are treated as whole tokens.
"|[0-9]+(\\.[0-9]*)?" - It matches numbers without +/-


Moumita Dhar (1):
  userdiff: extend Bash pattern to cover more shell function forms

 userdiff.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  683ea08819 ! 1:  de2e8f9792 userdiff : Added built in function recognition for shell
    @@
      ## Metadata ##
    -Author: Moumita <dhar61595@gmail.com>
    +Author: Moumita Dhar <dhar61595@gmail.com>
     
      ## Commit message ##
    -    userdiff : Added built in function recognition for shell
    +    userdiff: extend Bash pattern to cover more shell function forms
     
    -    Introduced a built-in userdiff driver for shell scripts, enabling
    -    accurate function name recognition in `git diff` hunk headers.
    +    The existing Bash userdiff pattern misses some shell function forms, such as
    +    `function foo()`, multi-line definitions, and extra whitespace.
     
    -    Enhancements include:
    -    - Function name detection for both POSIX and Bash/Ksh-style functions:
    -      - `function_name() { ... }`
    -      - `function function_name { ... }`
    -    - Exclusion of shell keywords that can resemble function names,
    -      preventing false matches (e.g., `if`, `for`, `while`, `return`, etc.).
    -    - Improved tokenization support for:
    -      - Identifiers (variable and function names)
    -      - Numeric constants (integers and decimals)
    -      - Shell variables (`$VAR`, `${VAR}`)
    -      - Logical (`&&`, `||`, `==`, `!=`, `<=`, `>=`) and arithmetic operators
    -      - Assignment and redirection operators
    -      - Brackets and grouping symbols
    +    Extend the pattern to:
    +    - Support `function foo()` syntax.
    +    - Allow spaces in `foo ( )` definitions.
    +    - Recognize multi-line definitions with backslashes.
    +    - Broaden function body detection.
     
    -    This update improves Git’s diff readability for shell scripts,
    -    bringing it in line with existing built-in userdiff drivers.
    -
    -    Signed-off-by: Moumita <dhar61595@gmail.com>
    +    Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
     
      ## userdiff.c ##
    -@@ userdiff.c: PATTERNS("scheme",
    - 	 "\\|([^\\\\]*)\\|"
    - 	 /* All other words should be delimited by spaces or parentheses */
    - 	 "|([^][)(}{[ \t])+"),
    -+PATTERNS("shell",
    -+	 /* Negate shell keywords that can look like functions */
    -+	  "!^[ \t]*(if|elif|else|fi|for|while|until|case|esac|then|do|done|return|break|continue)\\b\n"
    -+	 /* POSIX-style shell functions: function_name() { ... } */
    -+	 "^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\(\\)[ \t]*\\{\n"
    -+	 /* Bash/Ksh-style functions: function function_name { ... } */
    -+	 "^[ \t]*function[ \t]+([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\{\n",
    -+	 /* -- */
    +@@ userdiff.c: IPATTERN("ada",
    + 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
    + 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
    + PATTERNS("bash",
    +-	 /* Optional leading indentation */
    ++     /* Optional leading indentation */
    + 	 "^[ \t]*"
    +-	 /* Start of captured text */
    ++	 /* Start of captured function name */
    + 	 "("
    + 	 "("
    +-	     /* POSIX identifier with mandatory parentheses */
    +-	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
    ++		 /* POSIX identifier with mandatory parentheses (allow spaces inside) */
    ++		 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\)"
    + 	 "|"
    +-	     /* Bashism identifier with optional parentheses */
    +-	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
    ++		 /* Bash-style function definitions, allowing optional `function` keyword */
    ++		 "(?:function[ \t]+(?=[a-zA-Z_]))?[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))?"
    + 	 ")"
    + 	 /* Optional whitespace */
    + 	 "[ \t]*"
    +-	 /* Compound command starting with `{`, `(`, `((` or `[[` */
    +-	 "(\\{|\\(\\(?|\\[\\[)"
    +-	 /* End of captured text */
    ++	 /* Allow function body to start with `{`, `(` (subshell), `[[` */
    ++	 "(\\{|\\(|\\[\\[)"
    ++	 /* End of captured function name */
    + 	 ")",
    + 	 /* -- */
    +-	 /* Characters not in the default $IFS value */
    +-	 "[^ \t]+"),
     +	 /* Identifiers: variable and function names */
     +	 "[a-zA-Z_][a-zA-Z0-9_]*"
     +	 /* Numeric constants: integers and decimals */
    -+	 "|[-+]?[0-9]+(\\.[0-9]*)?"
    -+	 /* Shell variables: $VAR and ${VAR} */
    ++	 "|[-+]?[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
    ++	 /* Shell variables: `$VAR`, `${VAR}` */
     +	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"
     +	 /* Logical and comparison operators */
     +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
     +	 /* Assignment and arithmetic operators */
     +	 "|[-+*/%&|^!=<>]=?"
    ++	 /* Command-line options (to avoid splitting `-option`) */
    ++	 "|--?[a-zA-Z0-9_-]+"
     +	 /* Brackets and grouping symbols */
     +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
    - PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
    - 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
    - { .name = "default", .binary = -1 },
    + PATTERNS("bibtex",
    + 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
    + 	 /* -- */
-- 
2.48.0

