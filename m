From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Thu, 11 Dec 2008 16:45:05 -0600
Message-ID: <200812111645.10067.bss03@volumehost.net>
References: <ghop5d$qud$1@ger.gmane.org> <200812111051.20322.bss03@volumehost.net> <20081211215554.GA11565@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4185108.3rWkuGVSiy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAuK0-0002it-P8
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbYLKWqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYLKWqf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:46:35 -0500
Received: from ispmxmta06-srv.windstream.net ([166.102.165.167]:55747 "EHLO
	ispmxmta06-srv.windstream.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750767AbYLKWqe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 17:46:34 -0500
Received: from ispmxaamta08-gx.windstream.net ([166.102.154.15])
          by ispmxmta06-srv.windstream.net with ESMTP
          id <20081211224633.PYAC22277.ispmxmta06-srv.windstream.net@ispmxaamta08-gx.windstream.net>
          for <git@vger.kernel.org>; Thu, 11 Dec 2008 16:46:33 -0600
Received: from [192.168.1.123] (really [166.102.154.15])
          by ispmxaamta08-gx.windstream.net with ESMTP
          id <20081211224633.JWZR28131.ispmxaamta08-gx.windstream.net@[192.168.1.123]>;
          Thu, 11 Dec 2008 16:46:33 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <20081211215554.GA11565@sigill.intra.peff.net>
X-Cloudmark-Analysis: v=1.0 c=1 a=4x8eZqvhE5cA:10 a=cCwArZ2WySYA:10 a=imw7DGXsOz1VfKdyG2U9cg==:17 a=nEQGfrJnAAAA:8 a=jxldzrcGuEAmsuxgjGUA:9 a=Bwd1T9XZwgvy7Em1jgXbBG7jYUQA:4 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=upjked_cvJ3JbLUdLQUA:9 a=sxM_p3bnpGgwGnOCxWxLZWQzV4AA:4 a=rPt6xJ-oxjAA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102836>

--nextPart4185108.3rWkuGVSiy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2008 December 11 15:55:55 Jeff King wrote:
>On Thu, Dec 11, 2008 at 10:51:15AM -0600, Boyd Stephen Smith Jr. wrote:
>> Initially, I was looking for 'stdout' or 'stderr', and found many
>> unrelated commits.  I then figured it was part of the PAGER support, and
>> began
>
>Try looking for isatty, which takes the numeric fd. I think the behavior
>you asked about would be this:

Thanks, this will be plenty of context for me to be able to crawl the archi=
ves=20
and the actual history thinking about better behavior and considering old=20
discussions.

>We are not talking about
>interactivity, but rather about where the output is going. So your test
>would consider this interactive:
>
>  $ git log >foo.out
>
>and start a pager, which makes no sense.

Good point, I'll try and consider that while I investgate the history of th=
e=20
issue.

>Now if you proposed checking stderr and stdin _in addition_ to stdout,
>that might make more sense, but I haven't thought too hard about any
>implications.

I did see a commit message mentioning some unusual settings for PAGER, but =
in=20
general, pagers are interactive.  I'd think the default behavior would=20
be "interactive <-> pager", with a config option to turn the pager always o=
ff=20
or always on.  From there, I would reason the test for interactivity should=
=20
be the POSIX test.

It looks like this test have have been attempting to follow the behavior=20
of --color=3Dauto to GNU less and GNU grep (and possibly others).  This=20
certainly makes some sense as well, and may be less surprising.

>And FWIW, I don't recall this ever being discussed before, but then I
>have not been involved with git since the very beginning.

Google should be able to find it.  And worst-case, I can tell wget to spide=
r=20
the archives and then run some sort of find/html2txt/grep on them.

I'll go back to "the stacks" and read the discussions and commits.  If my=20
well-informed self still thinks the behavior should change, I'll write a=20
patch and open up the discussion again.
=2D-=20
Boyd Stephen Smith Jr. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ,=3D ,-_-. =3D.=20
bss03@volumehost.net =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 `-'(. .=
)`-'=20
http://iguanasuicide.org/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\_/ =C2=A0 =C2=A0=20

--nextPart4185108.3rWkuGVSiy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklBl/YACgkQdNbfk+86fC2K3wCfejiQ1Gl9idpEInGM54i9UVtf
LuAAnjibye9DZ73qBILUKIZwtc6piiWi
=ND6I
-----END PGP SIGNATURE-----

--nextPart4185108.3rWkuGVSiy--
