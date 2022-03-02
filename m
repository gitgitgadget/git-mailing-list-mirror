Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B670BC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 06:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbiCBGqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCBGqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 01:46:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350C60DA8
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 22:45:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso3970321pjk.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KH+ebvWvKhtkz4HuH8qacZXBxY19agpNpp6K7pOn9A=;
        b=NQ/mlMnJ+rHCnl4f7EBOPrCs0WiX5NECzykxp2zs4ynfa0dK4o8yW5RW+ddl3LPRyi
         0WnlmnHUvamNdsadVqXD6pC7nWCf/J2DlIU3WXVCKRv1tH9pbLbcU0wbY1njqZhqN0sz
         lVdRZ+I5q7fA3Sw2/1oU0Gfk9RlcO882FVLtTmjE2W99UNLAWunAuncqoVO9zRHJMZkV
         2EkJJwglU63C6WTtYyAqsAjAroV2Y1qgwRqQ+ZfP5fVGGAq5MTNea8HXLqHjfKa4IyLf
         lVDp+kxBE0Gk6RerOKVbKHWirsFTy2HhQ5f7mI92DEOG35Uo+o7eqZjccSf4Oxvuzjkj
         yR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KH+ebvWvKhtkz4HuH8qacZXBxY19agpNpp6K7pOn9A=;
        b=0liYhPHtsffrihnOCMtLMVv9M5HM1KPrv9WSPrsv7yqOsoIJ+q+WNOSQqZWjioghr0
         8xz6Jglx+k/21rcOB+N/n5TE7YXnqwUHkJr8jQjpngB8bd9I15LBGRx5rwrmPdggTSIU
         a8in61culYq0UUGIjRbpmkZUUcjlLzDkQ7hV0u1x5TYQLkjI+5ARwjaEOjHxk+ktJYpY
         vCy5zHJZqvdt+JkbIGgb2eg87S4T26nG3H2kp3NTnleguMMn8yo0DB4w/XnQO98BQbJD
         xuPBiEC05KdP/Oxg8gvune6Sh+qhtKi+UcDvtbMuf7CFwiCCf8p2TEzMaQGGXec6rgxv
         9Wlg==
X-Gm-Message-State: AOAM530qJe3AOBkSXHtu7OFPN2QrXNZ5THb86ihhBAFOxAEwk7qxDqLc
        PoBzH53kcxxLmFYpc6hgUJ3EElM/CpJ5KA==
X-Google-Smtp-Source: ABdhPJypoRC6wJukbZPopPcpB6QzexkWQmCkWjGfx0icdsZJB/8HhNZdNNsTdw/CIOrQ3zT/qMpLyA==
X-Received: by 2002:a17:90b:68d:b0:1bc:e9d5:b076 with SMTP id m13-20020a17090b068d00b001bce9d5b076mr25798748pjz.233.1646203533010;
        Tue, 01 Mar 2022 22:45:33 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id nk11-20020a17090b194b00b001beed2f1046sm1790165pjb.28.2022.03.01.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:45:32 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH] userdiff: add builtin driver for kotlin language
Date:   Wed,  2 Mar 2022 12:15:04 +0530
Message-Id: <20220302064504.2651079-2-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302064504.2651079-1-jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-1-jaydeepjd.8914@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xfuncname pattern finds func/class declarations
in diffs to display as a hunk header. The word_regex
pattern finds individual tokens in Kotlin code to generate
appropriate diffs.

This patch adds xfuncname regex and word_regex for Kotlin
language.

Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
---
 Documentation/gitattributes.txt |  2 ++
 t/t4018/kotlin-class            |  5 +++++
 t/t4018/kotlin-enum-class       |  5 +++++
 t/t4018/kotlin-fun              |  5 +++++
 t/t4018/kotlin-inheritace-class |  5 +++++
 t/t4018/kotlin-inline-class     |  5 +++++
 t/t4018/kotlin-interface        |  5 +++++
 t/t4018/kotlin-nested-fun       |  9 +++++++++
 t/t4018/kotlin-public-class     |  5 +++++
 t/t4018/kotlin-sealed-class     |  5 +++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/kotlin/expect           | 35 +++++++++++++++++++++++++++++++++
 t/t4034/kotlin/post             | 19 ++++++++++++++++++
 t/t4034/kotlin/pre              | 19 ++++++++++++++++++
 userdiff.c                      |  8 ++++++++
 15 files changed, 133 insertions(+)
 create mode 100644 t/t4018/kotlin-class
 create mode 100644 t/t4018/kotlin-enum-class
 create mode 100644 t/t4018/kotlin-fun
 create mode 100644 t/t4018/kotlin-inheritace-class
 create mode 100644 t/t4018/kotlin-inline-class
 create mode 100644 t/t4018/kotlin-interface
 create mode 100644 t/t4018/kotlin-nested-fun
 create mode 100644 t/t4018/kotlin-public-class
 create mode 100644 t/t4018/kotlin-sealed-class
 create mode 100644 t/t4034/kotlin/expect
 create mode 100644 t/t4034/kotlin/post
 create mode 100644 t/t4034/kotlin/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a71dad2674..4b36d51beb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -829,6 +829,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `kotlin` suitable for source code in the Kotlin language.
+
 - `markdown` suitable for Markdown documents.
 
 - `matlab` suitable for source code in the MATLAB and Octave languages.
