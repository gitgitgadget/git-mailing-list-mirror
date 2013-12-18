From: Joey Hess <joey@kitenet.net>
Subject: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 13:14:46 -0400
Message-ID: <20131218171446.GA19657@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 18:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtKhx-0003j0-JT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 18:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab3LRROt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 12:14:49 -0500
Received: from wren.kitenet.net ([80.68.85.49]:46198 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab3LRROt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 12:14:49 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id 9216D305EE8; Wed, 18 Dec 2013 12:14:46 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239458>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In sha1_file.c, when git is built on linux, it will use=20
getrlimit(RLIMIT_NOFILE). I've been deploying git binaries to some
unusual systems, like embedded NAS devices, and it seems some with older
kernels like 2.6.33 fail with "fatal: cannot get RLIMIT_NOFILE: Bad address=
".

I could work around this by building git without RLIMIT_NOFILE defined,
but perhaps it would make sense to improve the code to fall back
to one of the other methods for getting the limit, and/or return the
hardcoded 1 as a fallback. This would make git binaries more robust
against old/broken/misconfigured kernels.

--=20
see shy jo

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUrHYBskQ2SIlEuPHAQgknxAAptYzaGZxJCqFneaS50vH7pVvILIyKPvo
kOMQmDl+RtgYaH08ozbx2AKkomIjAZgwQR8QD1aVK7tV6h98HXR2/EGfwHCfwOgU
XMvTW2pQVoV+lU1Dd/4wrqzitYwK8S2ZdYjeVFIN23xmRA7fys43rcV+DxYwNIHF
unQF4uby3Mr81pi+sFS++XgyB9U1VlHF6u2/Z0fa42JOQvnOQVSeO1BYp54RZact
07ZZQ2vTitdw5bahD85H4xF36EUqNeX639D5ZBXdLvQfG+7iexbUhCqnB3xpovyZ
5aW3rmfv+ZTmUqmYq1KDWiG/ldAw5oKBjDtvpb6cehU3TNghVj9F6V8dWwXZO6mn
Hz+AQPg06AG0BK4r4wLbv8a5DhBQj0ASdpcJ8OKeu4dSPqqG+R6vLNTg+PZxFI9W
lR5gto54GMRSWlFXgszT+E0B+IzWEOo6lw1vPZHgfuc11bROzC2LfTuLM5GaYfWc
Q2OGlfVYJ2G4PweBrPjHpzj7n2Z4H8FCHSuIIxWHchBwT2fzyrEoZpFzXd2yY9o1
yxIMRMgYLMSFlSJEoAkoWm+/HFe6kYbBJ67KaCpultIesrQFKRjvOA3NNnVl5QjK
GOA4hdzhL7hhD+aJJfC+aBxQpsLWRD6YJEkY1x6+qccsGCcy89CEoxpE1sUTfOSu
aRtfQ12vGuw=
=Eii7
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
