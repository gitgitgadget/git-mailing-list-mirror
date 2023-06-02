Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E929C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjFBTLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjFBTLs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:11:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C18133
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:11:46 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 128145A210;
        Fri,  2 Jun 2023 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1685733105;
        bh=zwpRX3QRhFkenV2/yf87nlupZRyjOuqdnVK29pF1VZ4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LIOwaiquiMqMe1dgUSO07/0DaIZ3+AspRYgkuvSYGgwTZDA8NDaJSX0Zr5ekQbO4k
         Pwa83+InxLK86mEYcgOt9VHS+dzLDfCr7zY9zGYNdmAIT5eESkfMzTpteUorWYTtRv
         m/tPmDg5E/202F7GDANElkIwqOOwY78VthhP0WY/GFKLtkDGU3euSE+REUWBhFuFra
         ojouveKZEWNplLig9q6GffwQK18TOte7M72pNZE5fQv7BX0rxLh0sKpKM+b9062/rO
         DIJBsIhqvjPXiNiwcyvISaZ5shMlFTZSYoTT7p1MIyaHc3rxOiFjfIH258SKc2rP5k
         9HjNPDugLWjsiUDyL9zvG2WYGviv82SlWt+LYnNjOSmD1sH1ObOmXx2o7TqLbLZou7
         O5klxBLR3CTuV0ISMpuTCCJvruGm2oJtMomOjBP+F8s8srjCWMMScArLrAOO1KEFuZ
         AXx9JQ/qhx0g4E/qACCceKl8OIkOecpbjVyLZeY8O/6T/e892S7
Date:   Fri, 2 Jun 2023 19:11:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Shahin Dohan <shahin.dohan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Git bash slow after update
Message-ID: <ZHo+742ova7QTAe1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shahin Dohan <shahin.dohan@gmail.com>, git@vger.kernel.org
References: <CAHsf_F2CgyTWr82htsyg8aiA-WhrKa4zJQUc_wJwF0pfRYR7yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vWuW61ykFNKnEakw"
Content-Disposition: inline
In-Reply-To: <CAHsf_F2CgyTWr82htsyg8aiA-WhrKa4zJQUc_wJwF0pfRYR7yQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vWuW61ykFNKnEakw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-02 at 06:42:01, Shahin Dohan wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> Updated Git to 2.41.0
>=20
> What did you expect to happen? (Expected behavior)
> Same performance in Git bash as before
>=20
> What happened instead? (Actual behavior)
> Every operation is significantly slower. CD is slower, git pull is a
> lot slower, etc...
>=20
> What's different between what you expected and what actually happened?
> Git bash performance is significantly worse

The Git project doesn't distribute any binaries at all.  If you're using
Git for Windows and seeing problems that are in Git Bash and don't
involve Git (e.g., slowness in the shell with cd), then you'll probably
want to report it to https://github.com/git-for-windows/git/issues/
after searching for any existing issues.

I will also mention that you'll also want to indicate in your report to
the Git for Windows project if downgrading again solves the problem
(which you should try) and if you have any sort of non-default
antivirus, firewall, or monitoring software, since those can affect the
performance of programs on Windows.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vWuW61ykFNKnEakw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZHo+7wAKCRB8DEliiIei
gZ2fAQDNCyycg79t3nwR41+92H+yl4P8WcaSugwJrzrIM6WQZwEA5kMg4umTvNwo
XpzE4Ld5asLARq93FBi8s8Q5y6Ifngo=
=rX+w
-----END PGP SIGNATURE-----

--vWuW61ykFNKnEakw--