diff --git a/t/t4018/kotlin-class b/t/t4018/kotlin-class
new file mode 100644
index 0000000000..bb864f22e6
--- /dev/null
+++ b/t/t4018/kotlin-class
@@ -0,0 +1,5 @@
+class RIGHT {
+	//comment
+	//comment
+	return ChangeMe
+}
diff --git a/t/t4018/kotlin-enum-class b/t/t4018/kotlin-enum-class
new file mode 100644
index 0000000000..8885f908fd
--- /dev/null
+++ b/t/t4018/kotlin-enum-class
@@ -0,0 +1,5 @@
+enum class RIGHT{
+	// Left
+	// a comment
+	ChangeMe
+}
diff --git a/t/t4018/kotlin-fun b/t/t4018/kotlin-fun
new file mode 100644
index 0000000000..2a60280256
--- /dev/null
+++ b/t/t4018/kotlin-fun
@@ -0,0 +1,5 @@
+fun RIGHT(){
+	//a comment
+	//b comment
+    return ChangeMe()
+}
diff --git a/t/t4018/kotlin-inheritace-class b/t/t4018/kotlin-inheritace-class
new file mode 100644
index 0000000000..77376c1f05
--- /dev/null
+++ b/t/t4018/kotlin-inheritace-class
@@ -0,0 +1,5 @@
+open class RIGHT{
+	// a comment
+	// b comment
+	// ChangeMe
+}
diff --git a/t/t4018/kotlin-inline-class b/t/t4018/kotlin-inline-class
new file mode 100644
index 0000000000..7bf46dd8d4
--- /dev/null
+++ b/t/t4018/kotlin-inline-class
@@ -0,0 +1,5 @@
+value class RIGHT(Args){
+	// a comment
+	// b comment
+	ChangeMe
+}
diff --git a/t/t4018/kotlin-interface b/t/t4018/kotlin-interface
new file mode 100644
index 0000000000..f686ba7770
--- /dev/null
+++ b/t/t4018/kotlin-interface
@@ -0,0 +1,5 @@
+interface RIGHT{
+	//another comment
+	//another comment
+	//ChangeMe
+}
diff --git a/t/t4018/kotlin-nested-fun b/t/t4018/kotlin-nested-fun
new file mode 100644
index 0000000000..12186858cb
--- /dev/null
+++ b/t/t4018/kotlin-nested-fun
@@ -0,0 +1,9 @@
+class LEFT{
+	class CENTER{
+		fun RIGHT(  a:Int){
+			//comment
+			//comment
+			ChangeMe
+		}
+	}
+}
diff --git a/t/t4018/kotlin-public-class b/t/t4018/kotlin-public-class
new file mode 100644
index 0000000000..9433fcc226
--- /dev/null
+++ b/t/t4018/kotlin-public-class
@@ -0,0 +1,5 @@
+public class RIGHT{
+	//comment1
+	//comment2
+	ChangeMe
+}
diff --git a/t/t4018/kotlin-sealed-class b/t/t4018/kotlin-sealed-class
new file mode 100644
index 0000000000..0efa4a4eaf
--- /dev/null
+++ b/t/t4018/kotlin-sealed-class
@@ -0,0 +1,5 @@
+sealed class RIGHT {
+	// a comment
+	// b comment
+	ChangeMe
+}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index d5abcf4b4c..15764ee9ac 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -324,6 +324,7 @@ test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver kotlin
 test_language_driver matlab
 test_language_driver objc
 test_language_driver pascal
diff --git a/t/t4034/kotlin/expect b/t/t4034/kotlin/expect
new file mode 100644
index 0000000000..8acdc83bcc
--- /dev/null
+++ b/t/t4034/kotlin/expect
@@ -0,0 +1,35 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 884560d..7e136e2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,19 +1,19 @@<RESET>
+println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+<RED>100000<RESET><GREEN>100_000<RESET>
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET><GREEN>y<RESET>
+a<RED>+=<RESET><GREEN>-=<RESET>b
+<RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET> shl <RED>b a<RESET><GREEN>y x<RESET> shr <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET> and <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET> or <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
+-<RED>a<RESET><GREEN>x<RESET>+2
diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
new file mode 100644
index 0000000000..7e136e2bb4
--- /dev/null
+++ b/t/t4034/kotlin/post
@@ -0,0 +1,19 @@
+println("Hello World?")
+(1) (-1e10) (0xabcdef) 'y'
+100_000
+[x] x->y x.y
+!x x.inv() x*y x&y
+a-=b
+x*y x/y x%y
+x+y x-y
+x shl y x shr y
+x<y x<=y x>y x>=y
+x==y x!=y x===y
+x and y
+x^y
+x or y
+x&&y
+x||y
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
+-x+2
diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
new file mode 100644
index 0000000000..884560d60f
--- /dev/null
+++ b/t/t4034/kotlin/pre
@@ -0,0 +1,19 @@
+println("Hello World!\n")
+1 -1e10 0xabcdef 'x'
+100000
+[a] a->b a.b
+!a a.inv() a*b a&b
+a+=b
+a*b a/b a%b
+a+b a-b
+a shl b a shr b
+a<b a<=b a>b a>=b
+a==b a!=b a===b
+a and b
+a^b
+a or b
+a&&b
+a||b
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
+-a+2
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..b92572b582 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,14 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("kotlin",
+	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
+	 /* -- */
+	 "[_]?[a-zA-Z][a-zA-Z0-9_]*"
+	 /*hexadecimal, integers and binary numbers*/
+	 "|(0x0F|0b)?[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 /*match unary and binary operators*/
+	 "|[-+*/<>%&^|=!]*"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1

