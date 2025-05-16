Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3B192598
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406833; cv=none; b=BtSsYGMl/I/Qjb+LlX37bAi9Yvpc3vkFPDNaAt3kFdhi/4XwUb6Ht6z2RkbAST7/B6vO/a+VeWYLf7Kaj27gISYFE2wLH9VH0DDstCi/3KbeqCPaFTmhNilfp+Q7jFWEWfzWmfrvwnDkzI1tA1Lhe9AeC2Ld0s3ngOrd4Ut0IcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406833; c=relaxed/simple;
	bh=Bcqb4X3ZEc67Mn7OssoPTHFARG8yRRi2ovXQDQmsJfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSmF9EmjlZ27Bg/pWfvJKWjqAkoYJ4SpRPpltk28wzou0WKIG7yPb5jv4ZCPS4q2E1EtXWba0AS8xQnuDdgbiPj/Wob919sXMKD/uYi51QbF2Bw2Qef7JpQtRMekn+9UGnYNBn1q7IZ8Bhcm447theyNnasgG0yPer7swQj8yD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEvybkCo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEvybkCo"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30a894cc07cso2102389a91.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747406831; x=1748011631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q68OMzukDNxhEh+Wrr+L9JyjhiM/0LgDqrdp6oXV1Nw=;
        b=KEvybkCoEDHcVRPL2Iq4tYGO8x4o6oC4rjIfFIcjlAwka3GotGLIOLjGnMK0Nfnw4o
         0gn+R1XFwFjT8s+bJYFTWtrWA8jrUuKc5gRBjyWlP6gvqQ34i8qSfpF2bMO6cu9+yDyd
         7aEoUaFA/Jiq9dU8759nayLB+vIdqDOUWIAKcWXPu4oLSUJ91XKFTgbqz4yA6KYnJsV4
         J0gCRgO+EGdwm3tqwJbkqzpus1x3N9Rjz6RrigcWAyR5Q1plYam/Rkaygq1+Vw2ffFlv
         sRjujiGTQCkKCxkQ1idAqSslHjGKjZ+2Sf9m4mH5eNkbkHAouclbZPnZrjMwQly0uOLU
         DyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406831; x=1748011631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q68OMzukDNxhEh+Wrr+L9JyjhiM/0LgDqrdp6oXV1Nw=;
        b=h5QqQ+PrHhl8WiHYzcysvPTxC/w/iX7pPgBzN0Jrhr/hIgSdevgYcplIBRlnk6KeGi
         4l6zpyrEkKk73FSRkfdPNR8SfjsihRky2yN/R8IRxpBxPIjYVzILQ/I6B5vhbpKIpfMJ
         DNlUs6ADIkkrlWZeY8UIGOU4fK8gf/oVGyY+6fQ/hMRxuphKvwAOS4PCUYegNbRWgUPf
         JHJxTB8aDIFshKQZyVhptZ6WzACQ5V2b2KyQGOTqriJMP4GTFnyUcUHGfKFEw7wp0mST
         7Ki9ktD6ZjKqNkjilFakvHIw6FNYtDWcjx9Bi5NfTOJ7HVk0gfCxmJl1VSMycj/I5uca
         j8yA==
X-Gm-Message-State: AOJu0YwAqB28vObES2pOJOoGZmAqFpzc4BTCGs8W4lmijJJ5BA+m5rZe
	cBmi8bNk9tgU8/CUPdR2Hmr6zmwV/1cgJKEEPTyhsNUv/mjBVTx5/6GXRUNsdg==
X-Gm-Gg: ASbGncs+OcQrv1ddq8Tnj2M378hfuC+ppFVJoJphuKxxJhDLsPYhk9eeAR9jW81HJkt
	2fspuxTJJPjczXxqeua1q9q4TOC/wHmx7uaoRVlre4R9JOqrdS1QH9t5ORCPegArxfKrKgJogZ1
	j3Swlr96uPI7ufieVbNC5HXNKfjSITva1ZGcfglb32VSuosICcC+hlLNPS94vBtPGtNPgAVCloV
	Zk/LweVRNkQeMBBLo2wbiRl/qflmmVNDLK8aOA/RPU5R2kE3xu6cnX644pLLZ3mtYp2ArKZPoad
	ZK94K6aIU5pN9Z6X6Ktdqtr8jEy+QlZsjSpL6rNrCgEgLaeFsqdgQIqS3ZK0W8ha
X-Google-Smtp-Source: AGHT+IH3HRGM1/lZRTIlhbw3kEIK5B0f6XA33FvSnAA9g1n5xT3pjOmvfZJtI/sDTTtCY4fKs7533Q==
X-Received: by 2002:a17:90b:1f90:b0:304:ec28:4437 with SMTP id 98e67ed59e1d1-30e832162c8mr3485080a91.22.1747406830554;
        Fri, 16 May 2025 07:47:10 -0700 (PDT)
