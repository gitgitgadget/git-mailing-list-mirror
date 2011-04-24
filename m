From: Joey Hess <joey@kitenet.net>
Subject: symlinked working tree gotcha
Date: Sun, 24 Apr 2011 12:58:25 -0400
Message-ID: <20110424165825.GA21062@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Cc: 621386@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 18:58:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE2e2-0007WI-N8
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 18:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675Ab1DXQ6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 12:58:34 -0400
Received: from wren.kitenet.net ([80.68.85.49]:35969 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757669Ab1DXQ6d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 12:58:33 -0400
Received: from gnu.kitenet.net (dialup-4.154.35.0.Dial1.Atlanta1.Level3.net [4.154.35.0])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id AEA1C118284;
	Sun, 24 Apr 2011 12:58:30 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 0400B4798F; Sun, 24 Apr 2011 12:58:25 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171995>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

joey@gnu:/tmp>mkdir foo
joey@gnu:/tmp>cd foo
joey@gnu:/tmp/foo>git init
Initialized empty Git repository in /tmp/foo/.git/
joey@gnu:/tmp/foo>touch foo
joey@gnu:/tmp/foo>git add /tmp/foo/foo
joey@gnu:/tmp/foo>cd ..
joey@gnu:/tmp>ln -s foo bar
joey@gnu:/tmp>cd bar
joey@gnu:/tmp/bar>touch bar
joey@gnu:/tmp/bar>git add /tmp/bar/bar
fatal: '/tmp/bar/bar' is outside repository

Is this a bug or a feature of git? I had some code where I had, lazily,
assumed that passing the full path to the file would always work, since
it did, in my experience.

--=20
see shy jo

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTbRWsckQ2SIlEuPHAQhmFw//Yv9xWjM67uygFYlP4KWSfAqYum/Z+Ew1
RjmKXjp27ynrBeKwHe9+atQKZABe5yUf0/KGr2sJhnn+pORmgZxBo1rzfEgvChQC
B3YmxYNk0LZCLWm79AYlKSZVqQlOkgz4e61KVEO9WJ+mY8VBXaMa9JibR8cY0Gos
mHmNkZYSTKM4msLhNSEsHBKzFu5wpu1W6bwBzwXjunp8fqEChlqQctXCiLrNkR+x
DlBmW+ckoQYdeJtcRDuXA4bCMSh7MW7TCDfjnP6vA21d3thrUNKiIuM6AHMhyHKr
zjASxlsicW1qa/Zp5RFoaL011nor9xG5rc7E2VxOG1Uyapo6plspAng/VGqEWEnN
OAqHKmFJcQE3hSCrCocsYOerGpsRMmHcQN8o3/gt0fByrkYacbhco0NzaeWO6ykz
yHh2oxeDXltsH+5EqLJHgAvC9exjAHy32FlOSo6BYZeulnW8w5FKVVfzs93v1r3+
hhZ7WImwxipap3L5WOLjmba8+oAKGyAj5akJYzMedlxCUgb4mrlO3OfmgfBtOSlH
qOhMWP/a0c/9j4s9dOUeX37F4toPukZjW4vRLA46npp/V48jAVisy3v7gurwipQ0
HAl/r7n9K6taj+Zj98A6kZ7bzdeiyHWpyHuJGZNP8oeHdJJZ5hhUYhyWjGLPTx4J
CKvbmzV+Ckk=
=3PP4
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
