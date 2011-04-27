From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 19:59:33 +1000
Message-ID: <BANLkTi=UCGkQaOF7c0Ks6315gygacMzfyQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
	<BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
	<4DB7CC7C.2050508@drmicha.warpmail.net>
	<BANLkTinrU8LhA0RORde0e5a1TM5VB5gVNQ@mail.gmail.com>
	<BANLkTik8+ECdRsq19xUi1HzTnKoayvLOSw@mail.gmail.com>
	<20110427093627.GH2709@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Motiejus_Jak=C5=A1tys?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1X2-0006J2-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab1D0J7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 05:59:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51864 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab1D0J7e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 05:59:34 -0400
Received: by vws1 with SMTP id 1so1155732vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ABSvZy9+3ZT6BOFPu8/M5kOm2JIi3RbmdczbHqSOtnY=;
        b=LkXGNscYQ4K+b+5Q8ghYyC4l8KHCWmcHM9oO3WLcPG7yJqGccy0Hkbj/+ZVxM5Zykn
         nO3vObH2Al62CFPKfBPetZX+PdPKqQTvctVzFTHeVq6yTM6VVyHeGwn8bd/MIY8/kkPo
         ofVG7jLUrxLxBOC1uAwxogpJxFG++W91sAJTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NgOelP1QvFN+sdhL5oJXpjpZYfz93Ds1sX1sTsbWjVHelNCWh6qgwqlMWD5wB85umx
         kR3tAdneUBWdvCG+rhuJBJPYxiLF8xm7YYIoYpOxJgSoXQJIPJ7NUDkARnlRzsveQ6zT
         H5NrElqp7VMorsYICLuMfPDY3VOv8pHHs/iwk=
Received: by 10.52.180.164 with SMTP id dp4mr972391vdc.119.1303898373184; Wed,
 27 Apr 2011 02:59:33 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 02:59:33 -0700 (PDT)
In-Reply-To: <20110427093627.GH2709@jakstys.lt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172210>

2011/4/27 Motiejus Jak=C5=A1tys <desired.mta@gmail.com>:
> On Wed, Apr 27, 2011 at 06:40:07PM +1000, Jon Seymour wrote:
>> On Wed, Apr 27, 2011 at 6:15 PM, Jon Seymour <jon.seymour@gmail.com>=
 wrote:
>> > On Wed, Apr 27, 2011 at 5:57 PM, Michael J Gruber
>> > <git@drmicha.warpmail.net> wrote:
>> >
>> The idea would be to maintain a registry of "git package descriptors=
".
>> The descriptors would be a copy of the whatever descriptor an
>> activated package would be described by, but probably simply a git
>> config text file, since we already have the tools to parse those.
>>
>> Such a descriptor would have hints about how to use a real package
>> manager to get the actual package, but would not actually contain an=
y
>> files from the package itself.
>
>>
>> So, for example, the package source might be bundled in git-core
>> contrib/ directory, fetchable as a git repo, fetchable as a tar ball=
,
>> fetchable as an apt-get package, as brew package etc. The idea is th=
at
>> gpm would know enough about invoking a real package manager to handl=
e
>> the actual distribution details.
>
> Let me check If I get this right:
> Say I am a maintainer of enchanced git log -- git logx. It is one .c
> file, which has to be simply compiled (cc -o git-logx logx.c).
>
> If I want to maintain the package in a way you are suggesting, I have=
 to
> prepare deb, rpm, tarball, zipball, brew (what ever it is, sorry for
> non-intelligence) and what not. Otherwise, I lose users? *ball is not
> an option, since we are supporting different architectures and cannot
> distribute compiled files (unless statically compiled for all
> architectures we know, which is not good for obvious reasons).
>
> Morevoer, different debs for different debian releases (if package
> depends on libc version)?
>
> Although this looks very nice from user point of view, it would be a
> pain for the extension maintainer... Though it's only one C file.
>

I don't see why. You wouldn't be forced to maintain one of those
packages, anymore than you
are now. If you can, you just publish a git url, and your job is done.
If your tool requires
compilation, you have already solved the distribution problem for the
package managers you choose to support.

All I am suggesting you do is that you list pointers to these
packages, which gpm could then use to actually do the installation for
you.

The thing I really care about is: once the package has been installed
locally, how do I activate it and makes its features available to the
git runtime, without having to futz around with my PATH, MANPATH etc?

Yes, this is user focused. I want users of my tool to be able to someth=
ing like:

   git pm install gitwork

or perhaps:

   git pm install git://github.com/jonseymour/gitwork

And then start using it. I want the git completions to be there, I
want the man pages to be there. I want the scripts to be
there. In my case, there I really shouldn't have to do anything other
than point at a git url, get the package transported
to a local directory and activate it.

I want to tell my users what they need to do to install my extension
without having to have variants of the instructions for zip/tar
people, apt-get people, brew people, MAC ports people, yum people etc.
Yes, for compiled stuff, someone has to prepare the packages. But once
they are prepared, use whatever package manager the user uses to
install it and expose the gpm config required to activate it.

> I think shipping it in contrib/ and having extension system is a bett=
er
> option. Though it leaves a hole for dependencies -- if my logx depend=
s
> on boost or imagemagick, we don't want make git depend on it...
>

Unless I am misunderstanding something about how contrib/ is managed
that still requires Junio to be in the loop, which defeats one of my
objectives here - which is to allow anyone to contribute and share
their own extensions without being bottlenecked by someone else's
release cycle.

jon.
