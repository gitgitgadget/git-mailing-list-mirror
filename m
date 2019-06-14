Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79F81F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFNKBN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:01:13 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55326 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfFNKBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:11 -0400
Received: by mail-wm1-f46.google.com with SMTP id a15so1681459wmj.5
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOHrahVLNSnZ/v0IeGHp2iOEjUvcezpy5iCyli1GDFg=;
        b=WSlGaCfYJBfknnKPh/xkBnPqd7iaaNAe/s9LOJCRWoT2qT/+rprOzXIlPIhKu2Oijl
         IdNc1zzCIxR4NpJLxQW0Ygd+nu9ns4RCl+36M8WqJXkesvo+H+2PktmZdyGNWeIEXw+2
         HGPKd9AUiLz1rER65LgFNshy29ZY1AkkEfLhAgfAg0LrvG7udlu83E8HyO7E2pCUcH6J
         vCE6GZSubKq8BcPaavDg6klR61M/oVoLpEBgmgAJh/MDJC+FNsCkF7XuRQRv743UgUls
         9YZ2hlaV1e9nfP6YPBHAQQRA0OkZm4laoUWVKw0Z1Fk01U0JRQMeIhLxH/gT2HLfOH7Z
         ciqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOHrahVLNSnZ/v0IeGHp2iOEjUvcezpy5iCyli1GDFg=;
        b=TW3+DRnfBkI6HrFpzz4RazTkbHjCAgMCKb4ioMAmTSMf8zJ4HeUBwajriGTAqAo9UW
         s67oOsp7IknoaIb01dQ3mzaLlxvLgYXuugJhuqzl/kXLcOliM8gtIxhXZaeko8x7W3uF
         qLsW3L9ccL+hhXB+G/ldnnAC7tf47xZbiwlLPqiKWOuYrvXMWS6ekn5azZZTlhI00y1u
         iLzMx091ZhdTgsh2v0Jd8SYSEomNsX2lIrHfbKVdw8VZ62po5hf4WQhENUTHGBUoBsv7
         ZXqm8d0tFBKr2KJV4P5pFM4lYcqnIDmUqJ7UAfMs/91y0fltVUIiw27Rl+89uj9Z4BJx
         4PzA==
X-Gm-Message-State: APjAAAUt5CjLD7Vd9ShTtYzWzY749XlrtDiNxWol7JhoHGViOyN+iufY
        O/P4vf3nbT5qHjOCnei4SOnz1xlg
X-Google-Smtp-Source: APXvYqyIwTdXpbmdfbr5xUlI0jC645Od52QnM89VWG+N+3rF+i5fVvQl5vOpKFYjvp8MaMd/FCo0Ug==
X-Received: by 2002:a1c:9813:: with SMTP id a19mr7030447wme.11.1560506464855;
        Fri, 14 Jun 2019 03:01:04 -0700 (PDT)
Received: from localhost.localdomain (x4db35d93.dyn.telefonica.de. [77.179.93.147])
        by smtp.gmail.com with ESMTPSA id d3sm1986988wrs.8.2019.06.14.03.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 03:01:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1 1/4] compat/obstack: update from upstream
Date:   Fri, 14 Jun 2019 12:00:56 +0200
Message-Id: <20190614100059.13540-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

!! This does not compile !!

Update 'compat/obstack.{c,h}' from commit
5905d8ca9945f0d60ff40eb6cfa42afc0199ab8f in
https://git.savannah.gnu.org/git/gnulib.git

We have made a couple of changes to our copy of 'compat/obstack.{c,h}'
since it was introduced in e831171d67 (Add obstack.[ch] from EGLIBC
2.10, 2011-08-21), and in the meantime some of those issues have been
addressed in upstream as well [1].  Furthermore, upstream fixed one
big issue that we still suffer from, namely our copy still uses type
'long' to specify the size of the chunk of memory to allocate while
xmalloc() expects type 'size_t', which triggers compiler errors with
GCC 8 on Windows, where these two data types are of different size;
upstream has been using 'size_t' for quite some time now.  Making the
conversion from 'long' to 'size_t' in our copy just doesn't worth it,
hence the update from upstream.

[1] In particular the following changes have been adressed in
    upstream:
    764473d257 (compat/obstack: fix -Wcast-function-type warnings,
    2019-01-17)
    484257925f (Replace Free Software Foundation address in license
    notices, 2017-11-07)
    7323513d28 (obstack: fix spelling of similar, 2013-04-12)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 compat/obstack.c | 399 ++++++++++------------
 compat/obstack.h | 835 +++++++++++++++++++++++++----------------------
 2 files changed, 606 insertions(+), 628 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 27cd5c1ea1..6949111e4d 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -1,6 +1,5 @@
 /* obstack.c - subroutines used implicitly by object stack macros
-   Copyright (C) 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1996, 1997, 1998,
-   1999, 2000, 2001, 2002, 2003, 2004, 2005 Free Software Foundation, Inc.
+   Copyright (C) 1988-2019 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -15,16 +14,19 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
-#include "git-compat-util.h"
-#include <gettext.h>
-#include "obstack.h"
 
-/* NOTE BEFORE MODIFYING THIS FILE: This version number must be
-   incremented whenever callers compiled using an old obstack.h can no
-   longer properly call the functions in this obstack.c.  */
-#define OBSTACK_INTERFACE_VERSION 1
+#ifdef _LIBC
+# include <obstack.h>
+#else
+# include <config.h>
+# include "obstack.h"
+#endif
+
+/* NOTE BEFORE MODIFYING THIS FILE: _OBSTACK_INTERFACE_VERSION in
+   obstack.h must be incremented whenever callers compiled using an old
+   obstack.h can no longer properly call the functions in this file.  */
 
 /* Comment out all this code if we are using the GNU C Library, and are not
    actually compiling the library itself, and the installed library
@@ -32,113 +34,82 @@
    C Library, but also included in many other GNU distributions.  Compiling
    and linking in this code is a waste when using the GNU C library
    (especially if it is a shared library).  Rather than having every GNU
-   program understand `configure --with-gnu-libc' and omit the object
+   program understand 'configure --with-gnu-libc' and omit the object
    files, it is simpler to just do this in the source for each such file.  */
-
-#include <stdio.h>		/* Random thing to get __GNU_LIBRARY__.  */
 #if !defined _LIBC && defined __GNU_LIBRARY__ && __GNU_LIBRARY__ > 1
 # include <gnu-versions.h>
-# if _GNU_OBSTACK_INTERFACE_VERSION == OBSTACK_INTERFACE_VERSION
-#  define ELIDE_CODE
+# if (_GNU_OBSTACK_INTERFACE_VERSION == _OBSTACK_INTERFACE_VERSION	      \
+      || (_GNU_OBSTACK_INTERFACE_VERSION == 1				      \
+          && _OBSTACK_INTERFACE_VERSION == 2				      \
+          && defined SIZEOF_INT && defined SIZEOF_SIZE_T		      \
+          && SIZEOF_INT == SIZEOF_SIZE_T))
+#  define _OBSTACK_ELIDE_CODE
 # endif
 #endif
 
-#include <stddef.h>
-
-#ifndef ELIDE_CODE
-
-
-# if HAVE_INTTYPES_H
-#  include <inttypes.h>
+#ifndef _OBSTACK_ELIDE_CODE
+/* If GCC, or if an oddball (testing?) host that #defines __alignof__,
+   use the already-supplied __alignof__.  Otherwise, this must be Gnulib
+   (as glibc assumes GCC); defer to Gnulib's alignof_type.  */
+# if !defined __GNUC__ && !defined __alignof__
+#  include <alignof.h>
+#  define __alignof__(type) alignof_type (type)
 # endif
-# if HAVE_STDINT_H || defined _LIBC
-#  include <stdint.h>
+# include <stdlib.h>
+# include <stdint.h>
+
+# ifndef MAX
+#  define MAX(a,b) ((a) > (b) ? (a) : (b))
 # endif
 
 /* Determine default alignment.  */
