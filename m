Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49FC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbeB1R3i (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:29:38 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52100 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932583AbeB1R3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:29:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id h21so6541022wmd.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vnJhyEiZXVXQ6957RtChD6JtNCK/7w+t8ePhLEjpYoM=;
        b=PRsgEKwO19O7Y+Tvk3v6Z63RVzJSF/X6HUUKh+ANpjDfwOBycBBA7H8aUI0XRmH0BS
         YkIe7hEpoLpnhGiwrzrU1W+9RVzV/ANA2F5pzKu0neaiLpVKckOH/Tv9uEdyxej60vCk
         YQOouhFNvegPJFY+q03vFviIzixeLWBmQwoEYV5Zhv/YnioQ5LZpWsYPRZcYorD3vs8t
         XxcODW2Xi4W1xdBki1QZHuB6hn6nkBGbiHwCHjnHQrtamlhXUm5k5295tPZqGXqyLBMh
         TsNw7Cvgk7HDK7wJPBXqWHSwmUWM7cADuls7oD5b7j434e6L+vR5vr1dBGE9v2L8ZiHu
         IFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vnJhyEiZXVXQ6957RtChD6JtNCK/7w+t8ePhLEjpYoM=;
        b=XqmRq2pHRtmc8bWQ5U40Tpw5EmKtLSpEGEBX6LAccOG3qR0jVU7310EvmJVjx9rcv0
         m0mx8k2NyxxRu10Y8+3pv11TF7AlOn7pD5GUEOuiDz8E/EnasvGtueEX+HJcVnAFTUQp
         7vLCl2jkpJCYsIgKJTG26MyvMYITPcM+meg+tSzjubZuFMKxBdsG4hTz+XSlfWGOBKxl
         uLcEia58Efsj+CPvop5J0gtQ76xO00tPFKxTIKLJxLAOynbtMy1Lvki2n/e56LxabSpM
         0HSNQZ3fCzZ4buWrPgg8iCh8vAa21lv7/awGr/STSGtYMxjhGT2cRsiMVtEyJK4LhGfx
         fWxA==
X-Gm-Message-State: APf1xPAfHb/KaMj8Q3VCBvHQSeFlxy4SqP7g8EPkPbFTj0RkxDq9Cnj4
        Q7vLrwappRAqzyQOrfUNMPsv2ID8
X-Google-Smtp-Source: AG47ELsB6i+hIyhxuJ7L8qObUQyy5d+hYAbjoWSJdCkpQkUroKTYN6CEZK6WrZJp6bI2G9je55fi2w==
X-Received: by 10.28.214.4 with SMTP id n4mr16200093wmg.46.1519838974594;
        Wed, 28 Feb 2018 09:29:34 -0800 (PST)
Received: from localhost.localdomain (AToulouse-658-1-45-219.w86-221.abo.wanadoo.fr. [86.221.52.219])
        by smtp.gmail.com with ESMTPSA id u136sm2267332wmf.0.2018.02.28.09.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 09:29:33 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH] userdiff: add built-in pattern for golang
Date:   Wed, 28 Feb 2018 18:29:06 +0100
Message-Id: <20180228172906.30582-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds xfuncname and word_regex patterns for golang, a quite
popular programming language. It also includes test cases for the
xfuncname regex (t4018) and an updated documentation.

The xfuncname regex finds functions, structs and interfaces. The
word_regex pattern finds identifiers, integers, floats, complex
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
index 000000000..a9211ed18
--- /dev/null
+++ b/t/t4018/golang-complex-function
@@ -0,0 +1,8 @@
+type Test struct {
+	a Type
+}
+
+func (t *Test) RIGHT(a Type) (Type, error) {
+	t.a = a
+        return ChangeMe, nil
+}
diff --git a/t/t4018/golang-func b/t/t4018/golang-func
new file mode 100644
index 000000000..b17698218
--- /dev/null
+++ b/t/t4018/golang-func
@@ -0,0 +1,4 @@
+func RIGHT() {
+	a := 5
+        b := ChangeMe
+}
diff --git a/t/t4018/golang-interface b/t/t4018/golang-interface
new file mode 100644
index 000000000..2e03d4fc0
--- /dev/null
+++ b/t/t4018/golang-interface
@@ -0,0 +1,4 @@
+type RIGHT interface {
+	a() Type
+        b() ChangeMe
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
index 000000000..5cd70c8dc
--- /dev/null
+++ b/t/t4018/golang-struct
@@ -0,0 +1,4 @@
+type RIGHT struct {
+	a Type
+        b ChangeMe
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

