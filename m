From: martin f krafft <madduck@madduck.net>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 14:46:57 +1300
Message-ID: <20100204014657.GA10114@lapse.rw.madduck.net>
References: <20100204013556.GA2590@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcqoT-0006xW-Sa
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab0BDBrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:47:16 -0500
Received: from clegg.madduck.net ([193.242.105.96]:52908 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0BDBrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:47:13 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id A7EB81D4099;
	Thu,  4 Feb 2010 02:47:00 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 4C6942A5; Thu,  4 Feb 2010 14:46:57 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20100204013556.GA2590@atcmail.atc.tcs.com>
 <20100204012840.GC497@atcmail.atc.tcs.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138928>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1428 +1300]:
> I'm ok with symlinking stuff; a couple of "cp" commands
> would change to "ln" :)  Let me try it out (and make sure it
> works for upgrades also...)

ln -sf even.



also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1435 +1300]:
> I forgot... part of the reason this "copy all hooks over each time
> you run install" is also to give people an easy way to update the
> hooks when the repo was *copied* from elsewhere, and not *created*
> by gitolite in the first place.
>=20
> Basically I'm paranoid about that "update" hook, without which the
> branch level access control doesn't work at all.

Wouldn't it thus make sense to check during authentication that the
symlink exists and points to the right file, and to deny access
completely if that isn't the case?

> So this will still need to be done. Or you'll have to provide some
> other command that will sweep through all repos in the $REPO_BASE
> and check that the symlink is pointing to the right place etc etc.

Having a mass-update command for this might be nice, but I suppose
it's also a trivial shell one-liner...

  for i (**/*.git/hooks/update) \
    ln -sf ~git/.gitolite/src/hooks/update $i

(this is zsh, not sure bash can do this yet)

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
apt-get source --compile gentoo
=20
spamtraps: madduck.bogus@madduck.net

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktqJxEACgkQIgvIgzMMSnVGHwCg1xvCgupNjLqtHJ5ICnCPzMP9
H88AoMLvNOsQoJ54+jnrqrD21iOZubRJ
=8raM
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
