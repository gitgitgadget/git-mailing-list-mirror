Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314F5C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1257260F9C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbhJHTMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbhJHTL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:11:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D176BC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:10:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t2so32643678wrb.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ngZ0ar27WWg0VwBar7AyiNjC3RMv1OoTrNDR7TYg3MA=;
        b=KxUsVvgtJdhU4xXqHRD70pjjYUiH7SbFPBPhyVrV5wsZ64ie9qmO5tkbuQMbpEMU/I
         I6gEi1roIbOn5H/q532Q3zsBL2PJG/uvMY2DIYhhTk+EtpdVWzmKTMjWeOhQSriMigQz
         rFcKkiGAEN4LMrXT1N2YEjCxnDFNrpXbbqXpZClrVNIDXOzM1YAdKxJtnm/g2iHA9WSF
         HmEQ+h/M/KjJ6i74skhar+dsjhwJ0YiNb1+oYWJxhObCFfgYCIwlvu/Y7lFuawPRTUib
         Tj+kGY5+6mjvPgdaQ3t5YGnuRwmtwRZikOqFj8e8/1OEsPN21oiOdHbAHGy4bW75amNA
         eX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ngZ0ar27WWg0VwBar7AyiNjC3RMv1OoTrNDR7TYg3MA=;
        b=ivUIVRvO6hLOp3cU8B8bctPnerAw5saRTrVZRQ0M8se+TM4hppBrZk0OGK00daP8X+
         uJq9AQLc8MHfaL0H7zRobRxMFvGetSPV6djKCH2rOf8ZvcUtzp8GU9CxalueJ54E62l3
         v+x1Izf/2eMdt13eHuAmRSHgssvT5zH03JpRg1Ouz8785TqoLgBgObiienbYc7zAR69d
         lQkFe2n8UglelrRx1ZJRCaAsRzsZZAJy8iwnO33b0dkfjpASh0R90V/BO/HtxKtnNIZg
         nkxAyeSPb8rY8Qsrg4MII7qDyICGmghDcdau8nRE6CIKXITNqShdrxse/jYSKzuF406b
         SIeA==
X-Gm-Message-State: AOAM532vaC3W1n5uZxRJ3J19ASmbASpX2/UBet00g1csm1uqUrLz7O3f
        DRkzEvxdOQAEWYMBLUehgegZjPxkQ0Y=
X-Google-Smtp-Source: ABdhPJy/s209MtRInX4nEyxJNafgjotzi34myCAc93z8nfFziZck+pB2BuZEtSSvLnLS9MovyLTpPA==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr6257124wrw.226.1633720199492;
        Fri, 08 Oct 2021 12:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm174306wrc.51.2021.10.08.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:09:59 -0700 (PDT)
Message-Id: <d4ebe45fddc4e357b7f4c5299b26c0cd905fd3f2.1633720197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
        <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 19:09:55 +0000
Subject: [PATCH v2 3/5] userdiff-cpp: tighten word regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

Generally, word regex can be written such that they match tokens
liberally and need not model the actual syntax because it can be assumed
that the regex will only be applied to syntactically correct text.

The regex for cpp (C/C++) is too liberal, though. It regards these
sequences as single tokens:

   1+2
   1.5-e+2+f

and the following amalgams as one token:

   .l      as in str.length
   .f      as in str.find
   .e      as in str.erase

Tighten the regex in the following way:

- Accept + and - only in one position in the exponent. + and - are no
  longer regarded as the sign of a number and are treated by the
  catcher-all that is not visible in the driver's regex.

- Accept a leading decimal point only when it is followed by a digit.

For readability, factor hex- and binary numbers into an own term.

As a drive-by, this fixes that floating point numbers such as 12E5
(with upper-case E) were split into two tokens.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 16 ++++++++--------
 userdiff.c         |  8 +++++++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 63e53a61e62..46c9460a968 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -3,24 +3,24 @@
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,30 +1,30 @@<RESET>
-Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x<RED>.f<RESET><GREEN>.F<RESET>ind); }
+Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x.<RED>find<RESET><GREEN>Find<RESET>); }
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
-<GREEN>(<RESET>1 <RED>-1e10<RESET><GREEN>+1e10<RESET> 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
 // long double<RESET>
 <RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
 // float<RESET>
-120<RED>E5f<RESET><GREEN>E6f<RESET>
+<RED>120E5f<RESET><GREEN>120E6f<RESET>
 // hex<RESET>
-<RED>0xdeadbeaf+8<RESET><GREEN>0xdeadBeaf+7<RESET>ULL
+<RED>0xdeadbeaf<RESET><GREEN>0xdeadBeaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
 // octal<RESET>
 <RED>01234567<RESET><GREEN>01234560<RESET>
 // binary<RESET>
 <RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
 // expression<RESET>
-<RED>1.5-e+2+f<RESET><GREEN>1.5-e+3+f<RESET>
+1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
 // another one<RESET>
-str<RED>.e+65<RESET><GREEN>.e+75<RESET>
-[a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.e<RESET><GREEN>.*e<RESET>
+str.e+<RED>65<RESET><GREEN>75<RESET>
+[a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.<RESET><GREEN>.*<RESET>e
 <GREEN>~<RESET>!a <GREEN>!<RESET>~b c<RED>++<RESET><GREEN>+<RESET> d<RED>--<RESET><GREEN>-<RESET> e*<GREEN>*<RESET>f g<RED>&<RESET><GREEN>&&<RESET>h
 a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
 a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
@@ -30,6 +30,6 @@ a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
 a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
 a<RED>||<RESET><GREEN>|<RESET>b
 a?<GREEN>:<RESET>b
-a<RED>=<RESET><GREEN>==<RESET>b c<RED>+=<RESET><GREEN>+<RESET>d <RED>e-=f<RESET><GREEN>e-f<RESET> g<RED>*=<RESET><GREEN>*<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
+a<RED>=<RESET><GREEN>==<RESET>b c<RED>+=<RESET><GREEN>+<RESET>d e<RED>-=<RESET><GREEN>-<RESET>f g<RED>*=<RESET><GREEN>*<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
 a,b<RESET>
 a<RED>::<RESET><GREEN>:<RESET>b
diff --git a/userdiff.c b/userdiff.c
index d9b2ba752f0..ce2a9230703 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -54,8 +54,14 @@ PATTERNS("cpp",
 	 /* functions/methods, variables, and compounds at top level */
 	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
 	 /* -- */
+	 /* identifiers and keywords */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
+	 /* decimal and octal integers as well as floatingpoint numbers */
+	 "|[0-9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 /* hexadecimal and binary integers */
+	 "|0[xXbB][0-9a-fA-F]+[lLuU]*"
+	 /* floatingpoint numbers that begin with a decimal point */
+	 "|\\.[0-9]+([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
gitgitgadget

