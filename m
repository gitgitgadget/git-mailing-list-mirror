From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 13:18:57 -0400
Message-ID: <1117819137.32257.75.camel@jmcmullan.timesys>
References: <20050603152212.GA4598@jmcmullan.timesys> <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys> <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-bTHhDtWvgzcbXjpqFDoy";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:17:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeFm2-0006Jp-8t
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 19:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFCRTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVFCRTI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 13:19:08 -0400
Received: from mail.timesys.com ([65.117.135.102]:59320 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261403AbVFCRTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 13:19:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 03 Jun 2005 13:18:57 -0400
In-Reply-To: <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Fri, 3 Jun 2005 13:12:06 -0400
Message-ID: <1117819137.32257.75.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-daemon server
thread-index: AcVoX14l88ncfRt3QTyX6A1HUzk0vQ==
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-bTHhDtWvgzcbXjpqFDoy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-03 at 09:30 -0700, Linus Torvalds wrote:
> Well, it's fine, but you should at least tell _how_ you use it. What are
> the scripts you use to synchronize etc etc..

Sorry, here's some use cases (assuming that git-server is running on
192.168.1.1 port 7777)

###### Create a new local git repo

$ GITCONN=3D"--tcp --host 192.168.1.1 --port 7777"
$ git-init-db
$ git-server $GITCONN -- request master



###### Update local repo to remote's head linux-devel

$ git-server $GITCONN -- request linux-devel


###### Create remote head linux-mumble

$ git-server $GITCONN -- head -- linux-mumble
6678abc8d819abc919a018ca89273091bc98a


###### Get remote head's linux-mumble SHA1

$ git-server $GITCONN -- head linux-mumble
sha1 linux-mumble 6678abc8d819abc919a018ca89273091bc98a


###### Set remote head to new SHA1

$ git-server $GITCONN -- head linux-mumble
6678abc8d819abc919a018ca89273091bc98a
8389324a9890218bcd9a0193781abc8a183a9
sha1 linux-mumble 8389324a9890218bcd9a0193781abc8a183a9

(This has the side effect of the server requesting SHA1 objects from the
client if they do not exist on the remote repository)


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-bTHhDtWvgzcbXjpqFDoy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCoJEA8/0vJ5szK6kRAtKKAKCp8jZPib6e8/aOH2LETVVBfGGbjQCg0f6Z
eTWVy9HYsPu4saesU8UytAg=
=hYTx
-----END PGP SIGNATURE-----

--=-bTHhDtWvgzcbXjpqFDoy--
