Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B5C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02C2229C4
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbhAJUgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:36:51 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:55539 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbhAJUgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 15:36:50 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 15:36:04 EST
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 0000000000000151.000000005FFB6417.00007E49; Sun, 10 Jan 2021 21:31:19 +0100
Date:   Sun, 10 Jan 2021 21:31:18 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Martin =?iso-8859-1?Q?=C5gren?=" <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] refs: allow @{n} to work with n-sized reflog
Message-ID: <X/tkFuESnia/n35e@ruderich.org>
References: <cover.1609923643.git.liu.denton@gmail.com>
 <cover.1610015769.git.liu.denton@gmail.com>
 <c88c997eab2b3405cce20f719bf07d5bba7aa18e.1610015769.git.liu.denton@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-32329-1610310679-0001-2"
Content-Disposition: inline
In-Reply-To: <c88c997eab2b3405cce20f719bf07d5bba7aa18e.1610015769.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-32329-1610310679-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2021 at 02:36:59AM -0800, Denton Liu wrote:
> diff --git a/refs.c b/refs.c
> index bfdd04aefd..e70dcd33f7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -900,40 +900,53 @@ static int read_ref_at_ent(struct object_id *ooid, =
struct object_id *noid,
>  		const char *message, void *cb_data)
>  {
>  	struct read_ref_at_cb *cb =3D cb_data;
> +	int reached_count;
>
>  	cb->tz =3D tz;
>  	cb->date =3D timestamp;
>
> -	if (timestamp <=3D cb->at_time || cb->cnt =3D=3D 0) {
> +	/*
> +	 * It is not possible for cb->cnt =3D=3D 0 on the first itertion because

s/itertion/iteration/

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-32329-1610310679-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAl/7ZBYACgkQkv79t+RM
MvmUKw//UgLUnUaiUOtdHB+Z9ZezD6jRgF2Z6oDycWsxiyGT2n8gueIrN8LUndT5
zhSSDymYj8nEhbvLb8wZyz63I6nxmJXYItb+v57lmkT6BxgWMjtod49e653pHRQ+
cAMHcajWninSFNMMe8Qx+jswGmaXIVdL1VhsjtJLnZG9c5T34JTxZbkE4YPEOcAP
auvMH9ja4cKpaFqG4U0CctgICH2+qGV99VmLx1/P1Ld6Xvgw25CfzU4Q/y8KC7+7
NfBR6K9QsURFTBk9oP7q9SaM+201Bq95/kyM/sqgalcSHUcIWo6jeweNOp2IDGB4
RrmnjtJI+bJGbtWUDWVVhNpxms4HbyNyIH/Dgias/yAHgv+aUkSNhXFL9F2MQNPI
yPxPcW7KtvPkh8J0QHeXETYvIhxtjI9UVdFQNQHlfkho0YvQqrAtaK94ad+2ppxf
UDmQlms5/pzZyJlldukHFCwaOiVOZi/3mYDa39Rc2o2V6c8wmfzZX7c276GT8jPU
e1hcikbN9D/NU5By3xUJt6WhDHNAzYlEgHQ2wovJkKsiZpS73dHoxWdw/3bxpcfd
P0aFrfBR3+Q8tNkqIFzg26ew4keMwy4J2AVtD77noofBcEMI+84afNZQmPnRNGeC
8or7OSeZALr/9lQSNE22Vos7/99nvIz1xMNEfNNUoAm8souqmPc=
=t23B
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-32329-1610310679-0001-2--
