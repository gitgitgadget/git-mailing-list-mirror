Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C8C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 00:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDMA0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 20:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMA0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 20:26:20 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620316A40
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 17:26:19 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5D5C95A2B2;
        Thu, 13 Apr 2023 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1681345578;
        bh=xe/+yubP6eOcTx2KSFuUq5akMg9Sc3mi5Ef+j8XA2SM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rzrHpc6BkC4wLaazuJy4elUs80kZRqNCI5pPxGJ35lmrGIpCLSKQEHWPUrDdqtfJe
         NwlRiRVDOE5SWOAnxpHQ7xGpA5jTJ8vwh5Bh6hcNVQ9GKbd2TdWDJ3z1q2/ceFXbLD
         lbcRJo/0UuPKMP4zvldNAz1q+aybaMU8RFfQ3dfhfggg6IncXmktq5h6NhYb58oH+C
         Wmgys4fcbuV+1gAyv/g9NB8MK4S/0gVDIQ+zbDlulXhj88Etx+bM6Az6a2FDS/jg1e
         gUskFgXPp+Eo3ysLYrcAy0/oxO3Eg9LMF4M1FBMATBLzeUBSsQ4zMtYlRdaHmCy5de
         GGjYyE3AcizcMs7yHcq0WDktjYWUdQB4pLSeHKuZM6VuEEZs6Tjk8Jbuu11Kq9y6f7
         KWYKcOkjVKCgvqXZqk+409aMMffh72vY43I/pH2QIkp+nR5VQZwMvUKVzknjfKc8RT
         fg2majkdPb2xDTrYD6r1TVIjDseh2/dZvUUKVuHZ9AXx7HoYalG
Date:   Thu, 13 Apr 2023 00:26:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: criteria for linking to binaries from git-scm.com?
Message-ID: <ZDdMKNJ/4njF0Jdp@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20230412080019.GA2172825@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q4+rkL1yMGvh1Pef"
Content-Disposition: inline
In-Reply-To: <20230412080019.GA2172825@coredump.intra.peff.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--q4+rkL1yMGvh1Pef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-12 at 08:00:19, Jeff King wrote:
> There's an interesting question raised in an issue in the git-scm.com
> repo that I think would benefit from input from community folks here.
>=20
> The link is:
>=20
>   https://github.com/git/git-scm.com/issues/1774#issuecomment-1504829495
>=20
> but the tl;dr is:
>=20
>   From a supply chain perspective, what are our criteria for linking to
>   a third party's pre-built binaries from git-scm.com?

I think we should ideally suggest distribution binaries where those are
autobuilt and the distributor is complying with the license.  For macOS,
Apple is providing their own binaries, and if people want more
up-to-date versions, we could suggest Homebrew.  For Linux and BSD
systems, that would be pointing people to their OS distributor.

For Windows, I think most people are going to use Git for Windows and I
don't believe Microsoft is providing its own binaries as part of the OS.
I believe Git for Windows is autobuilt using CI.

> Obviously we don't want to point people at malicious or trojaned
> binaries. But we probably also bear some responsibility for making sure
> the third party has reasonable security practices themselves.

This is why I suggested autobuilt binaries only.  Typically OS
distributors have some sort of reasonably well secured autobuild
infrastructure.  I think it's safe to assume major distros have secured
their autobuild infrastructure unless we've seen evidence to the
contrary, because otherwise we'd need to be security auditors, which I
don't want to be.  Note that I wouldn't object if the binaries are
manually signed (say, because the key lives on a human's security key),
but I feel like that's practically unlikely for most OS distributors.

If we have evidence that people are not complying with the license, then
we should refuse to link to those binaries and not recommend that as a
trusted source.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--q4+rkL1yMGvh1Pef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZDdMKAAKCRB8DEliiIei
gdZ+AQDm1TLTv9TXBm3YMQTn8zgMXSpFYPdSgzhUGHgrmUqWPQD/VmvePCA7xW+Q
FTixeMc+uFWGk8SeCs+at3BhF6gYDAU=
=v7dW
-----END PGP SIGNATURE-----

--q4+rkL1yMGvh1Pef--
