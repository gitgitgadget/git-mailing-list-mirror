Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F951841
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302289; cv=none; b=lUmeGkIPqyH9wpdhWyDMKLpIV1JM+VT0oRmLmWIVRFEW/1CywSfVTiETpVg/aB5lTY3cLSvcZ7YPA6bnDZ8K7sTiUaBblOXfhlfgXwgcx9eX9eX4lLiGbCUhHAXSnOYRXZan1b0R+ZQh3jGvePagdciodGAZSCx254lJXUi6wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302289; c=relaxed/simple;
	bh=H5YNtz+7RfIYb1y+yBqnD/SDxQ/6Kv9EPikVLX48RUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXLP6T4USPSjNgHQZTlfSQUMHHU7MkM03jbUuamQ5+mCl7ZtXS7Db9yWKlbh4H97rv53L9jPyAEtHDoo1Ma5Y5lfoGm5dIM3YlGJvqmZ7n8vsGdKYV8w8UU9lFyqAPjX61G9wQZcxT8u0ysHsqgJ7pToIRi0LBB5CuxDv19I4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbBrTV25; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbBrTV25"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2469511a12.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711302287; x=1711907087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYQCqSwfnOp5hEM8NimNszvKrf7MoG2kvGBCrOWa6CI=;
        b=JbBrTV25V1tjVJeaWuOG8Zub8CaLOrkMDfCKXqlcUsis58/Mv+KOqPs9cua89+EjxS
         3uzVSi71LtjC3n4heIsajZjA3Sny2i8DecAreaKAvCwA7wUSz9CYJ+Grc9eE+OyokEa9
         Ua/WITA98eZg5Isp3lNHZiRbvlPxtg1tgUftmTiD56cplt5aQhzhH1R8MKawRKvEZvt5
         F/cX/jvas7dnLsmV8Letsdk8jxJFCPuhwrVMQAlTUPKZOHq+q0bPuxbanljBR5IkZ0K2
         sdzvHA0RSpMTjSA7jhEAxjdflibaACF0cUMA+cE1XbTBPFp/FNN9OyDXllsTmppiAv1S
         0J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711302287; x=1711907087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYQCqSwfnOp5hEM8NimNszvKrf7MoG2kvGBCrOWa6CI=;
        b=LK4/cmrvn23cxLXbBKY7cC11iOlQDjSiUF432NGkvzcfxhCFZNdn6CUwk+apzROz3p
         msVQ4r4HT1bJbJr6oe3RAMeOr0xlweRy+/biuNPZsbWK4HVFVE9E3OHhnrnoYfhXpU6E
         ucVsAkYVcvxv0S1KfbZse+2ZaCxAthSyKBP8RQ0H/Kl41IJ5swFSJTXIyjBypqy98UFp
         gVwv1e9rwPQokJPlWZnbhbNr5YZl2ixcAJ88CU7oIxn79UAcxTd3Cql3CIZ3LqpsRCln
         LSWqXZl6N3KuD3Leh2QgdzMeg0mb4eV6GMhwiH5KehAa7ghl6XyqE7h4BfSf5bYJ8wLD
         cxCQ==
X-Gm-Message-State: AOJu0YwO3zGAFA4B7yXm+TvQSbRIJn8IxM90x3QVmmKcaGoi2qbHQalv
	ZGoLnD8W9CsQr3lOC/D22GA9CR7GTHAAF/CPQHoLYZ8maS73Pkm82J04lk0v
X-Google-Smtp-Source: AGHT+IGtusbzzXOkKp/rFaeB9/Ysa5gA4IRuAO8MpSdEvTrH6LHh3tvtGpwQ8yVxROrZrL2ou7wOGA==
X-Received: by 2002:a17:902:da87:b0:1e0:b287:c1d8 with SMTP id j7-20020a170902da8700b001e0b287c1d8mr3756415plx.5.1711302286514;
        Sun, 24 Mar 2024 10:44:46 -0700 (PDT)
Received: from localhost.localdomain ([152.58.35.104])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001e0410bfccasm3294369pll.126.2024.03.24.10.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 10:44:46 -0700 (PDT)
From: Utsav Parmar <utsavp0213@gmail.com>
To: utsavp0213@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH] userdiff: add builtin driver for typescript language
Date: Sun, 24 Mar 2024 23:14:23 +0530
Message-Id: <20240324174423.55508-1-utsavp0213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319185938.243667-1-utsavp0213@gmail.com>
References: <20240319185938.243667-1-utsavp0213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no implementation or test changes in this patch. It simply relies on the git formatting rather than the IDE git UI formatting that I believe messed up in the parent email.

Signed-off-by: Utsav Parmar <utsavp0213@gmail.com>
---
 Documentation/gitattributes.txt          |  2 ++
 t/t4018/typescript-arrow-function        |  4 +++
 t/t4018/typescript-class-member-function |  7 +++++
 t/t4018/typescript-enum                  |  6 +++++
 t/t4018/typescript-function              |  4 +++
 t/t4018/typescript-function-assignment   |  4 +++
 t/t4018/typescript-interface             |  4 +++
 t/t4018/typescript-type                  |  4 +++
 t/t4034-diff-words.sh                    |  1 +
 t/t4034/typescript/expect                | 33 ++++++++++++++++++++++++
 t/t4034/typescript/post                  | 16 ++++++++++++
 t/t4034/typescript/pre                   | 16 ++++++++++++
 userdiff.c                               | 16 ++++++++++++
 13 files changed, 117 insertions(+)
 create mode 100644 t/t4018/typescript-arrow-function
 create mode 100644 t/t4018/typescript-class-member-function
 create mode 100644 t/t4018/typescript-enum
 create mode 100644 t/t4018/typescript-function
 create mode 100644 t/t4018/typescript-function-assignment
 create mode 100644 t/t4018/typescript-interface
 create mode 100644 t/t4018/typescript-type
 create mode 100644 t/t4034/typescript/expect
 create mode 100644 t/t4034/typescript/post
 create mode 100644 t/t4034/typescript/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4338d023d9..4461c41054 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -902,6 +902,8 @@ patterns are available:
 
 - `tex` suitable for source code for LaTeX documents.
 