-union fooround
-{
-  uintmax_t i;
-  long double d;
-  void *p;
-};
-struct fooalign
-{
-  char c;
-  union fooround u;
-};
+
 /* If malloc were really smart, it would round addresses to DEFAULT_ALIGNMENT.
    But in fact it might be less smart and round addresses to as much as
-   DEFAULT_ROUNDING.  So we prepare for it to do that.  */
-enum
-  {
-    DEFAULT_ALIGNMENT = offsetof (struct fooalign, u),
-    DEFAULT_ROUNDING = sizeof (union fooround)
-  };
-
-/* When we copy a long block of data, this is the unit to do it with.
-   On some machines, copying successive ints does not work;
-   in such a case, redefine COPYING_UNIT to `long' (if that works)
-   or `char' as a last resort.  */
-# ifndef COPYING_UNIT
-#  define COPYING_UNIT int
-# endif
+   DEFAULT_ROUNDING.  So we prepare for it to do that.
+
+   DEFAULT_ALIGNMENT cannot be an enum constant; see gnulib's alignof.h.  */
+#define DEFAULT_ALIGNMENT MAX (__alignof__ (long double),		      \
+                               MAX (__alignof__ (uintmax_t),		      \
+                                    __alignof__ (void *)))
+#define DEFAULT_ROUNDING MAX (sizeof (long double),			      \
+                               MAX (sizeof (uintmax_t),			      \
+                                    sizeof (void *)))
+
+/* Call functions with either the traditional malloc/free calling
+   interface, or the mmalloc/mfree interface (that adds an extra first
+   argument), based on the value of use_extra_arg.  */
+
+static void *
+call_chunkfun (struct obstack *h, size_t size)
+{
+  if (h->use_extra_arg)
+    return h->chunkfun.extra (h->extra_arg, size);
+  else
+    return h->chunkfun.plain (size);
+}
 
+static void
+call_freefun (struct obstack *h, void *old_chunk)
+{
+  if (h->use_extra_arg)
+    h->freefun.extra (h->extra_arg, old_chunk);
+  else
+    h->freefun.plain (old_chunk);
+}
 
-/* The functions allocating more room by calling `obstack_chunk_alloc'
-   jump to the handler pointed to by `obstack_alloc_failed_handler'.
-   This can be set to a user defined function which should either
-   abort gracefully or use longjump - but shouldn't return.  This
-   variable by default points to the internal function
-   `print_and_abort'.  */
-static void print_and_abort (void);
-void (*obstack_alloc_failed_handler) (void) = print_and_abort;
-
-# ifdef _LIBC
-#  if SHLIB_COMPAT (libc, GLIBC_2_0, GLIBC_2_3_4)
-/* A looong time ago (before 1994, anyway; we're not sure) this global variable
-   was used by non-GNU-C macros to avoid multiple evaluation.  The GNU C
-   library still exports it because somebody might use it.  */
-struct obstack *_obstack_compat;
-compat_symbol (libc, _obstack_compat, _obstack, GLIBC_2_0);
-#  endif
-# endif
 
-/* Define a macro that either calls functions with the traditional malloc/free
-   calling interface, or calls functions with the mmalloc/mfree interface
-   (that adds an extra first argument), based on the state of use_extra_arg.
-   For free, do not use ?:, since some compilers, like the MIPS compilers,
-   do not allow (expr) ? void : void.  */
-
-# define CALL_CHUNKFUN(h, size) \
-  (((h) -> use_extra_arg) \
-   ? (*(h)->chunkfun.extra) ((h)->extra_arg, (size)) \
-   : (*(h)->chunkfun.plain) ((size)))
-
-# define CALL_FREEFUN(h, old_chunk) \
-  do { \
-    if ((h) -> use_extra_arg) \
-      (*(h)->freefun.extra) ((h)->extra_arg, (old_chunk)); \
-    else \
-      (*(h)->freefun.plain) ((old_chunk)); \
-  } while (0)
-
-
 /* Initialize an obstack H for use.  Specify chunk size SIZE (0 means default).
    Objects start on multiples of ALIGNMENT (0 means use default).
-   CHUNKFUN is the function to use to allocate chunks,
-   and FREEFUN the function to free them.
 
    Return nonzero if successful, calls obstack_alloc_failed_handler if
    allocation fails.  */
 
-int
-_obstack_begin (struct obstack *h,
-		int size, int alignment,
-		void *(*chunkfun) (long),
-		void (*freefun) (void *))
+static int
+_obstack_begin_worker (struct obstack *h,
+                       _OBSTACK_SIZE_T size, _OBSTACK_SIZE_T alignment)
 {
-  register struct _obstack_chunk *chunk; /* points to new chunk */
+  struct _obstack_chunk *chunk; /* points to new chunk */
 
   if (alignment == 0)
     alignment = DEFAULT_ALIGNMENT;
@@ -146,33 +117,29 @@ _obstack_begin (struct obstack *h,
     /* Default size is what GNU malloc can fit in a 4096-byte block.  */
     {
       /* 12 is sizeof (mhead) and 4 is EXTRA from GNU malloc.
-	 Use the values for range checking, because if range checking is off,
-	 the extra bytes won't be missed terribly, but if range checking is on
-	 and we used a larger request, a whole extra 4096 bytes would be
-	 allocated.
+         Use the values for range checking, because if range checking is off,
+         the extra bytes won't be missed terribly, but if range checking is on
+         and we used a larger request, a whole extra 4096 bytes would be
+         allocated.
 
-	 These number are irrelevant to the new GNU malloc.  I suspect it is
-	 less sensitive to the size of the request.  */
+         These number are irrelevant to the new GNU malloc.  I suspect it is
+         less sensitive to the size of the request.  */
       int extra = ((((12 + DEFAULT_ROUNDING - 1) & ~(DEFAULT_ROUNDING - 1))
-		    + 4 + DEFAULT_ROUNDING - 1)
-		   & ~(DEFAULT_ROUNDING - 1));
+                    + 4 + DEFAULT_ROUNDING - 1)
+                   & ~(DEFAULT_ROUNDING - 1));
       size = 4096 - extra;
     }
 
-  h->chunkfun.plain = chunkfun;
-  h->freefun.plain = freefun;
   h->chunk_size = size;
   h->alignment_mask = alignment - 1;
-  h->use_extra_arg = 0;
 
-  chunk = h->chunk = CALL_CHUNKFUN (h, h -> chunk_size);
+  chunk = h->chunk = call_chunkfun (h, h->chunk_size);
   if (!chunk)
     (*obstack_alloc_failed_handler) ();
   h->next_free = h->object_base = __PTR_ALIGN ((char *) chunk, chunk->contents,
-					       alignment - 1);
-  h->chunk_limit = chunk->limit
-    = (char *) chunk + h->chunk_size;
-  chunk->prev = NULL;
+                                               alignment - 1);
+  h->chunk_limit = chunk->limit = (char *) chunk + h->chunk_size;
+  chunk->prev = 0;
   /* The initial chunk now contains no empty object.  */
   h->maybe_empty_object = 0;
   h->alloc_failed = 0;
@@ -180,52 +147,29 @@ _obstack_begin (struct obstack *h,
 }
 
 int
-_obstack_begin_1 (struct obstack *h, int size, int alignment,
-		  void *(*chunkfun) (void *, long),
-		  void (*freefun) (void *, void *),
-		  void *arg)
+_obstack_begin (struct obstack *h,
+                _OBSTACK_SIZE_T size, _OBSTACK_SIZE_T alignment,
+                void *(*chunkfun) (size_t),
+                void (*freefun) (void *))
 {
-  register struct _obstack_chunk *chunk; /* points to new chunk */
-
-  if (alignment == 0)
-    alignment = DEFAULT_ALIGNMENT;
-  if (size == 0)
-    /* Default size is what GNU malloc can fit in a 4096-byte block.  */
-    {
-      /* 12 is sizeof (mhead) and 4 is EXTRA from GNU malloc.
-	 Use the values for range checking, because if range checking is off,
-	 the extra bytes won't be missed terribly, but if range checking is on
-	 and we used a larger request, a whole extra 4096 bytes would be
-	 allocated.
-
-	 These number are irrelevant to the new GNU malloc.  I suspect it is
-	 less sensitive to the size of the request.  */
-      int extra = ((((12 + DEFAULT_ROUNDING - 1) & ~(DEFAULT_ROUNDING - 1))
-		    + 4 + DEFAULT_ROUNDING - 1)
-		   & ~(DEFAULT_ROUNDING - 1));
-      size = 4096 - extra;
-    }
-
-  h->chunkfun.extra = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
-  h->freefun.extra = (void (*) (void *, struct _obstack_chunk *)) freefun;
+  h->chunkfun.plain = chunkfun;
+  h->freefun.plain = freefun;
+  h->use_extra_arg = 0;
+  return _obstack_begin_worker (h, size, alignment);
+}
 
