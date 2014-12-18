From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-http-backend auth via Kerberos
Date: Thu, 18 Dec 2014 22:54:32 +0000
Message-ID: <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
References: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 23:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1jy0-0003Sq-3e
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 23:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbaLRWyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 17:54:40 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55617 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618AbaLRWyj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2014 17:54:39 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 044832808F;
	Thu, 18 Dec 2014 22:54:35 +0000 (UTC)
Mail-Followup-To: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261542>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2014 at 10:19:19PM +0000, Dan Langille (dalangil) wrote:
> This is what happens without a valid ticket:
>=20
> $ git clone https://us.example.com/git/clamav-bytecode-compiler
> Cloning into 'clamav-bytecode-compiler'...
> Username for 'https://us.example.com': dan
> Password for 'https://dan@us.example.com':=20
> fatal: Authentication failed for 'https://us.example.com/git/clamav-bytec=
ode-compiler/'

So there are two ways to do this.  One is allowing users to clone
without any credentials, which I take it you are trying to avoid.  If
that *is* what you're going for, I can provide you with my Apache
configuration, which does allow that.

What I would recommend is going to
https://us.example.com/git/clamav-bytecode-compiler/info/refs in a web
browser without a ticket, and see if it prompts you for a username and
password.  When you get that working, it will probably also work for you
with git.

You can also run git with GIT_CURL_VERBOSE=3D1 and see the protocol
exchange printed out, so you can see what's happening.  You'll obviously
want to see if the server offers Basic auth as well as Negotiate.

You might also try specifying KrbMethodK5Passwd on explicitly.  I don't
happen to use that option (I use Kerberos to avoid passwords altogether)
so that might work for you.

I don't know what version of git you're using, but some older versions
will still prompt for a password whenever authentication fails.
Therefore, just because you're getting a password prompt doesn't mean
that providing a password will necessarily work.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUk1soAAoJEL9TXYEfUvaLf48P/jJR/eDgux/UzqWhhPaoHFK3
5ayPXgmLwJGxn6WWJLMlYCbG1o6NP0/S7eC79sQ9jSHcJS2T1i0yPepdQbQYC9J8
KiCUx1mhORSbylTENKgnAH6dUE2q5H6px87+B7OQ8kHWASaBe30ti4aIwQes2ZMj
UOqo8J1KddWvVlHybUdP/65Ft5x8KpPiXfFy8PxmNK3V3W8aCTSr8uDK2lrjd3kW
LiX/N6+2PSkPkmlNb6Sg3zokOfJ/Tp4nRh3GQgK+iQTnZb5+PSuNqhdpEh124/2U
ktoYctN7dcpFQhcCb8CUDQNMB4VE8f12GLSqXSyShybR1cKNAeeGoyW55HBbzkeQ
50kNn3pPLagBna0M26gvlzds0Pjp6hOkAVG8v9CpuX6Avc/WaCnLKD86sldqqHZ/
oZzRkyBoaTpo6XO04jxRm8fpUDPDE890F53jNK2FTBUHH1HZDfEPk/pJ9d3Zw4E/
csCRwX76FDWYkYCulS/ifUUjRBtmNbR6BzMPG5YVDiIeEJR4dL8xL7rDOve+M09c
rg61VbebQfQJuXhhsqBnoFYVZQSq2UdGOeFjgdBsu1m8wXthGJEPWHafS/lD6sUy
JMCYQHljapo30Y2Zkzow71i9jA7G5csOCZHr13l+HuwkRFrYtFwGEKlfy5gNtLxn
EohL5fJagTJCzwHT71lq
=e8kf
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
