Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04655C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DAA20815
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vbApBX/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKYDFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:05:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbfKYDFB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 24 Nov 2019 22:05:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E4F5060427;
        Mon, 25 Nov 2019 03:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574651099;
        bh=Uf2IHVB6cgJA/C8bg+ROhujSFhq8XVA+pmQHvymv5cA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vbApBX/hIyj/IU4ef0W7tNq9VGPgAOFI9jHUQHXuTgSpHEZjHhkP5JLfggiMy/zo5
         TI6i0e8lJBL+53Oz/SaoolOUAED8m2/bGTuTjsab9uLBIbnAMeGc+0Q+n36C8P7wAh
         E3P0kw/57uUgSUZdrinonlpyb9xpIVrgr14A0IkcahDQFOninYfq5UTZCmGnC/a3J2
         igs8kZpulwN+nw3F6/wogwz23AkIFVk4QSqhnyCfGIXl196tcnOhKIGb505gmc4Wex
         Q4zzVg7HxArp4Ezbo3O3HBNG9BZr9o4SdtBzqm0Bo8J4LIBuYqMFNdErdDo8Vj+rp0
         HzAx8tqm85qkA2EU3sIs6Q6SspnFR7s86Q7Y6MWiiff/vNRC1WrlNnt7bRkEk2n+E6
         oYMZG1vXfIDR996k1FrCemKieIqtRK1hJPJHOEiQzut9jW7r1KUAlaOhAbd9Xp5acB
         j+zd2mJ246xM0NjzRZ+SCRTduKcd62i97JlEWvx90J19GumLjsI
Date:   Mon, 25 Nov 2019 03:04:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191125030445.GB2404748@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
 <20191123011924.GC101478@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20191123011924.GC101478@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-23 at 01:19:24, Emily Shaffer wrote:
> Ah, I think I see what you mean.
>=20
> hook.update =3D security-heuristic-runner
>=20
> where "security-heuristic-runner" is some compiled binary your employer
> purchased from some vendor and distributed directly to your `/bin/`.
>=20
> No, I had imagined users would achieve that by writing:
>=20
> hook.update =3D /bin/security-heuristic-runner

Yeah, that's what I'm looking for.  The problem is that, for example,
Debian does not guarantee where in PATH a file is.  Having a newer Git
on RHEL or CentOS systems often involves hacking PATH and
LD_LIBRARY_PATH.

> Hm. Do you mean:
>=20
> hook.update =3D git grep "something"
>=20
> Or do you mean:
>=20
> hook.update =3D ~/grephook.sh
>=20
> grephook.sh:
>   #!/bin/bash
>=20
>   git grep "something" >output
>   ... do something with output ...

I had intended to include the latter case, but also allow valid hooks
with multiple argument support.  For example, you could invoke "git lfs
pre-push" directly in your hook, and that is a fully functioning
pre-push hook, and would require a suitable PATH lookup to find your Git
binary.  It accepts the additional arguments that pre-push hooks accept;
right now we basically do the following instead:

----
#!/bin/sh

exec git lfs pre-push "$@"
----

> I suppose I need to understand better how $PATH works with the latter
> scenario, but my gut says "if you didn't worry about where to find the
> Git binary from your script before, why are you going to start caring
> now".
>=20
> This led me to wonder: "Should we allow someone to pass arguments via
> the hook config?" Or to put it another way, "Should we allow 'hook.update
> =3D grep -Rin blahblah >audit.log'?" I think the answer is no - some hooks
> do expect to be given arguments, for example
> sequencer.c:run_prepare_commit_msg_hook().

I think what we want to do in this case is just invoke things in the
shell with extra arguments, like we do with editors.  This means we
don't have to handle PATH or anything else; we just invoke the shell and
let it handle it.  That lets people provide multi-call binaries (like
git lfs) that include hooks inside them.

