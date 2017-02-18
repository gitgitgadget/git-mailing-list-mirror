Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC397201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 01:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbdBRB3y (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 20:29:54 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60358 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752527AbdBRB3x (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 20:29:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 11AAF280AD;
        Sat, 18 Feb 2017 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487381387;
        bh=ARmn19rNBspm5bxRaAqIMfmBbq0wusLJy7WW1jIksRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmQ+7HZkb1/jvALge014XUtA+HSXn2eXKa9XuhvpugQyA9IUaY/MIXAYjn13i+i7E
         4baAMQnAx2UXuxn2tnGWskiZPXlkAEPk6lBbhZ5jfWBr3Mbm2SO2Uc5AQb18vFYLnk
         zlQ4COvX1GOx0MdlX36WeuHUvXBSFoTVXjqPExIqNpebD0VxMxpBqGbC2IU10tfvoy
         6M8BSk5Wj9znEXxihF4mpPhS93kaLrQ2lpzwOO70IUwuOM6XMxcvxxoePCib/nKWnn
         Rswwqz/bEo3im8TZBADQGU0dtPvEni8bQm+csx8CVdijxK44DMd0Exy8TSRdWpX1dy
         ZbPEf0tIEsxpl9aEdjbZmeX1QaQR0p1diOLhkYtp8I9ikaTKOfSVAiF6VzRW1TGsZs
         tdJLs6OYfLBJUTL7kkLAHBvfUFkSnraV1MNB1b+empTjO+k8PE7N2RrCxGmTUkkFj3
         61KihYuVViw4uWdyGGGYg96AEQp7gHCifZJJH0pLvFIHMn7pQag
Date:   Sat, 18 Feb 2017 01:29:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/19] sha1_file: introduce an nth_packed_object_oid
 function
Message-ID: <20170218012942.gr5atoshytfa2f2u@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-17-sandals@crustytoothpaste.net>
 <fc5aff14-a047-1a51-c40c-8918098f1f59@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmtj6qwrslmsixw3"
Content-Disposition: inline
In-Reply-To: <fc5aff14-a047-1a51-c40c-8918098f1f59@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fmtj6qwrslmsixw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2017 at 01:24:34AM +0000, Ramsay Jones wrote:
>=20
>=20
> On 18/02/17 00:06, brian m. carlson wrote:
> > There are places in the code where we would like to provide a struct
> > object_id *, yet read the hash directly from the pack.  Provide an
> > nth_packed_object_oid function that is similar to the
> > nth_packed_object_sha1 function.
> >=20
> > In order to avoid a potentially invalid cast, nth_packed_object_oid
> > provides a variable into which to store the value, which it returns on
> > success; on error, it returns NULL, as nth_packed_object_sha1 does.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  cache.h     |  6 ++++++
> >  sha1_file.c | 17 ++++++++++++++---
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/cache.h b/cache.h
> > index e03a672d15..4f3bfc5ee7 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1608,6 +1608,12 @@ extern void check_pack_index_ptr(const struct pa=
cked_git *p, const void *ptr);
> >   * error.
> >   */
> >  extern const unsigned char *nth_packed_object_sha1(struct packed_git *=
, uint32_t n);
> > +/*
> > + * Like nth_packed_object_oid, but write the data into the object spec=
ified by
>                              ^^^
> ... Like nth_packed_object_sha1, but ...

Good catch.

> Having said that, if the intent is to eventually replace that function wi=
th
> the new nth_packed_object_oid(), then it is probably not a good idea to
> describe this function in terms of the function it will obsolete. ;-)

I've chosen to define them that way for now, in the hopes that it will
make them easier to use (as people are already familiar with the _sha1
version).  When I remove nth_packed_object_sha1 eventually, I'll update
the docstring so that the oid version is standalone.  I think I've
already done that somewhere else before (although it may be in a patch
that I haven't sent yet).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--fmtj6qwrslmsixw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlino4YACgkQv1NdgR9S
9ouuTA//Z7Yf6a6pCFwLkdVMQ2x9pe/yvx2YvhrwkvneadA1+rxLUhS22c7AIO7x
L7KsWOtqANPHcsX4MUVNAHE+cahZaR8RPaUOdt0qTJUfqu8fB5VRGLMWRnl3fNEu
652nVL0NN4nfqtOFS/UPIiGhWtJSEqDoQJkPWiFtCcFqo3CjjCXnJTzMInyit8Ge
z+0sEZwY/PRVnvtbaoEdHS/w0nIvUSQwdpn7c1Diz9y8Z9KUyVm8VI/GSGskq2NL
SWF1cryTZTUlIL/Vu0MiNRL5F1e8lkqx9IkS3j1YeWyVD7dj6E+UHRI2pRx3cCpm
xPjX04b9uMlcyyZ32osAaM5PjqadYmMRniKa7QYIyNrAxOYozRNm1lZl534gF3Je
q6gq40891vczHYXYjv7Qyk9C0Fq2n0obqogUu1ZS+TRpmmRLhaZotrvz15sFAKLM
FOZAkz5eRJKZZP1Yj7di0BZmwV1S4wzk5LXuaeIcFjnjcz5954HVoot+ytYV1Mvh
dycduiSvWfRxeOcJK166eEmeEWEilsJdlIsiNN/oEyKq7G9l0wXjisQTsJEoumdZ
fNIyJJFWiuAdBNCV1Mx7tEVNFOv6b0uPRCD6HK6wH6Rug/g3CEzdJX3e8cheQ8Kf
XKFAdGdwyECMkEEz3FdYQw3gIk8v7fTV5PpFbCp8ZLttTdBlMFo=
=RYNT
-----END PGP SIGNATURE-----

--fmtj6qwrslmsixw3--
