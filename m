Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5DF201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 13:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbdB1N0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 08:26:39 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41618 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751768AbdB1N0f (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 08:26:35 -0500
Received: from genre.crustytoothpaste.net (wsip-98-185-58-71.no.no.cox.net [98.185.58.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D6252280AD;
        Tue, 28 Feb 2017 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488288353;
        bh=0MNzPxwf3pWelP/E3xpT5dipeQnlLdqKYCb4863zW/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlW36SvS9YsLPci8qi4NCbvo7HOlNyk6IOC5dck/iZhEpGszJVm9HFWIBfxndv1bp
         r4ghw+fw+2uU98ncz6D+Y3q+fnFDUUPox1Z/e1XqSIoMffVjaxf/7/p0ZJen1gxx5w
         +axEtl9WKlAStSfFa6/MwBs4z/1jWa5XBalyu1gHRVfJaZHKPgybRqpWYCKX+GHdNR
         /nJJJ9bsPXXNac7DmDvN2omPc94QuB5TR+2Hv605HpHmoe8QM1azQYwKPGhtaWCK8a
         oIP1l53fstYT8RKtA1GBz2q9jEyUdRTOSja5wypkp91VbXbap1AEHDMUmrwc2GfGHe
         I4GbL6KEh04EujWq/gdeqKDG0cKUwFcetxBqwhKeUrWkuE/MtONCEXHpkBQm7Co1Af
         O7a3/8Eza7zGRmBYHKssDCyTEn98qC+E6gRQsRyFrcnuoLpuOil5r8YtCUmWvCpZAd
         5Hzbrzx9jNCPqCB2QjLV36OCWkULq6MU/9ZWFri2EgzgJ+QtOtO
Date:   Tue, 28 Feb 2017 13:25:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170228132545.ahhc6v7zulvlkzeh@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CACsJy8AtQG8YXQ+YfSFifUxqtd==THj5weJK5jooyiRN0yamiQ@mail.gmail.com>
 <20170225190410.anvb7ll7tlhwgm3t@genre.crustytoothpaste.net>
 <13bb2033-fedd-d7da-f584-21a3142852d3@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7g5vx366tdvoidub"
Content-Disposition: inline
In-Reply-To: <13bb2033-fedd-d7da-f584-21a3142852d3@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7g5vx366tdvoidub
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 02:29:18PM +0100, Ren=C3=A9 Scharfe wrote:
> Am 25.02.2017 um 20:04 schrieb brian m. carlson:
> >>> So I think that the current scope left is best estimated by the
> >>> following command:
> >>>
> >>>   git grep -P 'unsigned char\s+(\*|.*20)' | grep -v '^Documentation'
> >>>
> >>> So there are approximately 1200 call sites left, which is quite a bit=
 of
> >>> work.  I estimate between the work I've done and other people's
> >>> refactoring work (such as the refs backend refactor), we're about 40%
> >>> done.
> >=20
> > As a note, I've been working on this pretty much nonstop since the
> > collision announcement was made.  After another 27 commits, I've got it
> > down from 1244 to 1119.
> >=20
> > I plan to send another series out sometime after the existing series has
> > hit next.  People who are interested can follow the object-id-part*
> > branches at https://github.com/bk2204/git.
>=20
> Perhaps the following script can help a bit; it converts local and static
> variables in specified files.  It's just a simplistic parser which can get
> at least shadowing variables, strings and comments wrong, so its results
> need to be reviewed carefully.
>=20
> I failed to come up with an equivalent Coccinelle patch so far. :-/
>=20
> Ren=C3=A9
>=20
>=20
> #!/bin/sh
> while test $# -gt 0
> do
> 	file=3D"$1"
> 	tmp=3D"$file.new"
> 	test -f "$file" &&
> 	perl -e '
> 		use strict;
> 		my %indent;
> 		my %old;
> 		my %new;
> 		my $in_struct =3D 0;
> 		while (<>) {
> 			if (/^(\s*)}/) {
> 				my $len =3D length $1;
> 				foreach my $key (keys %indent) {
> 					if ($len < length($indent{$key})) {
> 						delete $indent{$key};
> 						delete $old{$key};
> 						delete $new{$key};
> 					}
> 				}
> 				$in_struct =3D 0;
> 			}
> 			if (!$in_struct and /^(\s*)(static )?unsigned char (\w+)\[20\];$/) {
> 				my $prefix =3D "$1$2";
> 				my $name =3D $3;
> 				$indent{$.} =3D $1;
> 				$old{$.} =3D qr/(?<!->)(?<!\.)(?<!-)\b$name\b/;
> 				$name =3D~ s/sha1/oid/;
> 				print $prefix . "struct object_id " . $name . ";\n";
> 				$new{$.} =3D $name . ".hash";
> 				next;
> 			}
> 			if (/^(\s*)(static )?struct (\w+ )?\{$/) {
> 				$in_struct =3D 1;
> 			}
> 			if (!$in_struct and ! /\/\*/) {
> 				foreach my $key (keys %indent) {
> 					s/$old{$key}/$new{$key}/g;
> 				}
> 			}
> 			print;
> 		}
> 	' "$file" >"$tmp" &&
> 	mv "$tmp" "$file" ||
> 	exit 1
> 	shift
> done

I'll see how it works.  I'm currently in New Orleans visiting a friend
until Thursday, so I'll have less time than normal to look at these, but
I'll definitely give it a try.

Most of the issue is not the actual conversion, but finding the right
order in which to convert functions.  For example, the object-id-part8
branch on my GitHub account converts parse_object, but
parse_tree_indirect has to be converted before you can do parse_object.
That leads to another handful of patches that have to be done.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7g5vx366tdvoidub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli1elkACgkQv1NdgR9S
9osrXg/+M3c1arl2MKeMsSYK499AY//TGhcLE6RfgBc+QrU827FEP2vZ/LaOQcGj
AgjVTxcvXPl/PNl30lDgnh1q8RPg7tth6Krvp1+b2xNwhI6XPqykAWVTGtDvOrt3
6vqiaqlMvqj/vHfgCFvE6b7cyX6ZT3eGCWF/CHjt3odg/lGd8sTk7l+kdvm+8fCV
dQFm8KFGl0LPSUEX+UdAuGKlDC2oxnI1TgoFLao25PfGPAGAC3OxdHv3MNL24eGG
Vte1HCx9o0dvKpM/LSiR3/7K2FiE5ooeoQnDbeyfCcypasfvX0NM1m+ZZAsw2kmX
GLf/7Nnj3LuNHC8OQikzgvgza0xcnsFmPkSMZeFtLDdufHI7SMbhjHVI31obU2Mf
5QD/Rm/RpDEQ8vDXyvARFK1ND7YxRRpDqX7ixL2jCmlR1KJuGxezsLd5i1dNzHxb
wJatQ2Quv1NZd21Pp6HdHDsMjbwMkys+hskhnVut3Knh9UCATLtKpxJNQbpqpiLA
AwoZNYzilNsqFh4tKq1arIcmdzWziaJZOsANf0KJiimw/3WghXgWlNvXIGlxsK3h
dhQQrGjPkXGNDHws7B69LYsxyV0OXosEbFe0tR4iQgagONskHl+l3OwYRe3tEFsc
OnuM1buQqnllUAQPYxVEhYuBywYU8rlGH44nmucbKzzM/DGVv38=
=LEU/
-----END PGP SIGNATURE-----

--7g5vx366tdvoidub--
