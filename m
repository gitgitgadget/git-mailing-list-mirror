Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4EC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A06263223
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbhKOXp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242093AbhKOXmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:42:19 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E6C079787
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:41:06 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 77B1C5B466;
        Mon, 15 Nov 2021 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637016065;
        bh=LTYjpkAPgP4uTraxZ4PyulGbaJCF7RR5GmbRLiul9rw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RJwCj7aVBSmrdX0UEt525uw1PCxQqC9XMdWs0qCrLRLm+RJlq0X159knKzaMxpctz
         3OGzrqe4tCjtRRb5FWV0kGO25wGmclZMyY3nX8FifhrAVn2NwOGGduQz2MJXhs7Kpp
         0GhRnczgDF+g28OLUSU+8FBcfnMwXpyhgkQmctjvw02qQsM1amYEwP6O9vqGOk9T/n
         liFrm12/l296L9BnnRgY1zBvqjahEClnOw/Y2m4Wawry5OvpjtWHtsQ03uNieoYkHi
         8SHa/lmN3W0DFbXJenYrwSRtpqNaMpAhBnh5BILPVHGh9+v+Xkb6zM/mXDMNEwSYRD
         qBltZQOHIn1ZuI6oMoLeUbNJc1OwnmARMiskRia2DxLRusZP2L2hMa311AmMtqCvux
         G+J2X/QXNrA5errxGPYFFrPq2xkU28L53i0KUuCKwDzqKOBJ05cpmxCaK15Yz7lFze
         tsNQmLSd3NDSIIijGZRU9Oq+8Ic80XHPh02a718kfmvZcqiTJa5
Date:   Mon, 15 Nov 2021 22:41:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add a test balloon for C99
Message-ID: <YZLh/1xkxRGDn76u@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <xmqqy25pj43a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SInq0c6wUSwaey8"
Content-Disposition: inline
In-Reply-To: <xmqqy25pj43a.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7SInq0c6wUSwaey8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-15 at 07:00:25, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Even for users who would like to target an older version of Windows,
> > such as the no longer supported Windows 7, GCC and Clang are available.
> > The LLVM suite, including Clang, is available pre-compiled for download
> > free of charge.  Using a different compiler is specifically proposed by
> > Microsoft staff[1] as a solution for users who wish to build modern
> > programs for MSVC versions which do not support modern C.
> >
> > As such, we can assume that Git can be safely compiled with C99 or C11
> > support on all operating systems which receive security support, and
> > even some which do not.  Our CI confirms that this series passes all
> > tests.  Let's introduce a test balloon which checks for this support and
> > fails with an error message if it is absent.
>=20
> I do not have much against adopting nicer C99 language features in
> principle, but I hope that we are not becoming too Linux centric
> with "other than Linux, as long as Windows is OK in some form,
> everything is peachy" mentality.

It's definitely not my goal to exclude Windows here.  I'm pretty sure
every major Unix platform will handle this fine, and an up to date
MSVC will also handle this fine.

Because compiling Git for Windows is a lot of work (not due to any
failing of that project or its members, just the fact that it requires a
lot of components to be assembled, including a full POSIX environment),
it's not very likely we're going to see a lot of people doing it, since
almost all Windows users are going to be using the regular releases.
It's also likely that they're going to be using some automated CI system
which will likely support a recent version of the compiler.

However, we have in the past heard screaming from people who want to
support old versions of Windows, so my point here is that there are
options if they can't use MSVC for any reason and those options are
easy, accessible, and free of charge.  I should point out that we
already require people on non-Linux Unix systems to install GNU make and
possibly also a shell (if theirs doesn't support the local keyword), so
installing suitable tooling to build Git isn't without precedent.

> If there is a rogue implementation that claims to do C99 with
> STDC_VERSION without properly supporting some language constructs we
> care about, that would be bad.  That is why I tend to prefer the
> approach we have taken so far, validating selected features we care
> about one by one with pointed weather balloon tests, over "the
> compiler says it supports that version, so we trust them".

I think this is going to be unlikely.  People can and do expect to rely
on __STDC_VERSION__ working properly, and it's likely any compiler which
lacked those features has long been fixed.

> Perhaps we can do this, and a more pointed "break compilers without
> variable decl in for() loop" change, at the same time.  After the
> latter turns out to be noise free, we can update CodingGuidelines.

As I mentioned in another thread, we'll need a patch like this first to
enable proper handling for older compilers, but I think that should be
fine on top.

> Even when we clear C99 as the whole, I'd be hesitant to allow
> certain things from the language (not because compilers do not grok
> them, but purely from style and readability point of view).  For
> example, -Wdecl-after-statement is a good discipline to follow even
> if your compiler allows them.

I think specifically -Wdecl-after-statement depends on the situation.
There are many cases where it's less error prone or easier to read if
the variable is declared immediately before it's used.

Regardless, I don't think we need to decide this now.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--7SInq0c6wUSwaey8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZLh/gAKCRB8DEliiIei
gaQdAQDXIRAWHFkCuQpQHrdeB5/0wJClLk8OxM/z3eVKcT8oTgEAiEwIlOdXUXbz
DZQzuDJNs59Kcn4VdRqHaUuV0wZRvQM=
=ZP93
-----END PGP SIGNATURE-----

--7SInq0c6wUSwaey8--
