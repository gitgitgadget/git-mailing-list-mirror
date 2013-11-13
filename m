From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH] Fix single quotes, AsciiDoc escaping, and other formatting/grammatical issues
Date: Wed, 13 Nov 2013 00:19:11 -0500
Message-ID: <1384319951-31321-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 06:19:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgSrH-0003bU-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 06:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab3KMFTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 00:19:16 -0500
Received: from mailhub129.itcs.purdue.edu ([128.210.5.129]:43720 "EHLO
	mailhub129.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab3KMFTO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Nov 2013 00:19:14 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-041-152.itap.purdue.edu [10.184.41.152])
	(authenticated bits=0)
	by mailhub129.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAD5JD7C015829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Nov 2013 00:19:13 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237774>

rev-list-options.txt:
-- added line breaks before some "endif" AsciiDoc commands to fix syntax
     highlighting in Vim
-- added line breaks after some options subheadings to fix syntax
     highlighting in Vim
-- added backticks around options/commands that were missing it
-- removed AsciiDoc escapes for "--" in options/commands
-- replaced single quotes around options/commands with backticks
-- replaced "regexp" with "regular expression(s)" where appropriate
-- added backticks around a file path to /dev/null
-- replaced some double quotes with proper AsciiDoc quotes (e.g.
     ``foo'')
-- slightly reworded some sentences for easier reading
-- fix some typos (e.g. "show" -> "shown")

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
This is a resubmit of patch 2/4 from my earlier patchset:
http://marc.info/?l=git&m=138395814108214&w=2


 Documentation/rev-list-options.txt | 136 +++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 60 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ec86d09..a7d2c5d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -40,6 +40,7 @@ ifdef::git-rev-list[]
 --min-age=<timestamp>::
 
 	Limit the commits output to specified time range.
+
 endif::git-rev-list[]
 
 --author=<pattern>::
@@ -71,13 +72,15 @@ When `--show-notes` is in effect, the message from the notes as
 if it is part of the log message.
 
 --all-match::
-	Limit the commits output to ones that match all given --grep,
+
+	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
 -i::
 --regexp-ignore-case::
 
-	Match the regexp limiting patterns without regard to letters case.
+	Match the regular expression limiting patterns without regard to
+	letter case.
 
 --basic-regexp::
 
@@ -98,7 +101,7 @@ if it is part of the log message.
 
 --perl-regexp::
 
-	Consider the limiting patterns to be Perl-compatible regexp.
+	Consider the limiting patterns to be Perl-compatible regular expressions.
 	Requires libpcre to be compiled in.
 
 --remove-empty::
@@ -129,6 +132,7 @@ again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
 parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
 --first-parent::
+
 	Follow only the first parent commit upon seeing a merge
 	commit.  This option can give a better overview when
 	viewing the evolution of a particular topic branch,
@@ -140,7 +144,7 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 --not::
 
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-	for all following revision specifiers, up to the next '--not'.
+	for all following revision specifiers, up to the next `--not`.
 
 --all::
 
@@ -169,6 +173,7 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	If pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
 --glob=<glob-pattern>::
+
 	Pretend as if all the refs matching shell glob '<glob-pattern>'
 	are listed on the command line as '<commit>'. Leading 'refs/',
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
@@ -186,6 +191,7 @@ ifndef::git-rev-list[]
 	was listed and as if it was followed by `--not` and the good
 	bisection refs `refs/bisect/good-*` on the command
 	line.
+
 endif::git-rev-list[]
 
 --stdin::
@@ -202,7 +208,8 @@ ifdef::git-rev-list[]
 	is primarily meant to allow the caller to
 	test the exit status to see if a range of objects is fully
 	connected (or not).  It is faster than redirecting stdout
-	to /dev/null as the output does not have to be formatted.
+	to `/dev/null` as the output does not have to be formatted.
+
 endif::git-rev-list[]
 
 --cherry-mark::
@@ -213,15 +220,15 @@ endif::git-rev-list[]
 --cherry-pick::
 
 	Omit any commit that introduces the same change as
-	another commit on the "other side" when the set of
+	another commit on the ``other side'' when the set of
 	commits are limited with symmetric difference.
 +
 For example, if you have two branches, `A` and `B`, a usual way
 to list all commits on only one side of them is with
 `--left-right` (see the example below in the description of
-the `--left-right` option).  It however shows the commits that were cherry-picked
-from the other branch (for example, "3rd on b" may be cherry-picked
-from branch A).  With this option, such pairs of commits are
+the `--left-right` option). However, it shows the commits that were
+cherry-picked from the other branch (for example, "3rd on b" may be
+cherry-picked from branch A). With this option, such pairs of commits are
 excluded from the output.
 
 --left-only::
