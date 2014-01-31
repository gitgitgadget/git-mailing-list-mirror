From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Performance regression in git fetch between 1.8.3.4 and 1.8.5.3
Date: Fri, 31 Jan 2014 21:02:15 +0000
Message-ID: <20140131210154.GA632399@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Cc: brian.carlson@cpanel.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 22:02:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9LEL-0007S4-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 22:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbaAaVC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 16:02:26 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51527 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754145AbaAaVCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 16:02:25 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [99.69.156.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CE2AD28071;
	Fri, 31 Jan 2014 21:02:21 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241319>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At work, we recently upgraded our git version from 1.8.3.4 to 1.8.5.3.
We've noticed a significant performance regression in git fetch.  The
numbers below are for an up-to-date branch (that is, no data is actually
being fetched) for a git-over-ssh remote on our gitorious server.

This is an auxiliary repository, so its size is probably between 6-7
GiB.  It does not have an especially large number of refs, but is a
clone of our main repository.

Other than the new version, the only difference is that 1.8.5.3 is built
against libpcre.  These are both running on the same CentOS 6 system;
literally the only difference is installing one RPM or the other.

1.8.3.4:

  brianc ok # for i in `seq 1 3`; do time git fetch; done
  git fetch  0.86s user 0.18s system 78% cpu 1.314 total
  git fetch  0.88s user 0.19s system 79% cpu 1.348 total
  git fetch  0.84s user 0.18s system 78% cpu 1.299 total

1.8.5.3:

  brianc ok # for i in `seq 1 3`; do time git fetch; done
  git fetch  17.11s user 1.22s system 98% cpu 18.652 total
  git fetch  16.74s user 1.24s system 98% cpu 18.286 total
  git fetch  17.78s user 1.35s system 98% cpu 19.446 total

Does anyone have any idea what might be causing this?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS7A9UAAoJEL9TXYEfUvaL1w0QAMmEMgjLb/b0Av/m7M26WApa
Ny+Z9oQsTGwhvx/zVCD1VXyzVqKU4+ynl+ZVgKr0t65CrltIdO7L8/GZBAcytZMC
b4awRlFMyhq6RCnCxNFRQEshyEQglNbtXfq8uP8zewc3x/c+f1v9eXNwCxf4Dw/2
hNn+CokhO93V+0sGXTLYJ9EeuFiv9qFvyqxIZcKIyxvWX3TQpxbxT5Lw9ct+GxRC
DHeb1DLDYOUo1BMgSv2BYo5SC0Wdj1P0yk5VehEvPEH+ugnUv+8EuCQCOsZ2bD84
rLRSVcIEkE1MWhUWOS54LDWX4yt3qzb7oTLeqrymlSIvSon5fV2aXJyXzH0LZWqG
gg2YluPoD+BjDSNu1x8fvjV7JnoiupE7P0q/ppz+kCB8hxN2zMZc4vzLfcEKOYDA
/mo/PL4Fu0OUE2eiSr+7r/J7wERQblgu3vsLFpxhIzU8X1GB2su6F4jQ7rHCnpRD
7YcX/9S/uIe1KjEx4NQ2GYT9ugT/U2F8p4ezBIit7p0dbFdmat9bes0t3xR7q7OU
3Na2gWySd6DlFGYa9Cnu1XPSS8KaIvZvnDWSwTViJZkF5UNTQB1JkuUEhw3unHgx
emjR/Y1qfc96ULv0W90KlQgWc4nbiza4MOUGV0vDBOWqvjMOjQ0JZ4XaLCG8nIzv
jzGQ2fWrYPgt1l0l0YfX
=rhla
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
