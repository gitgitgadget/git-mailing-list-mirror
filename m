Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB78C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EF322DD6
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgLPAvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:51:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33066 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgLPAvM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Dec 2020 19:51:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0FB3060769;
        Wed, 16 Dec 2020 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1608079830;
        bh=vGRFuOm7xgA4PHC9/Bwp+71YncjXKSNqFiDDk9Gs2iQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=P/XXe6nt7cUI9boL+BwtweVMyBIB6w2tMrE4puB3n1E6Fx9xJIkuX74DsU7TcNjcF
         fgL1+gzF1mY0W0ebt5lFyX+B4Pxt16e0LjgQRKJiSfowate7CDwt+L9l0C68V8yDXl
         1zmRZmkwN0CZM67/rVEGN2wpHJjaXWninpNn8cQKrC1K0Cq+o66UpTlqTLjPOFcjiR
         8nGtWdh4hX4VPrqrdftwFYscVMZNbqOi9NdtKfp/FhK+f9X19rcuJYl9hCF4YHDmY1
         ZQ8OZx2MV05AqGjjBh0VIl4/9gSsQSY2u6DPtkdNVDwjZyzenTDKmFf2K7UKHjj/nk
         /PqLzP6bBzelgxR5EOOJJZ46PDZyC6icrFkz3Qs1vzGvHvT6aRaRdiUpTZyTWa5aWW
         lw6fQITKBVSrs6uEa/DnlPev6XZI4TbSv3W+7Df4j7coebcyKX6IZVl6Wvi5swvOHZ
         i0gVXlDA0wh3+wJGIRO+OoVp7TXI0RK9TJ5i3ZJu3KqZQNkHPxl
Date:   Wed, 16 Dec 2020 00:50:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
Message-ID: <X9lZ0ABtWvjS+Zsv@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <20201213010539.544101-2-sandals@crustytoothpaste.net>
 <xmqqv9d4ergd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uEJ5X9jtSgsKcAjP"
Content-Disposition: inline
In-Reply-To: <xmqqv9d4ergd.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uEJ5X9jtSgsKcAjP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-14 at 00:09:19, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Come to think of it, this probably needs documentation as well, so I'll
> > wait for any other feedback and then reroll with that in there.
> > Hopefully that will clear up any potential confusion.
>=20
> Not just "where does the hashed entry can appear in the file", but
> "how exactly does it gets computed" needs to be described.  If it is
> sufficient to do something like
>=20
> 	set x $(echo doe@example.com | sha256sum) &&
> 	echo "@sha256sum:$2"
>=20
> that exact procedure must be described to the users in the
> documentation (note: I know the above is not correct as I looked at
> the tests---it is a demonstration of the need for a procedure using
> commonly available tools).

I believe the difference is that "echo" adds a newline and you probably
wanted "printf" here.  But I get your point: we need documentation to
explain how to do this that's simple and straightforward, and as we've
both pointed out, there isn't any at all.  I'll add some.

> I wonder if somebody may want to do a dedicated tool that lets you
>=20
>  (1) given an e-mail and/or a name, look-up existing entries and
>      show what <name, e-mail> pair it maps to;
>=20
>  (2) take a new <name, e-mail> pair and add mapping from it to some
>      other <name, e-mail> pair.
>=20
>  (3) take an existing mailmap file, and obfuscate all the existing
>      entries.
>=20
> The first one is covered by "check-mailmap", so the other two could
> be new features added to the command to be triggered with a command
> line option.

That could be a useful tool.

> > +	cat >hashed <<-EOF &&
> > +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_=
AUTHOR_EMAIL>
> > +	EOF
> > +	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
>=20
> The two spaces after "check-mailmap" is not significant but drew my
> attention.  Let's not do so.

That wasn't intentional.  Will fix.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--uEJ5X9jtSgsKcAjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9lZzwAKCRB8DEliiIei
gRHVAQDOfjKJE0bh+ZBmrIQTfbz9+86k1dwd9wNSKkpcO8HKGQD/e+sswtAIaPZ1
71IB3287orf2gbGRIsG9hqL5Wq8xLw8=
=k4DU
-----END PGP SIGNATURE-----

--uEJ5X9jtSgsKcAjP--
