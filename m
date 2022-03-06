Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6318EC433F5
	for <git@archiver.kernel.org>; Sun,  6 Mar 2022 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiCFLRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 06:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiCFLQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 06:16:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4766BDDE
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 03:16:03 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t14so11273448pgr.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 03:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3My/WmEiLFaeEihG+OGGJMsnvwCNSMDvnCJmPksmsA=;
        b=USIE6GWH64xP+PHkm8i3svgDkXAl46lF3JyOd7pHyc/7O0yzxQVuLG+m5EC9YAijBP
         E2D0Y9l9XfD6xRWsdL6edWe/+AQ10p4QYIniZwjKf63i2EVYIPgFVtQKH90xf0Sn+tK5
         W14J73e/xBC8ouAXM6EZqO6/Ee7aklgcF/gFGYno0C3rExtYKiCK4lEl6sKIsBDiaN27
         N2lzIxhBNRujPkoK9bAE2HSo7RpnhOn5hAy+zbXNReyYP5u6+qepF7j1tICf129eB1vN
         Ub/og0E7bVtsckO02uZcgiaOe2st2nvBgsuIYyVu0gBnEvCmr8PP2AM3HIgwUpPeiHny
         tzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3My/WmEiLFaeEihG+OGGJMsnvwCNSMDvnCJmPksmsA=;
        b=DWWVzs9pu2vP8ed2h71OpYviEdrsQifOO6TAts661fld8vc+ulUI9P3BCu7jffTaFD
         3UpLuiyvUtV+4bsG8Q+v2pHCkS5Upbyzolhv8RBh8gZPV0giiw23xqK2rAIlNmCZPiZi
         Oja9yw2tOVTHX3B2lXeb+GBVjrYn3DIvQSnKsFv6ABwMs/4YPe94SIJ9urvrg8qW9T9x
         40wWk1JqkjZFZ90TzRZY7E9JdzTa8XrUYqK+fffzcLwNBJD+YFt8tx/0LSVENOaOVVwV
         FFLpGy87YdP7w4HJ3DQ8q7YnUpz0I5m+V+e8I704xOK9IzH/IKGpw47y/BZkLHMSIa6B
         wwhQ==
X-Gm-Message-State: AOAM532n1GJi4tvURHZp3coXphK6WzYtsXhm+HqtEM7JLbu1gFfuh/8J
        3uS1SmLdjhU8YCHbANxivJYYCG0Zd6PUEVEy
X-Google-Smtp-Source: ABdhPJwQE7gSpG7a5MiZmQl8kt4TicyaJ6nueRPwo/soHi4WmvnrGExrTc5azv9xS+PyhTqyfy5VJg==
X-Received: by 2002:a62:63c1:0:b0:4f6:f215:93cb with SMTP id x184-20020a6263c1000000b004f6f21593cbmr2191324pfb.81.1646565362831;
        Sun, 06 Mar 2022 03:16:02 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id d32-20020a631d60000000b003650a9d8f9asm8861847pgm.33.2022.03.06.03.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:16:02 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