Received: from localhost.localdomain ([223.237.147.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334e24f8sm5321322a91.30.2025.05.16.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:47:10 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v7 1/1] userdiff: extend Bash pattern to cover more shell function forms
Date: Fri, 16 May 2025 20:15:12 +0530
Message-ID: <20250516144515.49514-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250516144515.49514-1-dhar61595@gmail.com>
References: <20250511141101.18450-1-dhar61595@gmail.com>
 <20250516144515.49514-1-dhar61595@gmail.com>
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
that everything on the function definition line is captured.

Additionally, the word regex is refined to better recognize shell
syntax, including additional parameter expansion operators and
command-line options.

Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
---
 .../bash-bashism-style-complete-line-capture  |  4 +++
 .../bash-posix-style-complete-line-capture    |  4 +++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 36 +++++++++++++++++++
 t/t4034/bash/post                             | 31 ++++++++++++++++
 t/t4034/bash/pre                              | 31 ++++++++++++++++
 userdiff.c                                    | 26 +++++++++-----
 8 files changed, 128 insertions(+), 8 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

diff --git a/t/t4018/bash-bashism-style-complete-line-capture b/t/t4018/bash-bashism-style-complete-line-capture
new file mode 100644
index 0000000000..070b979fa6
--- /dev/null
+++ b/t/t4018/bash-bashism-style-complete-line-capture
@@ -0,0 +1,4 @@
+function myfunc # RIGHT
+{
+    echo 'ChangeMe'
+}
diff --git a/t/t4018/bash-posix-style-complete-line-capture b/t/t4018/bash-posix-style-complete-line-capture
new file mode 100644
index 0000000000..b56942f322
--- /dev/null
+++ b/t/t4018/bash-posix-style-complete-line-capture
@@ -0,0 +1,4 @@
+func() { # RIGHT
+
+    ChangeMe
+}
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
index 0000000000..1864ab25dc
--- /dev/null
+++ b/t/t4034/bash/expect
@@ -0,0 +1,36 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 09ac008..60ba6a2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,31 +1,31 @@<RESET>
+<RED>my_var<RESET><GREEN>new_var<RESET>=10
+x=<RED>123<RESET><GREEN>456<RESET>
+echo <RED>$1<RESET><GREEN>$2<RESET>
+echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
+${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
+((a<RED>+<RESET><GREEN>+=<RESET>b))
+((a<RED>*<RESET><GREEN>*=<RESET>b))
+((a<RED>/<RESET><GREEN>/=<RESET>b))
+((a<RED>%<RESET><GREEN>%=<RESET>b))
+((a<RED>|<RESET><GREEN>|=<RESET>b))
+((a<RED>^<RESET><GREEN>^=<RESET>b))
+((a<RED>=<RESET><GREEN>==<RESET>b))
+((a<RED>!<RESET><GREEN>!=<RESET>b))
+((a<RED><<RESET><GREEN><=<RESET>b))
+((a<RED>><RESET><GREEN>>=<RESET>b))
+$((a<RED><<RESET><GREEN><<<RESET>b))
+$((a<RED>><RESET><GREEN>>><RESET>b))
+$((a<RED>&<RESET><GREEN>&&<RESET>b))
+$((a<RED>|<RESET><GREEN>||<RESET>b))
+${a<RED>:<RESET><GREEN>:-<RESET>b}
+${a<RED>:<RESET><GREEN>:=<RESET>b}
+${a<RED>:<RESET><GREEN>:+<RESET>b}
+${a<RED>:<RESET><GREEN>:?<RESET>b}
+${a<RED>#<RESET><GREEN>##<RESET>*/}
+${a<RED>%<RESET><GREEN>%%<RESET>.*}
+${a<RED>^<RESET><GREEN>^^<RESET>}
+${a<RED>,<RESET><GREEN>,,<RESET>}
+${<GREEN>!<RESET>a}
+${a[<RED>*<RESET><GREEN>@<RESET>]}
+ls <RED>-a<RESET><GREEN>-x<RESET>
+ls <RED>--all<RESET><GREEN>--color<RESET>
diff --git a/t/t4034/bash/post b/t/t4034/bash/post
new file mode 100644
index 0000000000..2bbee8936d
--- /dev/null
+++ b/t/t4034/bash/post
@@ -0,0 +1,31 @@
+new_var=10
+x=456
+echo $2
+echo $USERNAME
+${HOMEDIR}
+((a+=b))
+((a*=b))
+((a/=b))
+((a%=b))
+((a|=b))
+((a^=b))
+((a==b))
+((a!=b))
+((a<=b))
+((a>=b))
+$((a<<b))
+$((a>>b))
+$((a&&b))
+$((a||b))
+${a:-b}
+${a:=b}
+${a:+b}
+${a:?b}
+${a##*/}
+${a%%.*}
+${a^^}
+${a,,}
+${!a}
+${a[@]}
+ls -x
+ls --color
diff --git a/t/t4034/bash/pre b/t/t4034/bash/pre
new file mode 100644
index 0000000000..8d22039c40
--- /dev/null
+++ b/t/t4034/bash/pre
@@ -0,0 +1,31 @@
+my_var=10
+x=123
+echo $1
+echo $USER
+${HOME}
+((a+b))
+((a*b))
+((a/b))
+((a%b))
+((a|b))
+((a^b))
+((a=b))
+((a!b))
+((a<b))
+((a>b))
+$((a<b))
+$((a>b))
+$((a&b))
+$((a|b))
+${a:b}
+${a:b}
+${a:b}
+${a:b}
+${a#*/}
+${a%.*}
+${a^}
+${a,}
+${a}
+${a[*]}
+ls -a
+ls --all
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..7b18cbb669 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -59,20 +59,30 @@ PATTERNS("bash",
 	 "("
 	 "("
 	     /* POSIX identifier with mandatory parentheses */
-	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
+	     "([a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
 	 "|"
 	     /* Bashism identifier with optional parentheses */
-	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
+	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+)))"
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
+	 /* Shell variables: $VAR, ${VAR} */
+	  "|\\$[a-zA-Z0-9_]+|\\$\\{"
+	  /*Command list separators and redirection operators  */
+	 "|\\|\\||&&|<<|>>"
+	 /* Operators ending in '=' (comparison + compound assignment) */
+	 "|==|!=|<=|>=|[-+*/%&|^]="
+	 /* Additional parameter expansion operators */
+	 "|:=|:-|:\\+|:\\?|##|%%|\\^\\^|,,"
+	 /* Command-line options (to avoid splitting -option) */
+	 "|[-a-zA-Z0-9_]+"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("bibtex",
 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 /* -- */
-- 
2.48.0

