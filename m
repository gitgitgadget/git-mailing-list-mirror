From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: possible 'git cp'/how does git detect copies
Date: Fri, 27 Jun 2008 15:00:06 +0200
Message-ID: <20080627130006.GC17898@artemis.madism.org>
References: <4864DFB6.3050204@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="v9Ux+11Zm5mwPlX6";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:01:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDZe-0004Vx-Sh
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYF0NAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYF0NAL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:00:11 -0400
Received: from pan.madism.org ([88.191.52.104]:56807 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbYF0NAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:00:10 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 6E2E338C22;
	Fri, 27 Jun 2008 15:00:08 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EE63345E7; Fri, 27 Jun 2008 15:00:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Mircea Bardac <dev@mircea.bardac.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4864DFB6.3050204@mircea.bardac.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86550>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 12:40:22PM +0000, Mircea Bardac wrote:
> I was looking today at duplicating a file but, I soon realized that there=
=20
> is no 'git cp' command (this was the "deductive approach to git=20
> commands", starting from git mv/rm/...). How does "git diff -C" detect=20
> copies (-C is used for this, according to the documentation)?

  By comparing if files (blobs) are alike. It has some heuristics to
guess which files have good changes to be copies or renames of each
others. But it recomputes the information each time.

> On a very simple test, I couldn't see this working. I just copied one=20
> file, added it, committed the change, ran "git diff -C HEAD^!". There is=
=20
> no place saying that it's contents is copied from some other file (both=
=20
> files are in the repository now).
>=20
> "git blame -C new_copied_file" also doesn't show the commits for the=20
> original file.

  You probably want to use -C -C -M actually.

> I found this older thread [1] on "git cp" but the discussion appears to=
=20
> have stalled at some point. If there is indeed no use of a "git cp"=20
> command, I would like at least some info on how content copies are being=
=20
> detected, since I haven't seen this working.

  If you really need it, you can and an alias alias.cp=3D!cp and be done
with it ;P

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhk5FYACgkQvGr7W6Hudhw9VwCdHbmEfB6lvMQVqjqgLAQ1mYQq
1jwAoI1rTuPlscYF/UoHbu2J5kKbRu4H
=00AM
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
