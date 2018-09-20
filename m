Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF801F453
	for <e@80x24.org>; Thu, 20 Sep 2018 00:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeITFqa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 01:46:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbeITFqa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Sep 2018 01:46:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A5AC860735;
        Thu, 20 Sep 2018 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537401963;
        bh=vUO498MIY6I+R8TK9b/E7f/VgTyhSFJfPZCROpLWnxM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vGKUDrit/mBMSvhAjG6wK59OZECC7RDdn1SsLWC18GSdYhrHRTNVYykPXp9YxvW9b
         Q79TCFpa5hFp3IxwzhCB5+4txTAXeFSvnHYSVawo8KxvHNhq9cZA91QJZPBcBVhjjj
         BU0z+WREuQgF8gR8/g3i8E7oZt4E385NMH1O838SQddbuZOABCRRY2VdJmEpNEfIEi
         Q/c664sA1PhtQi/ui++6fR3GTIs0GFnDJDKLXcO6UQ7eaSGFiPqoQV9zHh/m474Vbf
         WbAPrgcoKkpGGBwyHERSnrqgnUKVzMdvWD7fSrO4CYWFIJY1aKUVGdiR0ldp/XSgRo
         nGA+Kdzqtjuwn3FqOpzdCAGjsqi4uPF2YhBpms4FsXYzmY/ifn6bvPKo/AZsA9pel1
         DgiX7WP50CVfB+2hP8zCZmMzR7l7WWPCimYQ1xjmp5jrQRTe9imngj3gJpLR9OvIUa
         uYgGxvPL7WcFw9rhNYmCYAleBZpr36y6HUGZr2pWVsrsDgLycUO
Date:   Thu, 20 Sep 2018 00:05:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180920000559.GA432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <20180917231850.GB81083@syl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eQ8QKBgzzGzhafWG"
Content-Disposition: inline
In-Reply-To: <20180917231850.GB81083@syl>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eQ8QKBgzzGzhafWG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 07:18:50PM -0400, Taylor Blau wrote:
> Hi brian,
>=20
> Thanks for CC-ing me on this.
>=20
> I use editorconfig every day via the configuration in my home directory
> [1], and the Vim plugin editorconfig-vim [2]. It's a great piece of
> software, and I've been using it without any issue since around the
> beginning of 2015.

Yeah, I noticed it in your dotfiles.

> In all *.[ch] files in git.git, I found a total of 817 lines over 79
> characters wide:
>=20
>   $ for file in $(git ls-files '**/*.[ch]'); do
>       awk 'length > 79' $f;
>     done | wc -l
>=20
> So I think that specifying indent_style, and tab_width to be 'tab' and
> '8' respectively is enough. We shouldn't be enforcing a rule about line
> lengths that we are not ourselves consistently following.

I must admit that some of these are my fault.  I think we're moving to
use clang-format more as a tool, so hopefully those become less of an
issue over time.

> Have you thought about including guidelines on COMMIT_EDITMSG? We prefer
> 72 characters per line [3], and this is enforceable via the following:
>=20
>   [COMMIT_EDITMSG]
>   max_line_length =3D 72

That's an interesting thought.  I know different people have different
settings for this: 70, 72, 74.  72 characters is typical for emails, and
since our commits end up as emails, I think standardizing on 72 would
make sense.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--eQ8QKBgzzGzhafWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlui5GcACgkQv1NdgR9S
9ouUkBAAvHHeNncitnueMYTiQamo7T3HL2mV2NczgQPoC0UQI0ObMyd4zAi2TG/D
JPeVLwMClhWZCBSO24WvvebZ1I9npPIvvaqCKn9IhGRhp7ZPj4e6m1JW1DzuV4m3
7qfda0E4sVWog386tFDMQbRp44/XCmUmvwyP1KE5UXw6+T27fqXFNAT1dg7/16DZ
ZcWQNaPsuQV6pYAprAawMJSnjE2zyCGpGrpNRYX52ODtsmRJCkaoqgxRpIiVYo8b
QuI1iz2Atq/ro/w40mTV980bwJMBcVXsdRL/rhyOWjaAsAtOzUwipfNwk0lmUIN+
VTtpAabdvyIagHyhE3g7+h42qM/NuGej2JRgxOYoxi6YpXkoz0QnjgQ5mlz+Swda
Q8pnmMmjbA/v33guQYOqsQQAA6z0BCowF9BdPph11qaNcwN89BUOg9X79sx+XAO5
wL0h3BCjEGhXCyas7f8UA+jiDL0qmSo2azKSFa8qwbRMio+M9+DiT0niBiXe4JiM
MMJlW8yxbR57LpPhLnL66DAHP7WCImRfJhI0Gm6QEUTa+y14y5iFRBI5vxX5+GKb
BNULEgZ81bZltuK71GE0yXcikGCJuvMr0BDIAxP60GUVfmFcPu14nNBNJA6vIOTk
yuEfBDQ79h0Rbx/BwR/CDtnP5e3Lonyl5G3fxUu3ewt/iLC5Gu4=
=PbnL
-----END PGP SIGNATURE-----

--eQ8QKBgzzGzhafWG--
