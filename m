From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] pull: add the --gpg-sign option.
Date: Sat, 1 Feb 2014 01:01:00 +0000
Message-ID: <20140201010100.GB635004@vauxhall.crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
 <1390524666-51274-10-git-send-email-sandals@crustytoothpaste.net>
 <xmqqlhy1m27b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 01 02:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Oxg-00070r-UI
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 02:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbaBABBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 20:01:06 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51532 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754120AbaBABBF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 20:01:05 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd82:88d3:586c:5bd8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8AFF928071;
	Sat,  1 Feb 2014 01:01:03 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Vigier <boklm@mars-attacks.org>
Content-Disposition: inline
In-Reply-To: <xmqqlhy1m27b.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241327>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 03:31:36PM -0800, Junio C Hamano wrote:
>=20
> ... but here it is used as if it is properly quoted so that later
> "eval $eval" will take it as a single argument.
>=20
> 	git pull --gpg-sign=3D'foo bar'
>=20
> will probably ask the command to use 'foo' as the signer key id,
> with 'bar' as an extra, unknown token on the command line of the
> underlying 'git merge', I suspect.  A "git rev-parse --sq-quote"
> in the earlier hunk may be all it takes to fix it.

Yes, you were correct that that was broken, and yes, it turns out that
your fix is sufficient.  It also happens to fix the issue where the help
text is improperly quoted.  With your suggested fix, it is now quoted
(ugly, but quoted):

  Stopped at aba3d3ff83b59627adbdafe1b334a46ed5b7ec17... am: add the --gpg-=
sign option
  You can amend the commit now, with
 =20
  	git commit --amend  '-Sbrian m. carlson <sandals@crustytoothpaste.net>'

Since I expect most users are going to use -S, either because they have
a key specifically specified in .gitconfig, or because the default key
is the right thing anyway, I don't see this as a huge problem.  I think
I'll probably end up fixing it anyway and then send out the reroll.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS7EdLAAoJEL9TXYEfUvaLvGwP/0hPt54+I6/x2r6icxUz54HC
M8IdTke/rX09Qrq4XdddmuSInujKq+3DMp8ST0mu9VH+1Iwt8l4muRPIEwuKJq1G
Sl/DgKarbhLKLm5Y1mHog2I4X7D+K+5jB/oCs3eRqm48OoA4otvUAJ2hh22jBjgO
eFqdARf70CdYPFZr7aikwFnLpx0X5w7YqI9LtoPGr8cWMEP6qPBrAUvQxEOm9E71
pbhA/7RfVDoQRrW4I/WX6Ojep4EV9SILGDWeY9bFAsspw5smHioCdp7nXf3lkOXl
f2knGx3pBo0Emt5OK+tfCm1WpaIuX5XJh8J+aZ6m/j8sk0NBxDqEWuI1eo7MH6oI
oBPutxTMl/8yL9gQupXG1dAWE63+5/X7FrdtaiItzEXz5jYkNy1ScLrmpPCdXTaM
K0xi2rQB9Y01kh89Yx8XTRbiNeu3e5VgIsIz8stAU3J4eqSEO3WGMxmb/+IpmsUA
uHmisU6Hcp9z01RSVFlVRdv2QoitZXwH70Z1n62LmrkEVIUkcVcXmc+m+k+CTj5m
+LhPhSYEftmUTRcg/z2TFMEJyi35ITbFgyLC/7yiO6JaIZk3U4D5NnY/93DRp8kG
eTMKZNcUDSB27BG4kyYss/35WGDGD8gC+pamASaI9pljFt+sOkBH9CuteBZjRLW1
qwhX857llLppM8ct5hlM
=JHiG
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
