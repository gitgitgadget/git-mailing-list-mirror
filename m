Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152B30EF86
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220071; cv=none; b=DE67tYP55laH5Sj1omnMJlaRoq4TfM1MRllK8Def7dXrr+X5wi4gHwJuCxnqYQeP8Yz+n+FsqLL5kd3+SWwIcz1D34ga9zycIcBaLMYPFf/Ij6a74jACv1BsUXm/HaKoNfC0+ks5YEYVZPODc3PQgaApd81D6svQv24W644YFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220071; c=relaxed/simple;
	bh=etk2SsSx+NTkBoicN5aNkH8TANb7vm/XCdXdrOIOvKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R80dITNdQk6+BImrZWKUyCoCyg0C/HALs4/ldwpyzvW1dj8B3rLehPii8fiD9TeBFOYZpTipGqTZUHS7AeShuzHnWL7hCXKsSScnvtTadlaqlR6I4+eSa7OysdKR9Eo2QLOWWOmXLCH5yWnr7sqLTra0k0cKO4x54m2S78Js324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwY7JT+o; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwY7JT+o"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8dfb9139008so280690485a.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 19:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220069; x=1776824869; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHGxfvEbJektW0qRjuLA8TY2XyrGwYTqQFOfyfPcv6A=;
        b=VwY7JT+oTCnxZ8Xpoz9gdgkWxxu53S9imCBKpjPnmu9GvUKSgL/9HexC7CWkA0Y483
         Er+Cl2fibqExB6JoAd8Z0mVP2hsMSxxtDddmOKddMxFFRc7LZvjg6i9oZox4Vth+AFiY
         eU+dB36cCeCnKiwEDRftxTjbJPxgecixZwmg6PLA6jl59tagJgxzrISSuQR2e5w8Hdxx
         HhJQOxu4Q6AalmY79yMgwCFm9446N6eiHLpanvVN9k0d+FdLM4xzDrB9UUAyv4CosVs0
         674/Mf2DJglMVvTqpOL/OaytmtCCa2Cbw/q/G3iqhfEq59OH4uQubg1wa40MQMkIBhkk
         J54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220069; x=1776824869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHGxfvEbJektW0qRjuLA8TY2XyrGwYTqQFOfyfPcv6A=;
        b=WqdhjisCfHMNoiSh9Z+erYWKsymc4zV4tzdV5QAPjI1h1TNiESVGcv96XZYpEfOvPg
         XxWdA1M7sVvogVcIyi4mbXBVpQbyZ7MRbKnB6eCT7EptWTmLhqeQGKBFUQTeOtfmJI53
         JVakyuFS6+uCQYafLGa8evix3Qlug/AUuWQbCVZs/lfuF8YtQOCMKzMr960Z1jJjmdfW
         Y5Te2z8LJUAZwcpgS88IhZa3u/2FKwWpcOcUgHY/14M9CD/M1zG8nEuw/ENQN6jVMIH+
         oB1WV6gmf9JFXL5emsjA+S7ui2zLzp3tW1BBpY3S0p6dO6fLmTPjSQahRVdWCP4k4ogA
         DhyA==
X-Gm-Message-State: AOJu0Yx/UmSjQrgjyEo5QhwHxo8QZZtrOVvt1wPer1EH0zPSVTsc0IEe
	RHiK1WMKOLdf4CdDrWntN5PmtyoG1hQNlPpTVlrfbfonxlscCZjF9ywJnUTbrQ==
X-Gm-Gg: AeBDietsgC8alzycdgu8DbUxT0FwEsi9InSZHyzDoC3oNzvuVK1C8Q8ppRRlTNNvD01
	jOauVNTFbRULfVa+82db/3UBIrLRUZ6RxwS1NORlurEof33Q+tAVugV4AhPug7FNc/i45DEUSFs
	PBPWf3Am49X2gDChdsdi4giAzwgQd52QWcZjK8VP/nTrXGsCpf6j/dsVMJTsVNox86Y/mXPvVjo
	pmTnhUVnG1yb3HTF0HV6FIk7E/PvAs9xVSKph7Z5Vx1an7n3CemtQ753kX2RwdRtqrViCEWeGw6
	QZl2cIKr8OgLwaVMXQTHHWgR9xYsZOKQpth8zeveS3j2eUO+jd9/tOnETdHzeV12i8RL5zdkRra
	o/LZDd30u/WPtINUBMxBJDoBqdSUaQKKM5+bKlok/daaoW4JmGMQa1O2GwxGBZsMfyLlovZfw/Z
	xzNlBbI9gQh86fT6wIQLfgIrp7+oXCUuZJwh8kbA==
