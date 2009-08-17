From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 23:23:02 +0200
Message-ID: <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
	 <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
	 <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
	 <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9fd-0001uL-FZ
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbZHQVXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 17:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZHQVXE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:23:04 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51201 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbZHQVXD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 17:23:03 -0400
Received: by bwz22 with SMTP id 22so2566795bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 14:23:03 -0700 (PDT)
Received: by 10.223.143.79 with SMTP id t15mr943903fau.13.1250544182728; Mon, 
	17 Aug 2009 14:23:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126289>

On Mon, Aug 17, 2009 at 11:05 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:
>
>> On Mon, Aug 17, 2009 at 10:43 PM, Reece Dunn<msclrhd@googlemail.com>=
 wrote:
>> > 2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
>> >> On Mon, Aug 17, 2009 at 9:53 PM, Johannes
>> >> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> >>
>> >>> Of course, we could have a script that verifies that the .vcproj
>> >>> files contain reference the appropriate files (which it would kn=
ow
>> >>> about by being called from the Makefile and being passed the fil=
e
>> >>> names), maybe even be able to edit the .vcproj file if it is mis=
sing
>> >>> some. =A0Should not be too hard in Perl.
>> >>
>> >> You'll need to special-case for Visual C++ 2010, which is differe=
nt
>> >> and incompatible with previous versions. Hence my suggestion for
>> >> CMake: appropriate project files would be generated for the tool =
the
>> >> user chooses, be it VC++ 2005, VC++2010, gcc, Borland C++ or anyt=
hing
>> >> else.
>> >
>> > The problem is that you'd still need the Visual Studio projects (o=
ne
>> > each for 6, 7 (2002), 7.1 (2003), 8 (2005), 9 (2008) and 10 (2010)=
 --
>> > yes, there'll need to be one for each version of Visual Studio) as
>> > people who use Visual Studio tend to primarily use the IDE. CMake
>> > (which Windows users will need to download & install from somewher=
e)
>> > will sit outside this -- unless you mean making the project files =
be
>> > the "Makefile project" type and simply use it to invoke CMake and =
host
>> > the source files to ease access to them from the IDE?
>>
>> If a CMake build system is provided, you will not need a single Visu=
al
>> Studio project, or the autotools build system, or anything else. Jus=
t
>> CMake and the CMake build system (which are a bunch of CMakeLists.tx=
t
>> plain text files).
>
> You are putting an undue burden on the already overloaded maintainer.

Sorry, but I'm a bit lost now. What maintainer are we talking about now=
? Junio?

As I would be providing a turn-key CMake build system, the only burden
I would be putting on the maintainer would be learning CMake.

Given that I'm providing a comprehensive (100+ slides) CMake tutorial
( http://www.elpauer.org/stuff/learning_cmake.pdf ) , which I use in
my CMake workshops, I think I'm making that burden a bit lighter.

If the next git conference is somewhere in Europe, I could also fly
there and we'd have a CMake tutorial, if people would feel more
comfortable that way.

> Well, let's see if you can provide a /src/cmake/release.sh that compi=
les
> CMake from scratch, and _then_ I'll look into CMake again.

Again, I'm a bit lost. What '/src/cmake/release.sh' are we talking
about now? Would that be part of CMake or git ?

If you want to build CMake from scratch, you only need to download the
source from http://cmake.org/cmake/resources/software.html , then run
"./bootstrap" in the source directory. That's true for every platform
but Visual C++, which requires you to download a pre-built CMake
binary to build CMake.

If you mean you want to bootstrap git (i. e. download the git tarball,
which would include the CMake sources, then bootstrap CMake, then
build git using the CMake build system), I'd say that makes no sense
at all. That would be like saying you want to include the autotools
sources, the OpenSSL sources, the curl sources, the Subversion
sources, etc in the git tarball. Insane.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