-  h->chunk_size = size;
-  h->alignment_mask = alignment - 1;
+int
+_obstack_begin_1 (struct obstack *h,
+                  _OBSTACK_SIZE_T size, _OBSTACK_SIZE_T alignment,
+                  void *(*chunkfun) (void *, size_t),
+                  void (*freefun) (void *, void *),
+                  void *arg)
+{
+  h->chunkfun.extra = chunkfun;
+  h->freefun.extra = freefun;
   h->extra_arg = arg;
   h->use_extra_arg = 1;
-
-  chunk = h->chunk = CALL_CHUNKFUN (h, h -> chunk_size);
-  if (!chunk)
-    (*obstack_alloc_failed_handler) ();
-  h->next_free = h->object_base = __PTR_ALIGN ((char *) chunk, chunk->contents,
-					       alignment - 1);
-  h->chunk_limit = chunk->limit
-    = (char *) chunk + h->chunk_size;
-  chunk->prev = NULL;
-  /* The initial chunk now contains no empty object.  */
-  h->maybe_empty_object = 0;
-  h->alloc_failed = 0;
-  return 1;
+  return _obstack_begin_worker (h, size, alignment);
 }
 
 /* Allocate a new current chunk for the obstack *H
@@ -235,25 +179,27 @@ _obstack_begin_1 (struct obstack *h, int size, int alignment,
    to the beginning of the new one.  */
 
 void
-_obstack_newchunk (struct obstack *h, int length)
+_obstack_newchunk (struct obstack *h, _OBSTACK_SIZE_T length)
 {
-  register struct _obstack_chunk *old_chunk = h->chunk;
-  register struct _obstack_chunk *new_chunk;
-  register long	new_size;
-  register long obj_size = h->next_free - h->object_base;
-  register long i;
-  long already;
+  struct _obstack_chunk *old_chunk = h->chunk;
+  struct _obstack_chunk *new_chunk = 0;
+  size_t obj_size = h->next_free - h->object_base;
   char *object_base;
 
   /* Compute size for new chunk.  */
-  new_size = (obj_size + length) + (obj_size >> 3) + h->alignment_mask + 100;
+  size_t sum1 = obj_size + length;
+  size_t sum2 = sum1 + h->alignment_mask;
+  size_t new_size = sum2 + (obj_size >> 3) + 100;
+  if (new_size < sum2)
+    new_size = sum2;
   if (new_size < h->chunk_size)
     new_size = h->chunk_size;
 
   /* Allocate and initialize the new chunk.  */
-  new_chunk = CALL_CHUNKFUN (h, new_size);
+  if (obj_size <= sum1 && sum1 <= sum2)
+    new_chunk = call_chunkfun (h, new_size);
   if (!new_chunk)
-    (*obstack_alloc_failed_handler) ();
+    (*obstack_alloc_failed_handler)();
   h->chunk = new_chunk;
   new_chunk->prev = old_chunk;
   new_chunk->limit = h->chunk_limit = (char *) new_chunk + new_size;
@@ -262,36 +208,19 @@ _obstack_newchunk (struct obstack *h, int length)
   object_base =
     __PTR_ALIGN ((char *) new_chunk, new_chunk->contents, h->alignment_mask);
 
-  /* Move the existing object to the new chunk.
-     Word at a time is fast and is safe if the object
-     is sufficiently aligned.  */
-  if (h->alignment_mask + 1 >= DEFAULT_ALIGNMENT)
-    {
-      for (i = obj_size / sizeof (COPYING_UNIT) - 1;
-	   i >= 0; i--)
-	((COPYING_UNIT *)object_base)[i]
-	  = ((COPYING_UNIT *)h->object_base)[i];
-      /* We used to copy the odd few remaining bytes as one extra COPYING_UNIT,
-	 but that can cross a page boundary on a machine
-	 which does not do strict alignment for COPYING_UNITS.  */
-      already = obj_size / sizeof (COPYING_UNIT) * sizeof (COPYING_UNIT);
-    }
-  else
-    already = 0;
-  /* Copy remaining bytes one by one.  */
-  for (i = already; i < obj_size; i++)
-    object_base[i] = h->object_base[i];
+  /* Move the existing object to the new chunk.  */
+  memcpy (object_base, h->object_base, obj_size);
 
   /* If the object just copied was the only data in OLD_CHUNK,
      free that chunk and remove it from the chain.
      But not if that chunk might contain an empty object.  */
-  if (! h->maybe_empty_object
+  if (!h->maybe_empty_object
       && (h->object_base
-	  == __PTR_ALIGN ((char *) old_chunk, old_chunk->contents,
-			  h->alignment_mask)))
+          == __PTR_ALIGN ((char *) old_chunk, old_chunk->contents,
+                          h->alignment_mask)))
     {
       new_chunk->prev = old_chunk->prev;
-      CALL_FREEFUN (h, old_chunk);
+      call_freefun (h, old_chunk);
     }
 
   h->object_base = object_base;
@@ -299,9 +228,6 @@ _obstack_newchunk (struct obstack *h, int length)
   /* The new chunk certainly contains no empty object yet.  */
   h->maybe_empty_object = 0;
 }
-# ifdef _LIBC
-libc_hidden_def (_obstack_newchunk)
-# endif
 
 /* Return nonzero if object OBJ has been allocated from obstack H.
    This is here for debugging.
@@ -309,48 +235,46 @@ libc_hidden_def (_obstack_newchunk)
 
 /* Suppress -Wmissing-prototypes warning.  We don't want to declare this in
    obstack.h because it is just for debugging.  */
-int _obstack_allocated_p (struct obstack *h, void *obj);
+int _obstack_allocated_p (struct obstack *h, void *obj) __attribute_pure__;
 
 int
 _obstack_allocated_p (struct obstack *h, void *obj)
 {
-  register struct _obstack_chunk *lp;	/* below addr of any objects in this chunk */
-  register struct _obstack_chunk *plp;	/* point to previous chunk if any */
+  struct _obstack_chunk *lp;    /* below addr of any objects in this chunk */
+  struct _obstack_chunk *plp;   /* point to previous chunk if any */
 
   lp = (h)->chunk;
   /* We use >= rather than > since the object cannot be exactly at
      the beginning of the chunk but might be an empty object exactly
      at the end of an adjacent chunk.  */
-  while (lp != NULL && ((void *) lp >= obj || (void *) (lp)->limit < obj))
+  while (lp != 0 && ((void *) lp >= obj || (void *) (lp)->limit < obj))
     {
       plp = lp->prev;
       lp = plp;
     }
-  return lp != NULL;
+  return lp != 0;
 }
-
+
 /* Free objects in obstack H, including OBJ and everything allocate
    more recently than OBJ.  If OBJ is zero, free everything in H.  */
 
-# undef obstack_free
-
 void
-obstack_free (struct obstack *h, void *obj)
+_obstack_free (struct obstack *h, void *obj)
 {
-  register struct _obstack_chunk *lp;	/* below addr of any objects in this chunk */
-  register struct _obstack_chunk *plp;	/* point to previous chunk if any */
+  struct _obstack_chunk *lp;    /* below addr of any objects in this chunk */
+  struct _obstack_chunk *plp;   /* point to previous chunk if any */
 
   lp = h->chunk;
   /* We use >= because there cannot be an object at the beginning of a chunk.
      But there can be an empty object at that address
      at the end of another chunk.  */
-  while (lp != NULL && ((void *) lp >= obj || (void *) (lp)->limit < obj))
+  while (lp != 0 && ((void *) lp >= obj || (void *) (lp)->limit < obj))
     {
       plp = lp->prev;
-      CALL_FREEFUN (h, lp);
+      call_freefun (h, lp);
       lp = plp;
       /* If we switch chunks, we can't tell whether the new current
-	 chunk contains an empty object, so assume that it may.  */
+         chunk contains an empty object, so assume that it may.  */
       h->maybe_empty_object = 1;
     }
   if (lp)
@@ -359,42 +283,50 @@ obstack_free (struct obstack *h, void *obj)
       h->chunk_limit = lp->limit;
       h->chunk = lp;
     }
-  else if (obj != NULL)
+  else if (obj != 0)
     /* obj is not in any of the chunks! */
     abort ();
 }
 
-# ifdef _LIBC
-/* Older versions of libc used a function _obstack_free intended to be
-   called by non-GCC compilers.  */
-strong_alias (obstack_free, _obstack_free)
-# endif
-
-int
+_OBSTACK_SIZE_T
 _obstack_memory_used (struct obstack *h)
 {
-  register struct _obstack_chunk* lp;
-  register int nbytes = 0;
+  struct _obstack_chunk *lp;
+  _OBSTACK_SIZE_T nbytes = 0;
 
-  for (lp = h->chunk; lp != NULL; lp = lp->prev)
+  for (lp = h->chunk; lp != 0; lp = lp->prev)
     {
       nbytes += lp->limit - (char *) lp;
     }
   return nbytes;
 }
-
-# ifdef _LIBC
-#  include <libio/iolibio.h>
-# endif
 
-# ifndef __attribute__
-/* This feature is available in gcc versions 2.5 and later.  */
-#  if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 5)
-#   define __attribute__(Spec) /* empty */
+# ifndef _OBSTACK_NO_ERROR_HANDLER
+/* Define the error handler.  */
+#  include <stdio.h>
+
+/* Exit value used when 'print_and_abort' is used.  */
+#  ifdef _LIBC
+int obstack_exit_failure = EXIT_FAILURE;
+#  else
+#   include "exitfail.h"
+#   define obstack_exit_failure exit_failure
 #  endif