X-Received: by 2002:a05:620a:4588:b0:8d6:255d:877a with SMTP id af79cd13be357-8ddcdbe3b22mr2845271485a.15.1776220068879;
        Tue, 14 Apr 2026 19:27:48 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4eed6eef3sm25914085a.2.2026.04.14.19.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:27:48 -0700 (PDT)
Message-Id: <0bd51e02ba1aec92f2149a3c870af2dd1fc200b4.1776220063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
References: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
	<pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 02:27:43 +0000
Subject: [PATCH v4 2/2] userdiff: extend Scheme support to cover other Lisp
 dialects
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jaydeep P Das <jaydeepjd.8914@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>

From: "Scott L. Burson" <Scott@sympoiesis.com>

Common Lisp has top-level forms, such as 'defun' and 'defmacro', that
are not matched by the current Scheme pattern.  Also, it is more
common in CL, when defining user macros intended as top-level forms,
to prefix their names with "def" instead of "define"; such forms are
also not matched.  And some top-level forms don't even begin with
"def".

On the other hand, it is an established formatting convention in the
Lisp community that only top-level forms start at the left margin.  So
matching any unindented line starting with an open parenthesis is an
acceptable heuristic; false positives will be rare.

However, there are also cases where notionally top-level forms are
grouped together within some containing form.  At least in the Common
Lisp community, it is conventional to indent these by two spaces, or
sometimes one.  But matching just an open parenthesis indented by two
spaces would be too broad; so the pattern added by this commit
requires an indented form to start with "(def".  It is believed that
this strikes a good balance between potential false positives and
false negatives.

Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
---
 Documentation/gitattributes.adoc           |  3 ++-
 t/t4018/scheme-lisp-defun-a                |  4 ++++
 t/t4018/scheme-lisp-defun-b                |  4 ++++
 t/t4018/scheme-lisp-eval-when              |  4 ++++
 t/t4018/{scheme-module => scheme-module-a} |  0
 t/t4018/scheme-module-b                    |  6 ++++++
 t/t4034/scheme/expect                      |  2 +-
 t/t4034/scheme/post                        |  2 +-
 t/t4034/scheme/pre                         |  2 +-
 userdiff.c                                 | 22 ++++++++++++++++------
 10 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 t/t4018/scheme-lisp-defun-a
 create mode 100644 t/t4018/scheme-lisp-defun-b
 create mode 100644 t/t4018/scheme-lisp-eval-when
 rename t/t4018/{scheme-module => scheme-module-a} (100%)
 create mode 100644 t/t4018/scheme-module-b

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f20041a323..bd76167a45 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -911,7 +911,8 @@ patterns are available:
 
 - `rust` suitable for source code in the Rust language.
 
-- `scheme` suitable for source code in the Scheme language.
+- `scheme` suitable for source code in most Lisp dialects,
+  including Scheme, Emacs Lisp, Common Lisp, and Clojure.
 
 - `tex` suitable for source code for LaTeX documents.
 
