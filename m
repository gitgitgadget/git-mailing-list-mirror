From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] Rework pretty_print_commit to use strbufs instead  of custom buffers.
Date: Sat, 08 Sep 2007 20:49:07 +0200
Message-ID: <20070908184907.GA13385@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org> <1189252399316-git-send-email-madcoder@debian.org> <11892523992038-git-send-email-madcoder@debian.org> <46E2EC88.6000500@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="r5Pyd7+fXNt84Ff3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Sep 08 20:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU5Mr-0001WS-3S
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 20:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbXIHStL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 14:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbXIHStL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 14:49:11 -0400
Received: from pan.madism.org ([88.191.52.104]:45194 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbXIHStJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 14:49:09 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C3D881E18B;
	Sat,  8 Sep 2007 20:49:08 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 157ED2E0F; Sat,  8 Sep 2007 20:49:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46E2EC88.6000500@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58132>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2007 at 06:40:08PM +0000, Ren=C3=A9 Scharfe wrote:
> Pierre Habouzit schrieb:
> >   Also remove the "len" parameter, as:
> >   (1) it was used as a max boundary, and every caller used ~0u
> >   (2) we check for final NUL no matter what, so it doesn't help for spe=
ed.
> >=20
> >   As a result most of the pp_* function takes 3 arguments less, and we =
need
> > a lot less local variables, this makes the code way more readable, and
> > easier to extend if needed.
> >=20
> >   This patch also fixes some spacing and cosmetic issues.
> >=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  builtin-branch.c      |   15 +--
> >  builtin-log.c         |   12 +-
> >  builtin-rev-list.c    |   13 +-
> >  builtin-show-branch.c |   13 +-
> >  commit.c              |  330 ++++++++++++++++++-----------------------=
--------
> >  commit.h              |    6 +-
> >  log-tree.c            |   56 +++------
> >  7 files changed, 171 insertions(+), 274 deletions(-)
>=20
> Nice!  I wonder if we should #include strbuf.h from git-compat-util.h
> (just like e.g. string.h) instead of from commit.h, in order to have
> strbuf available everywhere in git.
>=20
> Please be aware of the changes to commit.c already in next which your
> patch conflicts with: format_commit_message() has been exported and is
> used in builtin-archive.c there.

  Okay, then I'll hope than Junio will merge the first series and then
rebase this one on next. If I'm going to propose more of those patches,
should I write them rather on next or master (like I do now) ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4u6jvGr7W6HudhwRAnYMAJwLNrQ5G07cOTUhmXOPmRfrrItqRwCgo3Vb
Uem7CkhkY9kNr9/DTVf/Y7o=
=L9x/
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
