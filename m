From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Database consistency after a successful pull
Date: Mon, 06 Jun 2005 09:50:49 -0400
Message-ID: <1118065849.8970.37.camel@jmcmullan.timesys>
References: <Pine.LNX.4.21.0506051523280.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-o35axde4QZ5xGL2rKZti";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:49:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfHx7-0006e5-Fy
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 15:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFFNvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 09:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVFFNvM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 09:51:12 -0400
Received: from mail.timesys.com ([65.117.135.102]:42681 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261448AbVFFNux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 09:50:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 06 Jun 2005 09:50:50 -0400
In-Reply-To: <Pine.LNX.4.21.0506051523280.30848-100000@iabervon.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Mon, 6 Jun 2005 09:43:50 -0400
Message-ID: <1118065849.8970.37.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Database consistency after a successful pull
thread-index: AcVqncVzQp0mP6TORuuE/6nYd2Tfig==
To: "Daniel Barkalow" <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-o35axde4QZ5xGL2rKZti
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Subject Was: [PATCH] pull: gracefu[PAlly recover from delta retrieval
failure.]

[snip lots of really good information about the thinking
 behind the design of the pull mechanisms ]

Ok, so would I be correct in the following assumptions
about the validity of a 'consistent' .git/objects database:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Commits:
	* May have the tree they refer to in the database
	* Must have their parents in the database

Trees:
	* Must have the blobs they refer to in the database
	* Must have the trees they refer to in the database

Deltas:
	* Must have the referred to object in the database

Blobs:
	* No references to check


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In short, the database would contain:

	* The entire commit history
	* Selected commits would have the entire tree available

Correct, or totally mistaken? If mistaken, what are the consitency
rules?

[Oh, and does PGP signing my messages bug anybody? If so, I can stop
 doing that on this list]

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-o35axde4QZ5xGL2rKZti
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpFS58/0vJ5szK6kRAsKFAJ90468btuiPEHujB0P7+pC+AeKr/gCggbZi
fh2cMwo/SXCDBRKgyX7VCKs=
=dW0a
-----END PGP SIGNATURE-----

--=-o35axde4QZ5xGL2rKZti--
