From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: How to pick a commit from another git tree?
Date: Sun, 07 Oct 2007 19:50:13 +0200
Message-ID: <20071007175013.GH10024@artemis.corp>
References: <000101c80907$d461a810$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZPDwMsyfds7q4mrK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sun Oct 07 19:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeaGt-00013t-IB
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 19:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbXJGRuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbXJGRuR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 13:50:17 -0400
Received: from pan.madism.org ([88.191.52.104]:44175 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754984AbXJGRuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 13:50:15 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 28BCE2075E;
	Sun,  7 Oct 2007 19:50:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B718E2A38; Sun,  7 Oct 2007 19:50:13 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <000101c80907$d461a810$04ac10ac@Jocke>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60206>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2007 at 05:31:00PM +0000, Joakim Tjernlund wrote:
> Hi=20
>=20
> This is probably a somewhat stupid question but I havn't had a need until=
 now so here goes:
> There is a commit in David Millers tree:
> http://git.kernel.org/?p=3Dlinux/kernel/git/davem/bak-net-2.6.24.git;a=3D=
commit;h=3Dbbb4c0c35a4c2aed5e025b668c8dfc99c5b74cff
> that hasn't made it into 2.6.23, but will go into 2.6.24.=20
> I need this fix on top of 2.6.23(once it is released).
> Now I wonder how to best add this fix to my tree. Once this fix hits linu=
s tree and I pull
> linus tree, I don't wan't a conflict as I already have this fix in my tre=
e.
>=20
> Should I just pull Davids tree? Or should I cherry-pick this one commit?
> Or something else?

  The easiest way is to fetch his tree (git remote add ...; git fetch)
and then yes, cherry-pick the commit(s) you need.

  If you need more than one commit, you can use:

  git rebase --onto <your tip> fromCommit toCommit

  and it will move ]fromCommit..toCommit] onto <your tip>

  It's likely that the fetch will be quite cheap as I suppose that David
Millers tree as very few objects different from linus tree (compared to
the linux2.6 git repository size I mean).
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCRxVvGr7W6HudhwRAn//AKCThL1IT18Cawybd57YZvJZr1zmBgCfXprq
CkyTqO/j81xaygQeywpP3JM=
=uyrf
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
