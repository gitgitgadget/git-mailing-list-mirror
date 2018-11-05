Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5C71F453
	for <e@80x24.org>; Mon,  5 Nov 2018 23:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeKFJQt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 04:16:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725760AbeKFJQs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Nov 2018 04:16:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4409B6077B;
        Mon,  5 Nov 2018 23:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541462069;
        bh=efa/eoHIof+XBfsE3LqfPPw6JJPF7/bkCtqUw1L128c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ujmg+dpI1I6vzgZBLYAAyhjAWLi60SlCCLlFZOjSJNNN2AF4wTO5/As3Uabhi9YVI
         dkNshB3B519c9A1PDGR8Ux/bj6gWEbBD+64azFBMJZsRGVEDMYAUNLUGos8oy0Tmwl
         +63+0h4LiKTJeruiKxNg1AxAGTce/Z45IKEyCtNikMRM0QPc1I98jPHKLCUsBfmMXR
         uZ/riujvsAD4tAbgtZfJY2lDUU/7AvYExN/khnulIY7Fav48BBxa0NapJ56haXOwGI
         8AiVUqt/Qr0uaPoZpc6oRVD5o7fIPvbku9vZ1zkDQ7meIhGNOkIPcElvSriocjdAi7
         Nb6fvYtTs9XIIlNe5eFY314mFVTSg8qPYHaCoMXlA3s+HTrZni0DBFMy4qnn4Mu3N3
         fZS7PYckEkQQuLhgZGVNDerrW/8q20ZnFdkfP5O6kR9oI0HFmWHhB9Xf9lklvhoCK1
         BJLct8SYoIzi9N68r6rrgbfg9yElRGDDuvu72PPzeesRiTzx97M
Date:   Mon, 5 Nov 2018 23:54:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Design of multiple hash support
Message-ID: <20181105235424.GB890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
References: <20181105010032.GN731755@genre.crustytoothpaste.net>
 <xmqqlg68jlny.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZQQ2BqaANTQU_eHgOS0nBp9YzyTx1WAfpgADOyeLs4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZQQ2BqaANTQU_eHgOS0nBp9YzyTx1WAfpgADOyeLs4XQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 10:03:21AM -0800, Stefan Beller wrote:
> On Sun, Nov 4, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > I'm currently working on getting Git to support multiple hash algorit=
hms
> > > in the same binary (SHA-1 and SHA-256).  In order to have a fully
> > > functional binary, we'll need to have some way of indicating to certa=
in
> > > commands (such as init and show-index) that they should assume a cert=
ain
> > > hash algorithm.
> > >
> > > There are basically two approaches I can take.  The first is to provi=
de
> > > each command that needs to learn about this with its own --hash
> > > argument.  So we'd have:
> > >
> > >   git init --hash=3Dsha256
> > >   git show-index --hash=3Dsha256 <some-file
> > >
> > > The other alternative is that we provide a global option to git, which
> > > is parsed by all programs, like so:
> > >
> > >   git --hash=3Dsha256 init
> > >   git --hash=3Dsha256 show-index <some-file
> >
> > I am assuming that "show-index" above is a typo for something like
> > "hash-object"?

> Actually both seem plausible, as both do not require
> RUN_SETUP, which means they cannot rely on the
> extensions.objectFormat setting.

Correct.  In general, I assume that options that want a repository will
use the repository for that information.  There are a small number of
programs, such as init, that need to either set up a repository (without
reference to another repository) or need to inspect files without
necessarily being in a repository.

For example, we will want to have a way of indicating which hash we
would like to use in a fresh repository.  I am for the moment assuming
that we're in a stage 4 configuration: that is, that we're all SHA-1 or
all SHA-256.  A clone will provide this for us, but a git init will not.

Also, our pack index v3 format knows about which hash algorithm is in
use, but packs are not labeled with the algorithm they use.  This isn't
really a problem in normal use, since we always know from context which
algorithm is in use, but we'll need to indicate to index-pack (which
technically need not run in a repository) which algorithm it should use.

show-index will eventually learn to parse the index itself to learn
which algorithms are in use, so it is technically not required here.

