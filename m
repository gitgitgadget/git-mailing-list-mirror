Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94D73207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbdEDWBo (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34123 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbdEDWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id z129so6217310wmb.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eQIWLWV7zMgM2yeTyKGh/wxmFAtTY2jXXgqRm0KIXw=;
        b=cBlbFG9FqnacQcGUzfrnDmYMIWpA63pXUZaDAwxeoVC28gfL4Jh90rXp3mw9KJjYIW
         xS4jkeTdM2bouwIBC+UD2hwQjz0No1jw5BrI2i9Qw+7ecsuM1Q+CISsJtv/08xhbm3A8
         2uquoGzRiMy4S76SkdYjTxnaC1JzZR+lJDjqs9lOdJQ7xdRaldm1BmoBnaX0RlRBBt/N
         rMaad6jR54BC1IEhJkBUYgFhKyrlc39iqdDaxd5x68HT/a7C7D2TpBIA3bbYavRs58fW
         cGqgPQ67QIeHdppFZnjuVRw3dbgaN0V13CGeekqueiixYiNGVSXYt2nnEx0004gdDMLV
         PIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eQIWLWV7zMgM2yeTyKGh/wxmFAtTY2jXXgqRm0KIXw=;
        b=G1g5P0x8nzermJBTWqPx6piR1kDgUa9s0TGvl56KJFV9V1jwR3PtnMhl4cCxUhL1nY
         EjDDHRxuYnb67Ck07UZiq4oLQTvLkIrjkESpgcoxniBRY/i9rGCAjRouktxebYGAiVZD
         8rhTRjYx5tdCZ0vWFsEKdm/LcIwgbD42Sl2FFUMWNr6uPfboio51D+nJzLJVTGaFTio1
         GIuR0AznGyF/cIAc8ynyLbP4Lv9zijnLKaZSy6RlVj/VUXFNOXRQ/WfmjSfCS+9pbidN
         lwDo1kdEp+envmzXjiQrCMg17WbCzPf+gpp5BxVNMtRMOFDSCCFSYWdneXoRtxvS0vvb
         LGdQ==
X-Gm-Message-State: AODbwcAi6gLyvVrdY4zZoO5D4D9Syp2TZQz0qnkCqsckJXID/2jkXaEB
        uBJ5c22hcB6gKg==
X-Received: by 10.28.136.146 with SMTP id k140mr3539191wmd.55.1493935298079;
        Thu, 04 May 2017 15:01:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/7] fixup! compat/regex: update the gawk regex engine from upstream
Date:   Thu,  4 May 2017 22:00:43 +0000
Message-Id: <20170504220043.25702-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 compat/regex/intprops.h | 448 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/regex/verify.h   | 286 +++++++++++++++++++++++++++++++
 2 files changed, 734 insertions(+)
 create mode 100644 compat/regex/intprops.h
 create mode 100644 compat/regex/verify.h

