From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: obstack fails to compile on OS X 10.7
Date: Sun, 28 Aug 2011 22:08:46 +0200
Message-ID: <20110828200846.GA10754@fredrik-Q430-Q530>
References: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com>
 <20110827101418.GA8074@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 22:09:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxlfA-0004Tl-38
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 22:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab1H1UI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 16:08:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40754 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1H1UIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 16:08:54 -0400
Received: by bke11 with SMTP id 11so3686062bke.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0oivhFdFGIxn2Lgll86JY71u2hjatMVzur/vpN9p2FI=;
        b=OsN9Mg3XH/j8U1OCI5kSYAw1YeKd+HMol5gXxI7jQ6/R4J4MVhL+PBZ4DBnnHoabac
         zhyZ79aK/BakowEls/3YPwcAT8O/Lsy8yxuKNCfEH6ZwaEY8bBubzJmoR5btWzkLq7c5
         n+ZArWGGSygj0GM6Rc3bJGcz25WAmR1dX0JZM=
Received: by 10.204.130.205 with SMTP id u13mr1657164bks.401.1314562133251;
        Sun, 28 Aug 2011 13:08:53 -0700 (PDT)
Received: from fredrik-Q430-Q530 (c83-250-140-53.bredband.comhem.se [83.250.140.53])
        by mx.google.com with ESMTPS id y8sm1012751bks.54.2011.08.28.13.08.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 13:08:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110827101418.GA8074@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180282>

On Sat, Aug 27, 2011 at 03:14:43AM -0700, David Aguilar wrote:
> On Sat, Aug 27, 2011 at 02:21:40AM -0400, Brian Gernhardt wrote:
> > Some of the errors look like things I could track down, but some ju=
st confuse me.  If anyone else could take a look into this, it would be=
 much appreciated.
> >=20
> > ~~ Brian G.
> >=20
> > gcc -o compat/obstack.o -c -MF compat/.depend/obstack.o.d -MMD -MP =
 -Wall -Wdeclaration-after-statement -Werror -Wno-deprecated-declaratio=
ns -I. -DUSE_ST_TIMESPEC  -DSHA1_HEADER=3D'"block-sha1/sha1.h"'  -DNO_M=
EMMEM  compat/obstack.c
> > In file included from compat/obstack.c:30:
> > compat/obstack.h:190: error: __block attribute can be specified on =
variables only
> > compat/obstack.c:70: error: expected specifier-qualifier-list befor=
e =E2=80=98uintmax_t=E2=80=99
> > compat/obstack.c:111:24: error: exitfail.h: No such file or directo=
ry
> > cc1: warnings being treated as errors
> > compat/obstack.c: In function =E2=80=98print_and_abort=E2=80=99:
> > compat/obstack.c:436: warning: implicit declaration of function =E2=
=80=98gettext=E2=80=99
> > compat/obstack.c:436: warning: incompatible implicit declaration of=
 built-in function =E2=80=98gettext=E2=80=99
> > compat/obstack.c:438: error: =E2=80=98exit_failure=E2=80=99 undecla=
red (first use in this function)
> > compat/obstack.c:438: error: (Each undeclared identifier is reporte=
d only once
> > compat/obstack.c:438: error: for each function it appears in.)
> > compat/obstack.c:439: warning: =E2=80=98noreturn=E2=80=99 function =
does return
> > make: *** [compat/obstack.o] Error 1
> >=20
> > $ gcc --version
> > i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc. b=
uild 5658) (LLVM build 2335.15.00)
>=20
> I ran into the same thing.
>=20
> This fixes it for me, but we might want to rearrange the
> #includes a bit.  I think this needs more work.. including
> compat/obstack.h from kwset.c seems wrong.
> Should we just include obstack.h in git-compat-util instead?
>=20
> I suspect that more exotic platforms may have problems
> with obstack.h as well.  This probably needs some testing
> on SunOS, AIX, IRIX, etc.


How about doing something a bit simpler instead and changing obstack.c
to not make use of exit.h and exitfail.h? Then we don't have to update
Makefile for all platforms needing NEEDS_OBSTACK and NEEDS_EXITFAIL.

