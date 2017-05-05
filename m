Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA69F207D6
	for <e@80x24.org>; Fri,  5 May 2017 06:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755625AbdEEGMr (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 02:12:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33579 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755609AbdEEGMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 02:12:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so7631293wmh.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 23:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uF9OV3KYtCF6fgV8teRIeasdquTT/0cJ93jVuVAeRUU=;
        b=LwNvvqdS4jH/TqKBcDnOOXXNSugTFLkYh2/GCCQ4Ruiten6XVrozVWLkM20MApWbem
         wD0uYpYMI/fC75beotsYk6PmPu/WhgJJIx7molNkR4srcSV7oxenYZWjTVHUjWw9exU9
         Hv6wvsUcI6d9Ypt4dMFy7qg6mksPck47xfsQtNU9Nsze/ho7Ekjy7t1WLpWmv37gW9OA
         kdF2wbgi/Wh0eKAbJ3S4ralNmucs5DplG4UHtAzEzZCVf4lCUFmTQSCBakhgtXhGJRwK
         j9dfc0NYzLQw0b0GWbkVguSAwmfHEtcahxHv/B5rlZ86HIwyJ7ytY4xMIur4E8diXnkS
         nLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uF9OV3KYtCF6fgV8teRIeasdquTT/0cJ93jVuVAeRUU=;
        b=BIjNkjgNVPNs9OzCGW5zLhZjeSf3ASwSttZqqp/vdA66tb1jSsvkNzyLdyTx3xWBXq
         Uj1cV/mavzx+Ua0AghFKbiNn/bj8/J8FXuRu8WZpL/p9qvdOMJw92ym7tQ6HPbkU61AZ
         qvF0H2oMEhP975gON3M3aWTQMC7uHn+l2SMpFQ3Af8hWP/feTQjBf4ajB0F0F+CFXXJj
         +usuaM5AiqfQ+lUa7N/aEhA8tUmiuscj3gfBSJI0deu9gI0RwVdS5UlMBbelBENNGlac
         GXh8FCM14HR/mwXTAjdlJloh1bQXHTtlKOjD1aYSsU729Lg3DxC6sy7hPzZQ3ALtIiek
         izNA==
X-Gm-Message-State: AN3rC/4xAPmHbz31ZhF14sjsGWLsGUJ5SpoM9xGmgn6EMFbdVnBloXS0
        sHj3K9JZQcQXAqhd7OQ=
X-Received: by 10.28.29.6 with SMTP id d6mr4338710wmd.71.1493964764097;
        Thu, 04 May 2017 23:12:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c34sm4150022wrc.7.2017.05.04.23.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 23:12:43 -0700 (PDT)
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
Subject: [PATCH v2 8/7] fixup! compat/regex: update the gawk regex engine from upstream
Date:   Fri,  5 May 2017 06:12:25 +0000
Message-Id: <20170505061225.20000-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <a4731849-048c-1b3c-11e8-94c614f8b2de@kdbg.org>
References: <a4731849-048c-1b3c-11e8-94c614f8b2de@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---

On Fri, May 5, 2017 at 7:54 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> GNU C Library 2016? Is this GPL v3 code? that would be incompatible with GPL
> v2, I think.

No, it's all under LGPL 2.1, the glibc license has not changed since
2010.

As noted in patch 02 one amendmend to one of the LGPL 2.1 files from
glibc requires a GPLv3 header, this is a change made by Gawk in
importing it from glibc, but I removed that dependency.

But I forgot to subsequently git rm the relevant header file & amend
the monkeypatch. Here's a !fixup on top for that.

Junio: Just sending this one patch of v2, if you'd like to fetch the
whole thing it's import-2017-upstream-gawk-regex-engine-2 on
github.com/avar/git

 .../0001-Add-notice-at-top-of-copied-files.patch   |  15 --
 compat/regex/verify.h                              | 286 ---------------------
 2 files changed, 301 deletions(-)
 delete mode 100644 compat/regex/verify.h

diff --git a/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch b/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
index 4b4acc45ba..4f82185174 100644
--- a/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
+++ b/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
@@ -103,18 +103,3 @@ index c8f11e52e7..c79ff38b1c 100644
  /* Extended regular expression matching and search library.
     Copyright (C) 2002-2016 Free Software Foundation, Inc.
     This file is part of the GNU C Library.
-diff --git a/compat/regex/verify.h b/compat/regex/verify.h
-index 5c8381d290..e865af5298 100644
---- a/compat/regex/verify.h
-+++ b/compat/regex/verify.h
-@@ -1,3 +1,10 @@
-+/*
-+ * This is git.git's copy of gawk.git's regex engine. Please see that
-+ * project for the latest version & to submit patches to this code,
-+ * and git.git's compat/regex/README for information on how git's copy
-+ * of this code is maintained.
-+ */
-+
- /* Compile-time assert-like macros.
- 
-    Copyright (C) 2005-2006, 2009-2016 Free Software Foundation, Inc.
diff --git a/compat/regex/verify.h b/compat/regex/verify.h
deleted file mode 100644
index e865af5298..0000000000
--- a/compat/regex/verify.h
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- * This is git.git's copy of gawk.git's regex engine. Please see that
- * project for the latest version & to submit patches to this code,
- * and git.git's compat/regex/README for information on how git's copy
- * of this code is maintained.
- */
-
-/* Compile-time assert-like macros.
-
-   Copyright (C) 2005-2006, 2009-2016 Free Software Foundation, Inc.
-
-   This program is free software: you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 3 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
-
-/* Written by Paul Eggert, Bruno Haible, and Jim Meyering.  */
-
-#ifndef _GL_VERIFY_H
-#define _GL_VERIFY_H
-
-
-/* Define _GL_HAVE__STATIC_ASSERT to 1 if _Static_assert works as per C11.
-   This is supported by GCC 4.6.0 and later, in C mode, and its use
-   here generates easier-to-read diagnostics when verify (R) fails.
-
-   Define _GL_HAVE_STATIC_ASSERT to 1 if static_assert works as per C++11.
-   This will likely be supported by future GCC versions, in C++ mode.
-
-   Use this only with GCC.  If we were willing to slow 'configure'
-   down we could also use it with other compilers, but since this
-   affects only the quality of diagnostics, why bother?  */
-#if (4 < __GNUC__ + (6 <= __GNUC_MINOR__) \
-     && (201112L <= __STDC_VERSION__  || !defined __STRICT_ANSI__) \
-     && !defined __cplusplus)
-# define _GL_HAVE__STATIC_ASSERT 1
-#endif
-/* The condition (99 < __GNUC__) is temporary, until we know about the
-   first G++ release that supports static_assert.  */
-#if (99 < __GNUC__) && defined __cplusplus
-# define _GL_HAVE_STATIC_ASSERT 1
-#endif
-
-/* FreeBSD 9.1 <sys/cdefs.h>, included by <stddef.h> and lots of other
-   system headers, defines a conflicting _Static_assert that is no
-   better than ours; override it.  */
-#ifndef _GL_HAVE_STATIC_ASSERT
-# include <stddef.h>
-# undef _Static_assert
-#endif
-
-/* Each of these macros verifies that its argument R is nonzero.  To
-   be portable, R should be an integer constant expression.  Unlike
-   assert (R), there is no run-time overhead.
-
-   If _Static_assert works, verify (R) uses it directly.  Similarly,
-   _GL_VERIFY_TRUE works by packaging a _Static_assert inside a struct
-   that is an operand of sizeof.
-
-   The code below uses several ideas for C++ compilers, and for C
-   compilers that do not support _Static_assert:
-
-   * The first step is ((R) ? 1 : -1).  Given an expression R, of
-     integral or boolean or floating-point type, this yields an
-     expression of integral type, whose value is later verified to be
-     constant and nonnegative.
-
-   * Next this expression W is wrapped in a type
-     struct _gl_verify_type {
-       unsigned int _gl_verify_error_if_negative: W;
-     }.
-     If W is negative, this yields a compile-time error.  No compiler can
-     deal with a bit-field of negative size.
-
-     One might think that an array size check would have the same
-     effect, that is, that the type struct { unsigned int dummy[W]; }
-     would work as well.  However, inside a function, some compilers
-     (such as C++ compilers and GNU C) allow local parameters and
-     variables inside array size expressions.  With these compilers,
-     an array size check would not properly diagnose this misuse of
-     the verify macro:
-
-       void function (int n) { verify (n < 0); }
-
-   * For the verify macro, the struct _gl_verify_type will need to
-     somehow be embedded into a declaration.  To be portable, this
-     declaration must declare an object, a constant, a function, or a
-     typedef name.  If the declared entity uses the type directly,
-     such as in
-
-       struct dummy {...};
-       typedef struct {...} dummy;
-       extern struct {...} *dummy;
-       extern void dummy (struct {...} *);
-       extern struct {...} *dummy (void);
-
-     two uses of the verify macro would yield colliding declarations
-     if the entity names are not disambiguated.  A workaround is to
-     attach the current line number to the entity name:
-
-       #define _GL_CONCAT0(x, y) x##y
-       #define _GL_CONCAT(x, y) _GL_CONCAT0 (x, y)
-       extern struct {...} * _GL_CONCAT (dummy, __LINE__);
-
-     But this has the problem that two invocations of verify from
-     within the same macro would collide, since the __LINE__ value
-     would be the same for both invocations.  (The GCC __COUNTER__
-     macro solves this problem, but is not portable.)
-
-     A solution is to use the sizeof operator.  It yields a number,
-     getting rid of the identity of the type.  Declarations like
-
-       extern int dummy [sizeof (struct {...})];
-       extern void dummy (int [sizeof (struct {...})]);
-       extern int (*dummy (void)) [sizeof (struct {...})];
-
-     can be repeated.
-
-   * Should the implementation use a named struct or an unnamed struct?
-     Which of the following alternatives can be used?
-
-       extern int dummy [sizeof (struct {...})];
-       extern int dummy [sizeof (struct _gl_verify_type {...})];
-       extern void dummy (int [sizeof (struct {...})]);
-       extern void dummy (int [sizeof (struct _gl_verify_type {...})]);
-       extern int (*dummy (void)) [sizeof (struct {...})];
-       extern int (*dummy (void)) [sizeof (struct _gl_verify_type {...})];
-
-     In the second and sixth case, the struct type is exported to the
-     outer scope; two such declarations therefore collide.  GCC warns
-     about the first, third, and fourth cases.  So the only remaining
-     possibility is the fifth case:
-
-       extern int (*dummy (void)) [sizeof (struct {...})];
-
-   * GCC warns about duplicate declarations of the dummy function if
-     -Wredundant-decls is used.  GCC 4.3 and later have a builtin
-     __COUNTER__ macro that can let us generate unique identifiers for
-     each dummy function, to suppress this warning.
-
-   * This implementation exploits the fact that older versions of GCC,
-     which do not support _Static_assert, also do not warn about the
-     last declaration mentioned above.
-
-   * GCC warns if -Wnested-externs is enabled and verify() is used
-     within a function body; but inside a function, you can always
-     arrange to use verify_expr() instead.
-
-   * In C++, any struct definition inside sizeof is invalid.
-     Use a template type to work around the problem.  */
-
-/* Concatenate two preprocessor tokens.  */
-#define _GL_CONCAT(x, y) _GL_CONCAT0 (x, y)
-#define _GL_CONCAT0(x, y) x##y
-
-/* _GL_COUNTER is an integer, preferably one that changes each time we
-   use it.  Use __COUNTER__ if it works, falling back on __LINE__
-   otherwise.  __LINE__ isn't perfect, but it's better than a
-   constant.  */
-#if defined __COUNTER__ && __COUNTER__ != __COUNTER__
-# define _GL_COUNTER __COUNTER__
-#else
-# define _GL_COUNTER __LINE__
-#endif
-
-/* Generate a symbol with the given prefix, making it unique if
-   possible.  */
-#define _GL_GENSYM(prefix) _GL_CONCAT (prefix, _GL_COUNTER)
-
-/* Verify requirement R at compile-time, as an integer constant expression
-   that returns 1.  If R is false, fail at compile-time, preferably
-   with a diagnostic that includes the string-literal DIAGNOSTIC.  */
-
-#define _GL_VERIFY_TRUE(R, DIAGNOSTIC) \
-   (!!sizeof (_GL_VERIFY_TYPE (R, DIAGNOSTIC)))
-
-#ifdef __cplusplus
-# if !GNULIB_defined_struct__gl_verify_type
-template <int w>
-  struct _gl_verify_type {
-    unsigned int _gl_verify_error_if_negative: w;
-  };
-#  define GNULIB_defined_struct__gl_verify_type 1
-# endif
-# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
-    _gl_verify_type<(R) ? 1 : -1>
-#elif defined _GL_HAVE__STATIC_ASSERT
-# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
-    struct {                                   \
-      _Static_assert (R, DIAGNOSTIC);          \
-      int _gl_dummy;                          \
-    }
-#else
-# define _GL_VERIFY_TYPE(R, DIAGNOSTIC) \
-    struct { unsigned int _gl_verify_error_if_negative: (R) ? 1 : -1; }
-#endif
-
-/* Verify requirement R at compile-time, as a declaration without a
-   trailing ';'.  If R is false, fail at compile-time, preferably
-   with a diagnostic that includes the string-literal DIAGNOSTIC.
-
-   Unfortunately, unlike C11, this implementation must appear as an
-   ordinary declaration, and cannot appear inside struct { ... }.  */
-
-#ifdef _GL_HAVE__STATIC_ASSERT
-# define _GL_VERIFY _Static_assert
-#else
-# define _GL_VERIFY(R, DIAGNOSTIC)				       \
-    extern int (*_GL_GENSYM (_gl_verify_function) (void))	       \
-      [_GL_VERIFY_TRUE (R, DIAGNOSTIC)]
-#endif
-
-/* _GL_STATIC_ASSERT_H is defined if this code is copied into assert.h.  */
-#ifdef _GL_STATIC_ASSERT_H
-# if !defined _GL_HAVE__STATIC_ASSERT && !defined _Static_assert
-#  define _Static_assert(R, DIAGNOSTIC) _GL_VERIFY (R, DIAGNOSTIC)
-# endif
-# if !defined _GL_HAVE_STATIC_ASSERT && !defined static_assert
-#  define static_assert _Static_assert /* C11 requires this #define.  */
-# endif
-#endif
-
-/* @assert.h omit start@  */
-
-/* Each of these macros verifies that its argument R is nonzero.  To
-   be portable, R should be an integer constant expression.  Unlike
-   assert (R), there is no run-time overhead.
-
-   There are two macros, since no single macro can be used in all
-   contexts in C.  verify_true (R) is for scalar contexts, including
-   integer constant expression contexts.  verify (R) is for declaration
-   contexts, e.g., the top level.  */
-
-/* Verify requirement R at compile-time, as an integer constant expression.
-   Return 1.  This is equivalent to verify_expr (R, 1).
-
-   verify_true is obsolescent; please use verify_expr instead.  */
-
-#define verify_true(R) _GL_VERIFY_TRUE (R, "verify_true (" #R ")")
-
-/* Verify requirement R at compile-time.  Return the value of the
-   expression E.  */
-
-#define verify_expr(R, E) \
-   (_GL_VERIFY_TRUE (R, "verify_expr (" #R ", " #E ")") ? (E) : (E))
-
-/* Verify requirement R at compile-time, as a declaration without a
-   trailing ';'.  */
-
-#define verify(R) _GL_VERIFY (R, "verify (" #R ")")
-
-#ifndef __has_builtin
-# define __has_builtin(x) 0
-#endif
-
-/* Assume that R always holds.  This lets the compiler optimize
-   accordingly.  R should not have side-effects; it may or may not be
-   evaluated.  Behavior is undefined if R is false.  */
-
-#if (__has_builtin (__builtin_unreachable) \
-     || 4 < __GNUC__ + (5 <= __GNUC_MINOR__))
-# define assume(R) ((R) ? (void) 0 : __builtin_unreachable ())
-#elif 1200 <= _MSC_VER
-# define assume(R) __assume (R)
-#elif ((defined GCC_LINT || defined lint) \
-       && (__has_builtin (__builtin_trap) \
-           || 3 < __GNUC__ + (3 < __GNUC_MINOR__ + (4 <= __GNUC_PATCHLEVEL__))))
-  /* Doing it this way helps various packages when configured with
-     --enable-gcc-warnings, which compiles with -Dlint.  It's nicer
-     when 'assume' silences warnings even with older GCCs.  */
-# define assume(R) ((R) ? (void) 0 : __builtin_trap ())
-#else
-# define assume(R) ((void) (0 && (R)))
-#endif
-
-/* @assert.h omit end@  */
-
-#endif
-- 
2.11.0

