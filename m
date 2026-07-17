Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986722749E6
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296966; cv=none; b=EPlkx7C5vsGuiIz73HS/DKtV4hs/KiepX4KC/nAQN/wNRTdDerYiENSfzZIH5oH4uny60d4O87dPTcIFVsz+zZHqhsc8+yrTfPPjcu59ZcD2yjzs2kMgEiGS9CMF8QfnmA8HiTG799Hrp3AYUZX3QLzsnetc2xgVKqWFZYFDEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296966; c=relaxed/simple;
	bh=QMLLGcJjUACOT5NkbbX3jQMLl8u9FBZHWAQ95CgntS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lb11Dfx2TxYmy8X60krnkoBR2RvA0ass3KXjJaYDf+DL1WWJTi3gjRaWfZ3YSd6hdeXKToouR9WnWGD669fMbDJmFlbu5CtFEoj5BuNbqG7xTdtMM4EPxMJpBsIunX8KqHErmjY7HD+zHu6mCWavmt4Wb0A3gSElGtBxCBe842I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsz3njXQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsz3njXQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-caf45fc5202so5187275a12.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296964; x=1784901764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r98toiZbnpzcuXHybVsgAW75dipvlZqKNrwID5L/yL4=;
        b=Lsz3njXQxlatJgYzz0e/IdG1782Ie2fzyQtYh12s9T6OUIw4l5a9TTpjpsEz8N44TD
         p+4LH5N3RjzMtkDh+qwLuolTy3Tk49qvhTijpt4b12U2FmlooAu9OhVZaxTcpHoJLffO
         Ki9+VUY5zfkxkVFRUhgnAhMAXtwoCnXSAwnkDDY5Pbakk10oKTAi4HRqH1YY7Hn9kzRa
         auA7JFHVgFEpXr7E94AV0B3Atb2iJoBpjttNzbhrJddaGQTLCgh0dSWqSiDZIY0oCSf8
         iXJT+/w69mqinpd/rCCRtAdQDZF9qvYrugLZHXGzIIcRJ2Jvazm5pxS4pp3Uz9vFXjrC
         6r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296964; x=1784901764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r98toiZbnpzcuXHybVsgAW75dipvlZqKNrwID5L/yL4=;
        b=KBMnio90KQ5mosod+Rfkmr99zHse+GQauNddsplEFueBECgdKyNF5Dmjv+QeeVO4a3
         /jfIv2EL+K3HMEvfKqe6FqYw87xxKkX98G1OyuhQxjeFrIQaWfIy2L72YxZB2BFAwy68
         HA4PmddtHnK1xyymxOIDxlQZYQBNgGXt3SlwfWI2mFNym8vLR6Pk0sTRqQZ5doYHsOXE
         QT4Ckgc3vmtU2GA+i5eX6uCrMKl6g+zd5aOohtz3vybqcs6HwUOjPDlao0MKl928pmU0
         8wsJO52AuVhnFr7ZdLq4OdaE8pLb1Y1X6WUmwbYRMuTzXsEQMnpcZBdulRYvDDIQXwsj
         wdUw==
X-Gm-Message-State: AOJu0Yx6S9Ildeo8P9NS0Kz85RBXDM46GufAfDnIfBzYMuebDCi3m/DZ
	OW4Kos+AZuLoTYjWDQH1GNPtLvgA7pv6/3Pgzr7nq+Ur4CF/38bgPC08SSSCCbRI
X-Gm-Gg: AfdE7ckt3Q+7vyZAQfsvK3+2kZ3meGM5wlXgEqYRY0yjgLA+clXIJ/Mz1osab03QcaO
	HcGEpqs9N00mHuRtHgdhj/RQz59DveXl5+Ztf2GN+HybdcVP8dkhlW85nAfbS3yNSgouBMfZ9ZZ
	WoC/v+34txfCVaYt3b71OB190gXflnp1HZE4Yy431OFhy38DngHj/6an4OD/J4Tqc9P5M1jVszq
	s4flgKaHTIJ2cNzh0g0b3bhhKYRbzO+toUlUs++LfeA/92D2fDvBifQftXGI8jkNRefcWuup4Q2
	LESMxvr6no1B0f6poDYbtwcIBHiO2l3R/iXsg3c/d0p1+F0ewH5rJ3n0EUpXTbM6ZKhZMlJmxC7
	zYhuhLN0wMBRN6muJnZlYiFaSsibfF0swfh+nnN765FqJzIb7j0jIlExqPhr+nZuk4+YAKuJKRC
	GIaMykLFe8iSqcHQMdrz5upG/HlGpuM9VHQD62ZYZOnKIxdqU=
X-Received: by 2002:a17:90b:48c4:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-38e4b51bd8fmr3032057a91.24.1784296963169;
        Fri, 17 Jul 2026 07:02:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c54:99f5:e868:2959:a4c:3254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a210571sm7886418eec.31.2026.07.17.07.02.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 07:02:42 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Scott L. Burson" <Scott@sympoiesis.com>
