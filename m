From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: Adding push configuration to .git/config
Date: Wed, 28 Nov 2007 23:15:59 +0100
Message-ID: <20071128221559.GC22395@denkbrett.schottelius.org>
References: <20071121105517.GA11875@denkbrett.schottelius.org> <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de> <7vd4u28z90.fsf@gitster.siamese.dyndns.org> <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de> <Pine.LNX.4.64.0711221120300.27959@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 12:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixhzh-0007or-Pv
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 12:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbXK2Lz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 06:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756638AbXK2Lz0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 06:55:26 -0500
Received: from ch66.ha.eof.name ([62.65.155.66]:52843 "EHLO
	denkbrett.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbXK2Lz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 06:55:26 -0500
X-Greylist: delayed 48964 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2007 06:55:25 EST
Received: from nico by denkbrett.schottelius.org with local (Exim 4.68)
	(envelope-from <nico-linux-git@schottelius.org>)
	id 1IxVCe-0003sc-3q; Wed, 28 Nov 2007 23:16:20 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711221120300.27959@racer.site>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.23.9 on i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66526>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello guys,

I'm replying a bit late, had much to work in the last days.

I really like some ideas discussed here and want to state that

- "git push" without options is much easier and does nothing wrong,
  if you configured the branch.$name.pushto correctly
- I also think that having support for multiple push destinations
  per branch would be excellent for a distributed version control system
  like git
- doing 'git push origin master:myremote/myname' just covers to much
  redundant data, which imho can (but not must) be put into .git/config
- I don't care about the configuration names, we can even stick to
  "merge" for now and add simply add "push" and rename them in git 2.x

I currently would like this variant mostly, allowing high flexibility:

---------------------------------------------------------------------------=
-----
[remote "myremote"]
   url =3D git+ssh://.... # no change
   ref =3D refs/heads/    # renamed fetch =3D ...

# that way we can use the remote for fetch and push:

[branch "master"]
   merge =3D myremote
   push =3D myremote
   push =3D anotherremote

[branch "otherbranch"]
   merge =3D otherremote
   push =3D otherremote
   push =3D classmate
   push =3D myremote
---------------------------------------------------------------------------=
-----

What do you think about that approach?

Sincerly

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTeifuL75KpiFGIwRAnubAJ47t/1c2F4JD74Ojv+If/0DugdTCgCeKXyo
ZIrAeObCaPU7dV56JoBAM64=
=c4U9
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
