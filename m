From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/5] Docs: Use "-l::\n--long\n" format in OPTIONS sections
Date: Sun,  8 Jun 2008 03:36:09 +0200
Message-ID: <1212888972-29039-2-git-send-email-s-beyer@gmx.net>
References: <7vy75hlzvv.fsf@gitster.siamese.dyndns.org>
 <1212888972-29039-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 03:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59qz-0000Pn-Su
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 03:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbYFHBgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 21:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYFHBgp
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 21:36:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:37001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755653AbYFHBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 21:36:35 -0400
Received: (qmail invoked by alias); 08 Jun 2008 01:36:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp001) with SMTP; 08 Jun 2008 03:36:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+pOvAntLipqgbVIZVUpdYhBssOl1n67KDeNog/RN
	1ZB+XEJep8jPBr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K59pM-0007Yn-S9; Sun, 08 Jun 2008 03:36:12 +0200
X-Mailer: git-send-email 1.5.6.rc1.21.g03300
In-Reply-To: <1212888972-29039-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84246>

The OPTIONS section of a documentation file contains a list
of the options a git command accepts.
Currently there are several variants to describe the case that
different options (almost) do the same in the OPTIONS section.
Some are:
 -f, --foo::
 -f|--foo::
 -f | --foo::

But AsciiDoc has the special form:
 -f::
 --foo::

This patch
 * applies this form to the documentation of the whole git suite,
 * removes useless em-dash prevention, so \--foo becomes --foo.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

Although the patch is large, it's not a big thing and nonetheless easily 
reviewed, I hope.

For those who are unsure about the \--foo => --foo conversion:
AsciiDoc converts a "--" word to an "em dash" (&#8212; in HTML).
But it does NOT do this on something like --foo.
So \--foo is a useless escaping which just leads to confusion :)

Regards,
  Stephan

 Documentation/blame-options.txt          |    6 +++-
 Documentation/fetch-options.txt          |   30 +++++++++++++--------
 Documentation/git-add.txt                |   16 +++++++----
 Documentation/git-am.txt                 |   24 +++++++++++-----
 Documentation/git-apply.txt              |    9 ++++--
 Documentation/git-archive.txt            |    6 +++-
 Documentation/git-blame.txt              |    6 +++-
 Documentation/git-branch.txt             |    3 +-
 Documentation/git-checkout-index.txt     |   15 +++++++---
 Documentation/git-checkout.txt           |    3 +-
 Documentation/git-cherry-pick.txt        |   12 +++++---
 Documentation/git-commit.txt             |   42 ++++++++++++++++++++----------
 Documentation/git-config.txt             |    9 ++++--
 Documentation/git-cvsserver.txt          |    7 +++-
 Documentation/git-daemon.txt             |   12 +++++---
 Documentation/git-diff-files.txt         |    3 +-
 Documentation/git-fetch-pack.txt         |   22 ++++++++-------
 Documentation/git-filter-branch.txt      |    3 +-
 Documentation/git-fmt-merge-msg.txt      |    6 +++-
 Documentation/git-for-each-ref.txt       |    5 +++-
 Documentation/git-format-patch.txt       |   15 +++++++---
 Documentation/git-grep.txt               |   37 +++++++++++++++++++-------
 Documentation/git-help.txt               |   12 +++++---
 Documentation/git-http-push.txt          |    3 +-
 Documentation/git-init.txt               |    3 +-
 Documentation/git-instaweb.txt           |   15 +++++++---
 Documentation/git-ls-files.txt           |   30 ++++++++++++++-------
 Documentation/git-ls-remote.txt          |    8 ++++-
 Documentation/git-mv.txt                 |    3 +-
 Documentation/git-pack-objects.txt       |    3 +-
 Documentation/git-pack-refs.txt          |    4 +-
 Documentation/git-peek-remote.txt        |    2 +-
 Documentation/git-prune.txt              |    2 +-
 Documentation/git-pull.txt               |    6 ++--
 Documentation/git-push.txt               |   23 +++++++++-------
 Documentation/git-rebase.txt             |   15 +++++++---
 Documentation/git-repack.txt             |    3 +-
 Documentation/git-rev-parse.txt          |   12 +++++---
 Documentation/git-revert.txt             |   12 +++++---
 Documentation/git-rm.txt                 |   10 ++++---
 Documentation/git-send-email.txt         |   12 +++++---
 Documentation/git-send-pack.txt          |   14 +++++-----
 Documentation/git-shortlog.txt           |   12 +++++---
 Documentation/git-show-branch.txt        |    6 +++-
 Documentation/git-show-ref.txt           |   21 ++++++++++-----
 Documentation/git-stripspace.txt         |    3 +-
 Documentation/git-submodule.txt          |    9 ++++--
 Documentation/git-symbolic-ref.txt       |    3 +-
 Documentation/git-update-index.txt       |    6 +++-
 Documentation/git-update-server-info.txt |    3 +-
 Documentation/git-upload-pack.txt        |    4 +-
 Documentation/git-web--browse.txt        |    9 ++++--
 Documentation/git.txt                    |    3 +-
 Documentation/gitk.txt                   |    3 +-
 Documentation/merge-options.txt          |    9 ++++--
 Documentation/rev-list-options.txt       |   30 ++++++++++++++-------
 56 files changed, 394 insertions(+), 210 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index c11bb7d..5428111 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -41,7 +41,8 @@ of lines before or after the line given by <start>.
 -S <revs-file>::
 	Use revs from revs-file instead of calling linkgit:git-rev-list[1].
 
--p, --porcelain::
+-p::
+--porcelain::
 	Show in a format designed for machine consumption.
 
 --incremental::
@@ -83,5 +84,6 @@ alphanumeric characters that git must detect as moving
 between files for it to associate those lines with the parent
 commit.
 
--h, --help::
+-h::
+--help::
 	Show help message.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index b675911..85c8718 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,22 +1,26 @@
--q, \--quiet::
+-q::
+--quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
 	used programs.
 