+- `typescript` suitable for source code for TypeScript language.
+
 
 Customizing word diff
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/t/t4018/typescript-arrow-function b/t/t4018/typescript-arrow-function
new file mode 100644
index 0000000000..85a3d9cd6b
--- /dev/null
+++ b/t/t4018/typescript-arrow-function
@@ -0,0 +1,4 @@
+const RIGHT = (one) => {
+    someMethodCall();
+    return ChangeMe;
+}
diff --git a/t/t4018/typescript-class-member-function b/t/t4018/typescript-class-member-function
new file mode 100644
index 0000000000..f34b0a2bac
--- /dev/null
+++ b/t/t4018/typescript-class-member-function
@@ -0,0 +1,7 @@
+class Test {
+	var one;
+	function RIGHT(two: string) {
+		someMethodCall();
+		return ChangeMe;
+	}
+}
diff --git a/t/t4018/typescript-enum b/t/t4018/typescript-enum
new file mode 100644
index 0000000000..8c045a45ec
--- /dev/null
+++ b/t/t4018/typescript-enum
@@ -0,0 +1,6 @@
+enum RIGHT {
+    ONE = 1,
+    TWO,
+    THREE,
+    ChangeMe
+}
diff --git a/t/t4018/typescript-function b/t/t4018/typescript-function
new file mode 100644
index 0000000000..62cf63f669
--- /dev/null
+++ b/t/t4018/typescript-function
@@ -0,0 +1,4 @@
+function RIGHT<Type implements AnotherType>(one: number): Type {
+    someMethodCall();
+    return ChangeMe;
+}
diff --git a/t/t4018/typescript-function-assignment b/t/t4018/typescript-function-assignment
new file mode 100644
index 0000000000..49c528713e
--- /dev/null
+++ b/t/t4018/typescript-function-assignment
@@ -0,0 +1,4 @@
+const RIGHT = function(one: number): Type {
+    someMethodCall();
+    return ChangeMe;
+}
diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
new file mode 100644
index 0000000000..6f3665c2af
--- /dev/null
+++ b/t/t4018/typescript-interface
@@ -0,0 +1,4 @@
+interface RIGHT {
+  one?: string;
+  [propName: ChangeMe]: any;
+}
\ No newline at end of file
diff --git a/t/t4018/typescript-type b/t/t4018/typescript-type
new file mode 100644
index 0000000000..e1bb2d8371
--- /dev/null
+++ b/t/t4018/typescript-type
@@ -0,0 +1,4 @@
+type RIGHT = {
+  one: number,
+  ChangeMe: CustomType
+}
\ No newline at end of file
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..4e3cf415c2 100755
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
index 0000000000..19605fec4d
--- /dev/null
+++ b/t/t4034/typescript/expect
@@ -0,0 +1,33 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index e4a51a2..9c56465 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,16 +1,16 @@<RESET>
+log("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>) u<RESET>'<RED>x<RESET><GREEN>y<RESET>'
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>&<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>^<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>|<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>&&<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>||<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/typescript/post b/t/t4034/typescript/post
new file mode 100644
index 0000000000..b1b03a7666
--- /dev/null
+++ b/t/t4034/typescript/post
@@ -0,0 +1,16 @@
+log("Hello World?")
+(1) (-1e10) (0xabcdef) u'y'
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
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
index 0000000000..13a0b2138c
--- /dev/null
+++ b/t/t4034/typescript/pre
@@ -0,0 +1,16 @@
+log("Hello World!\n")
+1 -1e10 0xabcdef 'x'
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
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
index 92ef649c99..dbb5d7c072 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -297,6 +297,22 @@ PATTERNS("scheme",
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
+PATTERNS("typescript",
+         "^[ \t]*((enum|interface|type)[ \t]+([a-zA-Z][a-zA-Z0-9]*)+.*)$\n"
+         /* Method definitions */
+         "^[ \t]*[a-z]+[ \t]+([A-Za-z_][A-Za-z_0-9]*)+([ \t]*=[ \t]*(function)?)?([ \t]*[A-Za-z_<>&][?&<>|.,A-Za-z_]*[ \t]*)*[ \t]*\\([^;]*$",
+         /* -- */
+         "[a-zA-Z_][a-zA-Z0-9_]*"
+         /* Integers and floats */
+         "|[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?"
+         /* Binary */
+         "|0[bB][01]+"
+         /* Hexadecimals */
+         "|0[xX][0-9a-fA-F]+"
+         /* Floats starting with a decimal point */
+         "|[-+]?([0-9]*\\.?[0-9]+|[0-9]+\\.?[0-9]*)([eE][-+]?[0-9]+)?"
+         /* Operators */
+         "[-+*/%&|^!=<>]=?|===|!==|<<=?|>>=?|&&|\\|\\||\\?\\?|\\+\\+|--|~"),
 { "default", NULL, NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
2.34.1

