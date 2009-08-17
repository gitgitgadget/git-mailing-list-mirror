From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 22:54:26 +0200
Message-ID: <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
	 <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9Dy-00064M-Do
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbZHQUy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 16:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757985AbZHQUy1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:54:27 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:64366 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbZHQUy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 16:54:27 -0400
Received: by bwz22 with SMTP id 22so2553439bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:54:27 -0700 (PDT)
Received: by 10.223.4.204 with SMTP id 12mr950688fas.55.1250542467025; Mon, 17 
	Aug 2009 13:54:27 -0700 (PDT)
In-Reply-To: <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126278>

On Mon, Aug 17, 2009 at 10:43 PM, Reece Dunn<msclrhd@googlemail.com> wr=
ote:
> 2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
>> On Mon, Aug 17, 2009 at 9:53 PM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>
>>> Of course, we could have a script that verifies that the .vcproj fi=
les
>>> contain reference the appropriate files (which it would know about =
by
>>> being called from the Makefile and being passed the file names), ma=
ybe
>>> even be able to edit the .vcproj file if it is missing some. =A0Sho=
uld not
>>> be too hard in Perl.
>>
>> You'll need to special-case for Visual C++ 2010, which is different
>> and incompatible with previous versions. Hence my suggestion for
>> CMake: appropriate project files would be generated for the tool the
>> user chooses, be it VC++ 2005, VC++2010, gcc, Borland C++ or anythin=
g
>> else.
>
> The problem is that you'd still need the Visual Studio projects (one
> each for 6, 7 (2002), 7.1 (2003), 8 (2005), 9 (2008) and 10 (2010) --
> yes, there'll need to be one for each version of Visual Studio) as
> people who use Visual Studio tend to primarily use the IDE. CMake
> (which Windows users will need to download & install from somewhere)
> will sit outside this -- unless you mean making the project files be
> the "Makefile project" type and simply use it to invoke CMake and hos=
t
> the source files to ease access to them from the IDE?

If a CMake build system is provided, you will not need a single Visual
Studio project, or the autotools build system, or anything else. Just
CMake and the CMake build system (which are a bunch of CMakeLists.txt
plain text files).

CMake takes the CMakeLists.txt file(s) as the input and generates
makefiles for gcc, vcproj files for Visual C++, makefiles for NMake,
Eclipse projects for Eclipse, XCode projects for XCode, etc.

> Also, not every posix system will have CMake installed (e.g. Linux
> From Scratch systems) and that's not including "exotic" systems like
> Solaris and the *BSDs.

CMake is available for many platforms (Linux x86-32 and x86-64, PPC,
Solaris Sparc, HP-UX, Irix, AIX PPC) as a binary from the CMake site (
http://cmake.org/cmake/resources/software.html ) and as source for the
rest.

*BSD? It is available in the ports section (and maybe as a binary,
too) in FreeBSD(
http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/cmake/ ), NetBSD and
OpenBSD.

Linux from scratch? If people are brave enough to build and use LFS,
they are brave enough to build CMake (CMake is autocontained and
bootstraps itself, it only depends on a C++ compiler to build itself).

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