diff --git a/t/t4018/scheme-lisp-defun-a b/t/t4018/scheme-lisp-defun-a
new file mode 100644
index 0000000000..c3c750f76d
--- /dev/null
+++ b/t/t4018/scheme-lisp-defun-a
@@ -0,0 +1,4 @@
+(defun some-func (x y z) RIGHT
+  (let ((a x)
+        (b y))
+        (ChangeMe a b)))
diff --git a/t/t4018/scheme-lisp-defun-b b/t/t4018/scheme-lisp-defun-b
new file mode 100644
index 0000000000..21be305968
--- /dev/null
+++ b/t/t4018/scheme-lisp-defun-b
@@ -0,0 +1,4 @@
+(macrolet ((foo (x) `(bar ,x)))
+  (defun mumble (x) ; RIGHT
+    (when (> x 0)
+      (foo x)))) ; ChangeMe
diff --git a/t/t4018/scheme-lisp-eval-when b/t/t4018/scheme-lisp-eval-when
new file mode 100644
index 0000000000..5d941d7e0e
--- /dev/null
+++ b/t/t4018/scheme-lisp-eval-when
@@ -0,0 +1,4 @@
+(eval-when (:compile-toplevel :load-toplevel :execute)  ; RIGHT
+  (set-macro-character #\?
+		       (lambda (stream char)
+			 `(make-pattern-variable ,(read stream)))))  ; ChangeMe
diff --git a/t/t4018/scheme-module b/t/t4018/scheme-module-a
similarity index 100%
rename from t/t4018/scheme-module
rename to t/t4018/scheme-module-a
diff --git a/t/t4018/scheme-module-b b/t/t4018/scheme-module-b
new file mode 100644
index 0000000000..77bc0c5eff
--- /dev/null
+++ b/t/t4018/scheme-module-b
@@ -0,0 +1,6 @@
+(module A
+  (export with-display-exception)
+  (extern (display-exception display-exception))
+  (def (with-display-exception thunk) RIGHT
+    (with-catch (lambda (e) (display-exception e (current-error-port)) e)
+      thunk ChangeMe)))
diff --git a/t/t4034/scheme/expect b/t/t4034/scheme/expect
index 138abe9f56..fb7f2616fe 100644
--- a/t/t4034/scheme/expect
+++ b/t/t4034/scheme/expect
@@ -6,7 +6,7 @@
 (define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
   ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
   (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
-  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
+  (define <RED>|the \| \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
   ({<RED>}<RESET>(([<RED>]<RESET>(func-n)<RED>[<RESET>]))<RED>{<RESET>})
   (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
     (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
index 0e3bab101d..450cc234f7 100644
--- a/t/t4034/scheme/post
+++ b/t/t4034/scheme/post
@@ -1,7 +1,7 @@
 (define (my-func first second)
   ; This is a (moderately) cool function.
   (that\place (+ 3 4))
-  (define |a greeting| "hello")
+  (define |a \greeting| |hello there|)
   ({(([(func-n)]))})
   (let ((c (add1 first)))
     (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
index 03d77c7c43..e16ee75849 100644
--- a/t/t4034/scheme/pre
+++ b/t/t4034/scheme/pre
@@ -1,7 +1,7 @@
 (define (myfunc a b)
   ; This is a really cool function.
   (this\place (+ 3 4))
-  (define |the greeting| "hello")
+  (define |the \| \greeting| |hello there|)
   ({}(([](func-n)[])){})
   (let ((c (+ a b)))
     (format "one more than the total is %d" (add1 c))))
diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..b5412e6bc3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -344,14 +344,24 @@ PATTERNS("rust",
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
 PATTERNS("scheme",
-	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
 	 /*
-	  * R7RS valid identifiers include any sequence enclosed
-	  * within vertical lines having no backslashes
+	  * An unindented opening parenthesis identifies a top-level
+	  * expression in all Lisp dialects.
 	  */
-	 "\\|([^\\\\]*)\\|"
-	 /* All other words should be delimited by spaces or parentheses */
-	 "|([^][)(}{[ \t])+"),
+	 "^(\\(.*)$\n"
+	 /* For Scheme: a possibly indented left paren followed by a keyword. */
+	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$\n"
+	 /*
+	  * For all Lisp dialects: a slightly indented line starting with "(def".
+	  */
+	 "^  ?(\\([Dd][Ee][Ff].*)$",
+	 /*
+	  * The union of R7RS and Common Lisp symbol syntax: allows arbitrary
+	  * strings between vertical bars, including any escaped characters.
+	  */
+	 "\\|([^|\\\\]|\\\\.)*\\|"
+	 /* All other words should be delimited by spaces or parentheses. */
+	 "|([^][)(}{ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
 { .name = "default", .binary = -1 },
-- 
gitgitgadget
