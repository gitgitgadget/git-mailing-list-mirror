Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC6B1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408181AbfFKXfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:35:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405380AbfFKXfj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 19:35:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4429:e8a6:430:6b59])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2A5CD60427;
        Tue, 11 Jun 2019 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560296136;
        bh=bLZ3Dcdfmejk1/WlT7yLQK2o7eU8PycwOJ6L1dvo5Aw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AHtioKnOurWkUskcOHSE2RDPkelnBwC6DbX07ylSfdItl3OALkU8ejwTP/DJnLX3X
         agE5PNhyRpLwbDZVLbcEDWGHiP2BxWDdr6zY/CxZtmjWk+bgDJ4od6iHtU5LenoAfr
         1qvWd9wS8E4s3ol+LFbFmEBnoZVwVhHu47W1Lg/DYtpJBdow8D4IUhHOhxlODCvakt
         FOfUjz+wMa1KJ2xWrbvH13bDtqzi84mcn2+LgyrhS97TCX50cKmEG5gKZ1JVT+5+I/
         UDIf7beU0kzp6l+BTuQdNYj0MGGpJir2mzyg5XP4uwSWREcaXa7FiHqLuwLsuQrrGj
         tKJrbX7fs7stsfiOXWUKfZ++D6h/BLejmV4CxcZPdSUeuxxn2uWHoEtMMXI/f2QT5I
         X0NFO61zSnhbM1H1G26spq1Kb6qWXhRVK4x1/kxrQt6fJcp0+PnG23cRT/WgRpr8sJ
         lueGj18hIy49T9aCpSyoujIYBjdi+bGc4yVBGyvrHXosMQGjQym
Date:   Tue, 11 Jun 2019 23:35:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/10] t1450: make hash size independent
Message-ID: <20190611233530.GZ8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190609224400.41557-4-sandals@crustytoothpaste.net>
 <20190611230255.146381-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="obAtV4On+KRLREo5"
Content-Disposition: inline
In-Reply-To: <20190611230255.146381-1-jonathantanmy@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--obAtV4On+KRLREo5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-11 at 23:02:55, Jonathan Tan wrote:
> > @@ -84,7 +86,7 @@ test_expect_success 'branch pointing to non-commit' '
> >  test_expect_success 'HEAD link pointing at a funny object' '
> >  	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
> >  	mv .git/HEAD .git/SAVED_HEAD &&
> > -	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
> > +	echo $ZERO_OID >.git/HEAD &&
> >  	# avoid corrupt/broken HEAD from interfering with repo discovery
> >  	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
> >  	cat out &&
>=20
> ZERO_OID doesn't seem redefined to the SHA256 variant when being tested
> under SHA256. Maybe you need a test_oid invocation here.

That's actually coming in a later series. Eventually, test_oid_init will
be called automatically and ZERO_OID will be set by calling test_oid
with an appropriate value.

> I couldn't verify this, though - do you know if there is a way for me to
> run the tests with SHA256 instead of SHA1?

There isn't any way in Junio's tree, mostly because there are still a
lot of places that need fixing. However, all of those commits are in my
transition-stage-4 branch at https://github.com/bk2204/git.git, and you
can set the environment variable GIT_TEST_DEFAULT_HASH to "sha256" and
it will run the test suite with SHA-256.

That branch has a fully functional SHA-256 Git if you'd like to test it
out, and the same binary can handle SHA-1 and SHA-256. Interoperability
between SHA-1 and SHA-256 repos hasn't been implemented yet, though.

> > @@ -631,10 +639,12 @@ test_expect_success 'fsck --name-objects' '
> > =20
> >  test_expect_success 'alternate objects are correctly blamed' '
> >  	test_when_finished "rm -rf alt.git .git/objects/info/alternates" &&
> > +	path=3D$(test_oid numeric) &&
> > +	path=3D$(test_oid_to_path "$path") &&
>=20
> Double assignment to path?

Good point. Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--obAtV4On+KRLREo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0AOsIACgkQv1NdgR9S
9otg4xAApoerWDn874lXxoFe9a5EqB3tWTT4zAhdegH6wuOag+8QNPzO5Bh5GqRU
+D2rUIUS5HB2OjY7VziXdQYtdTMFSleFUp+YtRME7kX4iUXVN/C1PyAmDGT7IxWH
e9x68aY6pcsQDilECay/nV7D+ChFkF2c99VbMTPy05Yn2b7//rOfYHeaUj0k+hua
r8deH6VPhE/8TeU/Wohg31gRgj8/5gIlhYqimOsU8rZrI4w6VYBy4STqEuy2L3UR
l02uUqEX27arpwwv0XO3NUD3e6hOGnUNlA4FHMISY5+T6aktZXi0Fde24rjkA/HD
fT4WVQA+PCVSC4gVdleUQo19rN62JzGBdRL7WgHxLvw7R6c1jcx/XkG/wZ11fL/V
zxKm9GTmasZxLlFlpbL3+Ye9QDABubLZUzrFxup/UH6sAhElgUjrEwYSan1zINpM
hA4cmRmQ/7Eavv9y8kodgrDpaoC1qPHNmj9MEAVJaBiGcAK//lKZKlfps9ypVrtU
iHO3zA3ABY+8ZThDp3hZaIHu9w8CA/cEKWOTOkgdKpOTDFoPo+dh5A+u5lTNqEtd
u6biiRn3Huzr+bQT43rOIPMe1tGLK4BszLB9yiGn9QhNjfCMbVp6msIuhHzDLmOl
HkAI1JrGqW5JMfJGqlOC8MICBgaGTX0PcGTVSjxlWZVw3t5sZI0=
=tqw1
-----END PGP SIGNATURE-----

--obAtV4On+KRLREo5--
