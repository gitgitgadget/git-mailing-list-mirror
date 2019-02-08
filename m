Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CC41F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBHLpN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:45:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33874 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbfBHLpM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 06:45:12 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F36D603C6;
        Fri,  8 Feb 2019 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549626308;
        bh=qf2olCLWUDHcpe3QvgQiii83jb/e3Da5Ibc4606fFeM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dw79YIm9qhjdWcgfQH0DuDBwM1K66WyjuF4dMp+RlhwwBzi3g9on+L9nOW5DW7j/z
         /0d2bB7geiL7UUYm1TcTO65bgiAti0lCh2DD2rPyvtlUO4o/vG5ADvAxioTY8upCuI
         h5YnyMRqUwZmf9ot4bDCZXl+E2zbnDb11figDjX3Xfya6XlwLUzBoBTxWjoLNwM0Od
         7FQl8VVDcN7/CqyIOamXkcodqPta9nVz7rBPpLofsWkkaQUfkw0JF7uxAQglNh+BbP
         08iRp+Czl7fYWc8696Fhme6Rrxeds3gUk1D4K5MNc7mcf/uj2GneNgJa685+AJu2kH
         sEG0quWWuqL7AaiecrfIGfOf6B7KxHmr5Hd+FS3KlLwzD/uVTs/iG8LYuJ0ZOHSJWz
         qYPesl42iJtrnqqesLmrlYsSgjbQ21QTp7klhRkD8RjoBs6MIZ3Y/yK5bLgICpU1Jh
         /SL1Dwx1E8m25uN4BB9ccYQa0c0RBvNmem/sIcLj6s2ID+u2xFN
Date:   Fri, 8 Feb 2019 11:45:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Rich Felker <dalias@libc.org>
Cc:     Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208114502.GD11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rich Felker <dalias@libc.org>, Kevin Daudt <git@lists.ikke.info>,
        git@vger.kernel.org, larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <20190208060403.GA29788@brightrain.aerifal.cx>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 01:04:03AM -0500, Rich Felker wrote:
> That information is outdated and someone from our side should update
> it; since 1.1.19, musl treats "UTF-16" input as ambiguous endianness
> determined by BOM, defaulting to big if there's no BOM. However output
> is always big endian, such that processes conforming to the Unicode
> SHOULD clause will interpret it correctly.

It's good to hear that musl now supports parsing UTF-16 BOMs.

> The portable way to get little endian with a BOM is to open a
> conversion descriptor for "UTF-16LE" (which should not add any BOM)
> and write a BOM manually.

Right, I think my point is that we have existing systems which we know
ignore the SHOULD and assume something different. Perhaps in retrospect,
it would have been better to use MUST to specify areas where
interoperability is a concern.

> In any case, this test seems mainly relevant to Windows users wanting
> to store source files in UTF-16LE with BOM. This doesn't really make
> sense to do on a Linux/musl system, so I'm not sure any action is
> needed here from either side.

I do know that some people use CIFS or the like to share repositories
between Unix and Windows. However, I agree that such people aren't
likely to use UTF-16 on Unix systems. The working tree encoding
functionality also supports other encodings which musl may or may not
support.

If you and your users are comfortable with the fact that the test (and
the corresponding functionality) won't work as expected with UTF-16,
then I agree that no action is needed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxda74ACgkQv1NdgR9S
9otDRw//Qtg/1L9+q2n8V7QzKLk5BVLH5p/6/M6qs1s+bWUex9LShsuzjjmA29P1
ezKcyqCKBlBdSCPGgkOJaXRSiVZCa8TvmylpOaMD4QFfnZOHUlusv5KETamFaMK0
17k6vXWEfbilaQUaGQ4/S0TwtA+JGi945MH1mGyJLu/anXbmXa4BxKkeY8rNbF2g
rKqrfNNpVtjovQS/5Yb8vE3bvksKWNX7HyFo9n+ZpZLhVWIAOb11D40on9+LsX6j
RQjqylMiNAFq0scw+kSH/a6inPxbWfDZg/zQUzU+oGs9DUh0CDvBffKUpb+vmJR7
gLn2v04IDrvgD3jwWT/qux2bL1cqKUfCKD1+i1GAswmQ6hArlh0R8SVt4sp1jFI4
kyPNePxUW0OanenB/WS/O3GTfqJ5knuBzlNQpZHjwwS1n2uq4cJN5Ub3VG/mL3jg
uvJMiTQ0KdZ3lXndxjC1K/yrh462dP3uhTepKQtw3tn1foyC/xa/lHc8fYgdgLb8
MkTFLFSn22Ow91v4VbT/IN8Ri0tekZRgVujR3qo7hZ4gND1/1pnZ93ahLBZ6ims1
eTHSyTuA19fowbYoNIS89J38mzw6RL4qQjLdm6L1Tr1eAmxdpEVJYtZ5m4pefE2N
HL44K1GrdY612oKtPgy+Oyjm2ocIgYxvRsgn3tg0/MtntCITc30=
=KvsI
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