> When having a global setting, would that override the configured
> object format extension in a repository, or do we error out?
>=20
> So maybe
>=20
>   git -c extensions.objectFormat=3Dsha256 init
>=20
> is the way to go, for now? (Are repository format extensions parsed
> just like normal config, such that non-RUN_SETUP commands
> can rely on the (non-)existence to determine whether to use
> the default or the given hash function?)

The extensions callbacks are only handled in check_repo_format, so they
necessarily require a repository.  This is not new with my code.

Furthermore, one would have to specify "-c
core.repositoryformatversion=3D1" as well, as extensions require that
version in order to have any effect.

My current approach for the testsuite is to have git init honor a new
GIT_DEFAULT_HASH environment variable so we need not modify every place
in the testsuite that calls git init (of which there are many).  That
may or may not be greeted with joy by reviewers, but it seemed to be the
minimum viable approach.

> There is a section "Object names on the command line"
> in Documentation/technical/hash-function-transition.txt
> and I assume that this before the "dark launch"
> phase, so I would expect the latter to work (no error
> but conversion/translation on the fly) eventually as a goal.
> But the former might be in scope of one series.

Currently, I'm not implementing the stage 1-3 implementations.  I'm
merely going from the point where we have a binary that does only
SHA-256 and cannot perform SHA-1 operations at all to a stage 4
implementation, where the binary can do either, but a repository is
wholly one or the other.

> > It can work this way:
> >
> >  - read HEAD, discover that I am on 'master' branch, read refs/heads/ma=
ster
> >    to learn the object name in 40-hex, realize that it cannot be
> >    sha256 and report "corrupt ref".
> >
> > Or it can work this way:
> >
> >  - read repository format, realize it is a good old sha1 repository.
> >
> >  - do the usual thing to get to read_object() to read the commit
> >    object data for the commit at HEAD, doing all of it in sha1.
> >
> >  - in the commit object data, locate references to other objects
> >    that use sha1 name.
> >
> >  - replace these sha1 references with their sha256 counterparts and
> >    show the result.
> >
> > I am guessing that you are doing the former as a good first step, in
> > which case, as an option that changes/affects the behaviour of git
> > globally, I think "git --hash=3Dsha256" would make sense, like other
> > global options like --literal-pathspecs and --no-replace-objects.

Right now, we always read the repository configuration when possible,
and honor that.  I'm not planning, even when we have a full
implementation, to let the configuration of input and output format be
modified by command-line options.  That's a configuration of the
repository in the current transition plan, and I have no intention of
changing that (apart from possibly honoring "git -c").
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvg2DAACgkQv1NdgR9S
9otyzQ/6AlW8HTi9vsYg+bl5x10wdynubBKqSd/jR68am8pV2YCq6y1ubmnE8cWs
DP98SmH7EmRyqeYSzw2Zw/nLZ/rEG3aryk3SkJaDK+skKAKJYq+4dJpReXtSiUR7
rP8HRkWPG0Mtbf9meqGlbXATtipMZ3MP9P1P3kdJBx3DWjkX/x5v60XsRnJOq2pr
2vxG+5QX1FW93nY5Gjl3T6uUDcvPDZvwbP7CNU70M6iJAuhthgphv01Mp4HPQ8NV
tH2PlVA6Xda+7MFcpNuuPHy8t1cusw43m95YRcXhqvrXuCuCqnnJkAuRB7A2WN0S
uvx6wSEDWXQcDfqZzJHFyWLt0VvI45S7gHx+jlM1sJNAexZeDH7DaoRGuhzRFibd
pMGEKDvkoauZfw03XGf9bEjm2AIAB8rPtiBu4LC7kk1asOVjqFxEDb7hHVcnxEVU
ywWGKNlrTxfK4yhfaZ5nX8cjsLo3kXGjA1cHGQChK9f4zv6Zcwm68JTxDCC6SUji
Do2Kgh3rF0njCkKtF9I52tfnNwQBQxfOEQng9ODk4VYwWc2X8hX3LY3LlWDJtS2Q
lDpzrPPHQeeCMDh00uy6MHwX/AL8zt9UHgFll4bDvoI1QYkItsLLoON70kIZrzAi
fINxkMdJ3ftTTfC5FFHibTmxOVwfmmEzP1VIoLbEVLNXzk1MtKc=
=/lUq
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
