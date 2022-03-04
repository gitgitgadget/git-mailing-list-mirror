Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78520C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiCDNKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiCDNJu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:09:50 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A01B45C7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:08:57 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b8so7298612pjb.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ay/ktnK+cq01Lf8szp+Tz08UTxiSgd+2T91yIAsnViU=;
        b=nBFfqW8KeiM9o7pRJSuNQ7JAo8DMOEeAXc2nvXGq/m6+RuOq7eTgq5suY24fXS53+e
         sIn08tslDVngcKfGoa675xnLCKMjIgOtyJHArw12YPhhjWgi/d+1u++asfIfW8wf/ZX9
         82w4Pcx+/KFh+gQm5wOkV4N18B7i28f0KB7q0fz9+Dinj+EwchCI7LhKY6KywHtY2wDl
         U/B1gjeyLny1gLCVunwCkXU+JAwHm640DuGHm1lJvA4axAFTx0EIq/EES0m8VahEtY6Q
         bg49rEA1PvU2EC4eX7EB+uk33CM9r+mRp74YpWNJF+wUynC8VuAZFclvecK9HDaJi+vn
         fIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ay/ktnK+cq01Lf8szp+Tz08UTxiSgd+2T91yIAsnViU=;
        b=RdLIXd2cqRTDAM8iImnCOiWqOTys1cRQ6I+P9KFyTOGFGT6RMPhX6LxrOUTMmwlmv8
         o4PlNg7r1t2gAR39cX/bA7aCHzi+F54Goo7s+/iAF8kHxlfccVmKZ//ddurn1c/MBXtK
         qYNcZXYzo4C2Db5eqm62J5YnxRD7TlnaDlG+c68a53mBCdAHlByADttBGJTn9VWwatpF
         3O99y2/GrgnySERJZ5QpfYNTI8YEs2MF3Cetthg1LqT8YGm1TFTCPqtyAWN6pTdrhgK7
         LAKNW0O1iC+Jj0JG0h8SaNtLWMPr7tUZNaG7ZnmqtfiJrfuY3frHyrEMThQb0Ut7HzQ6
         vjlQ==
X-Gm-Message-State: AOAM532hd29HJsfYocfq1WW2CJPmNU+mg1yDzrhRuCgmzAn7jBO9xJ3A
        /DQQmW+A1Sgd34poIUDGZEuskrqWJpWr0Q==
X-Google-Smtp-Source: ABdhPJygg1ODQ2l/CY59KevI+Q967LG+rlzHNjpkmtDEW2futZdCClwI6Odb1ZYMyGvn2QDqNN0few==
X-Received: by 2002:a17:902:6e09:b0:151:76bc:8af9 with SMTP id u9-20020a1709026e0900b0015176bc8af9mr21566476plk.152.1646399336715;
        Fri, 04 Mar 2022 05:08:56 -0800 (PST)
Received: from ubuntu.localdomain ([140.115.59.167])
        by smtp.gmail.com with ESMTPSA id nm14-20020a17090b19ce00b001bf2404fd9dsm2205891pjb.31.2022.03.04.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:08:56 -0800 (PST)
From:   xing zhi jiang <a97410985new@gmail.com>
To:     git@vger.kernel.org
Cc:     a97410985new@gmail.com
Subject: [GSoC][PATCH 0/1] userdiff: add buildin diff driver for JavaScript language
Date:   Fri,  4 Mar 2022 05:08:53 -0800
Message-Id: <20220304130854.857746-1-a97410985new@gmail.com>
X-Mailer: git-send-email 2.35.1.273.ge6ebfd0e8c.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have already searched the git public-inbox don't find any active patch about
userdiff build-in driver for JavaScript(there is an unfinished patch about 
three years ago). So I pick this as my GSoC micro project.

Below are typical function patterns from JavaScript, and 
also has an example that matches the corresponding pattern. 
These examples come from many popular JavaScript projects. 
Because I want to make sure the hunk header would work well 
on real-world projects.

Common function's pattern for JavaScript
1. normal function
  `^[\t ]*((export[\t ]+)?((async|get|set)[\t ]+)?function[\t ]*([\t ]*\\*[\t ]*|[\t ]*)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)`
  example: 
  1. https://github.com/mozilla/pdf.js/blob/85ff7b117e04471c550914b7a13193ab7f7ecc6a/src/display/canvas.js#L648
  2. https://github.com/mozilla/pdf.js/blob/ad4b2ce021277ff7cea8ec7e32775c65d74ee673/test/unit/evaluator_spec.js#L40
