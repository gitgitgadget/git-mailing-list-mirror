From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 11:11:27 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFa9i-0006cG-6Y
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbYAQTLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 14:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYAQTLd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:11:33 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42093 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752739AbYAQTLc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 14:11:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HJBSBe021902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 11:11:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HJBRgM008070;
	Thu, 17 Jan 2008 11:11:27 -0800
In-Reply-To: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70907>



On Thu, 17 Jan 2008, Pedro Melo wrote:
>
> We have people using windows, people using Macs, and people using sev=
eral
> flavors of Linux desktops. They all have different settings and if I =
add a
> file like =E1=E9i=F3=FA that happens to be UTF-8 encoded, it will rea=
ch a iso-latin-1
> user as visual garbage.

Yes.

> git will track the file perfectly, we know that, because the sequence=
 of=20
> bytes that my system used to create the file will be the same on all=20
> "sane" systems, but the file will look "funny" to some users, and we =
get=20
> complaints for some less enlightened ones.

I can't really suggest anything else than trying to make everybody use=20
UTF-8.

[ Not just for filenames, by the way - this is one of the reasons I thi=
nk
  it is so *important* to not corrupt filenames, exactly because this i=
s=20
  in no way filename-specific at all, and filenames are generally "text=
ual=20
  data" exactly the same way a text-file is.

  But only totally insane people think that you should force-normalize=20
  text-files, even though all the issues are obviously all the same=20
  regardless of whether it's a filename or a word in textfile. ]

And yes, I also realize that it's not going to be realistic. We're=20
probably *closer* to that than we used to be, but I don't think you can=
=20
even make Windows think FAT is UTF-8.

I don't know how NTFS works (I know it is Unicode-aware, and I think it=
=20
encodes filenames in UCS-2 or possibly UTF-16, but there is an obvious =
1:1=20
translation to UTF-8, and since we use C strings, I'd assume/hope Windo=
ws=20
actually uses that unambiguous translation for any filenames).

Under modern Linux and OS X, UTF-8 is basically the only way (older Lin=
ux=20
distros may be set up for Latin1, but at least the newer ones seem to a=
ll=20
default to a UTF-8 locale).

> The answer is that users should not create filenames with non-ascii c=
haracters
> if they want a consistent experience, right?

Oh, absolutely. That takes care of 99.9% of all source projects. Even t=
hen=20
you can have problems with case insensitivity (the Linux kernel sources=
=20
are all US-ASCII filenames, for example, but *literally* has many files=
=20
that are identical if you ignore case, and that's not unheard of).

So yes, to a first approximation, the answer is to simply avoid using=20
anything but US-ASCII. It's seldom a big limitation when talking about=20
filenames.

			Linus
