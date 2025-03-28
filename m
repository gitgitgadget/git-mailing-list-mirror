Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1419AA5D
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192464; cv=none; b=PgOc7n3zJfw2fvDklsrdgmwLNR0DKoskF6xuWcmsgzBtI3A1tfY1q5pnB8hlWOeNqk3CGtJD85XDMDN+W/VFTzVvmEbNvAIPbz4COgbY+qG8180beFO73aiQJKL4jwbOtf3piFBe3Qry7duFmANf38+QNUE5SZTodq6r57MBMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192464; c=relaxed/simple;
	bh=Wr3jKATGaxG7FjPsTWHENm2Msu2BaOZZegqa2WQbnzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpoyJy6MRWLt8fAHHE4Fuaqn3asCMG2GDmxgorfOTlPyIa2AH6LvxKeasjM0Wk9ouqXj7sNDRsL27szKjrVqqoszhbG+ETDMYb3IVu4qnHFMknwcnXDPRIpz8X87RAl6K2lrk//D8vGIV+62/po+5ayxTNzkYFYFIdvEEXhzGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwk4N7l5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwk4N7l5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso3435610a91.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743192462; x=1743797262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROGxGpuM8SlPEVzMeQ7MqeL9ZDEzV30Sv7zimG05jbQ=;
        b=Dwk4N7l5zFjRB5tOY+JGzS7Ma62TzMDxAP9STFtdqav3U5M8a0sFn7RZ6tjcPoOgom
         +P6aRzjgeeYvD0y86GC/3/p+C0LpN+tqYFWwIMcQltZlaOBGv7fvE0BcNieKPBGwptQL
         WKIpOD1Sf5BlxXkjFJ8jpwKdIIKnTYCLPfenlvm6EkdkTApt0fP8gwMFXQt6wl6DyY5b
         780z527Im5nFQNWGolAQLa81RNYXEP0mfG7TLHgdaFvsH5DSAp+maMSKzg4cthV6Ctj5
         HgEJ2KIbYR7FpdnFhcUyqPxzvO4eETjADrSyu0xEY4hH0Bea0h/xXWgiJITQwX8TQ14d
         11vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192462; x=1743797262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROGxGpuM8SlPEVzMeQ7MqeL9ZDEzV30Sv7zimG05jbQ=;
        b=pk88oHCm8fYVlunjUwNiq+2uPAC0YaRCVnGMONiK1O9tPrakVfTHgC3iK+6SI6N8ZV
         5aimMAtu42VE0crdFOvflRoCFh95TcakXknzoDTfwuEXzfsM8f21psLdmfcYOJRBgnh9
         UOHQmRfFwpNU5WfalVWoKfU4/qE8REtkU0lqv8brmtYFiU4IZcdjNgZ9osAKscEQIneT
         vgUsojvlW0geZmAg4usq3RZ0lQ3RHIl06IrV0pL1wnbqq/UoMyk7s4Z+BMrEjRrO6WcB
         qCJQIEWiLMw/8bNseW/gjgfspZuo9nt5w6AU8dxcDGC8/TCAajtodO+j9UJOwORgxuPf
         2Thw==
X-Gm-Message-State: AOJu0YyAAJs/HQRD6Mc088BOLXFRUnZ6lSekIRe9kEh0P8JotWOGYYQg
	dKG2IooK5W7TAsreE/Lp60BcW2uxF64o1+JdfBN64c8PTuNI72KWYgORKA==
X-Gm-Gg: ASbGncvhXVVnHXJnk9W1aLn+fvx/XmhTt8JGYqQM84zICbI7C4pC/pQloME7Ff+rSfQ
	QgxpeSlSL8rYHjvijVZe9zS5iJPOdlZdG2RlNZXCygVN6dXDWpC2bXI0vJHTFnPy6NVW32gGxCd
	oqiGOveiFNUXnmXFH5Gcmf+SDc0YuIU6o8DgcBVIbRgU+/YM8TxC9rziJwj/jTynFp9Bc9crzrx
	JiJpk/+gSwzHdnY+SJshFj3mkvB2YUW+x1q6rhsUtP1/8BgWjgxnP/6i6A3bRLllcis0F1nE+Gp
	lUXXZosDmrNQ8QHSVFyqoiyObNOFlLV8RWrY2yuhc4uhObtYDD9t0BSE
