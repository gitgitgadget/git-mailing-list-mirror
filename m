Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E865EC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 02:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BB220684
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JFe3H6B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKZCly (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:41:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49594 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbfKZCly (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Nov 2019 21:41:54 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C1EF26045A;
        Tue, 26 Nov 2019 02:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574736112;
        bh=80/FWk+WGvCndZgN9jCChgU5yHDky4BVZzYeApnv44k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JFe3H6B/ySs+WjGa9rgQjzQSz4qQQVwJhQ4ArK0tVoXckAAcvL7mxAP+enLJFmwmQ
         19RncwMGfPFd3W8doVMe3EXF58Ur5eY1f3+BydJbIUxTbvpgD8B2ZI5ra31/0GUfIJ
         RjJdXoKviaGND4oBQpfDGN6oCOjFCxC9HakqeZ7JnbAmchYDk3fUIJX6dPVrutc88A
         ZgN5jaOQmiE2Rb01jnBQ4tAqmsEZAkDcy7+rmbKKvwsL92vunRHTWAOITIyA5upOip
         YbqIzLQDlUyWQydHjCqxJoEtsknB/DeRJMBhWX5V0fg7Bp8sqf68T7J5ybg/dmLqsF
         Tnw3X6lVR8QdYMp+xaopOn1bElKX6sR0pZOXqsx0pbeHm4Lp1nWswtSAhpY8JEAKGs
         KwATiGdoEby8kVG6kzNrr0LXRxzFYeRTJ/ZVNuBD5WGsQO6H5fb+li6j7JJGn+qHCT
         h/r+bLLd+G1zvTgIMs2aDZWQwtcRi/LoYxZ46M+0A4nMFr9ao/O
Date:   Tue, 26 Nov 2019 02:41:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191126024147.GF2404748@camp.crustytoothpaste.net>
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
 <20191126002806.GD2404748@camp.crustytoothpaste.net>
 <20191126005614.GA251804@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20191126005614.GA251804@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-26 at 00:56:14, Emily Shaffer wrote:
> Hopefully I am not beating a dead horse here but I really want to
> understand. Let me take another guess with examples at what you mean;
> please correct me!
>=20
> For our purposes, let's assume:
>=20
> .git/hooks/
>   update
>   update.d/
>     update-1
>     update-2
>=20
> update:
>   #!/bin/bash
>=20
>   ./git/hooks/update.d/update-1 &&
>   ./git/hooks/update.d/update-2
>=20
> The goal is to make sure update-1 and update-2 are run when other update
> hooks happen.



> With my proposal as is, I see two options:
>=20
> 1)
> .git/config:
>   hook.runHookDir =3D true
>=20
> This will run whatever else is in hook.update, and then it will run
> .git/hooks/update. This is not ideal because hookDir could change, and
> then the content of update will be incorrect:
>=20
>   git config --add core.hookdir=3D~/hooks/
>   mv .git/hooks/update* ~/hooks/
>   # call something which invokes update hooks
>   # ~/hooks/update fails, .git/hooks/update-1 is gone :(
>=20

This is actually fine.  We assume the user knows where they want to
store their hooks.  If they change that, then that's intentional.

> .git/config:
>   hook.update =3D 001:/project/path/.git/hooks/update.d/update-1
>   hook.update =3D 002:/project/path/.git/hooks/update.d/update-2
>=20
> This will run each update hook individually and have no notion of
> whether they're in a "hook dir" or not. It sees a path, it hands it to
> 'sh' to run, it checks the return code.

Correct.  This is the logical porting of the above shell script to the
config syntax if you use an absolute path.

> Now I run 'mv .git/hooks/update* ~/hooks/'. Next time I invoke something
> which would run the 'update' hook, it fails, because the path in the
> config isn't pointing to anything. But this way is unrelated to hookdir.

Yes, that's correct.

It sounds like you're thinking of the config approach as completely
orthogonal to the hook directory.  However, I want to have multiple
per-repository hooks that do not live within the repository but move
with it.  The logical place to store those hooks is in the hook
directory, even if it's not being invoked by Git explicitly.  To use
that with the config approach so I can have multiple hooks in a useful
way that's compatible with other tools, I need some way to refer to
whatever the hook directory is at a given point in time.

> It sounds like you might be asking for something like:
>=20
> .git/config:
>   hook.update =3D 001:__HOOKDIR__/update.d/update-1
>=20
> I'm not sure that I like the idea of this. My own dream is to eliminate
> the need for a hookdir entirely, so it's logically easy for my Gerrit
> hook to live in ~/gerrit-tools/ and my linter to live in ~/clang-tidy/
> and so on.

Using the config syntax eliminates per-repository storage for hooks.  I,
personally, want to store multiple one-off hooks in my hooks directory.
I want to use tools that install one-off hooks into my repository
without needing to depend on the location of those tools in the future.
I don't want those hooks to live elsewhere on my file system, since that
makes my repository no longer self contained.

I want to store those hooks in the hook directory, wherever I've
configured that, and whatever that happens to be at this point in time.

I may additionally have tools that live in other locations as well and
may use other syntaxes to invoke them.  For example, I may install a
hook that's provided by a Debian package and refer to it using a bare
program name.

If your goal is to eliminate the hook directory entirely, then I can't
say that I'm in support of that.  A design which does that won't meet my
needs, and it likely won't meet the needs of other users.

The benefit of your proposed config syntax for me is that it provides a
standard way to configure multiple hooks.  I still want many of those
hooks to live in the hook directory, although others may live elsewhere.

> I could see option 1 being alleviated by writing it as something like:
>=20
> update:
>   $GIT_HOOKDIR/update.d/update-1 &&
>   $GIT_HOOKDIR/update.d/update-2
>=20
> or
> update:
>   $(git config core.hookdir)/update.d/update-1 &&
>   $(git config core.hookdir)/update.d/update-2

This is similar to what I want, and why I want to pass it to the shell.
I can write the following, and everything just works:

=2Egit/config:
  hook.update =3D 001:$(git config core.hookdir || echo .git/hooks)/update.=
d/update-1
  hook.update =3D 002:$(git config core.hookdir || echo .git/hooks)/update.=
d/update-2

Wherever I have placed my hooks for this repository, I can refer to
them with a shell script.  I can also add the following line as well:

=2Egit/config:
  hook.update =3D debian-package-hook update

=E2=80=A6and everything just works.

> But, I think once you "buy in" to the idea of providing a full path to
> the final target - not to a trampoline script - in your config, you
> should forget about the idea of "core.hookdir" having anything to do
> with it.

I have no intention of providing a full path to any hook, since that's
quite brittle.  There are very few paths on my system which can be
guaranteed not to change, and all of them are things like /bin/sh or
/usr/bin/env.  If my hooks are in the hook directory (or even in the
working tree) with a full path and I move that repository, they become
broken.  If they're shipped by Debian and Debian decides to move the
command, they're broken.

I'm very interested in learning more about why you seem to want to
specify full paths.  It seems very at odds with the way the rest of Git
works.  If the goal is to support other syntaxes in the future, then
let's use a prefix character (e.g. !) to denote commands vs.
non-commands or something like that.  If the goal is security, then I'd
like to hear more about the security model you're trying to achieve with
this design.

> To quote you out-of-order now:
>=20
> > If we want to allow people to have multiple hooks under something like
> > .git/hooks/pre-push.d, then we need to have a way to wire them up in the
> > configuration using the correct location of the hook directory instead
> > of using a helper script like the one I linked above.
>=20
> I think I may spot the misunderstanding. It sounds like you hope someone
> can provide "hook.update=3D001:~/update.d/" and have all the contents of
> update.d executed. I'll be clear and say that I didn't have the
> intention to support that at all; instead I was hoping to support a case
> like 2. above. Recursing through directories like that sounds scary to
> order.

I don't need a particular way to do that, since I can do it already, but
I do need a way to wire up multiple hooks that are per-repository and
move with the repository but aren't in the repository.  In other words,
I need a functional replacement for that approach if we're not going to
use that approach itself.

Hopefully I've done a better job at explaining myself here.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3ckOsACgkQv1NdgR9S
9ovEYBAAsjgM+w6lXlyYH158Y9/hqMkf8qeX9tJYDqsk22ygqLS/PaWKaVTccOyg
2E218PY//G72iaWn4/WRQ5AuZH35kFUkgmh6CnEU/GHDqWLcJmeZbIU3pILhwuEk
j/TV2wZsjL9LMGrAE4pLxwp6fTMzwUhW1bWzytOlLLGz7SM6LimgtZB+w8+nxDld
fo8smNH8xVO21YuP0UW8quIu0pDmGPeZmP0NMgJXl1cwLw0Id/ZFARic3xMxBZKY
1IzGNlcZ2OnWmPiUfeMOmcSy13r1VGEcm70DRs9V8BEBYrwiEDkr2M1ZRiiFS+h6
I4WpCMWQkEDavzByhRnsPKfs/4xIfj9UXDU1pWYAvcc6dikI+XzDzCSE9BOc0Pzf
C9DBmiAaJFy2o/NuM/ITC0kRydpWylytTjEJqQo0T15z3r544s9yz6ks/qMlIvgA
m4BM2YbClYVsFWts1BftPHtG2a+gOgOUnlVGUOOfKc9YL6+W6DDPFBmNlGwG87+m
9ioQrZcjDc5Y8bOcGANAYwHcgEHw+0OMFmb3r2N9kIgBaLQ9q+8PfoZOwkrLR5tM
QdYoYAgRz0VckNAR4OOx8z/kmEESXQXP3lu4tsP7n2btkkYLntwdpUpV4U23nrx4
YcZj5YuH2p6+bZzsrFu+Q3wUN6kqADQt8DwIlfWJbBx1JB51N6Q=
=MhKU
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