-# endif
 
-static void
+#  ifdef _LIBC
+#   include <libintl.h>
+#  else
+#   include "gettext.h"
+#  endif
+#  ifndef _
+#   define _(msgid) gettext (msgid)
+#  endif
+
+#  ifdef _LIBC
+#   include <libio/iolibio.h>
+#  endif
+
+static _Noreturn void
 print_and_abort (void)
 {
   /* Don't change any of these strings.  Yes, it would be possible to add
@@ -402,12 +334,21 @@ print_and_abort (void)
      happen because the "memory exhausted" message appears in other places
      like this and the translation should be reused instead of creating
      a very similar string which requires a separate translation.  */
-# ifdef _LIBC
+#  ifdef _LIBC
   (void) __fxprintf (NULL, "%s\n", _("memory exhausted"));
-# else
+#  else
   fprintf (stderr, "%s\n", _("memory exhausted"));
-# endif
-  exit (1);
+#  endif
+  exit (obstack_exit_failure);
 }
 
-#endif	/* !ELIDE_CODE */
+/* The functions allocating more room by calling 'obstack_chunk_alloc'
+   jump to the handler pointed to by 'obstack_alloc_failed_handler'.
+   This can be set to a user defined function which should either
+   abort gracefully or use longjump - but shouldn't return.  This
+   variable by default points to the internal function
+   'print_and_abort'.  */
+__attribute_noreturn__ void (*obstack_alloc_failed_handler) (void)
+  = print_and_abort;
+# endif /* !_OBSTACK_NO_ERROR_HANDLER */
+#endif /* !_OBSTACK_ELIDE_CODE */
diff --git a/compat/obstack.h b/compat/obstack.h
index ced94d0118..811de588a4 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -1,6 +1,5 @@
 /* obstack.h - object stack macros
-   Copyright (C) 1988-1994,1996-1999,2003,2004,2005,2009
-	Free Software Foundation, Inc.
+   Copyright (C) 1988-2019 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -15,89 +14,89 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 /* Summary:
 
-All the apparent functions defined here are macros. The idea
-is that you would use these pre-tested macros to solve a
-very specific set of problems, and they would run fast.
-Caution: no side-effects in arguments please!! They may be
-evaluated MANY times!!
-
-These macros operate a stack of objects.  Each object starts life
-small, and may grow to maturity.  (Consider building a word syllable
-by syllable.)  An object can move while it is growing.  Once it has
-been "finished" it never changes address again.  So the "top of the
-stack" is typically an immature growing object, while the rest of the
-stack is of mature, fixed size and fixed address objects.
-
-These routines grab large chunks of memory, using a function you
-supply, called `obstack_chunk_alloc'.  On occasion, they free chunks,
-by calling `obstack_chunk_free'.  You must define them and declare
-them before using any obstack macros.
-
-Each independent stack is represented by a `struct obstack'.
-Each of the obstack macros expects a pointer to such a structure
-as the first argument.
-
-One motivation for this package is the problem of growing char strings
-in symbol tables.  Unless you are "fascist pig with a read-only mind"
---Gosper's immortal quote from HAKMEM item 154, out of context--you
-would not like to put any arbitrary upper limit on the length of your
-symbols.
-
-In practice this often means you will build many short symbols and a
-few long symbols.  At the time you are reading a symbol you don't know
-how long it is.  One traditional method is to read a symbol into a
-buffer, realloc()ating the buffer every time you try to read a symbol
-that is longer than the buffer.  This is beaut, but you still will
-want to copy the symbol from the buffer to a more permanent
-symbol-table entry say about half the time.
-
-With obstacks, you can work differently.  Use one obstack for all symbol
-names.  As you read a symbol, grow the name in the obstack gradually.
-When the name is complete, finalize it.  Then, if the symbol exists already,
-free the newly read name.
-
-The way we do this is to take a large chunk, allocating memory from
-low addresses.  When you want to build a symbol in the chunk you just
-add chars above the current "high water mark" in the chunk.  When you
-have finished adding chars, because you got to the end of the symbol,
-you know how long the chars are, and you can create a new object.
-Mostly the chars will not burst over the highest address of the chunk,
-because you would typically expect a chunk to be (say) 100 times as
-long as an average object.
-
-In case that isn't clear, when we have enough chars to make up
-the object, THEY ARE ALREADY CONTIGUOUS IN THE CHUNK (guaranteed)
-so we just point to it where it lies.  No moving of chars is
-needed and this is the second win: potentially long strings need
-never be explicitly shuffled. Once an object is formed, it does not
-change its address during its lifetime.
-
-When the chars burst over a chunk boundary, we allocate a larger
-chunk, and then copy the partly formed object from the end of the old
-chunk to the beginning of the new larger chunk.  We then carry on
-accreting characters to the end of the object as we normally would.
-
-A special macro is provided to add a single char at a time to a
-growing object.  This allows the use of register variables, which
-break the ordinary 'growth' macro.
-
-Summary:
-	We allocate large chunks.
-	We carve out one object at a time from the current chunk.
-	Once carved, an object never moves.
-	We are free to append data of any size to the currently
-	  growing object.
-	Exactly one object is growing in an obstack at any one time.
-	You can run one obstack per control block.
-	You may have as many control blocks as you dare.
-	Because of the way we do it, you can `unwind' an obstack
-	  back to a previous state. (You may remove objects much
-	  as you would with a stack.)
-*/
+   All the apparent functions defined here are macros. The idea
+   is that you would use these pre-tested macros to solve a
+   very specific set of problems, and they would run fast.
+   Caution: no side-effects in arguments please!! They may be
+   evaluated MANY times!!
+
+   These macros operate a stack of objects.  Each object starts life
+   small, and may grow to maturity.  (Consider building a word syllable
+   by syllable.)  An object can move while it is growing.  Once it has
+   been "finished" it never changes address again.  So the "top of the
+   stack" is typically an immature growing object, while the rest of the
+   stack is of mature, fixed size and fixed address objects.
+
+   These routines grab large chunks of memory, using a function you
+   supply, called 'obstack_chunk_alloc'.  On occasion, they free chunks,
+   by calling 'obstack_chunk_free'.  You must define them and declare
+   them before using any obstack macros.
+
+   Each independent stack is represented by a 'struct obstack'.
+   Each of the obstack macros expects a pointer to such a structure
+   as the first argument.
+
+   One motivation for this package is the problem of growing char strings
+   in symbol tables.  Unless you are "fascist pig with a read-only mind"
+   --Gosper's immortal quote from HAKMEM item 154, out of context--you
+   would not like to put any arbitrary upper limit on the length of your
+   symbols.
+
+   In practice this often means you will build many short symbols and a
+   few long symbols.  At the time you are reading a symbol you don't know
+   how long it is.  One traditional method is to read a symbol into a
+   buffer, realloc()ating the buffer every time you try to read a symbol
+   that is longer than the buffer.  This is beaut, but you still will
+   want to copy the symbol from the buffer to a more permanent
+   symbol-table entry say about half the time.
+
+   With obstacks, you can work differently.  Use one obstack for all symbol
+   names.  As you read a symbol, grow the name in the obstack gradually.
+   When the name is complete, finalize it.  Then, if the symbol exists already,
+   free the newly read name.
+
+   The way we do this is to take a large chunk, allocating memory from
+   low addresses.  When you want to build a symbol in the chunk you just
+   add chars above the current "high water mark" in the chunk.  When you
+   have finished adding chars, because you got to the end of the symbol,
+   you know how long the chars are, and you can create a new object.
+   Mostly the chars will not burst over the highest address of the chunk,
+   because you would typically expect a chunk to be (say) 100 times as
+   long as an average object.
+
+   In case that isn't clear, when we have enough chars to make up
+   the object, THEY ARE ALREADY CONTIGUOUS IN THE CHUNK (guaranteed)
+   so we just point to it where it lies.  No moving of chars is
+   needed and this is the second win: potentially long strings need
+   never be explicitly shuffled. Once an object is formed, it does not
+   change its address during its lifetime.
+
+   When the chars burst over a chunk boundary, we allocate a larger
+   chunk, and then copy the partly formed object from the end of the old
+   chunk to the beginning of the new larger chunk.  We then carry on
+   accreting characters to the end of the object as we normally would.
+
+   A special macro is provided to add a single char at a time to a
+   growing object.  This allows the use of register variables, which
+   break the ordinary 'growth' macro.
+
+   Summary:
+        We allocate large chunks.
+        We carve out one object at a time from the current chunk.
+        Once carved, an object never moves.
+        We are free to append data of any size to the currently
+          growing object.
+        Exactly one object is growing in an obstack at any one time.
+        You can run one obstack per control block.
+        You may have as many control blocks as you dare.
+        Because of the way we do it, you can "unwind" an obstack
+          back to a previous state. (You may remove objects much
+          as you would with a stack.)
+ */
 
 
 /* Don't do the contents of this file more than once.  */
