Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917732B9D7
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874791; cv=none; b=kupFU73v/ceAK1ldr1WkBOxAAjSX6GPc3YdhAf5nRqhH8dkcBQJHeE/0aPYie4FzO7lvAvCam9Y5T+LbW0Y1ZKN8EbxZmSPpOuRRU8nszdfpXJ+0PDPAZ/IV8Z9WFRsBhAZpAolknYE3pxlTIOrQNlKNfvqpM52zKLEIXEA6ISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874791; c=relaxed/simple;
	bh=QK4evKLNMUm/+upXvAPjSUhsQiZ6ShBwaYJ7DnpHK9I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LtEt2/jjTFcM7TdaUxWOnVMGS0Hj/tpuBUENiyu4IjlXHuCxciKvX3sFk/ZEZWxU/+lGONgsjHeVglQUq6/94U1hBvmpbePGk5fYONDwJmL00BoT4MauMwk48yGEk86yRk6jle+Kqp9+D6BE7uxbxL9rdjXpUzZ+8S/+vVZCFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNlImRcY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNlImRcY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4151593a12.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710874788; x=1711479588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=87D945c/Bc5uOaN+knwF+kmxr1XyWlZogsnlErvX9ok=;
        b=ZNlImRcYZ9DS9WdbZkx2kZEtYUWQyfnLjcQcDbUriyhi8e8anRuv9ehUTqQbJ1d41z
         cMlOUpt9cJXS5T1SvgqeiLXqKut41vHY74XdgHiShZ2A0Kz+JV3hyNdyKiksHDiirvYX
         5Nw9rvTaV1dhPFRdca0yy3XFmP9oMrJ+sizWuQJUZCbYH+uFZ60wa+SC97B79VqHHKAN
         DNKAJatSKFJZ04PK1GCJpfiEU+9KHXnvTocqBFsq9dm+dy0S87w7hb+J49SG7iuK4ZF1
         9OUvl1N4Mib+IBRKO9dU1IokHcZhPawiqWvNNc6m1hdJ/d/KCaQzS7Qlyd1rw9L47e4P
         DCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874788; x=1711479588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87D945c/Bc5uOaN+knwF+kmxr1XyWlZogsnlErvX9ok=;
        b=pfKhIFLCQgsWwqwOT3pFQgzciFbbw9JP8Q6R2UBDPw5gG+Wwu9ENr8KtaYAf4ArBDn
         B+/NZuecbR0r8gHvx+ykZK/y4dZaLjFLOflEbkPfUs5rhMVfJ+/VTnYJwUbRN8OCwAZR
         tBHdyLgkAhjh6ZvC0sk0VDW88/2rOEUWYG7jOUPy7sMNoZVuiRbMziaOEASRclcOfhxp
         nHh024Cmy3hig01G5Vn9mspv82TqPR3qNwtGI93ZJDH+EdFTLPoKaUjCnwJeHdDxzlWu
         9qy7W6xUibhazAi7tUYd+zFSbP4fLK5pP46djoY7S8rWKeNE2FLxUwRvpuj0Rlf257Oz
         QpwA==
X-Gm-Message-State: AOJu0YxUIRVSTG+eL2IqMgyyNSJYZIS38D3dRXS5VcyOISHwK501G/eY
	+EUHjH8cc47xTEVcntcYmS6ee3Lq2SnYNX249oZa9yqpT5l4Ok5B4DpnN506eUc=
X-Google-Smtp-Source: AGHT+IFtOHdKyk3iaNo8VH2lh0AgyWQlq8maUhRLGf4X1fTzLj2P2ONHP5T9GXQnTXA2FKPt1481Mg==
X-Received: by 2002:a17:90b:a0f:b0:29a:3c70:1525 with SMTP id gg15-20020a17090b0a0f00b0029a3c701525mr10366499pjb.45.1710874788392;
        Tue, 19 Mar 2024 11:59:48 -0700 (PDT)
Received: from localhost.localdomain ([152.58.61.195])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090a5b1000b0029f349cc253sm6640024pji.54.2024.03.19.11.59.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:59:47 -0700 (PDT)
From: Utsav Parmar <utsavp0213@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC][PATCH] userdiff: add funcname regex and wordregex for typescript language
Date: Wed, 20 Mar 2024 00:29:38 +0530
Message-Id: <20240319185938.243667-1-utsavp0213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a builtin driver for typescript language supporting regex for both function name and words. Also updates the `.gitattributes.txt` to reflect this.

