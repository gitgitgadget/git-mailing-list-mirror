Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0591C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiCDNKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiCDNJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:09:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3E1B45CF
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:08:59 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t187so3212477pgb.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7U+tkTko6hIrekc37uGzYWPT4LYUml7HX9+uJ+ns+98=;
        b=P2UxLIvW+42sd8nZ+Qq7ADOU9RKeggF/N1GaOnofAoy/jgKFF+25MHPtHdhZevTIxG
         z3fiDLKnHb5833XLF0x8kOKgwD7nRpvcFlnnY9M2eWcl4wM5B50rLPaKEQfP6YRbzO4w
         MH0UJI9esrVa4/4kY3m2CRKpn9IWFgLf/2olD2imZG2L3B26imEBx5GIt9sDyKHtaSJz
         P2mrIg749fMdA/5PjKlXDPYdiUVHj+J2/k7x5OcKIVqSfLyKcUtB3RP8sw2ohIIuYYzO
         ZgmKyP5rJeqzCeRLOLELtjWKxLhO0vJgrcHqT1QNAmukQfxapCnpIa9wEhErJeh/Sz7T
         aAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7U+tkTko6hIrekc37uGzYWPT4LYUml7HX9+uJ+ns+98=;
        b=yqYRnV9P3PfjR8Ty5iDFQ/3+RzFcHHDVpcID5Exnyd01YKiJHy/FNK8ArEVNS9BoDC
         l55BJyeADfvoM0Ot+kwAkRRsDD0LwWmib9yQAAvoQwmVwdk5zTfcUdqQa7DBB+gaczUl
         DWg8+i3Gb/q2V0o8pebF/DZk9xPsv21XbmVCZ8ggRiOWkHMYt3jIsvKdwuBxCe5JNHSi
         3F+EDpiyyn8ElBEfdYG3EOA7A+2yS9LOd5AUmsQZmvWLUWWglBZeFP/57PXTJnQGo3go
         feh+veIw67J8b1xOuKqolv/OqXV4J6EH8cJEbWiuaArNAKTvyIb5Se4/HSlkAIhHxLkQ
         qj1A==
X-Gm-Message-State: AOAM532PT34Mx9XKY6CzK2s+LZ8iXO1JpDcCu9fSthykcZecut2lKylz
        Z/wz6WVD5XpCtrlKjkWoSmLjDfV7wLxjLA==
X-Google-Smtp-Source: ABdhPJwFMM/Iy4rBxUsnE0SBPJilbEXMIHNfOE92InT12S7bv25T6GMUvH2qlwzU+mXRdzjXS9DolA==
X-Received: by 2002:a63:445c:0:b0:375:9c0c:c360 with SMTP id t28-20020a63445c000000b003759c0cc360mr32675292pgk.588.1646399338281;
        Fri, 04 Mar 2022 05:08:58 -0800 (PST)
Received: from ubuntu.localdomain ([140.115.59.167])
        by smtp.gmail.com with ESMTPSA id nm14-20020a17090b19ce00b001bf2404fd9dsm2205891pjb.31.2022.03.04.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:08:57 -0800 (PST)
From:   xing zhi jiang <a97410985new@gmail.com>
To:     git@vger.kernel.org
Cc:     a97410985new@gmail.com
Subject: [GSoC][PATCH 1/1] Add a diff driver for JavaScript languages.
Date:   Fri,  4 Mar 2022 05:08:54 -0800
Message-Id: <20220304130854.857746-2-a97410985new@gmail.com>
X-Mailer: git-send-email 2.35.1.273.ge6ebfd0e8c.dirty
In-Reply-To: <20220304130854.857746-1-a97410985new@gmail.com>
References: <20220304130854.857746-1-a97410985new@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the xfunction part that matches normal functions,
a variable declaration with an assignment of function, the function declaration
in the class, and also the function is object literal's property.

And in the word regex part, that matches numbers, punctuations, and also the
JavaScript identifier.
This part heavily references the formal ECMA sepcification[1].

