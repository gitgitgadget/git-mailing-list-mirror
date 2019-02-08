Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7888A1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBHUm2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:42:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33920 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfBHUm1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 15:42:27 -0500
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DCFDC60737;
        Fri,  8 Feb 2019 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549658544;
        bh=Ub6TMOOy3aKW3x0nfLPWOeSf/vnT87Ky4AiFlVyXzGQ=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=unU2L9C0TlKlekBqU688DffSEoMtxVWvn4aF58zUKE0PvBUL3BqD6frFFoniCbWhl
         7XkCBmAjEALnl1KoH0kwLqDkYjJl27N740cRHEnWgHaLI5YP2LUQK87a+NL+zFMGlI
         cfVxepnJF3hlGdstQciuUpaSH665gKad1EcqP0xAC4jt76/ft1licoUpRk3VXrHDTX
         EF7p74Uz4Eo2Brokk8KTfbaZqO3i8x6BhToRXynvzYAgkXNl0g2L6nQ7OPX+cLSXPW
         qoGBx6UXCk72wZBs9gAsP+woFYq8PMtd/yBf2J083ZICeThZK2TQIOk3voQuN8zUMS
         TuIE6UOpurQXkbSPGWnp+kVYsmxryfVk9esMB6mMbWuqw4CUkDRD/Vg1bphFvKVTNo
         l6z38kiKUbjWtKBrTlXsp/+yXKxZXAN2kicAxvSowgFzfNLgD36y2ttwix1Ezebx/A
         9PIlUOTdctTjokrT+Edr6PKHGBdMJ/F+eTYvK2rDZraRHsDg/N/
Date:   Fri, 8 Feb 2019 20:42:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>, Rich Felker <dalias@libc.org>,
        git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208204219.GF11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Rich Felker <dalias@libc.org>,
        git@vger.kernel.org, larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
 <20190208115511.GA30779@alpha>
 <20190208135137.GE11927@genre.crustytoothpaste.net>
 <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
 <20190208202336.GA5284@alpha>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <20190208202336.GA5284@alpha>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 09:23:36PM +0100, Kevin Daudt wrote:
> Firstly, the tests expect iconv -t UTF-16 to output a BOM, which it
> indeed does not do on Alpine. Secondly, git itself also expects the BOM
> to be present when the encoding is set to UTF-16, otherwise it will
> complain.

Yeah, we definitely want to require a BOM for UTF-16. As previously
mentioned, it isn't safe for us to assume big-endian when it's missing.

> I tried change the test to manually inject a BOM to the file (and
> setting iconv to UTF-16LE / UTF16-BE, which lets the first test go
> through, but test 3 then fails, because git itself output the file
> without BOM, presumably because it's passed through iconv.
>=20
> So I'm not sure if it's a matter of just fixing the tests.

I think something like the following will likely work in this scenario:

------ %< ---------
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Fri, 8 Feb 2019 12:58:11 +0000
Subject: [PATCH] WIP: utf8: handle missing musl UTF-16 BOM

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0028-working-tree-encoding.sh | 20 ++++++++++++++++++--
 utf8.c                           |  4 ++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encodi=
ng.sh
index e58ecbfc44..ff02d03bad 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -6,6 +6,22 @@ test_description=3D'working-tree-encoding conversion via g=
itattributes'
=20
 GIT_TRACE_WORKING_TREE_ENCODING=3D1 && export GIT_TRACE_WORKING_TREE_ENCOD=
ING
=20
+test_lazy_prereq NO_BOM '
+	printf abc | iconv -f UTF-8 -t UTF-16 &&
+	test $(wc -c) =3D 6
+'
+
+write_utf16 () {
+	test_have_prereq NO_BOM && printf '\xfe\xff'
+	iconv -f UTF-8 -t UTF-16
+
+}
+
+write_utf32 () {
+	test_have_prereq NO_BOM && printf '\x00\x00\xfe\xff'
+	iconv -f UTF-8 -t UTF-32
+}
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
=20
@@ -13,8 +29,8 @@ test_expect_success 'setup test files' '
 	echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes &&
 	echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM" >>.gitattri=
butes &&
 	printf "$text" >test.utf8.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
+	printf "$text" | write_utf16 >test.utf16.raw &&
+	printf "$text" | write_utf32 >test.utf32.raw &&
 	printf "\377\376"                         >test.utf16lebom.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
=20
diff --git a/utf8.c b/utf8.c
index 83824dc2f4..4aa69cd65b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -568,6 +568,10 @@ char *reencode_string_len(const char *in, size_t insz,
 		bom_str =3D utf16_be_bom;
 		bom_len =3D sizeof(utf16_be_bom);
 		out_encoding =3D "UTF-16BE";
+	} else if (same_utf_encoding("UTF-16", out_encoding)) {
+		bom_str =3D utf16_le_bom;
+		bom_len =3D sizeof(utf16_le_bom);
+		out_encoding =3D "UTF-16LE";
 	}
=20
 	conv =3D iconv_open(out_encoding, in_encoding);
------ %< ---------

This passes for me on glibc, but only on a little-endian system. If this
works for musl folks, then I'll add a config option for those people who
have UTF-16 without BOM.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxd6asACgkQv1NdgR9S
9osbdBAAmVUYHpP9eqqmTyt2vaOeMKiLROivBbpk1uzgAZkcfsQtW5asoHAFQLCd
80q1xTxoYKaAx7GtrGYaGWQsHghEYF+MMP3Zo3fzk4UtwZU5Je3u4OWPHCCZd82G
qFNtT0W3VisxaDOppmbHj9dK+PCZk4bxDvgcZ66hmiN6rvB7khv+Z8E7asLflZp6
FtjGkr/G8C6VK+Dza0Jw+Z/r2FGAS86juoqRK4Wwzc/AbGusy8pn59jv/WY/4WaI
xZMKfsGbGrIhUrHCPyV5pY7POvpvcJ+7QHCPBCOuf28PxQg6auDs87K9GAzRJbHq
V/b8XUNKwLTNvfGZW9oUVS9cHefaj2XYlsa3HwuQUPrmgU1TRMWwQBK19nt+5sVm
KpKl/MR80uvrFqpiv52cgNmiwuArrsPEUKdAjwZ39cqIT0oohmFhE9JxIAWHQ5Tt
D/cKICnYGZlsrLdlNRqtEZuEDR1EVqp4zpVbWWh80j3zPw1W12T3N2r9zMNsFmTd
ohVl4U4G0IoiR09O1GRDewP0sq0F1rbyxecSSDK8u8cl6IVXUr583I6pkgHUhyLp
3k4Q6bKaLxMdrQ03ZweJ6JyvLh+eLjItI6e4t/46TJ0FuNd4kfdGFCzGLwh3gVdO
h1KLYPaJB34HpcdLFnmRD1464ijuuWZyp7JDhB/2OZ3eGpGMVxI=
=QHZZ
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
