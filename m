Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B500207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdEDWBN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36111 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdEDWBL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so6179256wmu.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYMtEv+EKr+Ca3qqVufqnBgeiMLK79M2RQg0mVziUbE=;
        b=MUhHaW/l0bfOCjkNdpDUPUZOLSJHQV2wK8oEIxOwSIjF7FNCrYBDFZH68MQyVAmhi0
         qdQAMaxceXcKGJxy9i2i11mDfq6g0pK4aKxvHEqvhi89r7ezWEg7c2PIA20nH4gu2U63
         6XGoe4hInTIA60R+6BcBRO4/UOJycbDRp4hkc8vLqZITHbw9p6j0ecHIWHBg0vbuVuHL
         fRdgEQ/haj3xCxddyJVDt/LOJ/gw3+1yeCBQ3V1/6YprPa23HkDWijNkVQVg5iLC4vF4
         GM8WzLspnnMgigIwX+TXJp1tKbfqR2aYli1k248tF3UzGNDvIZDU+phB3iQ2dzi1pLdg
         31Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYMtEv+EKr+Ca3qqVufqnBgeiMLK79M2RQg0mVziUbE=;
        b=jSubtxMfdHu2wHu8GO+AWK+bscE+MUcZytZiHstRIxlBUhmep7kWgC62UOLLnlV4jI
         hIiIdGTR0vmOvqWwXNnxid4xnw9ZOwsCqphUKAIT8WL1Wyb6zOD/iROAB6EoQo6lrHS4
         O+HpOCz7QxSgkSmDvsD2Zv2N0eq+mkzRTWYQsmE8Rvfde94ikBx4rCLiZP+GTqI4/TSn
         E9W/rclBIzpBbhx6o1GbQ+FlXXKzFhPaS8WwI0M2+XzYRmJR4Itk6NYgn+9WUuVkAe6m
         mRNsqhbzd9Rh9LCAdZfmGOhVXhkSmxGgAtafcNYc8oX1RK1Bki5DSGT2zuQRcQW6ghxq
         FWvQ==
X-Gm-Message-State: AN3rC/6ML3+CqKFOmiWNC+84PPqVreTq0rTUylUoFC+v3Dw2LFtPWAPi
        xUWMxH/NKxaefw==
X-Received: by 10.28.33.66 with SMTP id h63mr3524885wmh.86.1493935269452;
        Thu, 04 May 2017 15:01:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:08 -0700 (PDT)
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
Subject: [PATCH 2/7] compat/regex: update the gawk regex engine from upstream
Date:   Thu,  4 May 2017 22:00:38 +0000
Message-Id: <20170504220043.25702-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the gawk regex engine from the upstream gawk.git as detailed in
the README added in a previous change.

