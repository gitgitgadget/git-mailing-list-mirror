Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F71C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 22:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB661212
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 22:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhHVWIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 18:08:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48630 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230091AbhHVWIa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Aug 2021 18:08:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7EF836042E;
        Sun, 22 Aug 2021 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629670068;
        bh=KiuGog92R+mo7r07t12qvC7Vk8OVC6awgQTY6HSlfNk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yTwR4dgPzjk45JLbp7vhOr4kowJlx7poxO2/1Fos7PYmkjTi9SQUUG39pZ4Txvkqz
         MfVowGrgnmtaXxXyovZNjophqMS4lRGSItXN0KmFFgR73wVDaBi1PACsm8iXJzu5Lz
         z4wN6dexO+5kV4PMUQtP4ZkSVnEclmeponsKGA9fqYwAn67JcakudnqgzGIy+8Fy5n
         UC9/ZHsH+1Xy56wEaGd6S5d3+MOWJUof5cYbRZO1zLmEok0Hx4tXFT1WX0t37S8KZ9
         IRK6LUeIv/bnL4OYOHjzmiCmUUi4LcFC6+KvudsXlVzSlm005a4rIyZX952Gn0axXI
         IvfcnJ56Unl9b5goCFB/ed8wDJ1In/cwa09F68zRJgKtGgHATb1gCxcHUj3LvwB6NK
         VoFS6r9Co+bFKSBDsmM7uVLXW/U15tSiSixLv/Xyx2rSDuHwRmVXUoMiMAPOL9kIP5
         l2uFNZa1ioN8IqEp4sVJNRG3iDAb1JOm72KMnilzXkVetJ4dcT9
Date:   Sun, 22 Aug 2021 22:07:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Rafael Santiago <voidbrainvoid@tutanota.com>
Cc:     Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Give support for hooks based on platform
Message-ID: <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rafael Santiago <voidbrainvoid@tutanota.com>,
        Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
 <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
 <Mheyv1D--3-2@tutanota.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vo3ImlIhhqRttfNQ"
Content-Disposition: inline
In-Reply-To: <Mheyv1D--3-2@tutanota.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vo3ImlIhhqRttfNQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-21 at 23:11:27, Rafael Santiago wrote:
> In my opinion "binary hooks" (hooks that execute specific binaries not
> present in the system as a default tool) should be versioned and built
> as a support tool into the repository or in the worst case downloaded
> from somewhere, even because versioning binaries into git repos is
> considered a bad practice that could make bloated repos.

Yes, I agree binary hooks should not be checked into the repository.

> The point is that in many cases a dependency with a script language is
> created only to make the hook actions portable from a platform to
> other, but what this script in its essence does is a thing that could
> be done with basic tools delivered with the current operating system.

Then, in general, it can be done in a shell script containing an if-then
statement per platform using the native tools, so I'm not seeing the
particular reason that this series is necessary if the hooks being
executed aren't binaries.  All systems on which Git runs must contain a
POSIX-compatible shell.

Can you explain the rationale for your proposal in more detail so that
we can understand why this change is necessary?  Typically this is done
in the commit message, but I don't think I understand why you want to do
this.

> There is no problem on using cygwin on windows, you should use
> standard hook and do all the effort to make it unique for cygwin
> environments and true unix boxes (in other words: you would continue
> doing what you are doing, because it attends yours requirements).
> Notice that everything that have been working will stay working as
> before. Anyway, if cygwin becomes a point of incompatibility at some
> point, you could use the "_windows" version by coding your "cygwin
> script" there.

Right, my point is that your commit message proposes using "windows" for
Cygwin.  The patch doesn't, but your commit message says that every
version of Windows is considered "windows".
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vo3ImlIhhqRttfNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYSLKrQAKCRB8DEliiIei
gTcaAQD+hOCkNiNsSPMRbscxwgy1xaVrRrnHepfwL5tOukqtnwEA2IAadlxWUN3K
Fs0dTkl7AoGqoeLEkfAIKR1NHIfVVwg=
=qECC
-----END PGP SIGNATURE-----

--vo3ImlIhhqRttfNQ--
