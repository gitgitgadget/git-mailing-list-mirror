Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8149C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 01:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeBFB4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 20:56:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58724 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752401AbeBFB4D (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 20:56:03 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E178B6042C;
        Tue,  6 Feb 2018 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517882162;
        bh=wDGLhJw74gZSt+KRc0AUaPTuR9hBzjURYVlfZU3Oruk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=glZH7v/3i8DsbDl7gA1ECdUeKpal23+P6VqKCmQUEth1IV8fqGrD9hxVDYsP89i2e
         zxpwclX23a4gHwayhh7agLtUl0jYvq3lubZBSmbKvd7eGKoInB+RyNS0Sa9b4zRTlA
         jR+lBOywbJEewVHSf1XCHrwRdZtmaz/a9gJRvDubWmyYDNMrVoHlY2MoJoxxV1WWvG
         rDhnHEBa45KK3+6LAXmqeOohUA0eHQ6fjEu8JmvqR95sxT1wxh4tO8SlJhFpDibxKG
         JAxibSTjDoZojhM0HXDAbs3tSCAri1a23G6R5KXfeG17PUsRup/90eUSZoJ25cOnrE
         R3zEwdLxgU0M5k/9GayqWUb7VCTMuR+WX8nzOjERHShz6cDIilGZKicEB3NDt2wMv4
         8OdOMwgExRjTdcFJ9iBKcr27AVl62a8XLCGWMqU7JrLtFMpYMtXmHCm1eGSbzaU++W
         pbq77Nq7lMyUXJ9RHqIrMjXRJJIc0X0mhmxIeYs20eaFR4VXOL+
Date:   Tue, 6 Feb 2018 01:55:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 065/194] object-store: add repository argument to
 sha1_object_info
Message-ID: <20180206015556.GF7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-45-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <20180205235735.216710-45-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 03:55:26PM -0800, Stefan Beller wrote:
> Add a repository argument to allow the callers of sha1_object_info
> to be more specific about which repository to handle. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>=20
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>=20
> In the expanded macro the identifier `the_repository` is not actually use=
d,
> so the compiler does not catch if the repository.h header is not included
> at the call site. call sites needing that #include were identified by

"Call sites" (capital at the beginning of the sentence).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp5CywACgkQv1NdgR9S
9ouDkg/+MfPIm/lY102BK3+lH0BuZ05qWo5ZnBDHYt2Cbqhkltv0srM7psZy+esN
YQX01lExeedh1oqGhe2abHqJnoaRq4xcEUo1rrTUIGUWqEtQP9vb1rqVc6xE1jg7
qVhUB/2zO9c4mZ84aXgMHRnQ9NELpB0Z5TzjBm+coty0iFJrCoPldXw0hQJ7R5/V
sN+eupD9JcI0+gW+hIX/095c2KvttLIcCs2ATdEwZHq5A5hX2+yu7jcYGrstDiy9
7w4yE+DG0RKjoihMv6SBuB/FGWKwrKIrDrpIYMqV1eSF9BHUmoySaSgFQN8CdxQc
cZORkrhGR8fkzkMh8c/cjWt4GjlW8C3owDYqQ3Q3RMvrttXraU7P22eLSnTdUDoK
RvRvSrVhljl7/WRc6+420Z3BHZvwaIfCuDCKGYO/7m2comVrcpf3vh69bLih+gPX
Tlln8xpXx9sjtNwt4DHJXdJevgNTl7gV0yB725hVPJ0KkjD8B1kVAWSeUeOxighR
wvU3w6CwTmoqXnxJqBs0p7ybKzFI6KtFuaz4JNFoV7M3F0ooMAh2xcme0bNNDM6T
EwiOSl2paKPhOxYx2+UU7UIbdq3ZZ9+bgCUCXsD4/vm4OX7Yu/OqecqpFasz2XaY
lMg4c0Garunn37A7W145m7d6O0Gwt++1ET/C5DBfuyFjHksIQ70=
=uUom
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
