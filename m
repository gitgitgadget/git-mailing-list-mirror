From: Brandon Philips <brandon@ifup.org>
Subject: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Mon, 9 May 2005 16:39:05 -0700
Message-ID: <20050509233904.GB878@osuosl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 01:33:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVHjh-0006p6-4Q
	for gcvg-git@gmane.org; Tue, 10 May 2005 01:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVEIXjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVEIXjd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 19:39:33 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:52648 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S261377AbVEIXjI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 19:39:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ns1.osuosl.org (Postfix) with ESMTP id 97F15BC31F;
	Mon,  9 May 2005 16:39:05 -0700 (PDT)
Received: from ns1.osuosl.org ([127.0.0.1])
	by localhost (ns1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12284-88; Mon, 9 May 2005 16:39:05 -0700 (PDT)
Received: from shell.osuosl.org (shell.osuosl.org [140.211.166.149])
	by ns1.osuosl.org (Postfix) with ESMTP id 6449DBC31A;
	Mon,  9 May 2005 16:39:05 -0700 (PDT)
Received: by shell.osuosl.org (Postfix, from userid 1000)
	id 50CD82F401C; Mon,  9 May 2005 16:39:05 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at osuosl.org
X-Spam-Status: No, hits=0.0 tagged_above=-999.0 required=5.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Petr,

cg-init has the ability to cg-add all files in the current directory.

But if the current directory has a sub directory cg-init breaks because
the `find *` command on line 34 returns directories which cg-add doesn't
accept.

Regards

Brandon Philips

Shameless plug: cogito-0.10 available in Gentoo

--
http://ifup.org

---

cg-init: needs update
Index: cg-init
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 972d8624458936868e6f392b40858b7c362af8cd/cg-init  (mode:100755)
+++ uncommitted/cg-init  (mode:100755)
@@ -31,7 +31,7 @@
 	echo "Cloned (origin $uri available as branch \"origin\")"
 else
 	git-read-tree # Seed the dircache
-	find * | xargs cg-add
+	find * ! -type d | xargs cg-add=20
 	cg-commit -C -m"Initial commit" -e
 fi
 exit 0

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCf/SYoP8TDUUjhZ0RAkpjAJ4gmvEbQsZ5JxdRKW/KzHHrQVI0AQCfRBE1
LGoWHcPL0Ft3h0brD9m/u1c=
=FLBb
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
