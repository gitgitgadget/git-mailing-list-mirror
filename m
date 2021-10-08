Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156A7C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC20C60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhJHTL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhJHTLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:11:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B929C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:09:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so32672327wra.4
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jGKb3bD3PdTJF5JK9UPW+pnauTj2gi9QtPj5hYf3JIE=;
        b=NvZikYOIsfKor6M/wrPp+uDrx7I/eVdRDA8hwy5kr8/2EuZuoKIp5uwDfKm+crNihS
         vXQA48nOI9pDzfOB65exLlescmP4Qr/onSw61KlgK52y2iVhMx2L8q+wLhrqyeuzTFbx
         bloF6HCqh10AVOAB+pow2Jsrw3SbM0unKuc5uzranNL8RSYSrh7Fqie0KTP6rvz5NM2o
         RCRmg9j7O3KPnj9XtZYbymZU98jziqEyYcGQLtTAbffisUA+BPkw/ezDtBzMn4Lr+fg0
         KMAEdXu81+dO7KdVU5Fv3gHUk8YT0EHQUrP5nK7qZQt/YxWTtbQniIhgtawyFpaCXlLO
         UjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jGKb3bD3PdTJF5JK9UPW+pnauTj2gi9QtPj5hYf3JIE=;
        b=LGb6Ur3Qmy1G2646tXP3U5kUdFXTcC3rLm32zFQkA0l2hKFD3s0uu5MpDbbQ2chdjv
         ACLj44ZrDueLRegJCJIqlEh17aEzmc9RJY3FKY1VHmd7xUnOQYnCeeMFFq+DO6F9/DqG
         kb6wKiX9fPN78HbftM+nHhB4HePK6l2NE2zzi7MkBJ9xVStrQS9JFf+vwnSycAUXLFUC
         7GEF4LnObKXR++T2D8am279yALvWhhaqzTLZkm9UBIDNJJtaKdbn6QUc0DmoWzC+IeEa
         2KZhKi1j9PYv5UmCUm/d5MzJ2RXj3i48+r1hbhg2RuJFZkRc4SHcGyajtqBdnSedE4Ix
         gX/Q==
X-Gm-Message-State: AOAM532Gb19O5pIwjtfE6NmvDjxQ6N+AWIzLALH4kTFNomkqKG09fn14
        Xdz9lJUq9eNp9efE9BU/We+JgeIR2mY=
X-Google-Smtp-Source: ABdhPJxWnY2mP6iJgGp7g6yAPt7ma77NAX1bXCw8q8eWkG4HUuw40wqqhBKRzI408pdXrcWYiSWHHg==
X-Received: by 2002:a5d:4a4a:: with SMTP id v10mr6307643wrs.306.1633720197961;
        Fri, 08 Oct 2021 12:09:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm208332wrq.9.2021.10.08.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:09:57 -0700 (PDT)
Message-Id: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 19:09:52 +0000
Subject: [PATCH v2 0/5] Fun with cpp word regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cpp word regex driver is a bit too loose and can match too much text
where the intent is to match only a number.

The first patch makes the cpp word regex tests more effective.

The second patch adds problematic test cases. The third patch fixes these
problems.

The final two patches add support for digit separators and the spaceship
operator <=> (generalized comparison operator).

I left out support for hexadecimal floating point constants because that
would require to tighten the regex even more to avoid that entire
expressions are treated as single tokens.

Changes since V1:

 * Tests, tests, tests.
 * Polished commit messages.

Johannes Sixt (5):
  t4034/cpp: actually test that operator tokens are not split
  t4034: add tests showing problematic cpp tokenizations
  userdiff-cpp: tighten word regex
  userdiff-cpp: permit the digit-separating single-quote in numbers
  userdiff-cpp: learn the C++ spaceship operator

 t/t4034/cpp/expect | 63 +++++++++++++++++++++++-----------------------
 t/t4034/cpp/post   | 47 +++++++++++++++++++++-------------
 t/t4034/cpp/pre    | 41 +++++++++++++++++++-----------
 userdiff.c         | 10 ++++++--
 4 files changed, 94 insertions(+), 67 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1054%2Fj6t%2Ffun-with-cpp-word-regex-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1054/j6t/fun-with-cpp-word-regex-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1054

