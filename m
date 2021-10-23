Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B136C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 12:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D260FDA
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 12:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJWMEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 08:04:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39596 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230236AbhJWMEp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Oct 2021 08:04:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B28A60473;
        Sat, 23 Oct 2021 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634990516;
        bh=+2rWOZse0Ny9c0Ew0iVCRfIXwizSpQeTcZ+tYOJTTaw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TX9qm174dKNXqHWRQEDiVHmDWLn0egBsODsrRmvkplV8s2MIZqbXEUuVUE9V8fSLI
         mMx/YgxzT9PCpZRt8apupGOiEI7v3fjjYiJAa9np7jRNMk5/RJtInDJrv7swbFmOKn
         u7vsZslmsxWOdzzq57WYuqFHlPgZnMtQdHgnNJnPzxQsuULsG6CKgij1DnNyKCEgie
         NRwgzGGDo4AQLysuCBRQLEgkZJHntCCyql/7orLPTrcCtv7VQvn66EBI0KbbPRJEoC
         YddjhTggivRHGMrEiUmeYLJ00ZrOL2NWQDnGlIwGq42MTWUq6Y4uLUsgyjzOAdnvaX
         0XvFsJEkbbLttBW+13D7+DR/vGXjZgFWD1eTN73RLKpMD7Zc2b8u4UxPEsEyqU5b81
         TzmMhhkyQxlu82cNc8BNw7PgHDz+5ycQ9kaFCBqYHcFgBxgDDTHMGJJkAuv5ZZjZWG
         0JLuD+5AxqVM7VUcV2zOZakqjItXAJHzPpsF2GYfiyw080Sjb+/
Date:   Sat, 23 Oct 2021 12:01:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Justus Ranvier <justus@opentransactions.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Rene Kita <mail@rkta.de>, git <git@vger.kernel.org>
Subject: Re: gitignore as symbolic link
Message-ID: <YXP5rZT5IgFcMZs0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Justus Ranvier <justus@opentransactions.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Rene Kita <mail@rkta.de>, git <git@vger.kernel.org>
References: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
 <YXLro/8c1Feg6TcN@kitchen>
 <CAHd-oW50puNCrYTQhR4qffgtP6-wJerWLhmhCV+nYcLVNu+CBg@mail.gmail.com>
 <fa4b28b1-9b5e-0201-5afe-2e8f294fa9b4@opentransactions.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dx/RTebC84F9Am6u"
Content-Disposition: inline
In-Reply-To: <fa4b28b1-9b5e-0201-5afe-2e8f294fa9b4@opentransactions.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dx/RTebC84F9Am6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-22 at 23:55:16, Justus Ranvier wrote:
> Suppose a person is managing N repositories. Would that person prefer to
> maintain the list of files to ignore for every random IDE that anybody who
> joins the team might want to use in:
>=20
> a: One place
> b: N places

Developers should be responsible for ensuring that their own editor's
temporary files are ignored.  For example, I use Vim, so it's my
responsibility to ensure that I globally ignore swap files using
"core.excludesFile" or that my editor is configured not to produce them.
(In my case, it's the latter.)

As you point out, it's unsustainable to have to manage a list of the
detritus of every possible editor.  What if I had decided to use an
editor that is not very popular, like ae, joe, or acme?  Should every
project be responsible for dealing with my uncommon editor, or should I
be responsible for my own editing hygiene?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--dx/RTebC84F9Am6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXP5rQAKCRB8DEliiIei
gYSdAP9HvE6FcjI0onHRNeKPCI3zVQ8/IOL2BZ8G6TjxJeqXoAD7B1jVl+6viO5k
2/gsxVunoctqsoSNkL54snUwRQDsuA4=
=5mXy
-----END PGP SIGNATURE-----

--dx/RTebC84F9Am6u--