gitattributes: add typescript language to hunk headers support
t4034: add tests for typescript word_regex
t4018: add tests for typescript funcname regex
userdiff: add funcname regex and wordregex for typescript language

---
Index: userdiff.c
diff --git a/userdiff.c b/userdiff.c
--- a/userdiff.c	(revision 2953d95d402b6bff1a59c4712f4d46f1b9ea137f)
+++ b/userdiff.c	(revision 6724df99624834d9b7278a0bc95fa319f526a1fe)
@@ -297,6 +297,22 @@
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
Index: t/t4018/typescript-arrow-function
diff --git a/t/t4018/typescript-arrow-function b/t/t4018/typescript-arrow-function
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-arrow-function	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,4 @@
+const RIGHT = (one) => {
+    someMethodCall();
+    return ChangeMe;
+}
Index: t/t4018/typescript-class-member-function
diff --git a/t/t4018/typescript-class-member-function b/t/t4018/typescript-class-member-function
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-class-member-function	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,7 @@
+class Test {
+	var one;
+	function RIGHT(two: string) {
+		someMethodCall();
+		return ChangeMe;
+	}
+}
Index: t/t4018/typescript-enum
diff --git a/t/t4018/typescript-enum b/t/t4018/typescript-enum
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-enum	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,6 @@
+enum RIGHT {
+    ONE = 1,
+    TWO,
+    THREE,
+    ChangeMe
+}
Index: t/t4018/typescript-function
diff --git a/t/t4018/typescript-function b/t/t4018/typescript-function
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-function	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,4 @@
+function RIGHT<Type implements AnotherType>(one: number): Type {
+    someMethodCall();
+    return ChangeMe;
+}
Index: t/t4018/typescript-function-assignment
diff --git a/t/t4018/typescript-function-assignment b/t/t4018/typescript-function-assignment
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-function-assignment	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,4 @@
+const RIGHT = function(one: number): Type {
+    someMethodCall();
+    return ChangeMe;
+}
Index: t/t4018/typescript-interface
diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-interface	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,4 @@
+interface RIGHT {
+  one?: string;
+  [propName: ChangeMe]: any;
+}
\ No newline at end of file
Index: t/t4018/typescript-type
diff --git a/t/t4018/typescript-type b/t/t4018/typescript-type
new file mode 100644
--- /dev/null	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4018/typescript-type	(revision b60d253ea78063d444f7131c3100388a7cdac060)
@@ -0,0 +1,4 @@
+type RIGHT = {
+  one: number,
+  ChangeMe: CustomType
+}
\ No newline at end of file
Index: t/t4034-diff-words.sh
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
--- a/t/t4034-diff-words.sh	(revision b60d253ea78063d444f7131c3100388a7cdac060)
+++ b/t/t4034-diff-words.sh	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
@@ -338,6 +338,7 @@
 test_language_driver ruby
 test_language_driver scheme
 test_language_driver tex
+test_language_driver typescript
 
 test_expect_success 'word-diff with diff.sbe' '
 	cat >pre <<-\EOF &&
Index: t/t4034/typescript/expect
diff --git a/t/t4034/typescript/expect b/t/t4034/typescript/expect
new file mode 100644
--- /dev/null	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
+++ b/t/t4034/typescript/expect	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
@@ -0,0 +1,57 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index e4a51a2..9c56465 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,16 +1,16 @@<RESET>
+log("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>) u<RESET>'<RED>x<RESET><GREEN>y<RESET>'
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>&<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>^<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>|<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>&&<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>||<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b
+<RESET>
+<RED>a<RESET><GREEN>y
+<RESET>
+<GREEN>x<RESET>,y
Index: t/t4034/typescript/post
diff --git a/t/t4034/typescript/post b/t/t4034/typescript/post
new file mode 100644
--- /dev/null	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
+++ b/t/t4034/typescript/post	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
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
Index: t/t4034/typescript/pre
diff --git a/t/t4034/typescript/pre b/t/t4034/typescript/pre
new file mode 100644
--- /dev/null	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
+++ b/t/t4034/typescript/pre	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
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
Index: Documentation/gitattributes.txt
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
--- a/Documentation/gitattributes.txt	(revision be6b88ac5ca33921af60ee42f71397011efb1806)
+++ b/Documentation/gitattributes.txt	(revision 2891f81b087a3f1c89d1417c40ba576aaa30feb9)
@@ -902,6 +902,8 @@
 
 - `tex` suitable for source code for LaTeX documents.
 
+- `typescript` suitable for source code for TypeScript language.
+
 
 Customizing word diff
 ^^^^^^^^^^^^^^^^^^^^^