Date:   Sun,  6 Mar 2022 16:45:39 +0530
Message-Id: <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
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
 t/t4018/kotlin-class            |  5 ++++
 t/t4018/kotlin-enum-class       |  5 ++++
 t/t4018/kotlin-fun              |  5 ++++
 t/t4018/kotlin-inheritace-class |  5 ++++
 t/t4018/kotlin-inline-class     |  5 ++++
 t/t4018/kotlin-interface        |  5 ++++
 t/t4018/kotlin-nested-fun       |  9 +++++++
 t/t4018/kotlin-public-class     |  5 ++++
 t/t4018/kotlin-sealed-class     |  5 ++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/kotlin/expect           | 42 +++++++++++++++++++++++++++++++++
 t/t4034/kotlin/post             | 29 +++++++++++++++++++++++
 t/t4034/kotlin/pre              | 29 +++++++++++++++++++++++
 userdiff.c                      | 12 ++++++++++
 15 files changed, 164 insertions(+)
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
index 0000000000..d80e17d2c5
--- /dev/null
+++ b/t/t4034/kotlin/expect
@@ -0,0 +1,42 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 1db2197..ec0a891 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,29 +1,29 @@<RESET>
+println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET><GREEN>y<RESET>
+a <RED>shr<RESET><GREEN>shl<RESET> b
+<RED>a<RESET><GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET> and <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET> or <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b a<RESET><GREEN>y x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET><GREEN>y<RESET>
+a<RED>=<RESET><GREEN>+=<RESET>b c<RED>+=<RESET><GREEN>=<RESET>d e<RED>-=<RESET><GREEN><=<RESET>f g<RED>*=<RESET><GREEN>>=<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
+a<RED><<=<RESET><GREEN><=<RESET>b
+a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&<RESET><GREEN>&<RESET>b
+<RED>a<RESET><GREEN>x<RESET>,y
+--a<RED>==<RESET><GREEN>!=<RESET>--b
+a++<RED>==<RESET><GREEN>!=<RESET>++b
+<RED>0xFF_EC_DE_5E 0b100_000 100_000<RESET><GREEN>0xFF_E1_DE_5E 0b100_100 200_000<RESET>
+a<RED>==<RESET><GREEN>===<RESET>b
+a<RED>!!<RESET><GREEN>!=<RESET>b
+<RED>_32<RESET><GREEN>_33<RESET>.find(arr)
+X.<RED>fill<RESET><GREEN>find<RESET>()
+X.<RED>u<RESET><GREEN>f<RESET>+1
+X.u<RED>-<RESET><GREEN>+<RESET>2
+a<RED>.<RESET><GREEN>..<RESET>b
+a<RED>?.<RESET><GREEN>?:<RESET>b
diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
new file mode 100644
index 0000000000..ec0a8919e9
--- /dev/null
+++ b/t/t4034/kotlin/post
@@ -0,0 +1,29 @@
+println("Hello World?")
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x x.inv() x*y x&y
+x*y x/y x%y
+x+y x-y
+a shl b
+x<y x<=y x>y x>=y
+x==y x!=y x===y
+x and y
+x^y
+x or y
+x&&y x||y
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+a+=b c=d e<=f g>=h i/j k%l m<<n o>>p q&r s^t u|v
+a<=b
+a|b a&b
+x,y
+--a!=--b
+a++!=++b
+0xFF_E1_DE_5E 0b100_100 200_000
+a===b
+a!=b
+_33.find(arr)
+X.find()
+X.f+1
+X.u+2
+a..b
+a?:b
diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
new file mode 100644
index 0000000000..1db2197baa
--- /dev/null
+++ b/t/t4034/kotlin/pre
@@ -0,0 +1,29 @@
+println("Hello World!\n")
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a a.inv() a*b a&b
+a*b a/b a%b
+a+b a-b
+a shr b
+a<b a<=b a>b a>=b
+a==b a!=b a===b
+a and b
+a^b
+a or b
+a&&b a||b
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a=b c+=d e-=f g*=h i/=j k%=l m<<=n o>>=p q&=r s^=t u|=v
+a<<=b
+a||b a&&b
+a,y
+--a==--b
+a++==++b
+0xFF_EC_DE_5E 0b100_000 100_000
+a==b
+a!!b
+_32.find(arr)
+X.fill()
+X.u+1
+X.u-2
+a.b
+a?.b
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..cd2155bbfe 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,18 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("kotlin",
+	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 /* hexadecimal and binary numbers */
+	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
+	 /* integers and floats */
+	 "|[0-9][.]?[0-9_]+([Ee][-+]?[0-9]+)?[fFlL]*"
+	 /* floating point numbers beginning with decimal point */
+	 "|[.][0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
+	 /* unary and binary operators */
+	 "|[-+*/<>%&^|=!]?==?|--|\\+\\+|<<?=?|>>?=?|&&|\\|[|]?|->|\\.\\*|!!|::|[?:.][.:]"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1

