Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AA1BC41
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061225; cv=none; b=iTIprGjm5mSv5ZD5sd2Rl8wziqlCpHLiqnrDUHV+p1qBYJT/EBrmwlTgzjzTSACAiw5NjISBiw1RzQ1UfR3tOoWCx4hkY4EmjFNDKCt4wBkp09NnceAaxVP47SSUutwbZKiPL7b6yJii6QsuNawe/A1eGaHBEQ9obdsbPBjrcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061225; c=relaxed/simple;
	bh=QVZNN6ofjWeTQ/38Y249wZ1lhb0JOaPljwZ9IIFuKs8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bCIOq7laM19tk8Vgkr3iCbU2auXUNvquR1WUDVEvVhI5VZ+HrDgADExbzq8ZJfsXZ/hQop+JXHiDqf36pvYx5os7mOgHXp4ff+C+5Wt+TAkdh3+9Ybzoc+xy5zn6zc7cfL7tXJ7IIcz0eBRMszEKzKzcRfKjB5AUm9gFINYwkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRM4TeJ6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRM4TeJ6"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea2f58448so6030633e87.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721061221; x=1721666021; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/bqP7gPTfy7AGGkBknX9ISFB7cB02XGiMpxUYwLqedo=;
        b=BRM4TeJ63PNi+AU8xaXNxmIsu3M5WhTV1NbbNcRqaGxe0DbiDOoEMsmYCoghc0zV+s
         4nAVecLR0wqCUzY71de3Sjky6g1yAgQb+WflIOAdXL1iI0lk61WXiQEXc6u6pQqfhe4a
         tdcX8aogeUZp1Dg5c0I2tPHM5/LcQLPY1soTTDB86mJDkZejj8Bc1ZGFVTgYREsEcSI/
         yfZu2CgPVMEXzg3acX/UtssxLFowoyS+vDI1raKQApVfZ2NVHgJkkkMmwUDdOk+2x8OV
         HrtxvC+vCHANe5Gau+Tuv1r+DuyRkZp1mV0yeZoS6ixOiBPk+Ke6Ij32lEbPeVFNiTXe
         Sb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061221; x=1721666021;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bqP7gPTfy7AGGkBknX9ISFB7cB02XGiMpxUYwLqedo=;
        b=svEVe3x5KIG+8Ipx9PVKuaknxnAq7KFvPIWvyomFaDJ7Wsa48P+PGxoJzHkDKUW1EW
         UN7XKpFZSddVXJJAVPCZd0xNA84tIE8W31fpXWqT9F6iyk0t2aNVmbCsVj/o40UL9cgJ
         4l+ECy2wjDO2aNrkmAj4ypEt6OKOYnBg9wQimTFV2o6B5BFw8KBwUJhg51wOOzf9OQcU
         tC2feakuFX5Bjol1aRlugLFncXtQuJjjAXTF3Cv3YX9g0ulLj1HgqSGR9LkXSulJ+zhX
         vasoui3brIPjU9QcRa+4/6nOfm3f00MCqJGS3vQVwLtq3wRhibgyXfa1tni+3MUb3NP8
         CHWg==
X-Gm-Message-State: AOJu0YxxlDQiWz2g5wEZageKFpdIWaeO9HfXK5kJ3754QJy50SYNe8nU
	k1cEFMhFVcFJ764A7djAnO77QXiQJssKp+A/F40oigq8cTKkSYpc6N/Rfg==
X-Google-Smtp-Source: AGHT+IEKb4kou/JqyPsjlRrUwjYHDWAd+C2BSvIc3xoekPxxFfzzZyC7t59M4xe8IP40rOgxIL+KoA==
X-Received: by 2002:a05:6512:15a4:b0:52c:df4d:bb9e with SMTP id 2adb3069b0e04-52ede1ccef1mr23670e87.41.1721061220205;
        Mon, 15 Jul 2024 09:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc2efsm130210835e9.36.2024.07.15.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:33:39 -0700 (PDT)
Message-Id: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
From: "Matthew Hughes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jul 2024 16:33:38 +0000
Subject: [PATCH] userdiff: add builtin diff driver for TypeScript language
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
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
    Matthew Hughes <matthewhughes934@gmail.com>

