Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79458C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiBWRZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiBWRZA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:25:00 -0500
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 09:24:31 PST
Received: from vmi563313.contaboserver.net (vmi563313.contaboserver.net [62.171.181.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D77DD5371B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:24:31 -0800 (PST)
Received: from inspiro.localdomain (unknown [182.253.127.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vmi563313.contaboserver.net (Postfix) with ESMTPSA id 82861AC0144;
        Wed, 23 Feb 2022 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kilabit.info;
        s=20210411-1; t=1645636622;
        bh=NxgC8R3Txi7iSAt5ZBdJj/uCDfuDHvRyxW9KkL10p6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=mIgX0zAUddCQ+KLzdUbq7FRU9GVWMfl2OphfoBgeTAX849bfz/TLbc1bG07Id4uJq
         bAgkMuElXgW9n4Rr3hA99oVeWN3ExUzwOh/mzWHD68v5fCidUuG6J6NaCrg645MdDe
         x53c0kRwThO/eqK49uhLO/LusXl9PfGtFtfQal1k=
Date:   Thu, 24 Feb 2022 00:16:56 +0700
From:   Shulhan <ms@kilabit.info>
To:     Halil SEN <halilsen@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH] gitk: fix error when resizing gitk
Message-ID: <20220224001656.6bd80ed0@inspiro.localdomain>
In-Reply-To: <CAOeUTuuyftWB=PaA9HPDnyxsb40R3Z6GD65TB92jEW+38goqRg@mail.gmail.com>
References: <20211125125720.231039-1-ms@kilabit.info>
        <CAOeUTuuyftWB=PaA9HPDnyxsb40R3Z6GD65TB92jEW+38goqRg@mail.gmail.com>
Organization: kilabit.info
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tGtQvFdpZITxOyB7=8ZIXQI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/tGtQvFdpZITxOyB7=8ZIXQI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Feb 2022 16:03:55 +0100
Halil SEN <halilsen@gmail.com> wrote:

> Hello Shulhan,

Hi Halil,

>=20
> I just stumbled upon your patch while looking for the patch
> that I sent at the beginning of this week for the exact same
> issue.  It turns out you sent your patch two months ago.  I
> should have checked before debugging :face_palm:
>=20
> If you would like to check it out, here is my patch in [1].
>=20
> I see that you have fixed resizeclistpanes but exact same issue
> is present on resizecdetpanes as well.

I have never encounter this issue.

>=20
> I am not sure if the conditional logic is necessary because we
> are sure that `sash#` includes x, y positions in ttk mode but it
> includes only the x position if not ttk. Also setting the y coord
> to 0 might have unintended consequences.
>=20

I am new to Tcl/Tk at the time fixing this issue, so it kinda
try-and-error-patch with printf here and there.  Your patch is more
simple and fix the issue too.

>=20
> [1]
> https://lore.kernel.org/git/0b5b8fb591e434a2a24b1f58d1ce3fc7da48a28e.1645=
386457.git.gitgitgadget@gmail.com/
>=20
> Signed-off-by: Halil Sen <halil.sen@gmail.com>

--=20
{ "github":"github.com/shuLhan", "site":"kilabit.info" }

--Sig_/tGtQvFdpZITxOyB7=8ZIXQI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEzvGqh+M3psOQ3lVQ+FB+6RSKTOMFAmIWbAgACgkQ+FB+6RSK
TOPTLgf/cgGe+aXgK+uprDEOnR54fzLTRGyU6kY/LarBI9K1o8gxer9kFLRhRK0w
wc2LtImzX4UiLhb7I9HdEDgXtBpsLLOw37PDRZb3kqLnqluK6LFxBe73ocmmAS95
bTAgdfaGBbDEeh1RR9Hxzqc/I7jLOZC2AanZxXEnKd0MzYUmg2fYT2geypxB4kNu
jF7+XxixFxPhqT5UDXHyydAntN7prqv7VL7+JZF7k1NZTbf4VMy8pRtnHptcL3nT
mWapaE0xzVuQiI9jEjQW5XS8WNQn+w6lSMwqiSOWiC6YK+/bN790XhgSP4GsNRAu
hbDdvYnAXGepDlQeaRr/tIIzQbUqzQ==
=fzGT
-----END PGP SIGNATURE-----

--Sig_/tGtQvFdpZITxOyB7=8ZIXQI--
