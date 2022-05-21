Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F00C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 18:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbiEUSkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbiEUSkC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 14:40:02 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E2A4666F
        for <git@vger.kernel.org>; Sat, 21 May 2022 11:39:59 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7F49B5A23B;
        Sat, 21 May 2022 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1653158398;
        bh=GdJ+KYNEf5qgtuUyOdu4agZhnbxemCTVkLAAyIkmCIE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DsOZvObs+6lnhIIZqBaFHXCET8howW1mSwmFYyf4iLMd76VzFGljXthNy9iWMQDHm
         wy9pLpaMCBLEOz7t6iznOJ5G61sijuc86Eb8xPkKvfKmb/J7xCyLuZSWdJb2xLMhHd
         hT+21w8bJ85vPKVzVTGX0sDIQis6Qej7dS9kwJsG/n874xMmoVKp+6fDmc8fwRbH9h
         Ns9k6kpGD9yLQyia1olml3r+gY5UVT1r8Pno/pmNo+wXOia/ZvN/bbyspX1839kYun
         RqXOCQ/9tOkZzjtQBbkEhNxGKKzLpdSkxdFc8h/3tXH0MvhU6xz8BvwFiulh7C33Mz
         jAUAOY3e0zaomRAz72x23AuXhP/1TLkp3fpSXCoE4MS8+jVffqEfyV43A+gcabXkyH
         XJO9CatdjvSdjnr7QXhRhU4Xqqa35Fj5h7I26/+o9TFNosHKAzYVPtZiaRSLvB3aG4
         CF4XJpFQIRRVz9AwSQ58cfFXfqiPcyCFY9Nr8/8eDxWLp+AxwTb
Date:   Sat, 21 May 2022 18:39:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     allejo <me@allejo.io>
Cc:     git <git@vger.kernel.org>
Subject: Re: bug: `git diff` implies =?utf-8?Q?fold?=
 =?utf-8?Q?er_isn=E2=80=99t?= a git repo
Message-ID: <Yokx/MyZHjGHRkoK@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        allejo <me@allejo.io>, git <git@vger.kernel.org>
References: <180dfb3d8d3.12352a818142651.7062268074453572353@allejo.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LC4MPX8M4BGXWMdn"
Content-Disposition: inline
In-Reply-To: <180dfb3d8d3.12352a818142651.7062268074453572353@allejo.io>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LC4MPX8M4BGXWMdn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-05-20 at 04:22:27, allejo wrote:
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> Change ownership of a Git repo to require `safe.directory` behavior.
>=20
> What did you expect to happen? (Expected behavior)
>=20
> If you run `git diff --exit-code` on a non-`safe.directory`, you should g=
et the standard error.
>=20
>     Error: fatal: unsafe repository ('/path/to/repo' is owned by someone =
else)
>=20
> What happened instead? (Actual behavior)
>=20
> I get an error message saying it's not actually a git repository even tho=
ugh it is, it's just not safe to work in.
>=20
>     warning: Not a git repository. Use --no-index to compare two paths ou=
tside a working tree
>     usage: git diff --no-index [<options>] <path> <path>
>=20
>     Diff output format options
>         -p, --patch           generate patch
>         -s, --no-patch        suppress diff output
>         -u                    generate patch
>         -U, --unified[=3D<n>]   generate diffs with <n> lines context
>         -W, --function-context
>                               generate diffs with <n> lines context
>         --raw                 generate the diff in raw format
>         --patch-with-raw      synonym for '-p --raw'
>         --patch-with-stat     synonym for '-p --stat'
>         --numstat             machine friendly --stat
>         --shortstat           output only the last line of --stat
>         -X, --dirstat[=3D<param1,param2>...]
>                               output the distribution of relative amount =
of changes for each sub-directory
>     ...
>=20
> What's different between what you expected and what actually happened?
>=20
> One error message implies the folder isn't a Git repo while the other exp=
licitly says it's not safe to work in and how to fix it.

While I agree this is not a good experience, let me explain why this is.
Some programs, like git status, must always have a Git repository.
Others, like git diff, may have a Git repository or not.  If they do
not, some functionality is not available.

The check for a Git repository happens during setup before anything
having to do with git diff is actually invoked.  By the time git diff
actually gets invoked, all it knows is that either (a) there is a valid
Git repository which can be used and is properly set up or (b) there is
not.  In this case, the answer is (b): you don't have a valid Git
repository because the permissions are wrong.

This could of course be changed, but it requires a bunch of retrofitting
throughout the code to save _why_ it's not a valid Git repository and
then print that later on, which hasn't happened yet.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--LC4MPX8M4BGXWMdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYokx+wAKCRB8DEliiIei
gZ5kAP9HkM8eVq50oWRNP74WX1WxNz3epRvqxwew9/d12xQ49QEArP/eFt5w3f0h
PWRRrTbXH2nlJR9SoErLA8M1MHDyiw4=
=YymD
-----END PGP SIGNATURE-----

--LC4MPX8M4BGXWMdn--