From: Matthew Hughes <matthewhughes934@gmail.com>

TypeScript[1] is an open-source programming language that builds on
JavaScript. This patch adds builtin diff driver support for this
language. As far as I can tell there is no official syntax specification
for the language (see[2] for some discussion) so this patch is based off
some existing work[3]. The docs[4] probably provide the best
reference as to what this driver should satisfy. See[5] for
discussion/motivation for this change from the TypeScript language team.

This is my first time developing a diff driver, so as such the
implementation borrows quite a bit from existing drivers. The funcname
attribute matches function and class definitions, the list of keywords
used to define functions was take from[3], I could not find an
exhaustive list for these. The word-regex borrows much from other
existing diff engines, with the addition of the rather unique
right-shifting operators (>>> and >>>=) available in JavaScript (and
hence Typescript)[6]

[1] https://www.typescriptlang.org/
[2] https://github.com/Microsoft/TypeScript/issues/15711
[3] https://github.com/git/git/pull/859
[4] https://www.typescriptlang.org/docs/
[5] https://github.com/microsoft/TypeScript/issues/36185
[6] https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Unsigned_right_shift

Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
    userdiff: add builtin diff driver for TypeScript language

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1746%2Fmatthewhughes934%2Fadd-typescript-diff-driver-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1746/matthewhughes934/add-typescript-diff-driver-v1
Pull-Request: https://github.com/git/git/pull/1746

 Documentation/gitattributes.txt      |  2 ++
 t/t4018/typescript-arrow-func        |  7 +++++
 t/t4018/typescript-class             |  8 ++++++
 t/t4018/typescript-func              |  7 +++++
 t/t4018/typescript-indented-func     |  7 +++++
 t/t4018/typescript-interface         |  5 ++++
 t/t4018/typescript-nested-arrow-func |  7 +++++
 t/t4034-diff-words.sh                |  1 +
 t/t4034/typescript/expect            | 42 ++++++++++++++++++++++++++++
 t/t4034/typescript/post              | 24 ++++++++++++++++
 t/t4034/typescript/pre               | 24 ++++++++++++++++
 userdiff.c                           | 11 ++++++++
 12 files changed, 145 insertions(+)
 create mode 100644 t/t4018/typescript-arrow-func
 create mode 100644 t/t4018/typescript-class
 create mode 100644 t/t4018/typescript-func
 create mode 100644 t/t4018/typescript-indented-func
 create mode 100644 t/t4018/typescript-interface
 create mode 100644 t/t4018/typescript-nested-arrow-func
 create mode 100644 t/t4034/typescript/expect
 create mode 100644 t/t4034/typescript/post
 create mode 100644 t/t4034/typescript/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e6150595af8..88ebfb2e6c9 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -907,6 +907,8 @@ patterns are available:
 
 - `tex` suitable for source code for LaTeX documents.
 
+- `typescript` suitable for source code in the TypeScript language.
+
 
 Customizing word diff
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/t/t4018/typescript-arrow-func b/t/t4018/typescript-arrow-func
new file mode 100644
index 00000000000..c884c2e6bdc
--- /dev/null
+++ b/t/t4018/typescript-arrow-func
@@ -0,0 +1,7 @@
+const RIGHT = (a: number) : number => {
+    const res = a + 1
+
+    // some comment
+    console.log("ChangeMe")
+    return res
+}
diff --git a/t/t4018/typescript-class b/t/t4018/typescript-class
new file mode 100644
index 00000000000..a373f7af1dd
--- /dev/null
+++ b/t/t4018/typescript-class
@@ -0,0 +1,8 @@
+class RIGHT {
+    // some
+    // comments
+    // ChangeMe
+    constructor() {
+        console.log("constructing...")
+    }
+}
diff --git a/t/t4018/typescript-func b/t/t4018/typescript-func
new file mode 100644
index 00000000000..94cc659a452
--- /dev/null
+++ b/t/t4018/typescript-func
@@ -0,0 +1,7 @@
+function RIGHT(a: number) : number {
+    const res = a + 1
+
+    // some comment
+    console.log("ChangeMe")
+    return res
+}
diff --git a/t/t4018/typescript-indented-func b/t/t4018/typescript-indented-func
new file mode 100644
index 00000000000..fee0373126e
--- /dev/null
+++ b/t/t4018/typescript-indented-func
@@ -0,0 +1,7 @@
+class Foo {
+    public RIGHT() {
+        // some
+        // comments
+        console.log("ChangeMe")
+    }
+}
diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
new file mode 100644
index 00000000000..78d14523446
--- /dev/null
+++ b/t/t4018/typescript-interface
@@ -0,0 +1,5 @@
+interface RIGHT {
+    name: string;
+    // some comment 
+    ChangeMe: number;
+}
diff --git a/t/t4018/typescript-nested-arrow-func b/t/t4018/typescript-nested-arrow-func
new file mode 100644
index 00000000000..52dbc6a92e5
--- /dev/null
+++ b/t/t4018/typescript-nested-arrow-func
@@ -0,0 +1,7 @@
+class Foo {
+    RIGHT = () => {
+        // some
+        // comment
+        console.log("ChangeMe")
+    }
+}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813c..4e3cf415c23 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -338,6 +338,7 @@ test_language_driver python
 test_language_driver ruby
 test_language_driver scheme
 test_language_driver tex