This is from gawk.git's gawk-4.1.0-2558-gb2651a80 which is the same
code as in the stable gawk-4.1.4 release, but with one trivial change
on top added in commit 725d2f78 ("Add small regex fix. Add support
directory.", 2016-12-22)[1]

The two patches applied on top of the upstream engine are to,
respectively:

 * Add a notice at the top of each file saying that this copy is
   maintained by the Git project.f

 * Remove the dependency on gawk's verify.h. The library compiles
   as-is when this header file is present, but unfortunately it's
   under GPL v3, unlike the rest of the files which is under LGPL 2.1
   or later.

The changes made in commit a997bf423d ("compat/regex: get the gawk
regex engine to compile within git", 2010-08-17) turned out to be
redundant to achieving the same with defining a few flags to make the
code itself do similar things.

In addition the -DNO_MBSUPPORT flag is not needed, upstream removed
the code that relied on that. It's possible that either -DHAVE_BTOWC
or -D_GNU_SOURCE could cause some problems on non-GNU systems.

The -DHAVE_BTOWC flag indicates that wchar.h has a btowc(3). This
function is defined in POSIX.1-2001 & C99 and later.

The -D_GNU_SOURCE flag is needed because the library itself does:

    #ifndef _LIBC
    #define __USE_GNU	1
    #endif

Which is subsequently picked up by GNU C library headers:

    In file included from compat/regex/regex_internal.h:32:0,
                     from compat/regex/regex.c:76:
    /usr/include/stdio.h:316:6: error: unknown type name ‘_IO_cookie_io_functions_t’; did you mean ‘__fortify_function’?
          _IO_cookie_io_functions_t __io_funcs) __THROW __wur;
          ^~~~~~~~~~~~~~~~~~~~~~~~~

1. http://git.savannah.gnu.org/cgit/gawk.git/commit/?id=725d2f78

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                                           |   8 +-
 .../0001-Add-notice-at-top-of-copied-files.patch   | 120 +++++++++++++++++++++
 .../0002-Remove-verify.h-use-from-intprops.h.patch |  41 +++++++
 3 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
 create mode 100644 compat/regex/patches/0002-Remove-verify.h-use-from-intprops.h.patch

diff --git a/Makefile b/Makefile
index e35542e631..6235e1b954 100644
--- a/Makefile
+++ b/Makefile
@@ -2060,7 +2060,13 @@ endif
 
 ifdef NO_REGEX
 compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
-	-DGAWK -DNO_MBSUPPORT
+	-DGAWK \
+	-DHAVE_WCHAR_H \
+	-DHAVE_WCTYPE_H \
+	-DHAVE_STDDEF_H \
+	-DHAVE_STDBOOL_H \
+	-DHAVE_BTOWC \
+	-D_GNU_SOURCE
 endif
 
 ifdef USE_NED_ALLOCATOR
diff --git a/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch b/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
new file mode 100644
index 0000000000..4b4acc45ba
--- /dev/null
+++ b/compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
@@ -0,0 +1,120 @@
+diff --git a/compat/regex/intprops.h b/compat/regex/intprops.h
+index 716741adc5..2aef98d290 100644
+--- a/compat/regex/intprops.h
++++ b/compat/regex/intprops.h
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* intprops.h -- properties of integer types
+ 
+    Copyright (C) 2001-2016 Free Software Foundation, Inc.
+diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
+index 5ac5370142..a1fb2e400e 100644
+--- a/compat/regex/regcomp.c
++++ b/compat/regex/regcomp.c
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Extended regular expression matching and search library.
+    Copyright (C) 2002-2016 Free Software Foundation, Inc.
+    This file is part of the GNU C Library.
+diff --git a/compat/regex/regex.c b/compat/regex/regex.c
+index 9f133fab84..d6e525e567 100644
+--- a/compat/regex/regex.c
++++ b/compat/regex/regex.c
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Extended regular expression matching and search library.
+    Copyright (C) 2002-2016 Free Software Foundation, Inc.
+    This file is part of the GNU C Library.
+diff --git a/compat/regex/regex.h b/compat/regex/regex.h
+index 143b3afa89..b602b5567f 100644
+--- a/compat/regex/regex.h
++++ b/compat/regex/regex.h
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Definitions for data structures and routines for the regular
+    expression library.
+    Copyright (C) 1985, 1989-2016 Free Software Foundation, Inc.
+diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
+index 18641ef1c0..6d766114a1 100644
+--- a/compat/regex/regex_internal.c
++++ b/compat/regex/regex_internal.c
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Extended regular expression matching and search library.
+    Copyright (C) 2002-2016 Free Software Foundation, Inc.
+    This file is part of the GNU C Library.
+diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
+index 01465e7678..9c88a6a57b 100644
+--- a/compat/regex/regex_internal.h
++++ b/compat/regex/regex_internal.h
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Extended regular expression matching and search library.
+    Copyright (C) 2002-2016 Free Software Foundation, Inc.
+    This file is part of the GNU C Library.
+diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
+index c8f11e52e7..c79ff38b1c 100644
+--- a/compat/regex/regexec.c
++++ b/compat/regex/regexec.c
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Extended regular expression matching and search library.
+    Copyright (C) 2002-2016 Free Software Foundation, Inc.
+    This file is part of the GNU C Library.
+diff --git a/compat/regex/verify.h b/compat/regex/verify.h
+index 5c8381d290..e865af5298 100644
+--- a/compat/regex/verify.h
++++ b/compat/regex/verify.h
+@@ -1,3 +1,10 @@
++/*
++ * This is git.git's copy of gawk.git's regex engine. Please see that
++ * project for the latest version & to submit patches to this code,
++ * and git.git's compat/regex/README for information on how git's copy
++ * of this code is maintained.
++ */
++
+ /* Compile-time assert-like macros.
+ 
+    Copyright (C) 2005-2006, 2009-2016 Free Software Foundation, Inc.
diff --git a/compat/regex/patches/0002-Remove-verify.h-use-from-intprops.h.patch b/compat/regex/patches/0002-Remove-verify.h-use-from-intprops.h.patch
new file mode 100644
index 0000000000..16c3fd30dd
--- /dev/null
+++ b/compat/regex/patches/0002-Remove-verify.h-use-from-intprops.h.patch
@@ -0,0 +1,41 @@
+diff --git a/compat/regex/intprops.h b/compat/regex/intprops.h
+index 2aef98d290..29f7f40837 100644
+--- a/compat/regex/intprops.h
++++ b/compat/regex/intprops.h
+@@ -28,7 +28,6 @@
+ #define _GL_INTPROPS_H
+ 
+ #include <limits.h>
+-#include <verify.h>
+ 
+ #ifndef __has_builtin
+ # define __has_builtin(x) 0
+@@ -88,28 +87,6 @@
+ # define LLONG_MIN __INT64_MIN
+ #endif
+ 
+-/* This include file assumes that signed types are two's complement without
+-   padding bits; the above macros have undefined behavior otherwise.
+-   If this is a problem for you, please let us know how to fix it for your host.
+-   As a sanity check, test the assumption for some signed types that
+-   <limits.h> bounds.  */
+-verify (TYPE_MINIMUM (signed char) == SCHAR_MIN);
+-verify (TYPE_MAXIMUM (signed char) == SCHAR_MAX);
+-verify (TYPE_MINIMUM (short int) == SHRT_MIN);
+-verify (TYPE_MAXIMUM (short int) == SHRT_MAX);
+-verify (TYPE_MINIMUM (int) == INT_MIN);
+-verify (TYPE_MAXIMUM (int) == INT_MAX);
+-verify (TYPE_MINIMUM (long int) == LONG_MIN);
+-verify (TYPE_MAXIMUM (long int) == LONG_MAX);
+-#ifdef LLONG_MAX
+-verify (TYPE_MINIMUM (long long int) == LLONG_MIN);
+-verify (TYPE_MAXIMUM (long long int) == LLONG_MAX);
+-#endif
+-/* Similarly, sanity-check one ISO/IEC TS 18661-1:2014 macro if defined.  */
+-#ifdef UINT_WIDTH
+-verify (TYPE_WIDTH (unsigned int) == UINT_WIDTH);
+-#endif
+-
+ /* Does the __typeof__ keyword work?  This could be done by
+    'configure', but for now it's easier to do it by hand.  */
+ #if (2 <= __GNUC__ \
-- 
2.11.0

