Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE84C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E7F613AB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhDTBmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 21:42:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37346 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhDTBmc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 21:42:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 47EAD60422;
        Tue, 20 Apr 2021 01:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618882920;
        bh=SWAYMCqp5vl8EPK51BZgvaoky2xBPFgL6Wmi3ULPV7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kuEkjoF86eseFOKZn4Fmx4S/R73SX+cTkxRJvd6M+xir2IlUwP7ILZr8BVj4CRz6V
         l/7iSw35CV8G0ULeGSuR/Ftji6zVCNv+P7I6FUb/rScxRIJE+nDJ9iosut3nY5/hKC
         1DdByBtn15h3oQDZwQ4Fx+/cbph1xMpvtkv9P1IDZm51fvWlK6YVhzipe23uiW1htf
         UOZfAARpvE5Sw0s6d3sJEGKrP+/fADPYhrC3zmuymK+HYE7VaCjwhooRCmvww4ScrB
         z4l24jBhdcnSrC6RNhapt3W4Fkbdj0RnwcGPu3Pz4KeQN6N8KUlaJ/mUDFLctgYIZT
         LRCvxU5JWm5EbLPFMX5ZAnyddL8XHcBGFX+c3W5/cte+ijtcAhtiddZs8r28aLhJb5
         XOXASvaWxTvmsfUW1bYE2sXmyoNkASdnHgACoSWAC7M5KTdOk3IoD6jBIUT+fGZib0
         SwWuzkq9nUK3SUIcnqWuTeE7KZVDe5sv9+B7ReInGXf2TzhBu1x
Date:   Tue, 20 Apr 2021 01:41:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] fast-export, fast-import: implement signed-commits
Message-ID: <YH4xY/oSwYIUmJyL@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Luke Shumaker <lukeshu@lukeshu.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
 <20210419225441.3139048-4-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wDVFXCzKW/T4NHl"
Content-Disposition: inline
In-Reply-To: <20210419225441.3139048-4-lukeshu@lukeshu.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2wDVFXCzKW/T4NHl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-19 at 22:54:41, Luke Shumaker wrote:
> From: Luke Shumaker <lukeshu@datawire.io>
>=20
> fast-export has an existing --signed-tags=3D flag that controls how to
> handle tag signatures.  However, there is no equivalent for commit
> signatures; it just silently strips the signature out of the commit
> (analogously to --signed-tags=3Dstrip).
>=20
> While signatures are generally problematic for fast-export/fast-import
> (because hashes are likely to change), if they're going to support tag
> signatures, there's no reason to not also support commit signatures.
>=20
> So, implement signed-commits.
>=20
> On the fast-export side, try to be as much like signed-tags as possible,
> in both implementation and in user-interface; with the exception that
> the default should be `--signed-commits=3Dstrip` (compared to the default
> `--signed-tags=3Dabort`), in order to continue defaulting to the
> historical behavior.  Only bother implementing "gpgsig", not
> "gpgsig-sha256"; the existing signed-tag support doesn't implement
> "gpgsig-sha256" either.

I would appreciate it if we did in fact implement it.  I would like to
use this functionality to round-trip objects between SHA-1 and SHA-256,
and it would be nice if both worked.

The situation with tags is different: the signature using the current
algorithm is always trailing, and the signature for the other algorithm
is in the header.  That wasn't how we intended it to be, but that's how
it ended up being.

As a result, tag output can support SHA-256 data, but with your
proposal, SHA-256 commits wouldn't work at all.  Considering SHA-1 is
wildly insecure and therefore signing SHA-1 commits adds very little
security, whereas SHA-256 is presently considered strong, I'd argue that
only supporting SHA-1 isn't the right move here.

Provided we do that and the test suite passes under both algorithms, I'm
strongly in favor of this feature.  In fact, I had been thinking about
implementing this feature myself just the other day, so I'm delighted
you decided to do it.

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-i=
mport.txt
> index 458af0a2d6..3d0c5dbf7d 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -437,6 +437,7 @@ change to the project.
>  	original-oid?
>  	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
>  	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
> +	('gpgsig' LF data)?

Could we emit this as "gpgsig sha1 data" and "gpgsig sha256 data"?  That
would allow us to consider the future case where the hash algorithm
changes again without requiring a change of format.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--2wDVFXCzKW/T4NHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH4xYQAKCRB8DEliiIei
gXCCAP4zM4J0bEhs3KyG8RHFUjgHuIQQcsrPl9X1I6RkpwsIxgD8D3slS6gQFqSo
5VcWgf7UJqzg2/fN1qdHAfNNhjj6tQ4=
=DEq/
-----END PGP SIGNATURE-----

--2wDVFXCzKW/T4NHl--
