Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E476820248
	for <e@80x24.org>; Sun,  3 Mar 2019 00:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCCAZu (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 19:25:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfCCAZt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Mar 2019 19:25:49 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:a4e9:9ba4:4fd2:4493])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF7BA60479;
        Sun,  3 Mar 2019 00:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1551572748;
        bh=Ox8vAB+qRKmZYMX3N7H1NRszBYWdyi7R9RD7b1IIgvY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n2KmlsMciIIWEHVcmSTn61jes06g+myvvGHPZ1Ixf5jYjQGqbGNJLhz9tIAAMxh9d
         diHP7Hde1W6flg0bTLwOgcYLrZLTnjy0fhQh5nEU7iesk+U176ecxn7jS/Pl/LXScB
         cSxIKM9xT7uKm6tW9HyAaZvAH71ODc6H0dXjlH0NoEjlORWG4PazVTae5cSR1LY424
         JANzCy9TvxmE7N7bKFseYs6E6Ryly4Q5R++Ck8HgDugARjCbzR51IgHWdI/DEDw2dT
         pLi0C59m/92W1ii/U1k8/wwcmj+EHczWPUHzfp1qeFzCfeUlUQ7/g0k7Uopp9u5L9V
         eXkQWLESdHG1//xueUCV9B2j8tGgqgZzKnkyeSJBgp24KZGIwKbAaj62YVNKtMp7O5
         IqPHnno3wTVot3RzhyLuPzRXzXAs39i9azI1qnx2OOW3dLKlVO8o0FaZ2Lj4PmyOrI
         0ZwednTaUaSZkMMRhwJYfvpZIvRrpBPrwvX7Dhgs8aojPlXMvlY
Date:   Sun, 3 Mar 2019 00:25:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Wendeborn, Jonathan" <Jonathan.Wendeborn@bruker.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fast-import fails with case sensitive tags due to case
 insensitive lock files
Message-ID: <20190303002542.GG601925@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Wendeborn, Jonathan" <Jonathan.Wendeborn@bruker.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ceb9b34681c14d9ab2a33ba909b5ca75@bruexc101.brumgt.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline
In-Reply-To: <ceb9b34681c14d9ab2a33ba909b5ca75@bruexc101.brumgt.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 06:19:48AM +0000, Wendeborn, Jonathan wrote:
> Hi,
>=20
> I have a problem with fast-import on an NTFS drive: If I try to import ta=
gs which are identical apart from their casing a failure due to identical l=
ock file names occurs.
>=20
> I am running git for windows 2.15.1.2 x64 on a Windows 10 machine (10.0.1=
5063):
> $ git --version --build-options
> git version 2.15.1.windows.2
> built from commit: 5d5baf91824ec7750b103c8b7c4827ffac202feb
> sizeof-long: 4
> machine: x86_64
>=20
> MCVE:
>  (echo "commit refs/heads/master" &&=20
>  echo "mark :1" &&
>  echo "committer me <> 0 +0000" &&
>  echo "data 0" &&
>  echo "" &&
>  echo "tag tag_A" &&
>  echo "from :1" &&
>  echo "tagger me <> 0 +0000" &&
>  echo "data 0" &&
>  echo "" &&
>  echo "tag tag_a" &&
>  echo "from :1" &&
>  echo "tagger me <> 0 +0000" &&
>  echo "data 0" &&
>  echo "") | git fast-import
>=20
> Instead of having 1 commit with two tags ("tag_A" and "tag_a") I get his =
error message:
> Unpacking objects: 100% (4/4), done.
> error: cannot lock ref 'refs/tags/tag_a': Unable to create 'C:/tmp/.git/r=
efs/tags/tag_a.lock': File exists.

The reason you're seeing this error is because refs can be stored in the
file system. In order to update a reference, Git takes a lock on it, and
as you've seen, Git can't take a lock on the same reference twice.

It's known that multiple references that differ only in case can't be
stored in a case-insensitive file system, and there is a design for a
different system (reftable) which nobody has yet implemented in Git but
does not have this problem.

Even if we accepted this situation in fast-import, we'd destroy one of
your tags, which would be undesirable.

Sometimes this happens to work because when we pack references, we store
them in a file instead, which does not suffer from case-sensitivity
problems.

Right now, you have some choices:

=E2=80=A2 Volunteer to implement reftable.
=E2=80=A2 Since you're on Windows 10, set your Git repository directory as
  case-sensitive.
=E2=80=A2 Use Windows Subsystem for Linux, which is case sensitive and crea=
tes
  directories with that flag (even on NTFS), to do your import.
=E2=80=A2 If you control the fast-export output, adjust the arguments you p=
ass
  such that the output does not contain one of the offending tags.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlx7HwYACgkQv1NdgR9S
9ovCzQ/+IJOnFF80u9QbMdf2RShin4tzBXpj1SLs96TDQ6Q4tXgVDJSiy92LZ2CS
S6Tifta1Z1vok2jedJz4Nr0LPjoXP2Z8N2Nu+evnvTDc4ZK975As6g96Z8dmdb+Y
L6DlmAZgWae8mwBNfN1twyW9CPiQ2Bt30Tm/3N5STruaBRkrfkTgqq2ppRil2w3w
A/+h3PRKMOGx8UOTXaxi6GDyv4ZIG5IQhflWCNbHzAdaNcoZggCycSOhADmMdOyf
YjeZisARsX2EdJ2wYBHo/bkH97qIRsr5TUx3y33j3RGVMAfsHpR7p1xOJ/NQhQ7N
p72PLpYslrsS8XsoQ/wRaW7Np8TIYmt53/CshWELoYatI4fjU0AkvL85AIXNvb4m
okfE7U5b4oO9VGU0EXrt6eetVSpdS0h/I20WoP0tMfZ6m4h/CBgOUUVEhruNoKUf
5n9wIBJlJjtRVzcQwrmHrPn852IhaYNw/pqB1DRcsW3gX1oot5PdsSO9ntRZ8HiV
Mt8nvTnDujUPzjG8O1VdmLLrEPmbcms+kvw50zywIS5Qtyv2DICRnC4MkYlbJ9C5
BdseeiB5p6KHQ2qeoqqKS1QKT3TrrdCHVOSEqrQ7ClK+ImdJOLL9N4jbSwvrI1xF
RxmnYT4GTT7UI3JgiXgNk0egIJwBFjpAlZVrhMkJS3nd84CrUIc=
=dzFv
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
