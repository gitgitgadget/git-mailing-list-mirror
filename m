Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F4419314
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617068; cv=none; b=j4KOFIaicPTAEZUoVXceHg/gJHbHOSdIhoWR0J1o+DpSxasOuaFtt1Udx7h4pg4487hujSyGTSVW1GxV5tTC8Qn/VQ+U+E4xGQbYN3i9e0LJ24ROn+X7umki6erLPHEijp+19BTlylcropvEXnDMOm6EgV5/6pUtAiiw68pUSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617068; c=relaxed/simple;
	bh=Odx/zPTiUpoGX3sxGDTrChyHhtN8OPlWfEmni2cdN8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETSq8HQxAyGM7eNnVil0odcSRDVyU6vjdjcXNJbvlR2i+lRWilKNIS7mjheg6BCrP1fZUPh6HtvjhgNZw8QYarllt6kmnco8y/MlyTgDsNnr1nYCFe61YClTFm7Mcrl56giVxAMGh6ZK5ouqHpZLHy+SN1w33ti2SA81HeayGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P64h3FLZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P64h3FLZ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so4944675a12.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784617066; x=1785221866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZISyztD4rKg8EfBDpcd2pJ2nPHVvKz65gVj7I81hcTM=;
        b=P64h3FLZZzyE0DX4TNfDHreNLmzJ+ZTAHtdjcE7GzoMvKJP5HqbzDotvFOQH/RQ2a9
         A0W3FJif44CYGKcEZjT8UI95mVEJWJ/3SH5TMsLcivMOhcC3LaWGY348nxi2L65ynjDN
         FQXLvYBel6PDxyMutuYjjw3cvO+4IY+cC6HxbDn+z7zdOvHTIn/5pAEnHmweE5wq9PwV
         bT1pSRGuUSD6UPpqwdG86zBvA/0hj8DRdfug5bQrLxwCjVIlSXdZ7XT73OkS66lSG0le
         P+lGsB42opn6aY2Nrni4JXchGn9YlBCcosf314P7lKB3k+A2NI15oveXG1sXcZMj915h
         IW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784617066; x=1785221866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZISyztD4rKg8EfBDpcd2pJ2nPHVvKz65gVj7I81hcTM=;
        b=hN7/H++90D8YdS2fzNlTL1CAybJv0dGEtLu19N+OYOzS3Y6op/qf7rI62fLfBj9tMF
         nH6hFxTG+7cTEb6Dn1a/wda3Bv10gJ31dRFTe5OLbNS0FxfSl5kklCZ4tsg4rPGSnXs7
         pLI19m8XGxJ0eyA/nfGrVB5VPwqbtr9XjiyR2SpZryB4pwaoBOVvM7Ec2jVnonCyHeLD
         PnaBsGA5RdWfyv/cCJRbQRg3UA9WRbwMKaONw60ayaFvnJIj0UoNCcu6WixJ0VmiPIOs
         1iUZhIl61q+DkYsnEbCgilsUjhjotU3+lUwgYHT9MsfH7JwmD/Kg8wJfwK8BlGavu+Zr
         kbBA==
X-Gm-Message-State: AOJu0YxHr4Wt3JsIYuOKUzKU8tqbaO90tBRdEL2oKniAlF3EK0/qd53q
	vrQmzm8fOE/t50bTgM21H58UfdqCeEmHXEmCZiTelhOwUPMvJHquSiwvj31f/GP6
X-Gm-Gg: AfdE7cnfKW4lxlZcnw/FTZ2RUGvh5009/DPumwkwxHevUlGuyoIGUN94Io3JVPWnRpt
	EE8uuJANM7mIHT0RxlWe+ie7NF04DpMzJ12L637x7ts397YVE5L0RYIUUtVXDzUHUe6kocsthMj
	fdNTgEgymMi9Gln1nXCytw6AGOolm9UsPF64pKmExgymgknOIe16kXYs1RNccQRmt/G5f6Celsh
	evtb6w6mI1S/rqRiHZ2yvwRwUqqd1S5uyTTbJq2ACi1YK6nyMGSUq/shF3HZED9xEqKZVzkomFQ
	3L5gvm7nrMuLh1hTaYy8yRaSEUZXVi31wvsKCkHtMcQYA0Qy7g8Uc3Jn9yZDLJFPl7kkYVPNB7t
	jjleLNkvmsLUb0rW2TEPGgqvWRMKt74PLSw7pzQhr1llNCtVn2bHE4E1m/7Y0BHxF9U3loZw9I9
	8/7A/0aPhE8ypEJeX3hZDjQ/iIRe0k9flwjsdffw==
X-Received: by 2002:a05:6a21:9147:b0:3bf:6c07:b2f7 with SMTP id adf61e73a8af0-3c3ad9e3ddemr18793381637.58.1784617065924;
        Mon, 20 Jul 2026 23:57:45 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:81e8:b680:e55f:5528:5bee:bb02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe1014sm43323339eec.7.2026.07.20.23.57.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 23:57:45 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Scott L . Burson" <Scott@sympoiesis.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2] userdiff: add support for Swift
