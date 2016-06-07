From: Pirate Praveen <praveen@debian.org>
Subject: Re: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible
 submodules" on debian jessie
Date: Tue, 7 Jun 2016 18:37:00 +0530
Message-ID: <5756C6F4.5050300@debian.org>
References: <5756856A.4020406@debian.org>
 <alpine.DEB.2.20.1606071229500.28610@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KkwW2KtneOiv6IDgVvj0Is38nRi5anMVL"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:07:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGj0-0005wt-In
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 15:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbcFGNHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 09:07:11 -0400
Received: from caibbdcaaahg.dreamhost.com ([208.113.200.76]:59846 "EHLO
	homiemail-a119.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932197AbcFGNHK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 09:07:10 -0400
X-Greylist: delayed 16774 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 09:07:10 EDT
Received: from homiemail-a119.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a119.g.dreamhost.com (Postfix) with ESMTP id 985526000082A;
	Tue,  7 Jun 2016 06:07:08 -0700 (PDT)
Received: from [192.168.1.110] (unknown [14.96.231.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: me@j4v4m4n.in)
	by homiemail-a119.g.dreamhost.com (Postfix) with ESMTPSA id DF54360000826;
	Tue,  7 Jun 2016 06:07:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <alpine.DEB.2.20.1606071229500.28610@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296675>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KkwW2KtneOiv6IDgVvj0Is38nRi5anMVL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 June 2016 04:00 PM, Johannes Schindelin wrote:
> Hi Pirate Praveen,
>=20
> On Tue, 7 Jun 2016, Pirate Praveen wrote:
>=20
>> I'm trying to rebuild git 2.8.1 on debian jessie/stable and I get this=

>> error (tests upto this succeeds).
>>
>> not ok 32 - should avoid cleaning possible submodules
>=20
> How about re-running the script with -i -v -x? If the output is still
> not shining enough light on it, maybe you want to paste the (relevant p=
art
> of the) output into a reply?

+ rm -fr to_clean possible_sub1
+ mkdir to_clean possible_sub1
+ test_when_finished rm -rf possible_sub*
+ test 0 =3D 0
+ test_cleanup=3D{ rm -rf possible_sub*
                } && (exit "$eval_ret"); eval_ret=3D$?; :
+ echo gitdir: foo
+
+ chmod 0 possible_sub1/.git
+
+ git clean -f -d
Skipping repository baz/boo

Skipping repository foo/
Removing possible_sub1/
Skipping repository repo/
Skipping repository sub2/
Removing to_clean/
+ test_path_is_file possible_sub1/.git
+ test -f possible_sub1/.git
+ echo File possible_sub1/.git doesn't exist.
File possible_sub1/.git doesn't exist.
+ false
error: last command exited with $?=3D1
not ok 32 - should avoid cleaning possible submodules
#
#               rm -fr to_clean possible_sub1 &&
#               mkdir to_clean possible_sub1 &&
#               test_when_finished "rm -rf possible_sub*" &&
#               echo "gitdir: foo" >possible_sub1/.git &&
#               >possible_sub1/hello.world &&
#               chmod 0 possible_sub1/.git &&
#               >to_clean/should_clean.this &&
#               git clean -f -d &&
#               test_path_is_file possible_sub1/.git &&
#               test_path_is_file possible_sub1/hello.world &&
#               test_path_is_missing to_clean
#

> Ciao,
> Johannes
>=20



--KkwW2KtneOiv6IDgVvj0Is38nRi5anMVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVsb0AAoJEM4fnGdFEsIqOi4QALFoPItfBxLuQZht3no9yvAU
yriDgLT7J9W9p+z0KjKr1z6GT2RpTDiyy23OfRHr611AlnTbvQt8J+qRGTgbN2I8
s3QfB8ljtRsgX52ib7yjASKM1nzyvhxPz/3IkEnCvrfIDc/6ld/x+mfKwjHY/qEH
opaNbupliCQm1DiCTOQoOI9VrgTzyqPnKj+lGdlJnB5X6gM8JBH5JG4H6NEzXZoG
sLKqeidw4URWogiJYAEe5KL8t3TJNTnlbzlGjrBo2tNqgXlP0U8pEaErHQm4aqhb
7n7Bp5XbEWBbTy9nmM1mVpZj+CfnP8E3qRCxiPJajHq94J76vv3lHYy8HgDxXFnm
LYq9wfHOI2lREaKln3uWScyDeU1ajmsRMysvKTyVK/9dR/hZl6DS8wRsUw9+sZYd
5EpPz3odUIQdEnRP9lAmJf0xEZSGTK+o03kjfFSCFhaiWXYtUfR9Mno+62MVc0N7
uy3c9U1F4B1lEKaU+xqSM6p9NDC3GduUeR+aktuJdAJda+qud9nOOCeTr083Wgoi
TziDyp09gPsADaHS8f3o58CJ5O4Diz04S9QCRSx+PStrt5BgF2KEOGyC4nPRbqBH
pSJrIy3Z5Wgit5yYFEAPUhcSGj+RKIN1nAa7TY/CzmWuiNS8A/7bA7NvHzQajX5Z
x9Yp8JaW30aWcp7X2Goq
=lG4k
-----END PGP SIGNATURE-----

--KkwW2KtneOiv6IDgVvj0Is38nRi5anMVL--
