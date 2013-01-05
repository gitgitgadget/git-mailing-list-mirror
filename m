From: esr@thyrsus.com (Eric S. Raymond)
Subject: [PATCH] Alphabetize the fast-import options, following a suggestion
 on the list.
Date: Sat,  5 Jan 2013 11:44:15 -0500 (EST)
Message-ID: <20130105164415.39B144044B@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 17:44:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrWrS-0006we-4Z
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 17:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab3AEQoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 11:44:21 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54243
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab3AEQoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 11:44:20 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 39B144044B; Sat,  5 Jan 2013 11:44:15 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212704>

---
 Documentation/git-fast-import.txt | 94 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 68bca1a..d006bcf 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -33,24 +33,9 @@ the frontend program in use.
 
 OPTIONS
 -------
---date-format=<fmt>::
-	Specify the type of dates the frontend will supply to
-	fast-import within `author`, `committer` and `tagger` commands.
-	See ``Date Formats'' below for details about which formats
-	are supported, and their syntax.
-
--- done::
-	Terminate with error if there is no 'done' command at the
-	end of the stream.
-
---force::
-	Force updating modified existing branches, even if doing
-	so would cause commits to be lost (as the new commit does
-	not contain the old commit).
-
---max-pack-size=<n>::
-	Maximum size of each output packfile.
-	The default is unlimited.
+--active-branches=<n>::
+	Maximum number of branches to maintain active at once.
+	See ``Memory Utilization'' below for details.  Default is 5.
 
 --big-file-threshold=<n>::
 	Maximum size of a blob that fast-import will attempt to
@@ -58,13 +43,27 @@ OPTIONS
 	(512 MiB).  Some importers may wish to lower this on systems
 	with constrained memory.
 
+--cat-blob-fd=<fd>::
+	Write responses to `cat-blob` and `ls` queries to the
+	file descriptor <fd> instead of `stdout`.  Allows `progress`
+	output intended for the end-user to be separated from other
+	output.
+
+--date-format=<fmt>::
+	Specify the type of dates the frontend will supply to
+	fast-import within `author`, `committer` and `tagger` commands.
+	See ``Date Formats'' below for details about which formats
+	are supported, and their syntax.
+
 --depth=<n>::
 	Maximum delta depth, for blob and tree deltification.
 	Default is 10.
 
---active-branches=<n>::
-	Maximum number of branches to maintain active at once.
-	See ``Memory Utilization'' below for details.  Default is 5.
+--done::
+	Terminate with error if there is no 'done' command at the end
+	of the stream.  This option might be useful for detecting
+	errors that cause the frontend to terminate before it has
+	started to write a stream.
 
 --export-marks=<file>::
 	Dumps the internal marks table to <file> when complete.
@@ -75,6 +74,20 @@ OPTIONS
 	at checkpoint (or completion) the same path can also be
 	safely given to \--import-marks.
 
+--export-pack-edges=<file>::
+	After creating a packfile, print a line of data to
+	<file> listing the filename of the packfile and the last
+	commit on each branch that was written to that packfile.
+	This information may be useful after importing projects
+	whose total object set exceeds the 4 GiB packfile limit,
+	as these commits can be used as edge points during calls
+	to 'git pack-objects'.
+
+--force::
+	Force updating modified existing branches, even if doing
+	so would cause commits to be lost (as the new commit does
+	not contain the old commit).
+
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
@@ -87,13 +100,9 @@ OPTIONS
 	Like --import-marks but instead of erroring out, silently
 	skips the file if it does not exist.
 
---relative-marks::
-	After specifying --relative-marks the paths specified
-	with --import-marks= and --export-marks= are relative
-	to an internal directory in the current repository.
-	In git-fast-import this means that the paths are relative
-	to the .git/info/fast-import directory. However, other
-	importers may use a different location.
+--max-pack-size=<n>::
+	Maximum size of each output packfile.
+	The default is unlimited.
 
 --no-relative-marks::
 	Negates a previous --relative-marks. Allows for combining
@@ -101,32 +110,19 @@ OPTIONS
 	--(no-)-relative-marks with the --(import|export)-marks=
 	options.
 
---cat-blob-fd=<fd>::
-	Write responses to `cat-blob` and `ls` queries to the
-	file descriptor <fd> instead of `stdout`.  Allows `progress`
-	output intended for the end-user to be separated from other
-	output.
-
---done::
-	Require a `done` command at the end of the stream.
-	This option might be useful for detecting errors that
-	cause the frontend to terminate before it has started to
-	write a stream.
-
---export-pack-edges=<file>::
-	After creating a packfile, print a line of data to
-	<file> listing the filename of the packfile and the last
-	commit on each branch that was written to that packfile.
-	This information may be useful after importing projects
-	whose total object set exceeds the 4 GiB packfile limit,
-	as these commits can be used as edge points during calls
-	to 'git pack-objects'.
-
 --quiet::
 	Disable all non-fatal output, making fast-import silent when it
 	is successful.  This option disables the output shown by
 	\--stats.
 
+--relative-marks::
+	After specifying --relative-marks the paths specified
+	with --import-marks= and --export-marks= are relative
+	to an internal directory in the current repository.
+	In git-fast-import this means that the paths are relative
+	to the .git/info/fast-import directory. However, other
+	importers may use a different location.
+
 --stats::
 	Display some basic statistics about the objects fast-import has
 	created, the packfiles they were stored into, and the
-- 
1.8.1



-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

"Gun control" is a job-safety program for criminals.
