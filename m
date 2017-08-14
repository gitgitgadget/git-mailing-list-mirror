Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645A120899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdHNVa6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:30:58 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33597 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdHNVa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:30:56 -0400
Received: by mail-pg0-f41.google.com with SMTP id u5so54862135pgn.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/UqW6xU2oDyuH7i0LogEO+odNOtu7wQF13rZzdynTA=;
        b=alRlidXZuXBNNB5kAvn+YzcFQiYI+yzB1A+HT2oMrh2ujTP8zPVSosD5Xez2bqvIaN
         9Z+n8IekXJ3L4DFFwqWVQ+uwrr9XGdurRlBob/3raHUM9m7awsjmG61KPCbdloEzb27K
         o5VqefGoqB8O8/zye4QXCuPMi1zsqoVZI4dfiJMSgJWwduoDkBZUvpYY+gAFEEAT0rBv
         HDqgCOFSi5g/owPe1CWLGnmBfK8M60lipWhx5S0n8LOS3/SiCuQhn5tecxcZAn09D/oM
         alrgUntEUyUSjB4TewZ1tSBQa4evPk04ubWABwCtYKmoETUsQWk4cZ4WfOJerpzZV3sm
         repg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/UqW6xU2oDyuH7i0LogEO+odNOtu7wQF13rZzdynTA=;
        b=r8g47uxKtOvvn3QfMCDqpkB+jKj26bsTEJf+O3FdI6fzYbDC2RYUS/oHZtExnLUzM0
         uU2CCfmAnWyvyL9K8P8voDxxIjfPwQFI3E66K0gWbxrnI1CUKnCqqERLSQEGtkd+QDvl
         5guxojS+Us8JO8ZbIbs5xELxRBW/gBzk0/2jxz3gQTqhnr1z5g6wES/ExB2tHyx0Qpsz
         2dj2xHFR20ZAVQVhgll2sNsmRTk1B//5oygG4G13tPv+SI3PQAXOHZOwVhGnNDOq9fA0
         YPnsoZtX++gHQw4usppdrdbn/IYeXPWj+RRw1JLNqkjSPdQhnGBP+cWW5crT5odw9rZx
         DQMQ==
X-Gm-Message-State: AHYfb5jevxJkaIBYk+V2ab8WwLEp0OTpPgTRJlg+TL+u5SfeL2Wwpne9
        mZbRKSNJ0Yb0kP/sEWRgSA==
X-Received: by 10.99.2.209 with SMTP id 200mr25413993pgc.403.1502746255420;
        Mon, 14 Aug 2017 14:30:55 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h62sm15842737pfc.97.2017.08.14.14.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:30:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com, peff@peff.net,
        peartben@gmail.com, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/2] clang-format: outline the git project's coding style
