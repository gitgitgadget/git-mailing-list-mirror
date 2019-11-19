Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88CB1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKSAvu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:51:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43898 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfKSAvu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Nov 2019 19:51:50 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A36E160458;
        Tue, 19 Nov 2019 00:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574124708;
        bh=UmSY2ehQ2HFR4s+FOUVXRctc3dB1tCOpWtTrWnNi0bQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LwX1c6bE78M/tJitXvkUEzsnVzaJCVErLwT61Hq486SV4UD52LxrzWXOFKHRfeZ52
         ukS3R3FaUtz2Org57Yc4m3TvGJcSGxvEfIS2nPZMLPQ1RDWH103+QvcSNXynRwRgJJ
         lPF1dLPuu1PAI9x2hnaUhBeyEmrBqa/r5P8TlWaO3lpxacNwh3Ym1PBxwaMihnZzJH
         dwQtxGtphAjVuHPdH11P5d7Kzwoxm7fh1b2yaD62SmHmYY3+NOzpRWpPAyzQI7MhJs
         gk5Inc2e5AEdbxcavFsyQaF62ds4WeOc4FWzcrief2gDsIWSypkR2D5dIIt0IomcQm
         X+x6GCWdE7tM4Csb88AqJsDEOA/Dz1esKuvXrkBVnGrSoyOimee8znDsX3tGj/v8qq
         ALCacCpY+EdhHoaAno7gZML1NE64SxYIB27WOcY98EK7AjUIFZ7cVjOf4QrFjyhx5r
         JFg+6m69qtUKhMCsTtl5+uF32G8a1E+B/Ln9d6+j5q/aInZ7Cap
Date:   Tue, 19 Nov 2019 00:51:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191119005136.GA6430@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20191118223819.GI22855@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-18 at 22:38:19, Emily Shaffer wrote:
> On Sat, Nov 16, 2019 at 05:45:01AM +0000, brian m. carlson wrote:
> > On 2019-11-16 at 01:11:25, Emily Shaffer wrote:
> > > Here's my suggestion.
> > >=20
> > >  - Let configs handle the hook list and ordering, via 'hook.{hookname=
}' which
> > >    can be specified more than once.
> > >    - global config: hook.update =3D /path/to/firsthook
> > >      user config: hook.update =3D /path/to/secondhook
> > >      worktree config: hook.update =3D -/path/to/firsthook #eliminate =
the firsthook
> > >       call
> > >    - global config: hook.update =3D /path/to/firsthook
> > >      repo config: hook.update =3D /path/to/secondhook
> > >      repo config: hook.update =3D ^/path/to/firsthook #move firsthook=
 execution
> > >        after secondhook for this project
> >=20
> > I'd like to hear more about how we handle multiple hooks that are
> > repo-specific and don't live in the PATH.  This is a common situation
> > for existing tools that handle multiple hooks, and it's one I think we
> > should support.
>=20
> I guess I'm confused about where PATH comes into play. Do you mean that
> the hook being run relies on PATH to be set appropriately? I had
> envisioned absolute paths in the config.

In past discussions, there's been an assumption that hooks in the config
will be found in PATH if they're not specified explicitly, and I assumed
(apparently incorrectly) that the same would be true here.

I do expect folks are going to want to use non-absolute paths, though.
If I'm invoking the git binary in a hook, I don't care whether it exists
in /usr/bin, /usr/local/bin, ~/bin, or somewhere else entirely.  That's
my shell's problem to figure out.

It's also common for folks to use something like "bundle exec" in a hook
to run a linter that's installed by the local package manager, and in
order to do that, you have to honor PATH to find the package manager's
binary.  That could be in a variety of places, and it could end up
changing dynamically in a session due to a tool like RVM.

> > Perhaps we add a "git hook execute" subcommand that executes scripts
> > from the hook directory.
>=20
> Can you give an example of when you'd use it? I'm not understanding your
> concern and I think an example use case would help me see what you mean.

Sure.  Currently, if I have pre-push hook, it lives in
=2Egit/hooks/pre-push.  Now, I want to have multiple hooks for that which
are specific to my repo.  Maybe I've stuffed them into
=2Egit/hooks/pre-push.d/hook1 and .git/hooks/pre-push.d/hook2, since
that's where my previous hook management system put them, but I now want
to use those same hooks with the config style and drop the old tool.

