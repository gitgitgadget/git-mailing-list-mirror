From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [NOT_A_PATCH] A naive attempt to cross-build
 Linux->mingw64 Git
Date: Mon, 21 Apr 2014 19:06:24 -0500
Message-ID: <5355b2807a10c_1d5ab792ecfd@nysa.notmuch>
References: <535569e92cbcc_32c48493101f@nysa.notmuch>
 <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
 <5355b0ce562b8_6c39e772f0cb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marat Radchenko <marat@slonopotamus.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Sebastian Schuberth <sschuberth@gmail.com>, 
 Heiko Voigt <hvoigt@hvoigt.net>, 
 git@vger.kernel.org, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, 
 Marat Radchenko <marat@slonopotamus.org>, 
 Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBB37J22NAKGQEKXJ4JQQ@googlegroups.com Tue Apr 22 02:16:50 2014
Return-path: <msysgit+bncBDBJVMGGZYNBB37J22NAKGQEKXJ4JQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f185.google.com ([209.85.192.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBB37J22NAKGQEKXJ4JQQ@googlegroups.com>)
	id 1WcOOG-0004hF-RY
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 02:16:49 +0200
Received: by mail-pd0-f185.google.com with SMTP id y13sf1289607pdi.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Apr 2014 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=yar94VLWJTjd513Lb4tDJ/ubWLOj/kEbj15rnkWzi3g=;
        b=LVKAq7UwYFZNhG0q535PXOGczxrWH+INvOAzK4gQirzosLJml9atiT75FUfMypGFoB
         QkFsvpfPhD1x3LZcC3lZoJCV/mfXJZUGjeAiNz2wSY+jtpIPUaKU59DWog3QhxpjQr6/
         SbdK+RuIMvexc1iyAYzh7+oWYPTFSKPL18bHzXwLFfJ3FwJwriwExJn7NkbfodWlvwOO
         Ne4+ZnJgIDn3NEq+GkOp+bDLQG/sGNqzigE9Ni5r1t8rTnnbPo9UAEmkNP6KSs31YleX
         TtZeLOEQqGqdjL2td68AJll1htbvWqjsUQR+bzTFVywiUrStImhrAk9/olZpckgDQxNV
         73GA==
X-Received: by 10.140.44.75 with SMTP id f69mr101163qga.11.1398125807763;
        Mon, 21 Apr 2014 17:16:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.88.72 with SMTP id s66ls2723875qgd.11.gmail; Mon, 21 Apr
 2014 17:16:47 -0700 (PDT)
X-Received: by 10.236.144.136 with SMTP id n8mr18706701yhj.22.1398125807281;
        Mon, 21 Apr 2014 17:16:47 -0700 (PDT)
Received: from mail-oa0-x22f.google.com (mail-oa0-x22f.google.com [2607:f8b0:4003:c02::22f])
        by gmr-mx.google.com with ESMTPS id rg8si441521igc.0.2014.04.21.17.16.47
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 17:16:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c02::22f as permitted sender) client-ip=2607:f8b0:4003:c02::22f;
Received: by mail-oa0-x22f.google.com with SMTP id i11so4910846oag.20
        for <msysgit@googlegroups.com>; Mon, 21 Apr 2014 17:16:47 -0700 (PDT)
X-Received: by 10.182.205.135 with SMTP id lg7mr30008807obc.32.1398125807032;
        Mon, 21 Apr 2014 17:16:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h1sm3412763obr.15.2014.04.21.17.16.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 17:16:46 -0700 (PDT)
In-Reply-To: <5355b0ce562b8_6c39e772f0cb@nysa.notmuch>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c02::22f as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246680>

Felipe Contreras wrote:
> Marat Radchenko wrote:
> > 4. Observe errors [1]
> 
> I see those errors with a 64-bit compiler, but not with the old 32-bit one.
> 
> > I would be happy to find out I'm doing something wrong -- Johannes says building
> > mingw64 Git is dirt-easy.
> 
> I get the same error. I've been cross-compiling since basically all my
> professional life, so I don't think you are doing something wrong, it just
> doesn't work.

