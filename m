Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06961F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfJaUCV (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:02:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbfJaUCU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Oct 2019 16:02:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EFBF76052F;
        Thu, 31 Oct 2019 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572552139;
        bh=9CC8h+azO/qQXUMhOX1gUSuzroLWQc/qL2LCzm/OqXw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tPDzeRfksgHOooOh51FMJvxXoWTB8VLzt6oGTYXDUOCquG2KW7qFQoKvKdisrFOjX
         pz6OYG4XbkBFA33jqSCDGlVSI9U7JOK3QdevRv7P7qJiH8iHnfmKa6zNvqFl4+VBF8
         AJXsvW3FEZXSwRUOjOqhePdDY7COiJK0+iEqSMNwHVZ1wIs0pQTeZD75gGLR9Mhxrk
         bI/68wafqeZnOvAmCRednAx31wBwrTL9ZYoOODS5Tx4btAM10FKhvGP6J9gH/vYHx+
         RO7kM4a5Zm2N4JCNR3v2lPL6ZqlnFJIIGbedqu+31BT3SeXtTsL1pE0PYdoJgn5LMM
         HDtqmk0u/F8Hv9ZfobD9TXf4sjfgE/5Q5kSme+RHQkQxl5al/JWiMcHqE373p0t2CG
         wpRH53HXoCzp+7u16sxFY+yn6Tk2+/0O1oaO+zFoLWq1dZ88BRORtBlMMEJ+xAwQhS
         A/3zbtbXHz5kD2LAv0+uEmedCFBbbaIvf+Ho2B4SB9rDGtpyWL2
Date:   Thu, 31 Oct 2019 20:02:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Message-ID: <20191031200214.h63elcyhzknd65hs@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-3-congdanhqx@gmail.com>
 <20191031181116.GC2133@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vsgghxjq357edf7u"
Content-Disposition: inline
In-Reply-To: <20191031181116.GC2133@sigill.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vsgghxjq357edf7u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-31 at 18:11:16, Jeff King wrote:
> On Thu, Oct 31, 2019 at 04:26:17PM +0700, Doan Tran Cong Danh wrote:
> > diff --git a/configure.ac b/configure.ac
> > index a43b476402..790b53bbdc 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -690,6 +690,28 @@ fi
> > =20
> >  fi
> > =20
> > +#
> > +# Define ICONV_OMITS_BOM if you are on a system which
> > +# iconv omits bom for utf-{16,32}
> > +if test -z "$NO_ICONV"; then
> > +AC_CACHE_CHECK([whether iconv omits bom for utf-16 and utf-32],
> > + [ac_cv_iconv_omits_bom],
> > +[
> > +if test "x$cross_compiling" =3D xyes; then
> > +	AC_MSG_FAILURE([please provide ac_cv_iconv_omits_bom])
> > +elif test `printf a | iconv -f utf-8 -t utf-16 | wc -c` =3D 2; then
>=20
> The ICONV_OMITS_BOM flag is about the libc iconv that Git will be linked
> against. But this is checking the iconv tool. For a system that is using
> musl across the board, that would work. But it might not always be the
> case (in particular, I don't know if people statically link some
> binaries against musl; certainly I've seen people do it with dietlibc).

Yeah, I think we need to do that, and not only for musl.  There are
folks for whom the iconv in libc is missing or inadequate and they use
an additional iconv(3) implementation which may not be the same as
iconv(1) (or vice versa).

Granted, as far as we know this option is only needed for musl, but that
doesn't mean there aren't other environments where this is a problem,
only that we don't yet know about them.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vsgghxjq357edf7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl27PcYACgkQv1NdgR9S
9otvaQ/+N8WrKyI4s7t7zU0jK2DQbSFGOAO25XNAFzAYOeZ8r2s5tZ2uen55DYyN
FBcBS1FqXIweGer0wQ3jNW7EuW9gXJ8X5YRiLKVKSbo/bClywMBU4FB76+cjeIur
8B4f8NgKko9KBE5Ksb/ojIaPbVmsTBwJjcPAFkTP6lAIwtk72CBt/G7F3UuFRrEc
bfFHu27LIZN3rxXwWk4LmNU1TMEjSL/VMtlhBuavz99Xl8rUCoFsfLOin1OYj892
7woHU+lEDWJ5998OkHZZUF/diVR0WoXV+6q0hz9znmbfIbI7GOnFwQaqeDN1Sq1i
/tp0pw4Lsyx74+o9hC7ZMteZlZY6ODoe403IzNLj+pzqZkuDOl8ffC2m52iSNLMI
x23CqbOe//1wuP2oJL8yptPOuK7wrwrMDZJSmVuruWpWRSmt0JfSQ58Q6h16vBcw
Vf3TfA4c/IhsKyxWnTodYRwVUcDV7S+eAyQGKpR4fSLj/T/U5whCtfzpNJL+lcoa
5HaeIf3M9HcMxlxupFcNxXMHu4rxjTaJWcg/Lo/yl8XNShkQSt91qLKijJA/zYDg
/qi8ABkYApbK1aTTWwMowBfs5MNXjK7ODs1B3UkTCFcvwTXIH37nxJ8M2XIo4heG
H2/Fay/jKF3K+4vQRrynXe4eeZkCBwGhTWa4zcJ/7IyxJGmCDSk=
=qNbc
-----END PGP SIGNATURE-----

--vsgghxjq357edf7u--
