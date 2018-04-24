Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2451F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeDXAbS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:31:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60838 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932574AbeDXAbS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 20:31:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D06C60400;
        Tue, 24 Apr 2018 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524529875;
        bh=QRtGTowD6hRtOLPNQCdVsvouyaTYsSYjfqWMXisM1A0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ao4NkGgaz9i6yr3QUEkXKQsozOx8szjd1EFU3p1oobLKDJIbeKZVexF+yt1jxyXkS
         omuXRYoRTKSfqAPEYkCcLqmgntHTJKVDB/Ax/L9PKvOdWKHfRG1zQI+MDn14z+uBtm
         eV2vhF0fatn0A6J78JkiyQ2kh1wvyqzJa9E7DOqYeMmL8kSlHgjpJxLXnUzAI//doT
         xSxfotYZ2SV1+oU+5NZf0qH8xI87A6wln0vN+UMW3Iqm1xiCqDZiw9oiq6YPMwZ0vq
         dIThYCs9u364a7aLyhRRpqjfMOuD0rX53TUmcIr+wtRGZZnCUx3+qahQUFhS75mpHC
         fG4UqwOTkIFq6HhqN6VVJCxuCWSK1mqFCPHKltEo3Uhw/XJr+xJ3olcsLkjeXfzQCI
         kGbnQGfKs9tnZH4caiF/ANopQTJsPLNgeYbYizd3uwdFwYTsqMZZIcic7vbMcM+64Y
         cW5F0mGEh3HPQmgFjgFWB6cPQfF+dWW5YqxAVGhY6HyV//jtpQr
Date:   Tue, 24 Apr 2018 00:31:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] cache.h: add repository argument to oid_object_info
Message-ID: <20180424003109.GA245996@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180423234327.250484-1-sbeller@google.com>
 <20180423234327.250484-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20180423234327.250484-3-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 04:43:20PM -0700, Stefan Beller wrote:
> Add a repository argument to allow the callers of oid_object_info
> to be more specific about which repository to handle. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>=20
> In the expanded macro the identifier `the_repository` is not actually use=
d,
> so the compiler does not catch if the repository.h header is not included
> at the call site. call sites needing that #include were identified by
> changing the macro to definition to
>=20
>       #define sha1_object_info(r, sha1, size) \
>           (r, sha1_object_info_##r(sha1, size)).

I think you may have wanted to write "oid_object_info" here.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrees0ACgkQv1NdgR9S
9otnmBAAiw2pcei8hR0ovQszqDuDVsJrnFMD/AboTRYlrInaSFQJM23e/AYAVNqc
xEYWqMwWeEMj1k6iSPjr9MQzSJr5cli8QesgNdtMdjHibdTEnNl2MOF2JV7HRuMg
MZitX+xp6ia8n90YBZTb5Zwr/tfKbT5qeyamUE7XjoIZwfm9GlMqlGCPVscvI8PK
uZ1WXr9gazR7gZ5q46fDcXSomhx7dTNivlf9Gys/RtnROI14jC/gyO2n28dLcxjK
Kbe4zLhJOWp0+tMmFZ3h3RAWrA38T24YlfuKW9u0tEDUl1gnj5hTqPnYOacYAzzR
YeW2nYeJA4CPHsgB9mAk5FXOFZHSRIeNiFh4KeAnY6Zs8+A9w28/IlWc/uN0Wgo9
c+CX2y6I6CZG3HdHpQuLdnHqBv/rYikWOcvkxrn1V4cMVLhoY/8I0RKITdrjZI11
X8JT+KJ4O1JvlQXEMkdflLIzlvjPxVk/C9KqDuRQ0ZPRAOf3T3eMUK/qglww9NUq
kzZItsM1d+yzlE5yY71F/TMa+kvCS7E4lJ7MQ0FUekzIUXKtdBi6d+MlwDCopFt6
v3n8yKXQlBepBTPgqhyB82tdSTqNho1KjLN/Hvh2HV9FIx49eK2GG4ZSm24sDQii
kf2AI3P1OtJJOh4qPeRk+QG6WWLMIZX9PCDyMirzba2vd2tlw10=
=Df6r
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
