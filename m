Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E2B2047F
	for <e@80x24.org>; Tue,  8 Aug 2017 01:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbdHHB0H (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 21:26:07 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36258 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdHHB0G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 21:26:06 -0400
Received: by mail-pf0-f171.google.com with SMTP id c28so8060283pfe.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NyoQxTC0uZdQJbOy+LD6B14cACrxPCWUdt8pb9MI+ZY=;
        b=siyencOJH/bmIX/PtdWH2fdnUuoBI+dD18brt0ivUocKbngjQGA2YfNAj/PaMzA6Z7
         z/4lBCJV2TROAJYBNKDHwhd+ieoPsUWw5L1hy6rBXlyFlwuFFtDdZHVT5GWMGO5u3q0t
         +NM94ABqpDFnQPwQBtIpZtDBjdTrYEsmt06Mh1EX989OawkZDmkuh/SuuUhhEM5IigFs
         8xsfxW2w5x7GkQjNZ/bKUMsbeQWmCL/FkH/zhDm9R1EpPcCLRnjhejoAPIVO/M9qjUJL
         jee9cgA1qbMD10y0bCgdTtFSdO7KijoET74+XicAKazXJK8Fc6JSTjh39hLfxLLoY2pf
         5eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NyoQxTC0uZdQJbOy+LD6B14cACrxPCWUdt8pb9MI+ZY=;
        b=UDsMX95LhiikcM2onLwGc5fwe68mcCHeI69OJLTvwUee0yeBEMrZti3Rnbuf4dJQk1
         L0viihkiTNkJkOgLusugO3UrOh0geLDJyaQ7on+wusmitX8K+HkixuAYjGXc0IFrKUDz
         EM9cib7UXQoDcfuxGUljHf6l/bfDNuRfeNfZ+l5/OdQcoFiFRR8OaS5QMoM0A8zABNKf
         8cm45D6GXclExyVwygbFlpIZvX31WCCEJ0Ul6xk4GwuNkMElr2Dr9Ynoukw90cFYHwAL
         sYquKNQvEwIZvLyYowhKdV14SmFaUVQ+GD0rbxHEQNlWhqlaw2SGs22Gy54VzEuhKNu3
         90gw==
X-Gm-Message-State: AHYfb5ievk7wfGfnH5jQxuj7gnD8PexEc7dschG7acI10Hrm2uHB7ZIo
        pfEXN5MVGsXRIDnLcqu6tA==
X-Received: by 10.99.98.69 with SMTP id w66mr2337537pgb.58.1502155565202;
        Mon, 07 Aug 2017 18:26:05 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s18sm118476pfg.166.2017.08.07.18.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 18:26:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [RFC] clang-format: outline the git project's coding style
Date:   Mon,  7 Aug 2017 18:25:54 -0700
Message-Id: <20170808012554.186051-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a '.clang-format' file which outlines the git project's coding
style.  This can be used with clang-format to auto-format .c and .h
files to conform with git's style.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

I'm sure this sort of thing comes up every so often on the list but back at
git-merge I mentioned how it would be nice to not have to worry about style
when reviewing patches as that is something mechanical and best left to a
machine (for the most part).  I saw that 'clang-format' was brought up on the
list once before a couple years ago
(https://public-inbox.org/git/20150121220903.GA10267@peff.net/) but nothing
really came of it.  I spent a little bit of time combing through the various
options and came up with this config based on the general style of our code
base.  The big issue though is that our code base isn't consistent so try as
you might you wont be able to come up with a config which matches everything we
do (mostly due to the inconsistencies in our code base).

Anyway, I thought I'd bring this topic back up and see how people feel about it.

 .clang-format | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 000000000..7f28dc259
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,166 @@
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
+# Add a line break after the return type of top-level functions
+# int
+# foo();
+AlwaysBreakAfterReturnType: TopLevel
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
+# Insert a space after a cast
+# x = (int32) y;    not    x = (int32)y;
+SpaceAfterCStyleCast: true
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
2.14.0.434.g98096fd7a8-goog