Date: Tue, 21 Jul 2026 12:27:36 +0530
Message-ID: <20260721065736.8747-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717140232.6722-1-diy2903@gmail.com>
References: <20260717140232.6722-1-diy2903@gmail.com>
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
v2, addressing Johannes Sixt's review of v1
(<2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>).  Changes since v1:

 - t4018/swift-{init,failable-init,generic-subscript}: "RIGHT" now
   appears only once, on the declaration line, so the expected header is
   unambiguous.
 - word regex: dropped the redundant "?" after the single-character
   operator class.  Single characters are already covered by the
   "|[^[:space:]]" fallback that the PATTERNS macro appends, so only the
   two-character forms need to be spelled out.

(A couple of Hannes's other suggestions I kept as-is; I have explained
the reasoning in a reply to his review.)

Some coverage evidence beyond the t4018 fixtures:

 - Grammar: a test over every declaration form in Swift's grammar
   summary (26 forms -- func/class/struct/enum/protocol/extension/actor,
   init incl. "init?"/"init!"/generic, deinit, subscript incl. generic,
   operator methods, stacked modifiers, inline attributes with and
   without arguments, "where" clauses, multi-line signatures) -- all 26
   resolve to the correct declaration.

 - Corpus: run over the last 200 commits touching *.swift in seven
   stylistically different projects (Alamofire, apple/
   swift-argument-parser, vapor, Kingfisher, RxSwift, SnapKit,
   pointfreeco/swift-composable-architecture): of 20454 hunks, 15310
   produced a header and 15296 (99.9%) named a real declaration.  The
   empty-header hunks are changes with no enclosing declaration (file
   comment blocks, imports, Package.swift, top-level code); sampling
   found no change inside a declaration that failed to get a header.
   The handful of non-declaration headers are the selective-import form
   ("import class Foundation.Bundle"), which reads "import" as a
   modifier; rare and low-harm, and I can exclude it in a follow-up if
   preferred.

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
index 0000000000..4bbd6217c9
--- /dev/null
+++ b/t/t4018/swift-failable-init
@@ -0,0 +1,7 @@
+class Bar {
+    init?(RIGHT: Int) {
+        let x = 0
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
index 0000000000..423cb58941
--- /dev/null
+++ b/t/t4018/swift-generic-subscript
@@ -0,0 +1,7 @@
+struct Container {
+    subscript<RIGHT>(index: Int) -> Int {
+        let a = 0
+        // a comment
+        return ChangeMe
+    }
+}
diff --git a/t/t4018/swift-init b/t/t4018/swift-init
new file mode 100644
index 0000000000..dc7a298f38
--- /dev/null
+++ b/t/t4018/swift-init
@@ -0,0 +1,7 @@
+class Foo {
+    init(RIGHT: Int) {
+        let x = 0
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
index b5412e6bc3..7129bf1482 100644
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
+	 "|[-+*/%<>=!&|^~?]=|&&|\\|\\||<<=?|>>=?|\\?\\?|\\.\\.[.<]|->"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
 { .name = "default", .binary = -1 },

Range-diff against v1:
1:  1e7e199355 ! 1:  af48611565 userdiff: add support for Swift
    @@ t/t4018/swift-failable-init (new)
     @@
     +class Bar {
     +    init?(RIGHT: Int) {
    -+        let value = RIGHT
    ++        let x = 0
     +        // a comment
     +        print(ChangeMe)
     +    }
    @@ t/t4018/swift-func (new)
      ## t/t4018/swift-generic-subscript (new) ##
     @@
     +struct Container {
    -+    subscript<RIGHT>(index: RIGHT) -> Int {
    ++    subscript<RIGHT>(index: Int) -> Int {
     +        let a = 0
     +        // a comment
     +        return ChangeMe
    @@ t/t4018/swift-init (new)
     @@
     +class Foo {
     +    init(RIGHT: Int) {
    -+        let value = RIGHT
    ++        let x = 0
     +        // a comment
     +        print(ChangeMe)
     +    }
    @@ userdiff.c: PATTERNS("scheme",
     +	 /* integers and floating-point numbers */
     +	 "|[0-9][0-9_]*([.][0-9_]+)?([eE][-+]?[0-9]+)?"
     +	 /* unary and binary operators */
    -+	 "|[-+*/%<>=!&|^~?]=?|&&|\\|\\||<<=?|>>=?|\\?\\?|\\.\\.[.<]|->"),
    ++	 "|[-+*/%<>=!&|^~?]=|&&|\\|\\||<<=?|>>=?|\\?\\?|\\.\\.[.<]|->"),
      PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
      	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
      { .name = "default", .binary = -1 },
-- 
2.52.0

