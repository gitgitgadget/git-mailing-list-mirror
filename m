From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] doc: convert \--option to --option
Date: Wed, 13 May 2015 01:01:38 -0400
Message-ID: <20150513050137.GF6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 07:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOni-0008Ur-BD
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbbEMFBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:01:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:57618 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751005AbbEMFBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:01:40 -0400
Received: (qmail 2136 invoked by uid 102); 13 May 2015 05:01:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:01:40 -0500
Received: (qmail 6985 invoked by uid 107); 13 May 2015 05:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 01:01:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 01:01:38 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268932>

Older versions of AsciiDoc would convert the "--" in
"--option" into an emdash. According to 565e135
(Documentation: quote double-dash for AsciiDoc, 2011-06-29),
this is fixed in AsciiDoc 8.3.0. According to bf17126, we
don't support anything older than 8.4.1 anyway, so we no
longer need to worry about quoting.

Even though this does not change the output at all, there
are a few good reasons to drop the quoting:

  1. It makes the source prettier to read.

  2. We don't quote consistently, which may be confusing when
     reading the source.

  3. Asciidoctor does not like the quoting, and renders a
     literal backslash.

Signed-off-by: Jeff King <peff@peff.net>
---
So this is the first of the more questionable patches, simply because we
are appeasing Asciidoctor, but not fixing the root problem (i.e., there
are still lots of places where the backslash quoting is messed up, like
HEAD@\{yesterday}). So I suspect we need to figure that problem out, and
then the asciidoctor issues will just go away. However, I think this may
be worth doing just to prettify the source.

 Documentation/config.txt           | 10 ++--
 Documentation/git-fast-export.txt  |  6 +--
 Documentation/git-fast-import.txt  | 28 +++++------
 Documentation/git-fetch-pack.txt   |  2 +-
 Documentation/git-pack-objects.txt |  2 +-
 Documentation/git-push.txt         |  4 +-
 Documentation/git-rev-list.txt     | 96 +++++++++++++++++++-------------------
 Documentation/git-rev-parse.txt    |  2 +-
 Documentation/git-send-pack.txt    |  2 +-
 Documentation/git-show.txt         |  2 +-
 Documentation/gitdiffcore.txt      |  6 +--
 11 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 948b8b0..e5d2ace 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2279,18 +2279,18 @@ remote.<name>.skipFetchAll::
 
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
-	option \--receive-pack of linkgit:git-push[1].
+	option --receive-pack of linkgit:git-push[1].
 
 remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
-	option \--upload-pack of linkgit:git-fetch-pack[1].
+	option --upload-pack of linkgit:git-fetch-pack[1].
 
 remote.<name>.tagOpt::
-	Setting this value to \--no-tags disables automatic tag following when
-	fetching from remote <name>. Setting it to \--tags will fetch every
+	Setting this value to --no-tags disables automatic tag following when
+	fetching from remote <name>. Setting it to --tags will fetch every
 	tag from remote <name>, even if they are not reachable from remote
 	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
-	override this setting. See options \--tags and \--no-tags of
+	override this setting. See options --tags and --no-tags of
 	linkgit:git-fetch[1].
 
 remote.<name>.vcs::
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 929e496..ed57c68 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -67,17 +67,17 @@ produced incorrect results if you gave these options.
 	have been completed, or to save the marks table across
 	incremental runs.  As <file> is only opened and truncated
 	at completion, the same path can also be safely given to
-	\--import-marks.
+	--import-marks.
 	The file will not be written if no new object has been
 	marked/exported.
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
-	must use the same format as produced by \--export-marks.
+	must use the same format as produced by --export-marks.
 +
 Any commits that have already been marked will not be exported again.
-If the backend uses a similar \--import-marks file, this allows for
+If the backend uses a similar --import-marks file, this allows for
 incremental bidirectional exporting of the repository by keeping the
 marks the same across runs.
 
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bf7fbd4..fd32895 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -42,13 +42,13 @@ OPTIONS
 --quiet::
 	Disable all non-fatal output, making fast-import silent when it
 	is successful.  This option disables the output shown by
