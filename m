From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Conventions on struct copying?
Date: Wed, 18 Jun 2014 23:31:29 +0000
Message-ID: <20140618233129.GK368384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 01:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxPKP-0007D2-9s
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 01:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbaFRXbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 19:31:37 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48414 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095AbaFRXbg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 19:31:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:4482:19b0:51d5:328f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B2DCB2808E
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 23:31:33 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252081>


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm still working on the struct object_id patches, and I had a style
question.  In several places throughout the code, we do something like
this:

  unsigned char a[20], b[20];

  /* do some stuff with b */
  hashcpy(a, b);

I could implement an oidcpy that does the same thing.

  struct object_id a, b;

  /* do some stuff with b */
  oidcpy(&a, &b);

Or I could just write that as:

  a =3D b;

and let the compiler do the heavy lifting.  Is there any reason that
we'd want the function for that purpose, or is it okay to just use the
assignment?  I don't know of any place we explicitly copy structs like
this, but I don't know of any prohibition against it, either.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJToiFRAAoJEL9TXYEfUvaLKqUP/R2tI1kBt+xdt+0h/Q3Ra24c
Lba+7TnvWHwZHcotv3YAi50NRDnkEfzQTBJdAslCB3pQt6SPzTurSksA7ZBZliHZ
8l3nxHnVa68SeCLLcZRlbpvGqPglaTAQqz5yEYxkLoM/fdN7GUlGQa7s5f5LsICM
q4SxTMPyPSNtUWry7uHQXp4LeVnpqKbNTVpc8c3UV3AWNufzw6eFlGPTpSRFFfa0
tRDUneEDRRCL6dYTeD3a2SrrXD9NsUx8bYhrzJESEIDALvgHysg9oZijYpAn6pfq
6M/0oSHqIKBmlOSZ0To2rDcxKQq3PhSBh5jDWWbDknN6RUgDHLCw5H4yg7J9rv9E
vLKOZpiYvv5LT0KBelPjaWO1u4k+XbgGq47l8F3tLDhlmOCBbwniKPIqKV3Q6t62
KbA/VtJlQDdDarQ1ve9m9GG3NSrKkVUthNtuXpW3gZUM05HqJESUOBy+os5VNvJR
D7H7Tfoqlh8Eim1Wa1gmGfozq7h4Y0ogQBUvr+A7UbNJe6nwQiOXH7zWqEUGyAwj
4jhJrObWWhv+EY3JNctDvV85VND1gcWsCvt4xxmU2VW3CQDn1CauuUiOu19Ve9+S
T5EP7GGCKb2nknhvPg1VnpxSyMFHTb/3wvcE+NTUUstAimqI13Ig2p2whduLgSiC
PgeV8hjZDkNWiyAOKP5w
=u9KE
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
