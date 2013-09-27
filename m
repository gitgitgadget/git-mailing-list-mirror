From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git rebase is confused about commits w/o textual changes (e.g.
 chmod's)
Date: Fri, 27 Sep 2013 22:28:07 +0000
Message-ID: <20130927222807.GA18384@vauxhall.crustytoothpaste.net>
References: <20130924225648.48af3f4e@x34f>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: git@vger.kernel.org
To: Paul Sokolovsky <pmiscml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 00:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPgWJ-00058G-Rg
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 00:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab3I0W2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 18:28:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60592 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753073Ab3I0W2P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Sep 2013 18:28:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 57B192807A;
	Fri, 27 Sep 2013 22:28:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130924225648.48af3f4e@x34f>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235478>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2013 at 10:56:48PM +0300, Paul Sokolovsky wrote:
> Hello,
>=20
> git rebase is confused about commits like
> https://github.com/pfalcon/civetweb/commit/ce8493837bf7676c6d824cdcb1d5e3=
a7ed476fe1
> - it stops, telling user to just run rebase --continue. I remember like
> few years ago rebase was confused like that oftentimes, which is in turn
> confused novices trying rebase-based workflow. There's big progress
> over years, and it would be nice to make it just perfect.
>=20
> The exact messages are:
>=20
> + git rebase --preserve-merges --onto upstream-master e61d4efbe4d34d64e6b=
e50ad5009045e4ff06764 HEAD
> The previous cherry-pick is now empty, possibly due to conflict resolutio=
n.
> If you wish to commit it anyway, use:
>=20
>     git commit --allow-empty
>=20
> Otherwise, please use 'git reset'
> # rebase in progress; onto a0b43ae
> # You are currently rebasing.
> #   (all conflicts fixed: run "git rebase --continue")
> #
> nothing to commit, working directory clean
> Could not pick 5831bf1affad12bfa3146c37b8b622ba4e584ca3

I'm interested in solving this, but I can't seem to reproduce it with
the following script.  Can you provide more information about which
branches specifically you were using (as well as which git version) so I
can reproduce the problem and look into fixing it?

  git checkout -b test-base
  printf "line 1\n" >example
  git add example
  git commit -m "add line 1"

  git checkout -b to-rebase
  chmod 755 example
  git add example
  git commit -m "change permissions"

  git checkout test-base
  printf "line 2\n" >>example
  git add example
  git commit -m "add line"

  git checkout to-rebase
  git rebase test-base
  test -x example

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSRgZ3AAoJEL9TXYEfUvaLviEP/2u25m5iBGIpl1TSqse8Vw/l
OxQWZzTNoDTN9TfELErFQGRvEddSvT14ES3BSFg53aChIbdsue2/eVJQ03cU4gVl
Vypos0Hx/WEUuGw60/4zYV3GWB7zCVNNJM5Q8fvImxrNHJKTAW2X/pdY3BeEtUMb
Xk4g4AFbmlC06Zvs28kAFGvHsHkVkuItiTkUL9vcP7DYUk7xCS7OzHNx7F+VGskF
ytV7b3RBbu3dWYQ5YXb3cPz1HrSXVit0X/msUd+7O3pFWSjFFiJeLkbvrVZygjac
q0ZcJcuG2iRvAzZSry6MgdTm0oZ7nTZuaq9RbADHblOAfwozc7S2kwsbF1fiPri4
jxGhGo7QpdrdJ611mIaXuLxjANCQnVAvsxQrwNH5RoRyVb4voudRupIKBxLFfGHW
DmTi0smnCPcQ5eM66nQLC+XNH9hsJli9E5fcUsQ/PTuxESjMPtOJPr/STQ3ShSF9
q7+98a4QSPK3dpNVztRs6Vhs+z+bqyYyMp3nL3NGoVrKLPuHwNG5tAnUUoDnaZOl
kaQALZa5UOF/Zlc/NH/w06xL34rjYfVSxE6HZdA3g/owkUsejLgjsNe9BUH7I91F
71dKQ7+sKF1imdF63/qNaQZdOS0itrSpsrJ/Eixd+832MjjyZ51sru6V2QMmHNMs
7ZdDLWT7iPhOGnh/tuOV
=ks2d
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
