Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4181F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeICXdH (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:33:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbeICXdG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 19:33:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7876960745;
        Mon,  3 Sep 2018 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536001891;
        bh=MWTUEaxiyIpJRoE1mIlWUWZFbVKSLWRAqi3v7tEq+90=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1RPz7xU4/PlBUqFLLzCRRaVxynm3Pqdovsw1rCFQxp+TTmfRzRsZU3jfdH6s23Vnf
         O+AQyNeRRvDr668ivBOu0prWq4N/oCDmzA4ohMdF4jcmNRyy2526VVJLzhi4sr/ud3
         XAUzrJu16octRpRzDPDzc+BJvwqQjoMC86r1ltYKVzarTzEnSka7l4fdvg+cMQ+IVE
         2rLkFK/vvn7XIp+vM1c1Bcuk9oqMfWu9pSgi4AuihHuZZwCQ9DbOAVhd2Ptna48NRr
         ym3iI6ryWTfhVuAmLHEWtyugYZg5F+Ex8kGxd9X3gOK7LLuXBVQLsl0IKIHEmukH4N
         6qTRg5BoSAOnBU95P3ywspR9lWrZaAz3Y6+iJIt1mRAUMIzNfIeQx8MXznT6oos4/X
         qaxx24w4QZqwBnyEe91q1vaat6KgIS734OPMv3BRZUAFggZnS3kykFu3YR4/Hb9fgH
         Sqbcrz9xXgurwNc+6FOvakTd6bY+oTulbIaFy+ByUipD8cuznwr
Date:   Mon, 3 Sep 2018 19:11:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 08/12] commit-graph: convert to using the_hash_algo
Message-ID: <20180903191126.GN432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <20180829005857.980820-9-sandals@crustytoothpaste.net>
 <ef3f5ff2-a774-9e9b-d73a-b21630bede53@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aSnC4ZPPfhCvD8sN"
Content-Disposition: inline
In-Reply-To: <ef3f5ff2-a774-9e9b-d73a-b21630bede53@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aSnC4ZPPfhCvD8sN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 08:41:36AM -0400, Derrick Stolee wrote:
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 6aee861f78..676c1a9ae0 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -333,7 +333,7 @@ test_expect_success 'git commit-graph verify' '
>=20
> =C2=A0NUM_COMMITS=3D9
> =C2=A0NUM_OCTOPUS_EDGES=3D2
> -HASH_LEN=3D20
> +HASH_LEN=3D"$(test_oid rawsz)"
> =C2=A0GRAPH_BYTE_VERSION=3D4
> =C2=A0GRAPH_BYTE_HASH=3D5
> =C2=A0GRAPH_BYTE_CHUNK_COUNT=3D6

I dropped this at the end of my hash-independent fixes series and I
slipped in a use of test_oid_init, which is now required.  Thanks for
the patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aSnC4ZPPfhCvD8sN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluNh14ACgkQv1NdgR9S
9ov+YhAAkIBUk09ak8EjX8xqJdjD8WSovBVXo9oxuSYMQ9GkTkdUVOkwmRmyBX9w
2KToevYHlOXETH1OX72BMl+8rO2g8Hk1oRiRgfX3Jqrj+dUhM4mJItzk2FcZUCxR
ifc80kj6rp59MX/TMdq0wvsWmAnQtY7eN+g2LxMvOFJMnYrbLC6amagR7WrjDhbf
+aKi34RdVyVQ7vKjTJlSeuwP02Q+P53xNMqSjftzEPpg++dLpDOtCkL+IfFctbzu
bENsJrAhHswF78vCsZoW6l/dEvVUjEzvLuN6Zy0ED0b7babHjy/c8xf7xqmOy1ek
H2orHux87sFPLBdjA3P3Zw6bBB0NtOGFBSf1GtEkrwRTp01ckLbHd/7Pwqy7XKhF
kTQkIwHtG93ge4qIj29fbmCyULiFaxoSshKN8rN38zNT2Ifq7hISD0m16Z5KpW3+
Smgubm9YPEWvjf5AhqD7VPzt90j+uZ51X2peYl8+/euUEjA4iVjCcTPw6DHk9OEQ
aIFzMTZd+EdcxLnHZNWRcrOIPdd5JSLEOFQoyfSc0lsdDEkVbFWrr6RfFtJ7vfm2
b/eVFMpap1d3IL8bv9Xv4Zy4bIXW5VlXEDYS8mcfkRZVOmmVA4qkGso3XIMWwPxC
ApfA9iixok/sFCsFDPTaDGtpPjd/s8aH2WpQLoAzd2d5mUsK65E=
=Q5h8
-----END PGP SIGNATURE-----

--aSnC4ZPPfhCvD8sN--
