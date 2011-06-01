From: Joey Hess <joey@kitenet.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 16:16:29 -0400
Message-ID: <20110601201629.GA25354@gnu.kitenet.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:17:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRrrH-0003tc-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 22:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795Ab1FAURe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 16:17:34 -0400
Received: from wren.kitenet.net ([80.68.85.49]:33816 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab1FAURd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 16:17:33 -0400
Received: from gnu.kitenet.net (dialup-4.154.7.116.Dial1.Atlanta1.Level3.net [4.154.7.116])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 70B951180DE
	for <git@vger.kernel.org>; Wed,  1 Jun 2011 16:17:24 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id D6E4551464; Wed,  1 Jun 2011 16:16:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110601195831.GA30070@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174900>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> So implementing the "optimization" to drop the refresh here doesn't seem
> worth it. It inroduces an awful inconsistency, and it probably isn't
> saving much in practice. Lots of other commands will end up stat'ing
> everything, anyway. Users with giant repos or slow stat calls are
> probably better off using assume-unchanged, which would help this and
> many other situations.

Sounded like git-reset -q file could be optimised to not reread the
index without any visible inconsistency?

My experience with semi-large trees[1] is that I have to remember to use
"git status ." in a subdir; that "git commit -a" is of course slow when
I need to use it; and that the index gets big and things that need to
update it can become somewhat slow especially on slow disks, but that
otherwise git scales fairly well and has good locality, and that it's
easy to reason about what operations are global and avoid them.
So this git-reset behavior was surprising.

assume-unchanged seems like it would add a lot of work when merging.

--=20
see shy jo

[1] Two or three times the number of files as linux-2.6.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTeaeHckQ2SIlEuPHAQhN+w/+NNaYkayq+J3QvG/0a5pr6mg9/0S60znR
LH6ituIDmjOTtuhv54wdlj2Inrd8gyonKQ8jslmecqPxEYbyJSz697AfPJ2M0XUO
Vj45GTnyt6qK5+r4jCLQijyXSgRsv7vM3SAzH/H2Vaj6QOYZBrilGAJwG6bmElgT
lxzuhNs4ajvf2TjzGa8QJPNifT8pKuIeTLxbtXZnAhUYiVLula9djbYQAd36ics9
rHLsDyqgfYoDOIjervoD25z4ZQTJ8SK5VJ95BBgUelQb52dXnOxC4pQrKiJPOdTW
wKLFOrGiEE3ZK50rQwJlI3MTTQy69NJLkLrRV/it+V+6ZJ1UTmJv1cVBh908j+5X
eNt8Xh9bn8IMLJRl4DAgJgPRnn/+xlwG7IfBTjT/peI0edpWiSKuArBH/qcYjIg+
zoUfLTdMO6vVvKQN/Lrf0/VgwW5J5f70EY+JatIiIgVpVOUBAZryYRk6mvBCATnl
HBHVfh6HgLX42THDuyJUz1h18WM1xNPE17aRkVI1+SmJQ8ls63lbF3UDixBqJFL/
L/6qTXbmuL0BrB4IATP4UPPSVbbHTE2H8Bwm3o9vxgEPaRmMA2YaPVF2Y14C6b6i
bTfWk81e/vyiMoy+yyT1+5Axc6vxEUTPve2/yoVYzF/k2xUoqohaZ//73YmUQesk
Qp5ntcOvB2w=
=T5g7
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