I managed to fix all the errors, some apply to newer mingw, regardless of 32 or
64, others are specific to 64-bit. It's all hacky and I haven't checked if it
runs, but at least it compiles (mostly).

diff --git a/compat/bswap.h b/compat/bswap.h
index 5061214..285d89c 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -5,6 +5,8 @@
  * operation.
  */
 
+#include <stdint.h>
+
 /*
  * Default version that the compiler ought to optimize properly with
  * constant values.
diff --git a/compat/mingw.h b/compat/mingw.h
index e033e72..9274b64 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -5,7 +5,6 @@
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
 #define hstrerror strerror
@@ -90,8 +89,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
-static inline pid_t fork(void)
-{ errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
@@ -261,12 +258,6 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 	return 0;
 }
 
-/*
- * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
- */
-#define off_t off64_t
-#define lseek _lseeki64
-
 /* use struct stat with 64 bit st_size */
 #ifdef stat
 #undef stat
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..3e4affd 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -720,6 +720,7 @@ struct mallinfo {
   inlining are defined as macros, so these aren't used for them.
 */
 
+#undef FORCEINLINE
 #ifndef FORCEINLINE
   #if defined(__GNUC__)
 #define FORCEINLINE __inline __attribute__ ((always_inline))
@@ -1352,58 +1353,6 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
 #ifndef __MINGW32__
 #pragma intrinsic (_InterlockedCompareExchange)
 #pragma intrinsic (_InterlockedExchange)
-#else
-  /* --[ start GCC compatibility ]----------------------------------------------
-   * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
-   * Microsoft Visual C++ functions. Originally developed for the ReactOS
-   * (<http://www.reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
-   * projects.
-   *
-   * Copyright (c) 2006 KJK::Hyperion <hackbunny@reactos.com>
-   *
-   * Permission is hereby granted, free of charge, to any person obtaining a
-   * copy of this software and associated documentation files (the "Software"),
-   * to deal in the Software without restriction, including without limitation
-   * the rights to use, copy, modify, merge, publish, distribute, sublicense,
-   * and/or sell copies of the Software, and to permit persons to whom the
-   * Software is furnished to do so, subject to the following conditions:
-   *
-   * The above copyright notice and this permission notice shall be included in
-   * all copies or substantial portions of the Software.
-   *
-   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-   * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-   * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-   * DEALINGS IN THE SOFTWARE.
-   */
-
-  /*** Atomic operations ***/
-  #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
-    #define _ReadWriteBarrier() __sync_synchronize()
-  #else
-    static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
-    {
-      long res;
-      __asm__ __volatile__("xchg%z0 %2, %0" : "=g" (*(Target)), "=r" (res) : "1" (Value));
-      return res;
-    }
-    static void __inline__ __attribute__((always_inline)) _MemoryBarrier(void)
-    {
-      __asm__ __volatile__("" : : : "memory");
-    }
-    #define _ReadWriteBarrier() _MemoryBarrier()
-  #endif
-  /* BUGBUG: GCC only supports full barriers */
-  static __inline__ __attribute__((always_inline)) long _InterlockedExchange(volatile long * const Target, const long Value)
-  {
-    /* NOTE: __sync_lock_test_and_set would be an acquire barrier, so we force a full barrier */
-    _ReadWriteBarrier();
-    return __sync_lock_test_and_set(Target, Value);
-  }
-  /* --[ end GCC compatibility ]---------------------------------------------- */
 #endif
 #define interlockedcompareexchange _InterlockedCompareExchange
 #define interlockedexchange _InterlockedExchange
diff --git a/config.mak.uname b/config.mak.uname
index efaed94..01acd54 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -13,6 +13,11 @@ ifdef MSVC
 	uname_O := Windows
 endif
 
+ifdef MINGW
+	uname_S := MINGW
+	uname_O := MINGW
+endif
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
@@ -508,7 +513,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \

-- 
Felipe Contreras

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
