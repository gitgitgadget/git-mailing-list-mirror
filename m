From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sat, 10 May 2014 17:23:39 +0000
Message-ID: <20140510172338.GB45511@vauxhall.crustytoothpaste.net>
References: <536E2C19.3000202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 19:23:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjB03-0001sH-56
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 19:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbaEJRXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 13:23:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47671 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188AbaEJRXq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 13:23:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a04c:bcbd:f5ef:c7f5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 19ABD28087;
	Sat, 10 May 2014 17:23:45 +0000 (UTC)
Mail-Followup-To: Sitaram Chamarty <sitaramc@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
Content-Disposition: inline
In-Reply-To: <536E2C19.3000202@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248661>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2014 at 07:09:37PM +0530, Sitaram Chamarty wrote:
> Hi,
>=20
> Is there a trick to optimising a push by telling the receiver to pick up
> missing objects from some other repo on its own server, to cut down even
> more on network traffic?
>=20
> So, hypothetically,
>=20
>     git push user@host:repo1 --look-for-objects-in=3Drepo2
>=20
> I'm aware of the alternates mechanism, but that makes the dependency on
> the other repo sort-of permanent.  I'm looking for a temporary
> dependence, just for the duration of the push.  Naturally, the objects
> should be brought into the target repo for that to happen, except that
> this would be doing more from disk and less from the network.
>=20
> My gut says this isn't possible, and I've searched enough to almost be
> sure, but before I give up, I wanted to ask.

I don't believe this is possible.  There has been some discussion on
related matters at least fairly recently, though.

Part of the reason nobody has implemented this is because it exposes
additional security concerns.  If I create a commit that references an
object I don't own, but is in someone else's repository, this feature
could allow me to gain access to objects which I shouldn't have access
to unless the authentication and permissions layer is very, very
careful.  This would make many very simple HTTPS and SSH setups much
more complex.  Alternates don't have this problem because they're done
server-side.

I definitely understand the desire for this, though.  I would probably
use it myself if it were available.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTbmCaAAoJEL9TXYEfUvaLIOQP/A36MBwj0KKlDOmdp9uA9Wgf
zqGETkR2imc5Twse8TzaBft+EkzXHQTKyvjT8UY94kZgNOluEiR5Vhg/izQuTPe9
QxRfZBd80SBrxxmAns+WVfAO9Fn18dyaHDOHt+poASSI/r3TheBg4hzko2M+Ev/G
/zAExwWjW2G7yaQxrv/U+YxzMVeziFzmATjlWpu3keljCjpZ+BJa/HmPwB+idX0y
UZR19O9ZZt9sYubT9Fh0M32ztL6nhy0BZPLZw3VznAL2SZqaWEgqvUN4uMrftPXC
gRarwc4NfvgwsndUzPOPhto+QYqS7Osw5Y0Rp9SU5GPba3DCafH1LrKuK1aPOeNb
jnhRq3b66tjpyra6XZtlbKiBj+3ELpxL5oM8NNqVslIyKXjhxv3fFtk1UYXTR2pu
wsC6HZ5vvCArr/IRUgnjg0lVw1KwjKQE4bgrGs4knLd1wg7Aq/T8vT4E8HFr7g7d
FiDDPN6Qtnw2XQUyyeLTVMR1JMP2/OGfQMGkAa3bbwzUegNj8STKP1/SU2a8nWkC
cSlTVABaXOVs91F+uplnFPIlRs5wFXmWOo5E/fqOzM658zeqq0mVr+NSFz70Thng
SBxboAfBB1FiitTzBMu7SMqG7sbBvtjLfEp5DGvZNtqkLedFOBBikmzpyIB3qVmH
9jXTwLDHWowOLbDivSwr
=7diO
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
