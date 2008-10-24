From: Joey Hess <joey@kitenet.net>
Subject: git-daemon and hook output
Date: Fri, 24 Oct 2008 01:07:13 -0400
Message-ID: <20081024050713.GA21548@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 07:08:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtEua-0003QQ-7r
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 07:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbYJXFHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 01:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbYJXFHW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 01:07:22 -0400
Received: from wren.kitenet.net ([80.68.85.49]:55485 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbYJXFHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 01:07:22 -0400
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 2101B3142E1
	for <git@vger.kernel.org>; Fri, 24 Oct 2008 01:07:18 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 29634114025; Fri, 24 Oct 2008 01:07:14 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8483/Thu Oct 23 23:01:54 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99008>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to githooks, standard output/error for the post-receive and
pre-receive hooks will be seen by the user. This is true if using ssh.
But if git-daemon has been configured to allow pushes, the user will
not see anything these hooks output, and only a not very helpful

 ! [remote rejected] master -> master (pre-receive hook declined)

I suppose that to fix this, git-daemon would have to select on stdout
and stderr and pipe them over the wire to the client. Apologies for not
even trying to write a patch to do that.

(I ran into this in a real-world application -- I'm implementing
anonymous pushes into ikiwiki, which are checked pre-receive to limit
them to changes that could be done via the web interface. So all my nice
error messages about why a commit is refused are not available, which is
a pity.)

--=20
see shy jo

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJAVfvd8HHehbQuO8RAk4UAJ9CI/O+H735wQySRXqWh+XIPeuf0gCfbYUQ
2rmBywuNUfZ4l+d2x/x0U2M=
=YWJH
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
