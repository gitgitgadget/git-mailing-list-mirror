Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C3C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6B20748
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QjtlCS3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKZA2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:28:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfKZA2O (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Nov 2019 19:28:14 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F2086045A;
        Tue, 26 Nov 2019 00:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574728092;
        bh=9GQuc4ic9i8fbP8saZfLbN0AN9QNeyhYuypzsKmkFuM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QjtlCS3cq5mBw9Dw3oVGF5HyePraZgkuOYQxuYqSDMxXdpbdXpiOESw4OpyaxVaJZ
         GpwHngr6cqJjP0MGPjNfqkOmuZG9K/BKb0rgoWDeORKbpCQ+ajQ4sTxGSfYrX8rUeg
         IwvyEfFEjo9t8XvC6Q/WtYn6PnxNOfkkRmYJPFIlZHTt8mdbb4HyJA/b6f/wYZjS8U
         QRnmg6WbvvvLmJbtOoKSMIE9rfRSjm+Vt3e7H7SjnyGyw8nEXkFfiw+7zGKBxyhmCk
         bi2laFqFsZk7muFz+D+N1qDQOhcPairD/d/1imEuYDIBhEkFXltDWYajFvqceULRgZ
         wl1UZiegWYcwZdknd9i8F1+T85839q1h1N8NNDajLpu43C44TWo68iNx46J3EfxhzO
         fySgKQBBJXNwREuVEkMZhC16SjHeZ6wJYuPLBCSOdhz6fQ0kW344acc8GPP3m+2OQb
         O/5MKbj8Cq13HGkjQ/5wPOuGQRLxWPiVF15UC0SHYI0ijRUSmLC
Date:   Tue, 26 Nov 2019 00:28:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191126002806.GD2404748@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
 <20191123011924.GC101478@google.com>
 <20191125030445.GB2404748@camp.crustytoothpaste.net>
 <20191125222113.GA83137@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <20191125222113.GA83137@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-25 at 22:21:13, Emily Shaffer wrote:
> I think that you are saying we should do the nice equivalent of:
>=20
>   system("git lfs pre-push");
>=20
> and tack the args onto the end. (I suppose that's run-command.h, but I'm
> trying to use a shorthand that is easy to understand.)

Yeah, I'm proposing we run the command using run-command.c with the
use_shell flag, which does something very much like that, except a
little bit saner.

> It seems like this would solve the PATH issue, yes. However, I feel
> tentative because of pushback on that approach in the bugreport review.
> Hmmm. I think this is different, because the user understands that the
> hook they configure themselves will be invoked on the shell of their
> choosing. That is, I think run-command.h with "C:\myhook.exe" would
> still work, no?

This will always use /bin/sh, as we do for editors.

bash on Windows does understand the Windows paths and works correctly in
this case, AIUI, so that should be fine.

> Will this approach "just work" for Windows, et al.?

Yes.  Windows ships with bash (or in Portable Git, busybox sh), which is
not only required to run the testsuite, but required to invoke editors.

> > I do, however, think we should require folks to have a suitable hook
> > that accepts the right arguments.  So "git grep blahblah" isn't a valid
> > hook in most cases, because it doesn't take the right arguments and read
> > the right data from stdin if necessary.
>=20
> I'm not sure how we would guarantee that. Are you suggesting we should
> try dry running a hook somehow when it's added with 'git hook add'? Even
> doing that won't stop someone from popping open ~/.gitconfig with nano
> and adding their hook that doesn't take the right args that way.

We don't need to guarantee that.  We just need to document it, so that
(a) people write hooks in the expected way and (b) if people don't, we
can point them to the documentation and explain why their hooks don't
work.  I can see people thinking of this as a set of commands that just
checks exit statuses, and there's likely to be confusion.

> > I'm just thinking about existing hook wrappers that invoke multiple
> > scripts at the moment, something like how
> > https://gist.github.com/mjackson/7e602a7aa357cfe37dadcc016710931b works
> > at the moment and how we'd replace that with a config-based model.
> >=20
> > I think using the shell avoids the entire proposal, because it then
> > becomes trivial to script that in the command and port it over, since we
> > can use my ugly hack above.
>=20
> Still not sure I understand what the issue was before. Is it that the
> trampoline script needs to know $PATH to be able to invoke the child
> hooks in hookname.d? Or it's because the current working directory
> isn't clear, so a relative path in the trampoline script may not be
> resolved well?

I think we need to have either (a) a way to explicitly invoke hooks
underneath the hook directory or (b) a shell invocation to allow looking
up the hook directory.  People want to have per-repository hooks that
are not a part of the project, and they need a place to store them,
which is logically the hook directory.

If we want to allow people to have multiple hooks under something like
=2Egit/hooks/pre-push.d, then we need to have a way to wire them up in the
configuration using the correct location of the hook directory instead
of using a helper script like the one I linked above.

We don't know that the hook directory will necessarily be under
=2Egit/hooks, so if the user has moved it elsewhere, we'd want to follow
that.  A relative path would be wrong if the user changed the hook
directory to a different location.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3ccZYACgkQv1NdgR9S
9otiEhAAxWhg/cePuVqwLr01JE0oZPpBLcNJ5d+Ms5oihl7WWycaGX5z30V/5jO0
9wW1CIC/z3sX4Ffn5y5yMTNstshSPE8uxm0B6R5IuRNGVHkG56l1bniAXeQC1gOt
OfusB6UU1DH1pqIRbwYj9wZMBR5uNFXnUeg3l3Lu7JQyjOegeaK69SSSN5pBAt3t
HYipVM1muAM524P87czMZc/TytB6afEzdBZKcM7wOrX+E0o7MdVsDcagBuErhWFf
bA6ZcTCs72O2MydbZiP8pdl8jaSbPIcgIgPMPy3GHy2iXeY0Sw7zZxH+QEETjwvw
PU2R2UYpi+/qZgP3HvsIwYbOfyb+GVmASSBzmkcWLxOtPh+OCy2M3rHXYlD3kvPg
OjreXLxJycX/lsBij4oX0Zm7JM5f0QQvOc2z1MfqNyqBYNRW6ZjXf2mZ2dAm6B1t
psPAU6kMfTFLbKeIhynW6C9bNyZXJV52yP9snfLrLJEiRPjDXYaNwn6m5FniaI/o
Ly3+i+ewMdNtMMz68gkq9oudJ8KiniT7diuRTMmIabR5uKNd8TUFnYZzqtaTPQlT
tMMLrmXssxVYJupxQZHRCGChE2nOwRFn0eaRwEpHGNm5Y0O1vFj/nWy0jcS0+Ihr
0c+vwt74E/ePjCmElv1ARxcPgUJOrxxlTc54HRyFeCyFWoeCkl0=
=rJve
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
