From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] Use --upload-pack in clone, fetch and ls-remote instead of --exec
Date: Tue, 23 Jan 2007 09:24:37 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070123082437.GA10053@cepheus>
References: <20070123082017.GA10007@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 23 09:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9GxQ-00087i-KD
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 09:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbXAWIYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 03:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902AbXAWIYl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 03:24:41 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58164 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932904AbXAWIYk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 03:24:40 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9GxL-0002lj-LF
	for git@vger.kernel.org; Tue, 23 Jan 2007 09:24:39 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0N8Obwm006016
	for <git@vger.kernel.org>; Tue, 23 Jan 2007 09:24:37 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0N8ObHS006015
	for git@vger.kernel.org; Tue, 23 Jan 2007 09:24:37 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070123082017.GA10007@cepheus>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37489>

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
I don't like the change to git-fetch.sh.  But currently git-fetch-pack
needs a =3D and ls-remote doesn't like it.  So it continues to have two
variables for the remote upload program.

 git-clone.sh     |    2 +-
 git-fetch.sh     |    2 +-
 git-ls-remote.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0f7bbbf..d652c00 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -163,7 +163,7 @@ while
 	1,-u|1,--upload-pack) usage ;;
 	*,-u|*,--upload-pack)
 		shift
-		upload_pack=3D"--exec=3D$1" ;;
+		upload_pack=3D"--upload-pack=3D$1" ;;
 	1,--depth) usage;;
 	*,--depth)
 		shift
diff --git a/git-fetch.sh b/git-fetch.sh
index 87b940b..2279991 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -34,7 +34,7 @@ do
 	--upl|--uplo|--uploa|--upload|--upload-|--upload-p|\
 	--upload-pa|--upload-pac|--upload-pack)
 		shift
-		exec=3D"--exec=3D$1"=20
+		exec=3D"--upload-pack=3D$1"=20
 		upload_pack=3D"-u $1"
 		;;
 	-f|--f|--fo|--for|--forc|--force)
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 03b624e..e9e79e2 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -23,7 +23,7 @@ do
   -u|--u|--up|--upl|--uploa|--upload|--upload-|--upload-p|--upload-pa|=
\
   --upload-pac|--upload-pack)
 	shift
-	exec=3D"--exec=3D$1"
+	exec=3D"--upload-pack=3D$1"
 	shift;;
   --)
   shift; break ;;
--=20
1.5.0.rc1.g581a


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D2004+in+roman+numerals
