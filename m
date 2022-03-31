Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36CC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiCaVVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiCaVVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 17:21:11 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FB3FBE9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:19:24 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 23D455A107;
        Thu, 31 Mar 2022 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1648761563;
        bh=GWlWbfZ7P1d+oswJTiDxLmVB1/tg9IXP3wfjJEzyDFs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WCVAq5orcIQkOcuFtPAm+DaFDd7851ZbglicPdbPM3C+s0d609UjY+uQ7t4x4Cfbp
         6Yf70yXFs1MSmwrEJmzSCigRH+gCCLQpkDxnLoW+0wfLVK7/P7nIiGZl0dO8L36Jbg
         BeibXGhxwKDI7hXHi5Rbbjpt4++ZR7r0sI+28bwqOYj7CCQYEWflidgXid6lp7Rqgo
         Dh9D9U8mVQsGjPEtQu3E7WJx+/hD+8R+2jGpyDWOjPBU4ekpdRPq1KvEmV5AzoyjnB
         qMaTB/TOw71bNdK+PF02eBUVwiOOKxWJC+jKMTkU3yLRoOcn0cIQ2MUOD9OVjFPsSM
         hDxFzGJw7hQV458geMS+mWC0Zja3OJjTtLjUP1jeXdUk3Vq1+F7kq7UqUBhRPdW5A+
         s3zdyRuFa99gCFQPj3AN4o7FGc9EHXURjU5N7ua43FPqBL99QVHMBR8qTsi3G9CyjV
         ktZeKj4CSj5FFcyclVPHzDROyeLVVuBK1lUqwfSbS18xaIbIzgy
Date:   Thu, 31 Mar 2022 21:19:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
Message-ID: <YkYa2NyA6IwIqZ4C@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <xmqqy20r3rv7.fsf@gitster.g>
 <220331.86v8vuqv95.gmgdl@evledraar.gmail.com>
 <xmqqo81l286e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nIUtN0WH8ABgMvgP"
Content-Disposition: inline
In-Reply-To: <xmqqo81l286e.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nIUtN0WH8ABgMvgP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-31 at 20:12:09, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> >> A separate weather balloon for C99 as a whole was raised separately
> >> in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
> >> 2021-12-01).  Hopefully, as we find out that all C99 features are OK
> >> on all platforms we care about, we can stop probing the features we
> >> want one-by-one like this
> >
> > Unfortunately this really isn't the case at all, the norm is for
> > compilers to advertise that they support verison X of the standard via
> > these macros when they consider the support "good enough", but while
> > there's still a long list of unimplemented features before they're at
> > 100% support (and most never fully get to 100%).
> >
> > We also need to worry about the stdlib implementation, and not just the
> > compiler, see e.g. the %zu format and MinGW in the exchange at
> > https://lore.kernel.org/git/220318.86bky3cr8j.gmgdl@evledraar.gmail.com/
> > and
> > https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.=
com/;
> >
> > But I think we're thoroughly past needing to worry about basic language
> > features in C99 such as these inline variable declarations.
>=20
> Well, that makes it sound like the C99 weather balloon was almost
> useless, doesn't it?

I think if we were talking about C17, maybe.  But as I said in my commit
message, C99 is over two decades old and required for the POSIX version
which came out in 2001.  I'm aware of only two platforms we care about
that don't support that POSIX version, which are NonStop and Windows.

I think the likelihood of this being a problem is very low.  And I think
we can justifiably expect that major syntactic functionality is
available when the define is set accordingly.  I am also willing to
simply tell people that a compiler that includes the define and doesn't
include the requisite features is buggy and ask them to use a modern
version of GCC or clang.  But, ultimately, given we're talking about
C99, this is extremely unlikely to ever be a problem in 2022.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--nIUtN0WH8ABgMvgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkYa1wAKCRB8DEliiIei
gXG2AQCiiQ83Rzvn1IdLSg+oKbkv+bqHwmzuMzz/FwC68EEAUAEAjBv/WF8z99sU
ZEc4VwirovR6wZBgrxz3SzFRhokGoQI=
=pixM
-----END PGP SIGNATURE-----

--nIUtN0WH8ABgMvgP--
