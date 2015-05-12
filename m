From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Remote End Hung Up Error
Date: Tue, 12 May 2015 23:24:35 +0000
Message-ID: <20150512232435.GA425227@vauxhall.crustytoothpaste.net>
References: <8FF1A22F7C52194BA8546AEBBC84EF5D1A9B4E1F@ims-exch1vc-wat.imscorp.intellimec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Scott <sscott@intellimec.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsJXY-0005VX-BK
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 01:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbbELXYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 19:24:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:37348 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964961AbbELXYj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 19:24:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:307e:6849:ffff:3e6f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E46212808F;
	Tue, 12 May 2015 23:24:38 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stephen Scott <sscott@intellimec.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8FF1A22F7C52194BA8546AEBBC84EF5D1A9B4E1F@ims-exch1vc-wat.imscorp.intellimec.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268906>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 06:14:53PM +0000, Stephen Scott wrote:
> Greetings;
>=20
> I am getting this error when trying to retrieve a repo from git. Has
> anyone seen this issue before, and if you have how did you resolve it.
>=20
> Cloning into 'xxxxxxxxx'...
> remote: Counting objects: 187683, done
> remote: Finding sources: 100% (187683/187683)
> remote: Getting sizes: 100% (98684/98684)
> remote: Compressing objects: 89% (8667/9643)
> efrror: RPC failed; result=3D56, HTTP code =3D 200 MiB | 42.00 KiB/s
> fatal: The remote end hung up unexpectedly
> atal: early EOF
> fatal: index-pack failed
>=20
> Cloning into 'xxxxxxxxx'...
> remote: Counting objects: 187683, done
> remote: Finding sources: 100% (187683/187683)
> efrror: RPC failed; result=3D56, HTTP code =3D 200
> atal: The remote end hung up unexpectedly
> fatal: protocol error: bad pack header

CURL error code 56 is CURLE_RECV_ERROR, so the problem is a network
connection.  Commonly these types of errors occur over HTTP because of a
broken proxy.  Are you using such a proxy?  If so, can you try over
HTTPS (without MITM), the Git protocol, or SSH?

Also, what version of Git are you using, what version of libcurl is it
linked against, and what type of HTTP authentication are you using, if
any?  I seem to remember that older versions of Git were broken with
Kerberos in some cases, but that was quite some time ago.

> This e-mail message is confidential, may be privileged and is intended
> for the exclusive use of the addressee. Any other person is strictly
> prohibited from disclosing, distributing or reproducing it. If the
> addressee cannot be reached or is unknown to you, please inform us
> immediately and delete this e-mail message and destroy all copies.
> Thank you.

Please don't send this material to the list.  See
http://www.goldmark.org/jeff/stupid-disclaimers/ for why it's a bad
idea.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVUoulAAoJEL9TXYEfUvaLpioP/Ap4oueIqYoZuOESutFWuNyh
SqJWiQksF+BiBfA6DhVLNfbKyyVLSv1ZCLHmOZ0fAJn0m96UwppdpZZIwhTKoGYq
dmM6rJFxt0uera8X8DH37CMQj/833PuTXXvZm5rzuh8us7JAwofQNy+UfCpt8Hzb
A/edf6v6dy0E0YtqkMJLAESceX/D+Th3lRwg4+BVf3nKr/zQ5pgMmPd+dlB3w9th
cWhED/Lhrou1KICUkOe7HaW6gIHGPKRd8Gvt0NHfOKb8CxCPWuoicqcvdg8ILhC+
/qYNovxAzyis1hGq1AGJazl1Z4xDvEUukc3hu3G6qtnHav7tfUbJYruQf5zYsl5E
iDlpd8/sY7984pt0Lwexz/cROZzNKCr//aceJWgJ0Prkdg5ZfrQKKZMweh2faSIM
yxG1PXEmzoqqQQZaplFRl6A3CZf7bKkH3Gx4qy+Tw9KtjWQLFJJRe78qYeM4ZXWl
VSe0PxcCUb9VyadsbDjKuSLoo5QefKN3cyCFDMqcijkgCk5eYnwM0/NUHb86T1n5
Q4NEIZXlJsUtFl/Xn8TlXcOLXcMBgOTlrq1fBQNbcPC0/jL+iC6mKI1ZugFzqB8+
+nNfO41wZgrcfhtgG1fr4wDDAM8dIugs/BK/BV9tbZwxm4X4aQKuGwXCml9pImsu
PwHJv929z3V4mgEkiS3g
=Bcrg
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