Subject: [PATCH] userdiff: add support for Swift
Date: Fri, 17 Jul 2026 19:32:29 +0530
Message-ID: <20260717140232.6722-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a built-in userdiff driver for the Swift programming language so that
diff hunk headers and word diffs work out of the box for ".swift" files.

The funcname pattern is built for Swift's own declaration grammar: an
optional run of attributes ("@objc", "@available(iOS 13, *)", ...),
followed by an optional run of lowercase modifiers ("public", "static",
"final", ...), followed by a declaration keyword (func, class, struct,
enum, protocol, extension, actor, init, deinit, subscript). The keyword
is followed by a boundary that allows whitespace, "(" (init/subscript),
"?" or "!" (failable init), or "<" (generics), while still acting as a
word boundary so e.g. "initialize(" does not match.

The word regex recognizes Swift identifiers, hexadecimal, octal, binary,
integer and floating-point literals, and the language's operators.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
This addresses the "add a userdiff driver for a language" microproject.
Swift is not covered by a built-in driver yet, and I did not find an
in-flight patch adding one on the list; please let me know if one exists.

Motivation: without a Swift driver, ".swift" files use the generic
funcname heuristic, so "git diff" hunk headers name the enclosing type
instead of the changed function.

The pattern is built directly from Swift's declaration grammar rather
than adapted from another language's driver, so it covers a few things
that a straight port would miss:

 - attributes, with or without arguments, whether on their own line
   ("@objc" above a "func") or inline with the declaration
   ("@objc func foo()", "@available(iOS 13, *) public func bar()");
 - modifiers ("public", "static", "override", "mutating", ...) in any
   combination, before or after attributes;
 - failable initializers, "init?" and "init!";
 - generics, "init<T>" and "subscript<T>";
 - the keyword boundary still acts as a word boundary, so e.g.
   "initialize(" is not mistaken for "init".

I verified all of the above against a built binary, including generic
functions with "where" clauses, multi-line signatures, and operator
functions such as "static func ==". I did not find a real case this
pattern misses; the ones I intentionally left out are one-line
declarations ("typealias", "associatedtype") and rarer forms
("operator", "precedencegroup", "macro"), which would not make useful
section headers anyway.

The word regex covers Swift identifiers; hexadecimal, octal, binary,
integer and floating-point literals; and operators including "<<=" /
">>=", "??" and the range operators. All of t4018 passes, including the
sorted builtin_drivers check and the new swift-* fixtures.

 Documentation/gitattributes.adoc  |  2 ++
 t/t4018/swift-actor               |  5 +++++
 t/t4018/swift-attribute-with-args |  7 +++++++
 t/t4018/swift-class               |  5 +++++
 t/t4018/swift-enum                |  5 +++++
 t/t4018/swift-extension           |  5 +++++
 t/t4018/swift-failable-init       |  7 +++++++
 t/t4018/swift-func                |  5 +++++
 t/t4018/swift-generic-subscript   |  7 +++++++
 t/t4018/swift-init                |  7 +++++++
 t/t4018/swift-inline-attribute    |  7 +++++++
 t/t4018/swift-modifiers           |  4 ++++
 t/t4018/swift-protocol            |  5 +++++
 t/t4018/swift-struct              |  5 +++++
 userdiff.c                        | 10 ++++++++++
 15 files changed, 86 insertions(+)
 create mode 100644 t/t4018/swift-actor
 create mode 100644 t/t4018/swift-attribute-with-args
 create mode 100644 t/t4018/swift-class
 create mode 100644 t/t4018/swift-enum
 create mode 100644 t/t4018/swift-extension
 create mode 100644 t/t4018/swift-failable-init
 create mode 100644 t/t4018/swift-func
 create mode 100644 t/t4018/swift-generic-subscript
 create mode 100644 t/t4018/swift-init
 create mode 100644 t/t4018/swift-inline-attribute
 create mode 100644 t/t4018/swift-modifiers
 create mode 100644 t/t4018/swift-protocol
 create mode 100644 t/t4018/swift-struct

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index bd76167a45..9fea75f96f 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -914,6 +914,8 @@ patterns are available:
 - `scheme` suitable for source code in most Lisp dialects,
   including Scheme, Emacs Lisp, Common Lisp, and Clojure.
 
