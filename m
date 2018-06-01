Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C182C1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 14:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeFAOgR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 10:36:17 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:43429 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbeFAOgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 10:36:16 -0400
Received: by mail-qk0-f175.google.com with SMTP id h19-v6so20008953qkj.10
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JkZU1BRrM9MbdzoA9vPExlljAJ10vJkwWzN9jDHM0Pw=;
        b=VZ6O13xmdOhmKaECRXFCTh5orucqspqMpQjxOHGgFPggvt/4gdMGlo2fzd06ZqFV8s
         1FTZNKlbsxiZ6A9TLJlaaCa5TwC7UjE3zbZ7rC2demvEl93+athXKNUAt9eSPcEPaA6q
         joIG5dNTUXNSLWlCcM0gnVG82XQBwp+AEDWCyG3KEWKdNp/Z/wwNNzi/hbwC726c0DFI
         hv8IjCZSxlfRIS8FNfX+cGWxTC1iMVTnHFh2X+GMRy1xKj2JdqawxzpLORRXukXmN50p
         rlXb9tNbGT2eGZ0tUpXqEF2CC/lv2rLWEMGYyHw2L7k8d+Y7X7Y4jRaR391ixvxQMU+f
         NllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkZU1BRrM9MbdzoA9vPExlljAJ10vJkwWzN9jDHM0Pw=;
        b=ru8H4DgukVS0xP5eHy6lByPKmtOguhr3tgv5o3JJamIye/emAQyZMf61TqUJDFwIKa
         Jjn6Mj6sr7NjMfqpAw90XU28SVrXkAQTxDKoFZUY3VmfkEgx9dadDu7rXcNmI66w2YLG
         eS9KXLy2BBZyLZQt0nAl2yBpJrO5fuSzZwwG0Vx6FLPk7HGlgNOv2IcTick6CLmGouaV
         dff0iUSpfdpcbno3MApST2S3DgDl+Nv+VFVkOB4UgGdDmLV11pkpM55/ve0P7zA/1AK0
         jbEK3gX08ulNZX/t4N5UKjwwFgG26ywRgxJiAeSGRNyb93+xGRf03koNq0m+sALjtVa+
         XT7A==
X-Gm-Message-State: APt69E2vJ87Ny6CgetDcRyOCQGfdm5oXu6kvS+fRRJ4mItFrcVyCCfi1
        AoHwg55nNgOcp3QqJXnueGbIyQ==
X-Google-Smtp-Source: ADUXVKKEAPilhLw00BjVYkOGB5BscZNVSW1CIfrEQgKvmglLDnV3LZAoWyf8m5zvxTB/mLjCtHZAGA==
X-Received: by 2002:a37:dd45:: with SMTP id n66-v6mr10690986qki.442.1527863776027;
        Fri, 01 Jun 2018 07:36:16 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-149.NATPOOL.NYU.EDU. [216.165.95.149])
        by smtp.gmail.com with ESMTPSA id h48-v6sm32448583qta.43.2018.06.01.07.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 07:36:15 -0700 (PDT)
Date:   Fri, 1 Jun 2018 10:38:25 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does a new repo actually *need* default template content?
Message-ID: <20180601143823.h7fvri25q7om4whn@LykOS.localdomain>
References: <alpine.LFD.2.21.1805280836140.10191@localhost.localdomain>
 <87h8mr7jgj.fsf@evledraar.gmail.com>
 <20180601070609.GC15578@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ohajyoirdoi2q66r"
Content-Disposition: inline
In-Reply-To: <20180601070609.GC15578@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ohajyoirdoi2q66r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 03:06:10AM -0400, Jeff King wrote:
> On Mon, May 28, 2018 at 07:56:12PM +0200, =C6var Arnfj=F6r=F0 Bjarmason w=
rote:
>=20
> >=20
> > On Mon, May 28 2018, Robert P. J. Day wrote:
> >=20
> > >   (apologies for more pedantic nitpickery, just little things i'm
> > > running across in my travels. aside: i actually teach git courses, so
> > > it's a bit embarrassing that i don't know some of this stuff. *sigh*.)
> >=20
> > Aside from maybe the empty branches/ directory (see c8a58ac5a5 ("Revert
> > "Don't create the $GIT_DIR/branches directory on init"", 2009-10-31)),
> > none of this is needed.
> >=20
> > I wish we didn't create any of this stuff, but have never been inclined
> > to make that my hill to die on.
> >=20
> > I think we're much better off just shipping e.g. a single README file in
> > hooks/, or just nothing at all.
>=20
> FWIW, that's my opinion, too (including the "hill to die on" part).
>=20

+1. It'd probably be worth having the sample hooks be part of the
installation, but not as part of every repository (e.g., hold them under
/usr/share/git/samples/hooks/ or something along those lines).

> I also wish hooks were just shell snippets in the config files that
> could follow the usual config-precedence rules.

I like this idea, but I'd probably keep the snippets in a separate file
to keep things clean.

Thanks,
-Santiago.

--ohajyoirdoi2q66r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlsRWl8ACgkQRo8SLOgW
IpW25RAAxfO22UCUL4VmLcu2h7ssGWdzYzWlOjris1TFJxlpt6ZzYgL1e46UfMcY
54MGZJ/Olxp1b1EpTByqfTLYksmSKMYDFRhpruQQQoxrvLucdfsnOfRHIv0mYQgd
wxsPwJgInrep34WlsaPov7i6aQ4WSllSog/qAjSwG+haJH6APIumRZS42Jgv9dnr
fgbvB+L1eccOzBuz9OIMIg1rmz1PqWMgmUkMzBsPNPFGcv9Pg23zDStpSSoD6fyv
/SGwZR03su5uU7wt9YAe9TaRxq6RXyGlQKAH1+e/GgAnq+8+Zq/rEEAmBaFIilvS
Jvc925hthtq3dza56JyhlqTLn8yJhOzakqJdcb5thDOtw4KDkhN6kxRmZ5ceEEx5
YJ2inmDZeJvSk9C/8keUaHLmvElUDU5txI3fsm8/h+IMRAVg20KMpu9QA9i6AfPI
UaU/76eA9xUtYlBNKg5Bbi5kCAyH1fZ6WaQqOWr0n8R4GI4b78i+UxGDKCzdsas4
l86LEGHFKtBctuWIP7RJCCWBZohroOjkyPHkTeOcQLceNUTTIL7JXuiMjUVaY65E
2rVyRTp9YGGk8+nlMXlrKFskXzNHsp9ib4UT80ZFuiAM/hYWtM7akMcb/Ynbh5MD
TL7Xb4sjrPre8+U7i9mn4rTo2ALdareBUvqYz5Q9+Nymhx7zDqo=
=bd6X
-----END PGP SIGNATURE-----

--ohajyoirdoi2q66r--