X-Google-Smtp-Source: AGHT+IGZZSxxiIZDodMuwN/a0N82Ard5qonhiXWxZYxbRp0/02gNeeHjP7bcoc2r2QGd+ODGauKRRQ==
X-Received: by 2002:a17:90b:2e4e:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-3053215ce9bmr1000316a91.30.1743192461418;
        Fri, 28 Mar 2025 13:07:41 -0700 (PDT)
Received: from localhost.localdomain ([171.60.232.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3ea84sm2346421a91.8.2025.03.28.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:07:41 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>
Subject: [PATCH v3 1/1] userdiff: extend Bash pattern to cover more shell function forms
Date: Sat, 29 Mar 2025 01:35:25 +0530
Message-ID: <20250328200525.4437-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250328200525.4437-1-dhar61595@gmail.com>
References: <20250218153537.16320-1-dhar61595@gmail.com>
 <20250328200525.4437-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moumita Dhar <dhar61595@gmail.com>

The previous function regex required explicit matching of function
bodies using `{`, `(`, `((`, or `[[`, which caused several issues:

- It failed to capture valid functions where `{` was on the next line
  due to line continuation (`\`).
- It did not recognize functions with single  command body, such as
  `x () echo hello`.

Replacing the function body matching logic with `.*$`, ensures
that everything on the function definition line is captured,
aligning with other userdiff drivers and improving hunk headers in
`git diff`.

Additionally, the word regex is refined to better recognize shell
syntax, including additional parameter expansion operators and
command-line options, improving syntax-aware diffs.

Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
---
 t/t4018/bash-bashism-style-multiline-function |  4 +++
 t/t4018/bash-posix-style-multiline-function   |  4 +++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 30 +++++++++++++++++++
 t/t4034/bash/post                             | 25 ++++++++++++++++
 t/t4034/bash/pre                              | 25 ++++++++++++++++
 userdiff.c                                    | 24 +++++++++++----
 8 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

diff --git a/t/t4018/bash-bashism-style-multiline-function b/t/t4018/bash-bashism-style-multiline-function
new file mode 100644
index 0000000000..0800daa156
--- /dev/null
+++ b/t/t4018/bash-bashism-style-multiline-function
@@ -0,0 +1,4 @@
+function RIGHT \
+{    
+    echo 'ChangeMe'
+}
\ No newline at end of file
diff --git a/t/t4018/bash-posix-style-multiline-function b/t/t4018/bash-posix-style-multiline-function
new file mode 100644
index 0000000000..756f21524b
--- /dev/null
+++ b/t/t4018/bash-posix-style-multiline-function
@@ -0,0 +1,4 @@
+RIGHT() \
+{
+    ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/bash-posix-style-single-command-function b/t/t4018/bash-posix-style-single-command-function
new file mode 100644
index 0000000000..398ae1c5d2
--- /dev/null
+++ b/t/t4018/bash-posix-style-single-command-function
@@ -0,0 +1,3 @@
+RIGHT() echo "hello"
+
+    ChangeMe
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f51d3557f1..0be647c2fb 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -320,6 +320,7 @@ test_expect_success 'unset default driver' '
 
 test_language_driver ada
 test_language_driver bibtex
+test_language_driver bash
 test_language_driver cpp
 test_language_driver csharp
 test_language_driver css
diff --git a/t/t4034/bash/expect b/t/t4034/bash/expect
new file mode 100644
index 0000000000..a0f7cbd5a3
--- /dev/null
+++ b/t/t4034/bash/expect
@@ -0,0 +1,30 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 09ac008..60ba6a2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,25 +1,25 @@<RESET>
+<RED>my_var<RESET><GREEN>new_var<RESET>=10
+x=<RED>123<RESET><GREEN>456<RESET>
+y=<RED>3.14<RESET><GREEN>2.71<RESET>
+z=<RED>.5<RESET><GREEN>.75<RESET>
+echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
+${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
+if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi
+((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
+((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
+${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
+${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
+${<RED>a<RESET><GREEN>x<RESET>##*/}
+${<RED>a<RESET><GREEN>x<RESET>%.*}
+${<RED>a<RESET><GREEN>x<RESET>%%.*}
+${<RED>a<RESET><GREEN>x<RESET>^^}
+${<RED>a<RESET><GREEN>x<RESET>,}
+${<RED>a<RESET><GREEN>x<RESET>,,}
+${!<RED>a<RESET><GREEN>x<RESET>}
+${<RED>a<RESET><GREEN>x<RESET>[@]}
+${<RED>a<RESET><GREEN>x<RESET>:?error message}
+${<RED>a<RESET><GREEN>x<RESET>:2:3}
+ls <RED>-a<RESET><GREEN>-x<RESET>
+ls <RED>--a<RESET><GREEN>--x<RESET>
diff --git a/t/t4034/bash/post b/t/t4034/bash/post
new file mode 100644
index 0000000000..60ba6a2e75
--- /dev/null
+++ b/t/t4034/bash/post
@@ -0,0 +1,25 @@
+new_var=10
+x=456
+y=2.71
+z=.75
+echo $USERNAME
+${HOMEDIR}
+if [ "$x" == "$y" ] || [ "$x" != "$y" ]; then echo "OK"; fi
+((x+=y))
+((x-=y))
+$((x<<y))
+$((x>>y))
+${x:-y}
+${x:=y}
+${x##*/}
+${x%.*}
+${x%%.*}
+${x^^}
+${x,}
+${x,,}
+${!x}
+${x[@]}
+${x:?error message}
+${x:2:3}
+ls -x
+ls --x
diff --git a/t/t4034/bash/pre b/t/t4034/bash/pre
new file mode 100644
index 0000000000..09ac008a83
--- /dev/null
+++ b/t/t4034/bash/pre
@@ -0,0 +1,25 @@
+my_var=10
+x=123
+y=3.14
+z=.5
+echo $USER
+${HOME}
+if [ "$a" == "$b" ] || [ "$c" != "$d" ]; then echo "OK"; fi
+((a+=b))
+((a-=b))
+$((a << b))
+$((a >> b))
+${a:-b}
+${a:=b}
+${a##*/}
+${a%.*}
+${a%%.*}
+${a^^}
+${a,}
+${a,,}
+${!a}
+${a[@]}
+${a:?error message}
+${a:2:3}
+ls -a
+ls --a
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..4c77c7e0f6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -64,15 +64,27 @@ PATTERNS("bash",
 	     /* Bashism identifier with optional parentheses */
 	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
 	 ")"
-	 /* Optional whitespace */
-	 "[ \t]*"
-	 /* Compound command starting with `{`, `(`, `((` or `[[` */
-	 "(\\{|\\(\\(?|\\[\\[)"
+	 /* Everything after the function header is captured  */
+	 ".*$"
 	 /* End of captured text */
 	 ")",
 	 /* -- */
-	 /* Characters not in the default $IFS value */
-	 "[^ \t]+"),
+	 /* Identifiers: variable and function names */
+	  "[a-zA-Z_][a-zA-Z0-9_]*"
+	 /* Numeric constants: integers and decimals */
+	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
+	 /* Shell variables: $VAR, ${VAR} */
+	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
+	  /* Logical and comparison operators */
+	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
+	 /* Assignment and arithmetic operators */
+	 "|[-+*/%&|^!=<>]=?"
+	 /* Additional parameter expansion operators */
+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
+	 /* Command-line options (to avoid splitting -option) */
+	 "|--?[a-zA-Z0-9_-]+"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("bibtex",
 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 /* -- */
-- 
2.48.0

