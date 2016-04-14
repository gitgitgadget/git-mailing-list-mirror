From: Joey Hess <id@joeyh.name>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 12:47:51 -0400
Message-ID: <20160414164751.GA3255@kitenet.net>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
 <1460502934.5540.71.camel@twopensource.com>
 <20160414015324.GA16656@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 18:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqkbV-0002fH-8S
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 18:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbcDNQ6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 12:58:49 -0400
Received: from kitenet.net ([66.228.36.95]:53668 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbcDNQ6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 12:58:48 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Apr 2016 12:58:48 EDT
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=f3PxJbhF;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1460652471; bh=CpF3d1DYH7qr/f2JPDweg0rxmMkURCO+64td+MzxSDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3PxJbhFDKZHcvtFw4hPDGBNhUl6JRNQLzHZX2+C/hdF5vhcnCKHlmt9iuiGmlJmp
	 bEOZnHzH/4qBxhjbzCOXdMuhcZOGms8vCeTDaFxAVf8XFlGZ/Qoa5Mb9CMRjvqtsA/
	 CAxlhI4Oe2A1xXuIVgHoDkEJ43H3UF64wm0MmoBs=
Content-Disposition: inline
In-Reply-To: <20160414015324.GA16656@thunk.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-99.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_SOFTFAIL,URIBL_BLOCKED,
	USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291534>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Theodore Ts'o wrote:
> OK, so how does this map to git?  First of all, from a collision
> perspective, the two blobs have to map into valid C code

Git provides other places to hide the colliding blobs; the best seems to
be as an added header in the commit object, or as trailing data after a \0
in the commit message. git is very good at hiding such potentially
colliding data from the user, as https://github.com/joeyh/supercollider
demonstrates.

commit 24f30db5790b209fa412ce81c5ef2bf8af5fd4d7
Author: Joey Hess <joey@kitenet.net>
Date:   Fri Sep 9 11:49:21 2011 -0400

    an innocent commit
   =20
    If this were a sha1 colliding attack, there would be some sort of binary
    garbage below. Which there isn't. So this can be safely merged.

joey@darkstar:~/tmp/supercollider>git cat-file -p 24f30db5790b209fa412ce81c=
5ef2bf8af5fd4d7
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


(The other possibility would be to hide the colliding blob in the tree
object, but that seems unlikely.)

--=20
see shy jo

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVw/JtckQ2SIlEuPHAQJH8w/+IbOHb6+CI6H5ncfNwSK7LT+WK8znQEKF
0uwU1UQqTD4Dg7pOEhR1I1DHfxAGIvfs3mGhWN4VpeXelYumwIbXhELWvAZmOn6k
f62EmET6zkFJerOzAdKqKuJsi7jFrLPYPfysH5wYkkukcMO2qg0Pl7SxZoALup2V
3ZnJd+Rm3qPI6+unhS9Yjg2CFYVywXZ0NK/GZKFKR9K3A8TXScge9r96B+7DycUr
e0Ypjww/q06j4YPLGKoJ2rvtF8mKJRMu1el+nkTIzJQsG1T5pXyy2wLFXhJcbFxG
CW8Zrf+D5S5ldNfZmu7T0c3NWf8dk6+TxswzYliWqc4SlB3z4E9s0fIDk6D/SlAD
Rt02gHjpetdO4nnzthKq0sodqQOeCXeUZvfgm3QF87koPa6YmC7iDSJjaCASn6o3
W0t7nSqi3nKZCZsjZRS+wxzhQngktFbtitUIV736FEArW5EVS5RP5djroWfGBZsF
OI9xfqBSzO2KNChMGwBfr3jTIDuw7tU8+P5Yo0edAYkPOBvY9v0973m4uGTLMof0
hiwA9eDGLlZN0mqCek9JH9cfBJX1P+ivsrvBvV79JpZk/9biEB7HaEuCtvmFfgTz
CRSjoU9lRpl3mT72D6YdcSE5B8EUBCU4w2WrXAXIfMlqicUBid4zfzKqhTziul02
G1K50ZkfBm4=
=8MPS
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
