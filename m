Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A7CC35DEA
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1682072D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BrynKWwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgBYAFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:05:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40694 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbgBYAFN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Feb 2020 19:05:13 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1EF9260797;
        Tue, 25 Feb 2020 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582589112;
        bh=m1kT145U80jsaidBEBZY56HkNNiawg/SO+gNY7dGMyk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BrynKWwv8YP6+dKns0mn21IYS++m/ioVzZh/GOhBKciG2jOSCN9MzVi3nyuzAo0WC
         +/CdhYfvhk7CUxHRikAxHR1v0Ogym8M3dq+0gcvjsfo5iKupUCYQk+6ZlmJFgPoahq
         KhLCSXpuWPG5jtisCN2qG6sVSkmILLsgdqiA7jGGmXq0++lQ8o2ipfZ3PSBH2B2beE
         DPqwGfetGcoiBgHikky/CdJ3rIXdCMYZcUXcrvWhAqtN5285FOyBgHPBEhKqK39yrq
         pHXwT0+3ukT0raFZjjpi/7xarh/UZYKpjXf6zesZdrGT5pnOkrJJzL5LUvUHieeRFL
         OUDsC1Y6Arju0QrsWU0kJq9EnerembATW40j9sn6UU4kHbW4K2YiTD4XMWRtpeBYu4
         z+F2oB0L/mEuyw6QiIpdnrFuM+zlM1pEMHS24lI1Zb+dtKB2Af9uwkKTDEzLcnRlII
         VFcpVufehIndHwq8ARX1k7JTxJkh7RVYyk6DsiA+SAGl5cFRACS
Date:   Tue, 25 Feb 2020 00:05:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 10/24] t/helper: initialize repository if necessary
Message-ID: <20200225000505.GH6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-11-sandals@crustytoothpaste.net>
 <xmqqo8tnrhbw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Content-Disposition: inline
In-Reply-To: <xmqqo8tnrhbw.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-24 at 18:05:55, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
> > index f7f8618445..ecc768e4cb 100644
> > --- a/t/helper/test-repository.c
> > +++ b/t/helper/test-repository.c
> > @@ -75,6 +75,10 @@ static void test_get_commit_tree_in_graph(const char=
 *gitdir,
> > =20
> >  int cmd__repository(int argc, const char **argv)
> >  {
> > +	int nongit_ok =3D 0;
> > +
> > +	setup_git_directory_gently(&nongit_ok);
>=20
> No need to initialize nongit_ok to any specific value before calling
> setup_git_directory_gently() and I personally find this initialization
> unhelpful to new readers, as it misleadingly hints the setup process
> may be affected by the value passed in by the value in nongit_ok,
> when in reality the variable is purely used as outout-only (the
> first thing the function does is to clear it).
>=20
> Was it necessary to work around a compiler warning or something?

I don't recall, but since this seems to be the only place we do that, I
assume it's not, and I'll just drop it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5UZLEACgkQv1NdgR9S
9ovwLhAAyZLWa6yIjAVsrztrs/dEjtgMg5IhHpI9ChxwwaVjIJRDsGYKa38cfn4s
mHcG3WLxAOjbOgaByNmZJKJZ8ev72hX+Z3A+1QPbQzGA6hyF0mSdedQnTJPOwI/B
AEm3NcAm141JaFN8J1Q4Rh9ksklslTc9kREwVMehp8TQ5kj+gz8hljebV5klvsv5
VIcm/2slZ7SyfZOXyj2CYubQI4qCLxRpKS3d4ZuH+3DdycmVrkmVK5/gKS0LctLQ
Gx4RV2ArixldH77B6ASYocYmMlwslNZuIa9tcKk8ghlKtWRpA6jtG9L7tJzVqlfa
eG+3pT9KcvDO5AJgc0qSuC4J2m5g1EMi2JqKED+NEMGaPKVcyViz98TamdQtpgi4
Pe7X+gGi+qLlKBwTZEf621uEKPIedmrwEx6tgVnihmqJlfHExXQHnKdhlJjRx9dU
yppeXmEUQNrYZslMHr+2Gb3xRnMmppnpytsGQfRRK7C4cU4Yv0Ea35kSlFi9t9QP
F3azzSN1rxbBwe3Ze5UqYG14rDMZGjl66Ji8m8txN2eO0xNe6X1clpHsbGcm7ZKU
0sm0XvvtJdYV/tc1vHRsmaqS3uKuB/6isnHcaSqTN4RNyjxkejHc1jNNCkdWohkP
PM42G+Afq05aB5n6rtG+ciTDtwCrBoGstYWZPp/p6Ec1hMtuDPQ=
=/Tb4
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--