diff --git a/compat/regex/intprops.h b/compat/regex/intprops.h
new file mode 100644
index 0000000000..29f7f40837
--- /dev/null
+++ b/compat/regex/intprops.h
@@ -0,0 +1,448 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
+/* intprops.h -- properties of integer types
+
+   Copyright (C) 2001-2016 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify it
+   under the terms of the GNU Lesser General Public License as published
+   by the Free Software Foundation; either version 2.1 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+/* Written by Paul Eggert.  */
+
+#ifndef _GL_INTPROPS_H
+#define _GL_INTPROPS_H
+
+#include <limits.h>
+
+#ifndef __has_builtin
+# define __has_builtin(x) 0
+#endif
+
+/* Return a value with the common real type of E and V and the value of V.  */
+#define _GL_INT_CONVERT(e, v) (0 * (e) + (v))
+
+/* Act like _GL_INT_CONVERT (E, -V) but work around a bug in IRIX 6.5 cc; see
+   <http://lists.gnu.org/archive/html/bug-gnulib/2011-05/msg00406.html>.  */
+#define _GL_INT_NEGATE_CONVERT(e, v) (0 * (e) - (v))
+
+/* The extra casts in the following macros work around compiler bugs,
+   e.g., in Cray C 5.0.3.0.  */
+
+/* True if the arithmetic type T is an integer type.  bool counts as
+   an integer.  */
+#define TYPE_IS_INTEGER(t) ((t) 1.5 == 1)
+
+/* True if the real type T is signed.  */
+#define TYPE_SIGNED(t) (! ((t) 0 < (t) -1))
+
+/* Return 1 if the real expression E, after promotion, has a
+   signed or floating type.  */
+#define EXPR_SIGNED(e) (_GL_INT_NEGATE_CONVERT (e, 1) < 0)
+
+
+/* Minimum and maximum values for integer types and expressions.  */
+
+/* The width in bits of the integer type or expression T.
+   Padding bits are not supported; this is checked at compile-time below.  */
+#define TYPE_WIDTH(t) (sizeof (t) * CHAR_BIT)
+
+/* The maximum and minimum values for the integer type T.  */
+#define TYPE_MINIMUM(t) ((t) ~ TYPE_MAXIMUM (t))
+#define TYPE_MAXIMUM(t)                                                 \
+  ((t) (! TYPE_SIGNED (t)                                               \
+        ? (t) -1                                                        \
+        : ((((t) 1 << (TYPE_WIDTH (t) - 2)) - 1) * 2 + 1)))
+
+/* The maximum and minimum values for the type of the expression E,
+   after integer promotion.  E should not have side effects.  */
+#define _GL_INT_MINIMUM(e)                                              \
+  (EXPR_SIGNED (e)                                                      \
+   ? ~ _GL_SIGNED_INT_MAXIMUM (e)                                       \
+   : _GL_INT_CONVERT (e, 0))
+#define _GL_INT_MAXIMUM(e)                                              \
+  (EXPR_SIGNED (e)                                                      \
+   ? _GL_SIGNED_INT_MAXIMUM (e)                                         \
+   : _GL_INT_NEGATE_CONVERT (e, 1))
+#define _GL_SIGNED_INT_MAXIMUM(e)                                       \
+  (((_GL_INT_CONVERT (e, 1) << (TYPE_WIDTH ((e) + 0) - 2)) - 1) * 2 + 1)
+
+/* Work around OpenVMS incompatibility with C99.  */
+#if !defined LLONG_MAX && defined __INT64_MAX
+# define LLONG_MAX __INT64_MAX
+# define LLONG_MIN __INT64_MIN
+#endif
+
+/* Does the __typeof__ keyword work?  This could be done by
+   'configure', but for now it's easier to do it by hand.  */
+#if (2 <= __GNUC__ \
+     || (1210 <= __IBMC__ && defined __IBM__TYPEOF__) \
+     || (0x5110 <= __SUNPRO_C && !__STDC__))
+# define _GL_HAVE___TYPEOF__ 1
+#else
+# define _GL_HAVE___TYPEOF__ 0
+#endif
+
+/* Return 1 if the integer type or expression T might be signed.  Return 0
+   if it is definitely unsigned.  This macro does not evaluate its argument,
+   and expands to an integer constant expression.  */
+#if _GL_HAVE___TYPEOF__
+# define _GL_SIGNED_TYPE_OR_EXPR(t) TYPE_SIGNED (__typeof__ (t))
+#else
+# define _GL_SIGNED_TYPE_OR_EXPR(t) 1
+#endif
+
+/* Bound on length of the string representing an unsigned integer
+   value representable in B bits.  log10 (2.0) < 146/485.  The
+   smallest value of B where this bound is not tight is 2621.  */
+#define INT_BITS_STRLEN_BOUND(b) (((b) * 146 + 484) / 485)
+
+/* Bound on length of the string representing an integer type or expression T.
+   Subtract 1 for the sign bit if T is signed, and then add 1 more for
+   a minus sign if needed.
+
+   Because _GL_SIGNED_TYPE_OR_EXPR sometimes returns 0 when its argument is
+   signed, this macro may overestimate the true bound by one byte when
+   applied to unsigned types of size 2, 4, 16, ... bytes.  */
+#define INT_STRLEN_BOUND(t)                                     \
+  (INT_BITS_STRLEN_BOUND (TYPE_WIDTH (t) - _GL_SIGNED_TYPE_OR_EXPR (t)) \
+   + _GL_SIGNED_TYPE_OR_EXPR (t))
+
+/* Bound on buffer size needed to represent an integer type or expression T,
+   including the terminating null.  */
+#define INT_BUFSIZE_BOUND(t) (INT_STRLEN_BOUND (t) + 1)
+
+
+/* Range overflow checks.
+
+   The INT_<op>_RANGE_OVERFLOW macros return 1 if the corresponding C
+   operators might not yield numerically correct answers due to
+   arithmetic overflow.  They do not rely on undefined or
+   implementation-defined behavior.  Their implementations are simple
+   and straightforward, but they are a bit harder to use than the
+   INT_<op>_OVERFLOW macros described below.
+
+   Example usage:
+
+     long int i = ...;
+     long int j = ...;
+     if (INT_MULTIPLY_RANGE_OVERFLOW (i, j, LONG_MIN, LONG_MAX))
+       printf ("multiply would overflow");
+     else
+       printf ("product is %ld", i * j);
+
+   Restrictions on *_RANGE_OVERFLOW macros:
+
+   These macros do not check for all possible numerical problems or
+   undefined or unspecified behavior: they do not check for division
+   by zero, for bad shift counts, or for shifting negative numbers.
+
+   These macros may evaluate their arguments zero or multiple times,
+   so the arguments should not have side effects.  The arithmetic
+   arguments (including the MIN and MAX arguments) must be of the same
+   integer type after the usual arithmetic conversions, and the type
+   must have minimum value MIN and maximum MAX.  Unsigned types should
+   use a zero MIN of the proper type.
+
+   These macros are tuned for constant MIN and MAX.  For commutative
+   operations such as A + B, they are also tuned for constant B.  */
+
+/* Return 1 if A + B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  */
+#define INT_ADD_RANGE_OVERFLOW(a, b, min, max)          \
+  ((b) < 0                                              \
+   ? (a) < (min) - (b)                                  \
+   : (max) - (b) < (a))
+
+/* Return 1 if A - B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  */
+#define INT_SUBTRACT_RANGE_OVERFLOW(a, b, min, max)     \
+  ((b) < 0                                              \
+   ? (max) + (b) < (a)                                  \
+   : (a) < (min) + (b))
+
+/* Return 1 if - A would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  */
+#define INT_NEGATE_RANGE_OVERFLOW(a, min, max)          \
+  ((min) < 0                                            \
+   ? (a) < - (max)                                      \
+   : 0 < (a))
+
+/* Return 1 if A * B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Avoid && and || as they tickle
+   bugs in Sun C 5.11 2010/08/13 and other compilers; see
+   <http://lists.gnu.org/archive/html/bug-gnulib/2011-05/msg00401.html>.  */
+#define INT_MULTIPLY_RANGE_OVERFLOW(a, b, min, max)     \
+  ((b) < 0                                              \
+   ? ((a) < 0                                           \
+      ? (a) < (max) / (b)                               \
+      : (b) == -1                                       \
+      ? 0                                               \
+      : (min) / (b) < (a))                              \
+   : (b) == 0                                           \
+   ? 0                                                  \
+   : ((a) < 0                                           \
+      ? (a) < (min) / (b)                               \
+      : (max) / (b) < (a)))
+
+/* Return 1 if A / B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Do not check for division by zero.  */
+#define INT_DIVIDE_RANGE_OVERFLOW(a, b, min, max)       \
+  ((min) < 0 && (b) == -1 && (a) < - (max))
+
+/* Return 1 if A % B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Do not check for division by zero.
+   Mathematically, % should never overflow, but on x86-like hosts
+   INT_MIN % -1 traps, and the C standard permits this, so treat this
+   as an overflow too.  */
+#define INT_REMAINDER_RANGE_OVERFLOW(a, b, min, max)    \
+  INT_DIVIDE_RANGE_OVERFLOW (a, b, min, max)
+
+/* Return 1 if A << B would overflow in [MIN,MAX] arithmetic.
+   See above for restrictions.  Here, MIN and MAX are for A only, and B need
+   not be of the same type as the other arguments.  The C standard says that
+   behavior is undefined for shifts unless 0 <= B < wordwidth, and that when
+   A is negative then A << B has undefined behavior and A >> B has
+   implementation-defined behavior, but do not check these other
+   restrictions.  */
+#define INT_LEFT_SHIFT_RANGE_OVERFLOW(a, b, min, max)   \
+  ((a) < 0                                              \
+   ? (a) < (min) >> (b)                                 \
+   : (max) >> (b) < (a))
+
+/* True if __builtin_add_overflow (A, B, P) works when P is non-null.  */
+#define _GL_HAS_BUILTIN_OVERFLOW \
+  (5 <= __GNUC__ || __has_builtin (__builtin_add_overflow))
+
+/* True if __builtin_add_overflow_p (A, B, C) works.  */
+#define _GL_HAS_BUILTIN_OVERFLOW_P \
+  (7 <= __GNUC__ || __has_builtin (__builtin_add_overflow_p))
+
+/* The _GL*_OVERFLOW macros have the same restrictions as the
+   *_RANGE_OVERFLOW macros, except that they do not assume that operands
+   (e.g., A and B) have the same type as MIN and MAX.  Instead, they assume
+   that the result (e.g., A + B) has that type.  */
+#if _GL_HAS_BUILTIN_OVERFLOW_P
+# define _GL_ADD_OVERFLOW(a, b, min, max)                               \
+   __builtin_add_overflow_p (a, b, (__typeof__ ((a) + (b))) 0)
+# define _GL_SUBTRACT_OVERFLOW(a, b, min, max)                          \
+   __builtin_sub_overflow_p (a, b, (__typeof__ ((a) - (b))) 0)
+# define _GL_MULTIPLY_OVERFLOW(a, b, min, max)                          \
+   __builtin_mul_overflow_p (a, b, (__typeof__ ((a) * (b))) 0)
+#else
+# define _GL_ADD_OVERFLOW(a, b, min, max)                                \
+   ((min) < 0 ? INT_ADD_RANGE_OVERFLOW (a, b, min, max)                  \
+    : (a) < 0 ? (b) <= (a) + (b)                                         \
+    : (b) < 0 ? (a) <= (a) + (b)                                         \
+    : (a) + (b) < (b))
+# define _GL_SUBTRACT_OVERFLOW(a, b, min, max)                           \
+   ((min) < 0 ? INT_SUBTRACT_RANGE_OVERFLOW (a, b, min, max)             \
+    : (a) < 0 ? 1                                                        \
+    : (b) < 0 ? (a) - (b) <= (a)                                         \
+    : (a) < (b))
+# define _GL_MULTIPLY_OVERFLOW(a, b, min, max)                           \
+   (((min) == 0 && (((a) < 0 && 0 < (b)) || ((b) < 0 && 0 < (a))))       \
+    || INT_MULTIPLY_RANGE_OVERFLOW (a, b, min, max))
+#endif
+#define _GL_DIVIDE_OVERFLOW(a, b, min, max)                             \
+  ((min) < 0 ? (b) == _GL_INT_NEGATE_CONVERT (min, 1) && (a) < - (max)  \
+   : (a) < 0 ? (b) <= (a) + (b) - 1                                     \
+   : (b) < 0 && (a) + (b) <= (a))
+#define _GL_REMAINDER_OVERFLOW(a, b, min, max)                          \
+  ((min) < 0 ? (b) == _GL_INT_NEGATE_CONVERT (min, 1) && (a) < - (max)  \
+   : (a) < 0 ? (a) % (b) != ((max) - (b) + 1) % (b)                     \
+   : (b) < 0 && ! _GL_UNSIGNED_NEG_MULTIPLE (a, b, max))
+
+/* Return a nonzero value if A is a mathematical multiple of B, where
+   A is unsigned, B is negative, and MAX is the maximum value of A's
+   type.  A's type must be the same as (A % B)'s type.  Normally (A %
+   -B == 0) suffices, but things get tricky if -B would overflow.  */
+#define _GL_UNSIGNED_NEG_MULTIPLE(a, b, max)                            \
+  (((b) < -_GL_SIGNED_INT_MAXIMUM (b)                                   \
+    ? (_GL_SIGNED_INT_MAXIMUM (b) == (max)                              \
+       ? (a)                                                            \
+       : (a) % (_GL_INT_CONVERT (a, _GL_SIGNED_INT_MAXIMUM (b)) + 1))   \
+    : (a) % - (b))                                                      \
+   == 0)
+
+/* Check for integer overflow, and report low order bits of answer.
+
+   The INT_<op>_OVERFLOW macros return 1 if the corresponding C operators
+   might not yield numerically correct answers due to arithmetic overflow.
+   The INT_<op>_WRAPV macros also store the low-order bits of the answer.
+   These macros work correctly on all known practical hosts, and do not rely
+   on undefined behavior due to signed arithmetic overflow.
+
+   Example usage, assuming A and B are long int:
+
+     if (INT_MULTIPLY_OVERFLOW (a, b))
+       printf ("result would overflow\n");
+     else
+       printf ("result is %ld (no overflow)\n", a * b);
+
+   Example usage with WRAPV flavor:
+
+     long int result;
+     bool overflow = INT_MULTIPLY_WRAPV (a, b, &result);
+     printf ("result is %ld (%s)\n", result,
+             overflow ? "after overflow" : "no overflow");
+
+   Restrictions on these macros:
+
+   These macros do not check for all possible numerical problems or
+   undefined or unspecified behavior: they do not check for division
+   by zero, for bad shift counts, or for shifting negative numbers.
+
+   These macros may evaluate their arguments zero or multiple times, so the
+   arguments should not have side effects.
+
+   The WRAPV macros are not constant expressions.  They support only
+   +, binary -, and *.  The result type must be signed.
+
+   These macros are tuned for their last argument being a constant.
+
+   Return 1 if the integer expressions A * B, A - B, -A, A * B, A / B,
+   A % B, and A << B would overflow, respectively.  */
+
+#define INT_ADD_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_ADD_OVERFLOW)
+#define INT_SUBTRACT_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_SUBTRACT_OVERFLOW)
+#if _GL_HAS_BUILTIN_OVERFLOW_P
+# define INT_NEGATE_OVERFLOW(a) INT_SUBTRACT_OVERFLOW (0, a)
+#else
+# define INT_NEGATE_OVERFLOW(a) \
+   INT_NEGATE_RANGE_OVERFLOW (a, _GL_INT_MINIMUM (a), _GL_INT_MAXIMUM (a))
+#endif
+#define INT_MULTIPLY_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_MULTIPLY_OVERFLOW)
+#define INT_DIVIDE_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_DIVIDE_OVERFLOW)
+#define INT_REMAINDER_OVERFLOW(a, b) \
+  _GL_BINARY_OP_OVERFLOW (a, b, _GL_REMAINDER_OVERFLOW)
+#define INT_LEFT_SHIFT_OVERFLOW(a, b) \
+  INT_LEFT_SHIFT_RANGE_OVERFLOW (a, b, \
+                                 _GL_INT_MINIMUM (a), _GL_INT_MAXIMUM (a))
+
+/* Return 1 if the expression A <op> B would overflow,
+   where OP_RESULT_OVERFLOW (A, B, MIN, MAX) does the actual test,
+   assuming MIN and MAX are the minimum and maximum for the result type.
+   Arguments should be free of side effects.  */
+#define _GL_BINARY_OP_OVERFLOW(a, b, op_result_overflow)        \
+  op_result_overflow (a, b,                                     \
+                      _GL_INT_MINIMUM (0 * (b) + (a)),          \
+                      _GL_INT_MAXIMUM (0 * (b) + (a)))
+
+/* Store the low-order bits of A + B, A - B, A * B, respectively, into *R.
+   Return 1 if the result overflows.  See above for restrictions.  */
+#define INT_ADD_WRAPV(a, b, r) \
+  _GL_INT_OP_WRAPV (a, b, r, +, __builtin_add_overflow, INT_ADD_OVERFLOW)
+#define INT_SUBTRACT_WRAPV(a, b, r) \
+  _GL_INT_OP_WRAPV (a, b, r, -, __builtin_sub_overflow, INT_SUBTRACT_OVERFLOW)
+#define INT_MULTIPLY_WRAPV(a, b, r) \
+  _GL_INT_OP_WRAPV (a, b, r, *, __builtin_mul_overflow, INT_MULTIPLY_OVERFLOW)
+
+/* Nonzero if this compiler has GCC bug 68193 or Clang bug 25390.  See:
+   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68193
+   https://llvm.org/bugs/show_bug.cgi?id=25390
+   For now, assume all versions of GCC-like compilers generate bogus
+   warnings for _Generic.  This matters only for older compilers that
+   lack __builtin_add_overflow.  */
+#if __GNUC__
+# define _GL__GENERIC_BOGUS 1
+#else
+# define _GL__GENERIC_BOGUS 0
+#endif
+
+/* Store the low-order bits of A <op> B into *R, where OP specifies
+   the operation.  BUILTIN is the builtin operation, and OVERFLOW the
+   overflow predicate.  Return 1 if the result overflows.  See above
+   for restrictions.  */
+#if _GL_HAS_BUILTIN_OVERFLOW
+# define _GL_INT_OP_WRAPV(a, b, r, op, builtin, overflow) builtin (a, b, r)
+#elif 201112 <= __STDC_VERSION__ && !_GL__GENERIC_BOGUS
+# define _GL_INT_OP_WRAPV(a, b, r, op, builtin, overflow) \
+   (_Generic \
+    (*(r), \
+     signed char: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned char, \
+                        signed char, SCHAR_MIN, SCHAR_MAX), \
+     short int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned short int, \
+                        short int, SHRT_MIN, SHRT_MAX), \
+     int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                        int, INT_MIN, INT_MAX), \
+     long int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                        long int, LONG_MIN, LONG_MAX), \
+     long long int: \
+       _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long long int, \
+                        long long int, LLONG_MIN, LLONG_MAX)))
+#else
+# define _GL_INT_OP_WRAPV(a, b, r, op, builtin, overflow) \
+   (sizeof *(r) == sizeof (signed char) \
+    ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned char, \
+                       signed char, SCHAR_MIN, SCHAR_MAX) \
+    : sizeof *(r) == sizeof (short int) \
+    ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned short int, \
+                       short int, SHRT_MIN, SHRT_MAX) \
+    : sizeof *(r) == sizeof (int) \
+    ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned int, \
+                       int, INT_MIN, INT_MAX) \
+    : _GL_INT_OP_WRAPV_LONGISH(a, b, r, op, overflow))
+# ifdef LLONG_MAX
+#  define _GL_INT_OP_WRAPV_LONGISH(a, b, r, op, overflow) \
+    (sizeof *(r) == sizeof (long int) \
+     ? _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                        long int, LONG_MIN, LONG_MAX) \
+     : _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long long int, \
+                        long long int, LLONG_MIN, LLONG_MAX))
+# else
+#  define _GL_INT_OP_WRAPV_LONGISH(a, b, r, op, overflow) \
+    _GL_INT_OP_CALC (a, b, r, op, overflow, unsigned long int, \
+                     long int, LONG_MIN, LONG_MAX)
+# endif
+#endif
+
+/* Store the low-order bits of A <op> B into *R, where the operation
+   is given by OP.  Use the unsigned type UT for calculation to avoid
+   overflow problems.  *R's type is T, with extremal values TMIN and
+   TMAX.  T must be a signed integer type.  Return 1 if the result
+   overflows.  */
+#define _GL_INT_OP_CALC(a, b, r, op, overflow, ut, t, tmin, tmax) \
+  (sizeof ((a) op (b)) < sizeof (t) \
+   ? _GL_INT_OP_CALC1 ((t) (a), (t) (b), r, op, overflow, ut, t, tmin, tmax) \
+   : _GL_INT_OP_CALC1 (a, b, r, op, overflow, ut, t, tmin, tmax))
+#define _GL_INT_OP_CALC1(a, b, r, op, overflow, ut, t, tmin, tmax) \
+  ((overflow (a, b) \
+    || (EXPR_SIGNED ((a) op (b)) && ((a) op (b)) < (tmin)) \
+    || (tmax) < ((a) op (b))) \
+   ? (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a, b, op, ut, t, tmin, tmax), 1) \
+   : (*(r) = _GL_INT_OP_WRAPV_VIA_UNSIGNED (a, b, op, ut, t, tmin, tmax), 0))
+
+/* Return A <op> B, where the operation is given by OP.  Use the
+   unsigned type UT for calculation to avoid overflow problems.
+   Convert the result to type T without overflow by subtracting TMIN
+   from large values before converting, and adding it afterwards.
+   Compilers can optimize all the operations except OP.  */
+#define _GL_INT_OP_WRAPV_VIA_UNSIGNED(a, b, op, ut, t, tmin, tmax) \
+  (((ut) (a) op (ut) (b)) <= (tmax) \
+   ? (t) ((ut) (a) op (ut) (b)) \
+   : ((t) (((ut) (a) op (ut) (b)) - (tmin)) + (tmin)))
+
+#endif /* _GL_INTPROPS_H */
diff --git a/compat/regex/verify.h b/compat/regex/verify.h
new file mode 100644
index 0000000000..e865af5298
--- /dev/null
+++ b/compat/regex/verify.h
@@ -0,0 +1,286 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
+/* Compile-time assert-like macros.
+
+   Copyright (C) 2005-2006, 2009-2016 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+/* Written by Paul Eggert, Bruno Haible, and Jim Meyering.  */
+
+#ifndef _GL_VERIFY_H
+#define _GL_VERIFY_H
+
+
+/* Define _GL_HAVE__STATIC_ASSERT to 1 if _Static_assert works as per C11.
+   This is supported by GCC 4.6.0 and later, in C mode, and its use
+   here generates easier-to-read diagnostics when verify (R) fails.
+
+   Define _GL_HAVE_STATIC_ASSERT to 1 if static_assert works as per C++11.
+   This will likely be supported by future GCC versions, in C++ mode.
+
+   Use this only with GCC.  If we were willing to slow 'configure'
+   down we could also use it with other compilers, but since this
+   affects only the quality of diagnostics, why bother?  */
+#if (4 < __GNUC__ + (6 <= __GNUC_MINOR__) \
+     && (201112L <= __STDC_VERSION__  || !defined __STRICT_ANSI__) \
+     && !defined __cplusplus)
+# define _GL_HAVE__STATIC_ASSERT 1
+#endif
+/* The condition (99 < __GNUC__) is temporary, until we know about the
+   first G++ release that supports static_assert.  */
+#if (99 < __GNUC__) && defined __cplusplus
+# define _GL_HAVE_STATIC_ASSERT 1
+#endif
+
+/* FreeBSD 9.1 <sys/cdefs.h>, included by <stddef.h> and lots of other
+   system headers, defines a conflicting _Static_assert that is no
+   better than ours; override it.  */
+#ifndef _GL_HAVE_STATIC_ASSERT
+# include <stddef.h>
+# undef _Static_assert
+#endif
+
+/* Each of these macros verifies that its argument R is nonzero.  To
+   be portable, R should be an integer constant expression.  Unlike
+   assert (R), there is no run-time overhead.
+
+   If _Static_assert works, verify (R) uses it directly.  Similarly,
+   _GL_VERIFY_TRUE works by packaging a _Static_assert inside a struct
+   that is an operand of sizeof.
+
+   The code below uses several ideas for C++ compilers, and for C
+   compilers that do not support _Static_assert:
+
+   * The first step is ((R) ? 1 : -1).  Given an expression R, of
+     integral or boolean or floating-point type, this yields an
+     expression of integral type, whose value is later verified to be
+     constant and nonnegative.
+
+   * Next this expression W is wrapped in a type
+     struct _gl_verify_type {
+       unsigned int _gl_verify_error_if_negative: W;
+     }.
+     If W is negative, this yields a compile-time error.  No compiler can
+     deal with a bit-field of negative size.
+
+     One might think that an array size check would have the same
+     effect, that is, that the type struct { unsigned int dummy[W]; }
+     would work as well.  However, inside a function, some compilers
+     (such as C++ compilers and GNU C) allow local parameters and
+     variables inside array size expressions.  With these compilers,
+     an array size check would not properly diagnose this misuse of
+     the verify macro:
+
+       void function (int n) { verify (n < 0); }
+
+   * For the verify macro, the struct _gl_verify_type will need to
+     somehow be embedded into a declaration.  To be portable, this
+     declaration must declare an object, a constant, a function, or a
+     typedef name.  If the declared entity uses the type directly,
+     such as in
+
+       struct dummy {...};
+       typedef struct {...} dummy;
+       extern struct {...} *dummy;
+       extern void dummy (struct {...} *);
+       extern struct {...} *dummy (void);
+
+     two uses of the verify macro would yield colliding declarations
+     if the entity names are not disambiguated.  A workaround is to
+     attach the current line number to the entity name:
+
+       #define _GL_CONCAT0(x, y) x##y
+       #define _GL_CONCAT(x, y) _GL_CONCAT0 (x, y)
+       extern struct {...} * _GL_CONCAT (dummy, __LINE__);
+
+     But this has the problem that two invocations of verify from
+     within the same macro would collide, since the __LINE__ value
+     would be the same for both invocations.  (The GCC __COUNTER__
+     macro solves this problem, but is not portable.)
+
+     A solution is to use the sizeof operator.  It yields a number,
+     getting rid of the identity of the type.  Declarations like
+
+       extern int dummy [sizeof (struct {...})];
+       extern void dummy (int [sizeof (struct {...})]);
+       extern int (*dummy (void)) [sizeof (struct {...})];
+
+     can be repeated.
+
+   * Should the implementation use a named struct or an unnamed struct?
+     Which of the following alternatives can be used?
+
+       extern int dummy [sizeof (struct {...})];
+       extern int dummy [sizeof (struct _gl_verify_type {...})];
+       extern void dummy (int [sizeof (struct {...})]);
+       extern void dummy (int [sizeof (struct _gl_verify_type {...})]);
+       extern int (*dummy (void)) [sizeof (struct {...})];
+       extern int (*dummy (void)) [sizeof (struct _gl_verify_type {...})];
+
+     In the second and sixth case, the struct type is exported to the
+     outer scope; two such declarations therefore collide.  GCC warns
+     about the first, third, and fourth cases.  So the only remaining
+     possibility is the fifth case:
+
+       extern int (*dummy (void)) [sizeof (struct {...})];
+
+   * GCC warns about duplicate declarations of the dummy function if
+     -Wredundant-decls is used.  GCC 4.3 and later have a builtin
+     __COUNTER__ macro that can let us generate unique identifiers for
+     each dummy function, to suppress this warning.
+
+   * This implementation exploits the fact that older versions of GCC,
+     which do not support _Static_assert, also do not warn about the
+     last declaration mentioned above.
+
+   * GCC warns if -Wnested-externs is enabled and verify() is used
+     within a function body; but inside a function, you can always
+     arrange to use verify_expr() instead.
+
+   * In C++, any struct definition inside sizeof is invalid.
+     Use a template type to work around the problem.  */
+
+/* Concatenate two preprocessor tokens.  */
+#define _GL_CONCAT(x, y) _GL_CONCAT0 (x, y)
+#define _GL_CONCAT0(x, y) x##y
+
+/* _GL_COUNTER is an integer, preferably one that changes each time we
+   use it.  Use __COUNTER__ if it works, falling back on __LINE__
+   otherwise.  __LINE__ isn't perfect, but it's better than a
+   constant.  */
+#if defined __COUNTER__ && __COUNTER__ != __COUNTER__
+# define _GL_COUNTER __COUNTER__
+#else
+# define _GL_COUNTER __LINE__
+#endif
+
+/* Generate a symbol with the given prefix, making it unique if
+   possible.  */
+#define _GL_GENSYM(prefix) _GL_CONCAT (prefix, _GL_COUNTER)
+
+/* Verify requirement R at compile-time, as an integer constant expression
+   that returns 1.  If R is false, fail at compile-time, preferably
+   with a diagnostic that includes the string-literal DIAGNOSTIC.  */
+
+#define _GL_VERIFY_TRUE(R, DIAGNOSTIC) \
+   (!!sizeof (_GL_VERIFY_TYPE (R, DIAGNOSTIC)))
+
+#ifdef __cplusplus
+# if !GNULIB_defined_struct__gl_verify_type
+template <int w>
+  struct _gl_verify_type {
+    unsigned int _gl_verify_error_if_negative: w;
+  };
+#  define GNULIB_defined_struct__gl_verify_type 1
+# endif
+# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
+    _gl_verify_type<(R) ? 1 : -1>
+#elif defined _GL_HAVE__STATIC_ASSERT
+# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
+    struct {                                   \
+      _Static_assert (R, DIAGNOSTIC);          \
+      int _gl_dummy;                          \
+    }
+#else
+# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
+    struct { unsigned int _gl_verify_error_if_negative: (R) ? 1 : -1; }
+#endif
+
+/* Verify requirement R at compile-time, as a declaration without a
+   trailing ';'.  If R is false, fail at compile-time, preferably
+   with a diagnostic that includes the string-literal DIAGNOSTIC.
+
+   Unfortunately, unlike C11, this implementation must appear as an
+   ordinary declaration, and cannot appear inside struct { ... }.  */
+
+#ifdef _GL_HAVE__STATIC_ASSERT
+# define _GL_VERIFY _Static_assert
+#else
+# define _GL_VERIFY(R, DIAGNOSTIC)				       \
+    extern int (*_GL_GENSYM (_gl_verify_function) (void))	       \
+      [_GL_VERIFY_TRUE (R, DIAGNOSTIC)]
+#endif
+
+/* _GL_STATIC_ASSERT_H is defined if this code is copied into assert.h.  */
+#ifdef _GL_STATIC_ASSERT_H
+# if !defined _GL_HAVE__STATIC_ASSERT && !defined _Static_assert
+#  define _Static_assert(R, DIAGNOSTIC) _GL_VERIFY (R, DIAGNOSTIC)
+# endif
+# if !defined _GL_HAVE_STATIC_ASSERT && !defined static_assert
+#  define static_assert _Static_assert /* C11 requires this #define.  */
+# endif
+#endif
+
+/* @assert.h omit start@  */
+
+/* Each of these macros verifies that its argument R is nonzero.  To
+   be portable, R should be an integer constant expression.  Unlike
+   assert (R), there is no run-time overhead.
+
+   There are two macros, since no single macro can be used in all
+   contexts in C.  verify_true (R) is for scalar contexts, including
+   integer constant expression contexts.  verify (R) is for declaration
+   contexts, e.g., the top level.  */
+
+/* Verify requirement R at compile-time, as an integer constant expression.
+   Return 1.  This is equivalent to verify_expr (R, 1).
+
+   verify_true is obsolescent; please use verify_expr instead.  */
+
+#define verify_true(R) _GL_VERIFY_TRUE (R, "verify_true (" #R ")")
+
+/* Verify requirement R at compile-time.  Return the value of the
+   expression E.  */
+
+#define verify_expr(R, E) \
+   (_GL_VERIFY_TRUE (R, "verify_expr (" #R ", " #E ")") ? (E) : (E))
+
+/* Verify requirement R at compile-time, as a declaration without a
+   trailing ';'.  */
+
+#define verify(R) _GL_VERIFY (R, "verify (" #R ")")
+
+#ifndef __has_builtin
+# define __has_builtin(x) 0
+#endif
+
+/* Assume that R always holds.  This lets the compiler optimize
+   accordingly.  R should not have side-effects; it may or may not be
+   evaluated.  Behavior is undefined if R is false.  */
+
+#if (__has_builtin (__builtin_unreachable) \
+     || 4 < __GNUC__ + (5 <= __GNUC_MINOR__))
+# define assume(R) ((R) ? (void) 0 : __builtin_unreachable ())
+#elif 1200 <= _MSC_VER
+# define assume(R) __assume (R)
+#elif ((defined GCC_LINT || defined lint) \
+       && (__has_builtin (__builtin_trap) \
+           || 3 < __GNUC__ + (3 < __GNUC_MINOR__ + (4 <= __GNUC_PATCHLEVEL__))))
+  /* Doing it this way helps various packages when configured with
+     --enable-gcc-warnings, which compiles with -Dlint.  It's nicer
+     when 'assume' silences warnings even with older GCCs.  */
+# define assume(R) ((R) ? (void) 0 : __builtin_trap ())
+#else
+# define assume(R) ((void) (0 && (R)))
+#endif
+
+/* @assert.h omit end@  */
+
+#endif
-- 
2.11.0

