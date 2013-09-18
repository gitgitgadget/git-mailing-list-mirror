From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 18 Sep 2013 11:43:11 +0200
Message-ID: <CAHGBnuMh9wqe6mhLyqbPAGJUEEH7cA2LZPuCQK8VD=NU2ix3Pg@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	<xmqqli30idfx.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
	<xmqqhadj1kyo.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMgE1zO4=MnJJXcDLJSD2Vsjptk1x2Bc6CpF9GSxmFp8w@mail.gmail.com>
	<xmqqsix3w27t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 11:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMEI3-0002x9-4k
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 11:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab3IRJnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 05:43:14 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:47336 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab3IRJnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 05:43:13 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so5528629lab.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0cE4jutP83Pz+glvLm4xe5YjD5Hm66wxh+yw/k0aHW0=;
        b=zYtgm8Cq4sy6K6lLrRhOPt+pV5ptr9FdHpQHti0fYItZZjhwPi5PN3jVIky0I5kyVi
         e38T1530FbHyfV+BGvRpwGaUXZzRrxcAUQviMmNio5oykEJ9qYtgNI/A3chYCTz/L+bH
         NSS4YejjjE4YirSJfey2ERfNFBmKGIqGhjyoO0RuxbOziOzJrNYPF3Juxtm1K1xnoFNF
         DV/Il9U72tphharbVdC7VWIFWEEnl3OLy+Nf5qlZfXoyXUwc3on6/dp4z0hNsw42B3do
         l5joX6fZBrnZrjXOmSOz8SfHg1l2o/jWtVau8U5fhFlzQDw3i1eoaFNxu1P4069c86dv
         NvPg==
X-Received: by 10.152.45.106 with SMTP id l10mr34657359lam.12.1379497391667;
 Wed, 18 Sep 2013 02:43:11 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Wed, 18 Sep 2013 02:43:11 -0700 (PDT)
In-Reply-To: <xmqqsix3w27t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234959>

On Tue, Sep 17, 2013 at 11:46 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I don't think people on other platforms seeing the ugliness is really
>> an issue. After all, the file is called git-*compat*-util.h;
>
> Well, judging from the way Linus reacted to the patch, I'd have to
> disagree.  After all, that argument leads to the position that
> nothing is needed in compat/, no?

My feeling is that Linus' reaction was more about that this
work-around is even necessary (and MinGW is buggy) rather than
applying it to git-compat-util.h and not elsewhere.

> One ugliness (lack of sane strcasecmp definition whose address can
> be taken) specific to mingw is worked around in compat/mingw.h, and
> another ugliness that some people may use compilers without include_next
> may need help from another configuration in the Makefile to tell it
> where the platform string.h resides.  I am not sure why you see it
> as a problem.

I just don't like that the ugliness is spreading out and requires a
change to config.mak.uname now, too. Also, I regard the change to
config.mak.uname by itself as ugly, mainly because you would have to
set SYSTEM_STRING_H_HEADER to some path, but that path might differ
from system to system, depending on where MinGW is installed on
Windows.

>> I do insist to avoid GCC-ism in C files,...
>
> To that I tend to agree.  Unconditionally killing inlining for any
> mingw compilation in compat/mingw.h may be the simplest (albeit it
> may be less than optimal) solution.

I tried to put the __NO_INLINE__ stuff in compat/mingw.h but failed,
it involved the need to shuffle includes in git-compat-util.h around
because winsock2.h already seems to include string.h, and I did not
find a working include order. So I came up with the following, do you
like that better?

diff --git a/compat/string_no_inline.h b/compat/string_no_inline.h
new file mode 100644
index 0000000..51eed52
--- /dev/null
+++ b/compat/string_no_inline.h
@@ -0,0 +1,25 @@
+#ifndef STRING_NO_INLINE_H
+#define STRING_NO_INLINE_H
+
+#ifdef __MINGW32__
+#ifdef __NO_INLINE__
+#define __NO_INLINE_ALREADY_DEFINED
+#else
+#define __NO_INLINE__ /* do not inline strcasecmp() */
+#endif
+#endif
+
+#include <string.h>
+#ifdef HAVE_STRINGS_H
+#include <strings.h> /* for strcasecmp() */
+#endif
+
+#ifdef __MINGW32__
+#ifdef __NO_INLINE_ALREADY_DEFINED
+#undef __NO_INLINE_ALREADY_DEFINED
+#else
+#undef __NO_INLINE__
+#endif
+#endif
+
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index db564b7..348dd55 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,8 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1

+#include "compat/string_no_inline.h"
+
 #ifdef WIN32 /* Both MinGW and MSVC */
 #ifndef _WIN32_WINNT
 #define _WIN32_WINNT 0x0502
@@ -101,10 +103,6 @@
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdarg.h>
-#include <string.h>
-#ifdef HAVE_STRINGS_H
-#include <strings.h> /* for strcasecmp() */
-#endif
 #include <errno.h>
 #include <limits.h>
 #ifdef NEEDS_SYS_PARAM_H
-- 
1.8.3.mingw.1.dirty

-- 
Sebastian Schuberth
