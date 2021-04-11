Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A98C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 02:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528BD610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 02:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhDKBzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 21:55:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58858 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234944AbhDKBzE (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 21:55:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6886460422;
        Sun, 11 Apr 2021 01:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618106088;
        bh=HjjIv7C9matHva1/cBtEyY/aac38M9NdwnanhMOcI54=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uD8oLdpSBNWjh6nS6hiKHz1A7XYr7iLh0eVNJbpX/spfEdeiM0NiEMoxYp+rkdqGf
         TQ+0znqyLiOVdqGN+oB3SzqkQQhldPzA3n+fdfXheUajzyIG3COfl2YpCNoTHuacY9
         Vnw0cSHUOp16jaVEPuINrVTz4SnS+4FkUIvjaPK0JrsGkzKnYi6Y+LvusSpqjyPPty
         yiG8HnE5ecctkJA1SJHpkD3cY/oeZyuat4NY5iR0e2NLl+ZcVxT+f310knRfRzQROo
         EvIZfjUzZVsdQzVYbP1v1246B3TKDOToihC+UZNsVTXLKUS0QZjW7I2gyZ79Xfm8Ib
         /WvbAu8yHQ2m5ByJ7RitjNwvto1KeNurKftni8WBCmubYbzLBH2WNwS+TOv7bXCa0v
         /ZOvlJKWTkl9NqGITk/l9Uk8SyyY8VedHzitLM6+0M07yn+/8j22ufgH9gjOdI+iRr
         FOalOhJM6qvHVklFTEQSi5agRpsrg0/cvNXG+Kj+gSssmh6QLo0
Date:   Sun, 11 Apr 2021 01:54:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: question re: git show-ref and matching ref patterns from the
 front
Message-ID: <YHJW4xCgw6GN0Rag@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Chris Jerdonek <chris.jerdonek@gmail.com>, git@vger.kernel.org
References: <CAOTb1wef2w_H4mwMMwR4En8665GduAMoceL45+OYC4DSBPtozQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcgLOYnx5ldRzwtY"
Content-Disposition: inline
In-Reply-To: <CAOTb1wef2w_H4mwMMwR4En8665GduAMoceL45+OYC4DSBPtozQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bcgLOYnx5ldRzwtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 01:24:57, Chris Jerdonek wrote:
> Hi, I noticed that git-show-ref only seems to permit matching patterns
> from the end of a ref name:
> https://git-scm.com/docs/git-show-ref#Documentation/git-show-ref.txt-ltpa=
tterngt82308203
> For example, "git show-ref master" will include both
> "refs/heads/master" and "refs/remotes/origin/master".
>=20
> However, is there a way to limit Git to showing refs starting with a
> prefix, and that doesn't also require Git to iterate over all refs?
>=20
> It seems like that would be natural and useful e.g. for repos with
> many refs and/or repos with namespaces. Am I missing something, or
> would that be a useful addition?

I believe you can do this with git for-each-ref.  It accepts prefixes,
and assuming you don't use a case-insensitive comparison, it will
restrict itself to iterating over only those prefixes you specify, not
all refs.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bcgLOYnx5ldRzwtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHJW4gAKCRB8DEliiIei
gWtBAQClnwVuL26nAdc1CX8JTLZgR4zG0+Qoq/7uhVUDp0w78gEAuK49uU0+n8vk
n7mAnPYW712t1W48kU4vw81gsGCcOgk=
=OXJr
-----END PGP SIGNATURE-----

--bcgLOYnx5ldRzwtY--
