From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: weaning distributions off tarballs: extended verification of git
 tags
Date: Sat, 28 Feb 2015 19:14:03 +0000
Message-ID: <20150228191403.GD514544@vauxhall.crustytoothpaste.net>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Cc: git@vger.kernel.org
To: Colin Walters <walters@verbum.org>
X-From: git-owner@vger.kernel.org Sat Feb 28 20:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRmqg-0003CD-AG
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 20:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbbB1TOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 14:14:11 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49394 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbbB1TOL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 14:14:11 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:199a:7224:fe1e:ce4d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9C54E2808F;
	Sat, 28 Feb 2015 19:14:09 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Colin Walters <walters@verbum.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264536>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2015 at 09:48:05AM -0500, Colin Walters wrote:
>The above strawman code allows embedding the SHA256(git archive | tar).  N=
ow,
>in order to make this work, the byte output of "git archive" must never ch=
ange in the
>future.  I'm not sure how valid an assumption this is.  Timestamps are set=
 to the
>commit timestamp, but I could imagine someone wanting to come along later
>and tweak the output to be compatible with some variant of tar or somethin=
g.

This is not a safe assumption.  Unfortunately, kernel.org assumed that=20
it was the case, and a change broke it.  Let's please not make more code=20
that does that.

>We could define the checksum to be over the stream of raw objects, sorted =
by their checksum,
>and that way be independent of archiving format variations.

This would be a much better idea, assuming you mean "raw git objects".=20
For cryptographic purposes, it's important to make the item boundaries=20
unambiguous, which is usually done using the length.  Since the raw git=20
objects include the length, this is sufficient.

If you don't make the boundaries unambiguous, you get the problem you=20
have with v3 OpenPGP keys, where somebody could move bytes from one=20
value to another, creating a different key, but with the same=20
fingerprint (hash value).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU8hN7AAoJEL9TXYEfUvaLvawQALl6BDlfjRV+j1H6XZWO+vQD
PE69HHYL0LEMTIXMH5i9v+f3mQOHDex2TxPFVDhLx1iHm0XAY7UWhv51vE6N1YvE
Bl4mPWTIKf2QfxTqulpFeg4PcfM9BXvF8LIllMEGKysWvknphAkSw2RI4k7ybvAO
qUsegqhKAeHTdVvhfAudypqygD48gMJqh/HYhsDBgNLjzxau5RCsiSDCAS0NM0pM
pIAoUnsD4/RCCV9tZI9/E5hIAH7EPe8S5Ia75H2D2/JxjkRNI3oVnTCLJZzX1o45
sbivjCFBvs3QVB7MvI9iy05YixtKjmRIio+256IiQ3H1N0mNibWRmhz9fT/jBWqd
sUSUAmAFEVZc63xTP24OpoIaXsfu0a2MuxTda4BlXAKjgfBAJJZ11OmeMydb5Kex
5kynzzySt94/HzTLEiT6SGJbUcYleTWXRvrSEK0eraEcDJljMzoigwJGKY9O0r+v
MHxBdxldb/B0Ehlb0BmO2rcmBDgeBYL2yadPMch6c8rCFuyWr/qKw+1Uz83VkFc0
B2bhDBzfiPij7iSNlgvYFAufgm0HNr0WE7jyCQyc1tOBOjw4z3jYHOhTJiANVh24
pv1I+flYYAGPO7aiwhwCigZxHf9FqKeI/IVvP5g87KP8pzJM6tmB6QaGktDsPqBn
s0Cs3X+j3rJliAwYSDaQ
=NSWM
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
