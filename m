Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5128EB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFVVRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:17:47 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA65F1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:17:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5B57A5A210;
        Thu, 22 Jun 2023 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687468666;
        bh=7sC6iVRR8Cjra61oU93aCBCTPLVKxDFuejNCqoYQcX0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PwvsANFu6lF1RFBqEut1x29972GmlXwotNuuhKmhlOysm1sZzz/EGRhxT7xWCIa4G
         PAC1oPxHWZNV5VfLmLL1CjgMSyl+Tm2+1RQJ3bTzICZiseLgbfQXc/4o7hVwG6U3gw
         SzyF1MZeiTLewQvfRCXrVEI8qmf5VuF77LoSYkIBX7OJHALQW6KZcrNYkLDxPV+2LR
         QlrcZWhxW5/4Kb9C2uLfRTrm/sqG8I0Mz6v/h6j5TOTgVZJaLzxgZSFtCVUk7BQbIQ
         HL/VgC5cTpIsfRpceyGeKXFTk6VAgvIfRj1NiLyJXJnCCAoaVegiy1GiSG7WEy/rXn
         +n5FQ/5LIDRJBcyP/mcC+cWbwayWPQAlUAkWggNDVcpoaYdBe/Q3YSTf03TFMWSTgh
         trCWMSI9M8dsAShDzsK10QJo3RzB5S4Wz9B7X0eyc8eC5Nph5lga6tJx1qpqS/oXob
         CGk2lhSpDyDBNanu0uvVkBlbK6AJaGXUQ87vz9SOjGd18FPYqYx
Date:   Thu, 22 Jun 2023 21:17:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] var: add attributes files locations
Message-ID: <ZJS6eARkNOuT+Zd/@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230622195059.320593-3-sandals@crustytoothpaste.net>
 <ebdf8a20-9ac7-dcf7-8cc6-b63894b7eb45@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C8ecTQ7NbDUf9Pnk"
Content-Disposition: inline
In-Reply-To: <ebdf8a20-9ac7-dcf7-8cc6-b63894b7eb45@github.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C8ecTQ7NbDUf9Pnk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-22 at 20:19:46, Derrick Stolee wrote:
> One way to solve for this is to use the more modern style
> when initializing the structs:
>=20
> static struct git_var git_vars[] =3D {
> 	{
> 		.name =3D "GIT_COMMITTER_IDENT",
> 		.read =3D git_author_info,
> 		.free =3D 0,
> 	},
> 	...
> }

Good idea, I've got this in for a v2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--C8ecTQ7NbDUf9Pnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJS6eAAKCRB8DEliiIei
gZ9YAP9xX0d4w2z554iuTaEmflSH/2N9YWe6Bj10IMULjobGrQD/at4lQsFgsxA1
u8yBsZjfNtjd7CxcHE8Np1xr8q7DFgc=
=u2eC
-----END PGP SIGNATURE-----

--C8ecTQ7NbDUf9Pnk--