--v, \--verbose::
+-v::
+--verbose::
 	Be verbose.
 
--a, \--append::
+-a::
+--append::
 	Append ref names and object names of fetched refs to the
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
-\--upload-pack <upload-pack>::
+--upload-pack <upload-pack>::
 	When given, and the repository to fetch from is handled
 	by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
 	the command to specify non-default path for the command
 	run on the other end.
 
--f, \--force::
+-f::
+--force::
 	When `git-fetch` is used with `<rbranch>:<lbranch>`
 	refspec, it refuses to update the local branch
 	`<lbranch>` unless the remote branch `<rbranch>` it
@@ -24,16 +28,18 @@
 	overrides that check.
 
 ifdef::git-pull[]
-\--no-tags::
+--no-tags::
 endif::git-pull[]
 ifndef::git-pull[]
--n, \--no-tags::
+-n::
+--no-tags::
 endif::git-pull[]
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
 	This option disables this automatic tag following.
 
--t, \--tags::
+-t::
+--tags::
 	Most of the tags are fetched automatically as branch
 	heads are downloaded, but tags that do not point at
 	objects reachable from the branch heads that are being
@@ -41,10 +47,12 @@ endif::git-pull[]
 	flag lets all tags and their associated objects be
 	downloaded.
 
--k, \--keep::
+-k::
+--keep::
 	Keep downloaded pack.
 
--u, \--update-head-ok::
+-u::
+--update-head-ok::
 	By default `git-fetch` refuses to update the head which
 	corresponds to the current branch.  This flag disables the
 	check.  This is purely for the internal use for `git-pull`
@@ -52,7 +60,7 @@ endif::git-pull[]
 	implementing your own Porcelain you are not supposed to
 	use it.
 
-\--depth=<depth>::
+--depth=<depth>::
 	Deepen the history of a 'shallow' repository created by
 	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
 	by the specified number of commits.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 88165da..9c6b081 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -50,22 +50,26 @@ OPTIONS
 	and `dir/file2`) can be given to add all files in the
 	directory, recursively.
 
--n, \--dry-run::
+-n::
+--dry-run::
         Don't actually add the file(s), just show if they exist.
 
--v, \--verbose::
+-v::
+--verbose::
         Be verbose.
 
 -f::
 	Allow adding otherwise ignored files.
 
--i, \--interactive::
+-i::
+--interactive::
 	Add modified contents in the working tree interactively to
 	the index. Optional path arguments may be supplied to limit
 	operation to a subset of the working tree. See ``Interactive
 	mode'' for details.
 
--p, \--patch::
+-p::
+--patch::
 	Similar to Interactive mode but the initial command loop is
 	bypassed and the 'patch' subcommand is invoked using each of
 	the specified filepatterns before exiting.
@@ -79,11 +83,11 @@ OPTIONS
 	command line. If no paths are specified, all tracked files in the
 	current directory and its subdirectories are updated.
 
-\--refresh::
+--refresh::
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
-\--ignore-errors::
+--ignore-errors::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 7f6f5b4..46544a0 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -28,14 +28,17 @@ OPTIONS
 	supply this argument, reads from the standard input. If you supply
 	directories, they'll be treated as Maildirs.
 
--s, --signoff::
+-s::
+--signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
 
--k, --keep::
+-k::
+--keep::
 	Pass `-k` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
 
--u, --utf8::
+-u::
+--utf8::
 	Pass `-u` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
@@ -49,13 +52,15 @@ default.   You could use `--no-utf8` to override this.
 	Pass `-n` flag to `git-mailinfo` (see
 	linkgit:git-mailinfo[1]).
 
--3, --3way::
+-3::
+--3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge, if the patch records the identity of blobs
 	it is supposed to apply to, and we have those blobs
 	available locally.
 
--b, --binary::
+-b::
+--binary::
 	Pass `--allow-binary-replacement` flag to `git-apply`
 	(see linkgit:git-apply[1]).
 
@@ -64,19 +69,22 @@ default.   You could use `--no-utf8` to override this.
 	program that applies
 	the patch.
 
--C<n>, -p<n>::
+-C<n>::
+-p<n>::
 	These flags are passed to the `git-apply` (see linkgit:git-apply[1])
 	program that applies
 	the patch.
 
--i, --interactive::
+-i::
+--interactive::
 	Run interactively.
 
 --skip::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
--r, --resolved::
+-r::
+--resolved::
 	After a patch failure (e.g. attempting to apply
 	conflicting patch), the user has applied it by hand and
 	the index file stores the result of the application.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 76277bd..c834763 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -73,7 +73,8 @@ OPTIONS
 When a pure mode change is encountered (which has no index information),
 the information is read from the current index instead.
 
--R, --reverse::
+-R::
+--reverse::
 	Apply the patch in reverse.
 
 --reject::
@@ -124,7 +125,8 @@ discouraged.
 	the result with this option, which would apply the
 	deletion part but not addition part.
 
---allow-binary-replacement, --binary::
+--allow-binary-replacement::
+--binary::
 	Historically we did not allow binary patch applied
 	without an explicit permission from the user, and this
 	flag was the way to do so.  Currently we always allow binary
@@ -169,7 +171,8 @@ behavior:
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
--v, --verbose::
+-v::
+--verbose::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index a3e36db..9b5f3ae 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -36,10 +36,12 @@ OPTIONS
 	Format of the resulting archive: 'tar' or 'zip'.  The default
 	is 'tar'.
 
---list, -l::
+-l::
+--list::
 	Show all available formats.
 
---verbose, -v::
+-v::
+--verbose::
 	Report progress to stderr.
 
 --prefix=<prefix>/::
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 7900f33..8f4fb46 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -52,12 +52,14 @@ include::blame-options.txt[]
 	a certain threshold for git-blame to consider those lines
 	of code to have been moved.
 
--f, --show-name::
+-f::
+--show-name::
 	Show filename in the original commit.  By default
 	filename is shown if there is any line that came from a
 	file with different name, due to rename detection.
 
