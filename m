From: Keith Packard <keithp@keithp.com>
Subject: Direct CVS import tool
Date: Mon, 13 Mar 2006 00:25:42 -0800
Message-ID: <1142238342.24217.63.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+dEZnFEx1wAUFVwZoRiX"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Mon Mar 13 09:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIiNN-0005Fi-1Y
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 09:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWCMIZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 03:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWCMIZ6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 03:25:58 -0500
Received: from home.keithp.com ([63.227.221.253]:37638 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932333AbWCMIZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 03:25:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7C52E130022;
	Mon, 13 Mar 2006 00:25:55 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30175-06; Mon, 13 Mar 2006 00:25:54 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id BB9E1130021; Mon, 13 Mar 2006 00:25:54 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 9BC8C14001;
	Mon, 13 Mar 2006 00:25:54 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id AB57C6AC1DF; Mon, 13 Mar 2006 00:25:42 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17561>


--=-+dEZnFEx1wAUFVwZoRiX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've got some rather large, broken, CVS trees that I'm trying to migrate
to git (X.org).

Attempts to do this with the existing cvsps-based git-cvsimport have
proved rather disasterous; missing files, incorrect log messages and
incorrect revisions are spread throughout the tree, including on the tip
of each branch.

I'm reasonably sure the problems are caused by cvsps, and while I've
hacked at that quite a bit, it seems like it's so focused on analysing
the tree for putative software engineering reesarch that it cannot be
made to accurately reproduce the tree via changeset analysis.

So, I've given up hacking cvsps and wrote a simple RCS file parser that
directly reads ,v files into a git-like revlist structure, and then
merges those together into a final tree. At this point, it's generating
the right head information for every named branch, but it's still not
successfully connecting all of the branches back together at suitable
points.

It's also not yet generating actual git trees; instead it dumps the
generated revision tree structure to a graphviz file for visual
inspection of the results.

But, I figured instead of doing this work in secret, I'd let people know
what I'm up to in case others want to play along.

git://git.freedesktop.org/~keithp/parsecvs

And, of course ideas for a suitable name would be welcome.

--=20
keith.packard@intel.com

--=-+dEZnFEx1wAUFVwZoRiX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEFSyGQp8BWwlsTdMRAlShAJwIFHeZ8fBtjOFascESo5w93uGULgCfcAWd
DJcSUbmG+4n8lvxCptNUPoE=
=n4K1
-----END PGP SIGNATURE-----

--=-+dEZnFEx1wAUFVwZoRiX--
