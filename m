Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9D31F576
	for <e@80x24.org>; Thu,  1 Mar 2018 11:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967658AbeCALTa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 06:19:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51007 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967592AbeCALT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 06:19:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id w128so10942850wmw.0
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 03:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5862KIq9hnSbPHAyiwQ2+cHbFCRFbK9VfJyDCesGjGE=;
        b=f3fI8cK5V5rVw23jt34zcgp10/HJf1AenGsC43WzWvOjput2phadjguX5leGexEd1f
         LreFV6MGLrYZ9yZ+KekWLYTHunBDS3/cFl1wVjUHLMNyC6PuLGSYqXyvgwbRz+F5T11T
         6L4Bhqlr3NsdXjM8FkEm0RPtfOWjUAFBmL5Si9wkLbb/AkburK0vQpCLISW/AuIAD0+A
         Qlo8SvyiLy6hi58ZcF2NZIuhUpZNXxWsyhiXgNyFM9xtKSFkp79fM99PMvfT/ClyAwsN
         c8w4Jy2LymJKE4alqnEGVx0K3W0yHF7EnnPA4L4K+H7sNOz9I2l9fO56EMtYwtPIt7YL
         +RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5862KIq9hnSbPHAyiwQ2+cHbFCRFbK9VfJyDCesGjGE=;
        b=r9QDm+980mIbtVCq0cpaKr2p6bLoYntQQg5ml+x2zDLnqlxAX+T74BdHw5SpTT5RTQ
         06EeErAixaDWmslWxuNeD0jwhhrKtBbc08TJfCrvSmqYo0cP1COZNB01EIpNowQiD9iE
         RbCncFTmYmqxOrLo1Rg7dXeWjtyN2uDzTK02+aCFlkXjkqOr1ExUMV7II5oQT3cRBBQg
         MRRZ1tkaWvClYMawYwOU8HlAq0szZZobLA+lcuH3TWMWiA41+p7xFNlLUWHjMb6JODXR
         7M2/6zazPT1ia0hAlrTUzo1AZHIFlmIsnOUkj97oTrPulC2uKFiXbyUwXPDgTgtIG5+X
         yiPA==
X-Gm-Message-State: AElRT7GutYIHWzThz9TpgCB5tQqQvL1RB9H2LrMDBUJRCuJ1dEh5xU8B
        Fv9yit4ENEn4Xlt8PEic1K9RBTR9
X-Google-Smtp-Source: AG47ELu4heu+GX6kdNs0WZebF4IlmhaxJT5V9/OBxTh+U2XRbI1Wg7H2M3OqCNh1+5KFila7YZrj6w==
X-Received: by 10.28.245.3 with SMTP id t3mr1398244wmh.134.1519903167774;
        Thu, 01 Mar 2018 03:19:27 -0800 (PST)
Received: from localhost.localdomain (AToulouse-658-1-45-219.w86-221.abo.wanadoo.fr. [86.221.52.219])
        by smtp.gmail.com with ESMTPSA id h50sm8203712wrf.65.2018.03.01.03.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 03:19:26 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2] userdiff: add built-in pattern for golang
Date:   Thu,  1 Mar 2018 12:19:07 +0100
Message-Id: <20180301111907.17607-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180228172906.30582-1-alban.gruin@gmail.com>
References: <20180228172906.30582-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds xfuncname and word_regex patterns for golang, a quite
popular programming language. It also includes test cases for the
xfuncname regex (t4018) and updated documentation.

The xfuncname regex finds functions, structs and interfaces.  Although
the Go language prohibits the opening brace from being on its own
line, the regex does not makes it mandatory, to be able to match
`func` statements like this:

    func foo(bar int,
    	baz int) {
    }

This is covered by the test case t4018/golang-long-func.

The word_regex pattern finds identifiers, integers, floats, complex
numbers and operators, according to the go specification.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Documentation/gitattributes.txt | 2 ++
 t/t4018-diff-funcname.sh        | 1 +
 t/t4018/golang-complex-function | 8 ++++++++
 t/t4018/golang-func             | 4 ++++
 t/t4018/golang-interface        | 4 ++++
 t/t4018/golang-long-func        | 5 +++++
 t/t4018/golang-struct           | 4 ++++
 userdiff.c                      | 9 +++++++++
 8 files changed, 37 insertions(+)
 create mode 100644 t/t4018/golang-complex-function
 create mode 100644 t/t4018/golang-func
 create mode 100644 t/t4018/golang-interface
 create mode 100644 t/t4018/golang-long-func
 create mode 100644 t/t4018/golang-struct

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c21f5ca10..d52b254a2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -714,6 +714,8 @@ patterns are available:
 
 - `fountain` suitable for Fountain documents.
 
+- `golang` suitable for source code in the Go language.
+
 - `html` suitable for HTML/XHTML documents.
 
 - `java` suitable for source code in the Java language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 1795ffc3a..22f9f88f0 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -33,6 +33,7 @@ diffpatterns="
 	css
 	fortran
 	fountain
+	golang
 	html
 	java
 	matlab
diff --git a/t/t4018/golang-complex-function b/t/t4018/golang-complex-function
new file mode 100644
index 000000000..e057dcefe
--- /dev/null
+++ b/t/t4018/golang-complex-function
@@ -0,0 +1,8 @@
+type Test struct {
+	a Type
+}
+
+func (t *Test) RIGHT(a Type) (Type, error) {
+	t.a = a
+	return ChangeMe, nil
+}
diff --git a/t/t4018/golang-func b/t/t4018/golang-func
new file mode 100644
index 000000000..8e9c9ac7c
--- /dev/null
+++ b/t/t4018/golang-func
@@ -0,0 +1,4 @@
+func RIGHT() {
+	a := 5
+	b := ChangeMe
+}
diff --git a/t/t4018/golang-interface b/t/t4018/golang-interface
new file mode 100644
index 000000000..553bedec9
--- /dev/null
+++ b/t/t4018/golang-interface
@@ -0,0 +1,4 @@
+type RIGHT interface {
+	a() Type
+	b() ChangeMe
+}
diff --git a/t/t4018/golang-long-func b/t/t4018/golang-long-func
new file mode 100644
index 000000000..ac3a77b5c
--- /dev/null
+++ b/t/t4018/golang-long-func
@@ -0,0 +1,5 @@
+func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
+	anotherLongVariableName AnotherLongType) {
+	a := 5
+	b := ChangeMe
+}
diff --git a/t/t4018/golang-struct b/t/t4018/golang-struct
new file mode 100644
index 000000000..5deda77fe
--- /dev/null
+++ b/t/t4018/golang-struct
@@ -0,0 +1,4 @@
+type RIGHT struct {
+	a Type
+	b ChangeMe
+}
diff --git a/userdiff.c b/userdiff.c
index dbfb4e13c..8f5028f6b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -38,6 +38,15 @@ IPATTERN("fortran",
 	 "|//|\\*\\*|::|[/<>=]="),
 IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
 	 "[^ \t-]+"),
+PATTERNS("golang",
+	 /* Functions */
+	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
+	 /* Structs and interfaces */
+	 "^[ \t]*(type[ \t].*(struct|interface)[ \t]*(\\{[ \t]*)?)",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
+	 "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&\\^=?|&&|\\|\\||<-|\\.{3}"),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
 	 "[^<>= \t]+"),
 PATTERNS("java",
-- 
2.16.1

