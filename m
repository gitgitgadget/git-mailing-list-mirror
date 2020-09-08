Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F89AC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60287215A4
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgIHBSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:18:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728056AbgIHBSd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Sep 2020 21:18:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7C31160457;
        Tue,  8 Sep 2020 01:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599527881;
        bh=jCcw1PdFVYNFlQUkISFx0dfkR/I0gyeLqj2TZwd/gXE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KzED7p+h3uIJcwFr5domkM5tTOfS0Fb3CLNYg3Nvx2i9YdKA89oI/jA5tna9P+cMz
         FHBAK4JjtvjnN95kz7YI2/pdmX8Ho1AAg0hE5waYVNVZ90pAAJs+BvCEuBwUvGyRnd
         6DkWOAP6UJjlCgduQqW5S6Bljj6hvU2UqaW0dIjE5G59b1KWigo9k8ICMLJBx07Glx
         LuG2pc8P3as9DpY0QRWm0S58omcg3MkdmZZOLNez39hbIZQZjzUjpqhnakxAHcmKhn
         Akhku8XucIjLIycnTgCweI+ECIBefRTystkGUxV/iVokyZAA738lFU3e9eARvY3gvy
         zG+Kr5mmUcZ7KVwvwtd/Nmc9Qv/sPVPCTgBGU4cNExQUTH8718XfeNXG63Xf0foEM3
         OJXnfyLWDo8hGIIcAOeGLV4xRo94Dax/vJ9FuxzxUN4m7WZVphQvPf7AbUFw+/ilRC
         QzPXZkKaXntzxqVQgHuyAFBrkL97joIZXuLktanmWPQneRxLOhV
Date:   Tue, 8 Sep 2020 01:17:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patrick Fong <patrickf3139@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
Message-ID: <20200908011756.GG241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-08 at 00:28:57, Patrick Fong wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> touch "this is escaped"
> touch "this is not escaped"
> git add "this is escaped"
> git status --short
>=20
> What did you expect to happen? (Expected behavior)
> I expected that git status --short would string escape both "this is
> escaped" and "this is not escaped" since they both contain spaces that
> need escaping.
>=20
> What happened instead? (Actual behavior)
> git status did not string escape "this is not escaped" but it does if
> you add it to the index.
>=20
> What's different between what you expected and what actually happened?
>=20
> Anything else you want to add:
> Once you add "this is not escaped", git status will output it with
> quotes. git status --short seems to change its behavior of escaping
> based on whether the path is tracked or untracked.

git-status(1) says:

  If a filename contains whitespace or other nonprintable characters,
  that field will be quoted in the manner of a C string literal:
  surrounded by ASCII double quote (34) characters, and with interior
  special characters backslash-escaped.

Note that that differs from the standard behavior of not handling
spaces, which I expect is due to the need to handle renames
unambiguously.  We have some special handling in wt_shortstatus_status,
but not in wt_shortstatus_other.

Patch incoming once the testsuite finishes running on this commit.
--=20
brian m. carlson: Houston, Texas, US

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1bbxAAKCRB8DEliiIei
gecEAP4xBCMymGegTeeWAquuSjL1MLhpxPDn0ENWbXuUkhLVHQD/USi8HQ04ab0S
DX1/tw1DVlDrEjigpC7ydrhSEXj6zgc=
=feQR
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
