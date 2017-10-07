Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6272036B
	for <e@80x24.org>; Sat,  7 Oct 2017 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdJGVVI (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 17:21:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54520 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751823AbdJGVVH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Oct 2017 17:21:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CA61160D8E;
        Sat,  7 Oct 2017 21:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507411266;
        bh=0Y+E1/k0ebAGmLj5lxo60kITAevOxXDVZ6nY1/LvjaA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HcHMKeNDw2PyVqXEr7O72QHXApNmYjMY5dfmXs0ijkiGQE+UOO+sjIZydv9aEWoj4
         iou/q5dhrl2Z+Hrq1wayhFl8zMdmqslJz9239zfrtoJ0qtYRSmirvoDAq6BCftrPfY
         DkhH5s6KLmBS+ZuzZbDb4k2RE6rLyr+0rBPZTX4Gr9hcAVLciDSCv9Soqr1YLYaia8
         D7qzhaCRv1zA09ybIrr7e93JOcYo/YPSbnKsz7WJOnn1vOSeeTdVK9Bz/AgPf2c037
         FewSQpakCZUiw35Q+dnHI4HIyTZ6jgAEvdmq6b6jBVxdrZSjXwe4wQp27fDgFHeD8n
         GvlhbN6JWet+aZxX59enUrYTgK0Wdj8pWfm5xcHkUtul8fMVB4m693ns5uAPuNcQhC
         +/cdSZUc4QBzq5xohNUQ1I+Iv06lr8MMZPbi8WvM+1zo+1oqiwaa0FmhL+3gADFEjg
         kWRwcs7pSHIFJiAQnzTbI+OLNP+BxmrotOBBltRozz6b/kmdJwZ
Date:   Sat, 7 Oct 2017 21:20:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
Message-ID: <20171007212058.676kdlwyxvtw3gi5@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
 <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hvtrpn3pipx4od3j"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hvtrpn3pipx4od3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 01:39:16PM -0400, Robert P. J. Day wrote:
> On Fri, 6 Oct 2017, Junio C Hamano wrote:
> > This is primarily why .git/info/exclude exists.  A user who does not
> > use the same set of tools to work on different projects may not be
> > able to use ~/.gitconfig with core.excludesFile pointing at a single
> > place that applies to _all_ repositories the user touches.
> >
> > Also, core.excludesFile came a lot later than in-project and
> > in-repository exclude list, IIRC.
> >
> > Don't waste time by seeking a "compelling" reason.  A mere "this is
> > the most expedite way to gain convenience" back when something was
> > introduced could be an answer, and it is way too late to complain
> > about such a choice anyway.
>=20
>   perfectly respectable answer ... it tells me that, between
> .gitignore files and core.excludesFile, there's not much left for
> .git/info/exclude to do, except in weird circumstances.

A place where I use it is in some Vim package repositories that I have
as submodules of my home directory.  The author of those repositories,
Tim Pope, explicitly does not exclude the helptags output.  I simply
ignore those files using .git/info/exclude.

Another case is when I install a plugin that lives below a our main
product repository at work.  I can simply exclude that plugin locally on
my system without the need to submit a change for merge.  I can later
remove those patterns if I like and run git clean -df to clean up.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--hvtrpn3pipx4od3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnZRToACgkQv1NdgR9S
9ovIBxAAt9JPZGHmq2LU77Fes+ezI0Fe6RwzlyD8uE3C5nrjOkQh9yFTKUdl3DgX
pp3g5o/BQEgTuUTa4WeN5Y/6aRCbSdMT2So2fSJrhox49b0vNYgc/fNmFngwATJQ
NUhvcWv7hHpP05TqQITi+Y8xI7QZlbaP7QIKIX/vuLhHvH2MCC6eg8/Nartbp7qa
bzadVXlateNBcZ30/DQTgksqNbDHNl4gRdcC1PNCEBiwHbejoaScuz5lVoPcxXGP
g/kiOIt8NO/w7gsj1zfxaEx0mB/Slruh1pIyXaxsaRlgcinelghMkQrlCueoPmoe
M/ZJgdas1SkYTVWpUpOmarybvh6IwDqYs3PzBTe2VE/U0+xupV+Kna0SBnZdL9QC
BGA9n3053CF0TGsoZzdiNfoM070nmKOCpSOsOtSU/W2eUKXNnHWPdROks51t9TCk
7o7pra+K/K+dMc3vN8LthlXkymyeyNM8PLWkn7iP53asMC+y9Hr9eiou3ySwDHLL
JoJYDcxFopNND/b2+R2hvv2KhN5NlP6BSs1CNtDoOYPR/i3jRI26PvC9KnxFqFtQ
PI5iKdbp6qtJApKmaw2mE3T+Uqn/PDxnh9pdwkbDZb/EwSB1RGBbMVgd0aqwdupr
G8u3DUN1Ra1XnPxYcQ4HjawM6vjdNiB3IVWANSG9cJ8qI6z9IAU=
=2Fwn
-----END PGP SIGNATURE-----

--hvtrpn3pipx4od3j--
