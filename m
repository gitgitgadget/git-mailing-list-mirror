From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http-backend: provide Allow header for 405
Date: Wed, 11 Sep 2013 02:14:00 +0000
Message-ID: <20130911021359.GA118418@vauxhall.crustytoothpaste.net>
References: <1378664106-95936-1-git-send-email-sandals@crustytoothpaste.net>
 <20130909041812.GA3430@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	jkoleszar@google.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 04:14:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJZwb-0006aw-96
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 04:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab3IKCOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 22:14:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60211 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752382Ab3IKCOI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Sep 2013 22:14:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D8C2128074;
	Wed, 11 Sep 2013 02:14:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130909041812.GA3430@elie.Belkin>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234518>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2013 at 09:18:12PM -0700, Jonathan Nieder wrote:
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -594,8 +594,11 @@ int main(int argc, char **argv)
> > =20
> >  			if (strcmp(method, c->method)) {
> >  				const char *proto =3D getenv("SERVER_PROTOCOL");
> > -				if (proto && !strcmp(proto, "HTTP/1.1"))
> > +				if (proto && !strcmp(proto, "HTTP/1.1")) {
> >  					http_status(405, "Method Not Allowed");
> > +					hdr_str("Allow", !strcmp("GET", c->method) ?
> > +						"GET, HEAD" : c->method);
> > +				}
> >  				else
>=20
> Small style nit: the closing brace should go on the same line as the
> "else", like so:
>=20
> 				if (proto && ...) {
> 					...
> 				} else
> 					http_status(400, "Bad Request");
>=20
> Another micronit: the comparison should be !strcmp(c->method, "GET")
> --- variable first, then constant it is being compared to.
>=20
> The functional change looks good.

I plan on doing a reroll tomorrow.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSL9HnAAoJEL9TXYEfUvaL9ygQAMRa8JU6lGynTeHqtq5uQay4
QFGEXb4Vuj3Ela7ot8NMQxavQHQQFbzlOEKfYS08c3uecCQ8c++miskp06fMOzrR
RD1+ia/vphmp6hXPK8XuzDpwdEOM1Q8y2peCVZ3g7DsM6CvZ+6PAPp/LyiiuPSzK
IdLaVCQvzACDaZ1gprrsXx7ywIC3fbc1/KywcmUe7xZY3HWd2HTiWhaJfllNbE/Q
z38AnewlYAMXZEhqHVxPrPL22WZb+4ntdZQu7jFwJGvoB3dxUkHgejP0ITUeXwl8
RkJt4IK+BwPa3ngvW+aVamcQDmKAOxLSVoxaHd/IarqYrJTxwasvxJkpT+p6dp8x
TGvNn02ebAyDEUVNFrpDKOE8uGEhC14LrwuiBHuzUrkLLcOeeshqES+rZb0XB0F9
ddGRfdGrgqqwrN/0KTWhDODTMbTd9pjJA7BN6c2JblqZRJCu1Oywctmj0AU4clIV
M9afOFuUhxpVuJqCKPfvfkq/g5pB6nvNIzDj/4dmErMbSWiwAwiDf+GObmrcbHxQ
iDU0BisXwm7fspaws9EdZ4+WwOzZWS3RkJ0a6ccy5P8y3r8puAFAAm41mDrAQXtG
xWMoVlIYXWvXNUV67hVQ5574rwqnFYL3yQCigxbGaw7TJW3u4dEKxjQWr2eMtixy
7DG2fA3q6JhY1vSvXEQe
=zjYV
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
