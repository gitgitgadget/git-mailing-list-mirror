Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19838C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 18:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiCCSQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiCCSQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 13:16:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A21965EA
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 10:15:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 9so5326340pll.6
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 10:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=muMgvscjWjLvgJAcS8rQ7U1zH4r8sWwf35fmC9tEPv8=;
        b=fCIaxUilqYLqQxaSADOk84ijG8s51nWX3xC1PGIjmNld9n3XassD4XwvDWebLac/3+
         gZR7BWlffh7WkdPZSkQUGCprgYarnWDr5w/mWzpb96ZFGapawQ9nFHc85gGnLZEO6pY7
         mu1K5wYItDRB/Cl+PiUPwiFhK4ZPqKpxOKnjI8Eh59ofthWK7uccyvo5H6wNZz8P6Mkq
         Wdvs/ma3SGrpYarwHa+0jZIe+bEKEtYDlT8rZpmjSfAj5hVF4sKNX0tAkefqRYU8HluB
         mZtkdDkkFtrbYE73wQMMpEdxwYEWBVLtg8DPgI08zeg/mg2yxdNX7q7Mn/uIOql2TK24
         KMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muMgvscjWjLvgJAcS8rQ7U1zH4r8sWwf35fmC9tEPv8=;
        b=dRnVptwBHJNHYRCXAtVLrRP/LMdvG/E/glPw3w85K/BL8HqbDSsrAgXZvtljx44iDD
         3BDDzcmqNMn5jwzlxUK3GKu5kvLivuja8I5SOtzg1HqhmjOChjedwfAf2iy2Rt+ZMVy8
         FEIUqtiHeaKPCp08tbmqx1D7TrWqv9eT1EaBiNBM1X7sKfKP9n/Gt3HgVy5GBrSpimoT
         DU7iLtuq+tWIQBnRJkcygBI/biF8rldyblIB7NhNYcZN2GGV0vH4ci8qv/9VpX9TIdhf
         pnuOHwfugRHjYko7pAGcL2tmj0TUVNd5gSpWmPjP115FlvP/dhnL2G3PTk4BaUzu+Sa8
         1gGA==
X-Gm-Message-State: AOAM532DI/dr5HqMn07Qn62UbAMKJ5Lz0DYIYhv+TJTcC8Qt2sHneCwS
        Mz+boof/y0uniupieK0BCAGy44kHzCwT+g==
X-Google-Smtp-Source: ABdhPJw/XzwpIvAB2/bCxDwi8q1gQoOLdnXjKlaY+5NJns8lRNIbWc2QdYBs20kl+oXCPdK94N4Q2w==
X-Received: by 2002:a17:903:32c3:b0:151:58b1:adf8 with SMTP id i3-20020a17090332c300b0015158b1adf8mr25390740plr.29.1646331339224;
        Thu, 03 Mar 2022 10:15:39 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id d25-20020a639919000000b00364f999aed5sm2564552pge.20.2022.03.03.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 10:15:38 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH] userdiff: add builtin diff driver for Kotlin language.
Date:   Thu,  3 Mar 2022 23:45:17 +0530
Message-Id: <20220303181517.70682-1-jaydeepjd.8914@gmail.com>
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
 t/t4018/kotlin-class            |  5 +++++
 t/t4018/kotlin-enum-class       |  5 +++++
 t/t4018/kotlin-fun              |  5 +++++
 t/t4018/kotlin-inheritace-class |  5 +++++
 t/t4018/kotlin-inline-class     |  5 +++++
 t/t4018/kotlin-interface        |  5 +++++
 t/t4018/kotlin-nested-fun       |  9 ++++++++
 t/t4018/kotlin-public-class     |  5 +++++
 t/t4018/kotlin-sealed-class     |  5 +++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/kotlin/expect           | 37 +++++++++++++++++++++++++++++++++
 t/t4034/kotlin/post             | 24 +++++++++++++++++++++
 t/t4034/kotlin/pre              | 24 +++++++++++++++++++++
 userdiff.c                      | 12 +++++++++++
 15 files changed, 149 insertions(+)
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
index 0000000000..f135eb2ab0
--- /dev/null
+++ b/t/t4034/kotlin/expect
@@ -0,0 +1,37 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index a569cfc..c4b213b 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,24 +1,24 @@<RESET>
+println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<RED>1 -1e10 <RESET><GREEN>(1) (-1e10) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a.b<RESET><GREEN>y x.y<RESET>
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
+<RED>_32<RESET><GREEN>_33<RESET>.find(arr)
+X<RED>.fill()<RESET><GREEN>.find()<RESET>
diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
new file mode 100644
index 0000000000..c4b213b89e
--- /dev/null
+++ b/t/t4034/kotlin/post
@@ -0,0 +1,24 @@
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
+_33.find(arr)
+X.find()
diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
new file mode 100644
index 0000000000..a569cfcc6e
--- /dev/null
+++ b/t/t4034/kotlin/pre
@@ -0,0 +1,24 @@
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
+_32.find(arr)
+X.fill()
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..b98961dd55 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,18 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("kotlin",
+	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
+	 /* -- */
+	 "(_*[a-zA-Z]|_+[0-9])[a-zA-Z0-9_]*"
+	 /* hexadecimal and binary numbers */
+	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
+	 /* integers and floats */
+	 "|[^_\n][0-9_.]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]"
+	 /* method calls */
+	 "|[.][a-zA-Z()0-9]+"
+	 /* unary and binary operators */
+	 "|[-+*/<>%&^|=!]?=(=)?|--|\\+\\+|<<?=?|>>?=?|&&?|[|]?\\||\\|->\\*?|\\.\\*"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1

