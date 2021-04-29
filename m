Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC3C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 02:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A594610A5
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 02:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhD2CJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 22:09:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229888AbhD2CJ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Apr 2021 22:09:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A4A5F6044F;
        Thu, 29 Apr 2021 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619662092;
        bh=IrHfZ7i4c5Uo8G6lohKMm5al7HGv61eEbpvTpQ930wk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yKXFE3NiYtM8LQwRwaiRJI9xIACKRi5BpfmkM0lJUn23wNbvuPTYEIFqotRtCV+PQ
         pV/rzQ06dNho5xE2wVO5qnULtitqrDz1u3SvIKfMTBGaFUOc050issGDTgXh7s9KXc
         lkjCm+dzQ1R8bE+43o5Bd/AxEIGi0cWe/kxOhQZ8bvUSxtwhL6lvmfwCg5ilgFvcUh
         vvZr287MYeOVDIjZwuJypID09LthYYsOQNMNoQIiYfwMIZWg+9bA9KUV/pIJa+9O/M
         k7wGhC/HEhcHXv+DrfmAQdu7OZMrZkUQ7Ugb6QH8VLkXzf+u9tSKnsm3W2XiUJtel4
         AlMUpW4GMtsp93gxvJGFpDXli4EGNploHV6qeGBmoj4xcDuGFliZy1tdTftxDXq49v
         ZizR0QoSFwiKoHMRqdj8TdmyTOZ1Y899vDaa9MOv2gleM40jOIcHfxFre9ZAB7HQ73
         RdGLaIQCZmBFKIcsr6jBCt06rAHfS+VFIoV8+Qj1uOQE0eWJ4za
Date:   Thu, 29 Apr 2021 02:08:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     dwh@linuxprogrammer.org, git@vger.kernel.org
Subject: Re: pkt-line and LF terminated lines of data
Message-ID: <YIoVBmeGMheSi897@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        dwh@linuxprogrammer.org, git@vger.kernel.org
References: <20210428222219.GA982@localhost>
 <87bl9yylyg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NlTVydTTl/8HXAZn"
Content-Disposition: inline
In-Reply-To: <87bl9yylyg.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NlTVydTTl/8HXAZn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-29 at 00:12:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Apr 28 2021, dwh@linuxprogrammer.org wrote:
>=20
> > I was just reading the Documentation/technical/protocol-common.txt
> > description of the pkt-line format. One detail that is left out is how a
> > receiver of pkt-line encoded data determines if a line is binary data or
> > contains non-binary data.
>=20
> They don't. The "is it binary" is a client convention / awareness of the
> consumed payload.

As a general rule of thumb, if the pkt-line is a pack or object, it's
binary, and otherwise (a ref advertisement, a negotiation, etc.) it's
text.  Almost any case where GIT_TRACE_PACKET prints the output is going
to be text, and almost any case where it does not is going to be binary.

Note that whether something is text or binary is specifically an
attribute of what part of the protocol is being parsed, not what bytes
it contains.  For example, a ref advertisement with a ref containing the
bytes FE and FF is text, despite those not appearing in UTF-8.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--NlTVydTTl/8HXAZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIoVBQAKCRB8DEliiIei
gbyqAP9UQB1tu4kcDKDYVi6zrtYhBOhIy1F5Owk7ttj4HLikQQEAngP2rhUGh8NW
OiJihgQbuNDp/xYvK+0I3AKkdcq8kQY=
=y/lW
-----END PGP SIGNATURE-----

--NlTVydTTl/8HXAZn--
