Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292D520958
	for <e@80x24.org>; Mon, 20 Mar 2017 23:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbdCTXaR (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 19:30:17 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46726 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753229AbdCTXaQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 19:30:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1EF03280AD;
        Mon, 20 Mar 2017 23:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490052164;
        bh=VbbRqKYUpB+AgMnc+Vzp1rtaYF/8DlYnxWeF8GpGi6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmywMLoU5cOynipS1BzeT2um5AcVtGc8wzte+Q9SoFY/vOh3ho21gvmtReLbFkJwF
         WRfSPrVWnC1Wycq3EA8TMNFjMNgnCUeUSgc/f3WdXb2CEL3uq4tZ5p4sUokvjemVDW
         WRnxZr/V+cMBViZdnt+3T4Rn4i+s71Kk5U0S3ecv7FKno/GEmF4freLGnIDAk1pFTj
         eNYLUQwnHKmqyFOSrSO9eQU7rdAEy0Uw4MhB0UwRk+1PafgKkUpVcgvhzqKlloPENT
         8cJ+SIiil47VydKcQT23yGr2iAXhia/Cyvu2MfwTPKmN0tmyQDuqPSbPLGms/prrw3
         fuzVo6PH+jDCuZAVNzJxf7nzaFUkFhWB/IyHAngFfvAEc9Y7zXayBNy4fyGSCr2PFR
         xGRFOyLQTby3NUGeRIVUqN6eMhMQVXH3rnpfbUqP7NxWEUGFZ98/KhY9Mr7gJs0v9n
         cNUsJQYSZAiVxYDOoyb31h2O1feIY+ZRMuBZ6wPJYWd1UcYL1G+
Date:   Mon, 20 Mar 2017 23:22:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     'git' <git@vger.kernel.org>,
        "Jeff Hostetler (jeffhost@microsoft.com)" 
        <Jeff.Hostetler@microsoft.com>, Ben Peart <benpeart@microsoft.com>
Subject: Re: Safe to use stdatomic.h?
Message-ID: <20170320232240.k3egololfj7wt5cf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, 'git' <git@vger.kernel.org>,
        "Jeff Hostetler (jeffhost@microsoft.com)" <Jeff.Hostetler@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
References: <000801d2a1b7$1ec41620$5c4c4260$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wmgpnncxbpzeuvr"
Content-Disposition: inline
In-Reply-To: <000801d2a1b7$1ec41620$5c4c4260$@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2wmgpnncxbpzeuvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 04:18:20PM -0400, Ben Peart wrote:
> My college Jeff is working on a patch series to further parallelize the
> loading of the index.  As part of that patch, it would be nice to use the
> atomic_fetch_add function as that would be more efficient than creating a
> mutex simply to protect a variable so that it can be incremented.  I have=
n't
> seen any use of atomics yet in Git, nor anything that includes
> <stdatomic.h>.
>=20
> GCC has supported them since 4.9 and Clang has supported them by default
> since 3.3.  Are there any compilers currently in use by Git that don't
> support these C11 functions?

At work, we're compiling for CentOS 6 and 7.  CentOS 7 only has GCC 4.8,
and CentOS 6 has something much older.  This is code we ship to
customers, so we can't rely on them having devtoolset installed for
newer GCC.

I could support the argument for ditching RHEL/CentOS 5 support, but I
expect other people might disagree.  After all, we're still targeting
C89.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--2wmgpnncxbpzeuvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljQZEAACgkQv1NdgR9S
9oveEA//dp2liVTI7BLoREByGZjrL/XfkZwFHLZ4M3m2JzY/xeROjGhtEwMX4tPR
TR8QYU+EP9vG5ubmP9FM29Zkn2WWgd6f0/TrmjbhVata3Hs4deMpTYRL2sj7COep
FdFJBOyBPqDr99yb7ewpsYBN+oRNo6UK8sFBrnlm7KBGtncSk/3cg1nHdhEf1aKG
lhVBp1tSCRjaAF5ZjehqMWN/GtLz1cW+XoC+6026qezm0MIMRN/LZC4rH0lQ15bn
fC1PfXndjIPKS0EZAx0oHWoPurTgTjtvtNXlZMuHxnKtb5/ZC1G+dd1nfZypnwUH
2WBH+uAxaXL7RXCjkDi50DrP1aUGqPvTsVHXp6k/wig1DyJUTKWzV+eAtaJmkXf7
RC5ykEQvdI6AYvYCIy4HTnhfO0JgP9VCpO0f1HzNm+4M74xNbX/uAMb38SOq1+7s
7OFyTjwrgNR3BYtpsJ3PQ8RuIMwUtCkaURvIULR6RG0nC9E/1TwOiU6zmoqwJp6Q
uuEF4lfUKiUj4vZQB/dZaqLu2FEKcv5fhqAcpOUmMmbWoD2f1GF5xpRWiZlnegw/
Avh30MjvV7WD2S3KD/EeNVU03Gxrs7f5pmN7aCUvpu+E4to1TddmbXj1nqz1Bz7r
SdGWmUBaFeZihk1l5RQRzPekDu4/DYbWTt17OuBVBb/t1I9WBFg=
=VgjF
-----END PGP SIGNATURE-----

--2wmgpnncxbpzeuvr--
