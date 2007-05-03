From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-export hg mutt (24M vs 184M)
Date: Fri, 4 May 2007 00:29:46 +0200
Message-ID: <20070503222946.GH3260@artemis>
References: <20070503185623.GA11817@cip.informatik.uni-erlangen.de> <20070503191716.GB11817@cip.informatik.uni-erlangen.de> <20070503210112.GE3260@artemis> <20070503211824.GB16538@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="YrlhzR9YrZtruaFS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 04 00:30:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjjoE-0003Jl-B3
	for gcvg-git@gmane.org; Fri, 04 May 2007 00:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbXECW3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754446AbXECW3t
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 18:29:49 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:55625 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbXECW3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 18:29:48 -0400
X-Greylist: delayed 5313 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2007 18:29:48 EDT
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 2059F17EF2;
	Fri,  4 May 2007 00:29:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0485E2AB9; Fri,  4 May 2007 00:29:47 +0200 (CEST)
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070503211824.GB16538@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46111>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2007 at 05:18:24PM -0400, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > On Thu, May 03, 2007 at 09:17:16PM +0200, Thomas Glanzmann wrote:
> > > Hello,
> > > git-repack -a -d -f got it down to 19M. I missed the -f parameter
> > > before. Sorry for the noise.
> >=20
> >   You may want to use git gc that does that (and a bit more) for you.
>=20
> Actually, in this case, no.
>=20
> git-gc by default doesn't use the -f option.  -f to git-repack
> means "no reuse deltas".  That particular feature of git-repack is
> basically required to be used after running git-fast-import with
> anything sizeable.

  okay, so why git fast-import does not let some note somewhere (to be
picked by git gc later) "a fast-import has been run, use -f for next
repack if you want best compression" ?

  I'd think that would make a lot of sense, and that users that now
naively (like me) think git-gc would always be enough would not be
dramatically wrong ? :)

  I mean it's nothing *very* important but some=20
  `touch $GIT_DIR/info/unpacked-fast-import` in fast-import then:
  if test -f $GIT_DIR/info/unpacked-fast-import; then
      REPACK_OPTIONS=3D$REPACK_OPTIONS\ -f
  fi
  // do the repack
  rm -f $GIT_DIR/info/unpacked-fast-import

  would do the trick, wouldn't it ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOmJavGr7W6HudhwRAjUrAKCBp/q9JIMrFRyedIF1wsBO+i7uyACfVWkN
yOblWbdA/GWybIoXrf0Zlc4=
=//km
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