2. JavaScript variable declaration with a lambda expression
  `^^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*[\t ])[\t ]*=>[\t ]*\\{?)`
   example:
   1. https://github.com/webpack/webpack/blob/2279c5a2105ea1498b83a4854919aefe1a28c553/lib/ChunkGraph.js#L91
   2. https://github.com/webpack/webpack/blob/2279c5a2105ea1498b83a4854919aefe1a28c553/lib/ChunkGraph.js#L122
    
   I found sometimes would define function on this way. But this should only match the top level? Because 
   it may match inside the function, and the below code would match the wrong function[1].

3. exports methods by assigning an anonymous function
  `^[\t ]*(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)`
   example:
   1. https://github.com/webpack/webpack/blob/c181294865dca01b28e6e316636fef5f2aad4eb6/lib/dependencies/DynamicExports.js#L17
   2. https://github.com/ajaxorg/ace/blob/d95725983b363a616c584237013dfd36eaadbba4/lib/ace/lib/dom.js#L37
4. expression about assign function to LHS
  `^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)`
   example:
   1. https://github.com/ajaxorg/ace/blob/94422a4a892495564c56089af85019a8f8f24673/lib/ace/anchor.js#L102
   2. https://github.com/ajaxorg/ace/blob/d95725983b363a616c584237013dfd36eaadbba4/lib/ace/lib/dom.js#L37
   3. https://github.com/ajaxorg/ace/blob/4257621787b4253d6d493611f4ec5a37829da323/lib/ace/search.js#L350
   4. https://github.com/mozilla/pdf.js/blob/85ff7b117e04471c550914b7a13193ab7f7ecc6a/src/display/canvas.js#L299
   
   Maybe this should only match on the 0,1,2 indent level? Because JavaScript may match the function assignment in another function.
5. normal function in object literal
  `^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)`
    1. https://github.com/jquery/jquery/blob/de5398a6ad088dc006b46c6a870a2a053f4cd663/src/core.js#L201
    2. https://github.com/mozilla/pdf.js/blob/85ff7b117e04471c550914b7a13193ab7f7ecc6a/src/display/canvas.js#L242
6. function in class
  `^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)`
    
   This regex is tricky because the class's function is no function keyword in JavaScript. 
   If you write the regex to match them, it will match many non-function declaration things!!! 
   Like examples below:
   1. the non-function matches
     1. https://github.com/ajaxorg/ace/blob/94422a4a892495564c56089af85019a8f8f24673/lib/ace/anchor.js#L58
     2. https://github.com/ajaxorg/ace/blob/d95725983b363a616c584237013dfd36eaadbba4/lib/ace/lib/dom.js#L132
   2. the function in class
     1. https://github.com/mozilla/pdf.js/blob/85ff7b117e04471c550914b7a13193ab7f7ecc6a/src/display/canvas.js#L1929
     2. https://github.com/webpack/webpack/blob/ccecc17c01af96edddb931a76e7a3b21ef2969d8/lib/Chunk.js#L179
     3. https://github.com/webpack/webpack/blob/612de998f186a9bb2fe8769a91678df689a0541e/lib/Module.js#L242
     4. https://github.com/mozilla/pdf.js/blob/5cf116a958548f6596674bf8d5ca0fe64aa2df3c/web/view_history.js#L75
     5. https://github.com/mozilla/pdf.js/blob/5cf116a958548f6596674bf8d5ca0fe64aa2df3c/web/view_history.js#L89
   
    My solution is to add some negation rules, and one rule is skipping the keywords that may have characters immediately 
    following them in the parenthesis, rule is `!^[ \t]*(if|do|while|for|with|switch|catch|import|return)`.
    Another negation rule is only before this 「function in class」 regex, that skips the line's indent level more than 
    one because most of the function in class has one indent level(the class is on top-level). The negation rule is 
    `!^(\t{2,}|[ ]{5,})`.
    
    But this is not enough, because maybe has function call on one indent level. So need an negation rule for skipping 
    statement. The negation rule is `!^.*;[ \t]*`. But the bad news is JavaScript's statement can end without a semicolon. 
    So it still has an opportunity to recognize function call as the function declaration if the code's statement does not 
    end with semicolons.

