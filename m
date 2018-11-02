Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AE11F453
	for <e@80x24.org>; Fri,  2 Nov 2018 01:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeKBK7G (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 06:59:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53020 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbeKBK7G (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 2 Nov 2018 06:59:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:293f:cdba:df65:a13e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F2D4A61B73;
        Fri,  2 Nov 2018 01:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541123621;
        bh=WlWC55MFLOzvBXn5drAmxqtj2mnP8Nu9Y+2EmiGEc/s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qq1jy7cakLQVxyY9LjLMl6hO/UCZUWhCkfksHmw5DcnWCHhfLZlYpTb3V8cBAVqXv
         W4DPAGegMK6cp12OH+9+zEX9XLB5u9WoVGEmojiHY5IkEUna734EpXjdt+okv1StAR
         kXyiBGko2X2L9sRFuVFcpdinQUD7tfU2Rc5kdMCHLrsFiHVEOJoLWqPvnR+drYExvt
         K+r0IKl5A2uVZA0KK53i5wcdoPmSr8fv9gd9qfd5Ixs9AEp7rYUgIQs1F736AOEcDg
         PgvkvDs0Zn2RSKu/sWymdemWbb7nHC90oei7c1kh182LU7weMVyQIZce/7zdUlhB/Y
         Hpx/12b++dwHjbqBMHWue6kQs+kqmmfgL8PZV0CGWhMLFYcDzTzv4S8TV2RZGgKiBf
         ytcddCgD+zIyLxUn3XpdCa2P0vm3/JuOTAJ1S5WnZ8jVRr7q5zsYzsqvZREI1Jru98
         LQ0z8u8GyaWo37RlYmezPoO7t0jRS3TUY+kOUwST+QhdwEkOK/o
Date:   Fri, 2 Nov 2018 01:53:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Aaron Lindsay <aaron@aclindsay.com>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Avoid empty transfer encoding header
Message-ID: <20181102015335.GC731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aaron Lindsay <aaron@aclindsay.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20181102010934.15473-1-aaron@aclindsay.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20181102010934.15473-1-aaron@aclindsay.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 09:09:34PM -0400, Aaron Lindsay wrote:
> Fix a small bug introduced by "7a36987ff (send-email: add an auto option
> for transfer encoding, 2018-07-14)
>=20
> I saw the following message when setting --transfer-encoding for a file
> with the same encoding:
>     $ git send-email --transfer-encoding=3D8bit example.patch
>     Use of uninitialized value $xfer_encoding in concatenation (.) or str=
ing
>     at /usr/lib/git-core/git-send-email line 1744.
>=20
> Signed-off-by: Aaron Lindsay <aaron@aclindsay.com>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2be5dac33..39c15bcc8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1834,7 +1834,7 @@ sub apply_transfer_encoding {
>  	my $from =3D shift;
>  	my $to =3D shift;
> =20
> -	return $message if ($from eq $to and $from ne '7bit');
> +	return ($message, $to) if ($from eq $to and $from ne '7bit');

Thanks, this is obviously correct.

Would you like to squash in the below patch to add a test?

----- >% -----
=46rom 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Fri, 2 Nov 2018 01:51:33 +0000
Subject: [PATCH] squash! send-email: Avoid empty transfer encoding header

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9001-send-email.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1ef1a19003..ee1efcc59d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -492,6 +492,21 @@ do
 			--validate \
 			$patches longline.patch
 	'
+
+done
+
+for enc in 7bit 8bit quoted-printable base64
+do
+	test_expect_success $PREREQ "--transfer-encoding=3D$enc produces correct =
header" '
+		clean_fake_sendmail &&
+		git send-email \
+			--from=3D"Example <nobody@example.com>" \
+			--to=3Dnobody@example.com \
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			--transfer-encoding=3D$enc \
+			$patches &&
+		grep "Content-Transfer-Encoding: $enc" msgtxt1
+	'
 done
=20
 test_expect_success $PREREQ 'Invalid In-Reply-To' '
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvbrh8ACgkQv1NdgR9S
9otAEw//TDa/k5/uStsIHT1hul1SC5ik1L9KG3ROxRCpSOrsGJVAEEzskjlRyWi+
60G4n4q4u/00ocUeupd9umVIDjJt7nP/xHvLABwfJW5hcdOuOo88v4XjC2JqbNgs
zqkwLK6/AZv65uuelh5FMrH5FH0UtVyUfozmke1TC3VtSYShBama9yC3bZM94T/r
gM2EP/hqwaWpv3jluk2Jf47Lv1N9bYZltKJUbldl8SHkKa9KavJqfqGvDu6uot/Y
r7T0vpJStuyQx8mzXblcGD+MN891tHaO24W3EYsuokOJlGuBBRTskX1sukcPxbjP
5Be/XCeUHIixfrpT12OFELWKPcJxZ/kmRgzvfn8427BH7S1tHgpR8CDZCO15YfbY
7i+PNiUmsRGk/YbRnC/hLN23uWkXszviLJ6zi+0CmK0ba0orUEtnqKR8vnzAXHiO
YIusGnqSFX5+GMxZIMjwZbDsYR4doT1n6ag8Xrc790eKeUnZn4jzm/3NuQcZxPVg
aFR2VqVRzvhiaIie8fbTyKS/pQgf9nmUsEVubdvd8Ht1ojSf7cwVmORJMPkX74aJ
dgh6pjDgsKsvEhMGFD0e+JO7CyfIM/i8D3JgFsmSHzMCdzaNdvbuhctb6xUjCsJC
03fiXtg98UfuioqOLdJG0m3Vt1lqR8/VkeJPX6IEKdklNlCgL3Y=
=EW62
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
