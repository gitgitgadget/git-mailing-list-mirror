From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 02/16] refs: convert for_each_tag_ref to struct
 object_id
Date: Fri, 24 Apr 2015 22:37:47 +0000
Message-ID: <20150424223747.GB322887@vauxhall.crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
 <1429745061-295908-3-git-send-email-sandals@crustytoothpaste.net>
 <CAGZ79kas9QgJy1ooCjHPR+ZGGuTdMhTxO9zSMxnGpPk8rG5_xQ@mail.gmail.com>
 <20150423192723.GA29220@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:38:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlmEW-0000w3-ER
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 00:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946098AbbDXWhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 18:37:55 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:46901 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946086AbbDXWhv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 18:37:51 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0F2B62808D;
	Fri, 24 Apr 2015 22:37:51 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
Content-Disposition: inline
In-Reply-To: <20150423192723.GA29220@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267763>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 03:27:23PM -0400, Jeff King wrote:
> +static int do_for_each_ref(struct ref_cache *refs, const char *base,
> +			   each_ref_fn fn, int trim, int flags, void *cb_data)
> +{
> +	return do_for_each_ref_generic(refs, base, fn, NULL, trim, flags, cb_da=
ta);
> +}
> +
> +static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
> +			       each_ref_fn_oid fn, int trim, int flags, void *cb_data)
> +{
> +	return do_for_each_ref_generic(refs, base, NULL, fn, trim, flags, cb_da=
ta);
> +}
> +
>  static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_d=
ata)
>  {
>  	unsigned char sha1[20];
>=20
> You can even dispense with the _oid variant wrapper, and just call into
> the generic version directly from the new callsites.

Sounds like a good idea.  I'll reroll with that change probably sometime
this weekend.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOsW7AAoJEL9TXYEfUvaLAP4QAKCorUU99z/kcWr6NpTVXq0n
LkAW1DzGThoC1BcLw9lTUPid1BbxNrQMrfDLHwugZgDl/kU+5FRoPKPq4YmRla+k
b6E0uDMJdn6sKseoaXjShvn2kBp/5j7FixMsEsfiVRCVEbTFt6eVjFeO3LGr4NOe
X+uD/tmd8hnzF21/RsTU7maZl75zaKBHN+fDvPdDzNRW9jxk1FQeEuAR0T6Pn31B
ckxKVVd65s4qJypTRK/9fGJNKN8CEoqCmUt3GI8CE98Rti5BBsarmKmIEZquHOV/
yDz3HT7UqHL1DFI5gKSvUl8gSQiRYo7yx9aa5P94ivRjcCw+ucxawbMtlmL8Fix6
EAf79cc8gFK7nD2lsRVMPyODy7x/KMo58yDq5bTBcCsbOySnuaeqyKNvxivKxOdF
OyTlRLxrpNsSVeyzHZGevJzvMLLC1IDGDbGedGgqaPxrdvYNu0Kh5SF7OhSjKrJ5
LbN6x4qUgSS3Akjyp7k257wACdKtRCdSP57GDUKv9BCkNobI7z4zQh8dkBbx5BYh
WR2PWlbvXERPfIf+lhBnM+gJ6SY7XtBhAIreRLb36K8Oo2wjKGcJveFXQTHFGBzI
1jBuyp5R78/LlBBi/rocjw6BvbomS7w5UvJoeVN9/iHfvEogsh/bbymBVQqVMr4d
fTG2wUYIDA8m7mNauYWG
=7Uuc
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
