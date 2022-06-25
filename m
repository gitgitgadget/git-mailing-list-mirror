Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A93C43334
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 12:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiFYMQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiFYMQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 08:16:55 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C795F140EC
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 05:16:54 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 213275A0E9;
        Sat, 25 Jun 2022 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656159414;
        bh=WuXGx3319Ht38KDWtsL0c97YQ3tUAKX2YyHqgUBSznk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Wq3qAjTX+tQxohTyxtRNOhezglb+jKeBVglVP+UaSLYT+7y4M9oYzFOcKYEI0xy9V
         AZ9iqL94n3RmwTA7NRJplwVkCHV/4eIy+OyQsFHK5cdHPMUK7sHeDGaw9ic3/lfDSE
         +ZrAk6J7auPq7oX9cqucY3QlmMQKA91YG98qBmQ+LGiDpmbKAv3mCul7tDRLPFGWVn
         lYJbvwTdTPw2xg/upQt0naQiVLlI3+hDVi1wro9Gi78gkoCV1NNJcHiNSf1u0A37pZ
         6H78xgCMk4H1GkT/PupxHrVPyNKaPbJiqK+wefhJykH3xQOP1eOzpwx3m5bYiN/tvP
         BCNeiaQlRoJfQsjGzdsHDqIyhvE0Tk+OYZ6wCamMva6sTjHFE14bi09wPk4tgiQ4Qn
         uHCPmB2k33y+lrPSXW9v/ecNJ3bZeD8O2faILjTsqlXBc6f7LdswxtbAhI4nfLH8I5
         YOlkzgiGhFKaEAkKFIwgUVd9aHxJQGpE9jVX3560UmbmiXftd1N
Date:   Sat, 25 Jun 2022 12:16:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Klaus Ethgen <Klaus@ethgen.ch>
Cc:     git@vger.kernel.org
Subject: Re: Git-Bug
Message-ID: <Yrb8tJDNxEJOuU+4@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Klaus Ethgen <Klaus@ethgen.ch>, git@vger.kernel.org
References: <YrbHPlJy/EW/Y+ON@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/qJ3MfKKmWyKqYCR"
Content-Disposition: inline
In-Reply-To: <YrbHPlJy/EW/Y+ON@ikki.ethgen.ch>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/qJ3MfKKmWyKqYCR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-25 at 08:28:46, Klaus Ethgen wrote:
> Hi,
>=20
> since some versions I have the following troubles with git:
>=20
> I use vcsh to manage my vim config files and pull/push them from one
> machine to others. That was working great but now the push refuses to
> work as it state the working tree is unclean even if it is clean:
>=20
>    # on the server:
>    ~> vcsh vim config receive.denyCurrentBranch
>    updateInstead
>    ~> vcsh vim config core.excludesfile
>    .gitignore.d/vim
>    ~> vcsh vim status
>    Auf Branch master
>    Ihr Branch ist auf demselben Stand wie 'origin/master'.
>=20
>    nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert
>=20
>    # on the client:
>    ~> vcsh vim status
>    Auf Branch master
>    Ihr Branch ist 3 Commits vor 'xxxx/master'.
>      (benutzen Sie "git push", um lokale Commits zu publizieren)
>=20
>    nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert
>    ~> vcsh vim push
>    Objekte aufz=C3=A4hlen: 10, fertig.
>    Z=C3=A4hle Objekte: 100% (9/9), fertig.
>    Delta-Kompression verwendet bis zu 2 Threads.
>    Komprimiere Objekte: 100% (6/6), fertig.
>    Schreibe Objekte: 100% (6/6), 821 Bytes | 821.00 KiB/s, fertig.
>    Gesamt 6 (Delta 4), Wiederverwendet 0 (Delta 0), Pack wiederverwendet 0
>    To xxxx:.config/vcsh/repo.d/vim.git
>     ! [remote rejected] master -> master (Working directory has unstaged =
changes)
>    error: Fehler beim Versenden einiger Referenzen nach 'xxxx:.config/vcs=
h/repo.d/vim.git'
>=20
> `vcsh ... command` does the same ad `vcsh ... && git command`... vcsh is
> a simple script that sets GIT_DIR to ~/.config/vcsh/repo.d/....git. vcsh
> is used to manage config files in $HOME but not the full directory. In
> this example, it manages .vimrc, .gvimrc, .vim/ and .exrc.
>=20
> As you can see, there is no unstaged changes but git tell me there are.
>=20
> I tried different things but failed to tell git that everything is clean
> and that there are no unstaged changes.

Do you have files that would be unstaged after you pushed?  Are there
ignored files in that directory that would conflict with what you've
pushed?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--/qJ3MfKKmWyKqYCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrb8tAAKCRB8DEliiIei
gSbGAQCZuwTA5w1to7ZAhx0HgiTV16TiRlgXqhSHVKPETO0J4AEA45pNK1xirrpZ
pmJh6mY+CjLmMQjthnY4QQP/PPfW1QY=
=AdoT
-----END PGP SIGNATURE-----

--/qJ3MfKKmWyKqYCR--