-	\--stats.
+	--stats.
 
 --stats::
 	Display some basic statistics about the objects fast-import has
 	created, the packfiles they were stored into, and the
 	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with \--quiet.
+	is currently the default, but can be disabled with --quiet.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
@@ -81,12 +81,12 @@ Locations of Marks Files
 	have been completed, or to save the marks table across
 	incremental runs.  As <file> is only opened and truncated
 	at checkpoint (or completion) the same path can also be
-	safely given to \--import-marks.
+	safely given to --import-marks.
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
-	must use the same format as produced by \--export-marks.
+	must use the same format as produced by --export-marks.
 	Multiple options may be supplied to import more than one
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
@@ -179,8 +179,8 @@ fast-forward update, fast-import will skip updating that ref and instead
 prints a warning message.  fast-import will always attempt to update all
 branch refs, and does not stop on the first failure.
 
-Branch updates can be forced with \--force, but it's recommended that
-this only be used on an otherwise quiet repository.  Using \--force
+Branch updates can be forced with --force, but it's recommended that
+this only be used on an otherwise quiet repository.  Using --force
 is not necessary for an initial import into an empty repository.
 
 
@@ -231,11 +231,11 @@ Date Formats
 ~~~~~~~~~~~~
 The following date formats are supported.  A frontend should select
 the format it will use for this import by passing the format name
-in the \--date-format=<fmt> command-line option.
+in the --date-format=<fmt> command-line option.
 
 `raw`::
 	This is the Git native format and is `<time> SP <offutc>`.
-	It is also fast-import's default format, if \--date-format was
+	It is also fast-import's default format, if --date-format was
 	not specified.
 +
 The time of the event is specified by `<time>` as the number of
@@ -437,7 +437,7 @@ the email address from the other fields in the line.  Note that
 of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
 
 The time of the change is specified by `<when>` using the date format
-that was selected by the \--date-format=<fmt> command-line option.
+that was selected by the --date-format=<fmt> command-line option.
 See ``Date Formats'' above for the set of supported formats, and
 their syntax.
 
@@ -888,7 +888,7 @@ save out all current branch refs, tags and marks.
 ....
 
 Note that fast-import automatically switches packfiles when the current
-packfile reaches \--max-pack-size, or 4 GiB, whichever limit is
+packfile reaches --max-pack-size, or 4 GiB, whichever limit is
 smaller.  During an automatic packfile switch fast-import does not update
 the branch refs, tags or marks.
 
@@ -1226,7 +1226,7 @@ users of fast-import, and are offered here as suggestions.
 Use One Mark Per Commit
 ~~~~~~~~~~~~~~~~~~~~~~~
 When doing a repository conversion, use a unique mark per commit
-(`mark :<n>`) and supply the \--export-marks option on the command
+(`mark :<n>`) and supply the --export-marks option on the command
 line.  fast-import will dump a file which lists every mark and the Git
 object SHA-1 that corresponds to it.  If the frontend can tie
 the marks back to the source repository, it is easy to verify the
@@ -1291,7 +1291,7 @@ even for considerably large projects (100,000+ commits).
 
 However repacking the repository is necessary to improve data
 locality and access performance.  It can also take hours on extremely
