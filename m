Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872CC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7012054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ISdC8s6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgEMXom (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:44:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38342 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732456AbgEMXol (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 19:44:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 60CCC6044D;
        Wed, 13 May 2020 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589413480;
        bh=uaI2lysmAGVOxDq/LpTfkuj6YJ1TZGy90oY/eUvkUAY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ISdC8s6h+p+uJcLXFyNK31hYvULfol5w5W6pTpV7f4lihyPiGB+A3qRnTcy2LT1iw
         3fd21c111d1ZcB7X3XDuODibj/iHgx8E2Xma+Xs/4STs+SNkmXPhUbe2jotOCKgAKi
         H6BUkcnPx6CkUCmwaMNX0bT1/P0Oo8/gy+9vRXMbPWBv/oQNSdPdMEO8iXTX0Uy7lh
         ON2XxOyF565Tnrg527IivvotbZ8fksSr3FZLrP8X/OtUtuTiyMzuKT8FLJazLix2ms
         SFStNmQ11R/mY1R8OaVF6gBe8i+iYHBAa4ppRs4DwwcDMfIIe35lRetqVmDRUBUZiZ
         /7I2K3XzCmGaMxPi1FdxL5A4EAUJO2pYDwHpNf3uts61M6iX8uPMyVXoCP6NVwoYQq
         C+FGXM62gEjUKbDkmevRReK+DKYRJnUcINKFX3OW/7sKbO/zaUmNBoUlJc3eBSeGN1
         phqooIIw6oJKMLoCC3+XvWjf8jOFWzGnmGU66JJTlBrwpYloexO
Date:   Wed, 13 May 2020 23:44:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [PATCH] fetch: allow adding a filter after initial clone.
Message-ID: <20200513234435.GG6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Xin Li <delphij@google.com>, git@vger.kernel.org, jrn@google.com
References: <20200513200040.68968-1-delphij@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <20200513200040.68968-1-delphij@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-13 at 20:00:40, Xin Li wrote:
> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  builtin/fetch.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3ae52c015d..e5faa17ecd 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1790,8 +1790,16 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen =3D 1;
> =20
> -	if (filter_options.choice && !has_promisor_remote())
> -		die("--filter can only be used when extensions.partialClone is set");
> +	if (filter_options.choice && !has_promisor_remote()) {
> +		char repo_version_string[10];
> +
> +		xsnprintf(repo_version_string, sizeof(repo_version_string),
> +			  "%d", (int)GIT_REPO_VERSION);
> +		git_config_set("core.repositoryformatversion",
> +			repo_version_string);
> +		git_config_set("extensions.partialclone", "origin");

Some things stood out to me here.  One, is this setting up the
repository if it's not already created?  If so, we'd probably want to
use one of the appropriate functions in setup.c.  Even if we're just
changing it, we should probably use a helper function.

Two, it isn't necessarily safe to automatically change the repository
version.  Keys that start with "extensions." are not special in format
version 0, but they are in format version 1.  I can technically have an
"extensions.tomatoSalad" in version 0 without any special meaning or
negative consequences, but as soon as we change to version 1, Git will
refuse to read it, since it doesn't know about the tomatoSalad extension
and in v1 unknown extensions are fatal.

My example may sound silly, but since extensions can be set in the
global config, users could well rely on v0 repositories ignoring them
and having them automatically turned on for their v1 repositories.  (I'm
thinking of the future extensions.objectFormat as something somebody
might try to do here, as dangerous as it may be.)

These aren't insurmountable problems, but they are things we'd need to
check for before just changing the repository version, so we'd want to
stuff some code in setup.c to handle this case.

Third, I'm not sure that "origin" is always the value we want to use
here.  At a previous employer, the upstream remote was called
"upstream", and your personal fork was called "origin", so I'd have
wanted upstream here..  We'd probably want to use whatever remote the
user is already using in this case, and gracefully handle the URL case
if that isn't allowed here (which it may be; I'm not that familiar with
partial clone).

I also agree with Junio's assessment that you'd probably want to explain
more about this feature in the commit message.  For example, I'd want to
know what this patch does and have some idea of how I might invoke this
feature, why it's safe to change the repository version, how one sets
the remote for fetch, and pretty much answers to all the other things I
asked here.  Even if I understand these things now, that doesn't mean a
future developer will in six months' time, and mentioning these things
in the commit message helps leave a note to them that you considered (or
did not consider, as the case may be) certain issues and helps them
understand the code as you saw and wrote it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXryGYwAKCRB8DEliiIei
gUIsAQCQo3MSHk9y91MC1I+43MxJLLyIIhLnJTH9Y4cbVtWJigEAxYBFpG9gFp17
KkmwOgYxyMlIa21EOeN5OtC5fgDVSgI=
=lVqj
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
