From: jari.aalto@cante.net
Subject: [PATCH] git-add.txt: Order options alphabetically
Date: Wed,  1 Dec 2010 17:42:25 +0200
Organization: Private
Message-ID: <1291218145-13016-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:42:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNopG-0002SI-O9
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab0LAPm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:42:29 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:42278 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0LAPm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:42:29 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id C4C50EBC73
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:42:27 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A019ADB9FFF; Wed, 01 Dec 2010 17:42:27 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id ABD4141BE4
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:42:26 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNop8-0003OM-02; Wed, 01 Dec 2010 17:42:26 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162535>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-add.txt |  106 ++++++++++++++++++++++-----------------=
-----
 1 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 54aaaeb..83751c6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -46,24 +46,26 @@ be used to add ignored files with the `-f` (force) op=
tion.
 Please see linkgit:git-commit[1] for alternative ways to add content to =
a
 commit.
=20
-
 OPTIONS
 -------
-<filepattern>...::
-	Files to add content from.  Fileglobs (e.g. `*.c`) can
-	be given to add all matching files.  Also a
-	leading directory name (e.g. `dir` to add `dir/file1`
-	and `dir/file2`) can be given to add all files in the
-	directory, recursively.
=20
--n::
---dry-run::
-	Don't actually add the file(s), just show if they exist and/or will
-	be ignored.
+-A::
+--all::
+	Like `-u`, but match <filepattern> against files in the
+	working tree in addition to the index. That means that it
+	will find new files as well as staging modified content and
+	removing files that are no longer in the working tree.
=20
--v::
---verbose::
-        Be verbose.
+-e, \--edit::
+	Open the diff vs. the index in an editor and let the user
+	edit it.  After the editor was closed, adjust the hunk headers
+	and apply the patch to the index.
++
+The intent of this option is to pick and choose lines of the patch to
+apply, or even to modify the contents of lines to be staged. This can be
+quicker and more flexible than using the interactive hunk selector.
+However, it is easy to confuse oneself and create a patch that does not
+apply to the index. See EDITING PATCHES below.
=20
 -f::
 --force::
@@ -76,6 +78,30 @@ OPTIONS
 	operation to a subset of the working tree. See ``Interactive
 	mode'' for details.
=20
+--ignore-errors::
+	If some files could not be added because of errors indexing
+	them, do not abort the operation, but continue adding the
+	others. The command shall still exit with non-zero status.
+
+--ignore-missing::
+	This option can only be used together with --dry-run. By using
+	this option the user can check if any of the given files would
+	be ignored, no matter if they are already present in the work
+	tree or not.
+
+-n::
+--dry-run::
+	Don't actually add the file(s), just show if they exist and/or will
+	be ignored.
+
+-N::
+--intent-to-add::
+	Record only the fact that the path will be added later. An entry
+	for the path is placed in the index with no content. This is
+	useful for, among other things, showing the unstaged content of
+	such files with `git diff` and committing them with `git commit
+	-a`.
+
 -p::
 --patch::
 	Interactively choose hunks of patch between the index and the
@@ -87,16 +113,9 @@ This effectively runs `add --interactive`, but bypass=
es the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
=20
--e, \--edit::
-	Open the diff vs. the index in an editor and let the user
-	edit it.  After the editor was closed, adjust the hunk headers
-	and apply the patch to the index.
-+
-The intent of this option is to pick and choose lines of the patch to
-apply, or even to modify the contents of lines to be staged. This can be
-quicker and more flexible than using the interactive hunk selector.
-However, it is easy to confuse oneself and create a patch that does not
-apply to the index. See EDITING PATCHES below.
+--refresh::
+	Don't add the file(s), but only refresh their stat()
+	information in the index.
=20
 -u::
 --update::
@@ -111,41 +130,22 @@ If no <filepattern> is given, default to "."; in ot=
her words,
 update all tracked files in the current directory and its
 subdirectories.
=20
--A::
---all::
-	Like `-u`, but match <filepattern> against files in the
-	working tree in addition to the index. That means that it
-	will find new files as well as staging modified content and
-	removing files that are no longer in the working tree.
-
--N::
---intent-to-add::
-	Record only the fact that the path will be added later. An entry
-	for the path is placed in the index with no content. This is
-	useful for, among other things, showing the unstaged content of
-	such files with `git diff` and committing them with `git commit
-	-a`.
-
---refresh::
-	Don't add the file(s), but only refresh their stat()
-	information in the index.
-
---ignore-errors::
-	If some files could not be added because of errors indexing
-	them, do not abort the operation, but continue adding the
-	others. The command shall still exit with non-zero status.
-
---ignore-missing::
-	This option can only be used together with --dry-run. By using
-	this option the user can check if any of the given files would
-	be ignored, no matter if they are already present in the work
-	tree or not.
+-v::
+--verbose::
+        Be verbose.
=20
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
=20
+<filepattern>...::
+	Files to add content from.  Fileglobs (e.g. `*.c`) can
+	be given to add all matching files.  Also a
+	leading directory name (e.g. `dir` to add `dir/file1`
+	and `dir/file2`) can be given to add all files in the
+	directory, recursively.
+
=20
 Configuration
 -------------
--=20
1.7.2.3