Date:   Mon, 14 Aug 2017 14:30:45 -0700
Message-Id: <20170814213046.107576-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <20170814213046.107576-1-bmwill@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a '.clang-format' file which outlines the git project's coding
style.  This can be used with clang-format to auto-format .c and .h
files to conform with git's style.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 .clang-format | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 000000000..3ede2628d
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,165 @@
+# Defaults
+
+# Use tabs whenever we need to fill whitespace that spans at least from one tab
+# stop to the next one.
+UseTab: Always
+TabWidth: 8
+IndentWidth: 8
+ContinuationIndentWidth: 8
+ColumnLimit: 80
+
+# C Language specifics
+Language: Cpp
+
+# Align parameters on the open bracket
+# someLongFunction(argument1,
+#                  argument2);
+AlignAfterOpenBracket: Align
+
+# Don't align consecutive assignments
+# int aaaa = 12;
+# int b = 14;
+AlignConsecutiveAssignments: false
+
+# Don't align consecutive declarations
+# int aaaa = 12;
+# double b = 3.14;
+AlignConsecutiveDeclarations: false
+
+# Align escaped newlines as far left as possible
+# #define A   \
+#   int aaaa; \
+#   int b;    \
+#   int cccccccc;
+AlignEscapedNewlines: Left
+
+# Align operands of binary and ternary expressions
+# int aaa = bbbbbbbbbbb +
+#           cccccc;
+AlignOperands: true
+
+# Don't align trailing comments
+# int a; // Comment a
+# int b = 2; // Comment b
+AlignTrailingComments: false
+
+# By default don't allow putting parameters onto the next line
+# myFunction(foo, bar, baz);
+AllowAllParametersOfDeclarationOnNextLine: false
+
+# Don't allow short braced statements to be on a single line
+# if (a)           not       if (a) return;
+#   return;
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: false
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+
+# By default don't add a line break after the return type of top-level functions
+# int foo();
+AlwaysBreakAfterReturnType: None
+
+# Pack as many parameters or arguments onto the same line as possible
+# int myFunction(int aaaaaaaaaaaa, int bbbbbbbb,
+#                int cccc);
+BinPackArguments: true
+BinPackParameters: true
+
+# Attach braces to surrounding context except break before braces on function
+# definitions.
+# void foo()
+# {
+#    if (true) {
+#    } else {
+#    }
+# };
+BreakBeforeBraces: Linux
+
+# Break after operators
+# int valuve = aaaaaaaaaaaaa +
+#              bbbbbb -
+#              ccccccccccc;
+BreakBeforeBinaryOperators: None
+BreakBeforeTernaryOperators: false
+
+# Don't break string literals
+BreakStringLiterals: false
+
+# Use the same indentation level as for the switch statement.
+# Switch statement body is always indented one level more than case labels.
+IndentCaseLabels: false
+
+# Don't indent a function definition or declaration if it is wrapped after the
+# type
+IndentWrappedFunctionNames: false
+
+# Align pointer to the right
+# int *a;
+PointerAlignment: Right
+
+# Don't insert a space after a cast
+# x = (int32)y;    not    x = (int32) y;
+SpaceAfterCStyleCast: false
+
+# Insert spaces before and after assignment operators
+# int a = 5;    not    int a=5;
+# a += 42;             a+=42;
+SpaceBeforeAssignmentOperators: true
+
+# Put a space before opening parentheses only after control statement keywords.
+# void f() {
+#   if (true) {
+#     f();
+#   }
+# }
+SpaceBeforeParens: ControlStatements
+
+# Don't insert spaces inside empty '()'
+SpaceInEmptyParentheses: false
+
+# The number of spaces before trailing line comments (// - comments).
+# This does not affect trailing block comments (/* - comments).
+SpacesBeforeTrailingComments: 1
+
+# Don't insert spaces in casts
+# x = (int32) y;    not    x = ( int32 ) y;
+SpacesInCStyleCastParentheses: false
+
+# Don't insert spaces inside container literals
+# var arr = [1, 2, 3];    not    var arr = [ 1, 2, 3 ];
+SpacesInContainerLiterals: false
+
+# Don't insert spaces after '(' or before ')'
+# f(arg);    not    f( arg );
+SpacesInParentheses: false
+
+# Don't insert spaces after '[' or before ']'
+# int a[5];    not    int a[ 5 ];
+SpacesInSquareBrackets: false
+
+# Insert a space after '{' and before '}' in struct initializers
+Cpp11BracedListStyle: false
+
+# A list of macros that should be interpreted as foreach loops instead of as
+# function calls.
+ForEachMacros: ['for_each_string_list_item']
+
+# The maximum number of consecutive empty lines to keep.
+MaxEmptyLinesToKeep: 1
+
+# No empty line at the start of a block.
+KeepEmptyLinesAtTheStartOfBlocks: false
+
+# Penalties
+# This decides what order things should be done if a line is too long
+PenaltyBreakAssignment: 100
+PenaltyBreakBeforeFirstCallParameter: 100
+PenaltyBreakComment: 100
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 100
+PenaltyExcessCharacter: 5
+PenaltyReturnTypeOnItsOwnLine: 0
+
+# Don't sort #include's
+SortIncludes: false
-- 
2.14.1.480.gb18f417b89-goog

