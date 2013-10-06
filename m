From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Sun, 6 Oct 2013 17:50:00 +0000
Message-ID: <20131006174959.GE3460@vauxhall.crustytoothpaste.net>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
 <20131006105013.GA24950@LK-Perkele-VII>
 <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr>
 <20131006152908.GD3460@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.00.1310061737000.6366@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sun Oct 06 19:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSsTU-0003je-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 19:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab3JFRuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 13:50:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60941 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753892Ab3JFRuK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Oct 2013 13:50:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EB68D2807A;
	Sun,  6 Oct 2013 17:50:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1310061737000.6366@tvnag.unkk.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235743>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2013 at 05:38:24PM +0200, Daniel Stenberg wrote:
> On Sun, 6 Oct 2013, brian m. carlson wrote:
>=20
> >If there's a way to make Apache with mod_auth_kerb do that with
> >curl, then it doesn't require a change to git, and I'm happy to
> >make it on my end. But using the curl command line client, I don't
> >see an Expect: 100-continue anywhere during the connection using
> >Debian's curl 7.32.0-1.  Do I need to send a certain amount of
> >data to see that behavior?
>=20
> Correct, curl will enable "Expect: 100-continue" if the post size is
> > 1024 bytes.

I've been able to reproduce this behavior with the curl command line
client, but it looks like we disable Expect: 100-continue in git since
some proxy servers are too stupid to understand it, according to commit
959dfcf.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSUaLHAAoJEL9TXYEfUvaLQsQQAMfsnJTw1+IHr352aXjKTZPw
ThFiv4WVykt8tVh97SxlLeQE0y4+h9Ccsbit7CnMyyWWr2DgYjcfZUbLJlcvLnu1
yuHboNLzCIEtKVN0XH0XLSEiG2LPmnDQgmT5a9c0iZE8aTSD4bYBRen9KDvMB8Ip
NuAw9jAAAZ1U9cgcT5jZeD+8733JAhdbLYPvKPbFz46Ln0Vtm8WYEcNBRlzn+0vO
w23p5IUvobXswmMk3rgt5Qmx/v1biMyJ3xr9Ik9D49h0bTCb/pMsBC73mXFVAWh2
/fkxNjF3ccYQOqsSFBcwXlgxDdXKljbLEDNsqZcU0/goIl1n6JCBMW1qBExWtyQR
LbsUaPVqAcaeh8GDdj2J26ICHHtd8vnnAIEHEjjBEkeYJV2ADYgC0ekhSktaALlv
UH7Chn/XA2UDrV6fjoDDx41dATDND0mZOVFWEAV7KE/KlIb09Ofglb+Tev3EE0VE
WuP/psGRdfSdg9MM68BA4QzAlKHG45+Ni6/Ru0X5pT6j0mw/lxJSgLN3ZbAPyD2Z
Zp0TUTyjIM8L1d/bAet8h2OM31yk5A/CXwCAGg6QVE0E5tIt1n2bXiRcr5MVAWR/
FGGMgvBU2N46lQmC+D/PDPOtiIEvI3kdHg23EqAd8qchUUDAbhXFCntCZdIVZS+2
K9XmvvmQ/w5BpaqMjg1n
=d10B
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
