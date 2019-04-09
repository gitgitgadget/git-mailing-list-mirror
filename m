Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31CF20248
	for <e@80x24.org>; Tue,  9 Apr 2019 22:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDIWzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 18:55:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35420 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbfDIWzl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Apr 2019 18:55:41 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 744C960458;
        Tue,  9 Apr 2019 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1554850537;
        bh=+a/9mlK92ZZbHO8FlZnZ0g8aydxMKVxXw78ZWpg2+pE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xxpM1bCkUxaCz4QQDK5FG8Bqz0SFdaoAIBK5cjP4D8mkR+oqyFrq8VjvcHmmdLUze
         dugtdXmIpLOUZUs6tdBXQ39/vjcDukKk8MreMYCXpqIl4b4tirDbKzJxypfYSFx/Lx
         e88Ereo0fDYHQtEmxTDyK+M4Mgnh6oB5eiDKHSdOUhQ7iwoICSXulx6P6kdPFSzRaS
         wRBtYpryx8cCAFSozEUAMiDYBCVTauCEn3XEQPOhTiUig/LjQDlx5aEqdhegnkZJrN
         /c0NgSiv1AfNyieD132kTVvtlK56P9GHkS7WFxhgQUyTubIZOBq6xN2juiQ/18XAjn
         wK52CLOjrfrSd6MFnYIVwh2Oltj68cWVKsR8YzYjswx2C7muS7K7T9gQTAwmHdgT4D
         oMbGC6+kN+7F/nhCWTiyn4af+7g3ByVoXCgW0dUPNG/+UF45Rr7crEIbwe7D5ALzYr
         k+mDRQDYxeam3FZJVM0nL9OzGjnLQvZMp2LcJVBEXPe9oy2QTxK
Date:   Tue, 9 Apr 2019 22:55:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
Message-ID: <20190409225531.GI12419@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IoFIGPN1N3g1Ryqz"
Content-Disposition: inline
In-Reply-To: <20190409192733.10173-1-xypron.glpk@gmx.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IoFIGPN1N3g1Ryqz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 09:27:33PM +0200, Heinrich Schuchardt wrote:
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index 1afe9fc858..884e776add 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -146,7 +146,7 @@ Note that no attempts whatsoever are made to validate=
 the encoding.
>  	even more opaque.  auto will use 8bit when possible, and quoted-printab=
le
>  	otherwise.
>  +
> -Default is the value of the `sendemail.transferEncoding` configuration
> +Default is the value of the `sendemail.transferencoding` configuration
>  value; if that is unspecified, default to `auto`.

In Git, two-part config settings are case-insensitive. We traditionally
write them in lower camel case because it's easier for people to read.
Git will canonicalize the values when "git config" runs.

So I don't think we should change this.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8200d58cdc..0e23193939 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -239,7 +239,7 @@ sub do_edit {
>  my (@suppress_cc);
>  my ($auto_8bit_encoding);
>  my ($compose_encoding);
> -my $target_xfer_encoding =3D 'auto';
> +my ($target_xfer_encoding);
>=20
>  my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
>=20
> @@ -446,6 +446,8 @@ sub read_config {
>  			$smtp_encryption =3D 'ssl';
>  		}
>  	}
> +
> +	$target_xfer_encoding =3D 'auto' unless (defined $target_xfer_encoding);
>  }
>=20
>  # read configuration from [sendemail "$identity"], fall back on [sendema=
il]

Thanks for fixing this. I didn't realize that we only set values if the
variable holding them is undef. Would you mind adding a test for this
case so we won't regress it in the future?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IoFIGPN1N3g1Ryqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlytIuMACgkQv1NdgR9S
9ouhkhAAz0eZO9zEmNG165vodoqpyPCMW9BmouXvhngUhcvYBJQB/uHNzu5Pb8Rv
rCdf1pMAbisa1NT1hhIq+gK3KMDNF2H6kb2He+0UihXgm6BxYAZ4I4Y82MidPph0
xuPOLrfEm9KfoTGqslFNH9QinDDq4WVUhCAA35lo+J6eMchCRsOrm397o/W0cxZy
uN26TcJQMuClCY7Lxm5+A7TKaPp3o5UaCFmxQKD7HbhidKe0hOz9EhjSx/ge5MxR
rTl52h67cnmgFrlfudPeQzyPgW75mmAFj6LVhA+/BKTXRnPCO+qHTpoUgVHNTRe0
zbWp6GX1ekc3+BRAhjmrAG+O1A088XM5T3/Xq1KTF61/8MKlJ1EUPzQOAMokrUKx
NHUV7bgXTq2KTF4VtCE9Er+554C+exzCDl1ct8/MvjuQ8hxzZLIIXWBBM48WZG6D
yN50c/vQTndpi1r+Jya9kHIikjLHqwzyeoc5bTSf9iFF69cOo3l8giW92jzslLrj
LcitPaaLpD6pDB9QkAjC8YHsxlXXDqOmd8yId66/UoBBudr7M4k5d3zDdAovEC6/
grR4PJz/I7fhwWO/rPbJ45FI4EY6D8fGH+pY9uyQBqKk7bhKImdd29rS4jSyI2cq
sKwOoMkIMlem5W0rGGN+7x/12UL/yVueQ2Y64iFS9QRID8G272c=
=bhQy
-----END PGP SIGNATURE-----

--IoFIGPN1N3g1Ryqz--