--n, --show-number::
+-n::
+--show-number::
 	Show line number in the original commit (Default: off).
 
 -s::
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index a70fa76..0fd5808 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -95,7 +95,8 @@ OPTIONS
 -a::
 	List both remote-tracking branches and local branches.
 
--v, --verbose::
+-v::
+--verbose::
 	Show sha1 and commit subject line for each head.
 
 --abbrev=<length>::
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index a8cad9c..676203b 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -22,21 +22,26 @@ Will copy all files listed from the index to the working directory
 
 OPTIONS
 -------
--u|--index::
+-u::
+--index::
 	update stat information for the checked out entries in
 	the index file.
 
--q|--quiet::
+-q::
+--quiet::
 	be quiet if files exist or are not in the index
 
--f|--force::
+-f::
+--force::
 	forces overwrite of existing files
 
--a|--all::
+-a::
+--all::
 	checks out all files in the index.  Cannot be used
 	together with explicit filenames.
 
--n|--no-create::
+-n::
+--no-create::
 	Don't checkout new files, only refresh files already checked
 	out.
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a5bf9d6..3ad9760 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -47,7 +47,8 @@ OPTIONS
 	by linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
--t, --track::
+-t::
+--track::
 	When creating a new branch, set up configuration so that git-pull
 	will automatically retrieve data from the start point, which must be
 	a branch. Use this if you always pull from the same upstream branch
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 3762272..5ac9cfb 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -22,7 +22,8 @@ OPTIONS
 	For a more complete list of ways to spell commits, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
--e|--edit::
+-e::
+--edit::
 	With this option, `git-cherry-pick` will let you edit the commit
 	message prior to committing.
 
@@ -44,14 +45,16 @@ OPTIONS
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
 
--m parent-number|--mainline parent-number::
+-m parent-number::
+--mainline parent-number::
 	Usually you cannot cherry-pick a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
 	the mainline and allows cherry-pick to replay the change
 	relative to the specified parent.
 
--n|--no-commit::
+-n::
+--no-commit::
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was
 	cherry-picked.  This flag applies the change necessary
@@ -64,7 +67,8 @@ OPTIONS
 This is useful when cherry-picking more than one commits'
 effect to your working tree in a row.
 
--s|--signoff::
+-s::
+--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a94b4e3..7502a31 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -52,21 +52,25 @@ that, you can recover from it with linkgit:git-reset[1].
 
 OPTIONS
 -------
--a|--all::
+-a::
+--all::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
 	told git about are not affected.
 
--C <commit>|--reuse-message=<commit>::
+-C <commit>::
+--reuse-message=<commit>::
 	Take existing commit object, and reuse the log message
 	and the authorship information (including the timestamp)
 	when creating the commit.
 
--c <commit>|--reedit-message=<commit>::
+-c <commit>::
+--reedit-message=<commit>::
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
--F <file>|--file=<file>::
+-F <file>::
+--file=<file>::
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
 
@@ -74,20 +78,24 @@ OPTIONS
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
 
--m <msg>|--message=<msg>::
+-m <msg>::
+--message=<msg>::
 	Use the given <msg> as the commit message.
 
--t <file>|--template=<file>::
+-t <file>::
+--template=<file>::
 	Use the contents of the given file as the initial version
 	of the commit message. The editor is invoked and you can
 	make subsequent changes. If a message is specified using
 	the `-m` or `-F` options, this option has no effect. This
 	overrides the `commit.template` configuration variable.
 
--s|--signoff::
+-s::
+--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--n|--no-verify::
+-n::
+--no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
 	See also linkgit:githooks[5][hooks].
 
@@ -107,7 +115,8 @@ OPTIONS
 	'whitespace' removes just leading/trailing whitespace lines
 	and 'strip' removes both whitespace and commentary.
 
--e|--edit::
+-e::
+--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
 	commit log message unmodified.  This option lets you
@@ -134,13 +143,15 @@ It is a rough equivalent for:
 but can be used to amend a merge commit.
 --
 
--i|--include::
+-i::
+--include::
 	Before making a commit out of staged contents so far,
 	stage the contents of paths given on the command line
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
--o|--only::
+-o::
+--only::
 	Make a commit only from the paths specified on the
 	command line, disregarding any contents that have been
 	staged so far. This is the default mode of operation of
@@ -151,20 +162,23 @@ but can be used to amend a merge commit.
 	the last commit without committing changes that have
 	already been staged.
 
--u|--untracked-files::
+-u::
+--untracked-files::
 	Show all untracked files, also those in uninteresting
 	directories, in the "Untracked files:" section of commit
 	message template.  Without this option only its name and
 	a trailing slash are displayed for each untracked
 	directory.
 
--v|--verbose::
+-v::
+--verbose::
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
 	lines prefixed with '#'.
 
--q|--quiet::
+-q::
+--quiet::
 	Suppress commit summary message.
 
 \--::
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 84b754f..c90421e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -101,7 +101,8 @@ rather than from all available files.
 +
 See also <<FILES>>.
 
--f config-file, --file config-file::
+-f config-file::
+--file config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
 
 --remove-section::
@@ -116,7 +117,8 @@ See also <<FILES>>.
 --unset-all::
 	Remove all lines matching the key from config file.
 
--l, --list::
+-l::
+--list::
 	List all variables set in config file.
 
 --bool::
@@ -128,7 +130,8 @@ See also <<FILES>>.
 	in the config file will cause the value to be multiplied
 	by 1024, 1048576, or 1073741824 prior to output.
 
--z, --null::
+-z::
+--null::
 	For all options that output values and/or keys, always
 	end values with the null character (instead of a
 	newline). Use newline instead as a delimiter between
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index b772113..3310ae2 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -41,10 +41,13 @@ Don't allow recursing into subdirectories
 Don't check for `gitcvs.enabled` in config. You also have to specify a list
 of allowed directories (see below) if you want to use this option.
 
---version, -V::
+-V::
+--version::
 Print version information and exit
 
