Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BABC433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB5D60F55
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJJRFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhJJRFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:05:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18363C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i12so35175230wrb.7
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ixa8RAuREyZoK9YyglgUT+oVhW5rQJ3PEwngHspOJqg=;
        b=WieuOvA9tqHejD32S7VcNG4lPpzFUUXhkbSsvsNcEVDyTTVzJPSav37MIS5ln5ErC4
         kcNvjZtYNe9DMhQKmepzNqFnrwTp8Ru2CxKbLKmAMupstsqNXeCOtaJpskzMlM/8JZCl
         pHR/ljquGKojyj0VAZCOHLOFtBaRfBUqmJeAqUfsmprdi1k6mqGrzvwltvDqNdF4FG3k
         +Z3Fz+EF/OGwByLsxd2by8y59kJa/FA5VhrRo/ZjPrfX5YVnW2BqPqgwkTphkPVFuEJG
         RF5LnpGdtMYGGsm4pyyyxmultCboiEePzffhxsGLOKb4R+wI53IIblhplmGLIDb1ps/9
         hPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ixa8RAuREyZoK9YyglgUT+oVhW5rQJ3PEwngHspOJqg=;
        b=by+DVZ4a8JCy/old9u0WE7rp0NMxJSg1OsopEAPFbRwF49E/QFm0lkjqy0X/5/oQyJ
         Y2qqQD5EsQi8WaTs3pO9XndnC6gK3ojqftl9ZDMFNNtY5Zm8Ljofd2YlNH1nQkrjDOBC
         M7y9wpjuwcYcPKuTKuxXBE2ojziJFBky+4rICQC3yMh3VmSlM0qg09JhLAvRT9YHLSrM
         GhHjS2K1xuJ5gKSbteX/s0nZbaIwXXAFjKzbOQiQ4qTh92xa2GesOFZyV1Www+UiNOf/
         QOwF0m5oCxELk5880ozU9XgL4XLa4XrdJpwMTteVpPecGwYT+MDHVxIR6E+O0AWO5WZL
         oc9w==
X-Gm-Message-State: AOAM5331WoI4BNyRr65hIAAXtGPw3wjHU9scjSTsAH6duYFu6ONVIlNx
        4Sjj7syozA5j5gINratML/l6ft6TO6k=
X-Google-Smtp-Source: ABdhPJyfareRrYsNTIlUkk/BO+hxZR83gZJdOZWV2VsJ7DzQktzv9Fj5xuZF4HdaUKCM+/6ZTP55vA==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr18806587wru.250.1633885385407;
        Sun, 10 Oct 2021 10:03:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm5372051wrd.1.2021.10.10.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:03:04 -0700 (PDT)
Message-Id: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Oct 2021 17:02:58 +0000
Subject: [PATCH v3 0/6] Fun with cpp word regex
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

The remaining three patches add support for digit separators and the
spaceship operator <=> (generalized comparison operator).

I left out support for hexadecimal floating point constants because that
would require to tighten the regex even more to avoid that entire
expressions are treated as single tokens.

Changes since V2:

 * Add test cases for the new features in a separate commit so that the new
   behavior is better visible.
 * Don't treat .' as in '.' as a token.

Changes since V1:

 * Tests, tests, tests.
 * Polished commit messages.

Johannes Sixt (6):
  t4034/cpp: actually test that operator tokens are not split
  t4034: add tests showing problematic cpp tokenizations
  userdiff-cpp: tighten word regex
  userdiff-cpp: prepare test cases with yet unsupported features
  userdiff-cpp: permit the digit-separating single-quote in numbers
  userdiff-cpp: learn the C++ spaceship operator

 t/t4034/cpp/expect | 63 +++++++++++++++++++++++-----------------------
 t/t4034/cpp/post   | 47 +++++++++++++++++++++-------------
 t/t4034/cpp/pre    | 41 +++++++++++++++++++-----------
 userdiff.c         | 10 ++++++--
 4 files changed, 94 insertions(+), 67 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1054%2Fj6t%2Ffun-with-cpp-word-regex-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1054/j6t/fun-with-cpp-word-regex-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1054

