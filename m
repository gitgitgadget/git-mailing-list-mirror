Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 15:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiCAPzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiCAPzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 10:55:35 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA263443F6
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 07:54:53 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 139so14732416pge.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oAqunByDHte5tiZBa9WFbGvihph398NDBij4nj44So=;
        b=Kd0IxDCgovjxS9bQlqtewluGz6b2CMD2MZ2+02VhTT1Z3K5bTP064aJoGF7byX6aTN
         fpDTpsS5pLFyCfPUeIWkWq3dIxMwTx/OEtKrvIDlczVTJtMaz5hwIYXGjmxAPPpHSfEF
         0pghMYGSfFgggIqmGBC1iCtJlf4woG7egisWyUxgykGVSgQpgPTSg8kyKVo/6I5VAtjO
         m0o2ig1/gA6PgXqM+5D0tZJ9xJ6/Av6rtZgYzdJat3kssvZkQ2ZW5aSYGRq7O0d9Un5T
         AM2LSgcB3GyBvZ/gW4RBd7ujZ2y4Eo5du5+8yuAlbCu4XLAmMQ+/s/ETEAEod8nQnItj
         4ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oAqunByDHte5tiZBa9WFbGvihph398NDBij4nj44So=;
        b=Y6dFlG4mLLqDig870H1kBaAF9r8CV2fO5ft/wGt2Ac7fLQeRPjZN0UC4A/T8083JgI
         8/ZTsJNLYuyUT6yOBpdT8PkSVyqrVFvGbsSM3JCxogKthsOfc9bmDsKSR6rq2Uut0mGE
         1crrgBuiOFgbhOh1iwGsq6dKMLd5jV8DqLC4//T+39Ju0WRZxkrt+fBDgX7T22ClP82M
         JRsWDY6/yoxJR3l1rMjYB/voMO53QSvJjEYnIyA420ffW/3qMLVtXAvcX4jvJ4FRtPsu
         8WfytODljzUOfsJ88NS0HQ7dzKDoZFZ3Nv1xE0EnMsQZ42tmx0EwDqm4cB5MiR3N49N+
         vq3w==
X-Gm-Message-State: AOAM532ZRvKx8oGxU5eKOjSHk+zIM+hx42HtMXvLjXgrVFSWPKTxrKF4
        IblhCNQOKku3iSAG5RWakDmzYjOwZGCIY6Sq
X-Google-Smtp-Source: ABdhPJygvT/40WcEOB9cKgE8CLJwKNw6yav8C4Thu5F+RFSARVIn+5asZBCQNu0KOo3UKuJbm/HyTg==
X-Received: by 2002:a63:1003:0:b0:378:7d70:2ec5 with SMTP id f3-20020a631003000000b003787d702ec5mr12365443pgl.351.1646150093068;
        Tue, 01 Mar 2022 07:54:53 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id l2-20020a637c42000000b003644cfa0dd1sm13142939pgn.79.2022.03.01.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:54:52 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH] userdiff: add builtin diff driver for Kotlin language.
Date:   Tue,  1 Mar 2022 21:24:31 +0530
Message-Id: <20220301155431.2534136-1-jaydeepjd.8914@gmail.com>
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
 t/t4018/kotlin-nested-fun       |  9 +++++++++
 t/t4018/kotlin-public-class     |  5 +++++
 t/t4018/kotlin-sealed-class     |  5 +++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/kotlin/expect           | 33 +++++++++++++++++++++++++++++++++
 t/t4034/kotlin/post             | 16 ++++++++++++++++
 t/t4034/kotlin/pre              | 16 ++++++++++++++++
 userdiff.c                      |  7 +++++++
 15 files changed, 124 insertions(+)
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
index 0000000000..80eea3e386
--- /dev/null
+++ b/t/t4034/kotlin/expect
@@ -0,0 +1,33 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index e8a199a..e6ebebb 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,16 +1,16 @@<RESET>
+println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<RED>0xabcdef<RESET><GREEN>) (0xaybcdef)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET> shl <RED>b a<RESET><GREEN>y x<RESET> shr <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
+<RED>a and b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x xnd y<RESET>
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
diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
new file mode 100644
index 0000000000..e6ebebb5e9
--- /dev/null
+++ b/t/t4034/kotlin/post
@@ -0,0 +1,16 @@
+println("Hello World?")
+(1) (-1e10) (0xaybcdef) 'y'
+[x] x->y x.y
+!x x.inv() x*y x&y
+x*y x/y x%y
+x+y x-y
+x shl y x shr y
+x<y x<=y x>y x>=y
+x==y x!=y x===y
+x xnd y
+x^y
+x or y
+x&&y
+x||y
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
new file mode 100644
index 0000000000..e8a199adb0
--- /dev/null
+++ b/t/t4034/kotlin/pre
@@ -0,0 +1,16 @@
+println("Hello World!\n")
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a a.inv() a*b a&b
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
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..f23f098f19 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,13 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("kotlin",
+	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*[ \t]*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]="
+	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1

