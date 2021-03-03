Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F3C43603
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3613F64E68
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhCDAYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233401AbhCDAAQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Mar 2021 19:00:16 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F2DA560DF4;
        Wed,  3 Mar 2021 23:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614815975;
        bh=PGa+Cis4K+w7FxYa/S//meNHi2sSMJbn7wendwUQqLg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ec4lpZrXv2waCq6Qfj+gSMDzlquE6MXPYF2DZJzri+tIZ3KrMV5uBfXeQi5DH9B4X
         e85ea1GckoDDeI3l9xQK1NTZumtqRigWdDaBG3PX/9AHAtdAFYH0yvDSABIzZ99ipP
         WEqH7UPq2xqwf5yAOFhTgIEnKz3xdCq66jQDF7qOslhQsAR7LLK4BGffvGVgSMZYuJ
         wextc86mGOtqOiKMaFhUDT20ih9jyBCB4RDWHKvb0AsSqJWdL2/CfYqeJb+mlOwp1A
         Ed9tQzC4wwliaBHnIaHxjCObzBy7mkg01cBe5bKuM3IW2/vIzd+iRbRKyi4kbGwdGl
         1IcOQJA/qmtAGyZjlR1/rP6PS+5pa5/o+9f67gicVj/YJoO5p8SxMfCDTn8CtabvKX
         Z5al5kzcZbQK1Kyt7LbAlPVdIxyXPnojTqSdY2rYOubmx+Xo7ZBNC+Boe7A3rzkg95
         /ak0dATbFM5bq4VpEwq4tmub1j2P0r3W0u1xz/X6fyVkBZhvHn5
Date:   Wed, 3 Mar 2021 23:59:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Vusich, Joseph" <jvusich@amazon.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug: conflicting core.bare setting causes segfault during bare
 clone
Message-ID: <YEAi4OkkNnp+IMJD@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Vusich, Joseph" <jvusich@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rXMaVlYZg8teHd0E"
Content-Disposition: inline
In-Reply-To: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rXMaVlYZg8teHd0E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-03 at 00:06:01, Vusich, Joseph wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> $ env | grep GIT
>=20
> $ git config --list
> user.email=3Djvusich@amazon.com
> user.name=3DJoseph Vusich
> core.bare=3Dfalse
>=20
> $ git clone --bare https://github.com/josephvusich/fixture
> Cloning into bare repository 'fixture.git'...
> zsh: segmentation fault  /opt/local/bin/git clone --bare https://github.c=
om/josephvusich/fixture
>=20
> What did you expect to happen? (Expected behavior)
>=20
> "git clone --bare" should clone a bare repository, regardless of the core=
=2Ebare setting in the global config
>=20
> What happened instead? (Actual behavior)
>=20
> "git clone --bare" causes a segfault if the global gitconfig has core.bar=
e=3Dfalse

I appreciate the report, and I can reproduce with 45526154a5 from next.
We should definitely not segfault in this case.  I completely agree that
segfaulting is the wrong behavior (because it's always the wrong
behavior for a command-line tool).

I do, however, think we should either ignore core.bare in the global
configuration, if we don't already, or produce an error.  The
documentation says, "If true this repository is assumed to be bare" and
much like we ignore certain other settings outside of .git/config, we
should ignore this one.

I also agree that "git clone --bare" should clone a bare repository
since we'd ignore the global setting.

I'm probably not going to get a chance to look at this before the
weekend, so anyone is free to come up with a patch in the meantime, but
if nobody has gotten to it then, I'll try to send out a patch.

I will admit being a bit interested in how this was discovered, since it
seems like an odd configuration to have, so if you can share, I'd
appreciate it, if only to satisfy my curiosity.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--rXMaVlYZg8teHd0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEAi4AAKCRB8DEliiIei
gRlMAP948fVIKVW2xrfPqJNk/ZXy4XqKeRDap2jlKqB6S38teAEAr+BUpYFqGWHx
eDa4BpRWGPXELKNj8Oa4xEaolgsc6wg=
=TmRG
-----END PGP SIGNATURE-----

--rXMaVlYZg8teHd0E--
