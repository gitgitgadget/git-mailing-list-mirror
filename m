From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying
	remote branches
Date: Fri, 13 Feb 2009 07:47:07 +0100
Message-ID: <20090213064707.GA17681@piper.oerlikon.madduck.net>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org> <1234503271-78569-1-git-send-email-jaysoffian@gmail.com> <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
To: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 07:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXrr5-0002gf-5Z
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbZBMGr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 01:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbZBMGr0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:47:26 -0500
Received: from clegg.madduck.net ([193.242.105.96]:41405 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZBMGrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 01:47:25 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 154D71D409B;
	Fri, 13 Feb 2009 07:47:09 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 30AC99F13D;
	Fri, 13 Feb 2009 07:47:08 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id C32FD4464; Fri, 13 Feb 2009 07:47:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8985/Thu Feb 12 23:11:57 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109714>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2009.02.13.0735 +0100]:
> Once you start making each case arm do more things, it might make sense to
> rewrite the above unrolled loop into something like this:
[...]
> 	} ref_kind[] =3D {
>         	{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
>         	{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
> 	};
[...]

> Then we can later add new elements more easily, e.g.
>=20
>                 { REF_TOPGIT_BASE, "refs/top-base/", 14 },

As soon as TopGit is integrated into Git proper, this could make
sense. However, I don't know when this will happen. In the mean
time, hardcoding extensions like you suggest might not scale too
well. Wouldn't it make more sense to provide an interface that
allowed tools to register their own namespaces, and handle those
appropriately within Git?

Much of that handling could be taken straight from refs/remotes/*,
as they are conceptually the same. refs/remotes/* just has
additional treatment inside Git, because it's part of the basic
feature set. An external feature's namespace wouldn't be, but Git
also doesn't need to know anything about those, or treat them
specially.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"doesn't he know who i think i am?"
                                                     -- phil collins
=20
spamtraps: madduck.bogus@madduck.net

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmVF2sACgkQIgvIgzMMSnXEHQCfYu3RYm39eVU49KKurf+kRD94
CNEAoJgz9m5d9VdIaXSG3XuHdfDPA3VH
=DSQR
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
