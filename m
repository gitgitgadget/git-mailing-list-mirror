Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19321C3F68F
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 03:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C467C24682
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 03:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xbz8IUMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLTDDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:03:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbfLTDDH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Dec 2019 22:03:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5623460446;
        Fri, 20 Dec 2019 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576810985;
        bh=ly/AIi9Nf3yhrRU1MFBWRc7sMc3l/gbW7XQpxVVntc0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Xbz8IUMqr6XyzWPYdxOybnyHdlCINxAUGPSt4fS8AGqoIJD78ITXlfFki4laWHchr
         O8RVXH0AJ3d6Y58nJg1RC6KafAWIW4Rx3rzg4ZeNC9CQKg1WundaX570h32w31FYfD
         UgJ8EDu6yd60zqzmFB6mYYJtwESqGxnGi1ISYlBvaVJDoOqbILa11mBbK1rmCHw+4k
         FOxr9j6gMCupWVFMwA9QKgBx01sJGWSKqB1QZfBh4JzeBUT0Bd/WAzSC8D7SSAlR/q
         sWCDpWiPGlgt9XCXzYjTBhlwFgo1owehmw9a0on7G7wJ5pDvs/V1VhlZBC0nCPZjap
         av0/EaKG9sSrp0MmaAciyleHL9pjlI5xptV+jMYBPZju/zOQSda7XKNs81pqeGX+B4
         1iB6WKfImM1mzSl5KByHi4zgM21IC/4KPUhwgXYgN8pr6uvoUc///5yUgu0v856fmM
         OGY2zxPgOdBDbWU9yiTcpdy3QDe0goP50qxDPiEt6S9aqnF/KmW
Date:   Fri, 20 Dec 2019 03:02:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Scott Richmond <scott@brightrockgames.com>
Cc:     git@vger.kernel.org
Subject: Re: Ability to ignore EOL changes for certain projects
Message-ID: <20191220030259.GC163225@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Scott Richmond <scott@brightrockgames.com>, git@vger.kernel.org
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-18 at 11:10:27, Scott Richmond wrote:
> The Problem Domain
> In certain dev environments (Unity3D projects) there is (AFAIK) an
> unsolvable problem where some files are often modified with line
> endings that aren't the native system or not the committed line
> endings for that file. Secondarily, in this case line endings don't
> matter - Nothing in the dev environment "cares" which kind of line
> ending is used.

I'm not sure this syncs up with your statements below.  Typically,
programs that do editing of text files either (a) write the line endings
that the file started out with or (b) write the system line endings.  If
you set the appropriate files with the `text` attribute in
`.gitattributes` (or use `* text=3Dauto` if appropriate), then Git will
always write in the system line endings and convert internally to LF,
and programs that do either (a) or (b) will work.

Yet it sounds like you have development tools that don't do either (a)
or (b): they write in some fixed line ending, and therefore care very
much which line ending is being used.  In such a case, you could
write (for example) `*.yaml text eol=3Dcrlf` (or `eol=3Dlf`) if you always
want them to do that and Git will convert to those line endings and
store in LF.

If the problem is text editor settings, you can use a `.editorconfig`
file, which is a cross-platform text editor configuration that can
specify line endings.  Most text editors can be configured to honor such
settings, although it may require a plugin.

If your problem is a shared Windows / Linux environment like WSL, you
can set `core.eol` to `crlf` in the repository and things will work.  If
you need settings like this, you can even set them up appropriately for
the system using a make target or bootstrap script so you don't need to
do that by hand on each system.

If you do this, then your tools will write the same line endings as are
checked out, and files won't appear modified.  You can see how Git
itself uses this to set up files appropriately for different systems.

The only case this wouldn't work is if the tools wrote some random line
endings depending on an attribute other than the OS they're on, or if
you had multiple tools doing different things.  If that's really your
problem, then yes, you'd need a new Git feature.  It is of course
possible to use a filter to strip out all carriage returns, but that
doesn't prevent Git from showing the file as being modified.

What I've proposed, of course, requires some setup work and
configuration.  It isn't trivial, but it does work for a lot of projects
already.

> Solution Request
> It would be fantastic if we could tell Git to stop caring about EOL
> changes on a per-repo basis, with the effective output being that git
> status shouldn't show changes for files with differing EOLs.
>=20
> I'm experienced with Git, though I am not expert enough to consider
> creating such a change myself - It is unclear to me just how
> complicated a change may be. However maybe I could look into it if it
> was made clear that this improvement is possible and has no serious
> side effects.

I'm not sure how such a feature would interact with how Git operates
when it re-reads the index.  It isn't 100% clear to me when data is
filtered through various text filters such as EOL filters.  All the
filtering I've used is one-to-one, and therefore any modification of the
file contents necessarily means that the indexed contents have changed.

If Git does apply such filters when refreshing the index (such as
happens before `git status`), then such a feature would be relatively
easy to implement, although you'd incur a performance penalty when
changing the EOL of a file, even if the file were otherwise identical.
I suspect it would make the most sense as an additional value for
`core.autocrlf`.

If Git doesn't apply those filters, then there really isn't a way to do
what you want without fundamentally changing the characteristics of how
Git operates on the index, since it would still show files as modified.

Maybe someone else can comment on the feasibility of this better than I
can.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl38OeMACgkQv1NdgR9S
9osjqBAAp7EcfZvHhfyCwx1+FdBr+18F9Rd3fcSVq4a87RP2pO/dxHrTkfEQaHD+
ROVki98lFJWytVXPc6aQaoHG0XMIYLKBOVix3xVuWk5yGMIUnOGReV/YxdsB4JLP
6WBO/tqozJLs+hqvFNfDuQRisB29J/ywM1F90xdtkdkv3+7GiMTffCIHF61m9o5I
Lua+E2YqfjSxed1aLw/vOarbSOHHQ2R4T/h/jrRYjttgN7/8I19jKhZ7hXmkYvkM
0bsVzmwG25MnQt78H1ir/zE3mbK5+qyYR6dwE9x0bjybiRkB1aicOBh+xaxBIMSw
+mU7SuXZYpkN6FThe3nN2uPp7w6arqTmCkQ6AMOtwOxe6S4hTG6TndXkSaTEw9e+
KSetLnAYU0THLsA+kRdFhcavysunnp7Z8ixruVXHSOqDz6z/FKzDLP230fWoPBwx
a7jZ4SHRrPYME1tyvvW7DWJarjcVN7AEtEldF1HAVwHrh2XBHXF5LusN05QiDpN5
Yp4B32MfdVROFiUuV+aU4gMP86DYCBtyVIWqBn7ykPqXPMhyzNNSSF/qCaWJywRI
1WNjYvN+rBJDQH6q3fdR8dWErciUhZ+3YhTG/aA0jOiE5lxy/GwyzN18/dPI1VaE
EFxgnYJHEAxcJwqN/nzqw89wWnkBdMxwUzc9Fty+tqOrjTOVHmU=
=BsQ5
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