@@ -254,14 +261,14 @@ list.
 	exclude (that is, '{caret}commit', 'commit1..commit2',
 	nor 'commit1\...commit2' notations cannot be used).
 +
-With '\--pretty' format other than oneline (for obvious reasons),
+With `--pretty` format other than `oneline` (for obvious reasons),
 this causes the output to have two extra lines of information
 taken from the reflog.  By default, 'commit@\{Nth}' notation is
 used in the output.  When the starting commit is specified as
 'commit@\{now}', output also uses 'commit@\{timestamp}' notation
-instead.  Under '\--pretty=oneline', the commit message is
+instead.  Under `--pretty=oneline`, the commit message is
 prefixed with this information on the same line.
-This option cannot be combined with '\--reverse'.
+This option cannot be combined with `--reverse`.
 See also linkgit:git-reflog[1].
 
 --merge::
@@ -320,7 +327,7 @@ Default mode::
 
 --simplify-merges::
 
-	Additional option to '--full-history' to remove some needless
+	Additional option to `--full-history` to remove some needless
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.
 
@@ -352,36 +359,36 @@ The horizontal line of history A---Q is taken to be the first parent of
 each merge.  The commits are:
 
 * `I` is the initial commit, in which `foo` exists with contents
-  "asdf", and a file `quux` exists with contents "quux".  Initial
+  ``asdf'', and a file `quux` exists with contents ``quux''. Initial
   commits are compared to an empty tree, so `I` is !TREESAME.
 
-* In `A`, `foo` contains just "foo".
+* In `A`, `foo` contains just ``foo''.
 
 * `B` contains the same change as `A`.  Its merge `M` is trivial and
   hence TREESAME to all parents.
 
-* `C` does not change `foo`, but its merge `N` changes it to "foobar",
+* `C` does not change `foo`, but its merge `N` changes it to ``foobar'',
   so it is not TREESAME to any parent.
 
-* `D` sets `foo` to "baz".  Its merge `O` combines the strings from
-  `N` and `D` to "foobarbaz"; i.e., it is not TREESAME to any parent.
+* `D` sets `foo` to ``baz''. Its merge `O` combines the strings from
+  `N` and `D` to ``foobarbaz''; i.e., it is not TREESAME to any parent.
 
-* `E` changes `quux` to "xyzzy", and its merge `P` combines the
-  strings to "quux xyzzy".  `P` is TREESAME to `O`, but not to `E`.
+* `E` changes `quux` to ``xyzzy'', and its merge `P` combines the
+  strings to ``quux xyzzy''. `P` is TREESAME to `O`, but not to `E`.
 
 * `X` is an independent root commit that added a new file `side`, and `Y`
   modified it. `Y` is TREESAME to `X`. Its merge `Q` added `side` to `P`, and
   `Q` is TREESAME to `P`, but not to `Y`.
 
-'rev-list' walks backwards through history, including or excluding
-commits based on whether '\--full-history' and/or parent rewriting
-(via '\--parents' or '\--children') are used.  The following settings
+`rev-list` walks backwards through history, including or excluding
+commits based on whether `--full-history` and/or parent rewriting
+(via `--parents` or `--children`) are used.  The following settings
 are available.
 
 Default mode::
 
 	Commits are included if they are not TREESAME to any parent
-	(though this can be changed, see '\--sparse' below).  If the
+	(though this can be changed, see `--sparse` below).  If the
 	commit was a merge, and it was TREESAME to one parent, follow
 	only that parent.  (Even if there are several TREESAME
 	parents, follow only one of them.)  Otherwise, follow all
@@ -400,7 +407,7 @@ available, removed `B` from consideration entirely.  `C` was
 considered via `N`, but is TREESAME.  Root commits are compared to an
 empty tree, so `I` is !TREESAME.
 +
-Parent/child relations are only visible with --parents, but that does
+Parent/child relations are only visible with `--parents`, but that does
 not affect the commits selected in default mode, so we have shown the
 parent lines.
 
@@ -427,7 +434,7 @@ them disconnected.
 --full-history with parent rewriting::
 
 	Ordinary commits are only included if they are !TREESAME
-	(though this can be changed, see '\--sparse' below).
+	(though this can be changed, see `--sparse` below).
 +
 Merges are always included.  However, their parent list is rewritten:
 Along each parent, prune away commits that are not included