-large projects (especially if -f and a large \--window parameter is
+large projects (especially if -f and a large --window parameter is
 used).  Since repacking is safe to run alongside readers and writers,
 run the repack in the background and let it finish when it finishes.
 There is no reason to wait to explore your new Git project!
@@ -1305,7 +1305,7 @@ Repacking Historical Data
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 If you are repacking very old imported data (e.g. older than the
 last year), consider expending some extra CPU time and supplying
-\--window=50 (or higher) when you run 'git repack'.
+--window=50 (or higher) when you run 'git repack'.
 This will take longer, but will also produce a smaller packfile.
 You only need to expend the effort once, and everyone using your
 project will benefit from the smaller repository.
@@ -1407,7 +1407,7 @@ branch, their in-memory storage size can grow to a considerable size
 fast-import automatically moves active branches to inactive status based on
 a simple least-recently-used algorithm.  The LRU chain is updated on
 each `commit` command.  The maximum number of active branches can be
-increased or decreased on the command line with \--active-branches=.
+increased or decreased on the command line with --active-branches=.
 
 per active tree
 ~~~~~~~~~~~~~~~
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 93b5067..8680f45 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -80,7 +80,7 @@ be in a separate packet, and the list must end with a flush packet.
 	the things up in .bash_profile).
 
 --exec=<git-upload-pack>::
-	Same as \--upload-pack=<git-upload-pack>.
+	Same as --upload-pack=<git-upload-pack>.
 
 --depth=<n>::
 	Limit fetching to ancestor-chains not longer than n.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index c2f76fb..bbea529 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -192,7 +192,7 @@ self-contained. Use `git index-pack --fix-thin`
 
 --shallow::
 	Optimize a pack that will be provided to a client with a shallow
