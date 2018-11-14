Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF901F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 01:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeKNLoO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 06:44:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbeKNLoO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 06:44:14 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9968E60489;
        Wed, 14 Nov 2018 01:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542159793;
        bh=oVk57nYcZDGy9ke5GneNTsN7vTRnAd5uWY3zO6jTw9A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=p/XV+ASrf7FeOAyUqpnPwW3kM2ZMg+o6qzPjSd9n5dDAet/9h7W5vZFvYeedtidnt
         8x/XaHdLcnGbm4fCMmPOYaMNxsqF5Qac7FWz/o4tEP/8ik7HUWlr/VTpeh3+k479cC
         9AHqXWjCKG0bRSIqPSeEXY/zKMDMm6pv6NMXiTmLhGpW+UbU8vszjkHYeIC7LHrVG4
         bGWtm9DK9++HpdfJFmKt4M/Znljiqt0PJEJ0JXNNjWg3rKxuKRSp+vKLXQuYD1gCRn
         QzR2DCenDB2f/CN5kjr2ktX9e35ZBzkcX7On368BCIOApMDVttE14crHBXbezdKqTN
         ptWV1wrUlDgriqaSw6JR5MzMiuKreYAJhYWigX7B8ALiIuTu7WoBjvU+QBLKOJAKO5
         4EHpGF+BHoJIa7qC9tLuKgjGxUWmMWdL/7C2x8W5Dgaym3OJiTQYNg03YJoblJllCq
         UtsLpzHd8ZewadIKxQhlo093bE02rliTXKoK0OnowNLenMhCPGW
Date:   Wed, 14 Nov 2018 01:43:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, mduft@gentoo.org, stefano.lattarini@gmail.com,
        kusmabite@gmail.com
Subject: Re: [PATCH] git-compat-util: prefer poll.h to sys/poll.h
Message-ID: <20181114014307.GM890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org, mduft@gentoo.org, stefano.lattarini@gmail.com,
        kusmabite@gmail.com
References: <20181114011043.27419-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sMkrXc3gAYLRVOjR"
Content-Disposition: inline
In-Reply-To: <20181114011043.27419-1-congdanhqx@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sMkrXc3gAYLRVOjR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 08:10:43AM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=
=B4ng Danh wrote:
> POSIX specifies that <poll.h> is the correct header for poll(2)
> whereas <sys/poll.h> is only needed for some old libc.
>=20
> Let's follow the POSIX way by default.
>=20
> This effectively eliminates musl's warning:
>=20
>     warning redirecting incorrect #include <sys/poll.h> to <poll.h>
>=20
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>

I think this patch is fine.  This was in SUSv2, and I don't feel bad
about siding with a spec that's at least 17 years old.

> t0028, t1308.23, t3900.34 is failing under musl,
> Those test cases in question also fails without this patch.
>=20
> - t0028 is failing because musl `iconv` output UTF-16 without BOM.
> I'm not sure if my installation is broken, or it's musl's default behavio=
r.
> But, I think RFC2781, section 4.3 allows the missing BOM

While the spec may allow this, we cannot for practical reasons.  There
are a large number of broken Windows programs that don't honor the spec
when it says to interpret UTF-16 byte sequences without a BOM as
big-endian, and instead use little-endian.  Since we cannot fix all the
broken Windows programs people use, we need to emit the BOM in UTF-16
mode.

> - t1308.23 is failing because musl `fopen` is success when open directory
> in readonly mode. POSIX allows this behavior:
> http://pubs.opengroup.org/onlinepubs/7908799/xsh/fopen.html
> [EISDIR]
> The named file is a directory and mode requires write access.

Does setting FREAD_READS_DIRECTORIES fix this?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sMkrXc3gAYLRVOjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvrfaoACgkQv1NdgR9S
9ovgzQ//ciYjWKsyAK8FjnyYD5vDyfW1YuXqbOnT5zaGC1/fvRhWGf4NDYDNKtKh
dFPf1aY2jsGS5G06tNM8tzkuWwJKe/rBlthZCHcb9UyEDI/uYb4ZA9YxPuiLV9PF
NcET4BV8/7SkOF+a1lBaBiwJqNtFziLj0P19aZJXgabhHP1jyXyC4PXWhgujtLDS
iwwfyOBJSUPaGmq0fzvPJtXddRRtqxfNa5pC0zWW2BcGE8lAr/mKmf/PU2SGaaFF
Mn3GcvKW/QFPsui3t/mZvGjsIcoKxmv0s72hCJnFTnCYngWDYlF8as1TI97oF454
Myc8gMnggIdUTFHv8H2QonHjZEAszNDiOr5vA4FdA+/1gvIxhT1/CsSHgnKD8GwO
4U8y65vq9ZKunfPsqczq6pq4iRiiTkjIgnuRbd+MmfYJSfwmXxtcpcy6t9jueJXO
Y5qpGjbi6dZMHRpE32sPXPsO1jix6gl1No0LxYV/T6+E5t8ISncKIBzRGT9k+FcK
+8Q6PeJuIEVXZIAHaV2tdsbHTT27rH3INA9Wyr9/wKbRBc2uUdNXCAPEPOjN4/6/
nLMZnS0HILSGXwWP29yOAEwCQ3mDZPUHJteZdmhZ5VD9c/QTEU15ySAJKB5dxJlr
3sGK4T8X8qB1+M/jT/vS7BML2oB1OjJ9liRNh47KWhWZ0o6UfUY=
=N9cM
-----END PGP SIGNATURE-----

--sMkrXc3gAYLRVOjR--
