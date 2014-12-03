From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Disabling credential helper?
Date: Wed, 3 Dec 2014 00:03:10 +0000
Message-ID: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 01:03:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxPb-0003Ee-AP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 01:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933487AbaLCADP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 19:03:15 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54934 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933271AbaLCADO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 19:03:14 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0DFFB2808F
	for <git@vger.kernel.org>; Wed,  3 Dec 2014 00:03:14 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260603>


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At $DAYJOB, we have a Git server[0] that supports the smart HTTP
protocol.  That server can return a 401 if the repository is private or
doesn't exist.

We have several scripts, some of which run interactively, some not, that
we simply want to fail if git fetch gets a non-2xx code.  Unfortunately,
git is very insistent about trying to use the default credential helper
to prompt for a username and password in this case, even opening
/dev/tty.

We've used GIT_ASKPASS=3D/bin/echo, which seems to solve the problem,
although it's ugly and I'm concerned it might break in the future.  Is
there a better way to do this?  I didn't see one in the documentation or
code when I looked.

[0] An Atlassian Stash instance.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBCgAGBQJUflM+AAoJEL9TXYEfUvaLy88P+NVP1173J7oDo1CiwJVREko1
r9Ugt8qi+9OjWgetZtUVaYqgSIeRYjje9VHrZ75HvpvIPM542cnQLXhLN6XFlA2o
lk1p7UMKuf19L43qxnEMyv9QkQqd3BGMAY93MmXk010obtjlPfLQ9sUFiVBJKyeo
6rGUCzT9geHHig+YyLGE5lc2t36QMGxV3/BhdNbFMwrHU5CXIorWaseWQ+Qfb/QD
qhzB7FCpKiN5sfVXqkOSQGmJ8vu3BLdKIZXD4tTj+YiSmVRawHaWBysi8lxucoXl
/otWHc2gfQlgKPWMhEhBbjq3MlouQdvinjU2ErSxvt7O+GrOLaO7aXUTL8KSnHpl
3m+dDqoBU/jYHRTD9bPbjqGrl/OHWIteFBoWp0C7z3pJ4oVHwL7a738e7nk/qRc5
j8xDiMa3+kkov2snIFTEaRBafI4vuwtw3krV4h/bD+krgStamua6+XuOuTOUtTCJ
ndiBF2lcqibP1YC/kqCDcfIr22Fg8Gyqnpg6Im+5apWSzJoojqx49E8OJ8v/zNjo
NaqcnSpNbuBLZyKKBwIFo0e0eiUZUcgN5zdbnF7tWrpvA9gkeLqkLVlPoZSRV690
lFjM8NoVnItCHm1YMuEzWNLu+NZYl2DH0yYwAhtMKxbnkaNH1qpNaFeQ4b8LMjTw
Ejq4bjclKerWsyS5XaE=
=pTCj
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
