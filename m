Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE9C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357534AbiDCN1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiDCN1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:27:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F8132993
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:25:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x14so3116856pjf.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XnKOOe1/r8o31UpJJyi3RQMxhTCP4VxbBEZNDCxPVU=;
        b=eYaD+jqNsAYS5MaMmzFnlWKEtjld+vxHGTN9XjFilnaZ8CBnu8S7mCw2x7bgAy4KdH
         CuCr5v262cJYFoyGZtHhyj36pqQGDox1dhBS82wSxP5QpThUphh5sDSEvRN3rdUIj3+E
         fJRjXtwUFFCNyMWYvgC9jqYYTv4leCzfA539rGEaB1sf9vnHN+13Vcr4/cHTYSJwLt6p
         Oyg0NqdpvMMSW3uPj+KuXF5//Qdk4isd41GRJnWmEjltiquGywflfvkGXscOnwv7yP6e
         MPToRVNUPsF1AEqvvo/Awb0XRVw09dbJIe5uC2359/i7ez9ZR89TE/qtZxBRjId1b5+Q
         frlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XnKOOe1/r8o31UpJJyi3RQMxhTCP4VxbBEZNDCxPVU=;
        b=KD31h9GGYG9LnjG+LkcDXua2IyiLaZOpaipaPqGWh8y+pvOI7zW/jKjEWa2Bfl3+yz
         mU5TjzBUFwfBJhOJHjoLygj0zgsXsfe9oGovlGAzOyNVHjy5glnBPJihiG+9iXDw9Xs1
         GLB4zXWvt/CSc/dG6ky56BQFx6Gmwx0nxggKFOKM8mMnNK8lXASU3pz20XJfLHceLtgU
         FwBYDZiSdNvg432BVSTvPQRSrTYHe1MgK39ng/QmipknKdyOw0EvUHblcyabiD7QaTYh
         f4Is5pqPclIsTeWxyMhL9J7J8Dbiy3igbeh52n5dcUf+Ifv1D7jkzyiedY2e6VqRUSx4
         U59Q==
X-Gm-Message-State: AOAM532sdcAoNEAY5RJAH5w2B+WHoX2F/y9FHDbOzT+4TVjIjzeM7lm6
        goDvaWVm5jtax3QAhf1grdMJvZXqA2s4JCHi
X-Google-Smtp-Source: ABdhPJzSxYWnKLpyiYfM7RKeN1IgybYYhiFCrvF65BeVJMID9C9nhiRONRu3/CsWgo45KwueSXmvpA==
X-Received: by 2002:a17:903:288:b0:156:a6b5:80d4 with SMTP id j8-20020a170903028800b00156a6b580d4mr855523plr.98.1648992311517;
        Sun, 03 Apr 2022 06:25:11 -0700 (PDT)
Received: from ubuntu.localdomain ([140.115.59.167])
        by smtp.gmail.com with ESMTPSA id z23-20020a056a001d9700b004fa8f24702csm8189738pfw.85.2022.04.03.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:25:11 -0700 (PDT)
From:   xing zhi jiang <a97410985new@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, chooglen@google.com
Subject: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
Date:   Sun,  3 Apr 2022 06:25:08 -0700
Message-Id: <20220403132508.28196-1-a97410985new@gmail.com>
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
in the class, named export for function in ECMA2015, CommonJS exports for
named function, and also the function is object literal's property[1].
The special match is this would match the popular framework test case
pattern(most is same as regex for matching function in class).

And in the word regex part, that matches numbers, punctuations, and also the
JavaScript identifier.
This part reference the formal ECMA specification[2].