[1]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar

Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
---
 .gitignore                                    |  1 +
 Documentation/gitattributes.txt               |  2 +
 ...avascript-assignment-of-anonymous-function |  4 ++
 .../javascript-assignment-of-arrow-function   |  4 ++
 .../javascript-assignment-of-named-function   |  4 ++
 t/t4018/javascript-async-function             |  4 ++
 t/t4018/javascript-export-async-function      |  4 ++
 t/t4018/javascript-export-function            |  4 ++
 t/t4018/javascript-exports-anomyous-function  |  4 ++
 .../javascript-exports-anomyous-function-2    |  4 ++
 t/t4018/javascript-exports-function           |  4 ++
 t/t4018/javascript-function                   |  4 ++
 t/t4018/javascript-function-2                 | 10 ++++
 t/t4018/javascript-function-belong-to-IIFE    |  6 +++
 t/t4018/javascript-function-in-class          |  6 +++
 t/t4018/javascript-function-in-class-2        | 11 ++++
 t/t4018/javascript-function-in-object-literal |  7 +++
 t/t4018/javascript-generator-function         |  4 ++
 t/t4018/javascript-generator-function-2       |  4 ++
 t/t4018/javascript-getter-function-in-class   |  6 +++
 t/t4018/javascript-setter-function-in-class   |  6 +++
 .../javascript-skip-function-call-statement   |  7 +++
 t/t4018/javascript-skip-keywords              | 34 ++++++++++++
 t/t4018/javascript-static-function-in-class   |  6 +++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/javascript/expect                     | 52 +++++++++++++++++++
 t/t4034/javascript/post                       | 32 ++++++++++++
 t/t4034/javascript/pre                        | 32 ++++++++++++
 userdiff.c                                    | 38 ++++++++++++++
 29 files changed, 305 insertions(+)
 create mode 100644 t/t4018/javascript-assignment-of-anonymous-function
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function
 create mode 100644 t/t4018/javascript-assignment-of-named-function
 create mode 100644 t/t4018/javascript-async-function
 create mode 100644 t/t4018/javascript-export-async-function
 create mode 100644 t/t4018/javascript-export-function
 create mode 100644 t/t4018/javascript-exports-anomyous-function
 create mode 100644 t/t4018/javascript-exports-anomyous-function-2
 create mode 100644 t/t4018/javascript-exports-function
 create mode 100644 t/t4018/javascript-function
 create mode 100644 t/t4018/javascript-function-2
 create mode 100644 t/t4018/javascript-function-belong-to-IIFE
 create mode 100644 t/t4018/javascript-function-in-class
 create mode 100644 t/t4018/javascript-function-in-class-2
 create mode 100644 t/t4018/javascript-function-in-object-literal
 create mode 100644 t/t4018/javascript-generator-function
 create mode 100644 t/t4018/javascript-generator-function-2
 create mode 100644 t/t4018/javascript-getter-function-in-class
 create mode 100644 t/t4018/javascript-setter-function-in-class
 create mode 100644 t/t4018/javascript-skip-function-call-statement
 create mode 100644 t/t4018/javascript-skip-keywords
 create mode 100644 t/t4018/javascript-static-function-in-class
 create mode 100644 t/t4034/javascript/expect
 create mode 100644 t/t4034/javascript/post
 create mode 100644 t/t4034/javascript/pre

