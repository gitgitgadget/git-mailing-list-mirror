From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t9501: Do not use export X=Y
Date: Thu, 25 Apr 2013 20:49:00 +0200
Message-ID: <201304252049.00811.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 20:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRES-0000N6-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759473Ab3DYStI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 14:49:08 -0400
Received: from mout.web.de ([212.227.17.11]:63471 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759469Ab3DYStF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 14:49:05 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LtX9Q-1UfNMS1Vh6-010vqp for <git@vger.kernel.org>; Thu,
 25 Apr 2013 20:49:04 +0200
X-Provags-ID: V02:K0:+4E19Qg2BDGwUw4Ygga675VMMowbNMFrVYMTwoT0rkK
 smTn0FbJC2EQ8vfXGoD9LgIh0nxIv2CjyclJu7oXFRXCejxSUU
 0UbAJJqauYEsXPo7SIM4r94iIN8ArbxxY7wIp1VLUw+DcFm1it
 w3EnomdMjrwDNTaAsdk0tHSWX19wLnwFnS9D55ceJqpw8FeGRm
 iU+fdkc8wVxyDU2rgFwqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222413>

Spilt lines like export X=3DY into 2 lines:
X=3DY
export X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9501-gitweb-standalone-http-status.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-=
standalone-http-status.sh
index ef86948..d3a5bac 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -130,7 +130,8 @@ test_expect_success DATE_PARSER 'modification: feed=
 last-modified' '
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: feed if-modified-since =
(modified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
 	grep "Status: 200 OK" gitweb.headers
@@ -138,7 +139,8 @@ test_expect_success DATE_PARSER 'modification: feed=
 if-modified-since (modified)
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: feed if-modified-since =
(unmodified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
 	grep "Status: 304 Not Modified" gitweb.headers
@@ -153,7 +155,8 @@ test_expect_success DATE_PARSER 'modification: snap=
shot last-modified' '
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: snapshot if-modified-si=
nce (modified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
 	grep "Status: 200 OK" gitweb.headers
@@ -161,7 +164,8 @@ test_expect_success DATE_PARSER 'modification: snap=
shot if-modified-since (modif
 test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: snapshot if-modified-si=
nce (unmodified)' '
-	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
 	grep "Status: 304 Not Modified" gitweb.headers
@@ -170,7 +174,8 @@ test_debug 'cat gitweb.headers'
=20
 test_expect_success DATE_PARSER 'modification: tree snapshot' '
 	ID=3D`git rev-parse --verify HEAD^{tree}` &&
-	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3D$ID;sf=3Dtgz" &&
 	grep "Status: 200 OK" gitweb.headers &&
--=20
1.8.2.1.614.g66d7af5
