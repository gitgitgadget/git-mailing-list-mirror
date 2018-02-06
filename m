Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F171F404
	for <e@80x24.org>; Tue,  6 Feb 2018 03:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBFDdG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 22:33:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58738 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751089AbeBFDdE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 22:33:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F0D36042C;
        Tue,  6 Feb 2018 03:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517887982;
        bh=EsyiZZtRWdmciqqw1omFC1v/+uEM3XCqprhl33LRlwQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jwowpSMZ2sy/SZ4IUKtxUfIM9p/S+pIhh+jILmQ8S/bMpQJvH34+psJFbIZySsapC
         FpUBho73crCdhxOrZ98Pj3QUhskF+H+a+taPiwzcgH3mjoHZL9gaYNxNYb1yVwu/Mq
         anWSSLAG9Z0keCdy4W8lSvlBW0QN/lB1uyCNwIGyLFiq/kE9RneSOWA2R0giTr7meL
         5g9Jtp+0x9/Ar5UonPOw8nOHArzGyXVYtCmi+6IJbhhOw4JuOdQcSgLKIsX67lApEa
         MEea7x8cdohQn2yKxushA2HeJmYp8KK7FPx0GRQRwyOTEI3q+tFdZed/t+u86eqHY4
         LH9/bC1mmTEupd33RC+S167Hwiga8g7CDFIIseQRVn1rvTIO1g/jB2Up9DyEHVtBzy
         gQndE8D8YATPHBBB63S+bq6pp967t7Qe9Jqv5JVE+t262324J23kGswFDCBtq1/J2z
         JD9JC4napXvujmpxsEqDSGGb3YgpGUxC+uEijhYAPgNz4AjkFdM
Date:   Tue, 6 Feb 2018 03:32:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository
 object
Message-ID: <20180206033255.GH7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180205235508.216277-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 03:51:54PM -0800, Stefan Beller wrote:
> This series moves a lot of global state into the repository struct.
> It applies on top of 2512f15446149235156528dafbe75930c712b29e (2.16.0)
> It can be found at https://github.com/stefanbeller/git/tree/object-store
>=20
> Motivation for this series:
> * Easier to reason about code when all state is stored in one place,
>   for example for multithreading
> * Easier to move to processing submodules in-process instead of
>   calling a processes for the submodule handling.
>   The last patch demonstrates this.

Of course, I like performance improvements (who doesn't?), but I really
like the way this series gets rid of various global variables.  I much
prefer to have fewer globals when possible.

> This is why this series tries to be reviewer friendly by utilizing
> machine assistance as much as possible. There are 3 types of patches
> in this series:
>=20
> (A) <area>: add repository argument to <function_foo>
>   This sort of patch is just adding the repository as an argument to that
>   function. It assumes the given repository is `the_repository` and has
>   a compile time check for that assertion using a preprocessor trick.
>   As did a compile check after each commit of the series, I don't expect
>   the review burden on these patches to be high. Review on these patches
>   is mostly checking for formatting errors or if I sneak in malicious
>   code -- if you're inclined to believe that.
>=20
> (B) <area>: allow <function_foo> to handle arbitrary repositories
>   This sort of patch is touching code inside the given function only,
>   usually replacing all occurrences of `the_repository` by the argument
>   `r`. Here the review is critical: Did I miss any function that relies
>   on state of `the_repository` ?
>   This series was developed by converting all functions of
>   packfile/sha1-file/commit/etc using (A); after the demo patch
>   was possible, all patches that did (A), but not (B) were deleted.
>   Therefore I was confident at time of writing that patch that
>   the conversion of a function which doesn't take a repository argument
>   is okay.
>=20
> (C) other patches, such as moving code around,
>     demoing this series in the last patch
>=20
> This approach was chosen as I think it is review friendly, despite the
> huge number of patches.

I very much appreciate this approach.  It made reviewing things much
nicer.

> A weakness of this approach is the buildup of a large series, which ignor=
es
> the ongoing development. Rebasing that series turned out to be ok, but me=
rging
> it with confidence is an issue.

That's my concern as well.  This necessarily conflicts with some of the
object_id and the_hash_algo work, but rebasing work on top of it
shouldn't be too awful once it's ready to be picked up.  In fact, long
term, it makes that work easier, so I'm all for it.

I'm sure Junio will have thoughts on the size of the series and
potential conflicts in flight, but I'll let him articulate those.  The
series could in theory be split into pieces the way you've done it: it
would just be less convenient to work with some of the functions in the
mean time.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp5IecACgkQv1NdgR9S
9ovUnQ//b/hSQNI3kYjVIXdULotjku2HkHJMHAqX57UVradtM30ShM9qrmU16bb5
xLNJOXj+iXGMCf7yE38aKvtQadbmGdrYdNsGdOCyu+ttYyQYL9PWSak30R+sxz9O
kTZCP8j10FtF8c99uN/rdJ3Tt2FCLQPa46fLVJdrr/1toYWe/Bl4rbkdcPFW7ZrP
kvkoQgroCFBkxgtteutju3l4ecJ7r+Q9q9ih+Ru9o5SoBMLeVD3QEBUUSdl2OLvZ
yaO1J/KHG2vJujd0FSKncYymW2zRsZLzKre9S+swRMe9aGVrNzP7jbjI7rMmGOuB
l7rQx8Iaszk6HbsZTepH3bHBwLpqYr0IrbF3hSW0dj48Ht0GUZJmuDyIz+fPyP74
Oh1xXlBhrn7z2GdcMLOD1GI8Qq/oGGdh0LwCbC7PytgEc2Bunvf0ZwRHyV1+EtsA
6wNY1FjWmbw+gRWgarqVneOUI4vSFJFElZsuKzIGpO6Y9RHtBv18OhzPfO4kdvcc
g0WGueVUpI0D1bSo3ihLT7tpQ+ahz7yUPDzCGYHKyO8kHxwJ2D5VT7dE1ZSleizp
SXuRFNVaGS5it2cg6K2vxe2/PdBtNJr/X4dMs6OPSYYIcXZKcUAHaGZR26C9SwSG
hwTnzMyV3zlfciy9HK/9rQMPpQ/1J8sHdcl34CJvkLqmK0QvcH0=
=TsR6
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