[1]https://github.com/jquery/jquery/blob/de5398a6ad088dc006b46c6a870a2a053f4cd663/src/core.js#L201
[2]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar

Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
---
I write a simple python script to help me observe the diff's results easier. 
And the result is in https://github.com/a97410985/user_diff_observe_tool.
I observe the six popular JavaScript projects - Jquery, NodeJS, React, TensorflowJS, 
Vue, and Webpack. The result is not perfect but acceptable.
Most of the mismatch is related to the function in class. Ex:
https://github.com/a97410985/user_diff_observe_tool/blob/092bd14c849b9a3f61bb872d730e38b58cc9c303/diff_result/jquery_result.diff#L1094.
But this is inevitable.
And besides, apply the code reviews suggestions. I add some new regex.
1. "!^[\t ]*[$_[:alpha:]][$_[:alnum:]][\t ]*\\(.*\\)\\.\n"
   this is for the case below
   `
    function RIGHT(a, b) {

        WRONG(spy.calls.count()).toBe(1)
        return a + b; // ChangeMe
    }
   `
   if we don't skip chained function call. This would happen mismatch.
2. "^[\t ]*(QUnit.test\\(.*)\n"
   I oberve there are many test case pattern in JavaScript. And most of popular JavaScript
   unit test framework's test case pattern is function call can be matched by the regex, which
   match "function in class". So it is no problem. But `QUnit framework` don't matched by that.
   Then add this regex into JavaScript userdiff.
   And the reason includes test case pattern has two
   1. This is inevitable. Because we can't distinguish that with function in class.
   2. This can help the user understand what change is happening in which test case. And if 
      don't match the test case, it has the large possibility to match no related function.
      
And I move the regex, which match normal function in object literal, under the regex 
""!^(\t{2,}|[ ]{5,})\n".
Because I found it would many mismatch if function in object literal has too many indent level(
the function body usually just few lines of code, and the below has large of code. If has change
on below, it would happen mismatch).
And there are two example for hunk header that match test case pattern.
      
