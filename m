Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0BE20958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755805AbdCTWOh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:14:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46688 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755760AbdCTWOg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 18:14:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D29AC280AD;
        Mon, 20 Mar 2017 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490048074;
        bh=21iWI2BUqhVQslfP7+YvwAVtLyr253ss+qvaVgA76Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/LRMblDqGBgZ+bYyMm1dFKldPmW5VbbMSjS2DLJ//rVaEBTJ5UJ4tKn/6TtjIYkn
         GgbNS9KaxCX5A0U6OiotozEh7LBRz9MhfoOY78QOwMgSCTMqupk7UMVL50pmkuH5e2
         zXL6Fx+OPgYqtZBtjqXixtVdLNjpzIh3S4bAtyc36RAmwGN1lSRRzvB5LJj1thinTO
         9b2mOHcFxPDt/wZ5sdutoTENNCFOCKuqPjIk81aAtUVgTJdgNJcuiuD0BCFXJ39TAV
         ZQKBJaRvZRI78yYzXVm3j6+wzMg/WdhW08T0jG9yAp4bnzHSPqaNJ2JsTjV3uL+NLb
         8qBqn4vGUoMqXWA3grzjDEyD7d5XA/06D2Ja34ySmJoX8xhthHvvCej8l4bPPvPTkG
         uAvBtlnIzHsXlsCpe8SZZEWNhYIatraJKzwvCJGyyr9FYg6R7E3l2KhzIO4CUWXyVD
         /30fPe3a4XnNKtkZ401ZU1xE9CR3hu8QA7K701TzxWY+yD6BIyt
Date:   Mon, 20 Mar 2017 22:14:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Alex Hoffman <spec@gal.ro>, git <git@vger.kernel.org>
Subject: Re: [PATCH] Correct compile errors when DEBUG_BISECT=1 after
 supporting other hash algorithms
Message-ID: <20170320221429.qefqowtwe2ptvgdg@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Alex Hoffman <spec@gal.ro>,
        git <git@vger.kernel.org>
References: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
 <CAGZ79kY1g-4c+GXZy3p-q=MsBY94esxsfs2=OPuhOH_o5oGc_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6dagtxm64rr3yrxu"
Content-Disposition: inline
In-Reply-To: <CAGZ79kY1g-4c+GXZy3p-q=MsBY94esxsfs2=OPuhOH_o5oGc_Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6dagtxm64rr3yrxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 11:11:17AM -0700, Stefan Beller wrote:
> +cc Brian
>=20
> On Sun, Mar 19, 2017 at 2:33 PM, Alex Hoffman <spec@gal.ro> wrote:
> > ---
> >  bisect.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/bisect.c b/bisect.c
> > index 30808cadf..6feed8533 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -131,7 +131,7 @@ static void show_list(const char *debug, int
> > counted, int nr,
> >                 unsigned flags =3D commit->object.flags;
> >                 enum object_type type;
> >                 unsigned long size;
> > -               char *buf =3D read_sha1_file(commit->object.sha1, &type=
, &size);
> > +               char *buf =3D read_sha1_file(commit->object.oid.hash,
> > &type, &size);
> >                 const char *subject_start;
> >                 int subject_len;
> >
> > @@ -143,10 +143,10 @@ static void show_list(const char *debug, int
> > counted, int nr,
> >                         fprintf(stderr, "%3d", weight(p));
> >                 else
> >                         fprintf(stderr, "---");
> > -               fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.=
sha1));
> > +               fprintf(stderr, " %.*s", 8,
> > sha1_to_hex(commit->object.oid.hash));

I think here we want to write

fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));

> >                 for (pp =3D commit->parents; pp; pp =3D pp->next)
> >                         fprintf(stderr, " %.*s", 8,
> > -                               sha1_to_hex(pp->item->object.sha1));
> > +                               sha1_to_hex(pp->item->object.oid.hash));

And here, as well.

> >
> >                 subject_len =3D find_commit_subject(buf, &subject_start=
);
> >                 if (subject_len)

Otherwise, I think this looks good.

I'm sorry I didn't catch this earlier, but I didn't even realize we had
this option, or I would have tested it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--6dagtxm64rr3yrxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljQVEUACgkQv1NdgR9S
9ou0vhAAubt1ky4wH8tyqrqu6V9NeCRREbU4SZxm+UNU0b5Jj83XgzZiRtHrVrh5
vr0j1qRjPbpAGaYcC7SDQ0Jin38LCB98RvLOZk0F48hA+DVuVTT2NEC8nTe6O7L6
qoq0tXTRPk/dF/oIOd1aBvyDnELKlYTkwUpOCz1Sj++IyL4/gaPkVFPzTmrwWfrX
Fs5fu+srgErehuxriQQVES6fENhVPY6Na8eivgJOSeLgXPlLFHWiG1/rjwrlfJOh
gAIQZe21lInXecNmJRweFxer60GJd9pur8Kaq9zEG0uzE0VZjMCcGDVWa50MT5go
ZwJlpIbAx1Vh+gOqGKSYxmC8IsDzIcZJP1GV9lF3MC7+3jvb5052eWzexF3HrFaf
N5FCBdXFT3Wv1WZQzNsOYV5hUGpvg7kcOvW0fW/Dm0EH5ZP75PmsbvJxODBzowFm
L/bFgxRSWBdmfWTi5Y7yQIL/DamopNmhq1MIpsmp59HCfCDM1ddwFd1xrVV+l5NK
ppq3EQDrKgEMaSirEsF+jDpxsLPV+gwWXVDIdo5GpVa5vit8VRV5s2KP1XwWj0r1
zA1/YCGdeUGILZbzsbpNRjPyvFGkMPo2sr7pfSLHmRLdd6nBhkGXlIrsn7Vnx8Nr
i0jFTmKIqMzikya3vLWUqRjUmY+MjLwfcsNJrUrczWl2jB96Sw4=
=qJnM
-----END PGP SIGNATURE-----

--6dagtxm64rr3yrxu--