-	repository.  This option, combined with \--thin, can result in a
+	repository.  This option, combined with --thin, can result in a
 	smaller pack at the cost of speed.
 
 --delta-base-offset::
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 863c30c..135d810 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -265,8 +265,8 @@ origin +master` to force a push to the `master` branch). See the
 
 --[no-]verify::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
-	default is \--verify, giving the hook a chance to prevent the
-	push.  With \--no-verify, the hook is bypassed completely.
+	default is --verify, giving the hook a chance to prevent the
+	push.  With --no-verify, the hook is bypassed completely.
 
 
 include::urls-remotes.txt[]
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 5b11922..b10ea60 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,54 +9,54 @@ git-rev-list - Lists commit objects in reverse chronological order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [ \--max-count=<number> ]
-	     [ \--skip=<number> ]
-	     [ \--max-age=<timestamp> ]
-	     [ \--min-age=<timestamp> ]
-	     [ \--sparse ]
-	     [ \--merges ]
-	     [ \--no-merges ]
-	     [ \--min-parents=<number> ]
-	     [ \--no-min-parents ]
-	     [ \--max-parents=<number> ]
-	     [ \--no-max-parents ]
-	     [ \--first-parent ]
-	     [ \--remove-empty ]
-	     [ \--full-history ]
-	     [ \--not ]
-	     [ \--all ]
-	     [ \--branches[=<pattern>] ]
-	     [ \--tags[=<pattern>] ]
-	     [ \--remotes[=<pattern>] ]
-	     [ \--glob=<glob-pattern> ]
-	     [ \--ignore-missing ]
-	     [ \--stdin ]
-	     [ \--quiet ]
-	     [ \--topo-order ]
-	     [ \--parents ]
-	     [ \--timestamp ]
-	     [ \--left-right ]
-	     [ \--left-only ]
-	     [ \--right-only ]
-	     [ \--cherry-mark ]
-	     [ \--cherry-pick ]
-	     [ \--encoding=<encoding> ]
-	     [ \--(author|committer|grep)=<pattern> ]
-	     [ \--regexp-ignore-case | -i ]
-	     [ \--extended-regexp | -E ]
-	     [ \--fixed-strings | -F ]
-	     [ \--date=(local|relative|default|iso|iso-strict|rfc|short) ]
-	     [ [ \--objects | \--objects-edge | \--objects-edge-aggressive ]
-	       [ \--unpacked ] ]
-	     [ \--pretty | \--header ]
-	     [ \--bisect ]
-	     [ \--bisect-vars ]
-	     [ \--bisect-all ]
-	     [ \--merge ]
-	     [ \--reverse ]
-	     [ \--walk-reflogs ]
-	     [ \--no-walk ] [ \--do-walk ]
-	     [ \--use-bitmap-index ]
+'git rev-list' [ --max-count=<number> ]
+	     [ --skip=<number> ]
+	     [ --max-age=<timestamp> ]
+	     [ --min-age=<timestamp> ]
+	     [ --sparse ]
+	     [ --merges ]
+	     [ --no-merges ]
+	     [ --min-parents=<number> ]
+	     [ --no-min-parents ]
+	     [ --max-parents=<number> ]
+	     [ --no-max-parents ]
+	     [ --first-parent ]
+	     [ --remove-empty ]
+	     [ --full-history ]
+	     [ --not ]
+	     [ --all ]
+	     [ --branches[=<pattern>] ]
+	     [ --tags[=<pattern>] ]
+	     [ --remotes[=<pattern>] ]
+	     [ --glob=<glob-pattern> ]
+	     [ --ignore-missing ]
+	     [ --stdin ]
+	     [ --quiet ]
+	     [ --topo-order ]
+	     [ --parents ]
+	     [ --timestamp ]
+	     [ --left-right ]
+	     [ --left-only ]
+	     [ --right-only ]
+	     [ --cherry-mark ]
+	     [ --cherry-pick ]
+	     [ --encoding=<encoding> ]
+	     [ --(author|committer|grep)=<pattern> ]
+	     [ --regexp-ignore-case | -i ]
+	     [ --extended-regexp | -E ]
+	     [ --fixed-strings | -F ]
+	     [ --date=(local|relative|default|iso|iso-strict|rfc|short) ]
+	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
+	       [ --unpacked ] ]
+	     [ --pretty | --header ]
+	     [ --bisect ]
+	     [ --bisect-vars ]
+	     [ --bisect-all ]
+	     [ --merge ]
+	     [ --reverse ]
+	     [ --walk-reflogs ]
+	     [ --no-walk ] [ --do-walk ]
+	     [ --use-bitmap-index ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 52e6826..c483100 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -147,7 +147,7 @@ can be used.
 	form as close to the original input as possible.
 
 --symbolic-full-name::
-	This is similar to \--symbolic, but it omits input that
+	This is similar to --symbolic, but it omits input that
 	are not refs (i.e. branch or tag names; or more
 	explicitly disambiguating "heads/master" form, when you
 	want to name the "master" branch when there is an
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 45c7725..b5d09f7 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -29,7 +29,7 @@ OPTIONS
 	a directory on the default $PATH.
 
 --exec=<git-receive-pack>::
-	Same as \--receive-pack=<git-receive-pack>.
+	Same as --receive-pack=<git-receive-pack>.
 
 --all::
 	Instead of explicitly specifying which refs to update,
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 4e617e6..82a4125 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -22,7 +22,7 @@ presents the merge commit in a special format as produced by
 For tags, it shows the tag message and the referenced objects.
 
 For trees, it shows the names (equivalent to 'git ls-tree'
-with \--name-only).
+with --name-only).
 
 For plain blobs, it shows the plain contents.
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c8b3e51..c579593 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -28,8 +28,8 @@ The 'git diff-{asterisk}' family works by first comparing two sets of
 files:
 
  - 'git diff-index' compares contents of a "tree" object and the
-   working directory (when '\--cached' flag is not used) or a
-   "tree" object and the index file (when '\--cached' flag is
+   working directory (when '--cached' flag is not used) or a
+   "tree" object and the index file (when '--cached' flag is
    used);
 
  - 'git diff-files' compares contents of the index file and the
@@ -142,7 +142,7 @@ merges these filepairs and creates:
 
 When the "-C" option is used, the original contents of modified files,
 and deleted files (and also unmodified files, if the
-"\--find-copies-harder" option is used) are considered as candidates
+"--find-copies-harder" option is used) are considered as candidates
 of the source files in rename/copy operation.  If the input were like
 these filepairs, that talk about a modified file fileY and a newly
 created file file0:
-- 
2.4.0.192.g5f8138b