I'd like to use "git hook execute pre-push.d/hook1" and "git hook
execute pre-push.d/hook2" to automatically find the right hooks and
invoke them.  Similarly, I could use "git hook execute pre-push" to
execute the old pre-push hook.

I suppose if we continue to keep the existing behavior of changing the
directory and we pass the config options to the shell, then we could
just write "$(git config core.hooksPath || echo
=2Egit/hooks)/pre-push.d/hook1" instead, which, while ugly, gets the job
done.  Then we wouldn't need such a command.

> > I think this addresses most of the concerns that I had about ordering.
> > It is still a little suboptimal that we're relying on the ordering of
> > the config file, since it makes things equivalent to numbered files in
> > .d directories hard.
>=20
> Hm, I suppose I don't see why, if the final ordering is determined by
> the .git/config (or future replacement for that). Can you explain what
> you mean? I want to understand where you're coming from.

One of the benefits to using numbered files in a .d directory is that
you can explicitly control ordering of operations.  For example, maybe I
have a per-repo pre-push hook that performs some checks and rejects a
push if something is off.  I also have a pre-push hook for Git LFS that
pushes the Git LFS objects to the remote server if Git LFS is in use.

In this case, I'd always want my sanity-check hook to run first, and so
I'd number it first.  This is fine if both are per-repo, but if the LFS
hook is global, then it's in the wrong order and my LFS objects are
pushed even though my sanity check failed.

> > Possibly as an alternative to the ^ syntax, we could make the hook value
> > be of the form "key program", where key is a sort key (e.g., a number)
> > and program is the program to run.  We pick normal config file ordering
> > if the keys are identical.  Then if the system config wants to have a
> > hook that always runs at the end, it can do so easily.
>=20
> Interesting. This way if you decide after you've set up all your configs
> just so that you really want something to run at the end of the update
> event, you can change one place, not n=3Dnumber of Git repos. (I do still
> want to be able to say "don't run that global hook in this project"
> though.)

Exactly.  A global or per-user commit-msg hook may want to see the final
message before approving or rejecting it, and that wouldn't be possible
without some sort of ordering.

I strongly agree that we should still allow removing higher-level hooks.

> > In addition, we should be sure that attempting to remove a hook which
> > doesn't exist isn't an error, since a user might want to set their
> > ~/.gitconfig file to always unset a global hook that may or may not
> > exist.
>=20
> I'd be comfortable with a warning when exiting 'git hook edit' mode and
> silence when actually running the hook list.

Yeah, that's what I'm going for.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3TPJgACgkQv1NdgR9S
9ovF9xAAl4HK5qiZPXDpOkJlC1iWgUf0F/TnWWikmRyggDkj/XGdt8TZO+49HHMb
P92b+OPlOc5FCKfFEJS4Jhh33iOvqb0Iv1x78b2Wk0GTourHvrJCNrzmPiarrxPl
pwE+fZ7zTaqB8DCbfRB4lb8zmjX8s4igyNASpyRTzGIEr42ccwMJP5oPdJZqXSGZ
diP6z2z3kbBsXwVsVt1RXYLsEQe2XXGBdfUu1ldbgmUI0oHW9fH3mG63doL4K0fy
MVdKtFScumLVOea4LLPMxnJVyUG/iRmO5InbX/tcb8BHB+blz2ID/vK59TvdmzKP
wJSgloe4fsyP1a1d5EFLXiT5PKVCACLI6FHi7p1BKu7ycsEKxVFT8TC1QZCLfcwM
QitF7SgN2Tazr+zhnzPbx7j6NS112hBsVre5EE842k5EQ26o3Ygko3bQeiejVLN3
T2+loOfu7sZf53V5FtyhHnZY0JMWNZZohdAkT8c/7/1pcWdoVtaJWLFHU4flTHLN
bVCeF7LOMqNCBfum6EAWu10khBmk0tM4WzEKnxanncn94RQSE/oYWF+AXzpWUgIj
YmEx2eLSdKuL7N0RmBZooz8oYGEVfGcJpmCBrfSNoyjcnNIIZF38SNbIzZVY+w5P
RAP7x9e+uohp1vsa8forYYbb3D+q4YyD3DvqX08GGZI4q8zzkhI=
=cW0i
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
