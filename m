Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23967C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 21:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiANVMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 16:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiANVMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 16:12:50 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69108C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 13:12:50 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8D6075B236;
        Fri, 14 Jan 2022 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642194769;
        bh=yZU00rpJArUSlVbeQSJNS7jmWnZ1r44t3iuDKbe/7jA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=N8E42z7hMBL/LqUQWSPCWLeo9BFng9A2ImpRo2cLxZKI0CDjkEgOGX0mUcM0Ph5yt
         2u13NNTksKqnTt8Xf5RRbJhf6tSC6B8pp2ZLp9SAI0cbW2TT50XRArPKhWGp+n99+0
         ABXVsFsILeWKHsnx8A8y/sSxOv/l0iaczgTKLjnbUjulpcrRFrX71JIDg+aFaC9B5G
         GRvDPteiYbSERiwQnxHtbgtXY09hm5tuH5cSnpoY9ZPZrg1ZHHcT/N8fydYFBl4+23
         9si+bvCJMnLPTC598SWLm7QT33CEkjBuuKcAtOiLc3Qzi5id5oagCRhWsieS8Ljm/N
         7vOWvzngR+OJaMOoo6p/Hc6kkyT+HSthGXPnh+KwkGl4QA7iJBoRzObXUmCLbc8ITW
         W+8vvwax03SmGi4bIyh3TJy63nOBYpkqLyZcTWIVBmUqoH9D0BYvhaZ4MFobasPbIK
         0LZksat9loVASh15yLTIijzXgrPIJX4X4oQr+SMDTrQzMZUCd4B
Date:   Fri, 14 Jan 2022 21:12:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
Message-ID: <YeHnT1BcisbVvQHB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
References: <cover.1642129840.git.dyroneteng@gmail.com>
 <xmqqfspqeun5.fsf@gitster.g>
 <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eA24vURGVwNi2k1t"
Content-Disposition: inline
In-Reply-To: <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eA24vURGVwNi2k1t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-14 at 19:57:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Thu, Jan 13 2022, Junio C Hamano wrote:
>=20
> > Teng Long <dyroneteng@gmail.com> writes:
> >
> >> +test_must_fail 'Exchange the order of "--heads" and <remote>' '
> >> +    git --version &&
> >> +    git init "test.git" &&
> >> +    test_commit -C "test.git" one &&
> >> +    git -C "test.git" ls-remote --heads ./. > result.1 &&
> >> +    git -C "test.git" ls-remote ./. --heads > result.2 &&
> >
> > I would say that this is working exactly as designed.  As with the
> > unix tradition, after the command name, first come options
> > (e.g. "--heads", "-v", etc. that begin with a dash or two dashes),
> > then arguments like "origin", "master", "." that are not dashed
> > options/flags.
> >
> > Then among the arguments, we generally take revs first and then
> > pathspecs.  "git help cli" explicitly mentions this, because it is
> > specific to "git" command suite, but it does not mention "dashed
> > options/flags first and then args", primarily because, at least back
> > when the documentation was written, this was taken as granted, iow,
> > those who wrote the "gitcli" documentation thought it was a common
> > knowledge among users that did not need to be spelled out.
> >
> > Apparently, it is not a common knowledge at least for you (and
> > probably others).  Perhaps we should add a paragraph to the cli help
> > and explicitly mention "options first and then args", before we go
> > on to say "among args, revs first and then pathspecs".
>=20
> I don't think this summary is accurate.
>=20
> We have multiple commands that are in GNU-fashion loose about whether
> you provide options first before no-option args, or after. E.g. we
> accept both of:
>=20
>     git push --dry-run <remote> <ref>
>=20
> And:
>=20
>     git push <remote> <ref> --dry-run
>=20
> The "tradition" you're referring to accurately summarizes how POSIX
> specifies that things should work.
>
> But when GNU came around its option parser was generally happy to accept
> options and args in either order. E.g. these both work with GNU
> coreutils, but the latter will fail on FreeBSD and various other
> capital-U UNIX-es:
>=20
>     touch foo; rm -v foo
>     touch foo; rm foo -v

Yes, POSIX specifies this is how it should work because it avoids
ambiguity.  According to POSIX, -v is a file, and that's a valid name on
Unix.  If GNU rm fails to delete that file or provide a diagnostic about
why it didn't, that's a bug.

In some cases, we do allow the GNU behavior of providing options
anywhere on the command line, but we don't when it causes ambiguity,
like in this case.  I think we should document the current behavior, but
I also think it's a given when working on Unix because many tools don't
work that way.  For example, test and find don't permit arbitrary
location of options and arguments and they are found on all Unix
systems.  You can't write "test foo -f".

And to prove that this is ambiguous, I provide you the following
example:

$ git update-ref refs/heads/--symref HEAD
$ git ls-remote . --symref
1ffcbaa1a5f10c9f706314d77f88de20a4a498c2        refs/heads/--symref

That prints something very different if I write "git ls-remote --symref
=2E".  And it is actually the case that people write this kind of syntax
in scripts relying on the current behavior and then those scripts get
used in a variety of situations with arbitrary ref names, so this should
continue to work this way.  I believe a former employer may have these
kinds of scripts, for example.

I'm not opposed to us building new tools which support the GNU behavior,
but I don't think we should change tools where we have the existing
behavior because it does lead to breakage in some scripting situations.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--eA24vURGVwNi2k1t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYeHnTgAKCRB8DEliiIei
gQABAP949UfqhYn5m3UaIAEVZCcCQsrZ+nuDxdIfAvZJhsaP+QD/XDifjdVKPQ5O
aDnYMWyYMUxTFlzamwqkKSn5e8cWYgc=
=faas
-----END PGP SIGNATURE-----

--eA24vURGVwNi2k1t--
