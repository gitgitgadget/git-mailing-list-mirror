From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 11:01:21 +0200
Message-ID: <20070929090121.GA4216@artemis.corp>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cNdxnHkX5QqsyA0e";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 11:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbYCb-0001e0-8J
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 11:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbXI2JB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 05:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbXI2JBZ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 05:01:25 -0400
Received: from pan.madism.org ([88.191.52.104]:38432 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbXI2JBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 05:01:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id ED69422509;
	Sat, 29 Sep 2007 11:01:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CAA1334A481; Sat, 29 Sep 2007 11:01:21 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070929000056.GZ3099@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59448>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 12:00:56AM +0000, Shawn O. Pearce wrote:
> The C based git-fetch made the http protocol almost totally silent.
> (No more got/walk messages.)  But that's actually also bad as it
> now doesn't even let you know its transferring anything at all.
>=20
> There are serious issues here about getting the user the progress
> they really want.  The last item ("When will this be done?") is
> actually not possible to determine under either the native git
> protocol or HTTP/FTP.  We have no idea up front how much data must
> be transferred.  In the native git case we do know how many objects,
> but we don't know how many bytes that will be.  It could be under
> a kilobyte in one project.  That same object count for a different
> set of objects fetch could be 500M.  Radically different transfer
> times would be required.

  I'm not sure you need the ETA thing. I've used bzr only a couple of
time, I don't think it shows any kind of ETA, but I think I remember sth
like:

Stage 3/4
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D>                                    ] [43%]

  And that's all is needed. It's sober, and informative enough I think.


  Many git commands output are still messy and indeed, having them in C
should help in that regard. The usual culprit are I think:

  * git fetch/clone/pull/.. ;
  * git push ;
  * git repack/gc/... ;
  * git merge (even with the merge.verbosity set to the minimum it's
    still not very readable and confusing).


  I do believe that the quite verbose output git commands sometimes have
is quite confusing, and let the user think it's messy. I believe that
porcelains should be more silent, it's OK for the plumbing to spit
progress messages and so on, because people using the plumbing are able
to understand those, but porcelains should not.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/hRhvGr7W6HudhwRAqVVAJ4jixS65DzIJuEJrVL0rEiW+SZ/ywCeO4hP
qhsh5Ph79yFzT46cAdPeRKI=
=Yjwo
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
