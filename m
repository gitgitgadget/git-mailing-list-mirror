Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6403AC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32121610F8
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEKXPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:15:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhEKXPO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 19:15:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 580A760749;
        Tue, 11 May 2021 23:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620774846;
        bh=FpxYvaDdDjBEvGblUuVbwwwGrqOm8rwAImeFDzUs0aQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pGBPO7OADA1E9jlip7ICKZLHMKqEuuQ8N43tnLBblZ7w/RRQxvMVx4DjuZk5lcE6C
         Gy2+0iN46Z+uBky75CsdpMPtfQtsEGCA2Uw9YV1U8aPPmMXm4oT+8qJTuJcVcnLu6T
         2tKw9eUQ1koq4JtlgyANAYxoMDnTbK2t9HcIt6Q8ivyGmsstx3I+phXT6w85ap7tPj
         5/uhxQEOaL5/n8E1FGxbMhzX8OY/6HJVuB9q6pWtwdwUJhz+HARB0fl38KpLF7ZNpb
         8TofDvaNFypWoeyRZa4FpIR9aWBkRboDM7NHpLJufZkYtaHkVbcHaG6cMQZy2JhvIA
         eqxtPKJG9VXD9gVJElnIMT4CWNy7+flFlSLGYL1NArv6KQIAbpoKjX/dgJSu+hMPIR
         CxTuJY7vDDU8vCOIZI9csnDnkcxB22ed+8221vwNgm3Plurp7SWfANVTL7WwfUtUga
         wkZgk3C8WooTMCdDfH7B9SRMoxIpX6D1SANdwZM7X1YqA3vinPg
Date:   Tue, 11 May 2021 23:14:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJsPuU5eLO8TkY2L@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sB+CkA/qkILj2OIW"
Content-Disposition: inline
In-Reply-To: <609a07ca6a51c_5afe12088b@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sB+CkA/qkILj2OIW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-11 at 04:27:54, Felipe Contreras wrote:
> I've never understood developers worried about how the bleeding edge
> would build in ancient platforms, when ancient platforms don't care
> about the bleeding edge.

Debian stable is a common environment to do development on.  I know
people who do use it for Git development, so I suspect we'll want to
continue to support it.  In fact, most of my colleagues who use a Debian
system for development use Debian stable, I'd say.

Moreover, in some cases, the distros one can use for development are
restricted due to requirements for software that runs on corporate
machines, so making things work nicely on the latest stable versions of
Debian and Ubuntu is generally kind.

Yes, people _can_ run "gem install asciidoctor", but people who are not
Ruby developers generally would prefer a distro package over installing
one-off gems, especially since getting the binaries into PATH is tricky
with gem.

> > It's not too hard to install an updated gem, but not quite as nice as
> > using the system package (it also makes things weird for building the
> > stable Debian package itself, which would want to rely only on other
> > packages; but of course any proposed change to the doc toolchain would
> > be for new versions, and would not get backported there anyway).
>=20
> Anyone trying to build git master on top of Debian stable 1. probably
> can live with the output of the current doc toolchain, and 2. probably
> doesn't exist.

I believe I have just demonstrated that 2 is false above.

> > > I think what I'm arguing for is
> > >=20
> > >   1) switch the default to asciidoctor,
> > >   2) enable optionally using it without xmlto,
> > >   3) figure out what broke and fix it, and document which is the mini=
mum
> > >      asciidoctor version we're going to bother with for (2),
> > >   4) lather, rinse, repeat (3),
> > >   5) switch the default to not using xmlto,
> > >   6) drop the xmlto way of generating the manpages(?).
> >=20
> > I'm unclear when support for python asciidoc goes away here. Is it part
> > of step 6 (because it does not have another way of generating them)? Or
> > does it live on forever as a non-default legacy system? I'd prefer not,
> > but as long as we are clear about the primary target and leave it up to
> > people interested in the legacy to do the compat fixes, that might be
> > OK.
>=20
> How about we leave the legacy system in place as an alternative, and
> decide later what to do with it?

I think it would be fine to just leave it in place for now and let
people decide which toolchain they'd like to use.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--sB+CkA/qkILj2OIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsPuQAKCRB8DEliiIei
gcDOAQC3GAHxgvn0BiibbMC1+icCfYZgXwIK0NV9JHBYbBTSAQD+IaLfFbLo3wzE
tVwQc88B7fSncIgOJq3uePxmMaQ6SAg=
=l+mq
-----END PGP SIGNATURE-----

--sB+CkA/qkILj2OIW--
