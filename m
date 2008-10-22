From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0.3
Date: Tue, 21 Oct 2008 22:43:21 -0700
Message-ID: <7v3aipw5fq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 07:44:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsWWZ-0005NU-Rm
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 07:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbYJVFne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2008 01:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbYJVFne
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 01:43:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbYJVFnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 01:43:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 10C628EB83;
	Wed, 22 Oct 2008 01:43:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3CA9F8EB81; Wed, 22 Oct 2008 01:43:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5BBBB59E-9FFC-11DD-82C7-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98828>

The latest maintenance release GIT 1.6.0.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.0.3-1.fc9.$arch.rpm	(RPM)

This one is larger than usual, as I took two weeks off since 1.6.0.2.

----------------------------------------------------------------

GIT v1.6.0.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.0.2
--------------------

* "git archive --format=3Dzip" did not honor core.autocrlf while
  --format=3Dtar did.

* Continuing "git rebase -i" was very confused when the user left modif=
ied
  files in the working tree while resolving conflicts.

* Continuing "git rebase -i" was also very confused when the user left
  some staged changes in the index after "edit".

* "git rebase -i" now honors the pre-rebase hook, just like the
  other rebase implementations "git rebase" and "git rebase -m".

* "git rebase -i" incorrectly aborted when there is no commit to replay=
=2E

* Behaviour of "git diff --quiet" was inconsistent with "diff --exit-co=
de"
  with the output redirected to /dev/null.

* "git diff --no-index" on binary files no longer outputs a bogus
  "diff --git" header line.

* "git diff" hunk header patterns with multiple elements separated by L=
=46
  were not used correctly.

* Hunk headers in "git diff" default to using extended regular
  expressions, fixing some of the internal patterns on non-GNU
  platforms.

* New config "diff.*.xfuncname" exposes extended regular expressions
  for user specified hunk header patterns.

* "git gc" when ejecting otherwise unreachable objects from packfiles i=
nto
  loose form leaked memory.

* "git index-pack" was recently broken and mishandled objects added by
  thin-pack completion processing under memory pressure.

* "git index-pack" was recently broken and misbehaved when run from ins=
ide
  .git/objects/pack/ directory.

* "git stash apply sash@{1}" was fixed to error out.  Prior versions
  would have applied stash@{0} incorrectly.

* "git stash apply" now offers a better suggestion on how to continue
  if the working tree is currently dirty.

* "git for-each-ref --format=3D%(subject)" fixed for commits with no
  no newline in the message body.

* "git remote" fixed to protect printf from user input.

* "git remote show -v" now displays all URLs of a remote.

* "git checkout -b branch" was confused when branch already existed.

* "git checkout -q" once again suppresses the locally modified file lis=
t.

* "git clone -q", "git fetch -q" asks remote side to not send
  progress messages, actually making their output quiet.

* Cross-directory renames are no longer used when creating packs.  This
  allows more graceful behavior on filesystems like sshfs.

* Stale temporary files under $GIT_DIR/objects/pack are now cleaned up
  automatically by "git prune".

* "git merge" once again removes directories after the last file has
  been removed from it during the merge.

* "git merge" did not allocate enough memory for the structure itself w=
hen
  enumerating the parents of the resulting commit.

* "git blame -C -C" no longer segfaults while trying to pass blame if
   it encounters a submodule reference.

* "git rm" incorrectly claimed that you have local modifications when a
  path was merely stat-dirty.

* "git svn" fixed to display an error message when 'set-tree' failed,
   instead of a Perl compile error.

* "git submodule" fixed to handle checking out a different commit
  than HEAD after initializing the submodule.

* The "git commit" error message when there are still unmerged
  files present was clarified to match "git write-tree".

* "git init" was confused when core.bare or core.sharedRepository are s=
et
  in system or user global configuration file by mistake.  When --bare =
or
  --shared is given from the command line, these now override such
  settings made outside the repositories.

* Some segfaults due to uncaught NULL pointers were fixed in multiple
  tools such as apply, reset, update-index.

