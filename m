Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B030ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 13:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIONEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 09:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIONEw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 09:04:52 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68320BF6A
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 06:04:50 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [12.148.187.67])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 207605A26C;
        Thu, 15 Sep 2022 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663247089;
        bh=2Cpy8Il6wEURUS5sHsYGRepSyUH3CJDP7OylmuTeyW8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wOaIWs9LSW/30+Hrkejz2KajlhgY06INdz4EQO5KTyOovuLJcVoy1NBZykx0KpoH7
         FURhu0Wl8wxk578vJmFd8bsKtDpqXaMSOIGXwJE7qErGP4cHyYJgrerKG/aiUDQqIR
         9DeVPDow0YvymiqmNo3v4Xfj6aUC+kPbPHeZ9OmfNCF00mXEayr/nZ0UhkRhYstAaR
         HmG/Oe8J3LlI+1jPDtmcStvsZCla5h3r+yB4lzxrHN0BfvmIn6UXLc90jgIWTNBsWB
         6Fgyob8g9KmTGMTVOpwsDoGe92zMEBTg3xQW87dlEulFo6LJ72Fdf5U3XJcrB5KT+c
         bjMcudtExWrenW1V4M6E2xHTMuKR4oh040wy43zcqVoR0Z9Iu8I+KSX1WGlqtfMciS
         jRpj3Nb5h9mfte7wP2vazyh/wogAhKQmll3pYinUL04XQHhoOYuxEMl8I57k/Wmt6n
         vo5++07PCR3WT75ArEdrvMMEF+FGHabaowpxGAKvYOZ4NjWZoOh
Date:   Thu, 15 Sep 2022 13:04:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brijesh Patel <bridgepatel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: Value for GIT_SSL_NO_VERIFY has no effect
Message-ID: <YyMi76Cy7KnfZFU4@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brijesh Patel <bridgepatel@gmail.com>, git@vger.kernel.org
References: <CACs=J2MLnawNF5mp19sCJAZADPenHjWVZvKW5rM1fwELHjqqyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fCrxXYJgNG/Qnjkg"
Content-Disposition: inline
In-Reply-To: <CACs=J2MLnawNF5mp19sCJAZADPenHjWVZvKW5rM1fwELHjqqyg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fCrxXYJgNG/Qnjkg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-15 at 01:46:50, Brijesh Patel wrote:
> Hi,

Hey,

> It appears that any value assigned to GIT_SSL_NO_VERIFY (true or
> false) has no effect on the GIT operations. For testing purposes, we
> have created a host entry for github.com and mapped it to foo.com.

This is definitely true.  There are several Git environment variables
that act this way, including GIT_CURL_VERBOSE, that check whether the
environment is present or absent, not whether it's set to a particular
value.

I believe this behaviour is by design (although other folks are free to
correct me if they think I'e wrong).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--fCrxXYJgNG/Qnjkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyMi7wAKCRB8DEliiIei
gVllAP4yGhUY9smAenN+rutKH2Te/6cVBuGD1kn5nGDDAEIBzwEAhsc+0Xelthl8
IOBUPhk78QsncOtGYdlVDdsGHQSMBA8=
=xFhO
-----END PGP SIGNATURE-----

--fCrxXYJgNG/Qnjkg--
