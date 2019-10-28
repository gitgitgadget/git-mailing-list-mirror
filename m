Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5491F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 23:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfJ1X7l (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 19:59:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55144 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfJ1X7l (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Oct 2019 19:59:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6E37F60423;
        Mon, 28 Oct 2019 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572307179;
        bh=jwU4DnEVqWWGpR305G1svhdPmjLJlDrpF7gZS6b+CnM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cJ0DXG2yV5V4PBbQ0BKXS5W0Zmjq5o1Y2fQQKXRxtJoWr3k/6UANTTM0jw4Bpox9S
         CYIxCE4C7XrV7mPQ210kuyLAuJQBjbRl5EW25G/6pUVseEmMybx8fy7WgGv+1V8kUu
         q/XRTOgU81Z3jk6n7IEoKO9+NIiaV1vhR/T0j857AFnU3A7RSabJeVXgFCBiCDGBhV
         ouHg/DH2L+fzAFoD8So8YpY9PSYPJ8A/hbTL9dK9wglEfAyjuhrVg+l5XfLW+gYA/p
         cKZjgVLcfoE6gJwrz/ByaHvA93vUfDAc+FV1WGFZONOrUPLNVwahE9SBrHdTl1CQB5
         aMtySL85L1ZWpEQj06/i6PvTKzUGHSmYkrIqwfcgzYkcw4SNutKRss5gx5opGEMsOI
         v02zzP917KZiTHlFWy1aCCLxt16D3szsoKdIQ5wCrW7Zc6WKfbZPnu6dBqXW1qHo9Z
         JVr+aVYptj6qkGTHrXlSnBJ5V5kE/BYq81/9dkqthzFBmuk4U6d
Date:   Mon, 28 Oct 2019 23:59:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/15] t4011: abstract away SHA-1-specific constants
Message-ID: <20191028235935.d7avz3f3hcuown2l@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
 <20191028005907.24985-8-sandals@crustytoothpaste.net>
 <xmqqk18pa88h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pa6puaoqti722ug7"
Content-Disposition: inline
In-Reply-To: <xmqqk18pa88h.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pa6puaoqti722ug7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-28 at 02:56:14, Junio C Hamano wrote:
> > +short_oid () {
> > +	local oid=3D$(git hash-object "$1") &&
> > +	git rev-parse --short "$oid"
> > +}
>=20
> Given that we do not use the former helper to compute a regular
> file object name without having a concrete file on the filesystem,
> I do not mind calling it symlink_oid at all.  But then this may want
> to be called file_oid to make the contrast better, and it would
> match the use of these two in a test near the end of this patch.

Yeah, I can make that change.

> >  test_expect_success 'diff new symlink and file' '
> > -	cat >expected <<-\EOF &&
> > +	symlink=3D$(symlink_oid xyzzy) &&
> > +	cat >expected <<-EOF &&
> >  	diff --git a/frotz b/frotz
> >  	new file mode 120000
> > -	index 0000000..7c465af
> > +	index 0000000..$symlink
>=20
> It is a mistake to name the variable "symlink", even though
> symlink_oid is a good name for this helper function. =20
>=20
> If you were showing a change that updates the symlink RelNotes from
> pointing at Documentation/RelNotes/2.0.0.txt to
> Documentation/RelNotes/2.1.0.txt, for example, you would say
>=20
> 	old=3D$(symlink_oid Documentation/RelNotes/2.0.0.txt) &&
> 	new=3D$(symlink_oid Documentation/RelNotes/2.1.0.txt) &&
> 	cat expect <<-EOF &&
> 	diff --git a/RelNotes b/RelNotes
> 	index $old..$new
> 	...
> 	EOF
>=20
> so I'd expect $new (on the right hand side of ..) would read more
> natural.

Can change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pa6puaoqti722ug7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl23gOcACgkQv1NdgR9S
9ovXzBAAjMR3igogeeai6oyI/qsjIoHPA5b9GL2hWhORWp/Nih/MmZQZDH5pgSIE
Y1jYYAWl83I6HgAg/fyY07ifY6NgfwA+qnFeHir0ksKGtTMkNK38mdS1qZGxJtjL
jgIHdojd0a4uKQTkpWy80Nf52TUNFFoJSqRpgEn5ZvR4EgvMy52sjg6sjW0Ay3n+
Nh7h+MlDVCqdTAr4RhIATs9SWRcDRlNpC0lxK35+9F7Zxiq2sekH/iReZh9X9/Zz
5j2xRTHXKvj9cFlhZZTIfqWbMp7qtH6H47mWjV2YHp2wcyRuWVlh9TJBdFeNbMRF
X5mGVh6ZcTmdeiDfy4gekVHeNaUS4nz7OpVuFhpjfv2XVnQt3lOTpAx8fzFXvzJH
OK/SIRqWTu33F1mHwP+6KW/ovJX2wmNMBNp9iuAdt271LW+84L8BNXkspOfoRjN+
QPwAx5wPP8XFU8aIa6liytPOp6txvREfPL7WRre3KSXbHExUBpPOyit/jlk8Tp8t
6gNG2ao4zFje1P8XP1fdvY0M2EWF2WOJJTI+UvOLzROEJis6ieg0w/4dfEojOsQW
b7jgzPEjgejhFksonblizYxJjrzlTP+YMdCbQPe79GxphOBgax6kK0vDVFrbwJOp
62te+Q78jlGtvaJXIpGxxSX1wnHmm8p9kb3WyFMWAxp1xrTKqfs=
=mBSj
-----END PGP SIGNATURE-----

--pa6puaoqti722ug7--
