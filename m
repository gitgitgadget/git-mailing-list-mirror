From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] git add: add long equivalents of '-u' and '-f' options
Date: Sat, 14 Jun 2008 11:48:00 +0200
Message-ID: <1213436881-2360-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7SNa-0005X4-KL
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338AbYFNJsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbYFNJsH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:48:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52859 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129AbYFNJsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:48:06 -0400
Received: from [127.0.1.1] (p5B131E03.dip0.t-ipconnect.de [91.19.30.3])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1K7SMb1wCU-00018f; Sat, 14 Jun 2008 11:48:02 +0200
X-Mailer: git-send-email 1.5.6.rc2.55.g9b8c
X-Provags-ID: V01U2FsdGVkX1+t01qMXBrjtn9S5aN+S26zZSFDSKtzRZBdM1f
 pPvfQXKFmTXVKZDEVVKiCneLgq4rclDVSsC67HWL/IxXsn6wYR
 jzWZ0e0wRnUb4ZRy1zm7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85004>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-add.txt |    7 +++++--
 builtin-add.c             |    4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c6b081..b8e3fa6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -8,8 +8,9 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [verse]
-'git-add' [-n] [-v] [-f] [--interactive | -i] [--patch | -p] [-u] [--r=
efresh]
-	  [--ignore-errors] [--] <filepattern>...
+'git-add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
+	  [--update | -u] [--refresh] [--ignore-errors] [--]
+	  <filepattern>...
=20
 DESCRIPTION
 -----------
@@ -59,6 +60,7 @@ OPTIONS
         Be verbose.
=20
 -f::
+--force::
 	Allow adding otherwise ignored files.
=20
 -i::
@@ -75,6 +77,7 @@ OPTIONS
 	the specified filepatterns before exiting.
=20
 -u::
+--update::
 	Update only files that git already knows about, staging modified
 	content for commit and marking deleted files for removal. This
 	is similar
diff --git a/builtin-add.c b/builtin-add.c
index 1da22ee..9930cf5 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -200,8 +200,8 @@ static struct option builtin_add_options[] =3D {
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive pickin=
g"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching")=
,
-	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored =
files"),
-	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"=
),
+	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignor=
ed files"),
+	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked fi=
les"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh t=
he index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip file=
s which cannot be added because of errors"),
 	OPT_END(),
--=20
1.5.6.rc2.55.g9b8c
