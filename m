Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7FC4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B822020756
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgI2WoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:44:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40822 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgI2WoC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Sep 2020 18:44:02 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 341FC60489;
        Tue, 29 Sep 2020 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1601419441;
        bh=CmWPzHOUS9KdL3YjBFO37GXVmnBvOCbIT5pORsUGtPI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QdA0usqybsofY6Lx9ZsW/4Z5gptRLNh160Ms5Olfb9/DFKEBX8rqEa+4bdbxDYYcj
         ZdkQ1HgXgvsLiqDAfNpqf3XQhBzzjkqysJ+EH+/MxmtEZ+QkQ2mGUEbhpBp5Fu4TGq
         9Vyyf/v4VCg7wHRyR4uzRxeAd0y+hzpcuqCHiAMwB5zr4idpRMNtXWFpUvP3sszN3p
         TvR2pbkAigAFVetSA+Fk/+j+reBKga4DRTU/R77Da3QoR687XnRm5yUc6YfzvjIjmS
         xYc4nEeYnorw1hJmVDKhmpnP5Vke2Fbagxr0oc2JQikhrBbg6A2RRj1KUzkJD2GunE
         ovxlsBc8P8laMrWPHHQ0iKpHnKKhK6hQlcA3TGxMHsB+uAT3FtAEOvbFjb4uOB0oMS
         +adZb+Xh7DEhYp+TmKW7lfW/JqOjzzzptXmQ5klgFbWjrN08RmoUx64TFjhqcaRcaf
         1o9u8X4rs8cPPXCTyT5eL0n6R9btkWsftDVLC9uxQtUUYtjGtGo
Date:   Tue, 29 Sep 2020 22:43:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question About Git V2 Protocol & SHA256
Message-ID: <20200929224356.GH1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20200929221311.GA15129@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-29 at 22:13:11, Jeff King wrote:
> On Tue, Sep 29, 2020 at 01:17:59AM +0000, Wu, Zhichen wrote:
> > 2. I see v2 has a capability called =E2=80=9Cobject-format=E2=80=9D tha=
t provides SHA1
> >    option. I=E2=80=99m wondering if that capability will be the only wa=
y for
> >    client and server to start using SHA256? Or put it as another word,
> >    will v2 protocol be the prerequisite of SHA256?
>=20
> I think it would be impossible to handle object-format via v1, because
> the v1 protocol writes the ref advertisement before any capabilities are
> negotiated. So I think v1 must implicitly remain sha1-only (and a sha256
> repository on the server side would need to either reject a v1 client,
> or back-translate as it would for a v2 client which asks for sha1).

I don't think that's the case.  You can indeed use v1 with SHA-256, but
if you have a SHA-1-only Git, it will choke because the object ID is
longer than it expects.  If you want to negotiate the algorithm when we
support both and the client can't deal with translating the initial ref
advertisement, then yes, you'll need v2.

We even support SHA-256 via bundles and the DAV-based HTTP protocol, but
the latter will never support negotiation of hash algorithms because
it's based on static files.

It is required that you understand the object-format capability on the
client side to support SHA-256, since if you fail to announce it, the
default is SHA-1, and right now, the server side will produce an error
if the client doesn't announce it (or sends SHA-1 data).
--=20
brian m. carlson: Houston, Texas, US

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX3O4rAAKCRB8DEliiIei
gSHJAP4kvjkl0PE2HYFJCD2Cm6x1zRx9D6jEPz4LioJoeEH4xAD9HDwG/l29WBGG
8t/zQuzC8oF1WuMFSuSJpKBu6+DORQw=
=vMDB
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
