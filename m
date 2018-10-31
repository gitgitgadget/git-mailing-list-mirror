Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A741F453
	for <e@80x24.org>; Wed, 31 Oct 2018 22:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeKAHzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 03:55:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52890 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbeKAHzf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Nov 2018 03:55:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:293f:cdba:df65:a13e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E4FD761B73;
        Wed, 31 Oct 2018 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541026526;
        bh=vdeJtK3QJ9O/WoY1D6Vyhz9vdnimk/jTKSrO0HD4MGE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Xtgg6zX3UWnUeUw4h1SOmWsV4vZQMuKvdrZYZRduiIHOVks6DI4cA1TZv3x599j3+
         52X66bdsF6eMEYGX0igztZleHTGaShYCswdBAnxGekFhPOfH2E7eeDIDudM0dKKO52
         pJJR2T9Hn50U8e3B+1EHP5mlZgySN10txI+yKsIrYaCWrXnWRbMwi+UV//oE/EmJsL
         1+ar9ZoCduLLT5W+U7Kr+MvwcZzfwVsrkIxv/WTS3KSGqdD7by63yEqvPykblwQ6JX
         Bt/OIgE3/iaCKOLxuMrVW3lah8BhkNbjuKFUhNP2zin3zRoSQCgFFTSgWyTSYJRxM4
         nHiQSYfZx27ynwAxq3APjUcMA4i7OIVpHoOLXBKNKwyCRQaR9et9FlVic0GNlrYuMN
         m+kKgSfBa4gtlDfu51VVJPf6c/dQCoysiZMAw7ILlhNfURwYrDm7/JwSg+fbmLXiAJ
         uw3CC7ogaZgix8a2RCgr337MGRp1V2hQOloAwFTNhsKyilMElbF
Date:   Wed, 31 Oct 2018 22:55:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 10/12] Add a base implementation of SHA-256 support
Message-ID: <20181031225521.GA573515@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        szeder.dev@gmail.com
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181025024005.154208-11-sandals@crustytoothpaste.net>
 <CAPUEspjCjFiwCO8TCM23f2jqFSpy2z05+Ea_zGATy0jh1L83iQ@mail.gmail.com>
 <20181028155206.GI6119@genre.crustytoothpaste.net>
 <xmqqftwpa8my.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <xmqqftwpa8my.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 09:39:33AM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > This may not strictly be needed, but removing it makes the header no
> > longer self-contained, which blows up my (and others') in-editor
> > linting.
>=20
> That sounds like bending backwards to please tools, though.  Can't
> these in-editor linting learn the local rules of the codebase they
> are asked to operate on?

Doing so involves writing (in my case) Vim code to configure settings
for this repo.

Since language linting tools invoke compilers and other language
runtimes, you need to specify command-line arguments to those tools, and
in general, that's not a safe thing you can read from the repository
configuration, since just viewing files should not be able to execute
arbitrary code[0].  Languages such as Perl which can execute arbitrary
code with compile checks have to be enabled explicitly with ALE (which
is what I'm using).

I need to do a reroll to address some other issues people brought up, so
I can remove this line.

[0] Pass "-o .bashrc" to the preprocessor, for example.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvaMtgACgkQv1NdgR9S
9os8lRAA0fU2H0fy284SUl2ds/8pK1dzvcgBS8LMqms1owLfGMxMLoODtKL07Li6
iKs2Zhhkoqv7Fl2JIkGcbP6dK+aQQtUN9RuCa61NxZDU8SlzhZO7AKiHoV0kCk8Q
sUlX536L4/oZ2K6fuowHekKhd00GcgchVp3V2iMbBo5t2+3B5fPpng5oSnFoeh1T
b7arVarYApWLSefUEjaq0P/dBBUPgjLHKr73NetJPJ0qbCp7f26v2cq5wCRZi+9y
VQgclLJPtopjWJT50c8Y8hoUndCJu6ziHUGydc7rB2Ngjw25kiRNwAy0U2FlxylM
4tv3RV2GOf08rCsBhm8KOOJNfSdyDAJDNPsGIFcUVNLr0NNZ5qHxcIi1Kx8mr4dU
nWRfHHpfsAAc5VdBhKbI92gV5EQHbK4SKRUSO6Olm9JBpxjmAKSEPBHwz57EsZXe
yMs8JohNy5Jlp6nqCSscUu46UUjN6dp7qt9AOMcP62WVXfoEt788z7/5N10BkAOv
q47wZtiOBXmrOSSp9NLVcjbqUJNoLlAjkAmIFy6nldLtUaPJSxguaYvKo0kzQjEk
+l+nD+EFwpyAZAE9iX7/MbtPjRCalK7+2MouIRdiMZGWnc4x1Cy7e8/aiAMqwTdc
gXRnx3uGeHIBAJYLYoVUcSmD64qwNxYyiURELlarZ0ir8C0JCuw=
=Ud5Y
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
