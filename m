Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D3EC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F2265256
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCHX5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:57:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231852AbhCHX5A (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Mar 2021 18:57:00 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D5FDA60DF4;
        Mon,  8 Mar 2021 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615247819;
        bh=Jw5oT17cVxcpGgmrIzVy5jcjJkjCF7SD/0yHuCV3a8U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UmKnvFqyr48OxsFlW45aaXD75W9EIu0eHDY3OPGuT38JRwp4B+b6tN+xmaZw2XxzK
         dwsMnoJgEj5PhlZmayo9f3d6PNR4Cc61J3g5LWphBPwbmrPzhSWgZZGeV02uDcJdKh
         2UpgpyQ0dV/2kMgzuwwnhdQx9w9VmZpDKHS2AcaEIWalkN41bIsHO8eSb1yHv9UJFT
         o1Eojg+qLUtBAgtwGiw786dQr+wV6JX0cOrhIazIuFG/Rw9A0TncQKMuU5ySTPmzxz
         EXdIIpiCg+uUm6k6N8JQ5RAlKPSauVOzvtAP3lpXRl97kTYWSsR39D0kHtqHzOoZmL
         t352/Vc6ZAXgIw76WG1I+TluYFR0CS6DXHyCkhCcRGYfST4RusKcMiYE5A40XcHgTi
         8J4GG8sPLca3gMdx+NQ1rrEZM++x6gcCex8XsVcuS/cM6n22AR4+zgKlCR/3u77IBm
         JjLIYw14L4T2siR31Rj2euB6hxg97FeDFj2pvp4DDKvjwqOT6rz
Date:   Mon, 8 Mar 2021 23:56:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Anthony Muller <anthony@monospace.sh>, git <git@vger.kernel.org>
Subject: Re: Performance of "git gc..." is extremely bad in some cases
Message-ID: <YEa5xe0gNDh2wZLB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bryan Turner <bturner@atlassian.com>,
        Anthony Muller <anthony@monospace.sh>, git <git@vger.kernel.org>
References: <17813b232e9.e48d03c3862272.7793967418558853913@monospace.sh>
 <CAGyf7-F6jbs-HQeCSMjf_y8Y=5ZfME=CjBagAfKUbnP_0vDXqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WvSF569t5fnvec6f"
Content-Disposition: inline
In-Reply-To: <CAGyf7-F6jbs-HQeCSMjf_y8Y=5ZfME=CjBagAfKUbnP_0vDXqA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WvSF569t5fnvec6f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-08 at 22:29:16, Bryan Turner wrote:
> On Mon, Mar 8, 2021 at 1:32 PM Anthony Muller <anthony@monospace.sh> wrot=
e:
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > git clone https://github.com/notracking/hosts-blocklists
> > cd hosts-blocklists
> > git reflog expire --all --expire=3Dnow && git gc --prune=3Dnow --aggres=
sive
>=20
> --aggressive tells git gc to discard all of its existing delta chains
> and go find new ones, and to be fairly aggressive in how it looks for
> candidates. This is going to be the primary source of the resource
> usage you see, as well as the time.
>=20
> Aggressive GCs are something you do once in a (very great) while. If
> you try this without the --aggressive, how does it look?

I should point out that this repository is also rather pathologically
structured.  Almost every commit is an automatic commit updating the
same five files which are text files ranging from 5 MB to 11 MB.

When you use --aggressive, as Bryan pointed out, you're asking to throw
away all the deltas and try really hard to compute all of them fresh.
That's going to use a lot of memory because you're loading many large
text files into memory.  It's also going to use a lot of CPU because
these files do indeed delta extremely well, and since computing deltas
on larger files is more expensive, especially when there are many of
them.

And that's just the blobs.  The trees and commits are also going to be
nearly identically structured and will also delta well with virtually
every other similar object of their type.  Normally Git sorts by size
which helps pick better candidates, but since these are all going to be
identically sized, the performance is going to suffer.

Now, I have the advantage in this case of being a person who's sometimes
on call for the maintenance of Git repositories and in that capacity,
that this is pathologically structured is obvious to me.  But, yeah, I
would definitely not run --aggressive on this repo unless I needed to
and I would not expect it to perform well.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--WvSF569t5fnvec6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEa5xAAKCRB8DEliiIei
gS1ZAP9gUDT+ky4Sx+UEWwtqAn4QGMppW+Skr8PtwHJPj5GepwEA/HHt3s2dP7ht
yK3P06VH4uETf2iiK7D380cnp7BP5AA=
=rA6Q
-----END PGP SIGNATURE-----

--WvSF569t5fnvec6f--
