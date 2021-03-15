Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0EFC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D364DF4
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhCOWCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:02:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhCOWCW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 18:02:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B202A60457;
        Mon, 15 Mar 2021 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615845712;
        bh=JYQ/Y808ZMxa0coAqqjsI9xCO/XXmX4DhoGMB9qFPes=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=D06no33zDDJNzv5ag3P+XnaSddO3nAKCdQ7bn9Q4rZQ47TTo5D2ldMUHRclfCkIX4
         H6guGRbhmCdBjB5ITVOSW0GAGlgLK2278rUS0M6XWjv2jROpWbeyPqjsBo8mAy92Aw
         pZKw4aZq9g8XAQmv3nKlTuC1uQ1QOJIqBQNwmS9tvrRqeMYd6VJh9XudcJCBBOpsy0
         2RWYPlIlW5ARyIhx0gu6I8QjUPKmqPwuMG5JFn2lwFu2mUz6gNLQdZ5u2PTRG86o3W
         QqlSwQwDkJ8mk/cthXUmqFn20MHwZfeJ8hGAmxc4DlnoVcXgq03knpKf0INd83+ptY
         9JAAWpuaGUpHvIiPpLj+mfViI6T3lSFoI/Rh1hnjwUj8FTgd9aDi/zxtF94Sj52RnG
         Tn0ThN5Uz+74Wly0ASfCQWCo+L8LYOjw7ZjP9SVN0734VBs/siCU5Hp35xKEvbB/Zn
         87ONTs2ApkhaJu84iJeqFzkc0XV8Q2erkvXMK3rVxOugYS2fq5Q
Date:   Mon, 15 Mar 2021 22:01:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z2A+DGitgfCw/3dt"
Content-Disposition: inline
In-Reply-To: <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--z2A+DGitgfCw/3dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-15 at 18:14:31, Drew DeVault wrote:
> On Mon Mar 15, 2021 at 1:56 PM EDT, Jonathan Nieder wrote:
> > The missing piece is an HTTP header to unambiguously mark that URL as
> > being usable by Git. I'm not aware of a standard way to do that; e.g.
> > golang's "go get" tool[*] uses a custom 'meta name=3D"go-import"' HTML
> > element.
>=20
> I don't agree that this is the case. It would be much better to be able
> to identify a URL as being useful for git without having to perform a
> network request to find out.

But you can't find whether a URL is useful for a particular purpose in
general.  For example, if I see an HTTPS URL, that tells me nothing
about the resources that one might find at that URL.

One might find:

* A plain dumb Git remote.
* A plain smart Git remote.
* A smart Git remote and Git LFS support.
* A human-readable text response.
* A machine-readable JSON response.
* A binary document which is intended to be human intelligible.
* Something else.
* Nothing at all.

In addition, it's possible that the data you want exists, but is not
suitable for you in whatever way (not in a language you understand, in
an unsuitable format, is illegal or offensive, etc.), or you are not
authorized to access it.  You can't know any of this without making some
sort of request.

All a URL can tell you is literally where a resource is located.  Even
if we saw a URL that used the hypothetical https+git as the scheme, we
couldn't determine whether we could access the data, whether the data
even still exists, or, even if we knew all of those things, whether it
was using the smart or dumb protocol, without making a request.

So I don't think this is a thing we can do, simply because in general
URLs aren't suitable for sharing this kind of information.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--z2A+DGitgfCw/3dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYE/ZSQAKCRB8DEliiIei
gZ0uAQDxAAeIXMNJfRy6q76CpcyUHkHs4/CDBvccP8gyBgRs1QEAymbq71nRODey
+8iUz+cpfK9Qys50DkYMoq+kgpt8RAA=
=8AjO
-----END PGP SIGNATURE-----

--z2A+DGitgfCw/3dt--
