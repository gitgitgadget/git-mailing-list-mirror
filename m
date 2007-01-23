From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] rename --exec to --upload-pack for fetch-pack and peek-remote
Date: Tue, 23 Jan 2007 09:20:17 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070123082017.GA10007@cepheus>
References: <7v7ivihldu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 23 09:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9GtO-00072s-US
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 09:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbXAWIUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 03:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902AbXAWIUX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 03:20:23 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58143 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932903AbXAWIUW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 03:20:22 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9GtB-0002im-37
	for git@vger.kernel.org; Tue, 23 Jan 2007 09:20:21 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0N8KIIF005859
	for <git@vger.kernel.org>; Tue, 23 Jan 2007 09:20:18 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0N8KItd005858
	for git@vger.kernel.org; Tue, 23 Jan 2007 09:20:18 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ivihldu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37488>

Just some option name disambiguation.  This is the counter part to comm=
it
d23842fd53e61f32c189a6ec902c4133abf29878 which made a similar change fo=
r push
and send-pack.

--exec continues to work.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 Documentation/git-fetch-pack.txt  |    7 +++++--
 Documentation/git-peek-remote.txt |    7 +++++--
 fetch-pack.c                      |   12 ++++++++----
 peek-remote.c                     |   12 ++++++++----
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index bd8ebac..105d76b 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -8,7 +8,7 @@ git-fetch-pack - Receive missing objects from another r=
epository
=20
 SYNOPSIS
 --------
-'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--exec=3D<=
git-upload-pack>] [--depth=3D<n>] [-v] [<host>:]<directory> [<refs>...]
+'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-p=
ack=3D<git-upload-pack>] [--depth=3D<n>] [-v] [<host>:]<directory> [<re=
fs>...]
=20
 DESCRIPTION
 -----------
@@ -45,7 +45,7 @@ OPTIONS
 	Spend extra cycles to minimize the number of objects to be sent.
 	Use it on slower connection.
=20
-\--exec=3D<git-upload-pack>::
+\--upload-pack=3D<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if is not found on your $PATH.
 	Installations of sshd ignores the user's environment
@@ -57,6 +57,9 @@ OPTIONS
 	shells by having a lean .bashrc file (they set most of
 	the things up in .bash_profile).
=20
+\--exec=3D<git-upload-pack>::
+	Same as \--upload-pack=3D<git-upload-pack>.
+
 \--depth=3D<n>::
 	Limit fetching to ancestor-chains not longer than n.
=20
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek=
-remote.txt
index ac57cda..74f37bd 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -8,7 +8,7 @@ git-peek-remote - List the references in a remote repos=
itory
=20
 SYNOPSIS
 --------
-'git-peek-remote' [--exec=3D<git-upload-pack>] [<host>:]<directory>
+'git-peek-remote' [--upload-pack=3D<git-upload-pack>] [<host>:]<direct=
ory>
=20
 DESCRIPTION
 -----------
@@ -17,7 +17,7 @@ stores them in the local repository under the same na=
me.
=20
 OPTIONS
 -------
---exec=3D<git-upload-pack>::
+\--upload-pack=3D<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if it is not found on your $PATH. Some
 	installations of sshd ignores the user's environment
@@ -29,6 +29,9 @@ OPTIONS
 	shells, but prefer having a lean .bashrc file (they set most of
 	the things up in .bash_profile).
=20
+\--exec=3D<git-upload-pack>::
+	Same \--upload-pack=3D<git-upload-pack>.
+
 <host>::
 	A remote host that houses the repository.  When this
 	part is specified, 'git-upload-pack' is invoked via
diff --git a/fetch-pack.c b/fetch-pack.c
index 726140a..3546aef 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -12,8 +12,8 @@ static int verbose;
 static int fetch_all;
 static int depth;
 static const char fetch_pack_usage[] =3D
-"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--exec=3D<g=
it-upload-pack>] [--depth=3D<n>] [-v] [<host>:]<directory> [<refs>...]"=
;
-static const char *exec =3D "git-upload-pack";
+"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pa=
ck=3D<git-upload-pack>] [--depth=3D<n>] [-v] [<host>:]<directory> [<ref=
s>...]";
+static const char *uploadpack =3D "git-upload-pack";
=20
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -643,8 +643,12 @@ int main(int argc, char **argv)
 		char *arg =3D argv[i];
=20
 		if (*arg =3D=3D '-') {
+			if (!strncmp("--upload-pack=3D", arg, 14)) {
+				uploadpack =3D arg + 14;
+				continue;
+			}
 			if (!strncmp("--exec=3D", arg, 7)) {
-				exec =3D arg + 7;
+				uploadpack =3D arg + 7;
 				continue;
 			}
 			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -682,7 +686,7 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	pid =3D git_connect(fd, dest, exec);
+	pid =3D git_connect(fd, dest, uploadpack);
 	if (pid < 0)
 		return 1;
 	if (heads && nr_heads)
diff --git a/peek-remote.c b/peek-remote.c
index 353da00..ef3c76c 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -3,8 +3,8 @@
 #include "pkt-line.h"
=20
 static const char peek_remote_usage[] =3D
-"git-peek-remote [--exec=3Dupload-pack] [host:]directory";
-static const char *exec =3D "git-upload-pack";
+"git-peek-remote [--upload-pack=3D<git-upload-pack>] [<host>:]<directo=
ry>";
+static const char *uploadpack =3D "git-upload-pack";
=20
 static int peek_remote(int fd[2], unsigned flags)
 {
@@ -35,8 +35,12 @@ int main(int argc, char **argv)
 		char *arg =3D argv[i];
=20
 		if (*arg =3D=3D '-') {
+			if (!strncmp("--upload-pack=3D", arg, 14)) {
+				uploadpack =3D arg + 14;
+				continue;
+			}
 			if (!strncmp("--exec=3D", arg, 7)) {
-				exec =3D arg + 7;
+				uploadpack =3D arg + 7;
 				continue;
 			}
 			if (!strcmp("--tags", arg)) {
@@ -60,7 +64,7 @@ int main(int argc, char **argv)
 	if (!dest || i !=3D argc - 1)
 		usage(peek_remote_usage);
=20
-	pid =3D git_connect(fd, dest, exec);
+	pid =3D git_connect(fd, dest, uploadpack);
 	if (pid < 0)
 		return 1;
 	ret =3D peek_remote(fd, flags);
--=20
1.5.0.rc1.g581a


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+hertz+in+sec**-1
