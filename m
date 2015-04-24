From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] connect: improve check for plink to reduce false
 positives
Date: Fri, 24 Apr 2015 22:48:33 +0000
Message-ID: <20150424224833.GC322887@vauxhall.crustytoothpaste.net>
References: <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
 <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
 <CAM=ud8zKE-Huq_ZGVq9ycFFw+R7TBkQ5R4tcwfha9OBm_geASg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Pete Harlan <pchpublic88@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlmOp-0005VC-N8
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 00:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbbDXWsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 18:48:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:46907 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755801AbbDXWsi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 18:48:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 540EF2808D;
	Fri, 24 Apr 2015 22:48:37 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Pete Harlan <pchpublic88@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Content-Disposition: inline
In-Reply-To: <CAM=ud8zKE-Huq_ZGVq9ycFFw+R7TBkQ5R4tcwfha9OBm_geASg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267765>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 03:46:30PM -0700, Pete Harlan wrote:
> On Fri, Apr 24, 2015 at 3:28 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > The git_connect function has code to handle plink and tortoiseplink
> > specially, as they require different command line arguments from
> > OpenSSH.  However, the match was done by checking for "plink"
> > case-insensitively in the string, which led to false positives when
>=20
> Perhaps s/case-insensitively/anywhere/?
>
> It's not important that it ignored case (your change ignores it too),
> it's that it was too lenient about its context.

Yes, I don't know what I was thinking.  I'll wait a bit to see if there
are any more comments and then reroll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOshBAAoJEL9TXYEfUvaLSH4P/2gYZHW85UAQDZg4+D6bnBYN
4iZGv+cOhdo4wbRFyzVjmUNnyvseF9KKPZxODL29+wXzofBJh3XW2zQUMowqpVhN
zdnitWG59O+8IT4Y43jH/7N8tCpfuD/CWdMQLub6waz3qCTkd8Dupj0oHAJ/wxZp
uevaLdPYSV/8U7OXATc+cRRl6K9bZCchhuKfuIzCa//wG9taWHNU+81BYs6tWI1n
kbpGvoopBABPhqqFaWPK5lfUY0TO/2awbdrKuD8TFwqnJ1xVj/7qU18WvqVrOLIy
VHpnmc4f5+0phKQJUynAFkUGXfyvLxcMk7QS3gZV6vv8Ru/rUc9hpNbfnwl409PX
D9huiHEE8qwjo+Btw+o0nZS0o1LeQ4qdD1pT+eEsIFU99B3D/jfXo3Y2f8gTgzf2
wkQyT2fbJoEC1D/PMERZxkvXTHmTk2la97r8GN83PTbUmLDs3MKY5G5R7eJ0exgn
7KSW+6JcoCFcC5Hhyyc9TiUHnXnnatTpsZSh8c1RzwoTp+bJn5tmSuYL7HZ9Z9Qe
8+IKwmnRD6L5TJy+ZHuUpU3JvokvK60Rt1E/pMiEva6A5/ZT7vi4I/4D0zCo2KUm
30/TiNwH4aMwLkZTRdDJ2V8v66ouhLRu084g+NS0LsuO4Cz/0dSwcBXL4eqqOGSv
MIYm1y/mCEnUCKeuqrZE
=7Vpj
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
