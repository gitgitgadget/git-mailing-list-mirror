Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC8920437
	for <e@80x24.org>; Thu, 12 Oct 2017 08:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdJLImj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 04:42:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751499AbdJLImi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 04:42:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F02B36042F;
        Thu, 12 Oct 2017 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507797757;
        bh=pzVE6TrCmFRtW+wrpjcwFvTPQTR4klHHvpuezrKUOUM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rcCtPIvsDL5Lk3r9siJs8yBaZsoa4JSZm8j8jlPBF+Fx2A/e0oFXwN3+leeM5h3rD
         MScqx9JNqFGDcwQkRKXYvhzqPHPiaZFHL9orT0FSBFTY4mZRL+yuGC1/TYxKF9fQDa
         /fbt8MAfHHFIHAUUtDLZBvpaKhsbXpGFQfcEF0EwWf6cMJ/14zxqKBiHVj+7o1ilDb
         cyzKBUIdnTUruuUwwsWsMsBDKvV7fiqW/+7b9CinP2kQfyNHVeS+0Gi4LKwci8G7H5
         lbIvjjomI3aD3g6dC+f+KOKyrQ+aoNoDyA+OIVS87wRZ8vnTtor/p6yCDGsCoKtW+M
         rdK3OWunMtHhl+YXWn6IkpsjGn5+bIFqXPfI553aV8se72qS5Qv+Kg1kZs9YYEURBw
         D2PCg0hWc6CUm/fSBJqLYrKPy/DsLcXwMJNwbCyhHnZ1dlFOSbaCYx1poc1C/MIZwq
         2342cGic4ae6R+qn6MrDxAWL6+i4AWTzj9CZkf14t044hFsUoMu
Date:   Thu, 12 Oct 2017 08:42:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v2 04/24] refs: convert update_ref and refs_update_ref to
 use struct object_id
Message-ID: <20171012084232.gag72xmflhpsk6wo@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-5-sandals@crustytoothpaste.net>
 <9d4c3854-38fb-d5b4-0436-0eee707201ab@alum.mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3imbzqujlil7ex4o"
Content-Disposition: inline
In-Reply-To: <9d4c3854-38fb-d5b4-0436-0eee707201ab@alum.mit.edu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3imbzqujlil7ex4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 08:33:46AM +0200, Michael Haggerty wrote:
> On 10/09/2017 03:11 AM, brian m. carlson wrote:
> > diff --git a/refs.c b/refs.c
> > index 0a5b68d6fb..51942df7b3 100644
> > --- a/refs.c
> > +++ b/refs.c
> > [...]
> > @@ -1003,12 +995,12 @@ int refs_update_ref(struct ref_store *refs, cons=
t char *msg,
> >  	int ret =3D 0;
> > =20
> >  	if (ref_type(refname) =3D=3D REF_TYPE_PSEUDOREF) {
> > -		assert(refs =3D=3D get_main_ref_store());
>=20
> Was the deletion of the line above intentional?

No, that would not have been intentional.  (I would have mentioned it in
the commit message if it were.)  I probably accidentally deleted a line
in my editor.  Will fix.

> > -		ret =3D write_pseudoref(refname, new_sha1, old_sha1, &err);
> > +		ret =3D write_pseudoref(refname, new_oid, old_oid, &err);
>=20
> This is not new to your code, but I just noticed a problem here.
> `refs_update_ref()` is documented, via its reference to
> `ref_transaction_update()`, to allow `new_sha1` (i.e., now `new_oid`) to
> be NULL. (NULL signifies that the value of the reference shouldn't be
> changed.)
>=20
> But `write_pseudoref()` dereferences its `oid` argument unconditionally,
> so this call would fail if `new_oid` is NULL.
>=20
> This has all been the case since `write_pseudoref()` was introduced in
> 74ec19d4be (pseudorefs: create and use pseudoref update and delete
> functions, 2015-07-31).
>=20
> In my opinion, `write_pseudoref()` is broken. It should accept NULL as
> its `oid` argument.

I can stuff a patch in for that.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--3imbzqujlil7ex4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnfKvgACgkQv1NdgR9S
9osIVw//VqBUDjkQE3KGpQl7+JWQQAajJ2VSrTbBeioAiyOEDMQZdfMDo1rUOTzh
tErys9qdzae8gzfMPuvQsPOsS1Z7OlGDCBWAvSDtLX4bWGNpsW/bveN6RYrNGdxo
HWn8h0bXvoQsZXafPKtdQIToJC8jCS3qUfToiNlMTmshjQE05eGDFXVLAExEeINs
asuJDjV+ptN6vVP+p5YYJfgpBa2LYk9ojxvgJrV9bLmrC7Gs6oNaSZdRZffm4WQf
w3TSuSFjNZSLFnx4hALrAGJHgbUrIgHKP1Vwa05emz1YZUevPQn/zPn7oI91qMWv
wCi5O33Nz90fzF2CJvsW1mUfQBPcnqlyw3QUtKOilzcBxkVif65WSTz3pIkfao/K
Bj1wLJNPTvJ60AC4YaB1c1jEya7QW3Sf5Jhr5mzSQgCpidjOr2NuNxYRhnVvebfy
ymlZ3whpsaGEE3sBvzTupCwoHt86hdOHMu5bwo29uzcXQAnifWDovFSoNF5O4hPA
Gha0OiXhr/Ziwh5NIo97PRCmrQSnWT3Zyzhb88GXBtojAuXVvHbLvoYiM22I99h7
Clkf9Wkc8zL7DwZnPwP6/cUxFGTEv8l3gzlYlWuzpeCc8Fq7Wm73zNGmSAiAE1Zl
HbPQ29Yli3xdL6Yr6b76oGRitTh5O/nXfGYAuVnbYYw+63la50k=
=4BCV
-----END PGP SIGNATURE-----

--3imbzqujlil7ex4o--
