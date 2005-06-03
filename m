From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 15:30:10 -0400
Message-ID: <1117827011.8970.2.camel@jmcmullan.timesys>
References: <20050603152212.GA4598@jmcmullan.timesys> <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys> <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org> <1117819137.32257.75.camel@jmcmullan.timesys> <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-uY446L2AXgRwkcyleexi";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 21:30:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeHpu-0001mm-VT
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 21:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVFCTaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 15:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVFCTaw
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 15:30:52 -0400
Received: from mail.timesys.com ([65.117.135.102]:50849 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261511AbVFCTaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 15:30:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 03 Jun 2005 15:30:11 -0400
In-Reply-To: <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Fri, 3 Jun 2005 15:23:19 -0400
Message-ID: <1117827011.8970.2.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-daemon server
thread-index: AcVocbMzXDDrqcsUSKyFC46pbGfrfQ==
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-uY446L2AXgRwkcyleexi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-03 at 10:41 -0700, Linus Torvalds wrote:=20
> Ok. Am I to understand that I could do a push to a remote server with ssh=
=20
> using something like
>=20
> 	git-server -- send master |
> 		ssh master.kernel.org git-server --db /pub/scm/linux/kernel/git/torvald=
s/linux-2.6.git

No, but you could do:

$ ssh master.kernel.org -L 7777:localhost:7777 \
    git-server --tcp --port 7777 \
               --db /pub/scm/linux/kernel/git/torvalds/linux-2.6.git &
$ git-server --tcp --port 7777 send master


You could probably play some games with shell redirection to file
descriptors if you really wanted to use the stdio stuff over ssh,
but that's a little ugly.


> Also, how do I send tags?

Tags are on my 'TODO' list, as are the deltafication and
mulitple-request changes. Also, a verdict on the name
(daemon vs server vs anything else) would be nice.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-uY446L2AXgRwkcyleexi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCoK/C8/0vJ5szK6kRApXYAKCDUv7pGESYiwgLJ08ro49ku9m/ggCfdfV+
azJlD4HghtFESbkzki8dOLE=
=qyD7
-----END PGP SIGNATURE-----

--=-uY446L2AXgRwkcyleexi--