Range-diff vs v1:

 -:  ----------- > 1:  dd9f82ba712 t4034/cpp: actually test that operator tokens are not split
 -:  ----------- > 2:  5a84fc9cf71 t4034: add tests showing problematic cpp tokenizations
 1:  a47ab9ba20e ! 3:  d4ebe45fddc userdiff: tighten cpp word regex
     @@ Metadata
      Author: Johannes Sixt <j6t@kdbg.org>
      
       ## Commit message ##
     -    userdiff: tighten cpp word regex
     +    userdiff-cpp: tighten word regex
      
          Generally, word regex can be written such that they match tokens
          liberally and need not model the actual syntax because it can be assumed
     @@ Commit message
      
             .l      as in str.length
             .f      as in str.find
     +       .e      as in str.erase
      
          Tighten the regex in the following way:
      
     @@ Commit message
      
          For readability, factor hex- and binary numbers into an own term.
      
     -    As a drive-by, this fixes that floatingpoint numbers such as 12E5
     +    As a drive-by, this fixes that floating point numbers such as 12E5
          (with upper-case E) were split into two tokens.
      
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
      
     + ## t/t4034/cpp/expect ##
     +@@
     + <BOLD>--- a/pre<RESET>
     + <BOLD>+++ b/post<RESET>
     + <CYAN>@@ -1,30 +1,30 @@<RESET>
     +-Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x<RED>.f<RESET><GREEN>.F<RESET>ind); }
     ++Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x.<RED>find<RESET><GREEN>Find<RESET>); }
     + cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
     +-<GREEN>(<RESET>1 <RED>-1e10<RESET><GREEN>+1e10<RESET> 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
     ++<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
     + // long double<RESET>
     + <RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
     + // float<RESET>
     +-120<RED>E5f<RESET><GREEN>E6f<RESET>
     ++<RED>120E5f<RESET><GREEN>120E6f<RESET>
     + // hex<RESET>
     +-<RED>0xdeadbeaf+8<RESET><GREEN>0xdeadBeaf+7<RESET>ULL
     ++<RED>0xdeadbeaf<RESET><GREEN>0xdeadBeaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
     + // octal<RESET>
     + <RED>01234567<RESET><GREEN>01234560<RESET>
     + // binary<RESET>
     + <RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
     + // expression<RESET>
     +-<RED>1.5-e+2+f<RESET><GREEN>1.5-e+3+f<RESET>
     ++1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
     + // another one<RESET>
     +-str<RED>.e+65<RESET><GREEN>.e+75<RESET>
     +-[a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.e<RESET><GREEN>.*e<RESET>
     ++str.e+<RED>65<RESET><GREEN>75<RESET>
     ++[a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.<RESET><GREEN>.*<RESET>e
     + <GREEN>~<RESET>!a <GREEN>!<RESET>~b c<RED>++<RESET><GREEN>+<RESET> d<RED>--<RESET><GREEN>-<RESET> e*<GREEN>*<RESET>f g<RED>&<RESET><GREEN>&&<RESET>h
     + a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
     + a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
     +@@ t/t4034/cpp/expect: a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
     + a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
     + a<RED>||<RESET><GREEN>|<RESET>b
     + a?<GREEN>:<RESET>b
     +-a<RED>=<RESET><GREEN>==<RESET>b c<RED>+=<RESET><GREEN>+<RESET>d <RED>e-=f<RESET><GREEN>e-f<RESET> g<RED>*=<RESET><GREEN>*<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
     ++a<RED>=<RESET><GREEN>==<RESET>b c<RED>+=<RESET><GREEN>+<RESET>d e<RED>-=<RESET><GREEN>-<RESET>f g<RED>*=<RESET><GREEN>*<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
     + a,b<RESET>
     + a<RED>::<RESET><GREEN>:<RESET>b
     +
       ## userdiff.c ##
      @@ userdiff.c: PATTERNS("cpp",
       	 /* functions/methods, variables, and compounds at top level */
 2:  9d1c05f5f41 ! 4:  dd75d19cee9 userdiff: permit the digit-separating single-quote in numbers
     @@ Metadata
      Author: Johannes Sixt <j6t@kdbg.org>
      
       ## Commit message ##
     -    userdiff: permit the digit-separating single-quote in numbers
     +    userdiff-cpp: permit the digit-separating single-quote in numbers
      
          Since C++17, the single-quote can be used as digit separator:
      
     @@ Commit message
             1'000'000
             0xdead'beaf
      
     -    Make it known to the word regex of the cpp driver, so that numbers are not
     -    split into separate tokens at the single-quotes.
     +    Make it known to the word regex of the cpp driver, so that numbers are
     +    not split into separate tokens at the single-quotes.
      
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
      
     + ## t/t4034/cpp/expect ##
     +@@
     + <BOLD>diff --git a/pre b/post<RESET>
     +-<BOLD>index 1229cdb..3feae6f 100644<RESET>
     ++<BOLD>index 60f3640..f6fbf7b 100644<RESET>
     + <BOLD>--- a/pre<RESET>
     + <BOLD>+++ b/post<RESET>
     + <CYAN>@@ -1,30 +1,30 @@<RESET>
     +@@ t/t4034/cpp/expect: Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>
     + cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
     + <GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
     + // long double<RESET>
     +-<RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
     ++<RED>3.141'592'653e-10l<RESET><GREEN>3.141'592'654e+10l<RESET>
     + // float<RESET>
     + <RED>120E5f<RESET><GREEN>120E6f<RESET>
     + // hex<RESET>
     +-<RED>0xdeadbeaf<RESET><GREEN>0xdeadBeaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
     ++<RED>0xdead'beaf<RESET><GREEN>0xdead'Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
     + // octal<RESET>
     +-<RED>01234567<RESET><GREEN>01234560<RESET>
     ++<RED>0123'4567<RESET><GREEN>0123'4560<RESET>
     + // binary<RESET>
     +-<RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
     ++<RED>0b10'00<RESET><GREEN>0b11'00<RESET>+e1
     + // expression<RESET>
     + 1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
     + // another one<RESET>
     +
     + ## t/t4034/cpp/post ##
     +@@ t/t4034/cpp/post: Foo() : x(0&42) { bar(x.Find); }
     + cout<<"Hello World?\n"<<endl;
     + (1 +1e10 0xabcdef) 'y'
     + // long double
     +-3.141592654e+10l
     ++3.141'592'654e+10l
     + // float
     + 120E6f
     + // hex
     +-0xdeadBeaf+7ULL
     ++0xdead'Beaf+7ULL
     + // octal
     +-01234560
     ++0123'4560
     + // binary
     +-0b1100+e1
     ++0b11'00+e1
     + // expression
     + 1.5-e+3+f
     + // another one
     +
     + ## t/t4034/cpp/pre ##
     +@@ t/t4034/cpp/pre: Foo():x(0&&1){ foo0( x.find); }
     + cout<<"Hello World!\n"<<endl;
     + 1 -1e10 0xabcdef 'x'
     + // long double
     +-3.141592653e-10l
     ++3.141'592'653e-10l
     + // float
     + 120E5f
     + // hex
     +-0xdeadbeaf+8ULL
     ++0xdead'beaf+8ULL
     + // octal
     +-01234567
     ++0123'4567
     + // binary
     +-0b1000+e1
     ++0b10'00+e1
     + // expression
     + 1.5-e+2+f
     + // another one
     +
       ## userdiff.c ##
      @@ userdiff.c: PATTERNS("cpp",
       	 /* identifiers and keywords */
 3:  df66485e7f0 ! 5:  43a701f5ffd userdiff: learn the C++ spaceship operator
     @@ Metadata
      Author: Johannes Sixt <j6t@kdbg.org>
      
       ## Commit message ##
     -    userdiff: learn the C++ spaceship operator
     +    userdiff-cpp: learn the C++ spaceship operator
      
     -    Since C++20, the language has a generalized comparison operator. Teach
     -    the cpp driver not to separate it into <= and > tokens.
     +    Since C++20, the language has a generalized comparison operator <=>.
     +    Teach the cpp driver not to separate it into <= and > tokens.
      
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
      
     + ## t/t4034/cpp/expect ##
     +@@
     + <BOLD>diff --git a/pre b/post<RESET>
     +-<BOLD>index 60f3640..f6fbf7b 100644<RESET>
     ++<BOLD>index 144cd98..244f79c 100644<RESET>
     + <BOLD>--- a/pre<RESET>
     + <BOLD>+++ b/post<RESET>
     + <CYAN>@@ -1,30 +1,30 @@<RESET>
     +@@ t/t4034/cpp/expect: str.e+<RED>65<RESET><GREEN>75<RESET>
     + a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
     + a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
     + a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
     +-a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
     ++a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<RED><=<RESET><GREEN><=><RESET>j
     + a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
     + a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
     + a<RED>||<RESET><GREEN>|<RESET>b
     +
     + ## t/t4034/cpp/post ##
     +@@ t/t4034/cpp/post: str.e+75
     + a*=b c/=d e%=f
     + a++b c--d
     + a<<=b c>>=d
     +-a<=b c<d e>=f g>h
     ++a<=b c<d e>=f g>h i<=>j
     + a!=b c=d
     + a^=b c|=d e&=f
     + a|b
     +
     + ## t/t4034/cpp/pre ##
     +@@ t/t4034/cpp/pre: str.e+65
     + a*b c/d e%f
     + a+b c-d
     + a<<b c>>d
     +-a<b c<=d e>f g>=h
     ++a<b c<=d e>f g>=h i<=j
     + a==b c!=d
     + a^b c|d e&&f
     + a||b
     +
       ## userdiff.c ##
      @@ userdiff.c: PATTERNS("cpp",
       	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"

-- 
gitgitgadget
