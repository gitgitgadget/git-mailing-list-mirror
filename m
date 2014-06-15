From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git rebase --skip stuck in a loop
Date: Sun, 15 Jun 2014 22:39:13 +0000
Message-ID: <20140615223913.GI368384@vauxhall.crustytoothpaste.net>
References: <5397551C.4030709@ubuntu.com>
 <539A151C.50307@ubuntu.com>
 <20140613010256.GD368384@vauxhall.crustytoothpaste.net>
 <539A50F2.40206@ubuntu.com>
 <20140613073446.GF7908@sigill.intra.peff.net>
 <539B0795.70907@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:39:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwJ5L-0003O2-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 00:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbaFOWjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 18:39:19 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48360 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033AbaFOWjS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2014 18:39:18 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:410d:6806:9865:2e4b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0190D2808E;
	Sun, 15 Jun 2014 22:39:16 +0000 (UTC)
Mail-Followup-To: Phillip Susi <psusi@ubuntu.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <539B0795.70907@ubuntu.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251701>


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2014 at 10:15:49AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 6/13/2014 3:34 AM, Jeff King wrote:
> > Thanks for saving the stuck state.
> >=20
> > If it's possible to share the whole repo, it might be worth seeing
> > (then we can all just run "git rebase --continue" ourselves). If
> > it's too big or is confidential, just tarring up .git/rebase-apply
> > and making it available is probably a good first step.
>=20
> It's the debian parted repo, so nothing confidential.  Here it is:
>=20
> https://drive.google.com/file/d/0ByOQJBpP4bDXXy13YlN0aE5Fcnc/edit?usp=3Ds=
haring

Okay.  This is actually a fairly straightforward issue.  In order to
reproduce, you have to use git rebase --merge and two patches in
sequence have to cause conflicts.  In that case, git rebase --skip will
fail to ever update the msgnum value, and it will get caught in a loop.

I should have a patch shortly.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTniCRAAoJEL9TXYEfUvaLXnsQAL1rWDnXwE05S/b8WS9BCUmS
djCsJ5NNMFnTAeOO6IKqdESpXEZGDUFFhSsvxs6npVHd7MDGlDsxHP6LB+CGdhEB
nIPIR4kMpcnu2sM1SDd5lTQCzglLd0yUzQVFnf1b/nksXF6UzJLVla3rtOd1IlwK
5Q6P/cC8T1DmIVAqwuE1HBa9jpK7ANVb5PoHINFCvAu6ctZIvi+9oHgPt2NkPAfL
cznDkrTxCAb0pewWWVgnFlvNOvOhSp8vorD91WXZQqFBqk8dYfHQnFrQN/4aOKJO
lA88RfIITDqnwmGGFw91rK9fdCEbTN/NL7MalqsmtDeagS3JK3f6ePbuKg/X6qwm
o5HPQEeESN9PhsqAobrZLQMlL687LZ8tBeUf5+iiF2a9roi1RnUS2LieCpzUnjcb
RJEH0oXWoS5lFhIzZtW8WOfNs/pwoh4lqpvVKtTdWLnBdWB4yeqnTIxLp+aikpDY
U3KKVcPbOWPiSWNJFoev2PyyHK6/6PS6NQkmUokDBFwarG+6LqxlAiGaeKcN0CeC
6idLi+EaJ8DTcgYcmfSpDd9DXMCkeZy29uSm+uZLcd01U40Bhgm29J5RgBm5K3nz
ZF2B7SxUoJe3/G9vATxpxn4k4tkG+5Bvedf6ZodAtCkHGnm93c6TpQ4Jx/PoXGRg
oMvjg89wR4m1VRLK2Gcp
=9sry
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