@@ -441,7 +448,7 @@ themselves.  This results in
 	  `-------------'
 -----------------------------------------------------------------------
 +
-Compare to '\--full-history' without rewriting above.  Note that `E`
+Compare to `--full-history` without rewriting above.  Note that `E`
 was pruned away because it is TREESAME, but the parent list of P was
 rewritten to contain `E`'s parent `I`.  The same happened for `C` and
 `N`, and `X`, `Y` and `Q`.
@@ -458,14 +465,14 @@ affects inclusion:
 
 	All commits that are walked are included.
 +
-Note that without '\--full-history', this still simplifies merges: if
+Note that without `--full-history`, this still simplifies merges: if
 one of the parents is TREESAME, we follow only that one, so the other
 sides of the merge are never walked.
 
 --simplify-merges::
 
 	First, build a history graph in the same way that
-	'\--full-history' with parent rewriting does (see above).
+	`--full-history` with parent rewriting does (see above).
 +
 Then simplify each commit `C` to its replacement `C'` in the final
 history according to the following rules:
@@ -484,7 +491,7 @@ history according to the following rules:
 --
 +
 The effect of this is best shown by way of comparing to
-'\--full-history' with parent rewriting.  The example turns into:
+`--full-history` with parent rewriting.  The example turns into:
 +
 -----------------------------------------------------------------------
 	  .-A---M---N---O
