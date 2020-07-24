Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D821DC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 21:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99724206F0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 21:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LDe3++HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXVJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:09:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40608 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbgGXVJs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Jul 2020 17:09:48 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ED41A60479;
        Fri, 24 Jul 2020 21:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595624987;
        bh=0FefEIyQwynoTmmnmCDoszlEvz3kiuQasXxjsuJwBl8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LDe3++HCK0NWvj662MR/4AtOPU8//B/GgZGb4tsUd5T08awe8GGfnP8LSncHMnEoU
         +1fyVWgXs5yGA1PSg7oMaTE2v8PcDF4tgbUjsHAlja960VftC+xNeTU0zDAFAdCK8a
         CH7KV3PNyAfgysQmj9+ShOdZT3pQcDaOZWzYELaAHYnGjws8qvyjyPhpYrYpX7uK5+
         30Rm/La5u5T4CsByDtqUPkcFsFZYapjGizt3IlqZMq5Qo8wPDSx5BMCeQTqchJbPOj
         KaOg96dY3HBQNvVvt7KXovazOVZr5QtmA29nZ/M6X4EjQvQzTQz2+E2FAN+exbPYIK
         ot2U7sWnWDXgiaeq5D+PWazK2/olitxHgx4pvFlJtJNHkmCiT8OINiyLGc3w2okODk
         GzthlglYcaNuxgwnam+tmEGyN3XyxYDM6qSp+S/+SUAs+91v1ZuMlNy8vH4iVJ5+fi
         B2Wtb7BtjwaLrOic11gsl0ZwwmpXA5C5/Wahih3JaYBm0CgJWff
Date:   Fri, 24 Jul 2020 21:09:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Casey Meijer <cmeijer@strongestfamilies.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
Message-ID: <20200724210940.GE1758454@crustytoothpaste.net>
References: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
 <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
 <20200724011944.GD1758454@crustytoothpaste.net>
 <EE35569F-6029-4659-86B3-29FBAAD7C491@strongestfamilies.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <EE35569F-6029-4659-86B3-29FBAAD7C491@strongestfamilies.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-24 at 18:14:03, Casey Meijer wrote:
> I think I misunderstood your claim actually Brian.   What is a bug is
> asking for worktree A's head and getting the main worktree's head. A
> super dangerous bug.
>=20
> I certainly disagree with your assertion that asking for head and not
> getting HEAD (or HeaD or hEAd) on a case-insensitive storage engine
> isn't a bug and it certainly shouldn't be a bug once extensible
> storage engines are in place: the storage engine should have final say
> on how objects are stored and retrieved, not git-core.

If you want to refer to HEAD, writing it "head" is always wrong.  "head"
is not a special ref to Git, and on a case-sensitive system, I am fully
entitled to create a branch, tag, or other ref with that name that is
independent from HEAD.

It's wrong because regardless of operating system, you don't
intrinsically know whether the repository is case sensitive.  Windows 10
permits case-sensitive directories and macOS has case-sensitive file
systems, so you cannot assume that "head" and "HEAD" are the same
without knowing the setting of "core.ignorecase" and the properties of
the file system.

So when you write "head", you are not asking for HEAD in any worktree or
repository at all.

We are fully aware that Git cannot consistently store refs differing in
case on case-insensitive file systems, and we agree that's a bug.
Reftable will fix that, and as I mentioned, it is being worked on.  It
is not, however, a deficiency that refs are intrinsically case
sensitive, and let me explain why.

First, Git does not require that refs are in any particular encoding.
Specifically, they need not be in Unicode or UTF-8.  It is valid to have
many characters in a ref name, including 0xff.  That means any type of
case folding is not possible, since a ref need not correspond to actual
text.

Second, even if we did require them to be UTF-8, it is impossible to
consistently fold case in a way that works for all locales.  Turkish and
other Turkic languages have a dotted I and a dotless I[0].  The ASCII
uppercase I would fold to a dotless lowercase I for Turkish and to the
ASCII (dotted) lowercase I for English.  Similarly, the ASCII lowercase
I is dotted, and folds to a dotted uppercase I in Turkish and an ASCII
(dotless) uppercase I in English.

It is literally not possible to correctly perform case-folding in a
locale-independent way.  Every attempt to do so will get at least this
case wrong (not to mention other cases that occur), and Turkic languages
are spoken by 200 million people, so ignoring their needs is not only
harmful, but also impacts a massive number of people.  That major OS
designers have made this mistake doesn't mean that we should as well.

We wouldn't perform ASCII-only case folding for all of the reasons
mentioned above and because it's Anglocentric.  As someone who speaks
both Spanish and French, I would find that unsuitable and the results
bizarre.

So I understand that you may expect that on Windows or macOS that you
can write "head" and get HEAD and be surprised when that doesn't work in
all cases.  But that is not, and never has been, expected to work, nor
is it a bug that it doesn't.

[0] https://en.wikipedia.org/wiki/Dotted_and_dotless_I
--=20
brian m. carlson: Houston, Texas, US

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXxtOEwAKCRB8DEliiIei
gXcAAQDy/PYC/J5Mg6wM/y1Fy+e6rXYkTp7Wu1Pu/a5Bsig41gEA4Ae661Zu51/o
ualebLnsqJuNFsd9o8fn6sYVo9fPegw=
=wFSs
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
