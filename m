Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148321C3BEB
	for <git@vger.kernel.org>; Sun, 11 May 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970149; cv=none; b=tZodBmos3enJtX7IXtZ6W2xkGzbfJchsiKbELecPH1jVYsChpbgHP5GU3Dri3122tGlyZptnTaJMY+WkPrcTolgqgWtpJKhN3z+5nODz/aIP1tbdMtXKnMFHxljU5YQ1doa89CWpsY0uX7wfqgukchHwksQvy7lRVJvtXS4Rzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970149; c=relaxed/simple;
	bh=xZCjsT4+mqj/oN9TqoXS8J6RV6BMfFD7s5EjzZn6ZK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG66vgntpVgCyUxvSdEuugBRgirgiUKXWmVvjyejt488nmQ1mr0LJ/j+6hrfv7h5EMbi3mBoUJf+1uBG6z5DD0vonV6M1JrdkReWzSD8pkWfZYc8yYSIrxC/ymRdA8+6ImQ6ToyIEmotp4LRLbX2dUlrcFwDgh7T7nQ1px4DAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FniO/CcP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FniO/CcP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74019695377so2619657b3a.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746970147; x=1747574947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY4kymXz1p7lguN5G9B8cSJ96Ll9BwVNM5wZiACkUpQ=;
        b=FniO/CcPyM/qjf8Sjc5m8xQJ6z7drqUj2c4XHIioQ3sumYI7gqFGMwuNG0pNEdOlsl
         ZujdORCtLVjX7lzm1NyyS0H+5Od5uBxiY/QxVxQchS+mxgOb4OQqal3lBmu3n86QE6dZ
         jp+uZwLvYK9DGUGCWoQR1BphcMm8DEI2qaKkHnwek6TkTh5sgNzEWE6YGLSYnYvHTiSV
         I7QCX9iakDdVlOhLqIasZh3TU31IDXBm2/N4GeCnuXImmqsmPK0QjB1yoj8lrd1Oy5Wl
         yKX4Mo5SwnOlGLiLG7jVwskabqUaGGab78KV7xUZfcOMrTZ7OoTj96c0fAZiHqmkLu1O
         vCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746970147; x=1747574947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY4kymXz1p7lguN5G9B8cSJ96Ll9BwVNM5wZiACkUpQ=;
        b=C/EuZvvVsg5Sda01dEj3VdoUHN6WB3RBLn5wh95c5QVLmE/IM6fcTcIK1DFXXhIQc5
         waLtRSESced4x+OP/AvGdg06fQ+qgy0p2lwt4IZTlTj0sKICFDkzhRF3ZJ+7oHvemivF
         JBy5N1ViTSjrsmf00Phaw5nAtzxMPEeuDbVgu7reweiLnUNsGvcw38xan6ryeHeLA3um
         +jpC6+c2HmXejpyOdR/2wwVd4Uf25MNUuOtdGNunlbSfTTWMLmyrhDfj5Zk1sc91B14j
         rcvDCgVxWoSOI6qgZrgFQwB+YPR55MUIx2EZEyrhtBOaKF4DUZBCbrgRpQiJX6F25kbR
         VYvg==
X-Gm-Message-State: AOJu0YzWRWUg3zcSKz6N/9G0yW+jjyMNyYmOnVtultXUTuGLzg5TFyS2
	FHm5aOh5DxxlYamVYsADQ4Vicmt7eiz+E9+EykvE1bndUH741CZEofm11Q==
X-Gm-Gg: ASbGnctn7TjCH87n9dixE4JlkB7zqC5pzLsfLq3w8F5nVh71/uYSZ/LhWq6W3s/B4mP
	Lfs2S/dDX3smBTC7hnLAYiX8RuPzcVGIauRfcGGZ6huvYSK9EtlxQ9jbahu56BBnI2+ktpKKsx9
	HWvBpLEG/Vikn4s26Tb7wz27xofES6zlhFwKx9v5UUQkVKSSqL+OikaRa9txkePDiyzMQRf4Xv5
	W7Tjv1yMm6huAoyUUAUuzuFq+5JVibC6nvPdhuqDtv0heDvxZZxQlDItR7qWr6XE9cIWRmVwEwj
	PULjW0vdLww4H09M5z8rkDeHwWOKsynNWnl0RKyRGK0Bgm2Ph8aqFqiWYwsnzlI2qQ==
X-Google-Smtp-Source: AGHT+IEyBitNAkqgINj/NDOHIDPFLxyilgPmiRUIH+aRc4SsANHqOgYZvCHQE3mLY/Q3KvIb97dTEg==
X-Received: by 2002:a17:90b:4c89:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-30c3d3e8b69mr18552994a91.17.1746970146993;
        Sun, 11 May 2025 06:29:06 -0700 (PDT)
