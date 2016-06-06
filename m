From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Coccinelle for automated refactors
Date: Mon, 6 Jun 2016 23:09:36 +0000
Message-ID: <20160606230936.GA60445@vauxhall.crustytoothpaste.net>
References: <20160605205518.GA153578@vauxhall.crustytoothpaste.net>
 <xmqqy46iw3ih.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:09:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3eW-0004pu-TI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbcFFXJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:09:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40614 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752593AbcFFXJn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 19:09:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8B4E0282A8;
	Mon,  6 Jun 2016 23:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465254581;
	bh=wrokbz4AG20Yltu7dk9vhaWbbSXm9+oERskZxXQmpvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+QCR7gN0g5dPuzM7glyYhwIj3L6bzuky71aWSMmy/HHw6JQ+LDby02KAA1ASpOn+
	 jI9zlUS/SR8kGU5evz1eqxIXcU6Q3Qxpv+rtGeEWWwd/0SICpllxejp1sJnaDNAbad
	 z9Zx/4SaqRwYxQHsJ7fWdY+Z8YpN82YZVu3BbXQPvKfwU0THhoNZI+MVcRb6ELGdl+
	 dqARB8gAqcKmjfMRAZ83n56TCazKwa7QzzK9iV7uiHW2s0u+xhTUUw6P+rgfd+gR23
	 U0HMe6Xzfm0330jGFe478zrPpvnmKy7O6OXIA/esYVVWnLIEr6YSmKz6Jrz6tF+S3F
	 gG1exO93TsvSgtg/8QHnP3xEnWqNDie4VsN9CEC5KPPzlst5mTopPt+SjHvQvjEEXd
	 8xhpv/uyhPcZvjuUj+GYRJ+H2aN0TPOseNFY/pai2J2YrswattXYJJ2kc2ZhNpbnsP
	 hJy6lBFL6QdIx0vc2JDpWwzWnxTZVhzHcGFGRDx3BWVAsW+0HOC
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqy46iw3ih.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-trunk-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296572>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 11:55:50AM -0700, Junio C Hamano wrote:
> Is the plan for such a "refactor" patch to compose such a series as
> two patch series:
>=20
>  [1/2] automatic refactor
>=20
> which gives the "semantic patch" in the proposed log message as part
> of its description, and the automated result (with possible
> misconversions that may have come from bugs in the automated tools),
> with a separate
>=20
>  [2/2] manual fixups
>=20
> that corrects what was misconverted and what was missed?
>=20
> As long as [2/2] can be kept to the minimum (and an automated tool
> that is worth using should make it so), I think that is a good way
> forward.  Another possibility would be to send the end-result as a
> single patch, with description on the manual fixups in the proposed
> log message, but it would be a lot more work to generate and review
> such a patch, I would think.

My hope is that I can make the automated changes such that manual fixups
are more along the lines of cleaning up related functions in the module,
fixing issues noticed during the refactor, and the like: in other words,
things that one might have done incidentally as part of the patch, but
could defensibly be done in a second patch anyway.

My goal is to make the series as much like a human-edited series as
possible, but with less work on all sides.

I can send an RFC series that demonstrates this a little later to see if
it's an acceptable direction for work.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.12 (GNU/Linux)

iQIcBAEBCgAGBQJXVgKwAAoJEL9TXYEfUvaLbXUQALS4UUTP+eEbtyvE8C/pVA1s
Ey2yPBgYQZWaKJEBGyEpW69Fl6aArZmX90LWTc7VaLqCNjObd3XMtMS2bg6lSmeS
Xb/gCJS7GabxB6IDynMTiVHKON/03weDGk+roAxrVzv149RmElAwej1CJ5QXsQqR
UG+PlWdGTuf0GeN2oMOq0/Mi3Lv/NeWN0xE2OdmI86QXzH2VlMHHHmX1Qlc6QKIn
tBqnqI27PlZ5O5h+XfYhiHA32bLker6ox0C2ijK6fe+M5SYrzykZ8mMJ9Jwwc4PL
McHZGIvBggyPYa7YG1HGJDnYMvSgfoIUZwa85NElBUTFkYrPGVNr/L/xqQMj7jAw
h3/Yz5luXrzMMrgo3FwnQVnMWgQ6lgUHn8XwRjE7wxLDyZIhsv5dnAZRdD6iak/T
vFu5PO1MGGOFTxi1gr8t6QOU+QBZZ9v+KTRctFOiox4tiJImI5GiJmpdSJixxEmn
/XLNocudWlTu0WllJMjq7zMNdLolPDg/7fjggmtzBUuBPDpS9Vg4w7CGCZ82YxdX
LSWfCoVg7HvAverbC60DM2+lecc4l4WlzG9ShaJDBH5jAxdiV6dTE3MZSG0noWgR
PDeaP9TmE0tIRvsaNix2FaSH6hHnaL2oljUsptA9x76ITsy7ik3Fy94SJbm6A4E9
GHZXIdTJQbYz9X8ITxX7
=BQU1
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
