Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D0FC433EF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D583760F4B
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJJRFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhJJRFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:05:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACEC06161C
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so47816906wrc.10
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yYJ/b49QpJ4fkZtCd4pL6lc0TKalwVrQgk6O0OkTjwk=;
        b=YRrV8sC4Fd3F6VdjoE44LH2cXmSsMrUmgcfo3jc/p4Pc6kdc0IZG9BrQHJt+PZd4lU
         iUQ49NWLkmFJbCnKZG4QbcQxm98pjhoQKelmbRole8kN2IfKOAjm5kR0fXgAqrvt+Cr7
         K2w+lppnGuVHRkz0YQ6GKIyEkWhMoDQDsX2Qt9RskRZhgAmveQ7FXGnrIXV7xq/plS4l
         DMAxlqg3RZ37hsUSXlbUAesmZlPAGFf1Fs3R/7lTNeXNALskyEcOyprrMMkZtwjXRAlm
         +H0HwY0geo11ggzdW9hI4ERl6czkBxYc/b05VtLRSwg35xB99ohoXwSySgyKSVVEDElu
         ML5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yYJ/b49QpJ4fkZtCd4pL6lc0TKalwVrQgk6O0OkTjwk=;
        b=E55teyt2U8B6rdKoKv0BUFN9zQV7lk8SE/YNaupqHtwMDNn6LIF7gTAvg5PU9o7HGB
         JH+7wf+DqmTr/vx7rutdccPwqJqCx3tmq7tAy/lv0j13QscuDx/6r0avUT0N5HXVKNkQ
         40a7XxB+iE0rLjYq57dp8W3hOwdE2uXI7hKGIAf6s8MSIXDnLpEtqgGloYjMxruCMtqY
         YdBAuwR5la8srf0zWhE5/U/Q106t3E49e1vJZcpT2YQmrYrnCd7StZ0pSHR9HFP0rVB2
         alGQwMT0CKIK92Ek6qs28kNGsU5wbD2WUpFt2bs0hRbxD6KF4Fy+A9khyp2mBYBjewTP
         kSnA==
X-Gm-Message-State: AOAM530JYI5zsGsIeTvo2XPAEHMTEVQwTeOeexDDAYiaYFS+Mdai8W2F
        ojD7+9efRzrUuT+nYEmn2embE0+3Sr8=
X-Google-Smtp-Source: ABdhPJy2+cqhlRbhJ9IyVII6wQ0/K3cbgk+FgtWk8CrZYHzi7XWhO/37J9xLDlTsCK32Tc2LP4wSsQ==
X-Received: by 2002:a5d:6c62:: with SMTP id r2mr18986021wrz.412.1633885386020;
        Sun, 10 Oct 2021 10:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c204sm18447328wme.11.2021.10.10.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:03:05 -0700 (PDT)
Message-Id: <dd9f82ba712f54245f19df95926050543d25b769.1633885384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
        <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Oct 2021 17:02:59 +0000
Subject: [PATCH v3 1/6] t4034/cpp: actually test that operator tokens are not
 split
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

8d96e7288f2b (t4034: bulk verify builtin word regex sanity, 2010-12-18)
added many tests with the intent to verify that operators consisting of
more than one symbol are kept together. These are tested by probing a
transition from, e.g., a!=b to x!=y, which results in the word-diff

  [-a-]{+x+}!=[-b-]{+y+}

But that proves only that the letters and operators are separate tokens.
To prove that != is an unseparable token, we have to probe a transition
from, e.g., a=b to a!=b having a word-diff

  a[-=-]{+!=+}b

that proves that the ! is not separate from the =.

In the post-image, add to or remove from operators a character that
turns it into another valid operator.

Change the identifiers used around operators such that the diff
algorithm does not have an incentive to match, e.g., a<b in one spot
in the pre-image with a<b elsewhere in the post-image.

Adjust the expected output to match the new differences. Notice that
there are some undesirable tokenizations around e, ., and -.  This will
be addressed in a later change.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 45 +++++++++++++++------------------------------
 t/t4034/cpp/post   | 29 +++++++++++++----------------
 t/t4034/cpp/pre    | 25 +++++++++++--------------
 3 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 37d1ea25870..41976971b93 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,36 +1,21 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 23d5c8a..7e8c026 100644<RESET>
+<BOLD>index c5672a2..4229868 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,19 +1,19 @@<RESET>
+<CYAN>@@ -1,16 +1,16 @@<RESET>
 Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
 <GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
-[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
-!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>&<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>^<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>|<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>&&<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>||<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
-<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>,y
-<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>
+[a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.e<RESET><GREEN>.*e<RESET>
+<GREEN>~<RESET>!a <GREEN>!<RESET>~b c<RED>++<RESET><GREEN>+<RESET> d<RED>--<RESET><GREEN>-<RESET> e*<GREEN>*<RESET>f g<RED>&<RESET><GREEN>&&<RESET>h
+a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
+a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
+a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
+a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
+a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
+a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
+a<RED>||<RESET><GREEN>|<RESET>b
+a?<GREEN>:<RESET>b
+a<RED>=<RESET><GREEN>==<RESET>b c<RED>+=<RESET><GREEN>+<RESET>d <RED>e-=f<RESET><GREEN>e-f<RESET> g<RED>*=<RESET><GREEN>*<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
+a,b<RESET>
+a<RED>::<RESET><GREEN>:<RESET>b
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index 7e8c026cefb..4229868ae62 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -1,19 +1,16 @@
 Foo() : x(0&42) { bar(x); }
 cout<<"Hello World?\n"<<endl;
 (1) (-1e10) (0xabcdef) 'y'
-[x] x->y x.y
-!x ~x x++ x-- x*y x&y
-x*y x/y x%y
-x+y x-y
-x<<y x>>y
-x<y x<=y x>y x>=y
-x==y x!=y
-x&y
-x^y
-x|y
-x&&y
-x||y
-x?y:z
-x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
-x,y
-x::y
+[a] b->*v d.*e
+~!a !~b c+ d- e**f g&&h
+a*=b c/=d e%=f
+a++b c--d
+a<<=b c>>=d
+a<=b c<d e>=f g>h
+a!=b c=d
+a^=b c|=d e&=f
+a|b
+a?:b
+a==b c+d e-f g*h i/j k%l m<<n o>>p q&r s^t u|v
+a,b
+a:b
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index 23d5c8adf54..c5672a24cfc 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -1,19 +1,16 @@
 Foo():x(0&&1){}
 cout<<"Hello World!\n"<<endl;
 1 -1e10 0xabcdef 'x'
-[a] a->b a.b
-!a ~a a++ a-- a*b a&b
-a*b a/b a%b
-a+b a-b
-a<<b a>>b
-a<b a<=b a>b a>=b
-a==b a!=b
-a&b
-a^b
-a|b
-a&&b
+[a] b->v d.e
+!a ~b c++ d-- e*f g&h
+a*b c/d e%f
+a+b c-d
+a<<b c>>d
+a<b c<=d e>f g>=h
+a==b c!=d
+a^b c|d e&&f
 a||b
-a?b:z
-a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
-a,y
+a?b
+a=b c+=d e-=f g*=h i/=j k%=l m<<=n o>>=p q&=r s^=t u|=v
+a,b
 a::b
-- 
gitgitgadget