Range-diff vs v2:

 1:  dd9f82ba712 = 1:  dd9f82ba712 t4034/cpp: actually test that operator tokens are not split
 2:  5a84fc9cf71 = 2:  5a84fc9cf71 t4034: add tests showing problematic cpp tokenizations
 3:  d4ebe45fddc = 3:  d4ebe45fddc userdiff-cpp: tighten word regex
 4:  dd75d19cee9 ! 4:  c9f58b5e82f userdiff-cpp: permit the digit-separating single-quote in numbers
     @@ Metadata
      Author: Johannes Sixt <j6t@kdbg.org>
      
       ## Commit message ##
     -    userdiff-cpp: permit the digit-separating single-quote in numbers
     +    userdiff-cpp: prepare test cases with yet unsupported features
      
     -    Since C++17, the single-quote can be used as digit separator:
     -
     -       3.141'592'654
     -       1'000'000
     -       0xdead'beaf
     -
     -    Make it known to the word regex of the cpp driver, so that numbers are
     -    not split into separate tokens at the single-quotes.
     +    We are going to add support for C++'s digit-separating single-quote and
     +    the spaceship operator. By adding the test cases in this separate
     +    commit, the effect on the word highlighting will become more obvious
     +    as the features are implemented and the file cpp/expect is updated.
      
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
      
     @@ t/t4034/cpp/expect
      @@
       <BOLD>diff --git a/pre b/post<RESET>
      -<BOLD>index 1229cdb..3feae6f 100644<RESET>
     -+<BOLD>index 60f3640..f6fbf7b 100644<RESET>
     ++<BOLD>index 144cd98..64e78af 100644<RESET>
       <BOLD>--- a/pre<RESET>
       <BOLD>+++ b/post<RESET>
       <CYAN>@@ -1,30 +1,30 @@<RESET>
     -@@ t/t4034/cpp/expect: Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>
     + Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x.<RED>find<RESET><GREEN>Find<RESET>); }
       cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
     - <GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
     +-<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
     ++<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>.<RESET>'
       // long double<RESET>
      -<RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
     -+<RED>3.141'592'653e-10l<RESET><GREEN>3.141'592'654e+10l<RESET>
     ++3.141'592'<RED>653e-10l<RESET><GREEN>654e+10l<RESET>
       // float<RESET>
       <RED>120E5f<RESET><GREEN>120E6f<RESET>
       // hex<RESET>
      -<RED>0xdeadbeaf<RESET><GREEN>0xdeadBeaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
     -+<RED>0xdead'beaf<RESET><GREEN>0xdead'Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
     ++0xdead'<RED>beaf<RESET><GREEN>Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
       // octal<RESET>
      -<RED>01234567<RESET><GREEN>01234560<RESET>
     -+<RED>0123'4567<RESET><GREEN>0123'4560<RESET>
     ++0123'<RED>4567<RESET><GREEN>4560<RESET>
       // binary<RESET>
      -<RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
     -+<RED>0b10'00<RESET><GREEN>0b11'00<RESET>+e1
     ++<RED>0b10<RESET><GREEN>0b11<RESET>'00+e1
       // expression<RESET>
       1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
       // another one<RESET>
     +@@ t/t4034/cpp/expect: str.e+<RED>65<RESET><GREEN>75<RESET>
     + a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
     + a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
     + a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
     +-a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
     ++a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<=<GREEN>><RESET>j
     + a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
     + a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
     + a<RED>||<RESET><GREEN>|<RESET>b
      
       ## t/t4034/cpp/post ##
     -@@ t/t4034/cpp/post: Foo() : x(0&42) { bar(x.Find); }
     +@@
     + Foo() : x(0&42) { bar(x.Find); }
       cout<<"Hello World?\n"<<endl;
     - (1 +1e10 0xabcdef) 'y'
     +-(1 +1e10 0xabcdef) 'y'
     ++(1 +1e10 0xabcdef) '.'
       // long double
      -3.141592654e+10l
      +3.141'592'654e+10l
     @@ t/t4034/cpp/post: Foo() : x(0&42) { bar(x.Find); }
       // expression
       1.5-e+3+f
       // another one
     +@@ t/t4034/cpp/post: str.e+75
     + a*=b c/=d e%=f
     + a++b c--d
     + a<<=b c>>=d
     +-a<=b c<d e>=f g>h
     ++a<=b c<d e>=f g>h i<=>j
     + a!=b c=d
     + a^=b c|=d e&=f
     + a|b
      
       ## t/t4034/cpp/pre ##
      @@ t/t4034/cpp/pre: Foo():x(0&&1){ foo0( x.find); }
     @@ t/t4034/cpp/pre: Foo():x(0&&1){ foo0( x.find); }
       // expression
       1.5-e+2+f
       // another one
     -
     - ## userdiff.c ##
     -@@ userdiff.c: PATTERNS("cpp",
     - 	 /* identifiers and keywords */
     - 	 "[a-zA-Z_][a-zA-Z0-9_]*"
     - 	 /* decimal and octal integers as well as floatingpoint numbers */
     --	 "|[0-9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
     -+	 "|[0-9][0-9.']*([Ee][-+]?[0-9]+)?[fFlLuU]*"
     - 	 /* hexadecimal and binary integers */
     --	 "|0[xXbB][0-9a-fA-F]+[lLuU]*"
     -+	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
     - 	 /* floatingpoint numbers that begin with a decimal point */
     --	 "|\\.[0-9]+([Ee][-+]?[0-9]+)?[fFlL]?"
     -+	 "|\\.[0-9']+([Ee][-+]?[0-9]+)?[fFlL]?"
     - 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
     - PATTERNS("csharp",
     - 	 /* Keywords */
     +@@ t/t4034/cpp/pre: str.e+65
     + a*b c/d e%f
     + a+b c-d
     + a<<b c>>d
     +-a<b c<=d e>f g>=h
     ++a<b c<=d e>f g>=h i<=j
     + a==b c!=d
     + a^b c|d e&&f
     + a||b
 -:  ----------- > 5:  037c743d9e3 userdiff-cpp: permit the digit-separating single-quote in numbers
 5:  43a701f5ffd ! 6:  cc9dc967f10 userdiff-cpp: learn the C++ spaceship operator
     @@ Commit message
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
      
       ## t/t4034/cpp/expect ##
     -@@
     - <BOLD>diff --git a/pre b/post<RESET>
     --<BOLD>index 60f3640..f6fbf7b 100644<RESET>
     -+<BOLD>index 144cd98..244f79c 100644<RESET>
     - <BOLD>--- a/pre<RESET>
     - <BOLD>+++ b/post<RESET>
     - <CYAN>@@ -1,30 +1,30 @@<RESET>
      @@ t/t4034/cpp/expect: str.e+<RED>65<RESET><GREEN>75<RESET>
       a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
       a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
       a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
     --a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
     +-a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<=<GREEN>><RESET>j
      +a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<RED><=<RESET><GREEN><=><RESET>j
       a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
       a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
       a<RED>||<RESET><GREEN>|<RESET>b
      
     - ## t/t4034/cpp/post ##
     -@@ t/t4034/cpp/post: str.e+75
     - a*=b c/=d e%=f
     - a++b c--d
     - a<<=b c>>=d
     --a<=b c<d e>=f g>h
     -+a<=b c<d e>=f g>h i<=>j
     - a!=b c=d
     - a^=b c|=d e&=f
     - a|b
     -
     - ## t/t4034/cpp/pre ##
     -@@ t/t4034/cpp/pre: str.e+65
     - a*b c/d e%f
     - a+b c-d
     - a<<b c>>d
     --a<b c<=d e>f g>=h
     -+a<b c<=d e>f g>=h i<=j
     - a==b c!=d
     - a^b c|d e&&f
     - a||b
     -
       ## userdiff.c ##
      @@ userdiff.c: PATTERNS("cpp",
       	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
       	 /* floatingpoint numbers that begin with a decimal point */
     - 	 "|\\.[0-9']+([Ee][-+]?[0-9]+)?[fFlL]?"
     + 	 "|\\.[0-9][0-9']*([Ee][-+]?[0-9]+)?[fFlL]?"
      -	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
      +	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
       PATTERNS("csharp",

-- 
gitgitgadget
