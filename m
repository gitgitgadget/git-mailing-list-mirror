Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67539C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4116060F56
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKAUxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:53:37 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55226 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhKAUxg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 16:53:36 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BA0151C0B96; Mon,  1 Nov 2021 21:51:00 +0100 (CET)
Date:   Mon, 1 Nov 2021 21:49:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, users@linux.kernel.org,
        tools@linux.kernel.org, git@vger.kernel.org
Subject: Re: b4: unicode control characters -- warn or remove?
Message-ID: <20211101204914.GA16445@duo.ucw.cz>
References: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
 <20211101190905.M853114@dcvr>
 <211101.86bl333als.gmgdl@evledraar.gmail.com>
 <20211101202220.dlcebvckeoz6c26k@meerkat.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20211101202220.dlcebvckeoz6c26k@meerkat.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It checks whitespace because that's something that's commonly a source
> > of patch corruption. I'm not adverse to adding this to core.whitespace,
> > but trying to catch malicious injected code seems like a rather big
> > expansion of its scope, particularly since:
> >=20
> >     "[...]sending patches for docs actually written in RTL languages[..=
=2E]"
> >=20
> > Or just code? People write comment and even in their native languages,
> > and not all projects are as anglo-centric as those hosted on kernel.org.
>=20
> My comment about docs was purely within the scope of the Linux kernel.
>=20
> I think the following would be a sane check:
>=20
> 1. are there unicode control characters (CCs) present?
> 2. are there other characters from RTL languages present in the same line?
>=20
> if both 1 && 2 are true, this is a legitimate use of Unicode CCs. If only=
 1 is
> true, then it's likely worth a warning.
>=20
> Maybe even relax #2 to just check for unicode characters above a certain
> barrier where RTL languages live. I think everyone will agree that if the=
re
> are unicode CCs and no other unicode characters in that same line, it's l=
ikely
> not a legitimate use of control characters.

If you are worried about malicious patches, then it should be easy for
attackers to add some RTL characters and escape the check...

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYYBSygAKCRAw5/Bqldv6
8vA/AJ4pW6dW1HjxRy4kQE6jl2C7FXqd+wCfZ7yEhCUON+HanuGKB3V/wSwgi5I=
=WlG7
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