* Solaris builds now default to OLD_ICONV=3D1 to avoid compile warnings=
;
  Solaris 8 does not define NEEDS_LIBICONV by default.

* "Git.pm" tests relied on unnecessarily more recent version of Perl.

* "gitweb" triggered undef warning on commits without log messages.

* "gitweb" triggered undef warnings on missing trees.

* "gitweb" now removes PATH_INFO from its URLs so users don't have
  to manually set the URL in the gitweb configuration.

* Bash completion removed support for legacy "git-fetch", "git-push"
  and "git-pull" as these are no longer installed.  Dashless form
  ("git fetch") is still however supported.

Many other documentation updates.

----------------------------------------------------------------

Changes since v1.6.0.2 are as follows:

Abhijit Bhopatkar (1):
      Documentation: Clarify '--signoff' for git-commit

Alec Berryman (2):
      git-svn: factor out svnserve test code for later use
      git-svn: Always create a new RA when calling do_switch for svn://

Alex Riesen (3):
      Remove empty directories in recursive merge
      Add remove_path: a function to remove as much as possible of a pa=
th
      Use remove_path from dir.c instead of own implementation

Alexander Gavrilov (1):
      builtin-blame: Fix blame -C -C with submodules.

Bj=C3=B6rn Steinbrink (1):
      force_object_loose: Fix memory leak

Brandon Casey (14):
      t9700/test.pl: avoid bareword 'STDERR' in 3-argument open()
      t9700/test.pl: remove File::Temp requirement
      diff.c: return pattern entry pointer rather than just the hunk he=
ader pattern
      diff.c: associate a flag with each pattern and use it for compili=
ng regex
      diff.*.xfuncname which uses "extended" regex's for hunk header se=
lection
      t4018-diff-funcname: test syntax of builtin xfuncname patterns
      builtin-prune.c: prune temporary packs in <object_dir>/pack direc=
tory
      git-stash.sh: don't default to refs/stash if invalid ref supplied
      builtin-merge.c: allocate correct amount of memory
      git-stash.sh: fix flawed fix of invalid ref handling (commit da65=
e7c1)
      remote.c: correct the check for a leading '/' in a remote name
      t4018-diff-funcname: rework negated last expression test
      t4018-diff-funcname: demonstrate end of line funcname matching fl=
aw
      xdiff-interface.c: strip newline (and cr) from line before patter=
n matching

Charles Bailey (2):
      Add new test to demonstrate git archive core.autocrlf inconsisten=
cy
      Make git archive respect core.autocrlf when creating zip format a=
rchives

Chris Frey (1):
      Documentation: clarify the details of overriding LESS via core.pa=
ger

Dan McGee (1):
      contrib: update packinfo.pl to not use dashed commands

Daniel Barkalow (1):
      Check early that a new branch is new and valid

David Soria Parra (1):
      Solaris: Use OLD_ICONV to avoid compile warnings

Deskin Miller (2):
      maint: check return of split_cmdline to avoid bad config strings
      git init: --bare/--shared overrides system/global config

Dmitry Potapov (4):
      git-rebase-interactive: do not squash commits on abort
      git-rebase--interactive: auto amend only edited commit
      make prefix_path() never return NULL
      do not segfault if make_cache_entry failed

Eric Raible (1):
      completion: git commit should list --interactive

Eric Wong (1):
      git-svn: fix handling of even funkier branch names

=46abrizio Chiarello (1):
      builtin-clone: fix typo

Garry Dolley (1):
      Clarified gitattributes documentation regarding custom hunk heade=
r.

Giuseppe Bilotta (1):
      gitweb: remove PATH_INFO from $my_url and $my_uri

Heikki Orsila (2):
      Start conforming code to "git subcmd" style part 3
      Cosmetical command name fix

Imre Deak (1):
      builtin-apply: fix typo leading to stack corruption

Jakub Narebski (2):
      gitweb: Fix two 'uninitialized value' warnings in git_tree()
      gitweb: Add path_info tests to t/t9500-gitweb-standalone-no-error=