I don't understand why the ELIDE_CODE check is not sufficient. Care to
explain?

Something like this (tested on Linux and SunOS 5.10):

-- 8< --

Subject: [PATCH RFC] obstack: Fix portability issues

i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1, SunOS 5.10, and possibly
others do not have exit.h and exitfail.h. Remove the use of these in
obstack.c.

The __block variable was renamed to block to avoid a gcc error:

compat/obstack.h:190: error: __block attribute can be specified on vari=
ables only

Initial-patch-by: David Aguilar <davvid@gmail.com>
Reported-by: Brian Gernhardt <brian@gernhardtsoftware.com>
Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 compat/obstack.c |   35 ++++-------------------------------
 compat/obstack.h |    5 +----
 kwset.c          |    2 +-
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 75440d9..a89ab5b 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -18,17 +18,9 @@
    Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.  */
=20
-
-#ifdef HAVE_CONFIG_H
-# include <config.h>
-#endif
-
-#ifdef _LIBC
-# include <obstack.h>
-# include <shlib-compat.h>
-#else
-# include "obstack.h"
-#endif
+#include "git-compat-util.h"
+#include <gettext.h>
+#include "obstack.h"
=20
 /* NOTE BEFORE MODIFYING THIS FILE: This version number must be
    incremented whenever callers compiled using an old obstack.h can no
@@ -103,15 +95,6 @@ enum
 static void print_and_abort (void);
 void (*obstack_alloc_failed_handler) (void) =3D print_and_abort;
=20
-/* Exit value used when `print_and_abort' is used.  */
-# include <stdlib.h>
-# ifdef _LIBC
-int obstack_exit_failure =3D EXIT_FAILURE;
-# else
-#  include "exitfail.h"
-#  define obstack_exit_failure exit_failure
-# endif
-
 # ifdef _LIBC
 #  if SHLIB_COMPAT (libc, GLIBC_2_0, GLIBC_2_3_4)
 /* A looong time ago (before 1994, anyway; we're not sure) this global=
 variable
@@ -400,16 +383,6 @@ _obstack_memory_used (struct obstack *h)
   return nbytes;
 }
 =0C
-/* Define the error handler.  */
-# ifdef _LIBC
-#  include <libintl.h>
-# else
-#  include "gettext.h"
-# endif
-# ifndef _
-#  define _(msgid) gettext (msgid)
-# endif
-
 # ifdef _LIBC
 #  include <libio/iolibio.h>
 # endif
@@ -435,7 +408,7 @@ print_and_abort (void)
 # else
   fprintf (stderr, "%s\n", _("memory exhausted"));
 # endif
-  exit (obstack_exit_failure);
+  exit (1);
 }
=20
 #endif	/* !ELIDE_CODE */
diff --git a/compat/obstack.h b/compat/obstack.h
index 449070e..c3b681f 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -187,7 +187,7 @@ extern int _obstack_begin_1 (struct obstack *, int,=
 int,
 			     void (*) (void *, void *), void *);
 extern int _obstack_memory_used (struct obstack *);
=20
-void obstack_free (struct obstack *__obstack, void *__block);
+void obstack_free (struct obstack *obstack, void *block);
=20
 =0C
 /* Error handler called when `obstack_chunk_alloc' failed to allocate
@@ -195,9 +195,6 @@ void obstack_free (struct obstack *__obstack, void =
*__block);
    should either abort gracefully or use longjump - but shouldn't
    return.  The default action is to print a message and abort.  */
 extern void (*obstack_alloc_failed_handler) (void);
-
-/* Exit value used when `print_and_abort' is used.  */
-extern int obstack_exit_failure;
 =0C
 /* Pointer to beginning of object being allocated or to be allocated n=
ext.
    Note that this might not be the final address of the object
diff --git a/kwset.c b/kwset.c
index fd4515a..956ae72 100644
--- a/kwset.c
+++ b/kwset.c
@@ -37,7 +37,7 @@
 #include "cache.h"
=20
 #include "kwset.h"
-#include "obstack.h"
+#include "compat/obstack.h"
=20
 #define NCHAR (UCHAR_MAX + 1)
 #define obstack_chunk_alloc xmalloc
--=20
1.7.6.557.gcee4
