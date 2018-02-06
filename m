Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26951F404
	for <e@80x24.org>; Tue,  6 Feb 2018 01:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBFBTs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 20:19:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58708 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751835AbeBFBTr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 20:19:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B23F36042C;
        Tue,  6 Feb 2018 01:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517879986;
        bh=2463Dixr9ej4fCGr1EFa9PvqCPLsAo4Px9egYo8vmeM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OnEsW7W1u3jHJmM3WPutFVCeYCMPE27BVYtw9KB2U3tqHYigqJFr5Zj5NohSxoXSC
         iMPhDsI1KwhqVJWfxzDkksLHJKPvNJvUAu2c5CvfN1dhRTCCIHT4Rkq9LFfw8YCv5C
         LyoVniJI+246kP20Pojq84WtSDCPffXsI18JsAONkDpxyn9Vn1ijFfwvw537ea1duQ
         s8W79OXOXV75rVrsFYH+CwMXrkAUDCl03ovw8rVg3OrVsOOcBCiY/NBPjBtezNqocF
         M2MmgTlvu2nXBrzN2uu7952f/U8svS07Phu/dPJgWh6jKdOe+HYNE+qIaZOXPL8g81
         GrpVop2DZII8IzU6GM+SUXjmwhhUajfCn37uW33Te8KnPP2W4YfBHyoJguBwVSZyP9
         mOXvr5v49NSsoXamYACKd4Zs9m++iC1VNgXycsAMSn8EsY5gN7cg0O48XXg215mxG9
         Tt0CrGlFgxEX3bxZFYLKhSr6cbmVCyl1y60AuQar8mQZXDNZTIi
Date:   Tue, 6 Feb 2018 01:19:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 025/194] object-store: allow prepare_alt_odb to handle
 arbitrary repositories
Message-ID: <20180206011940.GD7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <20180205235735.216710-5-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 03:54:46PM -0800, Stefan Beller wrote:
> @@ -434,12 +433,12 @@ static int link_alt_odb_entry_the_repository(const =
char *entry,
>  	ent =3D alloc_alt_odb(pathbuf.buf);
> =20
>  	/* add the alternate entry */
> -	*the_repository->objects.alt_odb_tail =3D ent;
> -	the_repository->objects.alt_odb_tail =3D &(ent->next);
> +	*r->objects.alt_odb_tail =3D ent;
> +	r->objects.alt_odb_tail =3D &(ent->next);
>  	ent->next =3D NULL;

I'm sure I'm missing something obvious, but it's not clear to me that
this transformation is correct.  Could you perhaps say a few words about
why it is?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp5AqwACgkQv1NdgR9S
9ovNXBAAnDYkHpuEkrnEmn3wbsuNSNfNBNvH4AZiOv3dFZzDWyJ94VuJqgCTrSr8
4GnAs0GxLdwvY6wEA+5kmln0TVGgzu+3Qd7o5rJniJopjx5H4bVNXzWqmVTUbxTj
sLhLN9Lvrf/Famm9D7fpYbHOVOahIt1izmqVx8xd7QwC3+CwsKW34rcM9o5LXSMx
ElUPxOdUhHwchiAjLxw49lcmJpOHw5c8Lcy8IU6MgDN9x0GWvWsFILcszQQGrmGh
O9uPKS9S7TuAJBHoJieAA/1nkRSYSsA/a5tTpPGoborjS28pdLKCrMORNOoF6FNH
b/GFPVe2uUMAY5WaPGYqoh+/aPM0E3BpeVijg4n7Nb3Ct2SWYUVBaBHuNVOUHQQZ
epH98FAvB30Hp4ESnyCMgqNlMrVGaHNA3LEJx6EMa73T42lo87Hd5XFsIRVf/O23
MSrKRQv31tU5P2cLlK0DF/jJo0bmUUsaRjumjAbkcu3AiW3KOTX+hrFeEL55Bpy7
7dsktFsZ3mC85yvuLXbBBmtO/uwRS3i0PpoigS0EcC6PW9NOZKQI/I4F3Qk1qWNU
XGl+7HfOOgv/2lbqNHUY9eySM99JacQnWE2XjnWCwoVBA9RP0/w7BuoaGRqcOfki
U6KIVCzfnFZVUOjaaKOxNJU8qNlj5YlHIwSpUuviKRqA53RMeU0=
=Nboy
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