+test_language_driver typescript
 
 test_expect_success 'word-diff with diff.sbe' '
 	cat >pre <<-\EOF &&
diff --git a/t/t4034/typescript/expect b/t/t4034/typescript/expect
new file mode 100644
index 00000000000..fde27423339
--- /dev/null
+++ b/t/t4034/typescript/expect
@@ -0,0 +1,42 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 6a5ba06c60..db4788b1a6 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,24 +1,24 @@<RESET>
+console.log("Hello world<RED>!<RESET><GREEN>?<RESET>")
+foo===<RED>bar<RESET><GREEN>buz<RESET>
+foo!==<RED>bar<RESET><GREEN>buz<RESET>
+function fn() : <RED>number<RESET><GREEN>string<RESET> { return <RED>1<RESET><GREEN>"ok"<RESET> }
+<RED>a<RESET><GREEN>x<RESET>.someFunc()
+const <RED>a<RESET><GREEN>x<RESET> = () => {}
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+"<RED>x<RESET><GREEN>y<RESET>"
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>>>>=<RED>b a<RESET><GREEN>y x<RESET>>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/typescript/post b/t/t4034/typescript/post
new file mode 100644
index 00000000000..4aca03f8ce6
--- /dev/null
+++ b/t/t4034/typescript/post
@@ -0,0 +1,24 @@
+console.log("Hello world?")
+foo===buz
+foo!==buz
+function fn() : string { return "ok" }
+x.someFunc()
+const x = () => {}
+(1) (-1e10) (0xabcdef) 'y'
+"y"
+[x] x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x>>>=y x>>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/typescript/pre b/t/t4034/typescript/pre
new file mode 100644
index 00000000000..ef654a92c61
--- /dev/null
+++ b/t/t4034/typescript/pre
@@ -0,0 +1,24 @@
+console.log("Hello world!")
+foo===bar
+foo!==bar
+function fn() : number { return 1 }
+a.someFunc()
+const a = () => {}
+1 -1e10 0xabcdef 'x'
+"x"
+[a] a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a>>>=b a>>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/userdiff.c b/userdiff.c
index c4ebb9ff734..7247d351cde 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -333,6 +333,17 @@ PATTERNS("scheme",
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
+PATTERNS("typescript",
+	"^[\t ]*((class|constructor|public|private|protected|function|interface)[ \t].*)$\n"
+	// arrow funcs
+	"^[\t ]*((const|let|var)?[^()]*)=[\t ]*\\([^()]*\\)[\t ]*.*=>.*$",
+	/* -- */
+	"[a-zA-Z_][a-zA-Z0-9_]*"
+	// numeric constants
+	"|[-+0-9.e]+|0[xX]?[0-9a-fA-F]"
+	// operators
+	"|[-+*/<>%&^|=!]"
+	"|--|\\+\\+|//=?|<<=?|>>?=?"),
 { .name = "default", .binary = -1 },
 };
 #undef PATTERNS

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
-- 
gitgitgadget
