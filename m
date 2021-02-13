Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD85C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 17:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FBF64E23
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 17:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBMR0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 12:26:35 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47734 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhBMR0e (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Feb 2021 12:26:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 747E160B15;
        Sat, 13 Feb 2021 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613237152;
        bh=kBgByrq6KzDXOWsMc6kZisyk/p2zxZ8TuxSuzQzcoa0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TWqoITL/Zli8uBfgz7tCUSpb14dnVFyDC3HVARz2BAYJCxjDsYaDV3XGTbC3IrfjL
         uTjoRttUBCryIDdMe6uCg7InSPYVWsKjgqWNBPO0GuDFm9ITWsguoYhIOS0byLxkaq
         /5EjEzNwzNIR779HFL3E972WCf7MI7dSjzPe560VeAcjj9HisorFFmfZylQ39hjNVP
         QUOAN1svcGsqW3sokRuTz42kgOcam7DRJuOSoZ+Ir1w4l/oI69bBmYSAFlSSPnfH/n
         Z4DlvxJF9dn2ILrFBNn3VPACc0pcq8TbsdM8+d/j39YTMuGGqquItwWS5mKh49E6rq
         xhLqoFgk9U3BuqpKZM4qvBqm4brwOZZO3L+Zsmw5I7HJUDmzZoclrf/OL2g/FBcmSt
         PQo6Gln6luhjHTz+Fd054TKfX4tFgCVTlVFwXdU6INa0L1GKKvmppYo2Usx5UOnrN4
         pJxg49j2qF1USrypAiM0DZbCjcrpygkXtBSm+CUcWNt35vvPgvC
Date:   Sat, 13 Feb 2021 17:25:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     PANEL Christian <ch.panel@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: git ability
Message-ID: <YCgLmgrKCV9AIzMI@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        PANEL Christian <ch.panel@free.fr>, git@vger.kernel.org
References: <24e39c2c4b7b86aa4a671601a069eaee767a63fb.camel@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VcopljOJSJZ5nXDQ"
Content-Disposition: inline
In-Reply-To: <24e39c2c4b7b86aa4a671601a069eaee767a63fb.camel@free.fr>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VcopljOJSJZ5nXDQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-13 at 13:25:03, PANEL Christian wrote:
> hello,
>=20
> does git have the ability to handle a repository on a removable disk?

Yes, this is possible.  You should access it from only one operating
system at a time.

I also strongly recommend that if you're going to do this across
operating systems, you use UDF[0] and not NTFS, FAT, or exFAT for this
purpose.  Linux can format drives this way for use across OSes.

> here is the experience I had:
>=20
> I have a project that I manage on a removable disk (therefore with a
> ".git" directory on it).
>=20
> until now I did "commits" and "push" on the server from windows10.
>=20
> I made changes to the source and made a "commit" from linux (on the
> same computer). Git asked me again for my username (email and user
> name): I then thought that these were not stored in the ".git"
> directory

These settings, user.name and user.email, _can_ be stored in
=2Egit/config, but _usually_ are stored in the user's home directory,
which will differ between operating systems.  You can use the "git
config" tool to set them appropriately if you'd like.  I personally sync
my dotfiles across machines, which includes .gitconfig, which is an
approach many others use as well.

> I then saw a new branch called "linuxcompatibility" appear.
>=20
> I would like to understand.

Git doesn't create branches unless requested.  It's possible that some
other tool on your system did.  For example, if you're using a file
syncing service (e.g., Dropbox or OneDrive) to sync data, that's
definitely not recommended and can cause problems like this.  If you're
using WSL instead of a true Linux system, that data could also have been
created by Windows.

It's also possible that this branch already existed on the server and it
may have shown up as a remote tracking branch with "git branch -a", in
which case attempting to check it out may have created a local copy.

Without more details or output from a program, it's hard to say what's
going on here.

> I thought to myself that I would then merge the "linuxcompatibility"
> branch to the "master" branch and push it all back to the server.
>=20
> if that went well with me, on the server the branch
> "linuxcompatibility" remained.

If you want to delete a branch on the remote server, you can do this:

  git push -d origin linuxcompatibility

If you want to delete a branch locally, you can do this:

  git branch -d linuxcompatibility

[0] https://en.wikipedia.org/wiki/Universal_Disk_Format; v2.01 is
recommended.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--VcopljOJSJZ5nXDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCgLmgAKCRB8DEliiIei
gYIYAQDsnXEQCMFMeL+I/HPLCms2W2+yDIB52sRMsSQZ17KMVAD/YnsiofIRaUi0
8xmNOXDRk+NmxB4FQdWXvYO+IOsz/Q8=
=0Ibl
-----END PGP SIGNATURE-----

--VcopljOJSJZ5nXDQ--
