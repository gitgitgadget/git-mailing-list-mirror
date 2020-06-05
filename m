Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B523DC433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901BD2067B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mr7T1TO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgFEAAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:00:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgFEAAo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Jun 2020 20:00:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C27026077B;
        Fri,  5 Jun 2020 00:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591315244;
        bh=d8e37qTSQCX6qetK0BaN08s/URKxEcFgvwMLo5fON7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mr7T1TO+96LHIVEtQTPvsi6lrg9td6eMPuTRQiIDmFqu4vP6JsXaAjn0cuhGP4q1Q
         cHE4Uc73maPndMjwZUT2qAhNvg0Vl/1ry394G46VKjkwJ9L64bMwtWkCMR1PHUPIUX
         QxdLIst3b5r0fm4sudLO6pontThjRw2dZo6pPgpUT04nArtAOcP1NhEppTuIItuVsT
         ezQOSQIYGo8HoMwClpPzxq869Hp7avVEKKEByZqJKv+tUBTKYjbyidgpraEIX7iedW
         evuKTqQkLyk6F223ZIOaeh5Xt/LW22ecE/0azxdEWeoGfZ0Zjy67csrSxFung1sxa6
         yoCDSOEQoMkv1BH9ujfQ9gs7WYLNEtO/KPy+ujEOCQ5ykOFH6XYn5YaIFv/o9oT1Y+
         q1LMKxicLKLZrLT3Im0EtO7ZCNbGHd/RacKnWMHRynhSED8op71gqK8RaGsHCDkPWi
         TUpue97KmbGx2P+PGVGJa3Echg770TXmD9L3t4b6c/L2widd+v7
Date:   Fri, 5 Jun 2020 00:00:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Change Native Windows shell
Message-ID: <20200605000039.GB6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
References: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-04 at 23:33:16, Steven Penny wrote:
> The Git pager is set up by the function `setup_pager` [1]. `setup_pager` =
calls
> `prepare_pager_args` [2]. `prepare_pager_args` sets `use_shell` [3]. Then
> `setup_pager` calls `start_command` [4]. Then, since `use_shell` has been
> defined, `prepare_shell_cmd` is called [5]. Finally, regardless of operat=
ing
> system, `sh` is called [6]:
>=20
>     #ifndef GIT_WINDOWS_NATIVE
>                     argv_array_push(out, SHELL_PATH);
>     #else
>                     argv_array_push(out, "sh");
>     #endif
>                     argv_array_push(out, "-c");
>=20
> The issue is, that it is possible to build a fully static native Windows
> Git [7]. A Git like this can run on a stock Windows system, with no requi=
rement
> on MSYS2 or Cygwin. So it doesnt make sense for Git to be calling `sh`, w=
hen a
> user may not have or need `sh` on their system. I think that on Native Wi=
ndows
> builds, that the Pager should be called directly, or if a shell must be u=
sed,
> then make it `cmd.exe` or `powershell.exe`.

This makes it impossible to write a configuration that works across
platforms.  CMD, PowerShell, and sh have entirely different quoting
rules and functionality.  The user would not be able to specify a pager
or editor with arguments portably.

In addition, Git supports the EDITOR and VISUAL environment variables
for editors and these always, 100% of the time, must be passed to sh to
function correctly.  It would be a bug if, when I used Windows, these
variables were passed to CMD or PowerShell.  People also use GIT_EDITOR
or GIT_SEQUENCE_EDITOR for scripting changes to git rebase -i, and these
also need to be interpreted in a portable way across systems, or
programs will break.

Finally, Git needs sh for some commands, like git submodule, git bisect,
git filter-branch, and others.  While there's an effort to replace a lot
of these with C because they don't perform very well on Windows, some of
them are highly interactive and unlikely to be used for scripting, so
porting them doesn't make a lot of sense.

If you really need Git functionality that doesn't rely on sh, you can
look into libgit2 and its assorted language wrappers.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtmLJwAKCRB8DEliiIei
gUNHAQDb4UuvzQiShDSbI4QnJgiSR4LyvZp4i7tgj/6v8aosWAD+MMRQQ9yrJc46
t4hgs7nP+AQ/RYIBvBWYEklaxAYZUAU=
=ho2D
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
