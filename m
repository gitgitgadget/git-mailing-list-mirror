From: jari.aalto@cante.net
Subject: [PATCH] diff-options.txt: order options alphabetically
Date: Wed,  1 Dec 2010 21:20:22 +0200
Organization: Private
Message-ID: <1291231222-19015-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 20:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsED-0005RL-LM
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab0LATU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:20:28 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:39813 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab0LATU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:20:26 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id DC8A08C6D5
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 21:20:24 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00DC1D9110; Wed, 01 Dec 2010 21:20:24 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 6D7F1E51A9
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 21:20:23 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNsE2-0004xA-Lj; Wed, 01 Dec 2010 21:20:22 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162577>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/diff-options.txt |  565 +++++++++++++++++++++-------------=
------
 1 files changed, 295 insertions(+), 270 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.=
txt
index f3e9538..a3eb7d3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -12,47 +12,203 @@ endif::git-log[]
 endif::git-diff[]
 endif::git-format-patch[]
=20
-ifdef::git-format-patch[]
--p::
---no-stat::
-	Generate plain patches without any diffstats.
+-a::
+--text::
+	Treat all files as text.
+
+--abbrev[=3D<n>]::
+	Instead of showing the full 40-byte hexadecimal object
+	name in diff-raw format output and diff-tree header
+	lines, show only a partial prefix.  This is
+	independent of the `--full-index` option above, which controls
+	the diff-patch output format.  Non default number of
+	digits can be specified with `--abbrev=3D<n>`.
+
+-b::
+--ignore-space-change::
+	Ignore changes in amount of whitespace.  This ignores whitespace
+	at line end, and considers all other sequences of one or
+	more whitespace characters to be equivalent.
+
+-B[<n>][/<m>]::
+--break-rewrites[=3D[<n>][/<m>]]::
+	Break complete rewrite changes into pairs of delete and
+	create. This serves two purposes:
++
+It affects the way a change that amounts to a total rewrite of a file
+not as a series of deletion and insertion mixed together with a very
+few lines that happen to match textually as the context, but as a
+single deletion of everything old followed by a single insertion of
+everything new, and the number `m` controls this aspect of the -B
+option (defaults to 60%). `-B/70%` specifies that less than 30% of the
+original should remain in the result for git to consider it a total
+rewrite (i.e. otherwise the resulting patch will be a series of
+deletion and insertion mixed together with context lines).
++
+When used with -M, a totally-rewritten file is also considered as the
+source of a rename (usually -M only considers a file that disappeared
+as the source of a rename), and the number `n` controls this aspect of
+the -B option (defaults to 50%). `-B20%` specifies that a change with
+addition and deletion compared to 20% or more of the file's size are
+eligible for being picked up as a possible source of a rename to
+another file.
+
+--binary::
+	In addition to `--full-index`, output a binary diff that
+	can be applied with `git-apply`.
+
+-C[<n>]::
+--detect-copies[=3D<n>]::
+	Detect copies as well as renames.  See also `--find-copies-harder`.
+	If `n` is specified, it has the same meaning as for `-M<n>`.
+
+ifndef::git-format-patch[]
+--check::
+	Warn if changes introduce trailing whitespace
+	or an indent that uses a space before a tab. Exits with
+	non-zero status if problems are found. Not compatible with
+	--exit-code.
 endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
--p::
--u::
---patch::
-	Generate patch (see section on generating patches).
-	{git-diff? This is the default.}
+--color[=3D<when>]::
+--no-color::
+	Show colored diff.
+	The value must be always (the default), never, or auto.
+
+	Or turn off colored diff, even when the configuration file
+	gives the default to color output.
+	Same as `--color=3Dnever`.
 endif::git-format-patch[]
=20
--U<n>::
---unified=3D<n>::
-	Generate diffs with <n> lines of context instead of
-	the usual three.
 ifndef::git-format-patch[]
-	Implies `-p`.
+--color-words[=3D<regex>]::
+	Equivalent to `--word-diff=3Dcolor` plus (if a regex was
+	specified) `--word-diff-regex=3D<regex>`.
 endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
---raw::
-	Generate the raw format.
-	{git-diff-core? This is the default.}
+--diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]::
+	Select only files that are Added (`A`), Copied (`C`),
+	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
+	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
+	are Unmerged (`U`), are
+	Unknown (`X`), or have had their pairing Broken (`B`).
+	Any combination of the filter characters (including none) can be used.
+	When `*` (All-or-none) is added to the combination, all
+	paths are selected if there is any file that matches
+	other criteria in the comparison; if there is no file
+	that matches other criteria, nothing is selected.
 endif::git-format-patch[]
