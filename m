From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2-rc1
Date: Mon, 16 Feb 2009 01:04:10 -0800
Message-ID: <7v8wo6bvn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 10:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYzQA-0001Ev-Pn
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 10:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZBPJET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 04:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZBPJES
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 04:04:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZBPJEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 04:04:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B5C5D9AF44;
	Mon, 16 Feb 2009 04:04:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 765459AF43; Mon,
 16 Feb 2009 04:04:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8A58BB8-FC08-11DD-A448-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110149>

GIT 1.6.2-rc1 is available for testing at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2-rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2-rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2-rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  testing/git-*-1.6.2-rc1-1.fc9.$arch.rpm	(RPM)


GIT v1.6.2 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=3D=
108007

for more details on the reason why this change is needed and the
transition plan.

=46or a similar reason, "git push $there :$killed" to delete the branch
$killed in a remote repository $there, if $killed branch is the current
branch pointed at by its HEAD, gets a large warning.  You can choose wh=
at
should happen upon such a push by setting the configuration variable
receive.denyDeleteCurrent in the receiving repository.


Updates since v1.6.1
--------------------

(subsystems)

* git-svn updates.

* gitweb updates, including a new patch view and RSS/Atom feed
  improvements.

* (contrib/emacs) git.el now has commands for checking out a branch,
  creating a branch, cherry-picking and reverting commits; vc-git.el
  is not shipped with git anymore (it is part of official Emacs).

(performance)

* pack-objects autodetects the number of CPUs available and uses thread=
ed
  version.

(usability, bells and whistles)

* automatic typo correction works on aliases as well

* @{-1} is a way to refer to the last branch you were on.  This is
  accepted not only where an object name is expected, but anywhere
  a branch name is expected and acts as if you typed the branch name.
  E.g. "git branch --track mybranch @{-1}", "git merge @{-1}", and
  "git rev-parse --symbolic-full-name @{-1}" would work as expected.

* When refs/remotes/origin/HEAD points at a remote tracking branch that
  has been pruned away, many git operations issued warning when they
  internally enumerated the refs.  We now warn only when you say "origi=
n"
  to refer to that pruned branch.

* The location of .mailmap file can be configured, and its file format =
was
  enhanced to allow mapping an incorrect e-mail field as well.

* "git add -p" learned 'g'oto action to jump directly to a hunk.

* "git add -p" learned to find a hunk with given text with '/'.

* "git add -p" optionally can be told to work with just the command let=
ter
  without Enter.

* when "git am" stops upon a patch that does not apply, it shows the
  title of the offending patch.

* "git am --directory=3D<dir>" and "git am --reject" passes these optio=
ns
  to underlying "git apply".

* "git am" learned --ignore-date option.

* "git blame" aligns author names better when they are spelled in
  non US-ASCII encoding.

* "git clone" now makes its best effort when cloning from an empty
  repository to set up configuration variables to refer to the remote
  repository.

* "git checkout -" is a shorthand for "git checkout @{-1}".

* "git cherry" defaults to whatever the current branch is tracking (if
  exists) when the <upstream> argument is not given.

* "git cvsserver" can be told not to add extra "via git-CVS emulator" t=
o
  the commit log message it serves via gitcvs.commitmsgannotation
  configuration.

* "git cvsserver" learned to handle 'noop' command some CVS clients see=
m
  to expect to work.

* "git diff" learned a new option --inter-hunk-context to coalesce clos=
e
  hunks together and show context between them.

* The definition of what constitutes a word for "git diff --color-words=
"
  can be customized via gitattributes, command line or a configuration.

* "git diff" learned --patience to run "patience diff" algorithm.

* "git filter-branch" learned --prune-empty option that discards commit=
s
  that do not change the contents.

* "git fsck" now checks loose objects in alternate object stores, inste=
ad
  of misreporting them as missing.

* "git gc --prune" was resurrected to allow "git gc --no-prune" and
  giving non-default expiration period e.g. "git gc --prune=3Dnow".

* "git grep -w" and "git grep" for fixed strings have been optimized.

* "git mergetool" learned -y(--no-prompt) option to disable prompting.

* "git rebase -i" can transplant a history down to root to elsewhere
  with --root option.

* "git reset --merge" is a new mode that works similar to the way
  "git checkout" switches branches, taking the local changes while
  switching to another commit.

* "git submodule update" learned --no-fetch option.

* "git tag" learned --contains that works the same way as the same opti=
on
  from "git branch".


=46ixes since v1.6.1
------------------

All of the fixes in v1.6.1.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.1.X series.

* "git-add sub/file" when sub is a submodule incorrectly added the path=
 to
  the superproject.

* "git bundle" did not exclude annotated tags even when a range given
  from the command line wanted to.

* "git filter-branch" unnecessarily refused to work when you had
  checked out a different commit from what is recorded in the superproj=
ect
  index in a submodule.

* "git filter-branch" incorrectly tried to update a nonexistent work tr=
ee
  at the end when it is run in a bare repository.

* "git mergetool" used to ignore autocrlf and other attributes
  based content rewriting.

* branch switching and merges had a silly bug that did not validate
  the correct directory when making sure an existing subdirectory is
  clean.

* "git -p cmd" when cmd is not a built-in one left the display in funny=
 state
  when killed in the middle.