+- `swift` suitable for source code in the Swift language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4018/swift-actor b/t/t4018/swift-actor
new file mode 100644
index 0000000000..e4852f40a7
--- /dev/null
+++ b/t/t4018/swift-actor
@@ -0,0 +1,5 @@
+actor RIGHT {
+    let a = 1
+    // a comment
+    let b = ChangeMe
+}
diff --git a/t/t4018/swift-attribute-with-args b/t/t4018/swift-attribute-with-args
new file mode 100644
index 0000000000..22b1ee32f1
--- /dev/null
+++ b/t/t4018/swift-attribute-with-args
@@ -0,0 +1,7 @@
+struct View {
+    @available(iOS 13, *) public func RIGHT() {
+        let a = 1
+        // a comment
+        print(ChangeMe)
+    }
+}
diff --git a/t/t4018/swift-class b/t/t4018/swift-class
new file mode 100644
index 0000000000..c3a9336027
--- /dev/null
+++ b/t/t4018/swift-class
@@ -0,0 +1,5 @@
+class RIGHT {
+    let a = 1
+    // a comment
+    let b = ChangeMe
+}
diff --git a/t/t4018/swift-enum b/t/t4018/swift-enum
new file mode 100644
index 0000000000..0a84302993
--- /dev/null
+++ b/t/t4018/swift-enum
@@ -0,0 +1,5 @@
+enum RIGHT {
+    case first
+    // a comment
+    case ChangeMe
+}
diff --git a/t/t4018/swift-extension b/t/t4018/swift-extension
new file mode 100644
index 0000000000..cbc18ab6ef
--- /dev/null
+++ b/t/t4018/swift-extension
@@ -0,0 +1,5 @@
+extension RIGHT {
+    static let a = 1
+    // a comment
+    static let b = ChangeMe
+}
diff --git a/t/t4018/swift-failable-init b/t/t4018/swift-failable-init
new file mode 100644
index 0000000000..5e4091d97c
--- /dev/null
+++ b/t/t4018/swift-failable-init
@@ -0,0 +1,7 @@
+class Bar {
+    init?(RIGHT: Int) {
+        let value = RIGHT
+        // a comment
+        print(ChangeMe)
+    }
+}
diff --git a/t/t4018/swift-func b/t/t4018/swift-func
new file mode 100644
index 0000000000..1fecae0911
--- /dev/null
+++ b/t/t4018/swift-func
@@ -0,0 +1,5 @@
+func RIGHT(x: Int) -> Int {
+    let y = x
+    // a comment
+    return ChangeMe
+}
diff --git a/t/t4018/swift-generic-subscript b/t/t4018/swift-generic-subscript
new file mode 100644
index 0000000000..565f93cd6c
--- /dev/null
+++ b/t/t4018/swift-generic-subscript
@@ -0,0 +1,7 @@
+struct Container {
+    subscript<RIGHT>(index: RIGHT) -> Int {
+        let a = 0
+        // a comment
+        return ChangeMe
+    }
+}
diff --git a/t/t4018/swift-init b/t/t4018/swift-init
new file mode 100644
index 0000000000..f683e74794
--- /dev/null
+++ b/t/t4018/swift-init
@@ -0,0 +1,7 @@
+class Foo {
+    init(RIGHT: Int) {
+        let value = RIGHT
+        // a comment
+        print(ChangeMe)
+    }
+}
diff --git a/t/t4018/swift-inline-attribute b/t/t4018/swift-inline-attribute
new file mode 100644
index 0000000000..2374c4b603
--- /dev/null
+++ b/t/t4018/swift-inline-attribute
@@ -0,0 +1,7 @@
+class Service {
+    @objc func RIGHT() {
+        let path = "/api"
+        // a comment
+        log(ChangeMe)
+    }
+}
diff --git a/t/t4018/swift-modifiers b/t/t4018/swift-modifiers
new file mode 100644
index 0000000000..9d80685a78
--- /dev/null
+++ b/t/t4018/swift-modifiers
@@ -0,0 +1,4 @@
+public static func RIGHT() -> Int {
+    // a comment
+    return ChangeMe
+}
diff --git a/t/t4018/swift-protocol b/t/t4018/swift-protocol
new file mode 100644
index 0000000000..07c39ec2a3
--- /dev/null
+++ b/t/t4018/swift-protocol
@@ -0,0 +1,5 @@
+protocol RIGHT {
+    var first: Int { get }
+    // a comment
+    var second: ChangeMe { get }
+}
diff --git a/t/t4018/swift-struct b/t/t4018/swift-struct
new file mode 100644
index 0000000000..e399ed7759
--- /dev/null
+++ b/t/t4018/swift-struct
@@ -0,0 +1,5 @@
+struct RIGHT {
+    let a = 1
+    // a comment
+    let b = ChangeMe
+}
diff --git a/userdiff.c b/userdiff.c
index b5412e6bc3..df37dd78a6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -362,6 +362,16 @@ PATTERNS("scheme",
 	 "\\|([^|\\\\]|\\\\.)*\\|"
 	 /* All other words should be delimited by spaces or parentheses. */
 	 "|([^][)(}{ \t])+"),
+PATTERNS("swift",
+	 "^[ \t]*((@[A-Za-z_][A-Za-z0-9_]*(\\([^()]*\\))?[ \t]+)*([a-z]+[ \t]+)*(func|init|deinit|subscript|class|struct|enum|protocol|extension|actor)[ \t(?!<].*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 /* hexadecimal, octal, and binary literals */
+	 "|0[xX][0-9a-fA-F_]+|0[oO][0-7_]+|0[bB][01_]+"
+	 /* integers and floating-point numbers */
+	 "|[0-9][0-9_]*([.][0-9_]+)?([eE][-+]?[0-9]+)?"
+	 /* unary and binary operators */
+	 "|[-+*/%<>=!&|^~?]=?|&&|\\|\\||<<=?|>>=?|\\?\\?|\\.\\.[.<]|->"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
 { .name = "default", .binary = -1 },
-- 
2.52.0