@@ -105,20 +104,30 @@ break the ordinary 'growth' macro.
 #ifndef _OBSTACK_H
 #define _OBSTACK_H 1
 
-#ifdef __cplusplus
-extern "C" {
+#ifndef _OBSTACK_INTERFACE_VERSION
+# define _OBSTACK_INTERFACE_VERSION 2
+#endif
+
+#include <stddef.h>             /* For size_t and ptrdiff_t.  */
+#include <string.h>             /* For __GNU_LIBRARY__, and memcpy.  */
+
+#if __STDC_VERSION__ < 199901L || defined __HP_cc
+# define __FLEXIBLE_ARRAY_MEMBER 1
+#else
+# define __FLEXIBLE_ARRAY_MEMBER
 #endif
-
-/* We need the type of a pointer subtraction.  If __PTRDIFF_TYPE__ is
-   defined, as with GNU C, use that; that way we don't pollute the
-   namespace with <stddef.h>'s symbols.  Otherwise, include <stddef.h>
-   and use ptrdiff_t.  */
-
-#ifdef __PTRDIFF_TYPE__
-# define PTR_INT_TYPE __PTRDIFF_TYPE__
+
+#if _OBSTACK_INTERFACE_VERSION == 1
+/* For binary compatibility with obstack version 1, which used "int"
+   and "long" for these two types.  */
+# define _OBSTACK_SIZE_T unsigned int
+# define _CHUNK_SIZE_T unsigned long
+# define _OBSTACK_CAST(type, expr) ((type) (expr))
 #else
-# include <stddef.h>
-# define PTR_INT_TYPE ptrdiff_t
+/* Version 2 with sane types, especially for 64-bit hosts.  */
+# define _OBSTACK_SIZE_T size_t
+# define _CHUNK_SIZE_T size_t
+# define _OBSTACK_CAST(type, expr) (expr)
 #endif
 
 /* If B is the base of an object addressed by P, return the result of
@@ -127,78 +136,102 @@ extern "C" {
 
 #define __BPTR_ALIGN(B, P, A) ((B) + (((P) - (B) + (A)) & ~(A)))
 
-/* Similar to _BPTR_ALIGN (B, P, A), except optimize the common case
+/* Similar to __BPTR_ALIGN (B, P, A), except optimize the common case
    where pointers can be converted to integers, aligned as integers,
-   and converted back again.  If PTR_INT_TYPE is narrower than a
+   and converted back again.  If ptrdiff_t is narrower than a
    pointer (e.g., the AS/400), play it safe and compute the alignment
    relative to B.  Otherwise, use the faster strategy of computing the
    alignment relative to 0.  */
 
-#define __PTR_ALIGN(B, P, A)						    \
-  __BPTR_ALIGN (sizeof (PTR_INT_TYPE) < sizeof (void *) ? (B) : (char *) 0, \
-		P, A)
+#define __PTR_ALIGN(B, P, A)						      \
+  __BPTR_ALIGN (sizeof (ptrdiff_t) < sizeof (void *) ? (B) : (char *) 0,      \
+                P, A)
+
+#ifndef __attribute_pure__
+# define __attribute_pure__ _GL_ATTRIBUTE_PURE
+#endif
+
+/* Not the same as _Noreturn, since it also works with function pointers.  */
+#ifndef __attribute_noreturn__
+# if 2 < __GNUC__ + (8 <= __GNUC_MINOR__) || 0x5110 <= __SUNPRO_C
+#  define __attribute_noreturn__ __attribute__ ((__noreturn__))
+# else
+#  define __attribute_noreturn__
+# endif
+#endif
 
-#include <string.h>
+#ifdef __cplusplus
+extern "C" {
+#endif
 
-struct _obstack_chunk		/* Lives at front of each chunk. */
+struct _obstack_chunk           /* Lives at front of each chunk. */
 {
-  char  *limit;			/* 1 past end of this chunk */
-  struct _obstack_chunk *prev;	/* address of prior chunk or NULL */
-  char	contents[4];		/* objects begin here */
+  char *limit;                  /* 1 past end of this chunk */
+  struct _obstack_chunk *prev;  /* address of prior chunk or NULL */
+  char contents[__FLEXIBLE_ARRAY_MEMBER]; /* objects begin here */
 };
 
-struct obstack		/* control current object in current chunk */
+struct obstack          /* control current object in current chunk */
 {
-  long	chunk_size;		/* preferred size to allocate chunks in */
-  struct _obstack_chunk *chunk;	/* address of current struct obstack_chunk */
-  char	*object_base;		/* address of object we are building */
-  char	*next_free;		/* where to add next char to current object */
-  char	*chunk_limit;		/* address of char after current chunk */
+  _CHUNK_SIZE_T chunk_size;     /* preferred size to allocate chunks in */
+  struct _obstack_chunk *chunk; /* address of current struct obstack_chunk */
+  char *object_base;            /* address of object we are building */
+  char *next_free;              /* where to add next char to current object */
+  char *chunk_limit;            /* address of char after current chunk */
+  union
+  {
+    _OBSTACK_SIZE_T i;
+    void *p;
+  } temp;                       /* Temporary for some macros.  */
+  _OBSTACK_SIZE_T alignment_mask;  /* Mask of alignment for each object. */
+
+  /* These prototypes vary based on 'use_extra_arg'.  */
   union
   {
-    PTR_INT_TYPE tempint;
-    void *tempptr;
-  } temp;			/* Temporary for some macros.  */
-  int   alignment_mask;		/* Mask of alignment for each object. */
-  /* These prototypes vary based on `use_extra_arg'. */
-  union {
-    void *(*plain) (long);
-    struct _obstack_chunk *(*extra) (void *, long);
+    void *(*plain) (size_t);
+    void *(*extra) (void *, size_t);
   } chunkfun;
-  union {
+  union
+  {
     void (*plain) (void *);
-    void (*extra) (void *, struct _obstack_chunk *);
+    void (*extra) (void *, void *);
   } freefun;
-  void *extra_arg;		/* first arg for chunk alloc/dealloc funcs */
-  unsigned use_extra_arg:1;	/* chunk alloc/dealloc funcs take extra arg */
-  unsigned maybe_empty_object:1;/* There is a possibility that the current
-				   chunk contains a zero-length object.  This
-				   prevents freeing the chunk if we allocate
-				   a bigger chunk to replace it. */
-  unsigned alloc_failed:1;	/* No longer used, as we now call the failed
-				   handler on error, but retained for binary
-				   compatibility.  */
+
+  void *extra_arg;              /* first arg for chunk alloc/dealloc funcs */
+  unsigned use_extra_arg : 1;     /* chunk alloc/dealloc funcs take extra arg */
+  unsigned maybe_empty_object : 1; /* There is a possibility that the current
+                                      chunk contains a zero-length object.  This
+                                      prevents freeing the chunk if we allocate
+                                      a bigger chunk to replace it. */
+  unsigned alloc_failed : 1;      /* No longer used, as we now call the failed
+                                     handler on error, but retained for binary
+                                     compatibility.  */
 };
 
 /* Declare the external functions we use; they are in obstack.c.  */
 
-extern void _obstack_newchunk (struct obstack *, int);
-extern int _obstack_begin (struct obstack *, int, int,
-			    void *(*) (long), void (*) (void *));
-extern int _obstack_begin_1 (struct obstack *, int, int,
-			     void *(*) (void *, long),
-			     void (*) (void *, void *), void *);
-extern int _obstack_memory_used (struct obstack *);
+extern void _obstack_newchunk (struct obstack *, _OBSTACK_SIZE_T);
+extern void _obstack_free (struct obstack *, void *);
+extern int _obstack_begin (struct obstack *,
+                           _OBSTACK_SIZE_T, _OBSTACK_SIZE_T,
+                           void *(*) (size_t), void (*) (void *));
+extern int _obstack_begin_1 (struct obstack *,
+                             _OBSTACK_SIZE_T, _OBSTACK_SIZE_T,
+                             void *(*) (void *, size_t),
+                             void (*) (void *, void *), void *);
+extern _OBSTACK_SIZE_T _obstack_memory_used (struct obstack *)
+  __attribute_pure__;
 
-void obstack_free (struct obstack *, void *);
 
-
-/* Error handler called when `obstack_chunk_alloc' failed to allocate
+/* Error handler called when 'obstack_chunk_alloc' failed to allocate
    more memory.  This can be set to a user defined function which
    should either abort gracefully or use longjump - but shouldn't
    return.  The default action is to print a message and abort.  */
-extern void (*obstack_alloc_failed_handler) (void);
-
+extern __attribute_noreturn__ void (*obstack_alloc_failed_handler) (void);
+
+/* Exit value used when 'print_and_abort' is used.  */
+extern int obstack_exit_failure;
+
 /* Pointer to beginning of object being allocated or to be allocated next.
    Note that this might not be the final address of the object
    because a new chunk might be needed to hold the final size.  */
@@ -211,210 +244,210 @@ extern void (*obstack_alloc_failed_handler) (void);
 
 /* Pointer to next byte not yet allocated in current chunk.  */
 
-#define obstack_next_free(h)	((h)->next_free)
+#define obstack_next_free(h) ((void *) (h)->next_free)
 
 /* Mask specifying low bits that should be clear in address of an object.  */
 
 #define obstack_alignment_mask(h) ((h)->alignment_mask)
 
 /* To prevent prototype warnings provide complete argument list.  */
-#define obstack_init(h)						\
-  _obstack_begin ((h), 0, 0,					\
-		  (void *(*) (long)) obstack_chunk_alloc,	\
-		  (void (*) (void *)) obstack_chunk_free)
+#define obstack_init(h)							      \
+  _obstack_begin ((h), 0, 0,						      \
+                  _OBSTACK_CAST (void *(*) (size_t), obstack_chunk_alloc),    \
+                  _OBSTACK_CAST (void (*) (void *), obstack_chunk_free))
 
-#define obstack_begin(h, size)					\
-  _obstack_begin ((h), (size), 0,				\
-		  (void *(*) (long)) obstack_chunk_alloc,	\
-		  (void (*) (void *)) obstack_chunk_free)
+#define obstack_begin(h, size)						      \
+  _obstack_begin ((h), (size), 0,					      \
+                  _OBSTACK_CAST (void *(*) (size_t), obstack_chunk_alloc), \
+                  _OBSTACK_CAST (void (*) (void *), obstack_chunk_free))
 
-#define obstack_specify_allocation(h, size, alignment, chunkfun, freefun)  \
-  _obstack_begin ((h), (size), (alignment),				   \
-		  (void *(*) (long)) (chunkfun),			   \
-		  (void (*) (void *)) (freefun))
+#define obstack_specify_allocation(h, size, alignment, chunkfun, freefun)     \
+  _obstack_begin ((h), (size), (alignment),				      \
+                  _OBSTACK_CAST (void *(*) (size_t), chunkfun),		      \
+                  _OBSTACK_CAST (void (*) (void *), freefun))
 
 #define obstack_specify_allocation_with_arg(h, size, alignment, chunkfun, freefun, arg) \
-  _obstack_begin_1 ((h), (size), (alignment),				\
-		    (void *(*) (void *, long)) (chunkfun),		\
-		    (void (*) (void *, void *)) (freefun), (arg))
+  _obstack_begin_1 ((h), (size), (alignment),				      \
+                    _OBSTACK_CAST (void *(*) (void *, size_t), chunkfun),     \
+                    _OBSTACK_CAST (void (*) (void *, void *), freefun), arg)
 
-#define obstack_chunkfun(h, newchunkfun) \
-  ((h)->chunkfun.extra = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
+#define obstack_chunkfun(h, newchunkfun)				      \
+  ((void) ((h)->chunkfun.extra = (void *(*) (void *, size_t)) (newchunkfun)))
 
-#define obstack_freefun(h, newfreefun) \
-  ((h)->freefun.extra = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
+#define obstack_freefun(h, newfreefun)					      \
+  ((void) ((h)->freefun.extra = (void *(*) (void *, void *)) (newfreefun)))
 
-#define obstack_1grow_fast(h,achar) (*((h)->next_free)++ = (achar))
+#define obstack_1grow_fast(h, achar) ((void) (*((h)->next_free)++ = (achar)))
 
-#define obstack_blank_fast(h,n) ((h)->next_free += (n))
+#define obstack_blank_fast(h, n) ((void) ((h)->next_free += (n)))
 
 #define obstack_memory_used(h) _obstack_memory_used (h)
-
-#if defined __GNUC__ && defined __STDC__ && __STDC__
-/* NextStep 2.0 cc is really gcc 1.93 but it defines __GNUC__ = 2 and
-   does not implement __extension__.  But that compiler doesn't define
-   __GNUC_MINOR__.  */
-# if __GNUC__ < 2 || (__NeXT__ && !__GNUC_MINOR__)
+
+#if defined __GNUC__
+# if !defined __GNUC_MINOR__ || __GNUC__ * 1000 + __GNUC_MINOR__ < 2008
 #  define __extension__
 # endif
 
 /* For GNU C, if not -traditional,
    we can define these macros to compute all args only once
    without using a global variable.
-   Also, we can avoid using the `temp' slot, to make faster code.  */
-
-# define obstack_object_size(OBSTACK)					\
-  __extension__								\
-  ({ struct obstack const *__o = (OBSTACK);				\
-     (unsigned) (__o->next_free - __o->object_base); })
-
-# define obstack_room(OBSTACK)						\
-  __extension__								\
-  ({ struct obstack const *__o = (OBSTACK);				\
-     (unsigned) (__o->chunk_limit - __o->next_free); })
-
-# define obstack_make_room(OBSTACK,length)				\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   int __len = (length);						\
-   if (__o->chunk_limit - __o->next_free < __len)			\
-     _obstack_newchunk (__o, __len);					\
-   (void) 0; })
-
-# define obstack_empty_p(OBSTACK)					\
-  __extension__								\
-  ({ struct obstack const *__o = (OBSTACK);				\
-     (__o->chunk->prev == 0						\
-      && __o->next_free == __PTR_ALIGN ((char *) __o->chunk,		\
-					__o->chunk->contents,		\
-					__o->alignment_mask)); })
-
-# define obstack_grow(OBSTACK,where,length)				\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   int __len = (length);						\
-   if (__o->next_free + __len > __o->chunk_limit)			\
-     _obstack_newchunk (__o, __len);					\
-   memcpy (__o->next_free, where, __len);				\
-   __o->next_free += __len;						\
-   (void) 0; })
-
-# define obstack_grow0(OBSTACK,where,length)				\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   int __len = (length);						\
-   if (__o->next_free + __len + 1 > __o->chunk_limit)			\
-     _obstack_newchunk (__o, __len + 1);				\
-   memcpy (__o->next_free, where, __len);				\
-   __o->next_free += __len;						\
-   *(__o->next_free)++ = 0;						\
-   (void) 0; })
-
-# define obstack_1grow(OBSTACK,datum)					\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   if (__o->next_free + 1 > __o->chunk_limit)				\
-     _obstack_newchunk (__o, 1);					\
-   obstack_1grow_fast (__o, datum);					\
-   (void) 0; })
+   Also, we can avoid using the 'temp' slot, to make faster code.  */
+
+# define obstack_object_size(OBSTACK)					      \
+  __extension__								      \
+    ({ struct obstack const *__o = (OBSTACK);				      \
+       (_OBSTACK_SIZE_T) (__o->next_free - __o->object_base); })
+
+/* The local variable is named __o1 to avoid a shadowed variable
+   warning when invoked from other obstack macros.  */
+# define obstack_room(OBSTACK)						      \
+  __extension__								      \
+    ({ struct obstack const *__o1 = (OBSTACK);				      \
+       (_OBSTACK_SIZE_T) (__o1->chunk_limit - __o1->next_free); })
+
+# define obstack_make_room(OBSTACK, length)				      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       _OBSTACK_SIZE_T __len = (length);				      \
+       if (obstack_room (__o) < __len)					      \
+         _obstack_newchunk (__o, __len);				      \
+       (void) 0; })
+
+# define obstack_empty_p(OBSTACK)					      \
+  __extension__								      \
+    ({ struct obstack const *__o = (OBSTACK);				      \
+       (__o->chunk->prev == 0						      \
+        && __o->next_free == __PTR_ALIGN ((char *) __o->chunk,		      \
+                                          __o->chunk->contents,		      \
+                                          __o->alignment_mask)); })
+
+# define obstack_grow(OBSTACK, where, length)				      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       _OBSTACK_SIZE_T __len = (length);				      \
+       if (obstack_room (__o) < __len)					      \
+         _obstack_newchunk (__o, __len);				      \
+       memcpy (__o->next_free, where, __len);				      \
+       __o->next_free += __len;						      \
+       (void) 0; })
+
+# define obstack_grow0(OBSTACK, where, length)				      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       _OBSTACK_SIZE_T __len = (length);				      \
+       if (obstack_room (__o) < __len + 1)				      \
+         _obstack_newchunk (__o, __len + 1);				      \
+       memcpy (__o->next_free, where, __len);				      \
+       __o->next_free += __len;						      \
+       *(__o->next_free)++ = 0;						      \
+       (void) 0; })
+
+# define obstack_1grow(OBSTACK, datum)					      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       if (obstack_room (__o) < 1)					      \
+         _obstack_newchunk (__o, 1);					      \
+       obstack_1grow_fast (__o, datum); })
 
 /* These assume that the obstack alignment is good enough for pointers
    or ints, and that the data added so far to the current object
    shares that much alignment.  */
 
