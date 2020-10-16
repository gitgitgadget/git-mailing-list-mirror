Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9ABC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E074F20878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbgJPCiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 22:38:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393795AbgJPCiM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Oct 2020 22:38:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE64160479;
        Fri, 16 Oct 2020 02:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602815861;
        bh=OfBVQ06N3cOMmE1YZFOqTX9jMZXExNLPDUVc/hTS4QI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eWwD/RuWP5NnS9qQx1Gjk6GzqvckbjzafJpV6OiXZat9KAjZF9WgIhWMvaDslRUMG
         a3GGhSTZqvPlRkqJKqcuJDR0bjQobT0ioB4zMrvci1w0QJ/kZ9OGXuMgXsUtmOeqIb
         nmU0QGqOIRqZH/HaMhKOMAwlZha3JlEM9dFl9RzYiwWQt8VTPewqVa5S0JGK6Lz4i2
         UsO9TAc45FxnTqSon7jlpAEYMFGFXM00HuCwR1B8RNCIBz1OQ6AV7k/7TzZKJL4II/
         LXJ1DTqaAs6RRvGBz3ExzYLkebBGNY+IirAQQvn/O1qIV1PCG9Bwkvp470DM5QgipQ
         AFWt38oV+erjxcUyQw1YtrlsEjvVTsfEqvduLoWT5PNYLUMFX9pAQYfnVFS+6Y+CSe
         mDVH1QPAKE9VVL0vGAkOSzv2QAKo4oD+hUxNOE8AEkI6ADQi6r/QE9aZv2NNsiiwuM
         vo42j8Vne9nG7ToAE7MJAjnS016SR+V63R2Y9azrblvfWnVP0Gd
Date:   Fri, 16 Oct 2020 02:37:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
Message-ID: <20201016023735.GD490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        git@vger.kernel.org
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
 <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
 <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
 <20201015185853.GA1108210@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20201015185853.GA1108210@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-15 at 18:58:53, Jeff King wrote:
> On Thu, Oct 15, 2020 at 11:35:28AM -0700, Junio C Hamano wrote:
> > I do not know if an issue-tracker would have helped, though.  The
> > issue was discovered and discussed there the day before:
> >=20
> >   https://lore.kernel.org/git/xmqqimg5o5fq.fsf@gitster.c.googlers.com/
>=20
> Doh, and I was so proud of myself for diagnosing and fixing it. ;)

Well, you did write a great commit message and patch with functional
tests.

> Looking over the thread, I don't see any problems pointed out (though
> as your diff below shows, the original patch missed the re-ordering
> required for the submodule mapping call).
>=20
> So I'd prefer my patch because of that fix and because of the tests.

Yeah, I'm fine with taking your patch as well.  Thanks for the tests,
which I think help us avoid future regressions here.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4kHbwAKCRB8DEliiIei
gTrsAP4ng5klNsvaZEM8Jxg17mgeW0O4GNvdv0WENSdSgEqUgAD+JVNM3WILfg/E
HIacq4xSsUT7BsJxziR9WYjbM1owuwI=
=9x24
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
