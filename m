From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Wed, 11 Mar 2015 22:08:25 +0000
Message-ID: <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:08:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVonr-0005EY-2s
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 23:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbCKWIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 18:08:31 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50026 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437AbbCKWIa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 18:08:30 -0400
Received: from vauxhall.crustytoothpaste.net (ng1.cptxoffice.net [208.74.121.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8455C2808F;
	Wed, 11 Mar 2015 22:08:29 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
Content-Disposition: inline
In-Reply-To: <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265343>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 07:38:42PM -0700, Kyle J. McKay wrote:
>GIT_SHA1_HEXSZ will always be exactly 2 * GIT_SHA1_RAWSZ, right?  In
>fact, if it's not things will almost certainly break, yes?
>
>Does it make more sense then to reflect this requirement by using:
>
>  #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
>
>instead?

Yes.  I'll make that change in the next version.

>I don't see anything wrong with this.  However, in part 02/10 the
>utility functions all use "oid" in their names, so I'm thinking that
>it may make more sense to just go with:
>
>struct object_id {
>	unsigned char oid[GIT_SHA1_RAWSZ];
>};
>
>to match?

Michael Haggerty recommended that I call the structure element sha1
instead of oid in case we want to turn this into a union if we decide to
go the additional hash route.

I think it can also improve readability if we use "oid" only for the
instances of the struct itself, especially since it makes it more
obvious what code has been converted already.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVALzZAAoJEL9TXYEfUvaL4SEQAI9qvAZZ+guNQ9qDMPdX3AmP
TWrmENqh1ZgD66wJYxtzqTR0/L8Vn4PcO6NeAmknWdZIsFnlWURBxV2VctKIJqeM
Fofy7FKt1IMYu8VQ765i1OIi4jKJn7LcHNWacEoCEn885fl1OJYtHACKEz4nBCKk
wezNrJtYBWIurVzRfpbV78GlKRgKvCaUm1y2biRmrfiO/k1QUOxnHKeUQrUHVv8D
Q9J0jJYcFlAOpbjd89u44mQASG79WoOjIZF07q+41ab1se3I61FaP+clwM/R2GUA
nvt1SMMZUHoE7j/pXSGPrxElJWlchl8LwIICHJU4nYxe4mQnirjL4Af6tAAzXvmu
kw8vfe0WaZtVZDkHhMwLTt8zf3nKuXKMfOf0ukqX2n3wFc2pP1pH+T6RustPXYL+
xFXnB1WWpF2/oHEX9YH6i1ci2NsYfYmKw2Z5n/c+8bAQu8v7J4SpdNGFWVq5KYWI
LqTAblEFuzHVG6FIPwHsICSa7OcXkk7oKOBgQzhHxYgg6eJ+PbHZ9xjs0vq6RFUu
dfJwD9enIIJpkEu+4UdkPBDiWyAWPvjx09Tle8S0c13j2sjM2Cf0M/XmKqeF4l9f
5shhXEflxfbTWqy6EMo3fq1xH0GzxL8dJTEswbQk6vIo3/kvuC8NmFgQLGDTLKFF
cCjtGkSrdDEgwT8AUnGJ
=q/th
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
