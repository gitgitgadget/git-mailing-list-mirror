From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Use core.sharedrepository consistently.
Date: Sun, 5 Mar 2006 00:05:57 +0100
Message-ID: <20060304230557.GB28469@ferdyx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 05 00:06:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFfpB-0001T6-R8
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 00:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWCDXGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCDXGD
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 18:06:03 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:54200
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1751769AbWCDXGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 18:06:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 5482D8D323;
	Sun,  5 Mar 2006 00:02:45 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20440-03; Sun, 5 Mar 2006 00:02:42 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id E34E18D303;
	Sun,  5 Mar 2006 00:02:41 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Sun,  5 Mar 2006 00:05:57 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17196>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

'git init-db --shared' sets 'core.sharedRepository' but in
setup.c 'core.sharedrepository' is checked instead. This
trivial patch fixes both init-db.c and its documentation to
use 'core.sharedrepository'.

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>

---

 Documentation/git-init-db.txt |    2 +-
 init-db.c                     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

531df8e5c78ca67746b7a651ac4486eae8b114c6
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index ea4d849..2d818d6 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -34,7 +34,7 @@ environment variable then the sha1 direc
 otherwise the default `$GIT_DIR/objects` directory is used.
=20
 A shared repository allows users belonging to the same group to push into =
that
-repository. When specifying `--shared` the config variable "core.sharedRep=
ository"=20
+repository. When specifying `--shared` the config variable "core.sharedrep=
ository"
 is set to 'true' so that directories under `$GIT_DIR` are made group writa=
ble
 (and g+sx, since the git group may be not the primary group of all users).
=20
diff --git a/init-db.c b/init-db.c
index ff29496..e77a749 100644
--- a/init-db.c
+++ b/init-db.c
@@ -285,7 +285,7 @@ int main(int argc, char **argv)
 	safe_create_dir(path, 1);
=20
 	if (shared_repository)
-		git_config_set("core.sharedRepository", "true");
+		git_config_set("core.sharedrepository", "true");
=20
 	return 0;
 }
--=20
1.2.4

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFECh1VCkhbDGC9KNQRAjaNAJ9y0tuR7TEq+IWkUc1dJyBMMM1+XQCdE9d2
AwWA07tzginmiNdJSDR0k/w=
=oErp
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
