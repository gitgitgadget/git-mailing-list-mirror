From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] remote-curl: fix large pushes with GSSAPI
Date: Thu, 31 Oct 2013 22:49:15 +0000
Message-ID: <20131031224913.GB41460@vauxhall.crustytoothpaste.net>
References: <20131031063451.GA5513@sigill.intra.peff.net>
 <20131031063651.GC5812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 23:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc13Q-0003fa-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 23:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab3JaWtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 18:49:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33451 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751694Ab3JaWtX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 18:49:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:21a5:310a:1a75:4292])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 902992807C;
	Thu, 31 Oct 2013 22:49:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131031063651.GC5812@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237190>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 02:36:51AM -0400, Jeff King wrote:
> From: brian m. carlson <sandals@crustytoothpaste.net>
>=20
> Due to an interaction between the way libcurl handles GSSAPI
> authentication over HTTP and the way git uses libcurl, large
> pushes (those over http.postBuffer bytes) would fail due to
> an authentication failure requiring a rewind of the curl
> buffer.  Such a rewind was not possible because the data did
> not fit into the entire buffer.
>=20
> Enable the use of the Expect: 100-continue header for large
> requests where the server offers GSSAPI authentication to
> avoid this issue, since the request would otherwise fail.
> This allows git to get the authentication data right before
> sending the pack contents.  Existing cases where pushes
> would succeed, including small requests using GSSAPI, still
> disable the use of 100 Continue, as it causes problems for
> some remote HTTP implementations (servers and proxies).
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Jeff King <peff@peff.net>

The entire series looks fine by me.  Thanks for fixing this up.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSct5pAAoJEL9TXYEfUvaLbMQP/jpAbV44S0ICcIN98PQyzsdB
7zAiZfAK4PJLM8ceddRloWSLtgb6JlfQvNRLc3BHpnmThUYVWQioaVSiQOLpf9ML
/E6qIsNq9ZjR/Afororx1vmaUEL3vbwKLqHGgxuq+7t4oNW5tLYtqp7qvxZValb/
xt9pCfz2ToOC/Xw3azoktcnj2uSb1KkHILrU1IznfI5IjXY1MW867aMXDSsY7WF/
+OfLsCvY4fE7qDHXucGdZ5WOyYfz7j84dgr4Ep8g/b/Ea24UANbLf6Y707zJB8wL
qMvcpFdPwdu81Faa6B+BaAcK3RO+BaZdksKENyt2JODHUJOMOqcm4Py1Qfy3JjCF
OkFdTQq7gbn1FMug+rmGDlA/hz1np6/WpRnUYkuGcBiyniCxTu60VBI7QkOJfah0
KJhIz//tPSPWRTD+qReAphulJC2KV6kNFD+RFOUQncu16Hp2LGe6iGoEyKWBqGH2
xF0qiqpClkH3PIsDPrtcFAVX+ZKoGAjYyKckkjvmBpupdtpaVBz6t95DygQHzCNl
x1TSN5GdcBrpZaZ2CEKq1B2U31l9uAw/+CS22QselrgpVsHaxnnanUWuyc8jAQrC
ccxbyotjnU7ae+hG/PQw0FcvNOlDkFxwVE5txAx/6TA8t7pk2yLdFBkhNxT7RX5Z
B+9WA6rw8w4PsgSJuYNI
=PfRQ
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