s.sh

Jeff King (3):
      Makefile: do not set NEEDS_LIBICONV for Solaris 8
      git apply --directory broken for new files
      tests: shell negation portability fix

Joey Hess (1):
      gitweb: avoid warnings for commits without body

Johan Herland (2):
      for-each-ref: Fix --format=3D%(subject) for log message without n=
ewlines
      Use strchrnul() instead of strchr() plus manual workaround

Johannes Schindelin (2):
      git rm: refresh index before up-to-date check
      rebase -i: do not fail when there is no commit to cherry-pick

Johannes Sixt (2):
      git-remote: do not use user input in a printf format string
      git-push.txt: Describe --repo option in more detail

Jonas Fonseca (2):
      checkout: Do not show local changes when in quiet mode
      git-check-attr(1): add output and example sections

Junio C Hamano (15):
      discard_cache: reset lazy name_hash bit
      diff Porcelain: do not disable auto index refreshing on -C -C
      diff --quiet: make it synonym to --exit-code >/dev/null
      Don't verify host name in SSL certs when GIT_SSL_NO_VERIFY is set
      Fix permission bits on sources checked out with an overtight umas=
k
      checkout: do not lose staged removal
      diff/diff-files: do not use --cc too aggressively
      Start draft release notes for 1.6.0.3
      diff: use extended regexp to find hunk headers
      diff hunk pattern: fix misconverted "\{" tex macro introducers
      Update draft release notes to 1.6.0.3
      diff(1): clarify what "T"ypechange status means
      Hopefully the final draft release notes update before 1.6.0.3
      Fix testcase failure when extended attributes are in use
      GIT 1.6.0.3

Linus Torvalds (1):
      fix bogus "diff --git" header from "diff --no-index"

Luc Heinrich (1):
      git-svn: call 'fatal' correctly in set-tree

Matt McCutchen (1):
      t1301-shared-repo.sh: don't let a default ACL interfere with the =
test

Michael J Gruber (1):
      make "git remote" report multiple URLs

Michael Prokop (1):
      Replace svn.foo.org with svn.example.com in git-svn docs (RFC 260=
6)

Mikael Magnusson (4):
      Typo "bogos" in format-patch error message.
      git-repack uses --no-repack-object, not --no-repack-delta.
      Fix a few typos in relnotes
      Typo "does not exists" when git remote update remote.

Miklos Vajna (2):
      test-lib: fix color reset in say_color()
      Add testcase to ensure merging an early part of a branch is done =
properly

Nanako Shiraishi (2):
      docs: describe pre-rebase hook
      Teach rebase -i to honor pre-rebase hook

Nicolas Pitre (2):
      fix pread()'s short read in index-pack
      rehabilitate 'git index-pack' inside the object store

Petr Baudis (1):
      Do not perform cross-directory renames when creating packs

Ping Yin (1):
      git-submodule: Fix "Unable to checkout" for the initial 'update'

Rafael Garcia-Suarez (1):
      Clarify commit error message for unmerged files

SZEDER G=C3=A1bor (5):
      t0024: add executable permission
      Documentation: remove '\' in front of short options
      rebase -i: proper prepare-commit-msg hook argument when squashing
      rebase -i: remove leftover debugging
      bash: remove fetch, push, pull dashed form leftovers

Samuel Tardieu (1):
      Do not use errno when pread() returns 0

Shawn O. Pearce (3):
      Update release notes for 1.6.0.3
      Update release notes for 1.6.0.3
      test-lib: fix broken printf

Stephen Haberman (1):
      Clarify how the user can satisfy stash's 'dirty state' check.

Thomas Rast (1):
      sha1_file: link() returns -1 on failure, not errno

Todd Zullinger (1):
      Use dashless git commands in setgitperms.perl

Tuncer Ayaz (1):
      Fix fetch/clone --quiet when stdout is connected

Yann Dirson (1):
      Bust the ghost of long-defunct diffcore-pathspec.

martin f. krafft (1):
      Improve git-log documentation wrt file filters
