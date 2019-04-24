Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1A41F453
	for <e@80x24.org>; Wed, 24 Apr 2019 02:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfDXCWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 22:22:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbfDXCWt (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 22:22:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C1FA60FF7;
        Wed, 24 Apr 2019 02:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556072566;
        bh=j2HHrgCpo7lo6Flj91mlZASVHt+khwFaZ0LBq2C6LMo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ceKSgg6ckfSxTcKFQHG8HkoAFooop6Uu+nikQ6vFpsFZIQeltpv6ql8Q9H+6VQjlr
         dlhTRXISVbn2PSmbEJC0iuClmlkTZWlcoqK/GAphXWgshVyDVHDCSQ7V5+ew/DYyE4
         IDjYp+l7NDk7HJMFM/sXxThvHAIZQJgo4++5JvlQr7N0yMbl1nzmwc/hspMSPAFnaY
         +EmX5YzTTekdl/gUjAFA6B6imUuLIyL+BjbVrzwIo0+frK3ZemL5r73qTn0mp0xFDs
         VMucbPX7KWqKxtmZwyOZJktTsKBL+aH8SoOw4fse/L8GSUZS5vNLXSZSpl3MNJohSL
         uEOnLcJ5dQkVmQ7zlf44MM+antC0a2+BS2Ks1G38wJsWBfIgt/wbQ+QcXADVHZf/QD
         izqkWLKoeTaZr0YmDoPPiZsi7TzyGPczyBwU+ODZt0EAIIbTdqUTmSKLJCm2OmjW1C
         eMgyvz7CiDBXOwDCf/o3yHtUMTx5bb07odz40K4XPl4LEQjpsAc
Date:   Wed, 24 Apr 2019 02:22:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190424022240.GH6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <xmqqtveo2lyx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline
In-Reply-To: <xmqqtveo2lyx.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 11:09:10AM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > To preserve backwards compatibility, we don't run the hooks in the ".d"
> > directory if the single file is a valid hook (i.e. it exists and is
> > executable). This is because some people already have multiple hook
> > scripts configured, and if we ran them both, we'd run the hooks twice.
> > This would be bad for e.g. the prepare-commit-msg hook. This is also the
> > least surprising behavior.
>=20
> OK.  An obvious alternative may be to see if the expected hooks path
> is a directory and use the contents.  If ".git/hooks/pre-commit" is
> a single file, we know it is the single hook as before, and if it is
> a directory, we know that is not a custom made (i.e. from the world
> before this series supported in the core-git) multi-hook setup.

That's an idea I hadn't considered. I'm interested to hear other folks'
ideas on it, but that certainly avoids a lot of the problems in my
approach.

> > We check each hook for its exit status, even if the hook normally
> > ignores exit status, and if it fails, we abort executing further hooks.
>=20
> This part may become the most controversial in the whole topic, but
> a design discussion is helped by having a concrete proposal that
> makes its own design decision, and this is the simplest design of
> the failure case that is the easiest to understand.

I expected it might be. I'm not strongly wedded to it, so if people make
a good argument for something else, I'm okay with changing it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAly/yHAACgkQv1NdgR9S
9ovvzQ/+MXM4qqG1I3ECFjN2ItEUkyjM1G9KBwRII92P5T8dEiXwvgPgIXe1k/Uz
mC6xPvAu9+zrak3nIETEg9U/RFxOglfyS+JeIfmIjVDI1fmkeNMOqGvqTDof/Q2f
iBcsd5cZXpdf1P7MjU+TIDvb0LxPRHDbwZPL8czd/E7d2vwmpFoDuQzZu1AhcNiq
45ofLDqt0Gw7zsyieT64wgGapu4zsOpjG84VRF/h04pImcD1siM3T5uibYvvnaeY
GBMYga8TmyWThH3WU/vqQfG2lcg42sCqUffwGbPdIEI/UOCqmoB47mL2REpjSZnp
l6Fvh07va/rv0YB+nrnE0+RsQOa9GOrLPd1w8Rf8z33dqiBiSOcVCbu+NDP2g0Bj
HbqBWdVGyATpv7Z0GBFpFypwRVpYmjZRiuJlBWJW4CUMbPJy3SgwNQ5sRRc4e0hp
VkUueUAj0KSCMOjueCrB/yBAsfp4ShC6SZMYDseXjq1Q27kqpZ0cuFoLv2w2YMQG
ZT7vZLAuUPTFqSRK9JPv6TEA0qOuzB5XZFW1JJUKeYXVOJxH/rQTUOcw/hOrM1xv
j1/6fpsq3QHmHZSY1SaYyB4bx/ZFG6XKYtYxDJNrwD3mhSFQU49tbDz4SdlyCxTX
lqKgD1s5FnmiaYUiK0Z+mHYundD07HKvdzXY9z4OeXTmnhImIHg=
=g/y7
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