---help, -h, -H::
+-h::
+-H::
+--help::
 Print usage information and exit
 
 <directory>::
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 3fb71d6..344f24e 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -103,7 +103,8 @@ OPTIONS
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
 
---user-path, --user-path=path::
+--user-path::
+--user-path=path::
 	Allow ~user notation to be used in requests.  When
 	specified with no parameter, requests to
 	git://host/~alice/foo is taken as a request to access
@@ -127,7 +128,8 @@ OPTIONS
 	Save the process id in 'file'.  Ignored when the daemon
 	is run under `--inetd`.
 
---user=user, --group=group::
+--user=user::
+--group=group::
 	Change daemon's uid and gid before entering the service loop.
 	When only `--user` is given without `--group`, the
 	primary group ID for the user is used.  The values of
@@ -138,14 +140,16 @@ Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
 `git-daemon` if needed.
 
---enable=service, --disable=service::
+--enable=service::
+--disable=service::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with an configuration
 	item.
 
---allow-override=service, --forbid-override=service::
+--allow-override=service::
+--forbid-override=service::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	are overridable.
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index ed9bd75..8a64869 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -30,7 +30,8 @@ The default is to diff against our branch (-2) and the
 cleanly resolved paths.  The option -0 can be given to
 omit diff output for unmerged entries and just show "Unmerged".
 
--c,--cc::
+-c::
+--cc::
 	This compares stage 2 (our branch), stage 3 (their
 	branch) and the working tree file and outputs a combined
 	diff, similar to the way 'diff-tree' shows a merge
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 6ee3dcc..282fcaf 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -28,30 +28,32 @@ have a common ancestor commit.
 
 OPTIONS
 -------
-\--all::
+--all::
 	Fetch all remote refs.
 
-\--quiet, \-q::
+-q::
+--quiet::
 	Pass '-q' flag to 'git-unpack-objects'; this makes the
 	cloning process less verbose.
 
-\--keep, \-k::
+-k::
+--keep::
 	Do not invoke 'git-unpack-objects' on received data, but
 	create a single packfile out of it instead, and store it
 	in the object database. If provided twice then the pack is
 	locked against repacking.
 
-\--thin::
+--thin::
 	Spend extra cycles to minimize the number of objects to be sent.
 	Use it on slower connection.
 
-\--include-tag::
+--include-tag::
 	If the remote side supports it, annotated tags objects will
 	be downloaded on the same connection as the other objects if
 	the object the tag references is downloaded.  The caller must
 	otherwise determine the tags this option made available.
 
-\--upload-pack=<git-upload-pack>::
+--upload-pack=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if is not found on your $PATH.
 	Installations of sshd ignores the user's environment
@@ -63,16 +65,16 @@ OPTIONS
 	shells by having a lean .bashrc file (they set most of
 	the things up in .bash_profile).
 
-\--exec=<git-upload-pack>::
+--exec=<git-upload-pack>::
 	Same as \--upload-pack=<git-upload-pack>.
 
-\--depth=<n>::
+--depth=<n>::
 	Limit fetching to ancestor-chains not longer than n.
 
-\--no-progress::
+--no-progress::
 	Do not show the progress.
 
-\-v::
+-v::
 	Run verbosely.
 
 <host>::
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 4406068..ea77f1f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -161,7 +161,8 @@ to other tags will be rewritten to point to the underlying commit.
 	does this in the '.git-rewrite/' directory but you can override
 	that choice by this parameter.
 
--f|--force::
+-f::
+--force::
 	`git filter-branch` refuses to start with an existing temporary
 	directory or when there are already refs starting with
 	'refs/original/', unless forced.
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 328cc54..2a7cfb9 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -33,11 +33,13 @@ OPTIONS
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---summary,--no-summary::
+--summary::
+--no-summary::
 	Synonyms to --log and --no-log; these are deprecated and will be
 	removed in the future.
 
---file <file>, -F <file>::
+-F <file>::
+--file <file>::
 	Take the list of merged objects from <file> instead of
 	stdin.
 
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6325ff9..b347bfb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -53,7 +53,10 @@ OPTIONS
 	literally, in the latter case matching completely or from the
 	beginning up to a slash.
 
---shell, --perl, --python, --tcl::
+--shell::
+--perl::
+--python::
+--tcl::
 	If given, strings that substitute `%(fieldname)`
 	placeholders are quoted as string literals suitable for
 	the specified host language.  This is meant to produce
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index cdee642..4dafa39 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -74,14 +74,17 @@ include::diff-options.txt[]
 -<n>::
 	Limits the number of patches to prepare.
 
--o|--output-directory <dir>::
+-o <dir>::
+--output-directory <dir>::
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
 
--n|--numbered::
+-n::
+--numbered::
 	Name output in '[PATCH n/m]' format.
 
--N|--no-numbered::
+-N::
+--no-numbered::
 	Name output in '[PATCH]' format.
 
 --start-number <n>::
@@ -92,11 +95,13 @@ include::diff-options.txt[]
 	without the default first line of the commit appended.
 	Mutually exclusive with the --stdout option.
 
--k|--keep-subject::
+-k::
+--keep-subject::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
--s|--signoff::
+-s::
+--signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 13b9cf7..1b646b7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -33,25 +33,30 @@ OPTIONS
 	Instead of searching in the working tree files, check
 	the blobs registered in the index file.
 
--a | --text::
+-a::
+--text::
 	Process binary files as if they were text.
 
--i | --ignore-case::
+-i::
+--ignore-case::
 	Ignore case differences between the patterns and the
 	files.
 
 -I::
 	Don't match the pattern in binary files.
 
--w | --word-regexp::
+-w::
+--word-regexp::
 	Match the pattern only at word boundary (either begin at the
 	beginning of a line, or preceded by a non-word character; end at
 	the end of a line or followed by a non-word character).
 
--v | --invert-match::
+-v::
+--invert-match::
 	Select non-matching lines.
 
--h | -H::
+-h::
+-H::
 	By default, the command shows the filename for each
 	match.  `-h` option is used to suppress this output.
 	`-H` is there for completeness and does not do anything
