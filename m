From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 19:40:11 +0100
Message-ID: <45BB9C8B.8020907@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A74BBDB5C0A86A859A5850B"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 19:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAsTc-0006R7-8G
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 19:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbXA0SkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbXA0SkW
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 13:40:22 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:46333 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbXA0SkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 13:40:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 332B1281C6;
	Sat, 27 Jan 2007 19:40:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pGkii80EPk1r; Sat, 27 Jan 2007 19:40:15 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 8EE31281C0;
	Sat, 27 Jan 2007 19:40:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37980>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A74BBDB5C0A86A859A5850B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Sat, 27 Jan 2007, Shawn O. Pearce wrote:
>> _THIS_ is worth doing.  I've been having a lot of discussion on
>> #git with Simon 'corecode' Schubert and Chris Lee about how poorly
>> git-blame performs compared to its counterpart in Subversion.
> I think we're *much* better off trying to get people off the "git-blame=
"=20
> mentality entirely.
>=20
> Don't screw up git in trying to make "git blame" performance better.

Okay, let's try to assume for now that nobody said "git blame".  Instead =
let's say:

git rev-list and git log (with or without -p) perform poorly when invoked=
 with a pathspec.

>    Which implies that with a slow CPU, and a really humongous archive, =
it=20
>    will take much more. Is five seconds slow enough that people think i=
t=20
>    is slow? Yes. Is 30 seconds approaching painful? Yes. But you should=
=20
>    try to aim for really just telling people that it's not a common=20
>    operation.

I agreee with those numbers.  However, on a converted KDE repo, they are =
*completely* different:

git log kdelibs/README takes 1:18.  One minute, eighteen seconds.
git rev-list and git blame take roughly the same time.

This particular file has 64 revisions.  However there are ~ 375000 revisi=
ons in the converted repo.

My and also Shawn's point was not about the speed of git blame itself.  I=
t is about pathspec/rev operations.  The operation time does not scale wi=
th the number of changes to the file/object/call-it-whatever, but with th=
e number of total commits in the branch.

That's what we were getting at.  Not the superiority of git blame (no iro=
ny) and thus reduced speed, but the algorithmic deficiency of any operati=
on on a pathspec/object, which can be easily fixed.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig7A74BBDB5C0A86A859A5850B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu5yNr5S+dk6z85oRAurwAJ41CLc0lmZ0QO/pobuzyoQhY97TgQCfSbV3
qkNWFvLBlb9KEom8ZaPkXJ8=
=lU4w
-----END PGP SIGNATURE-----

--------------enig7A74BBDB5C0A86A859A5850B--