=20
+--dirstat[=3D<limit>]::
+	Output the distribution of relative amount of changes (number of lines =
added or
+	removed) for each sub-directory. Directories with changes below
+	a cut-off percent (3% by default) are not shown. The cut-off percent
+	can be set with `--dirstat=3D<limit>`. Changes in a child directory are=
 not
+	counted for the parent directory, unless `--cumulative` is used.
+
+--dirstat-by-file[=3D<limit>]::
+	Same as `--dirstat`, but counts changed files instead of lines.
+
+--dst-prefix=3D<prefix>::
+	Show the given destination prefix instead of "b/".
+
 ifndef::git-format-patch[]
---patch-with-raw::
-	Synonym for `-p --raw`.
+--exit-code::
+	Make the program exit with codes similar to diff(1).
+	That is, it exits with 1 if there were differences and
+	0 means no differences.
 endif::git-format-patch[]
=20
---patience::
-	Generate a diff using the "patience diff" algorithm.
+--ext-diff::
+	Allow an external diff helper to be executed. If you set an
+	external diff driver with linkgit:gitattributes[5], you need
+	to use this option with linkgit:git-log[1] and friends.
=20
---stat[=3D<width>[,<name-width>]]::
-	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by `--stat=3D<width>`.
-	The width of the filename part can be controlled by
-	giving another width to it separated by a comma.
+--find-copies-harder::
+	For performance reasons, by default, `-C` option finds copies only
+	if the original file of the copy was modified in the same
+	changeset.  This flag makes the command
+	inspect unmodified files as candidates for the source of
+	copy.  This is a very expensive operation for large
+	projects, so use it with caution.  Giving more than one
+	`-C` option has the same effect.
+
+--full-index::
+	Instead of the first handful of characters, show the full
+	pre- and post-image blob object names on the "index"
+	line when generating patch format output.
+
+ifndef::git-format-patch[]
+-G<regex>::
+	Look for differences whose added or removed line matches
+	the given <regex>.
+endif::git-format-patch[]
+
+--ignore-space-at-eol::
+	Ignore changes in whitespace at EOL.
+
+--ignore-submodules[=3D<when>]::
+	Ignore changes to submodules in the diff generation. <when> can be
+	either "none", "untracked", "dirty" or "all", which is the default
+	Using "none" will consider the submodule modified when it either contai=
ns
+	untracked or modified files or its HEAD differs from the commit recorde=
d
+	in the superproject and can be used to override any settings of the
+	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
+	"untracked" is used submodules are not considered dirty when they only
+	contain untracked content (but they are still scanned for modified
+	content). Using "dirty" ignores all changes to the work tree of submodu=
les,
+	only changes to the commits stored in the superproject are shown (this =
was
+	the behavior until 1.7.0). Using "all" hides all changes to submodules.
+
+--inter-hunk-context=3D<lines>::
+	Show the context between diff hunks, up to the specified number
+	of lines, thereby fusing hunks that are close to each other.
+
+-l<num>::
+	The `-M` and `-C` options require O(n^2) processing time where n
+	is the number of potential rename/copy targets.  This
+	option prevents rename/copy detection from running if
+	the number of rename/copy targets exceeds the specified
+	number.
+
+-M[<n>]::
+--detect-renames[=3D<n>]::
+ifndef::git-log[]
+	Detect renames.
+endif::git-log[]
+ifdef::git-log[]
+	If generating diffs, detect and report renames for each commit.
+	For following files across renames while traversing history, see
+	`--follow`.
+endif::git-log[]
+	If `n` is specified, it is a is a threshold on the similarity
+	index (i.e. amount of addition/deletions compared to the
+	file's size). For example, `-M90%` means git should consider a
+	delete/add pair to be a rename if more than 90% of the file
+	hasn't changed.
+
+ifndef::git-format-patch[]
+--name-only::
+	Show only names of changed files.
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+--name-status::
+	Show only names and status of changed files. See the description
+	of the `--diff-filter` option on what the status letters mean.
+endif::git-format-patch[]
+
+--no-ext-diff::
+	Disallow external diff drivers.
+
+--no-prefix::
+	Do not show any source or destination prefix.
+
+--no-renames::
+	Turn off rename detection, even when the configuration
+	file gives the default to do so.
=20
 --numstat::
 	Similar to `\--stat`, but shows number of added and
@@ -61,72 +217,127 @@ endif::git-format-patch[]
 	binary files, outputs two `-` instead of saying
 	`0 0`.
=20
---shortstat::
-	Output only the last line of the `--stat` format containing total
-	number of modified files, as well as number of added and deleted
-	lines.
+-O<orderfile>::
+	Output the patch in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
=20
---dirstat[=3D<limit>]::
-	Output the distribution of relative amount of changes (number of lines =
added or
-	removed) for each sub-directory. Directories with changes below
-	a cut-off percent (3% by default) are not shown. The cut-off percent
-	can be set with `--dirstat=3D<limit>`. Changes in a child directory are=
 not
-	counted for the parent directory, unless `--cumulative` is used.
+ifndef::git-format-patch[]
+-p::
+-u::
+--patch::
+	Generate patch (see section on generating patches).
+	{git-diff? This is the default.}
+endif::git-format-patch[]
=20
---dirstat-by-file[=3D<limit>]::
-	Same as `--dirstat`, but counts changed files instead of lines.
+ifdef::git-format-patch[]
+-p::
+--no-stat::
+	Generate plain patches without any diffstats.
+endif::git-format-patch[]
=20
---summary::
-	Output a condensed summary of extended header information
-	such as creations, renames and mode changes.
+ifndef::git-format-patch[]
+--patch-with-raw::
+	Synonym for `-p --raw`.
+endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
 --patch-with-stat::
 	Synonym for `-p --stat`.
 endif::git-format-patch[]
=20
+--patience::
+	Generate a diff using the "patience diff" algorithm.
+
 ifndef::git-format-patch[]
+--pickaxe-all::
+	When `-S` or `-G` finds a change, show all the changes in that
+	changeset, not just the files that contain the change
+	in <string>.
+endif::git-format-patch[]
=20
--z::
-ifdef::git-log[]
-	Separate the commits with NULs instead of with new newlines.
-+
-Also, when `--raw` or `--numstat` has been given, do not munge
-pathnames and use NULs as output field terminators.
-endif::git-log[]
-ifndef::git-log[]
-	When `--raw`, `--numstat`, `--name-only` or `--name-status` has been
-	given, do not munge pathnames and use NULs as output field terminators.
-endif::git-log[]
-+
-Without this option, each pathname output will have TAB, LF, double quot=
es,
-and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
-respectively, and the pathname will be enclosed in double quotes if
-any of those replacements occurred.
+ifndef::git-format-patch[]
+--pickaxe-regex::
+	Make the <string> not a plain string but an extended POSIX
+	regex to match.
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+--quiet::
+	Disable all output of the program. Implies `--exit-code`.
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+-R::
+	Swap two inputs; that is, show differences from index or
+	on-disk file to tree contents.
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+--raw::
+	Generate the raw format.
+	{git-diff-core? This is the default.}
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+--relative[=3D<path>]::
+	When run from a subdirectory of the project, it can be
+	told to exclude changes outside the directory and show
+	pathnames relative to it with this option.  When you are
+	not in a subdirectory (e.g. in a bare repository), you
+	can name which subdirectory to make the output relative
+	to by giving a <path> as an argument.
+endif::git-format-patch[]
+
+ifndef::git-format-patch[]
+-S<string>::
+	Look for differences that introduce or remove an instance of
+	<string>. Note that this is different than the string simply
+	appearing in diff output; see the 'pickaxe' entry in
+	linkgit:gitdiffcore[7] for more details.
+endif::git-format-patch[]
+
+--stat[=3D<width>[,<name-width>]]::
+	Generate a diffstat.  You can override the default
+	output width for 80-column terminal by `--stat=3D<width>`.
+	The width of the filename part can be controlled by
+	giving another width to it separated by a comma.
=20
---name-only::
-	Show only names of changed files.
+--shortstat::
+	Output only the last line of the `--stat` format containing total
+	number of modified files, as well as number of added and deleted
+	lines.
=20
---name-status::
-	Show only names and status of changed files. See the description
-	of the `--diff-filter` option on what the status letters mean.
+--src-prefix=3D<prefix>::
+	Show the given source prefix instead of "a/".
=20
+ifndef::git-format-patch[]
 --submodule[=3D<format>]::
 	Chose the output format for submodule differences. <format> can be one =
of
 	'short' and 'log'. 'short' just shows pairs of commit names, this forma=
t
 	is used when this option is not given. 'log' is the default value for t=
his
 	option and lists the commits in that commit range like the 'summary'
 	option of linkgit:git-submodule[1] does.
+endif::git-format-patch[]
=20
---color[=3D<when>]::
-	Show colored diff.
-	The value must be always (the default), never, or auto.
+--summary::
+	Output a condensed summary of extended header information
+	such as creations, renames and mode changes.
=20
---no-color::
-	Turn off colored diff, even when the configuration file
-	gives the default to color output.
-	Same as `--color=3Dnever`.
+-U<n>::
+--unified=3D<n>::
+	Generate diffs with <n> lines of context instead of
+	the usual three.
+ifndef::git-format-patch[]
+	Implies `-p`.
+endif::git-format-patch[]
+
+-w::
+--ignore-all-space::
+	Ignore whitespace when comparing lines.  This ignores
+	differences even if one line has whitespace where the other
+	line has none.
=20
+ifndef::git-format-patch[]
 --word-diff[=3D<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
@@ -153,7 +364,9 @@ none::
 +
 Note that despite the name of the first mode, color is used to
 highlight the changed parts in all modes if enabled.
+endif::git-format-patch[]
=20
+ifndef::git-format-patch[]
 --word-diff-regex=3D<regex>::
 	Use <regex> to decide what a word is, instead of considering
 	runs of non-whitespace to be a word.  Also implies
@@ -171,214 +384,26 @@ The regex can also be set via a diff driver or con=
figuration option, see
 linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
-
---color-words[=3D<regex>]::
-	Equivalent to `--word-diff=3Dcolor` plus (if a regex was
-	specified) `--word-diff-regex=3D<regex>`.
 endif::git-format-patch[]
=20
---no-renames::
-	Turn off rename detection, even when the configuration
-	file gives the default to do so.
-
 ifndef::git-format-patch[]
---check::
-	Warn if changes introduce trailing whitespace
-	or an indent that uses a space before a tab. Exits with
-	non-zero status if problems are found. Not compatible with
-	--exit-code.
-endif::git-format-patch[]
-
---full-index::
-	Instead of the first handful of characters, show the full
-	pre- and post-image blob object names on the "index"
-	line when generating patch format output.
-
---binary::
-	In addition to `--full-index`, output a binary diff that
-	can be applied with `git-apply`.
-
---abbrev[=3D<n>]::
-	Instead of showing the full 40-byte hexadecimal object
-	name in diff-raw format output and diff-tree header
-	lines, show only a partial prefix.  This is
-	independent of the `--full-index` option above, which controls
-	the diff-patch output format.  Non default number of
-	digits can be specified with `--abbrev=3D<n>`.
-
--B[<n>][/<m>]::
---break-rewrites[=3D[<n>][/<m>]]::
-	Break complete rewrite changes into pairs of delete and
-	create. This serves two purposes:
-+
-It affects the way a change that amounts to a total rewrite of a file
-not as a series of deletion and insertion mixed together with a very
-few lines that happen to match textually as the context, but as a
-single deletion of everything old followed by a single insertion of
-everything new, and the number `m` controls this aspect of the -B
-option (defaults to 60%). `-B/70%` specifies that less than 30% of the
-original should remain in the result for git to consider it a total
-rewrite (i.e. otherwise the resulting patch will be a series of
-deletion and insertion mixed together with context lines).
+-z::
+ifdef::git-log[]
+	Separate the commits with NULs instead of with new newlines.
 +
-When used with -M, a totally-rewritten file is also considered as the
-source of a rename (usually -M only considers a file that disappeared
-as the source of a rename), and the number `n` controls this aspect of
-the -B option (defaults to 50%). `-B20%` specifies that a change with
-addition and deletion compared to 20% or more of the file's size are
-eligible for being picked up as a possible source of a rename to
-another file.
-
--M[<n>]::
---detect-renames[=3D<n>]::
-ifndef::git-log[]
-	Detect renames.
+Also, when `--raw` or `--numstat` has been given, do not munge
+pathnames and use NULs as output field terminators.
 endif::git-log[]
-ifdef::git-log[]
-	If generating diffs, detect and report renames for each commit.
-	For following files across renames while traversing history, see
-	`--follow`.
+ifndef::git-log[]
+	When `--raw`, `--numstat`, `--name-only` or `--name-status` has been
+	given, do not munge pathnames and use NULs as output field terminators.
 endif::git-log[]
-	If `n` is specified, it is a is a threshold on the similarity
-	index (i.e. amount of addition/deletions compared to the
-	file's size). For example, `-M90%` means git should consider a
-	delete/add pair to be a rename if more than 90% of the file
-	hasn't changed.
-
--C[<n>]::
---detect-copies[=3D<n>]::
-	Detect copies as well as renames.  See also `--find-copies-harder`.
-	If `n` is specified, it has the same meaning as for `-M<n>`.
-
---find-copies-harder::
-	For performance reasons, by default, `-C` option finds copies only
-	if the original file of the copy was modified in the same
-	changeset.  This flag makes the command
-	inspect unmodified files as candidates for the source of
-	copy.  This is a very expensive operation for large
-	projects, so use it with caution.  Giving more than one
-	`-C` option has the same effect.
-
--l<num>::
-	The `-M` and `-C` options require O(n^2) processing time where n
-	is the number of potential rename/copy targets.  This
-	option prevents rename/copy detection from running if
-	the number of rename/copy targets exceeds the specified
-	number.
-
-ifndef::git-format-patch[]
---diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]::
-	Select only files that are Added (`A`), Copied (`C`),
-	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
-	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
-	are Unmerged (`U`), are
-	Unknown (`X`), or have had their pairing Broken (`B`).
-	Any combination of the filter characters (including none) can be used.
-	When `*` (All-or-none) is added to the combination, all
-	paths are selected if there is any file that matches
-	other criteria in the comparison; if there is no file
-	that matches other criteria, nothing is selected.
-
--S<string>::
-	Look for differences that introduce or remove an instance of
-	<string>. Note that this is different than the string simply
-	appearing in diff output; see the 'pickaxe' entry in
-	linkgit:gitdiffcore[7] for more details.
-
--G<regex>::
-	Look for differences whose added or removed line matches
-	the given <regex>.
-
---pickaxe-all::
-	When `-S` or `-G` finds a change, show all the changes in that
-	changeset, not just the files that contain the change
-	in <string>.
-
---pickaxe-regex::
-	Make the <string> not a plain string but an extended POSIX
-	regex to match.
-endif::git-format-patch[]
-
--O<orderfile>::
-	Output the patch in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
-
-ifndef::git-format-patch[]
--R::
-	Swap two inputs; that is, show differences from index or
-	on-disk file to tree contents.
-
---relative[=3D<path>]::
-	When run from a subdirectory of the project, it can be
-	told to exclude changes outside the directory and show
-	pathnames relative to it with this option.  When you are
-	not in a subdirectory (e.g. in a bare repository), you
-	can name which subdirectory to make the output relative
-	to by giving a <path> as an argument.
-endif::git-format-patch[]
-
--a::
---text::
-	Treat all files as text.
-
---ignore-space-at-eol::
-	Ignore changes in whitespace at EOL.
-
--b::
---ignore-space-change::
-	Ignore changes in amount of whitespace.  This ignores whitespace
-	at line end, and considers all other sequences of one or
-	more whitespace characters to be equivalent.
-
--w::
---ignore-all-space::
-	Ignore whitespace when comparing lines.  This ignores
-	differences even if one line has whitespace where the other
-	line has none.
-
---inter-hunk-context=3D<lines>::
-	Show the context between diff hunks, up to the specified number
-	of lines, thereby fusing hunks that are close to each other.
-
-ifndef::git-format-patch[]
---exit-code::
-	Make the program exit with codes similar to diff(1).
-	That is, it exits with 1 if there were differences and
-	0 means no differences.
-
---quiet::
-	Disable all output of the program. Implies `--exit-code`.
++
+Without this option, each pathname output will have TAB, LF, double quot=
es,
+and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
+respectively, and the pathname will be enclosed in double quotes if
+any of those replacements occurred.
 endif::git-format-patch[]
=20
---ext-diff::
-	Allow an external diff helper to be executed. If you set an
-	external diff driver with linkgit:gitattributes[5], you need
-	to use this option with linkgit:git-log[1] and friends.
-
---no-ext-diff::
-	Disallow external diff drivers.
-
---ignore-submodules[=3D<when>]::
-	Ignore changes to submodules in the diff generation. <when> can be
-	either "none", "untracked", "dirty" or "all", which is the default
-	Using "none" will consider the submodule modified when it either contai=
ns
-	untracked or modified files or its HEAD differs from the commit recorde=
d
-	in the superproject and can be used to override any settings of the
-	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
-	"untracked" is used submodules are not considered dirty when they only
-	contain untracked content (but they are still scanned for modified
-	content). Using "dirty" ignores all changes to the work tree of submodu=
les,
-	only changes to the commits stored in the superproject are shown (this =
was
-	the behavior until 1.7.0). Using "all" hides all changes to submodules.
-
---src-prefix=3D<prefix>::
-	Show the given source prefix instead of "a/".
-
---dst-prefix=3D<prefix>::
-	Show the given destination prefix instead of "b/".
-
---no-prefix::
-	Do not show any source or destination prefix.
-
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
--=20
1.7.2.3