@@ -64,24 +69,33 @@ OPTIONS
 	option forces paths to be output relative to the project
 	top directory.
 
--E | --extended-regexp | -G | --basic-regexp::
+-E::
+--extended-regexp::
+-G::
+--basic-regexp::
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
 
--F | --fixed-strings::
+-F::
+--fixed-strings::
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
 -n::
 	Prefix the line number to matching lines.
 
--l | --files-with-matches | --name-only | -L | --files-without-match::
+-l::
+--files-with-matches::
+--name-only::
+-L::
+--files-without-match::
 	Instead of showing every matched line, show only the
 	names of files that contain (or do not contain) matches.
 	For better compatibility with git-diff, --name-only is a
 	synonym for --files-with-matches.
 
--c | --count::
+-c::
+--count::
 	Instead of showing every matched line, show the number of
 	lines that match.
 
@@ -103,7 +117,10 @@ OPTIONS
 	scripts passing user input to grep.  Multiple patterns are
 	combined by 'or'.
 
---and | --or | --not | ( | )::
+--and::
+--or::
+--not::
+( ... )::
 	Specify how multiple patterns are combined using Boolean
 	expressions.  `--or` is the default operator.  `--and` has
 	higher precedence than `--or`.  `-e` has to be used for all
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 8994c6d..faecd6b 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -28,15 +28,18 @@ former is internally converted into the latter.
 
 OPTIONS
 -------
--a|--all::
+-a::
+--all::
 	Prints all the available commands on the standard output. This
 	option supersedes any other option.
 
--i|--info::
+-i::
+--info::
 	Display manual page for the command in the 'info' format. The
 	'info' program will be used for that purpose.
 
--m|--man::
+-m::
+--man::
 	Display manual page for the command in the 'man' format. This
 	option may be used to override a value set in the
 	'help.format' configuration variable.
@@ -45,7 +48,8 @@ By default the 'man' program will be used to display the manual page,
 but the 'man.viewer' configuration variable may be used to choose
 other display programs (see below).
 
--w|--web::
+-w::
+--web::
 	Display manual page for the command in the 'web' (HTML)
 	format. A web browser will be used for that purpose.
 +
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 143291d..8d32a92 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -40,7 +40,8 @@ OPTIONS
 	Report the list of objects being walked locally and the
 	list of objects successfully sent to the remote repository.
 
--d, -D::
+-d::
+-D::
 	Remove <ref> from remote repository.  The specified branch
 	cannot be the remote HEAD.  If -d is specified the following
 	other conditions must also be met:
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index c48b615..792643c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -16,7 +16,8 @@ OPTIONS
 
 --
 
--q, \--quiet::
+-q::
+--quiet::
 
 Only print error and warning messages, all other output will be suppressed.
 
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 11e6a81..7da5b8d 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -20,24 +20,29 @@ repository.
 OPTIONS
 -------
 
--l|--local::
+-l::
+--local::
 	Only bind the web server to the local IP (127.0.0.1).
 
--d|--httpd::
+-d::
+--httpd::
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
 	Currently lighttpd, apache2 and webrick are supported.
 	(Default: lighttpd)
 
--m|--module-path::
+-m::
+--module-path::
 	The module path (only needed if httpd is Apache).
 	(Default: /usr/lib/apache2/modules)
 
--p|--port::
+-p::
+--port::
 	The port number to bind the httpd to.  (Default: 1234)
 
--b|--browser::
+-b::
+--browser::
 	The web browser that should be used to view the gitweb
 	page. This will be passed to the 'git-web--browse' helper
 	script along with the URL of the gitweb instance. See
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1b0b212..560594e 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -30,23 +30,29 @@ shown:
 
 OPTIONS
 -------
--c|--cached::
+-c::
+--cached::
 	Show cached files in the output (default)
 
--d|--deleted::
+-d::
+--deleted::
 	Show deleted files in the output
 
--m|--modified::
+-m::
+--modified::
 	Show modified files in the output
 
--o|--others::
+-o::
+--others::
 	Show other files in the output
 
--i|--ignored::
+-i::
+--ignored::
 	Show ignored files in the output.
 	Note that this also reverses any exclude list present.
 
--s|--stage::
+-s::
+--stage::
 	Show stage files in the output
 
 --directory::
@@ -56,10 +62,12 @@ OPTIONS
 --no-empty-directory::
 	Do not list empty directories. Has no effect without --directory.
 
--u|--unmerged::
+-u::
+--unmerged::
 	Show unmerged files in the output (forces --stage)
 
--k|--killed::
+-k::
+--killed::
 	Show files on the filesystem that need to be removed due
 	to file/directory conflicts for checkout-index to
 	succeed.
@@ -67,11 +75,13 @@ OPTIONS
 -z::
 	\0 line termination on output.
 
--x|--exclude=<pattern>::
+-x <pattern>::
+--exclude=<pattern>::
 	Skips files matching pattern.
 	Note that pattern is a shell wildcard pattern.
 
--X|--exclude-from=<file>::
+-X <file>::
+--exclude-from=<file>::
 	exclude patterns are read from <file>; 1 per line.
 
 --exclude-per-directory=<file>::
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 8ad7a94..f92f3ca 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -20,13 +20,17 @@ commit IDs.
 
 OPTIONS
 -------
--h|--heads, -t|--tags::
+-h::
+--heads::
+-t::
+--tags::
 	Limit to only refs/heads and refs/tags, respectively.
 	These options are _not_ mutually exclusive; when given
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
--u <exec>, --upload-pack=<exec>::
+-u <exec>::
+--upload-pack=<exec>::
 	Specify the full path of linkgit:git-upload-pack[1] on the remote
 	host. This allows listing references from repositories accessed via
 	SSH and where the SSH daemon does not use the PATH configured by the
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index fb485de..3391906 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -34,7 +34,8 @@ OPTIONS
 	condition. An error happens when a source is neither existing nor
         controlled by GIT, or when it would overwrite an existing
         file unless '-f' is given.
