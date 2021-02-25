Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF3BC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D54664ECF
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhBYCmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:42:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57196 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhBYCmQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Feb 2021 21:42:16 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E18A60DF4;
        Thu, 25 Feb 2021 02:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614220865;
        bh=d4aymB1rOQ6JiBMwn/HkHUpqnuakD2S6gVdUey97TS4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=adiyJkTiV2LXUkc4RNoaaX674ttV511vFX3YXtZD20EdcM6FLfbqN1nO1lZJS7o0h
         UzeUsrNxpWB04w/zHNmjT2Tves+27TXIU27jJCoarhLFH2H/fANWU4QDHfPyBk5H0a
         WflLoX1ZfrFlX2R08hW8xT0qUQTA1bmwuGRPLnEJohcZyAubfTTQXF66x/c7IluYVo
         JJooCln5QU2WBms7oi007oTeRU+bMtGsVA2fWqQfBSYqIQfXYL+02RFUyVXJ42UOfS
         DvTEtYKG3ofzMYeFvZTENyXJaTaJUrYXs/xtNHpi9R1ON5XtHamivpy9VzhwTQMnA/
         kSxBsHyFSTXlkxk8MZXPjaJ+KJ8xN8nroHUohaISj38zzlqYZTLxwRVxipTg5GEriD
         i9d+RVhjIuKpYnbj/Y3c+QbIoTjieqKLDtyFzXQn+vUC6+4PBN55wVgODGV5WpbGhp
         /dfGT/mO2kJFYHQJWz8mJl+wuO7qkkGca1OnoCU30XHZ/efB6E2
Date:   Thu, 25 Feb 2021 02:40:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: Getting an actuallt useful merge base?
Message-ID: <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        git@vger.kernel.org
References: <20210224175834.GT6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uRQCTl9f/KvXewMg"
Content-Disposition: inline
In-Reply-To: <20210224175834.GT6564@kitsune.suse.cz>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uRQCTl9f/KvXewMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-24 at 17:58:34, Michal Such=C3=A1nek wrote:
> Hello,
>=20
> I find the results of git merge-base A B quite useless.
>=20
> Suppose you have a repository with file sets
>=20
> S and T
>=20
> where S are sources which are developed in mainline and number of stable
> versions, and feature branches, and T are build tools (such as autoconf
> tests or whatever) that are largely independent of the source version.
>=20
> Because of the independence of T from S T are developed in a separate
> branch t which is merged into all branches developing S as needed.
>=20
> Fixes to S may affect more than one version, and depending on the
> situation it might be useful to apply fixes to S to mutiple
> stable/feature branche at once. For that one would need a merge base of
> the branches in question.
>=20
> However, merge-base almost always give a commit on branch t which is the
> merge base of files in set T and does not contain files in set S at all.
> In other words it is merge base only for files from set T and not set S.
> Can I get merge base that is merge base for all files that have common
> history between two branches?

The merge base is determined by the history.  In your case, I imagine
you have a history like this:

 A -- B -- C -- D -- E -- F -- G (S)
        _/        _/        _/
 H -- I -- J -- K -- L -- M -- N (T)

Here, the merge base of N and G is M, and the merge base of F and M is
K.  Those are the most recent common ancestors, which are typically
chosen as the merge base.

In your case, you probably want to cherry-pick a commit, or maybe rebase
a small set of commits onto another set.  That would probably work
better than trying to merge.  It's possible that there's something about
this case that I'm missing where it wouldn't work properly, but it's
definitely the approach I would try.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--uRQCTl9f/KvXewMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDcOOwAKCRB8DEliiIei
gZk8AQDyP3t0s+Om+54FuuUHQJ9YgSvD5wnQWGX9wg1wj/8d3AEA+VPmt4/61d01
V+VphAniT6UhPrvOKRku5A435U0DkQo=
=UYIF
-----END PGP SIGNATURE-----

--uRQCTl9f/KvXewMg--
