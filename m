Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58020C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 23:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C24613F2
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 23:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYXFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 19:05:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57032 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229776AbhFYXFw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Jun 2021 19:05:52 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1501560749;
        Fri, 25 Jun 2021 23:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624662181;
        bh=fjdUK8eoQvhcBlSJ2w8PfCDMUmIOax2Vj+bH3Y55Tvk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WIlQ2UE1eOcPK1apAKimRQJk3edSyNIrKrzsqlvN00s8NUK7EBUXem9/Gd0ESrsjJ
         +WmDu2tNDi58dWM8HUSaXUkoUCwjcXwmzsGVQF0hTdWeEtIXxwmiYz7xb/0ckCcFwR
         AB/LIa1FTWF/RohcZdAF9sG3dbrssvNsem3IXe+PfbYnLDrBGIaNVJ3OR+I+4jfFKP
         YAWEtAFdR8ZYb2jYg/mISuKTAWoS4mnkNRcUdkIjia92dqMF0sMXLLHjnrigdnZlrd
         o+KmBYeb+98CinVN62SBaKRtMHr/y0U8m9didNLaWX3FX0AUrcVhXXc7RscnTWblmR
         dZC6PW4Y1Q/PAtRSQ4XdgOALp3wA8woga6VTRE7lDZnE1bmgvLrmg4IFLCbocZHtl+
         XNaJuUFcXqlERCD06DTRZP/gURynMNSoJAjhwqiKxRU5YIseSoalYJcYl8jWJu6W1P
         z7CL06V1rBoh/51nnF0T58WsDGd6RkpEolXRXQmPAbMtIGGpMz3
Date:   Fri, 25 Jun 2021 23:02:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] submodule: mark submodules with update=none as inactive
Message-ID: <YNZgoS9R1qam+62C@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org,
        Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
 <20210619214449.2827705-1-sandals@crustytoothpaste.net>
 <56b5c722-8baf-9f9c-cc9f-5b5ed49d7fc3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6mjklmptBN1TfcG"
Content-Disposition: inline
In-Reply-To: <56b5c722-8baf-9f9c-cc9f-5b5ed49d7fc3@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f6mjklmptBN1TfcG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-22 at 03:45:45, Philippe Blain wrote:
> > That will make us properly ignore the submodule
> > when performing recursive operations.
> >=20
> > Note that we only do this when the --require-init option is passed,
> > which is only passed during clone.  That's because the update-clone
> > submodule helper is also invoked during a user-invoked git submodule
> > update, where we explicitly indicate that we override the configuration
> > setting, so we don't want to set such a configuration option then.
>=20
> I'm not sure what you mean here by 'where we explicitely indicate that we
> override the configuration setting'. For me, as I wrote above,
> 'git clone --recurse-submodules' and 'git clone' followed by
> 'git submodule update --init' should lead to mostly [*] the same end resu=
lt.
>=20
> If you mean 'git submodule update --checkout', that indeed seems to somet=
imes override the 'update=3Dnone'
> configuration (a fact which is absent from the documentation), then it's =
true that we
> would not want to write 'active=3Dfalse' at that invocation. As an aside,=
 in my limited testing
> I could not always get 'git submodule update --checkout' to clone and che=
ckout 'update=3Dnone' submdules;
> it would fail with "fatal: could not get a repository handle for submodul=
e 'sub1'" because
> 'git checkout/reset --recurse-submodules' leaves a bad .git/modules/sub1/=
config file
> with the core.worktree setting when the command fails (this should not ha=
ppen)...

Yes, that's what I meant.

> In any case, that leads me to think that maybe the right place to write t=
he 'active' setting
> would be during 'git submodule init', thus builtin/submodule--helper.c::i=
nit_submodule ?
> This way it would lead to the same behaviour if the clone was recursive o=
r not,
> and it would not interfere with 'git submodule update --checkout'.

Let me take a look at some other approaches and see if I can come up
with something a little bit better.

My apologies for the delay in response; I'm in the process of moving at
the moment and my attention has been directed elsewhere than the list.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--f6mjklmptBN1TfcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNZgoAAKCRB8DEliiIei
gRHIAP9jb6C3Q1Ro319OrxesdxDQAdjW9WdzS6t74hv3NWfV/QEAvvRNvLqyHK0K
gkhhlF0Ss9x3Wvin5jisrojEMAAQSgM=
=3Jnx
-----END PGP SIGNATURE-----

--f6mjklmptBN1TfcG--