--n, \--dry-run::
+-n::
+--dry-run::
 	Do nothing; only show what would happen
 
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d5a87ef..f4d8d68 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -79,7 +79,8 @@ base-name::
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native git clients.
 
---window=[N], --depth=[N]::
+--window=[N]::
+--depth=[N]::
 	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
 	objects are first internally sorted by type, size and
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index fa48681..c071846 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -42,7 +42,7 @@ unpacked.
 OPTIONS
 -------
 
-\--all::
+--all::
 
 The command by default packs all tags and refs that are already
 packed, and leaves other refs
@@ -51,7 +51,7 @@ developed and packing their tips does not help performance.
 This option causes branch tips to be packed as well.  Useful for
 a repository with many branches of historical interests.
 
-\--no-prune::
+--no-prune::
 
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index 56be1b6..ffbf93a 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -16,7 +16,7 @@ This command is deprecated; use `git-ls-remote` instead.
 
 OPTIONS
 -------
-\--upload-pack=<git-upload-pack>::
+--upload-pack=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if it is not found on your $PATH. Some
 	installations of sshd ignores the user's environment
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7283d07..ec335d6 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -37,7 +37,7 @@ OPTIONS
 \--::
 	Do not interpret any more arguments as options.
 
-\--expire <time>::
+--expire <time>::
 	Only expire loose objects older than <time>.
 
 <head>...::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c522ce..5f55f64 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -30,7 +30,7 @@ include::merge-options.txt[]
 
 :git-pull: 1
 
-\--rebase::
+--rebase::
 	Instead of a merge, perform a rebase after fetching.  If
 	there is a remote ref for the upstream branch, and this branch
 	was rebased since last fetched, the rebase uses that information
@@ -43,8 +43,8 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
-\--no-rebase::
-	Override earlier \--rebase.
+--no-rebase::
+	Override earlier --rebase.
 
 include::fetch-options.txt[]
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 9d8c379..89e0049 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -61,11 +61,11 @@ already exists on the remote side.  This is the default operation mode
 if no explicit refspec is found (that is neither on the command line
 nor in any Push line of the corresponding remotes file---see below).
 
