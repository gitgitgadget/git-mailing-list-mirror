Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A2C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 23:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351856AbiC3XqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiC3XqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 19:46:13 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF6F1D0D4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 16:44:27 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4C0D95A0CA;
        Wed, 30 Mar 2022 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1648683866;
        bh=DjI5HvjzhdKP5no51Lq7xE3EV8xq3I0sg/1t6kUwxxE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XmAfhmqh5PUZlHjzArSRDiw2wqP9GFCYtmVd9qXn5gLiFA/x0xEFtpkr4UNNRn6+m
         Fv+9PeMOK031NQUnhxpjkSYmS2t5E0ASPjF5a/aydEzR9EptjHOeOvtTgp+EC0OGq7
         WA5ZNvhCCNekM7rpL1KVO168PLnhDRYH/Zd6c4dbGhpSWAj2NBRXQzu/36VWcEnESf
         WSbn4E33pKaeIqKCOmkt7bFtC6+glQ5VKEHwZEeaAepqS00JezlDPVp06OiymUGEtU
         w6/+VCx7K9WAFUHty+Gx9MSSsu4vH2/nQA6tDvgNZXkAH4hrhGeqjJi0v9xFfCJhBf
         n2SZzxki3D4TFwOuO0xDbpTuxKj2iOxRtehKRA/7J7WyapluY0gM6fog4PeswTRdB0
         0217Qw5PC/kJ1iD++KcTrfJvURrIV39g9N01D1LrLHWyCGbGjH2hh1XSbOZvhdToVN
         HXhiIh4zgaG1WXPJwn8LWcogo2YMXn7E+fitqe9zl14IO32uK43
Date:   Wed, 30 Mar 2022 23:44:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes to
 a ref
Message-ID: <YkTrWPmIaBzl5SA5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-4-sandals@crustytoothpaste.net>
 <xmqqtubf59dz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SQ3HszUW2WxfDR8"
Content-Disposition: inline
In-Reply-To: <xmqqtubf59dz.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7SQ3HszUW2WxfDR8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-30 at 23:05:28, Junio C Hamano wrote:
> Documentation/CodingGuidelines still says this
>=20
>  - Declaring a variable in the for loop "for (int i =3D 0; i < 10; i++)"
>    is still not allowed in this codebase.
>=20
> We have been experimenting since we merged 44ba10d6 (revision: use
> C99 declaration of variable in for() loop, 2021-11-14) at 5a4069a1
> (Merge branch 'jc/c99-var-decl-in-for-loop', 2021-12-21), which is
> shipped as a part of v2.35.0 just a few months ago.
>=20
> Let's not add more until we are sure that we do not have to revert
> 44ba10d6 (revision: use C99 declaration of variable in for() loop,
> 2021-11-14) to limit the potential damage, especially when it is so
> easy to do so.
>=20
> Just declare "int i" at the beginning of the funcion and keep
> reusing it would be fine here.

Okay, I can reroll with that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--7SQ3HszUW2WxfDR8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkTrVwAKCRB8DEliiIei
gcyJAQCRTswyAS8wpxqhsj99E58+qgnHmHTeDeRct4rHfidjowD/ZWdN37bpjyvm
FaeY4mlwnfZkmxEjO0lxtqMKZkg3jwg=
=Q5iN
-----END PGP SIGNATURE-----

--7SQ3HszUW2WxfDR8--
