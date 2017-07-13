Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110D32027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbdGMXpQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:45:16 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59640 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752640AbdGMXpP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:45:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 65963280AD;
        Thu, 13 Jul 2017 23:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989514;
        bh=2bHFXSi3FgEYgvQ0wLVjwnhgiiakbxVCcIqE4O3RebM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPY2iBaEns5+2YYTc5o8/H8iZnFHvGFFf3ocU041XVzwiOOANMn3SZ6A04MWP5d9V
         N9JW8vEMToOnu59aqQ68/NRBETTcJRHtudB6GmLgY9rBf0JiKF38mGTaGPB1JG8qsz
         1A5R0CUtvYWBw5ucwlGssLxTA+7f36eZP+qZmBAi1L4YN1I5vJtyX//XuRCuxkmq9n
         KTfd9QoQ3v2XW6uHetVs+dEvqzsJUTsvRMDieKlWscQTKAvEnhwbAxcUKNR3tIqrMk
         DnvV4/+UUJGflRY5tuNtoGzlI80NhmPVkfw4A7lW3trbHqOnYxrdKVhb9U6n189jXY
         i2wi57SnCbNEkinN6TzOPbe6jkZcBxE9Vo7YF9GvJKLLQ7LTbVTiPSvoZFKmTQlZlw
         5McAXWFB+jmFbrvMIiGkFW+4rZL6kd0IADk246E6ZCYw/pYfuWEHJSJ5u1luR7wAkn
         lUDPRg6utc0gaDUfvWQ6F9mJbB6xW7lY9Rg/t530DLffi8c+ibI
Date:   Thu, 13 Jul 2017 23:45:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
Message-ID: <20170713234509.ik334vp4l5icblkr@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170713004415.5051-1-sbeller@google.com>
 <20170713004415.5051-2-sbeller@google.com>
 <xmqq4lugukju.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kb3_K8NxpHuzAdHhSLWUcbw_X3qVVspPeuSNA4sAeT-Kw@mail.gmail.com>
 <xmqqvamwt4ju.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZOCtk9YM0=dUic5MHMWLZgb8xeYsFX0VaMNbFrjw=sUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xayxsaqfnurzpbm"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZOCtk9YM0=dUic5MHMWLZgb8xeYsFX0VaMNbFrjw=sUA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2xayxsaqfnurzpbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 02:49:28PM -0700, Stefan Beller wrote:
> Snarkily I wanted to link to an essay "large patch series
> considered harmful"[1], but could not find any. So a couple
> of bullet points:
> (a) humans dislike larger series, hence fewer reviewers
> (b) the likelihood of a mistake in new code is proportional to its size
>   We can use the number of patches as a proxy for size
> (c) If a mistake is found, the whole series needs rerolling.
>   The effort of rerolling a series can be approximated with
>   its size as well.
>=20
> From combining (b) and (c), we conclude that the effort to
> land a patch series is O(n^2) with n as the number of patches.
> Also from (a) we conclude that two smaller series containing
> the same output as one large series, has better code quality.
> So with that, we conclude that all series shall be as small
> as possible.
>=20
> So I'd ask to queue these 2 separately, asking Brian to drop
> "builtin/verify-tag: convert to struct object_id"
>=20
> [1] https://www.cs.princeton.edu/~dpw/papers/hotos.pdf, 2005
>     seems interesting to me in hindsight.
>=20
> I can also send my patches to Brian, as you (both) like.

I'm literally about to send my series out; I rebased and tested it last
night.  I don't care whose patch gets applied, but to avoid needing to
rebase and retest my series, I'm going to send it out as it is.  Junio
can apply my series on top of yours, in which case he can drop the
relevant patch from my series.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--2xayxsaqfnurzpbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlloBgUACgkQv1NdgR9S
9ov9cw/+P3VBeULmQMUe4dx5SK7QUuj246p3kKHRAZe0UyIqpj+zp9PvItqWq6fi
EmqvPfktCqTu5KW2GuPURVGxjHmO2aItP9MduqDEtwMRdVbKQPgmxmfIJuSlcUL4
TybFoKFOcut5MTLwAHSYEw26sHimYbPWSnxzFyS7zKoedPw4TvtC6d71ybS3oCqr
Rlo+ppXfa5vWeJowj5RKgS2myEk53V6rPQhRP9yarVtOx0EuCsup/PU9sdkHz3MR
1ugw5bVdimluuSIworGzVoeh39QJNL6Q6t1DYuxIp7NtYSK2PMAhBAxCVAcfLY4n
U+pt4FiRRuf7d4u1EJF9ewJ67zyld1ccqVx//Tqv8F8O9iedsE1y0EQSdr06I4QF
FnmvnPj3qxVl/qJHe93FDIgVoqDvwMjwijT0IdigtK5FZpjO5UmhdICOMk5VyG1W
bR43qJswQ/xKeyAqAj9wmar4JLW6SyqSIlxesbGkYvDSqCt+wRDoJFqydcwN1OvD
v/ynsF1XrVKi0/UEnWSLQ9fo4N5VXVGWmHDGny8+reS7wWePMvq0ZZZ24bR9td+o
DkQOLowUFVD3w3WqpJkOSGxA47pZW0IKVPmZAEl0AsbstJJbSJEbwVIW4XU/gOkd
Tukoh5lRH4HI0Z17inWj+E32bbUJfZ5xVPKTlpTWsSFxRasuaHQ=
=uzyb
-----END PGP SIGNATURE-----

--2xayxsaqfnurzpbm--
