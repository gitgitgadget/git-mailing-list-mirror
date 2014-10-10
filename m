From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Fri, 10 Oct 2014 08:38:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410100809450.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-8-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info> <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
 <alpine.DEB.1.00.1410092146310.990@s15462909.onlinehome-server.info> <CAOYw7dtouon0EXYQPnvpc7ZMARKwaureNTK6ZL+aByknpPG-9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    gitster@pobox.com, msysGit <msysgit@googlegroups.com>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB3X53WQQKGQEJEAWPTI@googlegroups.com Fri Oct 10 08:38:40 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB3X53WQQKGQEJEAWPTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB3X53WQQKGQEJEAWPTI@googlegroups.com>)
	id 1XcTqZ-0000Cq-Sy
	for gcvm-msysgit@m.gmane.org; Fri, 10 Oct 2014 08:38:39 +0200
Received: by mail-wi0-f190.google.com with SMTP id ho1sf80320wib.27
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=02GqRZops4ZrJR4YdUFVG7tEr5ULYjYjfAYcRNCNTWo=;
        b=Y7b74Akza80UU2H9SL/9ILZMpVsN0Ci9kP1N1kuhdCrqXTzUavpcJIc1sTyTV/wRLS
         MhpCGJ4zDgSZJqI6qdFqY2JOKBcMogGGbZrAd50ajHcV2GbeAple0oVI/d6quXLihkCD
         ssm9sVnQfbJ1lTrsBAv+7M+Yl5VhhQM+l6gxYfPBxM0k9tU1CJDGK+YoWzs3+I0mUUiG
         yhlhtQJkXufWag7ErGK8YsiqOKaTFwxdNDrWHsKJdskhkBEpIBwPxhJm6paScUx6nz8T
         czE4r7mz1jeW5fnOUCsEhX8FNFlVEWWuKWcux/MX9Nq2QGGSppZSb50hYpz73vNtNVOh
         nJDA==
X-Received: by 10.152.18.137 with SMTP id w9mr5625lad.7.1412923119591;
        Thu, 09 Oct 2014 23:38:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.206.72 with SMTP id lm8ls246763lac.9.gmail; Thu, 09 Oct
 2014 23:38:37 -0700 (PDT)
X-Received: by 10.112.145.136 with SMTP id su8mr515556lbb.9.1412923117801;
        Thu, 09 Oct 2014 23:38:37 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id us10si157286lbc.1.2014.10.09.23.38.37
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 23:38:37 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MbPLI-1XsuEH431Q-00IpFu;
 Fri, 10 Oct 2014 08:38:10 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAOYw7dtouon0EXYQPnvpc7ZMARKwaureNTK6ZL+aByknpPG-9A@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ASr2KZwnW9ywDRUyzx5J3rv0CwKNkd5EyXBry8KITYcJ0vR49uI
 36odq7VYH97XOXPR2fzK5Fqi4LBilTnkDhOKmggpa93nUhvTwJEn2Dh5UXdeBxiBfjWP9/T
 5WhAmzz00REnruNEMlOlXciDQw/whiSZClgm0sAWmEpv184+15HbAO8akzB98q4ng9LYHYh
 sFMABaPKpXL48YaB1TUQg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Hi Ray,

On Fri, 10 Oct 2014, Ray Donnelly wrote:

> On Thu, Oct 9, 2014 at 8:47 PM, Johannes Schindelin <
> Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 9 Oct 2014, Ray Donnelly wrote:
> >
> >> On Thu, Oct 9, 2014 at 8:22 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >
> >> > On Wed, 8 Oct 2014, Marat Radchenko wrote:
> >> >
> >> >> +CC_MACH :=3D $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo
> not')
> >> >
> >> > There is a rather huge problem with that. The latest mingw-w64
> >> > release, 4.9.1, does not do what you expect here: while
> >> > '.../mingw32/bin/gcc -m32 -o 32.exe test.c' and
> >> > '.../mingw32/bin/gcc -m64 -o 64.exe test.c' work fine, producing
> >> > i686 and x86_64 executables respectively, '.../mingw32/bin/gcc
> >> > -dumpmachine' prints i686-w64-mingw32 *always*, even when
> >> > specifying the -m64 option.
> >> >
> >> > So unfortunately, the test introduced by this patch (intended to
> >> > figure out whether the build targets i686, and skip a compiler and
> >> > a linker option otherwise) is incorrect.
> >>
> >> Which release are you talking about? Can you point me to the tarball
> >> please?
> >
> http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%2=
0Win32/Personal%20Builds/mingw-builds/4.9.1/threads-win32/sjlj/
> >
> > (rev1, not rev0)
>=20
> I guess I can add passing in CFLAGS also to try to catch that case.

Well, my tests say that the CFLAGS do *not* change the behavior of
-dumpmachine. IOW `i686-w64-mingw32-gcc -m64 -dumpmachine` *still* spits
out i686-w64-mingw32. Even if the -m64 flag would cause the compiler to
generate 64-bit binaries.

> I've added support to build using your branch to MSYS2's MINGW-packages
> git-git package in case anyone wants to help out:
>=20
> https://github.com/Alexpux/MINGW-packages/tree/master/mingw-w64-git-git

Interesting.

With Git for Windows, we aim to become waaaaay more standards-compliant by
providing Git as a regular mingw-get'able package. To this end, we use
mgwport recipes to build the required packages.

It looks as if the PKGBUILD system is similar, but *just* incompatible
enough with mgwport to prevent code sharing. Is this fixable?

> Change _based_on_dscho_w64_msysgit=3Dno to =3Dyes. Note also that some mo=
re
> patches are needed before we can build, and I think more are needed.
> Using plain msysGit (I.e. =3Dno) and 15 patches we are able to build a
> somewhat functional git.

So here is my plan, please let me know whether you think we can compromise
on a strategy that benefits both of us:

Since I want mingw-get'able packages =E2=80=93 also for 64-bit =E2=80=93 I =
would like to
keep the CPU architecture dependent parts as contained as possible and use
only one package system for both. Likewise, I would really prefer to have
a single development environment for both architectures, and the Git for
Windows SDK is really coming along nicely, thanks to the tremendous
efforts put in by Thomas Braun and Sebastian Schuberth.

I am planning, therefore, to provide the MinGW-w64 compiler as an add-on
package that needs to be installed in order to build 64-bit stuff.

At this stage, it is actually *more* than a plan: I already have a package
to install 7za =E2=80=93 required to unpack MinGW-w64 pre-built packages =
=E2=80=93 and the
script to package mingw-w64 is in the process of being fleshed out.

With this compiler, and the 'w64' branch from https://github.com/dscho/git
=E2=80=93 intended to be merged into https://github.com/git-for-windows/git=
 =E2=80=93 the
following command-line produces 64-bit Git:

	PATH=3D/path/to/unpacked/mingw-w64/mingw64/bin/:$PATH \
	make \
		CROSS_COMPILE=3Dx86_64-w64-mingw32- CC=3D'$(CROSS_COMPILE)gcc' \
		AR=3Dar RC=3Dwindres \
		NO_ICONV=3D1 NO_OPENSSL=3D1 NO_CURL=3D1 NEEDS_LIBICONV=3D USE_LIBPCRE=3D

The test suite passes so far (still running, at the time of writing it is
going through t3404).

Ciao,
Johannes

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
