Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1410C43217
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiCLQtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 11:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiCLQtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 11:49:16 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054945535
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 08:48:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cx5so10826190pjb.1
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/wb1Q1O5OVO9wyGszYzX47mi/+2UfWDAfOlTtQEna4=;
        b=Estj1R5rQPLU6ku+YrTU4aLRXnm20cBh+XPhSLzr5hXm4gQEnXMbYiTaWpPYU7i4t0
         BEgB+aOaPlpmv7XBBMCt9iLOz2xG2HEGep2dCZxbmItY12im5ogqgtS7cu0pssjaiFQ1
         lYt/w2EdBQ9YfwOWT0TGK7EGQHuXeB9pOKMLs2xHvgVu40vuMAtj77DCZixHujIV3dZR
         +JW4nnBePNrmQlOOg348yhFUFqQnQEWP8jhlZAVGgLkGm9h58rbxfopTX6Qp5rK72zbX
         tOJ2mMkOEgud35RNQnhuS7vJsGtsirzU2RsM60wHJJAZAz9Nq2gR7xgI7eKLuFGVLOOq
         nGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/wb1Q1O5OVO9wyGszYzX47mi/+2UfWDAfOlTtQEna4=;
        b=IFLLxTZydLMVtzGYi3oTYxeQb3n2wCnE4lHgq/qPSh2QVPdHej0X60P64eame30Poc
         DQZpl2zaiOs/a85flYHq6aCVDYxk9cpqoq+nuzj+Tb1Z1P9pruLQWplychev03QCWAL3
         vHydLKIvAAQsIzw+21W/9fmdbTMh5l3aC0xIAJmu/fClmFPY0EI4QoZnb9vlCa0ULbs0
         I8Pf0JjJFJh0sewCILGKbUD4jSPMWEkRR0GAVvDxGTgsSYrDvURHYCnLaORrED7Bb1vu
         1eyF90rDGmaR+bNtuiuhdWQyA47UlhaQ4eN+kQT1GIXLzPye8p/PpYnROD0q/X6GF/uQ
         6E0A==
X-Gm-Message-State: AOAM533wtshcvIhwmW/sbU7fhvHqXpnfYnEzCokdqLoYU8VEyOXijl7+
        xDW+/FwD9eGU+1uz41vJo3NPXDfqCmj0hg==
X-Google-Smtp-Source: ABdhPJy58e6jTp29RTc8oyl8hckoG2hMHWTy87zk/9jeImQM5ceyDiGPzmWIoxqq3vvvJT7ToC5nyA==
X-Received: by 2002:a17:902:be0d:b0:151:6b8b:b3a5 with SMTP id r13-20020a170902be0d00b001516b8bb3a5mr16445230pls.27.1647103687353;
        Sat, 12 Mar 2022 08:48:07 -0800 (PST)
Received: from ubuntu.localdomain ([140.115.59.167])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a4dce00b001bcd7c2b2c0sm12363962pjl.7.2022.03.12.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 08:48:06 -0800 (PST)
From:   xing zhi jiang <a97410985new@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org
Subject: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
Date:   Sat, 12 Mar 2022 08:48:03 -0800
Message-Id: <20220312164803.57909-1-a97410985new@gmail.com>
X-Mailer: git-send-email 2.35.1.273.ge6ebfd0e8c.dirty
In-Reply-To: <20220304130854.857746-1-a97410985new@gmail.com>
References: <20220304130854.857746-1-a97410985new@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the xfunction part that matches normal functions,
a variable declaration with an assignment of function, the function declaration
in the class, and also the function is object literal's property[1].

And in the word regex part, that matches numbers, punctuations, and also the
JavaScript identifier.
This part reference the formal ECMA specification[2].

