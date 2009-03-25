From: martin f krafft <madduck@debian.org>
Subject: Re: [TopGit PATCH] hooks/pre-commit.sh: fix it again
Date: Wed, 25 Mar 2009 13:17:21 +0100
Organization: The Debian project
Message-ID: <20090325121721.GB13065@lapse.rw.madduck.net>
References: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	u.kleine-koenig@pengutronix.de
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmbEL-0006oO-Vg
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317AbZCYWCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 18:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755124AbZCYWCf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 18:02:35 -0400
Received: from clegg.madduck.net ([193.242.105.96]:48819 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755AbZCYWCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 18:02:33 -0400
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 636D81D409E;
	Wed, 25 Mar 2009 23:02:04 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 86A148082; Wed, 25 Mar 2009 13:17:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.28-1-686 i686
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9168/Wed Mar 25 22:01:16 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114684>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2009.03.25.1243 +0100=
]:
> First I think the '#' is a leftover, second this is now a bashism.

I think this can be rewritten as POSIX as follows:

> -			git rev-parse -q --verify "${head_/#refs\/heads/refs\/top-bases}" >/d=
ev/null || exit 0;;
> +			git rev-parse -q --verify "${head_/refs\/heads/refs\/top-bases}" >/de=
v/null || exit 0;;

  git rev-parse -q --verify "refs/top-bases/${head_##refs/heads/}" >/dev/nu=
ll || exit 0;;

This turns e.g. refs/heads/foo into foo and prepends
refs/top-bases/, which should be the same effect, assuming that the
variable's value contains nothing else but the ref's path.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
logik ist analsadismus: gedanken werden gewaltsam
durch einen engen gang gepre=DFt.
                                                    -- frei nach lacan

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknKINEACgkQIgvIgzMMSnWP2QCeKxy/PB0x0EHl0JeEv3AaJg6K
uLkAniQZjss2f2A4eaXjzkuDTr1BGx05
=rvmC
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