diff --git a/.gitignore b/.gitignore
index f817c509ec..de628c53f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -244,3 +244,4 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/.cache
\ No newline at end of file
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 60984a4682..f6554a4651 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -828,6 +828,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `javascript suitable for source code in the JavaScript language.
+
 - `markdown` suitable for Markdown documents.
 
 - `matlab` suitable for source code in the MATLAB and Octave languages.
diff --git a/t/t4018/javascript-assignment-of-anonymous-function b/t/t4018/javascript-assignment-of-anonymous-function
new file mode 100644
index 0000000000..5d4701e84c
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-anonymous-function
@@ -0,0 +1,4 @@
+const RIGHT = function (a, b) {
+	
+    return a + b; // ChangeMe
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-assignment-of-arrow-function b/t/t4018/javascript-assignment-of-arrow-function
new file mode 100644
index 0000000000..6ab73ccb7a
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function
@@ -0,0 +1,4 @@
+const RIGHT = (a, b) => {
+	
+    return a + b; // ChangeMe
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-assignment-of-named-function b/t/t4018/javascript-assignment-of-named-function
new file mode 100644
index 0000000000..85d43123a6
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-named-function
@@ -0,0 +1,4 @@
+const RIGHT = function test (a, b) {
+	
+    return a + b; // ChangeMe
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
new file mode 100644
index 0000000000..ebc7c8c05b
--- /dev/null
+++ b/t/t4018/javascript-async-function
@@ -0,0 +1,4 @@
+async function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascript-export-async-function
new file mode 100644
index 0000000000..3cd60b7980
--- /dev/null
+++ b/t/t4018/javascript-export-async-function
@@ -0,0 +1,4 @@
+export async function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-export-function
new file mode 100644
index 0000000000..177ddec779
--- /dev/null
+++ b/t/t4018/javascript-export-function
@@ -0,0 +1,4 @@
+export function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-exports-anomyous-function b/t/t4018/javascript-exports-anomyous-function
new file mode 100644
index 0000000000..45b0ecd659
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function
@@ -0,0 +1,4 @@
+exports.setFlagged = RIGHT => {
+	
+    return ChangeMe;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-exports-anomyous-function-2 b/t/t4018/javascript-exports-anomyous-function-2
new file mode 100644
index 0000000000..0c572bfde3
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function-2
@@ -0,0 +1,4 @@
+exports.RIGHT = (a, b, runtime) => {
+	
+    return ChangeMe;
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
new file mode 100644
index 0000000000..f1587fddac
--- /dev/null
+++ b/t/t4018/javascript-exports-function
@@ -0,0 +1,4 @@
+exports.RIGHT = function(document) {
+    
+    return ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
new file mode 100644
index 0000000000..dd8ab54c9b
--- /dev/null
+++ b/t/t4018/javascript-function
@@ -0,0 +1,4 @@
+function RIGHT(a, b) {
+
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-function-2 b/t/t4018/javascript-function-2
new file mode 100644
index 0000000000..d72063cdf0
--- /dev/null
+++ b/t/t4018/javascript-function-2
@@ -0,0 +1,10 @@
+function test(a, b) {
+  return {
+			RIGHT: function () {
+				currentUpdateRemovedChunks.forEach(function (chunkId) {
+					delete $installedChunks$[chunkId];
+				});
+				currentUpdateRemovedChunks = ChangeMe;
+   }
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-function-belong-to-IIFE b/t/t4018/javascript-function-belong-to-IIFE
new file mode 100644
index 0000000000..6a80118e8a
--- /dev/null
+++ b/t/t4018/javascript-function-belong-to-IIFE
@@ -0,0 +1,6 @@
+(function () {
+  this.$RIGHT = function (needle, modifier) {
+      let a = 5;
+      return ChangeMe;
+  };
+}).call(aaaa.prototype);
\ No newline at end of file
diff --git a/t/t4018/javascript-function-in-class b/t/t4018/javascript-function-in-class
new file mode 100644
index 0000000000..4b2f9c37e0
--- /dev/null
+++ b/t/t4018/javascript-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascript-function-in-class-2
new file mode 100644
index 0000000000..402c4aecc3
--- /dev/null
+++ b/t/t4018/javascript-function-in-class-2
@@ -0,0 +1,11 @@
+class Test {
+  RIGHT(
+      aaaaaaaaaa,
+      bbbbbbbbbb,
+      cccccccccc,
+      dddddddddd
+  ) {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-function-in-object-literal b/t/t4018/javascript-function-in-object-literal
new file mode 100644
index 0000000000..37f7ef72ee
--- /dev/null
+++ b/t/t4018/javascript-function-in-object-literal
@@ -0,0 +1,7 @@
+const obj = {
+    RIGHT: function (elems, callback, arg) {
+        var length, value;
+        // ...
+        return ChangeMe
+    }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
new file mode 100644
index 0000000000..caf0b9f04f
--- /dev/null
+++ b/t/t4018/javascript-generator-function
@@ -0,0 +1,4 @@
+function* RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
new file mode 100644
index 0000000000..6fc3b74a0d
--- /dev/null
+++ b/t/t4018/javascript-generator-function-2
@@ -0,0 +1,4 @@
+function *RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-getter-function-in-class b/t/t4018/javascript-getter-function-in-class
new file mode 100644
index 0000000000..0159541be7
--- /dev/null
+++ b/t/t4018/javascript-getter-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  get RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-setter-function-in-class b/t/t4018/javascript-setter-function-in-class
new file mode 100644
index 0000000000..3e17f47aa2
--- /dev/null
+++ b/t/t4018/javascript-setter-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  set RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-skip-function-call-statement b/t/t4018/javascript-skip-function-call-statement
new file mode 100644
index 0000000000..84b51514d2
--- /dev/null
+++ b/t/t4018/javascript-skip-function-call-statement
@@ -0,0 +1,7 @@
+class Test {
+  static RIGHT() {
+    haha();
+    haha2()
+    let b = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-skip-keywords b/t/t4018/javascript-skip-keywords
new file mode 100644
index 0000000000..1ed56c08de
--- /dev/null
+++ b/t/t4018/javascript-skip-keywords
@@ -0,0 +1,34 @@
+function RIGHT(a, b) {
+  import("./async1")
+  if (a > 1) {
+    // ...
+  }
+  do {
+    // ...
+  } while (i < 5);
+  for (const element of array1) {
+    console.log(element)
+  }
+  with(o) {
+    console.log(x)
+  }
+  switch (expr) {
+    case 'a':
+      // ...
+      break;
+    case 'b':
+      // ...
+      break;
+    default:
+      // ...
+  }
+  try {
+    // ...
+    return (a + c)
+  } 
+  catch (error) {
+    // ...
+  }
+
+  return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-static-function-in-class b/t/t4018/javascript-static-function-in-class
new file mode 100644
index 0000000000..efbccaf113
--- /dev/null
+++ b/t/t4018/javascript-static-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  static RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
\ No newline at end of file
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index d5abcf4b4c..33073edeca 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -324,6 +324,7 @@ test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver javascript
 test_language_driver matlab
 test_language_driver objc
 test_language_driver pascal
diff --git a/t/t4034/javascript/expect b/t/t4034/javascript/expect
new file mode 100644
index 0000000000..602513c651
--- /dev/null
+++ b/t/t4034/javascript/expect
@@ -0,0 +1,52 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index b72238f..8bc3e3a 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,32 +1,32 @@<RESET>
+// DecimalLiteral<RESET>
+<RED>123<RESET>
+<RED>0.123<RESET>
+<RED>0.123e+5<RESET>
+<RED>0.123E+5<RESET>
+<RED>0.123e5<RESET>
+<RED>1222222222222222223334444n<RESET><GREEN>124<RESET>
+<GREEN>0.124<RESET>
+<GREEN>0.123e-5<RESET>
+<GREEN>0.123E-5<RESET>
+<GREEN>0.123E5<RESET>
+<GREEN>12222222222222222233344445n<RESET>
+// HexIntegerLiteral<RESET>
+<RED>0x10<RESET>
+<RED>0X6Fa1<RESET>
+<RED>0x123_456<RESET>
+<RED>0x1234182989812f1289an<RESET><GREEN>0x11<RESET>
+<GREEN>0X5Fa1<RESET>
+<GREEN>0x123_756<RESET>
+<GREEN>0x1234182989812f1289bn<RESET>
+// OctalIntegerLiteral<RESET>
+<RED>05<RESET>
+<RED>0o6<RESET>
+<RED>0O7<RESET>
+<RED>0512_567<RESET>
+<RED>0o424242424242424242424242424242666666n<RESET><GREEN>06<RESET>
+<GREEN>0o5<RESET>
+<GREEN>0O4<RESET>
+<GREEN>0511_567<RESET>
+<GREEN>0o424242424242424242424242424242666667n<RESET>
+// BinaryIntegerLiteral<RESET>
+<RED>0b1001<RESET>
+<RED>0B0110<RESET>
+<RED>0b0001_1001_0011<RESET>
+<RED>0b1111111111111111111111111111111111111n<RESET><GREEN>0b1101<RESET>
+<GREEN>0B0010<RESET>
+<GREEN>0b0001_1101_0011<RESET>
+<GREEN>0b11111111111111000011111111111111111n<RESET>
+// punctuations<RESET>
+{<RED>a<RESET><GREEN>b<RESET>} (<RED>a<RESET><GREEN>b<RESET>)
+<RED>a<RESET><GREEN>b<RESET>;
+[<RED>1,<RESET>2<GREEN>,3<RESET>]
+[<RED>1, 2,<RESET> ...<RED>params<RESET><GREEN>params_v2<RESET> ]
+a<RED><=<RESET><GREEN>=<RESET>2 a<RED>>=<RESET><GREEN>=<RESET>2 a<RED>==<RESET><GREEN>=<RESET>2 a<RED>!=<RESET><GREEN>=<RESET>2 a<RED>===<RESET><GREEN>=<RESET>2 a<RED>!==<RESET><GREEN>=<RESET>2 a<RED>^=<RESET><GREEN>=<RESET>2 a<RED>=><RESET><GREEN>=<RESET>2
+a<RED>+=<RESET><GREEN>-=<RESET>b a<RED>*=<RESET><GREEN>%=<RESET>b a<RED>**=<RESET><GREEN>&&=<RESET>b a<RED>||=<RESET><GREEN>|=<RESET>b
+b<RED>+<RESET><GREEN>-<RESET>c a<RED>--<RESET><GREEN>++<RESET> a<RED>>><RESET><GREEN><<<RESET>b a<RED>>>><RESET><GREEN>>>>=<RESET>b a<RED>>>=<RESET><GREEN><<=<RESET>b
+a<RED>&&<RESET><GREEN>&<RESET>b a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&=<RESET><GREEN>??=<RESET>b
diff --git a/t/t4034/javascript/post b/t/t4034/javascript/post
new file mode 100644
index 0000000000..8bc3e3af12
--- /dev/null
+++ b/t/t4034/javascript/post
@@ -0,0 +1,32 @@
+// DecimalLiteral
+124
+0.124
+0.123e-5
+0.123E-5
+0.123E5
+12222222222222222233344445n
+// HexIntegerLiteral
+0x11
+0X5Fa1
+0x123_756
+0x1234182989812f1289bn
+// OctalIntegerLiteral
+06
+0o5
+0O4
+0511_567
+0o424242424242424242424242424242666667n
+// BinaryIntegerLiteral
+0b1101
+0B0010
+0b0001_1101_0011
+0b11111111111111000011111111111111111n
+// punctuations
+{b} (b)
+b;
+[2,3]
+[ ...params_v2 ]
+a=2 a=2 a=2 a=2 a=2 a=2 a=2 a=2
+a-=b a%=b a&&=b a|=b
+b-c a++ a<<b a>>>=b a<<=b
+a&b a|b a??=b
\ No newline at end of file
diff --git a/t/t4034/javascript/pre b/t/t4034/javascript/pre
new file mode 100644
index 0000000000..b72238f779
--- /dev/null
+++ b/t/t4034/javascript/pre
@@ -0,0 +1,32 @@
+// DecimalLiteral
+123
+0.123
+0.123e+5
+0.123E+5
+0.123e5
+1222222222222222223334444n
+// HexIntegerLiteral
+0x10
+0X6Fa1
+0x123_456
+0x1234182989812f1289an
+// OctalIntegerLiteral
+05
+0o6
+0O7
+0512_567
+0o424242424242424242424242424242666666n
+// BinaryIntegerLiteral
+0b1001
+0B0110
+0b0001_1001_0011
+0b1111111111111111111111111111111111111n
+// punctuations
+{a} (a)
+a;
+[1,2]
+[ 1, 2, ...params ]
+a<=2 a>=2 a==2 a!=2 a===2 a!==2 a^=2 a=>2
+a+=b a*=b a**=b a||=b
+b+c a-- a>>b a>>>b a>>=b
+a&&b a||b a&&=b
\ No newline at end of file
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..a6a341e3c1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,44 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+
+PATTERNS("javascript",
+	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
+	 /* don't match statement */
+	 "!^.*;[ \t]*\n"
+	 /* match normal function */
+	 "^[\t ]*((export[\t ]+)?(async[\t ]+)?function[\t ]*([\t ]*\\*[\t ]*|[\t ]*)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
+	 /* match JavaScript variable declaration with a lambda expression */
+	 "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
+	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*[\t ])[\t ]*=>[\t ]*\\{?)\n"
+	 /* match exports for anonymous fucntion */
+	 "^[\t ]*(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
+	 /* match assign function to LHS */
+	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"
+	 /* match normal function in object literal */
+	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)\n"
+	 /* don't match the function in class, which has more than one ident level */
+	 "!^(\t{2,}|[ ]{5,})\n"
+	 /* match function in class */
+	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",
+	 /* word regex */
+	 /* hexIntegerLiteral and bigHexIntegerLiteral*/
+	 "0[xX][0-9a-fA-F][_0-9a-fA-F]*n?|"
+	 /* octalIntegerLiteral and bigOctalIntegerLiteral */
+	 "0[oO]?[0-7][_0-7]*n?|"
+	 /* binaryIntegerLiteral and bigBinaryIntegerLiteral */
+	 "(0[bB][01][_01]*n?)|"
+	 /* decimalLiteral */
+	 "(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?|"
+	 /* bigDecimalLiteral */
+	 "(0|[1-9][_0-9]*)n|"
+	 /* punctuations */
+	 "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=|>=|==|!=|={3}|!==|\\+|-|\\*|/|%|\\*{2}|"
+	 "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=|\\+=|-=|\\*=|%=|\\*{2}=|"
+	 "<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>|"
+	 /* identifiers */
+	 "[$_[:alpha:]][$_[:alnum:]]*"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1.273.ge6ebfd0e8c.dirty

