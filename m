From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 12:33:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211210270.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org>
 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3Mj-0000Om-M9
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbYAUUeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 15:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbYAUUeR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:34:17 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56465 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751998AbYAUUeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 15:34:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LKXlOV023708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 12:33:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LKXlUh018358;
	Mon, 21 Jan 2008 12:33:47 -0800
In-Reply-To: <373E260A-6786-4932-956A-68706AA7C469@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.423 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71330>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
>=20
> > It's what shows up when you sha1sum, but it's also as simple as wha=
t shows
> > up when you do an "ls -l" and look at a file size.
>=20
> It does? Why on earth should it do that? Filename doesn't contribute =
to the
> listed filesize on OS X.

Umm. What's this inability to see that data is data is data?

Why do you think Unicode has anything in particular to do with filename=
s?

Those same unicode strings are often part of the file data itself, and=20
then that encoding damn well is visible in "ls -l".

Doing

	echo =E4 > file
	ls -l file

sure shows that "underlying octet" thing that you wanted to avoid so mu=
ch.=20
My point was that those underlying octets are always there, and they do=
=20
matter. The fact that the differences may not be visible when you compa=
re=20
the normalized forms doesn't make it any less true.

You can choose to put blinders on and try to claim that normalization i=
s=20
invisible, but it's only invisible TO THOSE THINGS THAT DON'T WANT TO S=
EE=20
IT.

But that doesn't change the fact that a lot of things *do* see it. Ther=
e=20
are very few things that are "Unicode specific", and a *lot* of tools t=
hat=20
are just "general data tools".

And git tries to be a general data tool, not a Unicode-specific one.

> I'm not sure what you mean. The byte sequence is different from Latin=
1 to
> UTF-8 even if you use NFC, so I don't think, in this case, it makes a=
ny
> difference whether you use NFC or NFD.
>
> Yes, the codepoints are the same in Latin1 and UTF-8 if you use NFC, =
but=20
> that's hardly relevant. Please correct me if I'm wrong, but I believe=
=20
> Latin1->UTF-8->Latin1 conversion will always produce the same Latin1=20
> text whether you use NFC or NFD.

The problem is that the UTF-8 form is different, so if you save things =
in=20
UTF-8 (which we hopefully agree is a sane thing to do), then you should=
=20
try to use a representation that people agree on.

And NFC is the more common normalization form by far, so by normalizing=
 to=20
something else, you actually de-normalize as far as those other people =
are=20
concerned.

So if you have to normalize, at least use the normal form!

> The only reason it's particularly inconvenient is because it's differ=
ent from
> what most other systems picked. And if you want to blame someone for =
that,
> blame Unicode for having so many different normalization forms.

I blame them for encouraging normalization at all.

It's stupid.

You don't need it.

The people who care about "are these strings equivalent" shouldn't do a=
=20
"memcmp()" on them in the first place. And if you don't do a memcmp() o=
n=20
things, then you don't need to normalize.=20

So you have two cases:
 (a) the cases that care about *identity*. They don't want normalizatio=
n
 (b) the cases that care about *equivalence*. And they shouldn't do=20
      octet-by-octet comparison.

See? Either you want to see equivalence, or you don't. And in neither c=
ase=20
is normalization the right thing to do (except as *possibly* an interna=
l=20
part of the comparison, but there are actually better ways to check for=
=20
equivalence than the brute-force "normalize both and compare results=20
bitwise").

			Linus
