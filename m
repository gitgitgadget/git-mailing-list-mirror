Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78641C433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F77160F58
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhJJRFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhJJRFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:05:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6461CC061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y3so14727579wrl.1
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/JFOu18bI6ZDnCyvpp97l+zqeYnrFVFqOP4uPer1+s=;
        b=kF1GLObII+JSxbpYxJQEuDL3XpLzA9AfVlrkm1OzsX2RiJ6/Tu+moxavuVuFCPPcGz
         Bs3XO135TOWhU8xLfO9bjyr2xCqIeow/wAOkpgj035Gb52bQHvl7MWVZkKBiAvXGjuRG
         FTxVqGdxIU7Lf7JqKO9EogFOW2FM8UdVI61+H/qst/bWwxQhzr4nl4YyGu4r2qJIX28v
         XRZ3HTUcIs4WaCmEwekpgHk3mxOc+k3V9C8z3MqbL6OqQyo4unewZSNG53L4e8PrF9pj
         J732dLFUpEHrIwvSpwtQQfmN6keALZMZeyX/M7l4hdSE+aB5Sbi6MD6zwBNHKgefHRv2
         4PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L/JFOu18bI6ZDnCyvpp97l+zqeYnrFVFqOP4uPer1+s=;
        b=e0194nrw7eMfLp0Ev7VsILU0smt9j2l5fBiUvK62mf1eCLT0+dFFI8AU/Ot7DMBTUO
         uR2V+uvH1JRkDDszXbyU1NrYwg75ArfDFqUH/Rmf4EV0pslv2jpagbC7UKKcgfrYOUNJ
         TleEd6z7QE0ZocGuG74qUNmdfStDNoJdZBFUtThET/PwUQu8wovjKmcm3yA/1ZkjGoOw
         EXSM/k3oUtKqRhVdsfg0xTkdVzSiJfIS22y0AqMBMhn4cyOoFoyNbxr2+XAIOKRfpiRO
         4AMaoz4HGlC0Yrn2300rWUDx/YaheLEroJeWfZwRXsallCWi+7v3KdnaN0XYusb22qPs
         lsiA==
X-Gm-Message-State: AOAM5305ZhQsOmq6PTDebtiR4u/XWjCXZ1Zp5YHMQJW32rnJQfmyNExO
        oPtaX4yvIdjxYkJr3Rg81hpN1ge6Iys=
X-Google-Smtp-Source: ABdhPJxnVTNo96umpu5oufxBSZHuApd2AvjXYKpRpfzAQB9WYBsUSRKvEOHu58MaZEYDpVROza3PAA==
X-Received: by 2002:a1c:a443:: with SMTP id n64mr16451733wme.32.1633885387998;
        Sun, 10 Oct 2021 10:03:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm18116423wmb.41.2021.10.10.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:03:07 -0700 (PDT)
Message-Id: <c9f58b5e82f2de4d4c3c9cee651e295ed935f63b.1633885384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
        <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Oct 2021 17:03:02 +0000
Subject: [PATCH v3 4/6] userdiff-cpp: prepare test cases with yet unsupported
 features
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

We are going to add support for C++'s digit-separating single-quote and
the spaceship operator. By adding the test cases in this separate
commit, the effect on the word highlighting will become more obvious
as the features are implemented and the file cpp/expect is updated.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 14 +++++++-------
 t/t4034/cpp/post   | 12 ++++++------
 t/t4034/cpp/pre    | 10 +++++-----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 46c9460a968..3d37ddac42c 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,21 +1,21 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 1229cdb..3feae6f 100644<RESET>
+<BOLD>index 144cd98..64e78af 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,30 +1,30 @@<RESET>
 Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x.<RED>find<RESET><GREEN>Find<RESET>); }
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
-<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>.<RESET>'
 // long double<RESET>
-<RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
+3.141'592'<RED>653e-10l<RESET><GREEN>654e+10l<RESET>
 // float<RESET>
 <RED>120E5f<RESET><GREEN>120E6f<RESET>
 // hex<RESET>
-<RED>0xdeadbeaf<RESET><GREEN>0xdeadBeaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
+0xdead'<RED>beaf<RESET><GREEN>Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
 // octal<RESET>
-<RED>01234567<RESET><GREEN>01234560<RESET>
+0123'<RED>4567<RESET><GREEN>4560<RESET>
 // binary<RESET>
-<RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
+<RED>0b10<RESET><GREEN>0b11<RESET>'00+e1
 // expression<RESET>
 1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
 // another one<RESET>
@@ -25,7 +25,7 @@ str.e+<RED>65<RESET><GREEN>75<RESET>
 a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
 a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
 a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
-a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
+a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<=<GREEN>><RESET>j
 a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
 a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
 a<RED>||<RESET><GREEN>|<RESET>b
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index 3feae6f430f..64e78afbfb5 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -1,16 +1,16 @@
 Foo() : x(0&42) { bar(x.Find); }
 cout<<"Hello World?\n"<<endl;
-(1 +1e10 0xabcdef) 'y'
+(1 +1e10 0xabcdef) '.'
 // long double
-3.141592654e+10l
+3.141'592'654e+10l
 // float
 120E6f
 // hex
-0xdeadBeaf+7ULL
+0xdead'Beaf+7ULL
 // octal
-01234560
+0123'4560
 // binary
-0b1100+e1
+0b11'00+e1
 // expression
 1.5-e+3+f
 // another one
@@ -20,7 +20,7 @@ str.e+75
 a*=b c/=d e%=f
 a++b c--d
 a<<=b c>>=d
-a<=b c<d e>=f g>h
+a<=b c<d e>=f g>h i<=>j
 a!=b c=d
 a^=b c|=d e&=f
 a|b
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index 1229cdb59d1..144cd980d6b 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -2,15 +2,15 @@ Foo():x(0&&1){ foo0( x.find); }
 cout<<"Hello World!\n"<<endl;
 1 -1e10 0xabcdef 'x'
 // long double
-3.141592653e-10l
+3.141'592'653e-10l
 // float
 120E5f
 // hex
-0xdeadbeaf+8ULL
+0xdead'beaf+8ULL
 // octal
-01234567
+0123'4567
 // binary
-0b1000+e1
+0b10'00+e1
 // expression
 1.5-e+2+f
 // another one
@@ -20,7 +20,7 @@ str.e+65
 a*b c/d e%f
 a+b c-d
 a<<b c>>d
-a<b c<=d e>f g>=h
+a<b c<=d e>f g>=h i<=j
 a==b c!=d
 a^b c|d e&&f
 a||b
-- 
gitgitgadget