Range-diff against v2:
1:  3b326bd2b6 ! 1:  2791a7b6b8 Add a diff driver for JavaScript languages.
    @@ Commit message
     
         In the xfunction part that matches normal functions,
         a variable declaration with an assignment of function, the function declaration
    -    in the class, and also the function is object literal's property[1].
    +    in the class, named export for function in ECMA2015, CommonJS exports for
    +    named function, and also the function is object literal's property[1].
    +    The special match is this would match the popular framework test case
    +    pattern(most is same as regex for matching function in class).
     
         And in the word regex part, that matches numbers, punctuations, and also the
         JavaScript identifier.
    @@ t/t4018/javascript-async-function (new)
     +async function RIGHT(a, b) {
     +  
     +  return a + b; // ChangeMe
    ++}
    +
    + ## t/t4018/javascript-es5-method-shorthand (new) ##
    +@@
    ++const foo = {
    ++    RIGHT() {
    ++        
    ++        console.log('ChangeMe');
    ++    }
     +}
     
      ## t/t4018/javascript-export-async-function (new) ##
    @@ t/t4018/javascript-exports-anomyous-function-2 (new)
     +exports.RIGHT = (a, b, runtime) => {
     +	
     +    return ChangeMe;
    ++};
    +
    + ## t/t4018/javascript-exports-anomyous-function-3 (new) ##
    +@@
    ++module.exports.RIGHT = (a, b, runtime) => {
    ++	
    ++    return ChangeMe;
    ++};
    +
    + ## t/t4018/javascript-exports-anomyous-function-4 (new) ##
    +@@
    ++module.exports = ( RIGHT ) => {
    ++	
    ++    return ChangeMe;
     +};
     
      ## t/t4018/javascript-exports-function (new) ##
    @@ t/t4018/javascript-function (new)
     +  return a + b; // ChangeMe
     +}
     
    - ## t/t4018/javascript-function-2 (new) ##
    -@@
    -+function test(a, b) {
    -+  return {
    -+			RIGHT: function () {
    -+				currentUpdateRemovedChunks.forEach(function (chunkId) {
    -+					delete $installedChunks$[chunkId];
    -+				});
    -+				currentUpdateRemovedChunks = ChangeMe;
    -+   }
    -+  }
    -+}
    -
    - ## t/t4018/javascript-function-belong-to-IIFE (new) ##
    -@@
    -+(function () {
    -+  this.$RIGHT = function (needle, modifier) {
    -+      let a = 5;
    -+      return ChangeMe;
    -+  };
    -+}).call(aaaa.prototype);
    -
      ## t/t4018/javascript-function-in-class (new) ##
     @@
     +class Test {
    @@ t/t4018/javascript-setter-function-in-class (new)
     +    let a = 4;
     +    let b = ChangeMe;
     +  }
    ++}
    +
    + ## t/t4018/javascript-skip-chained-function (new) ##
    +@@
    ++function RIGHT(a, b) {
    ++
    ++  expect(spy.calls.count()).toBe(1)
    ++  return a + b; // ChangeMe
     +}
     
      ## t/t4018/javascript-skip-function-call-statement (new) ##
    @@ userdiff.c: PATTERNS("java",
     +	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
     +	 /* don't match statement */
     +	 "!;\n"
    -+	 /* match normal function */
    ++	 /* match normal function or named export for function in ECMA2015 */
     +	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
    -+	 /* match JavaScript variable declaration with a lambda expression */
    -+	 "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
    -+	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
    -+	 /* match exports for anonymous fucntion */
    -+	 "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
    -+	 /* match assign function to LHS */
    -+	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"
    -+	 /* match normal function in object literal */
    -+	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)\n"
    -+	 /* don't match the function in class, which has more than one ident level */
    ++	 /* match JavaScript variable declaration with a lambda expression at top level */
    ++	 "^((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
    ++		"(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
    ++	 /* match object's property assignment by anonymous function and CommonJS exports for named function */
    ++	 "^((module\\.)?[$_[:alpha:]][$_[:alnum:]]*\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(async[\t ]+)?(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
    ++	 /* match assign function to LHS with explicit function keyword */
    ++	 "^(.*=[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
    ++	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */
    ++	 "^[\t ]*(QUnit.test\\(.*)\n"
    ++	 /* don't match the function in class or in object literal, which has more than one ident level */
     +	 "!^(\t{2,}|[ ]{5,})\n"
    -+	 /* match function in class */
    ++	 /* match normal function in object literal */
    ++	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function.*)\n"
    ++	 /* don't match chained method call */
    ++	 "!^[\t ]*[$_[:alpha:]][$_[:alnum:]][\t ]*\\(.*\\)\\.\n"
    ++	 /* match function in class and ES5 method shorthand */
     +	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",
     +	 /* word regex */
    -+	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, DecimalLiteral and its big version */
    -+	 "(0[xXoObB])?[0-9a-fA-F][_0-9a-fA-F]*n?"
    -+	 /* DecimalLiteral may be float */
    -+	 "|(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
    ++	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and its big version */
    ++	 "0[xXoObB][_0-9a-fA-F]+n?"
    ++	 /* DecimalLiteral and its big version*/
    ++	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
    ++	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
     +	 /* punctuations */
     +	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
     +	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="

 Documentation/gitattributes.txt               |  2 +
 ...avascript-assignment-of-anonymous-function |  4 ++
 .../javascript-assignment-of-arrow-function   |  4 ++
 .../javascript-assignment-of-arrow-function-2 |  4 ++
 .../javascript-assignment-of-arrow-function-3 |  4 ++
 .../javascript-assignment-of-named-function   |  4 ++
 t/t4018/javascript-async-function             |  4 ++
 t/t4018/javascript-es5-method-shorthand       |  6 +++
 t/t4018/javascript-export-async-function      |  4 ++
 t/t4018/javascript-export-function            |  4 ++
 t/t4018/javascript-exports-anomyous-function  |  4 ++
 .../javascript-exports-anomyous-function-2    |  4 ++
 .../javascript-exports-anomyous-function-3    |  4 ++
 .../javascript-exports-anomyous-function-4    |  4 ++
 t/t4018/javascript-exports-function           |  4 ++
 t/t4018/javascript-function                   |  4 ++
 t/t4018/javascript-function-in-class          |  6 +++
 t/t4018/javascript-function-in-class-2        | 11 ++++
 t/t4018/javascript-function-in-class-3        | 10 ++++
 t/t4018/javascript-function-in-object-literal |  7 +++
 t/t4018/javascript-generator-function         |  4 ++
 t/t4018/javascript-generator-function-2       |  4 ++
 t/t4018/javascript-getter-function-in-class   |  6 +++
 t/t4018/javascript-setter-function-in-class   |  6 +++
 t/t4018/javascript-skip-chained-function      |  5 ++
 .../javascript-skip-function-call-statement   |  7 +++
 t/t4018/javascript-skip-keywords              | 34 ++++++++++++
 t/t4018/javascript-static-function-in-class   |  6 +++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/javascript/expect                     | 54 +++++++++++++++++++
 t/t4034/javascript/post                       | 33 ++++++++++++
 t/t4034/javascript/pre                        | 33 ++++++++++++
 userdiff.c                                    | 37 +++++++++++++
 33 files changed, 328 insertions(+)
 create mode 100644 t/t4018/javascript-assignment-of-anonymous-function
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function-2
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function-3
 create mode 100644 t/t4018/javascript-assignment-of-named-function
 create mode 100644 t/t4018/javascript-async-function
 create mode 100644 t/t4018/javascript-es5-method-shorthand
 create mode 100644 t/t4018/javascript-export-async-function
 create mode 100644 t/t4018/javascript-export-function
 create mode 100644 t/t4018/javascript-exports-anomyous-function
 create mode 100644 t/t4018/javascript-exports-anomyous-function-2
 create mode 100644 t/t4018/javascript-exports-anomyous-function-3
 create mode 100644 t/t4018/javascript-exports-anomyous-function-4
 create mode 100644 t/t4018/javascript-exports-function
 create mode 100644 t/t4018/javascript-function
 create mode 100644 t/t4018/javascript-function-in-class
 create mode 100644 t/t4018/javascript-function-in-class-2
 create mode 100644 t/t4018/javascript-function-in-class-3
 create mode 100644 t/t4018/javascript-function-in-object-literal
 create mode 100644 t/t4018/javascript-generator-function
 create mode 100644 t/t4018/javascript-generator-function-2
 create mode 100644 t/t4018/javascript-getter-function-in-class
 create mode 100644 t/t4018/javascript-setter-function-in-class
 create mode 100644 t/t4018/javascript-skip-chained-function
 create mode 100644 t/t4018/javascript-skip-function-call-statement
 create mode 100644 t/t4018/javascript-skip-keywords
 create mode 100644 t/t4018/javascript-static-function-in-class
 create mode 100644 t/t4034/javascript/expect
 create mode 100644 t/t4034/javascript/post
 create mode 100644 t/t4034/javascript/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 60984a4682..a8e3e4d735 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -828,6 +828,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `javascript` suitable for source code in the JavaScript language.
