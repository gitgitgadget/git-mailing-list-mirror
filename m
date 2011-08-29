From: David Aguilar <davvid@gmail.com>
Subject: Re: obstack fails to compile on OS X 10.7
Date: Sun, 28 Aug 2011 20:18:08 -0700
Message-ID: <20110829031806.GA58338@gmail.com>
References: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com>
 <20110827101418.GA8074@gmail.com>
 <20110828200846.GA10754@fredrik-Q430-Q530>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 05:19:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxsO0-0003cc-Va
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 05:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab1H2DSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 23:18:45 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45497 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab1H2DSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 23:18:43 -0400
Received: by pzk37 with SMTP id 37so7704866pzk.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 20:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4dJhXEjA3aOXfhxh51LEC65yCR9e+ODWSGcljA7Mh9Y=;
        b=GfrXbe5nzgNyuegjq4UylgYfdoKwLXoXiKwjPf/0ZpGPUpgrsrssJAsUV8RL2YUw0l
         lYmedDHoDlkqM4HuTX5DSVVLXNczoscaRLVhb0rHfLRKpDn/zPmeusvQVO0Az/a5yfDZ
         C++oV3SuoHLqkMkoPxrTrR1lbwcNjqc9MOO/4=
Received: by 10.142.50.11 with SMTP id x11mr2269025wfx.193.1314587922567;
        Sun, 28 Aug 2011 20:18:42 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id s1sm4563103wfh.8.2011.08.28.20.18.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 20:18:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110828200846.GA10754@fredrik-Q430-Q530>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180292>

On Sun, Aug 28, 2011 at 10:08:46PM +0200, Fredrik Kuivinen wrote:
> On Sat, Aug 27, 2011 at 03:14:43AM -0700, David Aguilar wrote:
> > On Sat, Aug 27, 2011 at 02:21:40AM -0400, Brian Gernhardt wrote:
> > > Some of the errors look like things I could track down, but some =
just confuse me.  If anyone else could take a look into this, it would =
be much appreciated.
> > >=20
> > > ~~ Brian G.
> > >=20
> > > gcc -o compat/obstack.o -c -MF compat/.depend/obstack.o.d -MMD -M=
P  -Wall -Wdeclaration-after-statement -Werror -Wno-deprecated-declarat=
ions -I. -DUSE_ST_TIMESPEC  -DSHA1_HEADER=3D'"block-sha1/sha1.h"'  -DNO=
_MEMMEM  compat/obstack.c
> > > In file included from compat/obstack.c:30:
> > > compat/obstack.h:190: error: __block attribute can be specified o=
n variables only
> > > compat/obstack.c:70: error: expected specifier-qualifier-list bef=
ore =E2=80=98uintmax_t=E2=80=99
> > > compat/obstack.c:111:24: error: exitfail.h: No such file or direc=
tory
> > > cc1: warnings being treated as errors
> > > compat/obstack.c: In function =E2=80=98print_and_abort=E2=80=99:
> > > compat/obstack.c:436: warning: implicit declaration of function =E2=
=80=98gettext=E2=80=99
> > > compat/obstack.c:436: warning: incompatible implicit declaration =
of built-in function =E2=80=98gettext=E2=80=99
> > > compat/obstack.c:438: error: =E2=80=98exit_failure=E2=80=99 undec=
lared (first use in this function)
> > > compat/obstack.c:438: error: (Each undeclared identifier is repor=
ted only once
> > > compat/obstack.c:438: error: for each function it appears in.)
> > > compat/obstack.c:439: warning: =E2=80=98noreturn=E2=80=99 functio=
n does return
> > > make: *** [compat/obstack.o] Error 1
> > >=20
> > > $ gcc --version
> > > i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc.=
 build 5658) (LLVM build 2335.15.00)
> >=20
> > I ran into the same thing.
> >=20
> > This fixes it for me, but we might want to rearrange the
> > #includes a bit.  I think this needs more work.. including
> > compat/obstack.h from kwset.c seems wrong.
> > Should we just include obstack.h in git-compat-util instead?
> >=20
> > I suspect that more exotic platforms may have problems
> > with obstack.h as well.  This probably needs some testing
> > on SunOS, AIX, IRIX, etc.
>=20
>=20
> How about doing something a bit simpler instead and changing obstack.=
c
> to not make use of exit.h and exitfail.h? Then we don't have to updat=
e
> Makefile for all platforms needing NEEDS_OBSTACK and NEEDS_EXITFAIL.

I like this much better.  Less code is better code.

> I don't understand why the ELIDE_CODE check is not sufficient. Care t=
o
> explain?

I can't say I know.  The intention of the check is to avoid
pulling in that section of code when it is already built-in to
the C library.  Maybe that check doesn't quite mean the same
thing when the file is used alone outside of its original
context?

> -void obstack_free (struct obstack *__obstack, void *__block);
> +void obstack_free (struct obstack *obstack, void *block);

Tiny nit: I know it's just a declaration but would it be
advisable to drop the variable names altogether here?
Having a pointer and a structure with the same "obstack"
name could be confusing.

This looks good otherwise.  I was a bit iffy about my patch
when I had to bring in the extra headers.
Doing without them is much better.

I tried your patch on top of my recent
"Improve compiler header dependency check" and it worked fine.

So...
Tested-by: David Aguilar <davvid@gmail.com>
--=20
					David
