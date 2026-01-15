Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132E2FFDDE
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519127; cv=none; b=gavCrlS6nD9By/ulCkrtfGjZj3r7opjpa3HNWL6xg6JJ2MzDIRs4zzZbSkVVtJyyVN1TP0e7GOFDuHHXDNMj/BazvS0gKVjuy9lQYq1vPuBfY3rJovRS+V69EMMnbrmVuaRx51sSkKW0Cdv4C6BFt3DGl6clGla8aRxeQ3nwNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519127; c=relaxed/simple;
	bh=ZCs9ilinT1ri2dTrOjTGjFIY2c5Fie3bGN3eGv7uZjs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V+Lm0wA1LOstlaQUT8ssrVxdBLV8uvl8CxYSOkFbvCNSrrMiXcvrL9+PkyVAqnGZz86Y16h/Zq7nBwUgdl+1gb7S4xe+RszI4wB8ezgYSFrDtEcaJzmaNZnSJVovJkcF31++dxXQ3lR12Rezw4tWEKURXm0JxhRFmY+NqoMvqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDkqemTd; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDkqemTd"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cfd9b4e3f8so374483a34.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768519124; x=1769123924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ew7v4Bx+9nbSjxAhWiK12+ZlKQA78k+T3IBe23pI1o=;
        b=aDkqemTdzMm1LQt1TJQG+KFuEI7xN2pLsWS5ga84EgTeOaseYP9NQj+u8HHAG05KvI
         3qGMzmvsfgyyZGqb/8oJUfvFfphyC8bDUhBSmMc1/XtWY1a0z1xaMfuVqS2NAR45EYLs
         Ab+Rw/iF/SW9oQRMjBSe8KULL3lTxPgvNhLM9hKk3iysO+WCmMrU3BJHbH7Uu6dD6oPF
         KjHzkStdHQofjw6Uimc+aEaPAVLJVFtFp8FGrnv/d4exLFhc0dEd6X0hw1EnP+ZUuNd8
         IwDSyZzqOR/1ryTDuytdzRs/yn6vPgM+Pn5ihDxmBgd99iJ9nN5q45dowwW9iuiLBBba
         FxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519124; x=1769123924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ew7v4Bx+9nbSjxAhWiK12+ZlKQA78k+T3IBe23pI1o=;
        b=PCvvnP+Wlo4UQQ/09h63rmXMpXK08FJj7A01qiON8CrynuqDrefCCyHFnY90vZmcop
         wjmC4SQiEvycgUmTAWXqY9+Gn7TLVF1tibONrziwwJzZEU2rYV6hue0600aAdKX8RO8R
         4KJny2ajO3RMBKHLKqfl+rHaQvog/PkHl35Bi7Wmf75cqbJpZ2PBUWACBBSinntrqVHe
         c+W/yUfpVKjTGltQA5dHRTFJUWcPYcBrM/bILK3vdQs5n6TbqSJBmAXVjUDO5uJ7VStQ
         zd0wam9mMSXCTDmbWdDNzZrzw9CTzOuaQYH0GEBgIy+o5qGJmA+qOOwePC+XYIYA8Aq9
         7Gfg==
X-Gm-Message-State: AOJu0YxLZgepNw4hdnoaJ80yEFCgrcEYm3MzZFeMPRtz34TxHp/1/vtX
	bWt+dMkOfvVzgbXGGKypHWrfDHyCVzSd5cNTChcOuiFX74XgpwbhLNHZymjNOg==
X-Gm-Gg: AY/fxX65shUscBmf0O6O389cFJkTTIFcZp2W9HpPE2J/9uScn3lV+P4U+HfuGOZyi1Q
	gJmNq0edrQRchoXNVrZyD750Lu9Z7VQdyN/p3rXwuwrnWG9rm/3P+NHIC/4eWMw9HOErhcsX2AH
	buiR/Dlw/Cm5T7v+1AiqmSLcFSFenWKFSj7Bys7FwISKxbteLa3l5gM4emAp1Nu6Mad2upbLhSP
	knSV72pfQyf2W8ZdS/lZK7qhxP87OGOgx2YJHHks3h+9S2oX/X5MHnghnKls2tSgkXMfgzfMJmN
	BsE+7A9O5iHh1IdTW7WvpfcY4mO76shjvv2E1nt9p8ks/K0pnuIqGUMB5eAF1xPGcvbfHRHNpgL
	BPKSdLTjonAyIwVpKS5O0vrXgAlfbGJ+bGY9iXp+F0CtRNtedpL4SC+/7Nh7/FN4l/Quu1w7HLG
	rKfAts0tKtnFO5
X-Received: by 2002:a05:6830:61cd:b0:7ce:2b15:de88 with SMTP id 46e09a7af769-7cfdee59b04mr609686a34.26.1768519124488;
        Thu, 15 Jan 2026 15:18:44 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.74])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b59e2sm633413a34.30.2026.01.15.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 15:18:44 -0800 (PST)
Message-Id: <fb4c8dc5d4434deab9c8f1872f309a79351dc799.1768519120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
References: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
	<pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Jan 2026 23:18:40 +0000
Subject: [PATCH v3 2/2] userdiff: extend Scheme support to cover other Lisp
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
 Documentation/gitattributes.adoc           |  1 +
 t/t4018/scheme-lisp-defun-a                |  4 ++++
 t/t4018/scheme-lisp-defun-b                |  4 ++++
 t/t4018/scheme-lisp-eval-when              |  4 ++++
 t/t4018/{scheme-module => scheme-module-a} |  0
 t/t4018/scheme-module-b                    |  6 ++++++
 t/t4034/scheme/expect                      |  2 +-
 t/t4034/scheme/post                        |  2 +-
 t/t4034/scheme/pre                         |  2 +-
 userdiff.c                                 | 22 ++++++++++++++++------
 10 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 t/t4018/scheme-lisp-defun-a
 create mode 100644 t/t4018/scheme-lisp-defun-b
 create mode 100644 t/t4018/scheme-lisp-eval-when
 rename t/t4018/{scheme-module => scheme-module-a} (100%)
 create mode 100644 t/t4018/scheme-module-b

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f20041a323..a9ce5adef9 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -912,6 +912,7 @@ patterns are available:
 - `rust` suitable for source code in the Rust language.
 
 - `scheme` suitable for source code in the Scheme language.
+Also handles Emacs Lisp, Common Lisp, and most other dialects.
 
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
index 138abe9f56..72592665f1 100644
--- a/t/t4034/scheme/expect
+++ b/t/t4034/scheme/expect
@@ -6,7 +6,7 @@
 (define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
   ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
   (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
-  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
+  (define <RED>|the \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
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
index 03d77c7c43..ba8b8ac0a4 100644
--- a/t/t4034/scheme/pre
+++ b/t/t4034/scheme/pre
@@ -1,7 +1,7 @@
 (define (myfunc a b)
   ; This is a really cool function.
   (this\place (+ 3 4))
-  (define |the greeting| "hello")
+  (define |the \greeting| |hello there|)
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
