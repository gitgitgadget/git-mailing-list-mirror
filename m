Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D362C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B6D206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EFeqt7Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFEWjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:39:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39034 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728013AbgFEWjw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 18:39:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E7696077B;
        Fri,  5 Jun 2020 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591396761;
        bh=kONsFwGBl+a1jYaDkSLCdf0bFf7l0JOXcWJjbFwYvdM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EFeqt7Ls6OC/QeQf0+nw2mbKyJn5NQBWslkPvGgPOjO4arNOdY0lBktxhJXihN6jT
         QFAQqSw6OK2mKvWoErSBjVfA9mFTjW3PvZXjfoaJ+WvCjaDh/nDHR2ICVpXYcf62KV
         jCyAGaqdRBdPRMCkHclOXlJ/L75oi2b0S0EvqeYdw5zdmKsv16zl6onlo5gOakp3DB
         s+uZ4l2ItxPMe8aJLg63GOOK32Os3ZkE3qgmv/GirZb8oB6BSxzCmA8cYVF1mzhJp8
         6hmOiWb9/jzKGpj4qUBKAUmZCGMtRSGwbZFYnQxUFlwDmP1htgLm3+fCKe8oGAjNbJ
         HVT6MH6vgYRitmikB/K76E+K4AWXI/t3hPdiGe2pijVrcsYtBCfB98mqs6YJqDkRqw
         dsF2smdumwHS03TbzTg9qamiCDEQHd/ENBIf4cPDIa+NyElRxrUNtxoSB3MjrCHV90
         ebs53i4RiZk81uDm6T2My99hZ4+6MjyhGgHatHgbyAm9cvY3ZKK
Date:   Fri, 5 Jun 2020 22:39:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 20/24] fast-import: permit reading multiple marks files
Message-ID: <20200605223910.GE6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-21-sandals@crustytoothpaste.net>
 <xmqqimg5o5fq.fsf@gitster.c.googlers.com>
 <xmqqeeqto4x1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <xmqqeeqto4x1.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-05 at 16:26:02, Junio C Hamano wrote:
> diff --git a/fast-import.c b/fast-import.c
> index 0dfa14dc8c..ed87d6e380 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -150,7 +150,7 @@ struct recent_command {
>  	char *buf;
>  };
> =20
> -typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_id=
 *oid, uintmax_t mark);
> +typedef void (*mark_set_inserter_t)(struct mark_set **s, struct object_i=
d *oid, uintmax_t mark);
>  typedef void (*each_mark_fn_t)(uintmax_t mark, void *obj, void *cbp);
> =20
>  /* Configured limits on output */
> @@ -534,13 +534,15 @@ static char *pool_strdup(const char *s)
>  	return r;
>  }
> =20
> -static void insert_mark(struct mark_set *s, uintmax_t idnum, struct obje=
ct_entry *oe)
> +static void insert_mark(struct mark_set **sp, uintmax_t idnum, struct ob=
ject_entry *oe)
>  {
> +	struct mark_set *s =3D *sp;
> +
>  	while ((idnum >> s->shift) >=3D 1024) {
>  		s =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
> -		s->shift =3D marks->shift + 10;
> -		s->data.sets[0] =3D marks;
> -		marks =3D s;
> +		s->shift =3D (*sp)->shift + 10;
> +		s->data.sets[0] =3D (*sp);
> +		(*sp) =3D s;
>  	}

Yeah, this is much better.  I'm not sure how I missed converting that
block, but it definitely leaks heavily, and obviously we don't want to
update the actual marks variable in every case, since that defeats the
purpose of the patch.

We don't actually hit this case in any of the tests because we don't
have any tests that have 1024 marks in them.  I'm having trouble coming
up with a test even with a large number of marks because I don't think
we produce different behavior here; we just leak a lot of memory.

This does fix the reported issue, as I suspected.

Do you want to write this up into a patch with a commit message, or
should I?  If the latter, may I have your sign-off for it?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtrJjgAKCRB8DEliiIei
gd1DAP4unGq2r2GTXoASIARWGq5dDHGRNmbttPNha8SQhFGlWAEAoIGXwbDC9FKz
ZwgSsIVjEV3boRu+Zznl2WtTOLo/lw8=
=p3af
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
