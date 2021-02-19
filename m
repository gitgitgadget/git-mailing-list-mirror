Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE613C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D26564E38
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 22:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSWhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 17:37:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52056 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhBSWhZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Feb 2021 17:37:25 -0500
Received: from camp.crustytoothpaste.net (unknown [97.105.19.220])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5FD160DF4;
        Fri, 19 Feb 2021 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613774173;
        bh=6SMTA/PaKC07SlZmJVe5xMPLvpOVf97OPlurCiCfFdw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tu70BNcFgNpRlvx0AkSncYShaUefs+0zynKesIkXonkitSxuAgKzDI9+QQNuaNdaQ
         uRZhEYmKqB5dFlBS4zSU8C+ilareqyT5gDpZ7W3LrlzyH7oNXXtVAWAW6P8xUzcLfX
         pq0XE5pt9NAckOgPhMTAfjMSmrbrJi7naaMl+mwrhD02ZmhfmR+FxwYHpmQVD4iYFt
         z03naM4niXCzsCTF08+j9vVyPMULU1o2iqEPIpXYkNcI2qDdWq8Wxx6Ql1AJUw4oWJ
         U7js0bvC/H4n+LVCHDI4UYzAvUGTyZK/QZbF62PzJqcMmTbgqo+qwdLrjULcHLxdX0
         +9NjGXTrzGOcqu7s6KgtlJWaA/YKIxmu2EeRGAsMG3/t7xUQ++bn9UOwWXd/AfYOnI
         +XKPLfA0lhRHCyzhDJB7AsnWanARjL0NdJL6yT5CstirfE0OIqk4vleFtubOmhwYR0
         SNVG/Mz/D93hobKbZB3iMwN8fxWxxIEGqfkFINLyV3Nc8J4sJz2
Date:   Fri, 19 Feb 2021 22:36:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andrej Shadura via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH 0/2] Add --no-filters option to git-add
Message-ID: <YDA9WjWOjkqlsALc@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mlB1r3e00IglsYfs"
Content-Disposition: inline
In-Reply-To: <pull.880.git.1613758333.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mlB1r3e00IglsYfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-19 at 18:12:11, Andrej Shadura via GitGitGadget wrote:
> It is possible for a user to disable attribute-based filtering when
> committing by doing one of the following:
>=20
>  * Create .git/info/attributes unapplying all possible transforming
>    attributes.
>  * Use git hash-object and git update-index to stage files manually.
>=20
> Doing the former requires keeping an up-to-date list of all attributes wh=
ich
> can transform files when committing or checking out. Doing the latter is
> difficult, error-prone and slow when done from scripts.
>=20
> Instead, similarly to git hash-object, --no-filter can be added to git add
> to enable temporarily disabling filtering in an easy to use way.
>=20
> These patches:
>=20
>  * Add new flag ADD_CACHE_RAW to add_to_index()
>  * Add new flag HASH_RAW to index_fd()
>  * Make git hash-object use the new HASH_RAW flag for consistency
>  * Add tests for the new git-add option.

I'm interested in your use cases here.  While I agree that this is an
interesting feature, it also means that practically, a user who checks
out a file that's added this way may find that git status marks it as
perpetually modified until a properly cleaned version is committed.
Moreover, even "git reset --hard" won't fix this situation.

We see this problem extremely frequently with Git LFS where people
change the .gitattributes file but don't run "git add --renormalize ."
and then end up with this problem.  However, it's not limited to Git LFS
in particular; anything that uses filters, working tree encodings, or
end of line attributes can be affected.

So I think that while this might be a useful escape hatch for users, I
definitely want to see a compelling rationale for it and a big warning
in the documentation and an update to the relevant entry in the Git FAQ
before we accept such a patch.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--mlB1r3e00IglsYfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDA9WQAKCRB8DEliiIei
gQWfAQCEXan4woKj6lQaIFHmMUzJEPPH1xzZ9VNO9bVUOk6WDgD/bJ7cLSmmbWsZ
VhZ+eDzSWGBdSG+SONPydienLaar/AI=
=D9QW
-----END PGP SIGNATURE-----

--mlB1r3e00IglsYfs--
