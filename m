Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC1C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000632251E
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgLXAGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:06:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbgLXAGw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Dec 2020 19:06:52 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 918636076E;
        Thu, 24 Dec 2020 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1608768370;
        bh=SPkSfTKhCvFdkLr5Oln0EUk3V3k9c/JEp9xqcuSGyDs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bV6qvX8RMPkcSzENlKxoL+XhI8h0w0akspKeO8bEI5Y3IK9evGWx0STQ1k4V85tBL
         jn93Su+aHyUlpcAwL1m4MAUw58ZOjy6bBVkzFgP3zz2zsBbAp11a3rGIJCnBPw+iK1
         sVm3aW4fRDT/enG2tNtpE2GDrF038AE013TGYMCkZec1dmIHOM46FOrIkqf10iiKzN
         E8SfkNRqwl27zBnQNV6KuddGOsGIicrH4WJ/YiNsQfHkXZKBn3Wr0OzsDbPW1BHxXM
         MfMuVy/bE+bYZCtPTKsBB69Xre+Yjk1NpezCZAKxmLM9dfXEfmI9lAmlYHQBklNLfy
         vXDPhywIrH94csRC89aCx60lmuqRI7EGATgLQKI0TpmgSr8w54BxEXWvTkVVkdVnYg
         suwyPsSNrr625HxzULS5evsIFRZjHMSduU7FsbxUBC4Y6WWSyxc3bS0npvpZghUqxf
         GpPsFIynoNY/fmBp/cIefQ5a7D6GYSvUommOUvMVtzhsCVTavfh
Date:   Thu, 24 Dec 2020 00:06:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Feature Request (Commit Message editing directly from
 interactive rebase control file)
Message-ID: <X+PbbVNIspvJx/yE@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
References: <CAM0jFOfx+vxvUAqZqnxeOvGmn0F0Q6vyTKWPjtsSh1bmq__SsQ@mail.gmail.com>
 <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bFy3epMSAt21W76Y"
Content-Disposition: inline
In-Reply-To: <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bFy3epMSAt21W76Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-23 at 23:07:43, Mike McLean wrote:
> Indicator that the commit-rename should use the text in the control
> file (rather than the later editor prompt) could either be A) a new
> command (rename-inline, or similar) or B) existing rename command +
> "the text on this line is different from the text on the original
> commit".
>=20
> Obviously this wouldn't support multiline commit messages - those
> would still use the existing workflow, but adding this new feature
> wouldn't impinge upon them, so they've not lost anything.

I know people tend to do this quite frequently, but it's extremely
uncommon for me to write such a message.  I normally write a reasonably
verbose commit message, and in the vast majority of the cases where the
change is so trivial that I write a single-line commit message, I'm on a
project with sign-offs, so this wouldn't work there.

That doesn't mean that this couldn't be useful in some cases, but I
think we're likely to encourage single-line commit messages, which I
don't think we want to do in the general case, or cause user confusion
when their commit message inline is either (a) truncated unexpectedly or
(b) not honored because the message is already multiline.  So I feel
like such a feature is a foot-gun waiting to happen.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bFy3epMSAt21W76Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX+PbbQAKCRB8DEliiIei
gRJkAP4hSDl852xrXnfD6BragWiCprPNYupJkXvbAIX9+GKVhQEA+mSFgEFnxB8B
BdfPU3oYidGAkgLF1Xbqyb5CXSRzOAE=
=lBW6
-----END PGP SIGNATURE-----

--bFy3epMSAt21W76Y--