Word's pattern for JavaScript
In this part, I reference the formal ECMA specification heavily[2].
JavaScript has some special syntax, such as numbers can be separated with an underscore for readability[3]. 
And has BigInt literal, which is number end with a 「n」 character. So the number-related regex would be some 
differences with another language.

In the last, I had a fork git project on Github. And has the CI's result, the all test cases pass[4].

[1] https://github.com/webpack/webpack/blob/2279c5a2105ea1498b83a4854919aefe1a28c553/lib/ChunkGraph.js#L279
[2] https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar
[3] https://v8.dev/features/numeric-separators
[4] https://github.com/a97410985/git/actions/runs/1933091300

xing zhi jiang (1):
  Add a diff driver for JavaScript languages.

 .gitignore                                    |  1 +
 Documentation/gitattributes.txt               |  2 +
 ...avascript-assignment-of-anonymous-function |  4 ++
 .../javascript-assignment-of-arrow-function   |  4 ++
 .../javascript-assignment-of-named-function   |  4 ++
 t/t4018/javascript-async-function             |  4 ++
 t/t4018/javascript-export-async-function      |  4 ++
 t/t4018/javascript-export-function            |  4 ++
 t/t4018/javascript-exports-anomyous-function  |  4 ++
 .../javascript-exports-anomyous-function-2    |  4 ++
 t/t4018/javascript-exports-function           |  4 ++
 t/t4018/javascript-function                   |  4 ++
 t/t4018/javascript-function-2                 | 10 ++++
 t/t4018/javascript-function-belong-to-IIFE    |  6 +++
 t/t4018/javascript-function-in-class          |  6 +++
 t/t4018/javascript-function-in-class-2        | 11 ++++
 t/t4018/javascript-function-in-object-literal |  7 +++
 t/t4018/javascript-generator-function         |  4 ++
 t/t4018/javascript-generator-function-2       |  4 ++
 t/t4018/javascript-getter-function-in-class   |  6 +++
 t/t4018/javascript-setter-function-in-class   |  6 +++
 .../javascript-skip-function-call-statement   |  7 +++
 t/t4018/javascript-skip-keywords              | 34 ++++++++++++
 t/t4018/javascript-static-function-in-class   |  6 +++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/javascript/expect                     | 52 +++++++++++++++++++
 t/t4034/javascript/post                       | 32 ++++++++++++
 t/t4034/javascript/pre                        | 32 ++++++++++++
 userdiff.c                                    | 38 ++++++++++++++
 29 files changed, 305 insertions(+)
 create mode 100644 t/t4018/javascript-assignment-of-anonymous-function
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function
 create mode 100644 t/t4018/javascript-assignment-of-named-function
 create mode 100644 t/t4018/javascript-async-function
 create mode 100644 t/t4018/javascript-export-async-function
 create mode 100644 t/t4018/javascript-export-function
 create mode 100644 t/t4018/javascript-exports-anomyous-function
 create mode 100644 t/t4018/javascript-exports-anomyous-function-2
 create mode 100644 t/t4018/javascript-exports-function
 create mode 100644 t/t4018/javascript-function
 create mode 100644 t/t4018/javascript-function-2
 create mode 100644 t/t4018/javascript-function-belong-to-IIFE
 create mode 100644 t/t4018/javascript-function-in-class
 create mode 100644 t/t4018/javascript-function-in-class-2
 create mode 100644 t/t4018/javascript-function-in-object-literal
 create mode 100644 t/t4018/javascript-generator-function
 create mode 100644 t/t4018/javascript-generator-function-2
 create mode 100644 t/t4018/javascript-getter-function-in-class
 create mode 100644 t/t4018/javascript-setter-function-in-class
 create mode 100644 t/t4018/javascript-skip-function-call-statement
 create mode 100644 t/t4018/javascript-skip-keywords
 create mode 100644 t/t4018/javascript-static-function-in-class
 create mode 100644 t/t4034/javascript/expect
 create mode 100644 t/t4034/javascript/post
 create mode 100644 t/t4034/javascript/pre


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
-- 
2.35.1.273.ge6ebfd0e8c.dirty