-# define obstack_ptr_grow(OBSTACK,datum)				\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   if (__o->next_free + sizeof (void *) > __o->chunk_limit)		\
-     _obstack_newchunk (__o, sizeof (void *));				\
-   obstack_ptr_grow_fast (__o, datum); })				\
-
-# define obstack_int_grow(OBSTACK,datum)				\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   if (__o->next_free + sizeof (int) > __o->chunk_limit)		\
-     _obstack_newchunk (__o, sizeof (int));				\
-   obstack_int_grow_fast (__o, datum); })
-
-# define obstack_ptr_grow_fast(OBSTACK,aptr)				\
-__extension__								\
-({ struct obstack *__o1 = (OBSTACK);					\
-   *(const void **) __o1->next_free = (aptr);				\
-   __o1->next_free += sizeof (const void *);				\
-   (void) 0; })
-
-# define obstack_int_grow_fast(OBSTACK,aint)				\
-__extension__								\
-({ struct obstack *__o1 = (OBSTACK);					\
-   *(int *) __o1->next_free = (aint);					\
-   __o1->next_free += sizeof (int);					\
-   (void) 0; })
-
-# define obstack_blank(OBSTACK,length)					\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   int __len = (length);						\
-   if (__o->chunk_limit - __o->next_free < __len)			\
-     _obstack_newchunk (__o, __len);					\
-   obstack_blank_fast (__o, __len);					\
-   (void) 0; })
-
-# define obstack_alloc(OBSTACK,length)					\
-__extension__								\
-({ struct obstack *__h = (OBSTACK);					\
-   obstack_blank (__h, (length));					\
-   obstack_finish (__h); })
-
-# define obstack_copy(OBSTACK,where,length)				\
-__extension__								\
-({ struct obstack *__h = (OBSTACK);					\
-   obstack_grow (__h, (where), (length));				\
-   obstack_finish (__h); })
-
-# define obstack_copy0(OBSTACK,where,length)				\
-__extension__								\
-({ struct obstack *__h = (OBSTACK);					\
-   obstack_grow0 (__h, (where), (length));				\
-   obstack_finish (__h); })
-
-/* The local variable is named __o1 to avoid a name conflict
-   when obstack_blank is called.  */
-# define obstack_finish(OBSTACK)					\
-__extension__								\
-({ struct obstack *__o1 = (OBSTACK);					\
-   void *__value = (void *) __o1->object_base;				\
-   if (__o1->next_free == __value)					\
-     __o1->maybe_empty_object = 1;					\
-   __o1->next_free							\
-     = __PTR_ALIGN (__o1->object_base, __o1->next_free,			\
-		    __o1->alignment_mask);				\
-   if (__o1->next_free - (char *)__o1->chunk				\
-       > __o1->chunk_limit - (char *)__o1->chunk)			\
-     __o1->next_free = __o1->chunk_limit;				\
-   __o1->object_base = __o1->next_free;					\
-   __value; })
-
-# define obstack_free(OBSTACK, OBJ)					\
-__extension__								\
-({ struct obstack *__o = (OBSTACK);					\
-   void *__obj = (OBJ);							\
-   if (__obj > (void *)__o->chunk && __obj < (void *)__o->chunk_limit)  \
-     __o->next_free = __o->object_base = (char *)__obj;			\
-   else (obstack_free) (__o, __obj); })
-
-#else /* not __GNUC__ or not __STDC__ */
-
-# define obstack_object_size(h) \
- (unsigned) ((h)->next_free - (h)->object_base)
-
-# define obstack_room(h)		\
- (unsigned) ((h)->chunk_limit - (h)->next_free)
-
-# define obstack_empty_p(h) \
- ((h)->chunk->prev == 0							\
-  && (h)->next_free == __PTR_ALIGN ((char *) (h)->chunk,		\
-				    (h)->chunk->contents,		\
-				    (h)->alignment_mask))
+# define obstack_ptr_grow(OBSTACK, datum)				      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       if (obstack_room (__o) < sizeof (void *))			      \
+         _obstack_newchunk (__o, sizeof (void *));			      \
+       obstack_ptr_grow_fast (__o, datum); })
+
+# define obstack_int_grow(OBSTACK, datum)				      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       if (obstack_room (__o) < sizeof (int))				      \
+         _obstack_newchunk (__o, sizeof (int));				      \
+       obstack_int_grow_fast (__o, datum); })
+
+# define obstack_ptr_grow_fast(OBSTACK, aptr)				      \
+  __extension__								      \
+    ({ struct obstack *__o1 = (OBSTACK);				      \
+       void *__p1 = __o1->next_free;					      \
+       *(const void **) __p1 = (aptr);					      \
+       __o1->next_free += sizeof (const void *);			      \
+       (void) 0; })
+
+# define obstack_int_grow_fast(OBSTACK, aint)				      \
+  __extension__								      \
+    ({ struct obstack *__o1 = (OBSTACK);				      \
+       void *__p1 = __o1->next_free;					      \
+       *(int *) __p1 = (aint);						      \
+       __o1->next_free += sizeof (int);					      \
+       (void) 0; })
+
+# define obstack_blank(OBSTACK, length)					      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       _OBSTACK_SIZE_T __len = (length);				      \
+       if (obstack_room (__o) < __len)					      \
+         _obstack_newchunk (__o, __len);				      \
+       obstack_blank_fast (__o, __len); })
+
+# define obstack_alloc(OBSTACK, length)					      \
+  __extension__								      \
+    ({ struct obstack *__h = (OBSTACK);					      \
+       obstack_blank (__h, (length));					      \
+       obstack_finish (__h); })
+
+# define obstack_copy(OBSTACK, where, length)				      \
+  __extension__								      \
+    ({ struct obstack *__h = (OBSTACK);					      \
+       obstack_grow (__h, (where), (length));				      \
+       obstack_finish (__h); })
+
+# define obstack_copy0(OBSTACK, where, length)				      \
+  __extension__								      \
+    ({ struct obstack *__h = (OBSTACK);					      \
+       obstack_grow0 (__h, (where), (length));				      \
+       obstack_finish (__h); })
+
+/* The local variable is named __o1 to avoid a shadowed variable
+   warning when invoked from other obstack macros, typically obstack_free.  */
+# define obstack_finish(OBSTACK)					      \
+  __extension__								      \
+    ({ struct obstack *__o1 = (OBSTACK);				      \
+       void *__value = (void *) __o1->object_base;			      \
+       if (__o1->next_free == __value)					      \
+         __o1->maybe_empty_object = 1;					      \
+       __o1->next_free							      \
+         = __PTR_ALIGN (__o1->object_base, __o1->next_free,		      \
+                        __o1->alignment_mask);				      \
+       if ((size_t) (__o1->next_free - (char *) __o1->chunk)		      \
+           > (size_t) (__o1->chunk_limit - (char *) __o1->chunk))	      \
+         __o1->next_free = __o1->chunk_limit;				      \
+       __o1->object_base = __o1->next_free;				      \
+       __value; })
+
+# define obstack_free(OBSTACK, OBJ)					      \
+  __extension__								      \
+    ({ struct obstack *__o = (OBSTACK);					      \
+       void *__obj = (void *) (OBJ);					      \
+       if (__obj > (void *) __o->chunk && __obj < (void *) __o->chunk_limit)  \
+         __o->next_free = __o->object_base = (char *) __obj;		      \
+       else								      \
+         _obstack_free (__o, __obj); })
+
+#else /* not __GNUC__ */
+
+# define obstack_object_size(h)						      \
+  ((_OBSTACK_SIZE_T) ((h)->next_free - (h)->object_base))
+
+# define obstack_room(h)						      \
+  ((_OBSTACK_SIZE_T) ((h)->chunk_limit - (h)->next_free))
+
+# define obstack_empty_p(h)						      \
+  ((h)->chunk->prev == 0						      \
+   && (h)->next_free == __PTR_ALIGN ((char *) (h)->chunk,		      \
+                                     (h)->chunk->contents,		      \
+                                     (h)->alignment_mask))
 
 /* Note that the call to _obstack_newchunk is enclosed in (..., 0)
    so that we can avoid having void expressions
@@ -422,88 +455,92 @@ __extension__								\
    Casting the third operand to void was tried before,
    but some compilers won't accept it.  */
 