@@ -494,7 +501,7 @@ The effect of this is best shown by way of comparing to
 	  `---------'
 -----------------------------------------------------------------------
 +
-Note the major differences in `N`, `P` and `Q` over '--full-history':
+Note the major differences in `N`, `P` and `Q` over `--full-history`:
 +
 --
 * `N`'s parent list had `I` removed, because it is an ancestor of the
@@ -513,9 +520,9 @@ Finally, there is a fifth simplification mode available:
 --ancestry-path::
 
 	Limit the displayed commits to those directly on the ancestry
-	chain between the "from" and "to" commits in the given commit
-	range. I.e. only display commits that are ancestor of the "to"
-	commit, and descendants of the "from" commit.
+	chain between the ``from'' and ``to'' commits in the given commit
+	range. I.e. only display commits that are ancestor of the ``to''
+	commit, and descendants of the ``from'' commit.
 +
 As an example use case, consider the following commit history:
 +
@@ -530,14 +537,14 @@ As an example use case, consider the following commit history:
 A regular 'D..M' computes the set of commits that are ancestors of `M`,
 but excludes the ones that are ancestors of `D`. This is useful to see
 what happened to the history leading to `M` since `D`, in the sense
-that "what does `M` have that did not exist in `D`". The result in this
+that ``what does `M` have that did not exist in `D`''. The result in this
 example would be all the commits, except `A` and `B` (and `D` itself,
 of course).
 +
 When we want to find out what commits in `M` are contaminated with the
 bug introduced by `D` and need fixing, however, we might want to view
 only the subset of 'D..M' that are actually descendants of `D`, i.e.
-excluding `C` and `K`. This is exactly what the '--ancestry-path'
+excluding `C` and `K`. This is exactly what the `--ancestry-path`
 option does. Applied to the 'D..M' range, it results in:
 +
 -----------------------------------------------------------------------
@@ -548,7 +555,7 @@ option does. Applied to the 'D..M' range, it results in:
 				L--M
 -----------------------------------------------------------------------
 
-The '\--simplify-by-decoration' option allows you to view only the
+The `--simplify-by-decoration` option allows you to view only the
 big picture of the topology of the history, by omitting commits
 that are not referenced by tags.  Commits are marked as !TREESAME
 (in other words, kept after history simplification rules described
@@ -622,14 +629,17 @@ Commit Ordering
 By default, the commits are shown in reverse chronological order.
 
 --date-order::
+
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the commit timestamp order.
 
 --author-date-order::
+
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the author timestamp order.
 
 --topo-order::
+
 	Show no parents before all of its children are shown, and
 	avoid showing commits on multiple lines of history
 	intermixed.
@@ -656,7 +666,7 @@ together.
 --reverse::
 
 	Output the commits in reverse order.
-	Cannot be combined with '\--walk-reflogs'.
+	Cannot be combined with `--walk-reflogs`.
 
 Object Traversal
 ~~~~~~~~~~~~~~~~
@@ -666,35 +676,35 @@ These options are mostly targeted for packing of Git repositories.
 --objects::
 
 	Print the object IDs of any object referenced by the listed
-	commits.  '--objects foo ^bar' thus means "send me
+	commits.  `--objects foo ^bar` thus means ``send me
 	all object IDs which I need to download if I have the commit
-	object 'bar', but not 'foo'".
+	object _bar_ but not _foo_''.
 
 --objects-edge::
 
-	Similar to '--objects', but also print the IDs of excluded
-	commits prefixed with a "-" character.  This is used by
-	linkgit:git-pack-objects[1] to build "thin" pack, which records
+	Similar to `--objects`, but also print the IDs of excluded
+	commits prefixed with a ``-'' character.  This is used by
+	linkgit:git-pack-objects[1] to build ``thin'' pack, which records
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
 --unpacked::
 
-	Only useful with '--objects'; print the object IDs that are not
+	Only useful with `--objects`; print the object IDs that are not
 	in packs.
 
 --no-walk[=(sorted|unsorted)]::
 
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
-	"unsorted" is given, the commits are show in the order they were
+	"unsorted" is given, the commits are shown in the order they were
 	given on the command line. Otherwise (if "sorted" or no argument
-	was given), the commits are show in reverse chronological order
+	was given), the commits are shown in reverse chronological order
 	by commit time.
 
 --do-walk::
 
-	Overrides a previous --no-walk.
+	Overrides a previous `--no-walk`.
 
 Commit Formatting
 ~~~~~~~~~~~~~~~~~
@@ -714,20 +724,20 @@ include::pretty-options.txt[]
 --date=(relative|local|default|iso|rfc|short|raw)::
 
 	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty". `log.date` config variable sets a default
-	value for log command's --date option.
+	as when using `--pretty`. `log.date` config variable sets a default
+	value for the log command's `--date` option.
 +
 `--date=relative` shows dates relative to the current time,
-e.g. "2 hours ago".
+e.g. ``2 hours ago''.
 +
 `--date=local` shows timestamps in user's local time zone.
 +
 `--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
 +
 `--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in E-mail messages.
+format, often found in e-mail messages.
 +
-`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
+`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
 +
 `--date=raw` shows the date in the internal raw Git format `%s %z` format.
 +
@@ -739,6 +749,7 @@ ifdef::git-rev-list[]
 
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
+
 endif::git-rev-list[]
 
 --parents::
@@ -753,7 +764,9 @@ endif::git-rev-list[]
 
 ifdef::git-rev-list[]
 --timestamp::
+
 	Print the raw commit timestamp.
+
 endif::git-rev-list[]
 
 --left-right::
@@ -795,18 +808,20 @@ you would get an output like this:
 +
 This enables parent rewriting, see 'History Simplification' below.
 +
-This implies the '--topo-order' option by default, but the
-'--date-order' option may also be specified.
+This implies the `--topo-order` option by default, but the
+`--date-order` option may also be specified.
 
 ifdef::git-rev-list[]
 --count::
+
 	Print a number stating how many commits would have been
 	listed, and suppress all other output.  When used together
-	with '--left-right', instead print the counts for left and
+	with `--left-right`, instead print the counts for left and
 	right commits, separated by a tab. When used together with
-	'--cherry-mark', omit patch equivalent commits from these
+	`--cherry-mark`, omit patch equivalent commits from these
 	counts and print the count for equivalent commits separated
 	by a tab.
+
 endif::git-rev-list[]
 
 
@@ -814,7 +829,7 @@ ifndef::git-rev-list[]
 Diff Formatting
 ~~~~~~~~~~~~~~~
 
-Below are listed options that control the formatting of diff output.
+Listed below are options that control the formatting of diff output.
 Some of them are specific to linkgit:git-rev-list[1], however other diff
 options may be given. See linkgit:git-diff-files[1] for more options.
 
@@ -828,7 +843,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 
 --cc::
 
-	This flag implies the '-c' option and further compresses the
+	This flag implies the `-c` option and further compresses the
 	patch output by omitting uninteresting hunks whose contents in
 	the parents have only two variants and the merge result picks
 	one of them without modification.
@@ -838,7 +853,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	This flag makes the merge commits show the full diff like
 	regular commits; for each merge parent, a separate log entry
 	and diff is generated. An exception is that only diff against
-	the first parent is shown when '--first-parent' option is given;
+	the first parent is shown when `--first-parent` option is given;
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
@@ -848,5 +863,6 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 
 -t::
 
-	Show the tree objects in the diff output. This implies '-r'.
+	Show the tree objects in the diff output. This implies `-r`.
+
 endif::git-rev-list[]
-- 
1.8.4.2
