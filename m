From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 9 Sep 2011 12:03:01 -0400
Message-ID: <20110909160301.GA9707@gnu.kitenet.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
 <20110908200343.GD16064@sigill.intra.peff.net>
 <robbat2-20110909T004300-810527870Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:03:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23Xs-0005it-Bu
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188Ab1IIQDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:03:06 -0400
Received: from wren.kitenet.net ([80.68.85.49]:38351 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759081Ab1IIQDF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:03:05 -0400
Received: from gnu.kitenet.net (24-158-104-148.dhcp.kgpt.tn.charter.com [24.158.104.148])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id AB9C9118427
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 12:03:02 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 357A840BDA; Fri,  9 Sep 2011 12:03:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <robbat2-20110909T004300-810527870Z@orbis-terrarum.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181087>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="//TRANSLIT"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Robin H. Johnson wrote:
> Joey Hess discussed this two years ago, and again last week:
> http://kitenet.net/~joey/blog/entry/size_of_the_git_sha1_collision_attack=
_surface/
>=20
> This is easy in the kernel tree, it's got lots of eyeballs and only few
> binary files. This isn't true for lots of other Git trees, a tree with a
> JPEG image or a gzip file would be a great target.

The most credible attack I have so far does not involve binary files in
tree. Someone pointed out that git log, git show, etc stop printing
commit messages at NULL. So colliding binary garbage can be put in a
commit message and be unlikely to be noticed, and the commit can
later be altered to point to a different tree.

https://github.com/joeyh/supercollider

joey@gnu:~/tmp/supercollider>git log
commit 24f30db5790b209fa412ce81c5ef2bf8af5fd4d7
Author: Joey Hess <joey@kitenet.net>
Date:   Fri Sep 9 11:49:21 2011 -0400

    an innocent commit
   =20
    If this were a sha1 colliding attack, there would be some sort of binary
    garbage below. Which there isn't. So this can be safely merged.
joey@gnu:~/tmp/supercollider>git cat-file commit 24f30db5790b209fa412ce81c5=
ef2bf8af5fd4d7
tree 735a7633237c07b398856005de3bc9ea00446747
author Joey Hess <joey@kitenet.net> 1315583361 -0400
committer Joey Hess <joey@kitenet.net> 1315583361 -0400

an innocent commit

If this were a sha1 colliding attack, there would be some sort of binary
garbage below. Which there isn't. So this can be safely merged.
=00


??b???=1F[?i??=CD=AF?t?=0C2??=02????os?=14<????h?+,M?mY?e?EW?i=13v$???=14J?=
?U}n~???L??????f??=02?=C4=9B??3>?Q??H?=DE=B8=16*zl=1A?RA=CB=82q?E=0C?=06=16=
E=7F7??=1B?=03\?m???U?=1E>MU=0B	GY?d)?=C8=BC??'g?~D??=C9=AFhQ?=13???/"E=04?=
?X?m???^=CD=B8??S?D=13??;w6(?`??>?=10=E7=B8=98?=07A=D1=B2?*!??@v????>?8??2=
=08?=14!??=3D*?J	=1B=0D=0D???=01ynH=10???c?w?\??K7??=1C?N?6??=1C???A5?FM?wZ=
?~?pK=02Y?R???s7=7F??(?=07=C6=B6?_"??m=11%????=7F1=7Fa??=CA=80??K[=0Dt??=11=
??=0E!A0?=CE=88fT.?T?w=07?=F2=81=9B=B5=C6=8C=0B?=D1=80???aco?V/2=14??n=D9=
=8E?
?}?6?=19_?z?{

It might be worth ameloriating that attack by making git log always
show the full buffer. Or it would be easy to write a tool that finds
any commits that have a NULL in their message.

--=20
see shy jo

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTmo4sMkQ2SIlEuPHAQirIQ//fq9O9XDn5oP4vJMLIp8/Anq9W8D8V3zc
nL/mC1vo41KJuW1WBIodOJIx8WcLB0JeMPbo2mZ8ZCovO5CAX0MeULQMOT0dEJTG
CKLBS7QXPmEVvEjFjfQgFEORHPZpzfDu1whDCh7MsunPfDbDTOV6AztwRPZOaCu4
vjDWbPbOSid/GfklzpNSW2Evh0Q0n9bOPE3535Az9uNM8Twz/wFc0W2cHTC4p+LK
5RZ9l/urX6taU0uYiCZMbrhL1c+t1Jy0YTMx0TVeQEQj/g5LAvIo1ieOkCD8Qcpq
FzbIqOlSp6fM7EglnQYx1UymXZlpp7TCx5x54LeRaUf6NqO6ea/3TNxjlei0R3Sk
8t+/vZG6PTUdQEgNmW5u/sZmGVFSoObVzzDWzN5iA+BTl/r6puoWvHykHBTAu3uC
FhVghkuDRf5mvzzsXch5zCK8xS+CMZqmgX4RQFF2N+vhyHsSoUD+L1jvMi2+XfMf
39H+VnXJg0871rBjAD5D9MhxLLJATexsJBerXGbP5Bsc+02zZEgRVC4/Uri9bCFq
dJz5avgkx/VKZ9XKepX13YZttAt7tt9K5+RcQfEzf2kBamLich791AQTVeu9y3Pc
ZWMlNJReoeCgbE141fXVZ+933UBg9xise9QjQT8HlolsQcLibXp4zkc9+sxN2OuB
nw/KS/4GmLI=
=dQK+
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