-# define obstack_make_room(h,length)					\
-( (h)->temp.tempint = (length),						\
-  (((h)->next_free + (h)->temp.tempint > (h)->chunk_limit)		\
-   ? (_obstack_newchunk ((h), (h)->temp.tempint), 0) : 0))
-
-# define obstack_grow(h,where,length)					\
-( (h)->temp.tempint = (length),						\
-  (((h)->next_free + (h)->temp.tempint > (h)->chunk_limit)		\
-   ? (_obstack_newchunk ((h), (h)->temp.tempint), 0) : 0),		\
-  memcpy ((h)->next_free, where, (h)->temp.tempint),			\
-  (h)->next_free += (h)->temp.tempint)
-
-# define obstack_grow0(h,where,length)					\
-( (h)->temp.tempint = (length),						\
-  (((h)->next_free + (h)->temp.tempint + 1 > (h)->chunk_limit)		\
-   ? (_obstack_newchunk ((h), (h)->temp.tempint + 1), 0) : 0),		\
-  memcpy ((h)->next_free, where, (h)->temp.tempint),			\
-  (h)->next_free += (h)->temp.tempint,					\
-  *((h)->next_free)++ = 0)
-
-# define obstack_1grow(h,datum)						\
-( (((h)->next_free + 1 > (h)->chunk_limit)				\
-   ? (_obstack_newchunk ((h), 1), 0) : 0),				\
-  obstack_1grow_fast (h, datum))
-
-# define obstack_ptr_grow(h,datum)					\
-( (((h)->next_free + sizeof (char *) > (h)->chunk_limit)		\
-   ? (_obstack_newchunk ((h), sizeof (char *)), 0) : 0),		\
-  obstack_ptr_grow_fast (h, datum))
-
-# define obstack_int_grow(h,datum)					\
-( (((h)->next_free + sizeof (int) > (h)->chunk_limit)			\
-   ? (_obstack_newchunk ((h), sizeof (int)), 0) : 0),			\
-  obstack_int_grow_fast (h, datum))
-
-# define obstack_ptr_grow_fast(h,aptr)					\
-  (((const void **) ((h)->next_free += sizeof (void *)))[-1] = (aptr))
-
-# define obstack_int_grow_fast(h,aint)					\
-  (((int *) ((h)->next_free += sizeof (int)))[-1] = (aint))
-
-# define obstack_blank(h,length)					\
-( (h)->temp.tempint = (length),						\
-  (((h)->chunk_limit - (h)->next_free < (h)->temp.tempint)		\
-   ? (_obstack_newchunk ((h), (h)->temp.tempint), 0) : 0),		\
-  obstack_blank_fast (h, (h)->temp.tempint))
-
-# define obstack_alloc(h,length)					\
- (obstack_blank ((h), (length)), obstack_finish ((h)))
-
-# define obstack_copy(h,where,length)					\
- (obstack_grow ((h), (where), (length)), obstack_finish ((h)))
-
-# define obstack_copy0(h,where,length)					\
- (obstack_grow0 ((h), (where), (length)), obstack_finish ((h)))
-
-# define obstack_finish(h)						\
-( ((h)->next_free == (h)->object_base					\
-   ? (((h)->maybe_empty_object = 1), 0)					\
-   : 0),								\
-  (h)->temp.tempptr = (h)->object_base,					\
-  (h)->next_free							\
-    = __PTR_ALIGN ((h)->object_base, (h)->next_free,			\
-		   (h)->alignment_mask),				\
-  (((h)->next_free - (char *) (h)->chunk				\
-    > (h)->chunk_limit - (char *) (h)->chunk)				\
-   ? ((h)->next_free = (h)->chunk_limit) : 0),				\
-  (h)->object_base = (h)->next_free,					\
-  (h)->temp.tempptr)
-
-# define obstack_free(h,obj)						\
-( (h)->temp.tempint = (char *) (obj) - (char *) (h)->chunk,		\
-  ((((h)->temp.tempint > 0						\
-    && (h)->temp.tempint < (h)->chunk_limit - (char *) (h)->chunk))	\
-   ? (int) ((h)->next_free = (h)->object_base				\
-	    = (h)->temp.tempint + (char *) (h)->chunk)			\
-   : (((obstack_free) ((h), (h)->temp.tempint + (char *) (h)->chunk), 0), 0)))
-
-#endif /* not __GNUC__ or not __STDC__ */
+# define obstack_make_room(h, length)					      \
+  ((h)->temp.i = (length),						      \
+   ((obstack_room (h) < (h)->temp.i)					      \
+    ? (_obstack_newchunk (h, (h)->temp.i), 0) : 0),			      \
+   (void) 0)
+
+# define obstack_grow(h, where, length)					      \
+  ((h)->temp.i = (length),						      \
+   ((obstack_room (h) < (h)->temp.i)					      \
+   ? (_obstack_newchunk ((h), (h)->temp.i), 0) : 0),			      \
+   memcpy ((h)->next_free, where, (h)->temp.i),				      \
+   (h)->next_free += (h)->temp.i,					      \
+   (void) 0)
+
+# define obstack_grow0(h, where, length)				      \
+  ((h)->temp.i = (length),						      \
+   ((obstack_room (h) < (h)->temp.i + 1)				      \
+   ? (_obstack_newchunk ((h), (h)->temp.i + 1), 0) : 0),		      \
+   memcpy ((h)->next_free, where, (h)->temp.i),				      \
+   (h)->next_free += (h)->temp.i,					      \
+   *((h)->next_free)++ = 0,						      \
+   (void) 0)
+
+# define obstack_1grow(h, datum)					      \
+  (((obstack_room (h) < 1)						      \
+    ? (_obstack_newchunk ((h), 1), 0) : 0),				      \
+   obstack_1grow_fast (h, datum))
+
+# define obstack_ptr_grow(h, datum)					      \
+  (((obstack_room (h) < sizeof (char *))				      \
+    ? (_obstack_newchunk ((h), sizeof (char *)), 0) : 0),		      \
+   obstack_ptr_grow_fast (h, datum))
+
+# define obstack_int_grow(h, datum)					      \
+  (((obstack_room (h) < sizeof (int))					      \
+    ? (_obstack_newchunk ((h), sizeof (int)), 0) : 0),			      \
+   obstack_int_grow_fast (h, datum))
+
+# define obstack_ptr_grow_fast(h, aptr)					      \
+  (((const void **) ((h)->next_free += sizeof (void *)))[-1] = (aptr),	      \
+   (void) 0)
+
+# define obstack_int_grow_fast(h, aint)					      \
+  (((int *) ((h)->next_free += sizeof (int)))[-1] = (aint),		      \
+   (void) 0)
+
+# define obstack_blank(h, length)					      \
+  ((h)->temp.i = (length),						      \
+   ((obstack_room (h) < (h)->temp.i)					      \
+   ? (_obstack_newchunk ((h), (h)->temp.i), 0) : 0),			      \
+   obstack_blank_fast (h, (h)->temp.i))
+
+# define obstack_alloc(h, length)					      \
+  (obstack_blank ((h), (length)), obstack_finish ((h)))
+
+# define obstack_copy(h, where, length)					      \
+  (obstack_grow ((h), (where), (length)), obstack_finish ((h)))
+
+# define obstack_copy0(h, where, length)				      \
+  (obstack_grow0 ((h), (where), (length)), obstack_finish ((h)))
+
+# define obstack_finish(h)						      \
+  (((h)->next_free == (h)->object_base					      \
+    ? (((h)->maybe_empty_object = 1), 0)				      \
+    : 0),								      \
+   (h)->temp.p = (h)->object_base,					      \
+   (h)->next_free							      \
+     = __PTR_ALIGN ((h)->object_base, (h)->next_free,			      \
+                    (h)->alignment_mask),				      \
+   (((size_t) ((h)->next_free - (char *) (h)->chunk)			      \
+     > (size_t) ((h)->chunk_limit - (char *) (h)->chunk))		      \
+   ? ((h)->next_free = (h)->chunk_limit) : 0),				      \
+   (h)->object_base = (h)->next_free,					      \
+   (h)->temp.p)
+
+# define obstack_free(h, obj)						      \
+  ((h)->temp.p = (void *) (obj),					      \
+   (((h)->temp.p > (void *) (h)->chunk					      \
+     && (h)->temp.p < (void *) (h)->chunk_limit)			      \
+    ? (void) ((h)->next_free = (h)->object_base = (char *) (h)->temp.p)       \
+    : _obstack_free ((h), (h)->temp.p)))
+
+#endif /* not __GNUC__ */
 
 #ifdef __cplusplus
-}	/* C++ */
+}       /* C++ */
 #endif
 
-#endif /* obstack.h */
+#endif /* _OBSTACK_H */
-- 
2.22.0.589.g5bd7971b91

