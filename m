From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Fri, 12 Jun 2015 22:27:13 +0000
Message-ID: <20150612222713.GD29305@vauxhall.crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
 <20150610235114.GA786544@vauxhall.crustytoothpaste.net>
 <20150611000251.GB786544@vauxhall.crustytoothpaste.net>
 <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
 <xmqq4mmef22j.fsf@gitster.dls.corp.google.com>
 <20150612203054.GA29305@vauxhall.crustytoothpaste.net>
 <xmqqvbesbmm6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:27:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XQ2-0004fj-Nx
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbbFLW1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:27:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:41739 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754692AbbFLW1R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2015 18:27:17 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:81d4:30df:5b4f:7cad])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A65492808F;
	Fri, 12 Jun 2015 22:27:16 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <xmqqvbesbmm6.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271538>


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2015 at 03:14:25PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > While I did run the tests between each commit, I hadn't noticed they
> > were failing because I don't have Apache installed on my laptop, so they
> > were silently skipped.  I'll resubmit with that fixed.
>=20
> It is somewhat strange that _only_ http part had failures like this,
> and is unnerving, too, given that a few people seem to have given at
> least a cursory read over the patches and didn't spot anything
> obviously wrong.
>=20
> Was that because there was a single manual botch, or was that merely
> that other parts of the system do not have sufficient test coverage?

It appears that I broke the change in "parse_fetch: convert to use
struct object_id" which modifies remote-curl.c, so I think it's a single
manual botch.  I'm going to rework that patch anyway since Michael said
that he didn't like the idea of parse_oid_hex as it stands, so it will
end up being mostly moot.

I mostly introduced it in an effort to avoid having to use
GIT_SHA1_HEXSZ repeatedly throughout small blocks of code, but since we
don't use assignments in conditionals, it doesn't seem useful as it
currently stands.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVe1zAAAoJEL9TXYEfUvaLmD8QAIvns4cSNagALcWwb4Esn+gf
oeDcstBuRY+EE45ohnGvGbNaexnWOtNpED7eirR08c9hcd4zbNh6RnJpRF4wgvVi
TARglqgf8pgIcYT3UKsFIpKmZ1pAa0MXFEJ4zT4R+71MEXLhpHRDslIcufqxSEnf
hetwj5p3p2N48qNH9rc3GQLc3EmKLSQ38vPS0SmFTE+2LYiq+CcG2+z985fSRBIG
3/HGUC2P/CKk3qVINvRUIYDmJLsh+WW0qOlod6puGU09tIAUXCrGqryKCdPL+Qn0
Zrp2BLbwH8ck/AsRrHQ7gbQ8x7cXoYHyoBpqat+YAUGGpLobzP9e2fMyS8vUJrSb
4+7PyPjmFUIDuoyXkhjukGEYlBs4U+mG69xXV7rJlE4quaQcG7PGi69hv7EyIs3P
9g8MGRyfabMwiMjcsahmKZRO/RGZbxKWBaFF7YyvhEs1LGEkyJsZGAbTiF8pCsI7
xTL/KYPB/askADDcwCTOZgsDxAu8AaQZdVOu8ltwxRMjPPqmXXsQZ6NmL80JfR8V
4sOuQIlz4hP6Ob9E5qXhfEXK0g0G3vdi40GWHCuC2RGFYJAudhgGgZJVV6WrG5q5
VHccIgJipeRVXL2uIUANwIMnde6c6m0O9Tz5uVJo8bzaF8bHcYb3Ixe+SsRg3f6e
4yguzypbbDLFwricWelD
=kWVi
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
