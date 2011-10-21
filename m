From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git grep --no-index and absolute paths don't work?
Date: Fri, 21 Oct 2011 09:09:33 +0200
Message-ID: <1319180973.5352.8.camel@bee.lab.cmartin.tk>
References: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-kOJZ85+f4bLtVoNjaHyT"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 09:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH9Ek-0004rR-0h
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 09:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab1JUHJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 03:09:42 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:45428 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab1JUHJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 03:09:42 -0400
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 4AD22460FE;
	Fri, 21 Oct 2011 09:09:10 +0200 (CEST)
In-Reply-To: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184050>


--=-kOJZ85+f4bLtVoNjaHyT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-10-21 at 08:34 +0200, Bert Wesarg wrote:
> Hi,
>=20
> I'm currently  totally confused, that a
>=20
>     git grep --no-index foo /usr/include
>=20
> does not work. I know that the documentation says "in the current
> directory" for the --no-index flag. But this does not work ether:

The rest of the sentence reads ", not just those tracked by git" which
implies that the files tracked by git are also searched. This requires a
git repository.

>=20
>     cd ~; git grep --no-index foo ~/.bashrc
>=20
> They all fail with 'is outside repository'. Which is for itself vary
> misleading, because I intentionally said --no-index.

Git is a tool that works on git repositories. Some commands may work
outside of a repository, like ls-remote when given an URL or init (for
obvious reasons) but it's not something that should be expected,
especially for commands that read files from the working tree.

Why are you trying to use git's grep command outside a repository? Why
isn't 'grep -nr foo /usr/include/' good enough?

   cmn


--=-kOJZ85+f4bLtVoNjaHyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOoRqtAAoJEHKRP1jG7ZzTXlwH/jS3UsAm8kG8ymEXcqbhUKoD
O7jkr2MsQNVXnS7kN0s6G9DqOCiUz9V82iSez5JWJySpQby5t9+Ovml6ydOuWO9v
P/QagwheBOGp1rXrI7L4oJCZhVTUKLXpgE5b50f9PaxzfDDBL1vPTWj94x+CKNdU
kEShXRYdzR5NhRiJsPqsU1csrxGrhR1WBDaYI4W/QmNg0Nacuq+67Gk3kIhTx1fs
1vWQe3Ro8TvNtSe7OQgnwCBuC7uqROmKzmf5+4rRFa2oHGIwASkEn4n//KocdBJY
A7+GUrZCUqwrqJLMcVYDU6S1Olcdv01N6iRbQ1lj/9v4xsAMVB3ie51rqKth2nM=
=EvMw
-----END PGP SIGNATURE-----

--=-kOJZ85+f4bLtVoNjaHyT--
