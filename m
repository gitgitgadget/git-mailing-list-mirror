From: martin f krafft <madduck@madduck.net>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 17:13:18 +1300
Message-ID: <20100204041318.GD13411@lapse.rw.madduck.net>
References: <20100204013556.GA2590@atcmail.atc.tcs.com>
 <20100204012840.GC497@atcmail.atc.tcs.com>
 <20100204014657.GA10114@lapse.rw.madduck.net>
 <20100204032239.GA5429@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nct61-0000KK-So
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 05:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab0BDENd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 23:13:33 -0500
Received: from clegg.madduck.net ([193.242.105.96]:53383 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab0BDENc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 23:13:32 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id DEC4D1D4099;
	Thu,  4 Feb 2010 05:13:21 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id B9BA73F5; Thu,  4 Feb 2010 17:13:18 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20100204032239.GA5429@atcmail.atc.tcs.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138947>


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1622 +1300]:
> > Wouldn't it thus make sense to check during authentication that
> > the symlink exists and points to the right file, and to deny
> > access completely if that isn't the case?
>=20
> Yeah I guess that's easy enough really... just need to include
> a way to tell the code what is the right file to point to.
> (Currently it's all inside $GL_ADMINDIR but in the APT case that
> may not be true...?)

How about comparing the hash sums of where you think the file is?
This would also ensure that repo access was disallowed if the hook
hasn't been upgraded without symlinks (though I think the symlinks
are still better than copies, and more expressive too). Does that
fit your level of security-paranoia? ;)

About the APT case =E2=80=94 leave that to us. If we distribute gitolite
=66rom /usr/share/gitolite, then we'll probably be patching the entire
source anyway. Obviously, if it proves viable, then it might make
sense to bring back that functionality and have it configurable at
install or runtime.

> This has to work on systems that don't even have bash (like plain
> old sh personality of ksh), leave alone zsh :)
>=20
> Not saying it's hard; just a "find" in backticks.  I'd still
> rather put it inside the perl code somewhere that already gets run
> anyway, as it is now...

No objection.

Thanks!

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
tempt not a desperate man.
                                                -- william shakespeare
=20
spamtraps: madduck.bogus@madduck.net

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktqSV4ACgkQIgvIgzMMSnXWxgCbBpRFE9GrrZQxEpx1x6fBW8Dc
QUcAoJK/YYdNc0GuegRxGYk+ASoFO6e2
=C9GX
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
