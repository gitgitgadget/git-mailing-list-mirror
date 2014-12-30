From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: bearer token authorization with HTTPS transport
Date: Tue, 30 Dec 2014 23:56:11 +0000
Message-ID: <20141230235610.GC10649@vauxhall.crustytoothpaste.net>
References: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Cc: git@vger.kernel.org, peff@peff.net
To: David Renshaw <david@sandstorm.io>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66eE-0002J1-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbaL3X4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:56:17 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56422 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463AbaL3X4Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2014 18:56:16 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:38c8:c576:a602:38e0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A5C482808F;
	Tue, 30 Dec 2014 23:56:14 +0000 (UTC)
Mail-Followup-To: David Renshaw <david@sandstorm.io>, git@vger.kernel.org,
	peff@peff.net
Content-Disposition: inline
In-Reply-To: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261963>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2014 at 11:24:09AM -0800, David Renshaw wrote:
> Hi,
> I would like to be able to serve a git repository over HTTPS from a
> web server that requires OAuth2-style bearer tokens for authorization.
> For more context, see this thread:
> https://groups.google.com/forum/#!topic/sandstorm-dev/4oigfb4-9E4
>=20
> Does anyone here have any advice about how to convince a git client to
> add an "Authorization: Bearer <token>" header?
>=20
> I can think of a few approaches:
>=20
> (1) I could modify the curl remote helper to insert the header if it
> sees a "bearertoken" config option. I have in fact written a
> proof-of-concept patch that does this (see
> https://github.com/dwrensha/git/commit/4da7b64b85b3b6652abe7), but I
> don't know how much of chance something like this has of getting
> merged into the mainline git client.

An idea that might be interesting is to add a framework to select a set
of authentication types (defaulting, of course, to "any").  As part of
that, you could add a type, "bearer", that uses the password we've
collected via the credential helper as the bearer token.

I think that has the best chance of getting merged designwise.  I've
CC'd Peff, as he has touched the area a lot and might have other
suggestions.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUozuaAAoJEL9TXYEfUvaLyjgP/13F3kuFWUaMKTvY+T/stO/o
cRYWzrp21APUF8vHh1uJ7+1wQZyD0Dl4+5fDAAd1dnKhUbF0JgfQVrDLEw2G8mK3
5zpzSNVo6HcmvBve2ggC9WrvwHz70hOaJiQ1eE/PO6D2AU/CVR+o0hec1BeNvu+Q
LL+PQwoUylqDsCHCOZmi1D5/JdfJX0xBJyS0kcnLnFsKW1IMJS4x6trcqRDjUrto
t+S2+DVg3c/+Zkh3lC0NCpA3N/LcF5Yiw8/NN2EhIziek1N+/dcNGuFSGBWs7g0b
y+7u7kO1Aku49gqsfpy1aowQwXShwqFS+rnyqvtPqlQQukKgxOtVJXgyYWkPrb6m
tU1nGV1Rz7OX7U+vEs1Ies18eqwITDBHVIHhWKUB/EZyh87zRIoVWMcarU5AEX/L
qn8Vend8I5w4KV8hMNti4xMUs3RsRe5LLkcv5T99s8vHb5W3USUq5h84wE8QKVe+
LfgFrZ5O53y8D8dYAj7RyW8KnHpsvFobBSjdDPqdswbwYbdmKhobYhcNdruIl7t3
AbPAzVMeN1GpP7aqdW6f4JDH3d8j5tgivVWXO32H0C/WAWIsW4IDWy3YLiDrHoUw
Ei19pKptS8hmOjIGEyeQl++/1pxd3STCuvrYUQ+1/bRM1coccBe8SZSGT1C0NGaU
ncp3CK1ajhebHrzgh8bX
=AsKE
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