+
 - `markdown` suitable for Markdown documents.
 
 - `matlab` suitable for source code in the MATLAB and Octave languages.
diff --git a/t/t4018/javascript-assignment-of-anonymous-function b/t/t4018/javascript-assignment-of-anonymous-function
new file mode 100644
index 0000000000..b6f2ccccfc
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-anonymous-function
@@ -0,0 +1,4 @@
+const RIGHT = function (a, b) {
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-arrow-function b/t/t4018/javascript-assignment-of-arrow-function
new file mode 100644
index 0000000000..24ce517b7a
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function
@@ -0,0 +1,4 @@
+const RIGHT = (a, b) => {
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-arrow-function-2 b/t/t4018/javascript-assignment-of-arrow-function-2
new file mode 100644
index 0000000000..bbf5de369e
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function-2
@@ -0,0 +1,4 @@
+const RIGHT = (a, b)=>{
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-arrow-function-3 b/t/t4018/javascript-assignment-of-arrow-function-3
new file mode 100644
index 0000000000..4a07aa3259
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function-3
@@ -0,0 +1,4 @@
+const RIGHT=test=>{
+	
+    return test + 1; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-named-function b/t/t4018/javascript-assignment-of-named-function
new file mode 100644
index 0000000000..bfc486ebef
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-named-function
@@ -0,0 +1,4 @@
+const RIGHT = function test (a, b) {
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
new file mode 100644
index 0000000000..993e6926bf
--- /dev/null
+++ b/t/t4018/javascript-async-function
@@ -0,0 +1,4 @@
+async function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-es5-method-shorthand b/t/t4018/javascript-es5-method-shorthand
new file mode 100644
index 0000000000..01fc0cc34b
--- /dev/null
+++ b/t/t4018/javascript-es5-method-shorthand
@@ -0,0 +1,6 @@
+const foo = {
+    RIGHT() {
+        
+        console.log('ChangeMe');
+    }
+}
diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascript-export-async-function
new file mode 100644
index 0000000000..fecbd669d7
--- /dev/null
+++ b/t/t4018/javascript-export-async-function
@@ -0,0 +1,4 @@
+export async function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-export-function
new file mode 100644
index 0000000000..b5acbb2b08
--- /dev/null
+++ b/t/t4018/javascript-export-function
@@ -0,0 +1,4 @@
+export function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-exports-anomyous-function b/t/t4018/javascript-exports-anomyous-function
new file mode 100644
index 0000000000..6786cbda8d
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function
@@ -0,0 +1,4 @@
+exports.setFlagged = RIGHT => {
+	
+    return ChangeMe;
+};
diff --git a/t/t4018/javascript-exports-anomyous-function-2 b/t/t4018/javascript-exports-anomyous-function-2
new file mode 100644
index 0000000000..883569f40d
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function-2
@@ -0,0 +1,4 @@
+exports.RIGHT = (a, b, runtime) => {
+	
+    return ChangeMe;
+};
diff --git a/t/t4018/javascript-exports-anomyous-function-3 b/t/t4018/javascript-exports-anomyous-function-3
new file mode 100644
index 0000000000..bc78ed87eb
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function-3
@@ -0,0 +1,4 @@
+module.exports.RIGHT = (a, b, runtime) => {
+	
+    return ChangeMe;
+};
diff --git a/t/t4018/javascript-exports-anomyous-function-4 b/t/t4018/javascript-exports-anomyous-function-4
new file mode 100644
index 0000000000..b952cf2a5a
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function-4
@@ -0,0 +1,4 @@
+module.exports = ( RIGHT ) => {
+	
+    return ChangeMe;
+};
diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
new file mode 100644
index 0000000000..63b79f5991
--- /dev/null
+++ b/t/t4018/javascript-exports-function
@@ -0,0 +1,4 @@
+exports.RIGHT = function(document) {
+    
+    return ChangeMe;
+}
diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
new file mode 100644
index 0000000000..0cc0bf54e7
--- /dev/null
+++ b/t/t4018/javascript-function
@@ -0,0 +1,4 @@
+function RIGHT(a, b) {
+
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-function-in-class b/t/t4018/javascript-function-in-class
new file mode 100644
index 0000000000..0cc0a26612
--- /dev/null
+++ b/t/t4018/javascript-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascript-function-in-class-2
new file mode 100644
index 0000000000..725495fe55
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
diff --git a/t/t4018/javascript-function-in-class-3 b/t/t4018/javascript-function-in-class-3
new file mode 100644
index 0000000000..e9b20728b2
--- /dev/null
+++ b/t/t4018/javascript-function-in-class-3
@@ -0,0 +1,10 @@
+class Test {
+  RIGHT(aaaaaaaaaa,
+      bbbbbbbbbb,
+      cccccccccc,
+      dddddddddd
+  ) {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-function-in-object-literal b/t/t4018/javascript-function-in-object-literal
new file mode 100644
index 0000000000..021cc706dd
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
diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
new file mode 100644
index 0000000000..dc7793939f
--- /dev/null
+++ b/t/t4018/javascript-generator-function
@@ -0,0 +1,4 @@
+function* RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
new file mode 100644
index 0000000000..950676a612
--- /dev/null
+++ b/t/t4018/javascript-generator-function-2
@@ -0,0 +1,4 @@
+function *RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-getter-function-in-class b/t/t4018/javascript-getter-function-in-class
new file mode 100644
index 0000000000..9a5aee39f7
--- /dev/null
+++ b/t/t4018/javascript-getter-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  get RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-setter-function-in-class b/t/t4018/javascript-setter-function-in-class
new file mode 100644
index 0000000000..dc5f288665
--- /dev/null
+++ b/t/t4018/javascript-setter-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  set RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-skip-chained-function b/t/t4018/javascript-skip-chained-function
new file mode 100644
index 0000000000..4ce23901cf
--- /dev/null
+++ b/t/t4018/javascript-skip-chained-function
@@ -0,0 +1,5 @@
+function RIGHT(a, b) {
+
+  expect(spy.calls.count()).toBe(1)
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-skip-function-call-statement b/t/t4018/javascript-skip-function-call-statement
new file mode 100644
index 0000000000..321993c27e
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
diff --git a/t/t4018/javascript-skip-keywords b/t/t4018/javascript-skip-keywords
new file mode 100644
index 0000000000..5584970b58
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
diff --git a/t/t4018/javascript-static-function-in-class b/t/t4018/javascript-static-function-in-class
new file mode 100644
index 0000000000..fbf0b7ca3d
--- /dev/null
+++ b/t/t4018/javascript-static-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  static RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
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
index 0000000000..419d61903b
--- /dev/null
+++ b/t/t4034/javascript/expect
@@ -0,0 +1,54 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 18f4796..46f9b62 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,33 +1,33 @@<RESET>
+// DecimalLiteral<RESET>
+<RED>123<RESET>
+<RED>0.123<RESET>
+<RED>.123<RESET>
+<RED>0.123e+5<RESET>
+<RED>0.123E+5<RESET>
+<RED>0.123e5<RESET>
+<RED>1222222222222222223334444n<RESET><GREEN>124<RESET>
+<GREEN>0.124<RESET>
+<GREEN>.124<RESET>
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
index 0000000000..46f9b627e4
--- /dev/null
+++ b/t/t4034/javascript/post
@@ -0,0 +1,33 @@
+// DecimalLiteral
+124
+0.124
+.124
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
diff --git a/t/t4034/javascript/pre b/t/t4034/javascript/pre
new file mode 100644
index 0000000000..18f479688c
--- /dev/null
+++ b/t/t4034/javascript/pre
@@ -0,0 +1,33 @@
+// DecimalLiteral
+123
+0.123
+.123
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
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..306286df35 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,43 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+
+PATTERNS("javascript",
+	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
+	 /* don't match statement */
+	 "!;\n"
+	 /* match normal function or named export for function in ECMA2015 */
+	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
+	 /* match JavaScript variable declaration with a lambda expression at top level */
+	 "^((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
+		"(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
+	 /* match object's property assignment by anonymous function and CommonJS exports for named function */
+	 "^((module\\.)?[$_[:alpha:]][$_[:alnum:]]*\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(async[\t ]+)?(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
+	 /* match assign function to LHS with explicit function keyword */
+	 "^(.*=[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
+	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */
+	 "^[\t ]*(QUnit.test\\(.*)\n"
+	 /* don't match the function in class or in object literal, which has more than one ident level */
+	 "!^(\t{2,}|[ ]{5,})\n"
+	 /* match normal function in object literal */
+	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function.*)\n"
+	 /* don't match chained method call */
+	 "!^[\t ]*[$_[:alpha:]][$_[:alnum:]][\t ]*\\(.*\\)\\.\n"
+	 /* match function in class and ES5 method shorthand */
+	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",
+	 /* word regex */
+	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and its big version */
+	 "0[xXoObB][_0-9a-fA-F]+n?"
+	 /* DecimalLiteral and its big version*/
+	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
+	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
+	 /* punctuations */
+	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
+	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
+	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
+	 /* identifiers */
+	 "|[$_[:alpha:]][$_[:alnum:]]*"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1.273.ge6ebfd0e8c.dirty

