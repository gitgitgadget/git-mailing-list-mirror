From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Teach read-tree 2-way merge to ignore intermediate symlinks
Date: Thu, 12 Jul 2007 14:40:45 +0200
Message-ID: <20070712124045.GA4509@artemis.corp>
References: <20070704203541.GA13286@artemis.corp> <7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ibTvN161/egqYuK8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 14:41:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8xyZ-0001Wz-FI
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762872AbXGLMkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762697AbXGLMkt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:40:49 -0400
Received: from pan.madism.org ([88.191.52.104]:45143 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760550AbXGLMks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:40:48 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B7F7A5510;
	Thu, 12 Jul 2007 14:40:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 575741427EB; Thu, 12 Jul 2007 14:40:45 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52271>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2007 at 01:04:16AM -0700, Junio C Hamano wrote:
> Earlier in 16a4c61, we taught "read-tree -m -u" not to be
> confused when switching from a branch that has a path frotz/filfre
> to another branch that has a symlink frotz that points at xyzzy/
> directory.  The fix was incomplete in that it was still confused
> when coming back (i.e. switching from a branch with frotz -> xyzzy/
> to another branch with frotz/filfre).
>=20
> This fix is rather expensive in that for a path that is created
> we would need to see if any of the leading component of that
> path exists as a symbolic link in the filesystem (in which case,
> we know that path itself does not exist, and the fact we already
> decided to check it out tells us that in the index we already
> know that symbolic link is going away as there is no D/F
> conflict).
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

  I confirm this fixes the issue I reported.
  Thanks !
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGliFNvGr7W6HudhwRAu4AAJ4shthUw5nwEQ7UiovF35XClDUWDACdEcqO
swVeUOtFpzlf5qfjAQNurpM=
=65lz
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