-\--all::
+--all::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
-\--mirror::
+--mirror::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` and `$GIT_DIR/refs/tags/`
 	be mirrored to the remote repository.  Newly created local
@@ -75,39 +75,42 @@ nor in any Push line of the corresponding remotes file---see below).
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
-\--dry-run::
+--dry-run::
 	Do everything except actually send the updates.
 
-\--tags::
+--tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
 	line.
 
-\--receive-pack=<git-receive-pack>::
+--receive-pack=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
 
-\--exec=<git-receive-pack>::
+--exec=<git-receive-pack>::
 	Same as \--receive-pack=<git-receive-pack>.
 
--f, \--force::
+-f::
+--force::
 	Usually, the command refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
 
-\--repo=<repo>::
+--repo=<repo>::
 	When no repository is specified the command defaults to
 	"origin"; this overrides it.
 
-\--thin, \--no-thin::
+--thin::
+--no-thin::
 	These options are passed to `git-send-pack`.  Thin
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
--v, \--verbose::
+-v::
+--verbose::
 	Run verbosely.
 
 include::urls-remotes.txt[]
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index cc48bee..7166414 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,19 +213,22 @@ OPTIONS
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
--m, \--merge::
+-m::
+--merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.
 
--s <strategy>, \--strategy=<strategy>::
+-s <strategy>::
+--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).  This implies --merge.
 
--v, \--verbose::
+-v::
+--verbose::
 	Display a diffstat of what changed upstream since the last rebase.
 
 -C<n>::
@@ -238,12 +241,14 @@ OPTIONS
 	This flag is passed to the `git-apply` program
 	(see linkgit:git-apply[1]) that applies the patch.
 
--i, \--interactive::
+-i::
+--interactive::
 	Make a list of the commits which are about to be rebased.  Let the
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
 
--p, \--preserve-merges::
+-p::
+--preserve-merges::
 	Instead of ignoring merges, try to recreate them.  This option
 	only works in interactive mode.
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 793dcca..04d6f1f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -73,7 +73,8 @@ OPTIONS
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See gitlink:git-update-server-info[1].
 
---window=[N], --depth=[N]::
+--window=[N]::
+--depth=[N]::
 	These two options affect how the objects contained in the pack are
 	stored using delta compression. The objects are first internally
 	sorted by type, size and optionally names and compared against the
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index a0ef1fd..9e273bc 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -52,7 +52,8 @@ OPTIONS
 	The parameter given must be usable as a single, valid
 	object name.  Otherwise barf and abort.
 
--q, --quiet::
+-q::
+--quiet::
 	Only meaningful in `--verify` mode. Do not output an error
 	message if the first argument is not a valid object name;
 	instead exit with non-zero status silently.
@@ -119,16 +120,19 @@ OPTIONS
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
 
---short, --short=number::
+--short::
+--short=number::
 	Instead of outputting the full SHA1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
 	7 is used. The minimum length is 4.
 
---since=datestring, --after=datestring::
+--since=datestring::
+--after=datestring::
 	Parses the date string, and outputs corresponding
 	--max-age= parameter for git-rev-list command.
 
---until=datestring, --before=datestring::
+--until=datestring::
+--before=datestring::
 	Parses the date string, and outputs corresponding
 	--min-age= parameter for git-rev-list command.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 5e6adfc..5b49b81 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -22,12 +22,14 @@ OPTIONS
 	For a more complete list of ways to spell commit names, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
--e|--edit::
+-e::
+--edit::
 	With this option, `git-revert` will let you edit the commit
 	message prior to committing the revert. This is the default if
 	you run the command from a terminal.
 
--m parent-number|--mainline parent-number::
+-m parent-number::
+--mainline parent-number::
 	Usually you cannot revert a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
@@ -38,7 +40,8 @@ OPTIONS
 	With this option, `git-revert` will not start the commit
 	message editor.
 
--n|--no-commit::
+-n::
+--no-commit::
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was reverted.
 	This flag applies the change necessary to revert the
@@ -51,7 +54,8 @@ OPTIONS
 This is useful when reverting more than one commits'
 effect to your working tree in a row.
 
--s|--signoff::
+-s::
+--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
 
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index da3fe59..d88554b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -38,7 +38,8 @@ OPTIONS
 -f::
 	Override the up-to-date check.
 
--n, \--dry-run::
+-n::
+--dry-run::
 	Don't actually remove any file(s).  Instead, just show
 	if they exist in the index and would otherwise be removed
 	by the command.
@@ -52,15 +53,16 @@ OPTIONS
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
 
-\--cached::
+--cached::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
 	left alone.
 
-\--ignore-unmatch::
+--ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
--q, \--quiet::
+-q::
+--quiet::
 	git-rm normally outputs one line (in the form of an "rm" command)
 	for each file removed. This option suppresses that output.
 
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a295837..251d661 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -40,7 +40,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---chain-reply-to, --no-chain-reply-to::
+--chain-reply-to::
+--no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -65,7 +66,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---signed-off-by-cc, --no-signed-off-by-cc::
+--signed-off-by-cc::
+--no-signed-off-by-cc::
         If this is set, add emails found in Signed-off-by: or Cc: lines to the
         cc list.
         Default is the value of 'sendemail.signedoffcc' configuration value;
@@ -141,7 +143,8 @@ user is prompted for a password while the input is masked for privacy.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---suppress-from, --no-suppress-from::
+--suppress-from::
+--no-suppress-from::
         If this is set, do not add the From: address to the cc: list.
         Default is the value of 'sendemail.suppressfrom' configuration value;
         if that is unspecified, default to --no-suppress-from.
@@ -157,7 +160,8 @@ user is prompted for a password while the input is masked for privacy.
 	if that is unspecified, default to 'self' if --suppress-from is
 	specified, as well as 'sob' if --no-signed-off-cc is specified.
 
---thread, --no-thread::
+--thread::
+--no-thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
 	header set.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 850c351..ba2fdae 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -21,33 +21,33 @@ updates it from the current repository, sending named refs.
 
 OPTIONS
 -------
-\--receive-pack=<git-receive-pack>::
+--receive-pack=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
 
-\--exec=<git-receive-pack>::
+--exec=<git-receive-pack>::
 	Same as \--receive-pack=<git-receive-pack>.
 
-\--all::
+--all::
 	Instead of explicitly specifying which refs to update,
 	update all heads that locally exist.
 
-\--dry-run::
+--dry-run::
 	Do everything except actually send the updates.
 
-\--force::
+--force::
 	Usually, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  What this means is that
 	the remote repository can lose commits; use it with
 	care.
 
-\--verbose::
+--verbose::
 	Run verbosely.
 
-\--thin::
+--thin::
 	Spend extra cycles to minimize the number of objects to be sent.
 	Use it on slower connection.
 
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 5079b56..daa64d4 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -22,17 +22,21 @@ Additionally, "[PATCH]" will be stripped from the commit description.
 OPTIONS
 -------
 
--h, \--help::
+-h::
+--help::
 	Print a short usage message and exit.
 
--n, \--numbered::
+-n::
+--numbered::
 	Sort output according to the number of commits per author instead
 	of author alphabetic order.
 
--s, \--summary::
+-s::
+--summary::
 	Suppress commit description and provide a commit count summary only.
 
--e, \--email::
+-e::
+--email::
 	Show the email address of each author.
 
 -w[<width>[,<indent1>[,<indent2>]]]::
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 32595ad..de9e8f8 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -38,10 +38,12 @@ OPTIONS
 	branches under $GIT_DIR/refs/heads/topic, giving
 	`topic/*` would show all of them.
 
--r|--remotes::
+-r::
+--remotes::
 	Show the remote-tracking branches.
 
--a|--all::
+-a::
+--all::
 	Show both remote-tracking branches and local branches.
 
 --current::
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index a85332c..6b99529 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -29,22 +29,26 @@ in the `.git` directory.
 OPTIONS
 -------
 
--h, --head::
+-h::
+--head::
 
 	Show the HEAD reference.
 
---tags, --heads::
+--tags::
+--heads::
 
 	Limit to only "refs/heads" and "refs/tags", respectively.  These
 	options are not mutually exclusive; when given both, references stored
 	in "refs/heads" and "refs/tags" are displayed.
 
--d, --dereference::
+-d::
+--dereference::
 
 	Dereference tags into object IDs as well. They will be shown with "^{}"
 	appended.
 
--s, --hash::
+-s::
+--hash::
 
 	Only show the SHA1 hash, not the reference name. When also using
 	--dereference the dereferenced tag will still be shown after the SHA1.
@@ -55,17 +59,20 @@ OPTIONS
 	Aside from returning an error code of 1, it will also print an error
 	message if '--quiet' was not specified.
 
---abbrev, --abbrev=len::
+--abbrev::
+--abbrev=len::
 
 	Abbreviate the object name.  When using `--hash`, you do
 	not have to say `--hash --abbrev`; `--hash=len` would do.
 
--q, --quiet::
+-q::
+--quiet::
 
 	Do not print any results to stdout. When combined with '--verify' this
 	can be used to silently check if a reference exists.
 
---exclude-existing, --exclude-existing=pattern::
+--exclude-existing::
+--exclude-existing=pattern::
 
 	Make git-show-ref act as a filter that reads refs from stdin of the
 	form "^(?:<anything>\s)?<refname>(?:\^\{\})?$" and performs the
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 4883834..8421a39 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -16,7 +16,8 @@ Remove multiple empty lines, and empty lines at beginning and end.
 
 OPTIONS
 -------
--s|--strip-comments::
+-s::
+--strip-comments::
 	In addition to empty lines, also strip lines starting with '#'.
 
 <stream>::
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 139206f..441ae14 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -61,10 +61,12 @@ summary::
 
 OPTIONS
 -------
--q, --quiet::
+-q::
+--quiet::
 	Only print error messages.
 
--b, --branch::
+-b::
+--branch::
 	Branch of repository to add as submodule.
 
 --cached::
@@ -72,7 +74,8 @@ OPTIONS
 	commands typically use the commit found in the submodule HEAD, but
 	with this option, the commit stored in the index is used instead.
 
--n, --summary-limit::
+-n::
+--summary-limit::
 	This option is only valid for the summary command.
 	Limit the summary size (number of commits shown in total).
 	Giving 0 will disable the summary; a negative number means unlimited
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index e9b996b..3d3a059 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -26,7 +26,8 @@ a regular file whose contents is `ref: refs/heads/master`.
 OPTIONS
 -------
 
--q, --quiet::
+-q::
+--quiet::
 	Do not issue an error message if the <name> is not a
 	symbolic ref but a detached HEAD; instead exit with
 	non-zero status silently.
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c703365..bbb0a6a 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -76,7 +76,8 @@ OPTIONS
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.
 
---assume-unchanged, --no-assume-unchanged::
+--assume-unchanged::
+--no-assume-unchanged::
 	When these flags are specified, the object name recorded
 	for the paths are not updated.  Instead, these options
 	sets and unsets the "assume unchanged" bit for the
@@ -88,7 +89,8 @@ OPTIONS
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
 
---again, -g::
+-g::
+--again::
 	Runs `git-update-index` itself on the paths whose index
 	entries are different from those from the `HEAD` commit.
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index aa1ee67..d21be41 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -22,7 +22,8 @@ generates such auxiliary files.
 OPTIONS
 -------
 
--f|--force::
+-f::
+--force::
 	Update the info files from scratch.
 
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 521da5b..bac465e 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -24,10 +24,10 @@ repository.  For push operations, see 'git-send-pack'.
 OPTIONS
 -------
 
-\--strict::
+--strict::
 	Do not try <directory>/.git/ if <directory> is no git directory.
 
-\--timeout=<n>::
+--timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
 
 <directory>::
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index f8d5fb1..e80a7c1 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -31,14 +31,17 @@ Custom commands may also be specified.
 
 OPTIONS
 -------
--b BROWSER|--browser=BROWSER::
+-b BROWSER::
+--browser=BROWSER::
 	Use the specified BROWSER. It must be in the list of supported
 	browsers.
 
--t BROWSER|--tool=BROWSER::
+-t BROWSER::
+--tool=BROWSER::
 	Same as above.
 
--c CONF.VAR|--config=CONF.VAR::
+-c CONF.VAR::
+--config=CONF.VAR::
 	CONF.VAR is looked up in the git config files. If it's set,
 	then its value specify the browser that should be used.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ba07e51..763e70c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -137,7 +137,8 @@ help ...'.
 	environment variable. If no path is given 'git' will print
 	the current setting and then exit.
 
--p|--paginate::
+-p::
+--paginate::
 	Pipe all output into 'less' (or if set, $PAGER).
 
 --no-pager::
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 14bcf91..f843f39 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -25,7 +25,8 @@ To control which revisions to shown, the command takes options applicable to
 the linkgit:git-rev-list[1] command. This manual page describes only the most
 frequently used options.
 
--n <number>, --max-count=<number>::
+-n <number>::
+--max-count=<number>::
 
 	Limits the number of commits to show.
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index f37a776..ffbc6e9 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -2,10 +2,12 @@
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat.
 
--n, \--no-stat::
+-n::
+--no-stat::
 	Do not show diffstat at the end of the merge.
 
---summary, \--no-summary::
+--summary::
+--no-summary::
 	Synonyms to --stat and --no-stat; these are deprecated and will be
 	removed in the future.
 
@@ -49,7 +51,8 @@
 	a fast-forward, only update the branch pointer. This is
 	the default behavior of git-merge.
 
--s <strategy>, \--strategy=<strategy>::
+-s <strategy>::
+--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 05d5abe..37dd1d6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -129,7 +129,8 @@ limiting may be applied.
 
 --
 
--n 'number', --max-count='number'::
+-n 'number'::
+--max-count='number'::
 
 	Limit the number of commits output.
 
@@ -137,21 +138,25 @@ limiting may be applied.
 
 	Skip 'number' commits before starting to show the commit output.
 
---since='date', --after='date'::
+--since='date'::
+--after='date'::
 
 	Show commits more recent than a specific date.
 
---until='date', --before='date'::
+--until='date'::
+--before='date'::
 
 	Show commits older than a specific date.
 
 ifdef::git-rev-list[]
---max-age='timestamp', --min-age='timestamp'::
+--max-age='timestamp'::
+--min-age='timestamp'::
 
 	Limit the commits output to specified time range.
 endif::git-rev-list[]
 
---author='pattern', --committer='pattern'::
+--author='pattern'::
+--committer='pattern'::
 
 	Limit the commits output to ones with author/committer
 	header lines that match the specified pattern (regular expression).
@@ -161,16 +166,19 @@ endif::git-rev-list[]
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
 
--i, --regexp-ignore-case::
+-i::
+--regexp-ignore-case::
 
 	Match the regexp limiting patterns without regard to letters case.
 
--E, --extended-regexp::
+-E::
+--extended-regexp::
 
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
--F, --fixed-strings::
+-F::
+--fixed-strings::
 
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
@@ -239,7 +247,8 @@ from the other branch (for example, "3rd on b" may be cherry-picked
 from branch A).  With this option, such pairs of commits are
 excluded from the output.
 
--g, --walk-reflogs::
+-g::
+--walk-reflogs::
 
 	Instead of walking the commit ancestry chain, walk
 	reflog entries from the most recent one to older ones.
@@ -268,7 +277,8 @@ See also linkgit:git-reflog[1].
 	Output uninteresting commits at the boundary, which are usually
 	not shown.
 
---dense, --sparse::
+--dense::
+--sparse::
 
 When optional paths are given, the default behaviour ('--dense') is to
 only output commits that changes at least one of them, and also ignore
-- 
1.5.5.1