----------------------------------------------------------------

Changes since v1.6.2-rc0 are as follows:

Alexandre Julliard (1):
      Describe notable git.el changes in the release notes

Anton Gyllenberg (1):
      test case for regression caused by git-svn empty symlink fix

Christian Couder (1):
      rev-list: fix showing distance when using --bisect-all

Deskin Miller (1):
      git-svn: Print revision while searching for earliest use of path

D=C3=A9vai Tam=C3=A1s (1):
      git-svn: Fix for rewriteRoot URL containing username.

Elijah Newren (1):
      fast-export: ensure we traverse commits in topological order

Eric Kidd (1):
      filter-branch: Add more error-handling

Eric Wong (2):
      git-svn: allow disabling expensive broken symlink checks
      git-svn: fix broken symlink workaround when switching branches

=46abian Franz (1):
      submodule: add --no-fetch parameter to update command

Jacob Helwig (1):
      Add 'rm -f' equivalent to 'git rm' example of filter-branch --ind=
ex-filter

Jakub Narebski (1):
      gitweb: Better regexp for SHA-1 committag match

Jeff King (1):
      symbolic-ref: allow refs/<whatever> in HEAD

Jeremy White (1):
      Update documentation to add further information about using Thund=
erbird with git-imap-send.

Johannes Schindelin (4):
      Let ls-files strip trailing slashes in submodules' paths
      submodule: warn about non-submodules
      Add two extra tests for git rebase
      gc: make --prune useful again by accepting an optional parameter

Johannes Sixt (4):
      Make test-path-utils more robust against incorrect use
      Move sanitary_path_copy() to path.c and rename it to normalize_pa=
th_copy()
      Test and fix normalize_path_copy()
      Remove unused normalize_absolute_path()

Junio C Hamano (16):
      Revert "Merge branch 'js/notes'"
      Modernize t5400 test script
      remote prune: warn dangling symrefs
      Warn use of "origin" when remotes/origin/HEAD is dangling
      Drop double-semicolon in C
      receive-pack: receive.denyDeleteCurrent
      builtin-receive-pack.c: do not initialize statics to 0
      revision traversal and pack: notice and die on missing commit
      Squelch overzealous "ignoring dangling symref" in an empty reposi=
tory
      Make repack less likely to corrupt repository
      Prepare for 1.6.1.4.
      Revert "validate_headref: tighten ref-matching to just branches"
      Install the default "master" branch configuration after cloning a=
 void
      Teach the "@{-1} syntax to "git branch"
      Teach @{-1} to git merge
      RelNotes Update

Keith Cascio (1):
      Remove redundant bit clears from diff_setup()

Lars Hjemli (1):
      tree.c: allow read_tree_recursive() to traverse gitlink entries

Marcel M. Cary (1):
      git-sh-setup: Use "cd" option, not /bin/pwd, for symlinked work t=
ree

Marius Storm-Olsen (5):
      Add mailmap.file as configurational option for mailmap location
      Add find_insert_index, insert_at_index and clear_func functions t=
o string_list
      Add map_user() and clear_mailmap() to mailmap
      Change current mailmap usage to do matching on both name and emai=
l of author/committer.
      Move mailmap documentation into separate file

Mark Burton (1):
      git-rebase.txt: --interactive does not work with --whitespace

Matt Kraai (1):
      bash-completion: Complete the values of color.interactive, color.=
ui, color.pager

Matt McCutchen (1):
      gitweb: add $prevent_xss option to prevent XSS by repository cont=
ent

Michael J Gruber (1):
      Fix the installation path for html documentation

Nazri Ramliy (1):
      Bugfix: GIT_EXTERNAL_DIFF with more than one changed files

Pat Notz (1):
      Fix contrib/hooks/post-receive-email for new duplicate branch

Ren=C3=A9 Scharfe (2):
      Fix GIT_CEILING_DIRECTORIES on Windows
      builtin-receive-pack.c: fix compiler warnings about format string

SZEDER G=C3=A1bor (3):
      Move 'rev-parse --git-dir' test to t1500
      t1500: more 'git rev-parse --git-dir' tests
      bash: fix misspelled 'git svn' option

Sam Vilain (1):
      git-svn: abstract out a block into new method other_gs()

Santi B=C3=A9jar (1):
      doc/bundle: Use the more conventional suffix '.bundle'

Shawn O. Pearce (2):
      Clear the delta base cache during fast-import checkpoint
      Clear the delta base cache if a pack is rebuilt

Sitaram Chamarty (1):
      Documentation: clarify commits affected by gitk --merge

Stephan Beyer (3):
      add -p: get rid of Git.pm warnings about unitialized values
      Makefile: resort filenames alphabetically
      Generalize and libify index_is_dirty() to index_differs_from(...)

Tay Ray Chuan (1):
      use a hash of the lock token as the suffix for PUT/MOVE

Ted Pavlic (2):
      completion: Fix GIT_PS1_SHOWDIRTYSTATE to prevent unbound variabl=
e errors.
      completion: Get rid of tabbed indentation in comments. Replace wi=
th spaces.

Thomas Rast (2):
      log: do not print ellipses with --abbrev-commit
      Documentation: pruning recipe for destructive filter-branch

Todd Zullinger (1):
      git-web--browse: Fix check for /bin/start
