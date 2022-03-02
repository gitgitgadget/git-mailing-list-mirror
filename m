Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC777C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiCBO12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiCBO11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:27:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EDC5DB2
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:26:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1986134pjb.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/jZmwdDaGjdjlhtPY8p3rQNqA1xOpu9JkMqwDOKc34=;
        b=PBRyUQFdVWooq8hGMO8yz5dOoEOBSucpvfkwrv+UUy8pE7zJxS08Q+gGVSizEme/Lc
         Tb8GoFbQ+6lpPhiThO1R8mvpv45du9tGDFS9CAbRsuzRRFicoy7KP27r90AAWX6qo0kb
         oPvlyuX5kqvggaZrpdOA5owDq+BiU7Done2Kh1ZQT2RZKWJzwYrhMxkJO977ZHpQ4kix
         UtS5KyU+LNGlbIdraDXVEdxGfx+jT4XnRo4kk9M9lmrM54scIQgeEj3d9+0h0Vxd4Orv
         H6mwcKTb545ni9TektAi/hQAKegXNowR3gjDtXQfRPniJx+nphKeLBC2SD3FF6jc5LjZ
         5L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/jZmwdDaGjdjlhtPY8p3rQNqA1xOpu9JkMqwDOKc34=;
        b=ih7qA1nI55ntllILNA/8lLDJdSdsWbiBVwTCcrGJLutVDU8MPtdR8n53/Lb7hecAQd
         po7QKg47+icOn51iWNvqu4C31ezp5++hn4Gx+rEHOBzXTGHE5E9OPW/0F0Zaio1LbKNY
         sE3xRUzA8eDydA5NhrQJ2UcrTBD7jxd6D1KLJVtVkCBFYmMuTGkToTuhOUsBJzqqu1jF
         OmqTobGJ/KlcocMjCptzd36oKwoS1FmvK9lyr2wR5d77UBOF+d/2KPfgBsu3FAIXuU6L
         GWqoNpnsJoX++1IV9kkxpAUIaigGjB/qsm4bJG+R3kNZ7Rv7WjbZV5y03fDk++XaYJge
         Z5HQ==
X-Gm-Message-State: AOAM53008bLPEj2zfbCsI/IcBCP3MvJP8tZibqwr6ky8ICwldpmgg0G5
        MWDfQq/U8agzWU638E+EEfdLExISKTEI3g==
X-Google-Smtp-Source: ABdhPJy9cB36kGyEO6RVp4YZLTYip+qRM0oblPSUU6vF4GgeB31zXmDOS9lKLo3a5T1CgtT0ZozSGw==
X-Received: by 2002:a17:902:654b:b0:14d:964d:7578 with SMTP id d11-20020a170902654b00b0014d964d7578mr30668887pln.166.1646231203422;
        Wed, 02 Mar 2022 06:26:43 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id k21-20020a056a00169500b004f65bbfca3asm2349218pfc.57.2022.03.02.06.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:26:43 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH] userdiff: add builtin driver for kotlin language
Date:   Wed,  2 Mar 2022 19:56:08 +0530
Message-Id: <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
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
 t/t4034/kotlin/expect           | 34 +++++++++++++++++++++++++++++++++
 t/t4034/kotlin/post             | 21 ++++++++++++++++++++
 t/t4034/kotlin/pre              | 21 ++++++++++++++++++++
 userdiff.c                      | 10 ++++++++++
 15 files changed, 138 insertions(+)
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
index 0000000000..7062b67319
--- /dev/null
+++ b/t/t4034/kotlin/expect
@@ -0,0 +1,34 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 3cfa271..20d26cc 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,21 +1,21 @@<RESET>
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
diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
new file mode 100644
index 0000000000..20d26cca5f
--- /dev/null
+++ b/t/t4034/kotlin/post
@@ -0,0 +1,21 @@
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
diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
new file mode 100644
index 0000000000..3cfa271e37
--- /dev/null
+++ b/t/t4034/kotlin/pre
@@ -0,0 +1,21 @@
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
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..bb701100c6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,16 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("kotlin",
+	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
+	 /* -- */
+	 "[_]?[a-zA-Z][a-zA-Z0-9_]*"
+	 /* hexadecimal and binary numbers */
+	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
+	 /* integers and floats */
+	 "|[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 /* unary and binary operators */
+	 "|[-+*/<>%&^|=!]?=(=)?|--|\\+\\+|<<?=?|>>?=?|&&?|[|]?\\||\\|->\\*?|\\.\\*"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1