[1]https://github.com/jquery/jquery/blob/de5398a6ad088dc006b46c6a870a2a053f4cd663/src/core.js#L201
[2]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar

Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
---
Range-diff against v1:
1:  7f764f97cf ! 1:  3b326bd2b6 Add a diff driver for JavaScript languages.
    @@ Commit message
     
         In the xfunction part that matches normal functions,
         a variable declaration with an assignment of function, the function declaration
    -    in the class, and also the function is object literal's property.
    +    in the class, and also the function is object literal's property[1].
     
         And in the word regex part, that matches numbers, punctuations, and also the
         JavaScript identifier.
    -    This part heavily references the formal ECMA sepcification[1].
    +    This part reference the formal ECMA specification[2].
     
    -    [1]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar
    +    [1]https://github.com/jquery/jquery/blob/de5398a6ad088dc006b46c6a870a2a053f4cd663/src/core.js#L201
    +    [2]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar
     
         Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
     
    - ## .gitignore ##
    -@@ .gitignore: Release/
    - /git.VC.db
    - *.dSYM
    - /contrib/buildsystems/out
    -+/.cache
    - \ No newline at end of file
    -
      ## Documentation/gitattributes.txt ##
     @@ Documentation/gitattributes.txt: patterns are available:
      
      - `java` suitable for source code in the Java language.
      
    -+- `javascript suitable for source code in the JavaScript language.
    ++- `javascript` suitable for source code in the JavaScript language.
     +
      - `markdown` suitable for Markdown documents.
      
    @@ t/t4018/javascript-assignment-of-anonymous-function (new)
     +	
     +    return a + b; // ChangeMe
     +};
    - \ No newline at end of file
     
      ## t/t4018/javascript-assignment-of-arrow-function (new) ##
     @@
    @@ t/t4018/javascript-assignment-of-arrow-function (new)
     +	
     +    return a + b; // ChangeMe
     +};
    - \ No newline at end of file
    +
    + ## t/t4018/javascript-assignment-of-arrow-function-2 (new) ##
    +@@
    ++const RIGHT = (a, b)=>{
    ++	
    ++    return a + b; // ChangeMe
    ++};
    +
    + ## t/t4018/javascript-assignment-of-arrow-function-3 (new) ##
    +@@
    ++const RIGHT=test=>{
    ++	
    ++    return test + 1; // ChangeMe
    ++};
     
      ## t/t4018/javascript-assignment-of-named-function (new) ##
     @@
    @@ t/t4018/javascript-assignment-of-named-function (new)
     +	
     +    return a + b; // ChangeMe
     +};
    - \ No newline at end of file
     
      ## t/t4018/javascript-async-function (new) ##
     @@
    @@ t/t4018/javascript-async-function (new)
     +  
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-export-async-function (new) ##
     @@
    @@ t/t4018/javascript-export-async-function (new)
     +  
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-export-function (new) ##
     @@
    @@ t/t4018/javascript-export-function (new)
     +  
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-exports-anomyous-function (new) ##
     @@
    @@ t/t4018/javascript-exports-anomyous-function (new)
     +	
     +    return ChangeMe;
     +};
    - \ No newline at end of file
     
      ## t/t4018/javascript-exports-anomyous-function-2 (new) ##
     @@
    @@ t/t4018/javascript-exports-anomyous-function-2 (new)
     +	
     +    return ChangeMe;
     +};
    - \ No newline at end of file
     
      ## t/t4018/javascript-exports-function (new) ##
     @@
     +exports.RIGHT = function(document) {
     +    
    -+    return ChangeMe
    ++    return ChangeMe;
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-function (new) ##
     @@
    @@ t/t4018/javascript-function (new)
     +
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-function-2 (new) ##
     @@
    @@ t/t4018/javascript-function-2 (new)
     +   }
     +  }
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-function-belong-to-IIFE (new) ##
     @@
    @@ t/t4018/javascript-function-belong-to-IIFE (new)
     +      return ChangeMe;
     +  };
     +}).call(aaaa.prototype);
    - \ No newline at end of file
     
      ## t/t4018/javascript-function-in-class (new) ##
     @@
    @@ t/t4018/javascript-function-in-class (new)
     +    let b = ChangeMe;
     +  }
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-function-in-class-2 (new) ##
     @@
    @@ t/t4018/javascript-function-in-class-2 (new)
     +    let b = ChangeMe;
     +  }
     +}
    - \ No newline at end of file
    +
    + ## t/t4018/javascript-function-in-class-3 (new) ##
    +@@
    ++class Test {
    ++  RIGHT(aaaaaaaaaa,
    ++      bbbbbbbbbb,
    ++      cccccccccc,
    ++      dddddddddd
    ++  ) {
    ++    let a = 4;
    ++    let b = ChangeMe;
    ++  }
    ++}
     
      ## t/t4018/javascript-function-in-object-literal (new) ##
     @@
    @@ t/t4018/javascript-function-in-object-literal (new)
     +        return ChangeMe
     +    }
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-generator-function (new) ##
     @@
    @@ t/t4018/javascript-generator-function (new)
     +  
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-generator-function-2 (new) ##
     @@
    @@ t/t4018/javascript-generator-function-2 (new)
     +  
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-getter-function-in-class (new) ##
     @@
    @@ t/t4018/javascript-getter-function-in-class (new)
     +    let b = ChangeMe;
     +  }
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-setter-function-in-class (new) ##
     @@
    @@ t/t4018/javascript-setter-function-in-class (new)
     +    let b = ChangeMe;
     +  }
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-skip-function-call-statement (new) ##
     @@
    @@ t/t4018/javascript-skip-function-call-statement (new)
     +    let b = ChangeMe;
     +  }
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-skip-keywords (new) ##
     @@
    @@ t/t4018/javascript-skip-keywords (new)
     +
     +  return a + b; // ChangeMe
     +}
    - \ No newline at end of file
     
      ## t/t4018/javascript-static-function-in-class (new) ##
     @@
    @@ t/t4018/javascript-static-function-in-class (new)
     +    let b = ChangeMe;
     +  }
     +}
    - \ No newline at end of file
     
      ## t/t4034-diff-words.sh ##
     @@ t/t4034-diff-words.sh: test_language_driver dts
    @@ t/t4034-diff-words.sh: test_language_driver dts
      ## t/t4034/javascript/expect (new) ##
     @@
     +<BOLD>diff --git a/pre b/post<RESET>
    -+<BOLD>index b72238f..8bc3e3a 100644<RESET>
    ++<BOLD>index 18f4796..46f9b62 100644<RESET>
     +<BOLD>--- a/pre<RESET>
     +<BOLD>+++ b/post<RESET>
    -+<CYAN>@@ -1,32 +1,32 @@<RESET>
    ++<CYAN>@@ -1,33 +1,33 @@<RESET>
     +// DecimalLiteral<RESET>
     +<RED>123<RESET>
     +<RED>0.123<RESET>
    ++<RED>.123<RESET>
     +<RED>0.123e+5<RESET>
     +<RED>0.123E+5<RESET>
     +<RED>0.123e5<RESET>
     +<RED>1222222222222222223334444n<RESET><GREEN>124<RESET>
     +<GREEN>0.124<RESET>
    ++<GREEN>.124<RESET>
     +<GREEN>0.123e-5<RESET>
     +<GREEN>0.123E-5<RESET>
     +<GREEN>0.123E5<RESET>
    @@ t/t4034/javascript/post (new)
     +// DecimalLiteral
     +124
     +0.124
    ++.124
     +0.123e-5
     +0.123E-5
     +0.123E5
    @@ t/t4034/javascript/post (new)
     +a-=b a%=b a&&=b a|=b
     +b-c a++ a<<b a>>>=b a<<=b
     +a&b a|b a??=b
    - \ No newline at end of file
     
      ## t/t4034/javascript/pre (new) ##
     @@
     +// DecimalLiteral
     +123
     +0.123
    ++.123
     +0.123e+5
     +0.123E+5
     +0.123e5
    @@ t/t4034/javascript/pre (new)
     +a+=b a*=b a**=b a||=b
     +b+c a-- a>>b a>>>b a>>=b
     +a&&b a||b a&&=b
    - \ No newline at end of file
     
      ## userdiff.c ##
     @@ userdiff.c: PATTERNS("java",
    @@ userdiff.c: PATTERNS("java",
     +	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
     +	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
     +	 /* don't match statement */
    -+	 "!^.*;[ \t]*\n"
    ++	 "!;\n"
     +	 /* match normal function */
    -+	 "^[\t ]*((export[\t ]+)?(async[\t ]+)?function[\t ]*([\t ]*\\*[\t ]*|[\t ]*)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
    ++	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
     +	 /* match JavaScript variable declaration with a lambda expression */
     +	 "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
    -+	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*[\t ])[\t ]*=>[\t ]*\\{?)\n"
    ++	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
     +	 /* match exports for anonymous fucntion */
    -+	 "^[\t ]*(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
    ++	 "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
     +	 /* match assign function to LHS */
     +	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"
     +	 /* match normal function in object literal */
    @@ userdiff.c: PATTERNS("java",
     +	 /* match function in class */
     +	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",
     +	 /* word regex */
    -+	 /* hexIntegerLiteral and bigHexIntegerLiteral*/
    -+	 "0[xX][0-9a-fA-F][_0-9a-fA-F]*n?|"
    -+	 /* octalIntegerLiteral and bigOctalIntegerLiteral */
    -+	 "0[oO]?[0-7][_0-7]*n?|"
    -+	 /* binaryIntegerLiteral and bigBinaryIntegerLiteral */
    -+	 "(0[bB][01][_01]*n?)|"
    -+	 /* decimalLiteral */
    -+	 "(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?|"
    -+	 /* bigDecimalLiteral */
    -+	 "(0|[1-9][_0-9]*)n|"
    ++	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, DecimalLiteral and its big version */
    ++	 "(0[xXoObB])?[0-9a-fA-F][_0-9a-fA-F]*n?"
    ++	 /* DecimalLiteral may be float */
    ++	 "|(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
     +	 /* punctuations */
    -+	 "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=|>=|==|!=|={3}|!==|\\+|-|\\*|/|%|\\*{2}|"
    -+	 "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=|\\+=|-=|\\*=|%=|\\*{2}=|"
    -+	 "<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>|"
    ++	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
    ++	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
    ++	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
     +	 /* identifiers */
    -+	 "[$_[:alpha:]][$_[:alnum:]]*"),
    ++	 "|[$_[:alpha:]][$_[:alnum:]]*"),
      PATTERNS("markdown",
      	 "^ {0,3}#{1,6}[ \t].*",
      	 /* -- */

 Documentation/gitattributes.txt               |  2 +
 ...avascript-assignment-of-anonymous-function |  4 ++
 .../javascript-assignment-of-arrow-function   |  4 ++
 .../javascript-assignment-of-arrow-function-2 |  4 ++
 .../javascript-assignment-of-arrow-function-3 |  4 ++
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
 t/t4018/javascript-function-in-class-3        | 10 ++++
 t/t4018/javascript-function-in-object-literal |  7 +++
 t/t4018/javascript-generator-function         |  4 ++
 t/t4018/javascript-generator-function-2       |  4 ++
 t/t4018/javascript-getter-function-in-class   |  6 +++
 t/t4018/javascript-setter-function-in-class   |  6 +++
 .../javascript-skip-function-call-statement   |  7 +++
 t/t4018/javascript-skip-keywords              | 34 ++++++++++++
 t/t4018/javascript-static-function-in-class   |  6 +++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/javascript/expect                     | 54 +++++++++++++++++++
 t/t4034/javascript/post                       | 33 ++++++++++++
 t/t4034/javascript/pre                        | 33 ++++++++++++
 userdiff.c                                    | 32 +++++++++++
 31 files changed, 320 insertions(+)
 create mode 100644 t/t4018/javascript-assignment-of-anonymous-function
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function-2
 create mode 100644 t/t4018/javascript-assignment-of-arrow-function-3
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
 create mode 100644 t/t4018/javascript-function-in-class-3
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

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 60984a4682..a8e3e4d735 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -828,6 +828,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `javascript` suitable for source code in the JavaScript language.
+
 - `markdown` suitable for Markdown documents.
 
 - `matlab` suitable for source code in the MATLAB and Octave languages.
diff --git a/t/t4018/javascript-assignment-of-anonymous-function b/t/t4018/javascript-assignment-of-anonymous-function
new file mode 100644
index 0000000000..b6f2ccccfc
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-anonymous-function
@@ -0,0 +1,4 @@
+const RIGHT = function (a, b) {
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-arrow-function b/t/t4018/javascript-assignment-of-arrow-function
new file mode 100644
index 0000000000..24ce517b7a
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function
@@ -0,0 +1,4 @@
+const RIGHT = (a, b) => {
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-arrow-function-2 b/t/t4018/javascript-assignment-of-arrow-function-2
new file mode 100644
index 0000000000..bbf5de369e
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function-2
@@ -0,0 +1,4 @@
+const RIGHT = (a, b)=>{
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-arrow-function-3 b/t/t4018/javascript-assignment-of-arrow-function-3
new file mode 100644
index 0000000000..4a07aa3259
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-arrow-function-3
@@ -0,0 +1,4 @@
+const RIGHT=test=>{
+	
+    return test + 1; // ChangeMe
+};
diff --git a/t/t4018/javascript-assignment-of-named-function b/t/t4018/javascript-assignment-of-named-function
new file mode 100644
index 0000000000..bfc486ebef
--- /dev/null
+++ b/t/t4018/javascript-assignment-of-named-function
@@ -0,0 +1,4 @@
+const RIGHT = function test (a, b) {
+	
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
new file mode 100644
index 0000000000..993e6926bf
--- /dev/null
+++ b/t/t4018/javascript-async-function
@@ -0,0 +1,4 @@
+async function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascript-export-async-function
new file mode 100644
index 0000000000..fecbd669d7
--- /dev/null
+++ b/t/t4018/javascript-export-async-function
@@ -0,0 +1,4 @@
+export async function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-export-function
new file mode 100644
index 0000000000..b5acbb2b08
--- /dev/null
+++ b/t/t4018/javascript-export-function
@@ -0,0 +1,4 @@
+export function RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-exports-anomyous-function b/t/t4018/javascript-exports-anomyous-function
new file mode 100644
index 0000000000..6786cbda8d
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function
@@ -0,0 +1,4 @@
+exports.setFlagged = RIGHT => {
+	
+    return ChangeMe;
+};
diff --git a/t/t4018/javascript-exports-anomyous-function-2 b/t/t4018/javascript-exports-anomyous-function-2
new file mode 100644
index 0000000000..883569f40d
--- /dev/null
+++ b/t/t4018/javascript-exports-anomyous-function-2
@@ -0,0 +1,4 @@
+exports.RIGHT = (a, b, runtime) => {
+	
+    return ChangeMe;
+};
diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
new file mode 100644
index 0000000000..63b79f5991
--- /dev/null
+++ b/t/t4018/javascript-exports-function
@@ -0,0 +1,4 @@
+exports.RIGHT = function(document) {
+    
+    return ChangeMe;
+}
diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
new file mode 100644
index 0000000000..0cc0bf54e7
--- /dev/null
+++ b/t/t4018/javascript-function
@@ -0,0 +1,4 @@
+function RIGHT(a, b) {
+
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-function-2 b/t/t4018/javascript-function-2
new file mode 100644
index 0000000000..06cfb779f0
--- /dev/null
+++ b/t/t4018/javascript-function-2
@@ -0,0 +1,10 @@
+function test(a, b) {
+  return {
+			RIGHT: function () {
+				currentUpdateRemovedChunks.forEach(function (chunkId) {
+					delete $installedChunks$[chunkId];
+				});
+				currentUpdateRemovedChunks = ChangeMe;
+   }
+  }
+}
diff --git a/t/t4018/javascript-function-belong-to-IIFE b/t/t4018/javascript-function-belong-to-IIFE
new file mode 100644
index 0000000000..6e5fe858c0
--- /dev/null
+++ b/t/t4018/javascript-function-belong-to-IIFE
@@ -0,0 +1,6 @@
+(function () {
+  this.$RIGHT = function (needle, modifier) {
+      let a = 5;
+      return ChangeMe;
+  };
+}).call(aaaa.prototype);
diff --git a/t/t4018/javascript-function-in-class b/t/t4018/javascript-function-in-class
new file mode 100644
index 0000000000..0cc0a26612
--- /dev/null
+++ b/t/t4018/javascript-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascript-function-in-class-2
new file mode 100644
index 0000000000..725495fe55
--- /dev/null
+++ b/t/t4018/javascript-function-in-class-2
@@ -0,0 +1,11 @@
+class Test {
+  RIGHT(
+      aaaaaaaaaa,
+      bbbbbbbbbb,
+      cccccccccc,
+      dddddddddd
+  ) {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-function-in-class-3 b/t/t4018/javascript-function-in-class-3
new file mode 100644
index 0000000000..e9b20728b2
--- /dev/null
+++ b/t/t4018/javascript-function-in-class-3
@@ -0,0 +1,10 @@
+class Test {
+  RIGHT(aaaaaaaaaa,
+      bbbbbbbbbb,
+      cccccccccc,
+      dddddddddd
+  ) {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-function-in-object-literal b/t/t4018/javascript-function-in-object-literal
new file mode 100644
index 0000000000..021cc706dd
--- /dev/null
+++ b/t/t4018/javascript-function-in-object-literal
@@ -0,0 +1,7 @@
+const obj = {
+    RIGHT: function (elems, callback, arg) {
+        var length, value;
+        // ...
+        return ChangeMe
+    }
+}
diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
new file mode 100644
index 0000000000..dc7793939f
--- /dev/null
+++ b/t/t4018/javascript-generator-function
@@ -0,0 +1,4 @@
+function* RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
new file mode 100644
index 0000000000..950676a612
--- /dev/null
+++ b/t/t4018/javascript-generator-function-2
@@ -0,0 +1,4 @@
+function *RIGHT(a, b) {
+  
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-getter-function-in-class b/t/t4018/javascript-getter-function-in-class
new file mode 100644
index 0000000000..9a5aee39f7
--- /dev/null
+++ b/t/t4018/javascript-getter-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  get RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-setter-function-in-class b/t/t4018/javascript-setter-function-in-class
new file mode 100644
index 0000000000..dc5f288665
--- /dev/null
+++ b/t/t4018/javascript-setter-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  set RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-skip-function-call-statement b/t/t4018/javascript-skip-function-call-statement
new file mode 100644
index 0000000000..321993c27e
--- /dev/null
+++ b/t/t4018/javascript-skip-function-call-statement
@@ -0,0 +1,7 @@
+class Test {
+  static RIGHT() {
+    haha();
+    haha2()
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4018/javascript-skip-keywords b/t/t4018/javascript-skip-keywords
new file mode 100644
index 0000000000..5584970b58
--- /dev/null
+++ b/t/t4018/javascript-skip-keywords
@@ -0,0 +1,34 @@
+function RIGHT(a, b) {
+  import("./async1")
+  if (a > 1) {
+    // ...
+  }
+  do {
+    // ...
+  } while (i < 5);
+  for (const element of array1) {
+    console.log(element)
+  }
+  with(o) {
+    console.log(x)
+  }
+  switch (expr) {
+    case 'a':
+      // ...
+      break;
+    case 'b':
+      // ...
+      break;
+    default:
+      // ...
+  }
+  try {
+    // ...
+    return (a + c)
+  } 
+  catch (error) {
+    // ...
+  }
+
+  return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-static-function-in-class b/t/t4018/javascript-static-function-in-class
new file mode 100644
index 0000000000..fbf0b7ca3d
--- /dev/null
+++ b/t/t4018/javascript-static-function-in-class
@@ -0,0 +1,6 @@
+class Test {
+  static RIGHT() {
+    let a = 4;
+    let b = ChangeMe;
+  }
+}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index d5abcf4b4c..33073edeca 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -324,6 +324,7 @@ test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver javascript
 test_language_driver matlab
 test_language_driver objc
 test_language_driver pascal
diff --git a/t/t4034/javascript/expect b/t/t4034/javascript/expect
new file mode 100644
index 0000000000..419d61903b
--- /dev/null
+++ b/t/t4034/javascript/expect
@@ -0,0 +1,54 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 18f4796..46f9b62 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,33 +1,33 @@<RESET>
+// DecimalLiteral<RESET>
+<RED>123<RESET>
+<RED>0.123<RESET>
+<RED>.123<RESET>
+<RED>0.123e+5<RESET>
+<RED>0.123E+5<RESET>
+<RED>0.123e5<RESET>
+<RED>1222222222222222223334444n<RESET><GREEN>124<RESET>
+<GREEN>0.124<RESET>
+<GREEN>.124<RESET>
+<GREEN>0.123e-5<RESET>
+<GREEN>0.123E-5<RESET>
+<GREEN>0.123E5<RESET>
+<GREEN>12222222222222222233344445n<RESET>
+// HexIntegerLiteral<RESET>
+<RED>0x10<RESET>
+<RED>0X6Fa1<RESET>
+<RED>0x123_456<RESET>
+<RED>0x1234182989812f1289an<RESET><GREEN>0x11<RESET>
+<GREEN>0X5Fa1<RESET>
+<GREEN>0x123_756<RESET>
+<GREEN>0x1234182989812f1289bn<RESET>
+// OctalIntegerLiteral<RESET>
+<RED>05<RESET>
+<RED>0o6<RESET>
+<RED>0O7<RESET>
+<RED>0512_567<RESET>
+<RED>0o424242424242424242424242424242666666n<RESET><GREEN>06<RESET>
+<GREEN>0o5<RESET>
+<GREEN>0O4<RESET>
+<GREEN>0511_567<RESET>
+<GREEN>0o424242424242424242424242424242666667n<RESET>
+// BinaryIntegerLiteral<RESET>
+<RED>0b1001<RESET>
+<RED>0B0110<RESET>
+<RED>0b0001_1001_0011<RESET>
+<RED>0b1111111111111111111111111111111111111n<RESET><GREEN>0b1101<RESET>
+<GREEN>0B0010<RESET>
+<GREEN>0b0001_1101_0011<RESET>
+<GREEN>0b11111111111111000011111111111111111n<RESET>
+// punctuations<RESET>
+{<RED>a<RESET><GREEN>b<RESET>} (<RED>a<RESET><GREEN>b<RESET>)
+<RED>a<RESET><GREEN>b<RESET>;
+[<RED>1,<RESET>2<GREEN>,3<RESET>]
+[<RED>1, 2,<RESET> ...<RED>params<RESET><GREEN>params_v2<RESET> ]
+a<RED><=<RESET><GREEN>=<RESET>2 a<RED>>=<RESET><GREEN>=<RESET>2 a<RED>==<RESET><GREEN>=<RESET>2 a<RED>!=<RESET><GREEN>=<RESET>2 a<RED>===<RESET><GREEN>=<RESET>2 a<RED>!==<RESET><GREEN>=<RESET>2 a<RED>^=<RESET><GREEN>=<RESET>2 a<RED>=><RESET><GREEN>=<RESET>2
+a<RED>+=<RESET><GREEN>-=<RESET>b a<RED>*=<RESET><GREEN>%=<RESET>b a<RED>**=<RESET><GREEN>&&=<RESET>b a<RED>||=<RESET><GREEN>|=<RESET>b
+b<RED>+<RESET><GREEN>-<RESET>c a<RED>--<RESET><GREEN>++<RESET> a<RED>>><RESET><GREEN><<<RESET>b a<RED>>>><RESET><GREEN>>>>=<RESET>b a<RED>>>=<RESET><GREEN><<=<RESET>b
+a<RED>&&<RESET><GREEN>&<RESET>b a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&=<RESET><GREEN>??=<RESET>b
diff --git a/t/t4034/javascript/post b/t/t4034/javascript/post
new file mode 100644
index 0000000000..46f9b627e4
--- /dev/null
+++ b/t/t4034/javascript/post
@@ -0,0 +1,33 @@
+// DecimalLiteral
+124
+0.124
+.124
+0.123e-5
+0.123E-5
+0.123E5
+12222222222222222233344445n
+// HexIntegerLiteral
+0x11
+0X5Fa1
+0x123_756
+0x1234182989812f1289bn
+// OctalIntegerLiteral
+06
+0o5
+0O4
+0511_567
+0o424242424242424242424242424242666667n
+// BinaryIntegerLiteral
+0b1101
+0B0010
+0b0001_1101_0011
+0b11111111111111000011111111111111111n
+// punctuations
+{b} (b)
+b;
+[2,3]
+[ ...params_v2 ]
+a=2 a=2 a=2 a=2 a=2 a=2 a=2 a=2
+a-=b a%=b a&&=b a|=b
+b-c a++ a<<b a>>>=b a<<=b
+a&b a|b a??=b
diff --git a/t/t4034/javascript/pre b/t/t4034/javascript/pre
new file mode 100644
index 0000000000..18f479688c
--- /dev/null
+++ b/t/t4034/javascript/pre
@@ -0,0 +1,33 @@
+// DecimalLiteral
+123
+0.123
+.123
+0.123e+5
+0.123E+5
+0.123e5
+1222222222222222223334444n
+// HexIntegerLiteral
+0x10
+0X6Fa1
+0x123_456
+0x1234182989812f1289an
+// OctalIntegerLiteral
+05
+0o6
+0O7
+0512_567
+0o424242424242424242424242424242666666n
+// BinaryIntegerLiteral
+0b1001
+0B0110
+0b0001_1001_0011
+0b1111111111111111111111111111111111111n
+// punctuations
+{a} (a)
+a;
+[1,2]
+[ 1, 2, ...params ]
+a<=2 a>=2 a==2 a!=2 a===2 a!==2 a^=2 a=>2
+a+=b a*=b a**=b a||=b
+b+c a-- a>>b a>>>b a>>=b
+a&&b a||b a&&=b
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..51bfe4021d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,38 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+
+PATTERNS("javascript",
+	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
+	 /* don't match statement */
+	 "!;\n"
+	 /* match normal function */
+	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
+	 /* match JavaScript variable declaration with a lambda expression */
+	 "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
+	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
+	 /* match exports for anonymous fucntion */
+	 "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
+	 /* match assign function to LHS */
+	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"
+	 /* match normal function in object literal */
+	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)\n"
+	 /* don't match the function in class, which has more than one ident level */
+	 "!^(\t{2,}|[ ]{5,})\n"
+	 /* match function in class */
+	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",
+	 /* word regex */
+	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, DecimalLiteral and its big version */
+	 "(0[xXoObB])?[0-9a-fA-F][_0-9a-fA-F]*n?"
+	 /* DecimalLiteral may be float */
+	 "|(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
+	 /* punctuations */
+	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
+	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
+	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
+	 /* identifiers */
+	 "|[$_[:alpha:]][$_[:alnum:]]*"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1.273.ge6ebfd0e8c.dirty

