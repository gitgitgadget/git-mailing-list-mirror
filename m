From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Mon, 7 Oct 2013 22:56:07 +0000
Message-ID: <20131007225607.GA30156@vauxhall.crustytoothpaste.net>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
 <20131006105013.GA24950@LK-Perkele-VII>
 <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr>
 <20131006152908.GD3460@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.00.1310061737000.6366@tvnag.unkk.fr>
 <20131006174959.GE3460@vauxhall.crustytoothpaste.net>
 <20131007120241.GC5792@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Cc: Daniel Stenberg <daniel@haxx.se>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 08 00:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTJix-0000BG-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 00:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab3JGW4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 18:56:19 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60959 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197Ab3JGW4S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Oct 2013 18:56:18 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DE4F760001;
	Mon,  7 Oct 2013 22:56:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131007120241.GC5792@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235765>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2013 at 08:02:41AM -0400, Jeff King wrote:
> Yeah, instead we try to make two separate requests, and assume that the
> first one clears the path for any further requests. Of course that
> doesn't work for auth methods that actually negotiate for each request.
>=20
> We should probably make the "Expect" suppression optional for people who
> know they have working systems. It would be nice to trigger it
> automatically when people are using something like GSS, but that
> decision happens at the curl layer.

Yeah, that's what I ultimately determined would be the best choice.
Technically, we could respawn the process, but that would be a
logistical nightmare and extremely inefficient for large transfers.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSUzwHAAoJEL9TXYEfUvaLnrAP+wWwt29UMUydkpqXo9CSF4mh
dU4y6C22++ft6mi/FwZvhRTvMF0VhDN5Ph6crgjnZcBOIq2A5sioYfkt+yr3BA+8
ydo2YW0a+WXzEi2YDSVihSsWqahk5RxHpefjzJ6YdHQKtqvH12ZupnWBTWJyCXaz
GdYE+5qU4BAHGah4jrmbWDNHHLE+0OwQMq41vzV1tHScK8ij1MNcQ/mhf2tkeWf2
1oQHYHksvzAzOQI8Avwxlm5h1TloDXsgOPZH+qkv1dRLWGt+8B332+qCf3v2SJha
/vH5sRKBDKltOlwJqKaMxQzr9/URXObzP+uQkFtqVeUQ7JvrWTpWSzptAFDLhicE
sOQX6zXxORDZa6/QZJdJp5FLanFJdhFDjL9VjV6eqeIGxwRB5CMEDtGMOiwBGsX0
QcOLo/LFzdXYgdGs6ruF0pWxtRV3CEcdf+KnOdgEramTVNhNpX2AkNQ+kLJPcT4T
lF/nQGARZbnxeVItNgDpPKSJFjWPGZPrP4NJEQgY5AWz4OvdWjQYCp8dSwy8rlts
XxgIG1msU41XEV983wXCkvdiC7WAbGm8ZlnVpDESZwg8AJijE2MnefHm1qUc72ZY
UKYT5TS7Eo4CYdq/ShVe8sAzxZXVaVeUdY3XwqgJx6aym9H8LSZ289hUVlGFS2oS
Kwv6sdNqsdNwc7l6XJZf
=cHQa
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