Received: from localhost.localdomain ([223.237.150.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb42fsm7778088a91.40.2025.05.11.06.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 06:29:06 -0700 (PDT)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita Dhar <dhar61595@gmail.com>,
	"Johannes Sixt" <j6t@kdbg.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: 
Date: Sun, 11 May 2025 18:58:02 +0530
Message-ID: <20250511132802.16338-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250511132802.16338-1-dhar61595@gmail.com>
References: <20250511125809.14180-1-dhar61595@gmail.com>
 <20250511132802.16338-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moumita Dhar <dhar61595@gmail.com>

Subject: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more shell
 function forms

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
 t/t4018/bash-bashism-style-multiline-function |  4 ++
 .../bash-hunk-header-complete-line-capture    |  4 ++
 t/t4018/bash-posix-style-multiline-function   |  4 ++
 .../bash-posix-style-single-command-function  |  3 ++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/bash/expect                           | 38 +++++++++++++++++++
 t/t4034/bash/post                             | 33 ++++++++++++++++
 t/t4034/bash/pre                              | 33 ++++++++++++++++
 userdiff.c                                    | 28 ++++++++++----
 9 files changed, 140 insertions(+), 8 deletions(-)
 create mode 100644 t/t4018/bash-bashism-style-multiline-function
 create mode 100644 t/t4018/bash-hunk-header-complete-line-capture
 create mode 100644 t/t4018/bash-posix-style-multiline-function
 create mode 100644 t/t4018/bash-posix-style-single-command-function
 create mode 100644 t/t4034/bash/expect
 create mode 100644 t/t4034/bash/post
 create mode 100644 t/t4034/bash/pre

diff --git a/t/t4018/bash-bashism-style-multiline-function b/t/t4018/bash-bashism-style-multiline-function
new file mode 100644
index 0000000000..284d50dd99
--- /dev/null
+++ b/t/t4018/bash-bashism-style-multiline-function
@@ -0,0 +1,4 @@
+function RIGHT \
+{    
+    echo 'ChangeMe'
+}
diff --git a/t/t4018/bash-hunk-header-complete-line-capture b/t/t4018/bash-hunk-header-complete-line-capture
new file mode 100644
index 0000000000..b56942f322
--- /dev/null
+++ b/t/t4018/bash-hunk-header-complete-line-capture
@@ -0,0 +1,4 @@
+func() { # RIGHT
+
+    ChangeMe
+}
diff --git a/t/t4018/bash-posix-style-multiline-function b/t/t4018/bash-posix-style-multiline-function
new file mode 100644
index 0000000000..cc8727cbcd
--- /dev/null
+++ b/t/t4018/bash-posix-style-multiline-function
@@ -0,0 +1,4 @@
+RIGHT() \
+{
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
index 0000000000..17755e455f
--- /dev/null
+++ b/t/t4034/bash/expect
@@ -0,0 +1,38 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 09ac008..60ba6a2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,33 +1,33 @@<RESET>
+<RED>my_var<RESET><GREEN>new_var<RESET>=10
+x=<RED>123<RESET><GREEN>456<RESET>
+y=<RED>3.14<RESET><GREEN>2.71<RESET>
+z=<RED>.5<RESET><GREEN>.75<RESET>
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
+${a<RED>:2:3<RESET><GREEN>:4:6<RESET>}
+ls <RED>-a<RESET><GREEN>-x<RESET>
+ls <RED>--a<RESET><GREEN>--x<RESET>
diff --git a/t/t4034/bash/post b/t/t4034/bash/post
new file mode 100644
index 0000000000..669e218c30
--- /dev/null
+++ b/t/t4034/bash/post
@@ -0,0 +1,33 @@
+new_var=10
+x=456
+y=2.71
+z=.75
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
+${a:4:6}
+ls -x
+ls --x
diff --git a/t/t4034/bash/pre b/t/t4034/bash/pre
new file mode 100644
index 0000000000..ada8470bac
--- /dev/null
+++ b/t/t4034/bash/pre
@@ -0,0 +1,33 @@
+my_var=10
+x=123
+y=3.14
+z=.5
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
+${a:2:3}
+ls -a
+ls --a
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..655c8fe0b1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -59,20 +59,32 @@ PATTERNS("bash",
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
+	 /* Numeric constants: integers and decimals */
+	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
+	 /* Shell variables: $VAR, ${VAR} */
+	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
+	  /* Logical and comparison operators */
+	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
+	 /* Assignment and arithmetic operators */
+	 "|[-+*/%&|^!=<>]=?"
+	 /* Additional parameter expansion operators */
+	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"
+	 /* Command-line options (to avoid splitting -option) */
+	 "|--?[a-zA-Z0-9_-]+"
+	 /* Brackets and grouping symbols */
+	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
 PATTERNS("bibtex",
 	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 /* -- */
-- 
2.48.0