I do, however, think we should require folks to have a suitable hook
that accepts the right arguments.  So "git grep blahblah" isn't a valid
hook in most cases, because it doesn't take the right arguments and read
the right data from stdin if necessary.

> > I suppose if we continue to keep the existing behavior of changing the
> > directory and we pass the config options to the shell, then we could
> > just write "$(git config core.hooksPath || echo
> > .git/hooks)/pre-push.d/hook1" instead, which, while ugly, gets the job
> > done.  Then we wouldn't need such a command.
>=20
> Yeah, I am wondering about when you want to run a hook generically (i.e.
> from a noninteractive script) but outside of the context of something in
> the Git binary invoking a hook. Are you thinking of Git commands
> implemented as scripts?

I'm just thinking about existing hook wrappers that invoke multiple
scripts at the moment, something like how
https://gist.github.com/mjackson/7e602a7aa357cfe37dadcc016710931b works
at the moment and how we'd replace that with a config-based model.

I think using the shell avoids the entire proposal, because it then
becomes trivial to script that in the command and port it over, since we
can use my ugly hack above.  I think I like that better than "git hook
execute" because it's a little more flexible.

> > One of the benefits to using numbered files in a .d directory is that
> > you can explicitly control ordering of operations.  For example, maybe I
> > have a per-repo pre-push hook that performs some checks and rejects a
> > push if something is off.  I also have a pre-push hook for Git LFS that
> > pushes the Git LFS objects to the remote server if Git LFS is in use.
> >=20
> > In this case, I'd always want my sanity-check hook to run first, and so
> > I'd number it first.  This is fine if both are per-repo, but if the LFS
> > hook is global, then it's in the wrong order and my LFS objects are
> > pushed even though my sanity check failed.
>=20
> Yeah, this is really compelling, and also removes the somewhat wonky ^
> proposed just below here. I like this idea quite a lot:
>=20
> hook.pre-push =3D 001:/path/to/sanity-checker

I think a colon is actually better than my proposal for a space in this
regard, but I'm not picky: anything unambiguous is fine.

> I'll have to ponder on the UX of a 'git hook'-facilitated interactive
> edit of the hook numbering, though. UX is not my strong point :)

I also find I'm not great at UX, so I can't be of much help.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3bRM0ACgkQv1NdgR9S
9osiWA/+NixJxHzckO9Nh+JN1e6ETS0nvzkFRSy7I6D07rYh2rxhTrnUIbmJ9iqT
LkXSUinFLIgcCjvnjeIuLg47vY9weznkQqSrVCqZlX7rT9opIJ+IqWIKpoHx/6su
GP/HhOX5JMKZxEsLRBDjt440vaskWVSabU09InjTruRbWXuP/4z9JKuqU/w32sYG
1uLsAybm3T7c75lTdfYUNsRtlL63t2xqxCXoGZrKmgEuFXIj7NL92uPT9mV93/wI
4TKyBqHAdtcZ/HDlAQyfp++SiXhasO0rL4mlLRVlUAyWXkakLvIsuHnnuTkzgqRa
iYdKSw+auC0h05bW1t92qQ+LVBHb8GKxSM/RVcwoyqlVL4uJRjyWP8mv61qVcvaG
4rtKulDyv7TbrNgOg5JGXfaoO/9UbFo2a656irPrHVISL4tu5yUtEVJgi7ttLaqp
5MtyFzdRzGSQXQjEFeOXcrps0iI+oKW3CyUB4F82uOP5gsjRBVT5L7BEarRZ9J9s
YqvbGw6U5R78hH0XQQLSsQCQ8a0u28ozgf4ziKFjnkABpVa8svkSrh98YkZESA0D
wqwknIVRsiouIkswriuMLKWpeAI7VBk0MqZoPJug8W29jS37ZXKf57a5jn7W8HEQ
36RpksWfwpQgFYeJYNK6vwCA/6SNHVzdZEClclpW+HIioEWLyw8=
=i0fn
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
