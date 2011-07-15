From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git with detached worktrees , push has no effect
Date: Fri, 15 Jul 2011 21:24:59 +0200
Message-ID: <1310757899.7308.10.camel@centaur.lab.cmartin.tk>
References: <20110714181019.2453e3a8@shiva.selfip.org>
	 <1310647767.6041.73.camel@centaur.lab.cmartin.tk>
	 <20110715105640.694fb3ea@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-T7KLAetuU4Mt5Qss0fWy"
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:25:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qho0a-00089m-TG
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab1GOTZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:25:02 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:49485 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab1GOTZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:25:01 -0400
Received: from [192.168.1.17] (brln-d9ba3451.pool.mediaWays.net [217.186.52.81])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 04F29461F5;
	Fri, 15 Jul 2011 21:24:58 +0200 (CEST)
In-Reply-To: <20110715105640.694fb3ea@shiva.selfip.org>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177214>


--=-T7KLAetuU4Mt5Qss0fWy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-07-15 at 10:56 +0530, J. Bakshi wrote:
[snip]
> Working like a charm and the hook is also working fine. Can we make the=
=20
> empty master branch at the server, so that client can continue with
> plain "git push" ?

You may have figured this out already, but once you push, that branch
exists, so under those same rules, pushing to master will work from
there onwards.

If you were asking whether you can create an empty branch on the remote
you it works "automatically", then the answer is no, because a branch
doesn't exist[0] before its first commit. A branch is a reference to a
commit (which is, logically, considered the tip of that branch). Thus an
empty branch cannot exist before any commits are made to that branch.

[0] For the purposes of network transfer. The way to create the first
commit ever in a repo (or in an orphan branch) is to have HEAD point to
an as-of-yet nonexistent branch; but this won't help you in this case.

Cheers,
   cmn


--=-T7KLAetuU4Mt5Qss0fWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOIJQEAAoJEHKRP1jG7ZzT6oMH/jlwKzB7JvF9TwnpASLCEdyW
eUT3cIzAwCHJ/C85RcFxN2lshCi5aSQYFjuqdLrzHCuJToe8QPXFQfMrC7/r993H
RY44LLuA5SQKk0jlFuS63GXqkfhKkAM5KMgB4InmqxnPI/RDsZqI2dEe0iBfO1i4
enN/9yL7nHMC7Gszts0+IYDUU9I/o3opC7qWSQ9/C2l5bFYg6d6Ijx4zggnlVks8
bP9xf9JPfPp1KMWQYOpK2BjdhoUgaSs69BxU7uRwkDPn3aNqMl+7EVTZ2gvo6PNf
oyBVnhpnwyAc3f7viAutVG0JetxT0q1XSyUiM5CEYjvG4CL0HMtZqL88JSC9jTQ=
=cLGt
-----END PGP SIGNATURE-----

--=-T7KLAetuU4Mt5Qss0fWy--
