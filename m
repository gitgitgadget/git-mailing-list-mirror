From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2.rc2
Date: Wed, 25 Feb 2009 17:26:00 -0800
Message-ID: <7v3ae2yonr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 02:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcV2c-0003pN-5l
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 02:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbZBZB0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 20:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZBZB0Q
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 20:26:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZBZB0O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 20:26:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 90EA49D279;
	Wed, 25 Feb 2009 20:26:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8C5E9D276; Wed,
 25 Feb 2009 20:26:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 72E52AF0-03A4-11DE-8281-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111518>

A release candidate GIT 1.6.2.rc2 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2.rc2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2.rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2.rc2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.2.rc2-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------
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

* "git gc" did not work if your repository was created with an ancient =
git
  and never had any pack files in it before.

* "git mergetool" used to ignore autocrlf and other attributes
  based content rewriting.

* branch switching and merges had a silly bug that did not validate
  the correct directory when making sure an existing subdirectory is
  clean.

* "git -p cmd" when cmd is not a built-in one left the display in funny=
 state
  when killed in the middle.

--
exec >/var/tmp/1
O=3Dv1.6.2-rc2
echo O=3D$(git describe master)
git shortlog --no-merges $O..master ^maint


----------------------------------------------------------------

Changes since v1.6.2-rc1 are as follows:

Abhijit Menon-Sen (1):
      Convert git-* invocations to "git *" in the svnimport example.

Alexandre Julliard (3):
      git.el: Make sure that file lists are sorted as they are created.
      git.el: Improve the confirmation message on remove and revert.
      Add a README in the contrib/emacs directory.

Allan Caffee (1):
      trace: Fixed a minor typo in an error message.

Ben Walton (1):
      git-svn fix to avoid using strftime %z

Brian Gernhardt (1):
      git-svn: Create leading directories in create-ignore

Christian Couder (1):
      README: fix path to "gitcvs-migration.txt" and be more consistent

Eric Wong (1):
      git-svn: fix delete+add branch tracking with empty files

=46elipe Contreras (2):
      git add: trivial codestyle cleanup
      sha1_file.c: fix typo

Gerrit Pape (3):
      Documentation/git-push: --all, --mirror, --tags can not be combin=
ed
      Install builtins with the user and group of the installing person=
ality
      git-quiltimport: preserve standard input to be able to read user =
input

Giuseppe Bilotta (1):
      gitweb: fix wrong base URL when non-root DirectoryIndex

Jay Soffian (2):
      disallow providing multiple upstream branches to rebase, pull --r=
ebase
      Allow HTTP tests to run on Darwin

Johannes Schindelin (2):
      Introduce the function strip_path_suffix()
      system_path(): simplify using strip_path_suffix(), and add suffix=
 "git"

Johannes Sixt (1):
      gitattributes.txt: Path matching rules are explained in gitignore=
=2Etxt

Junio C Hamano (4):
      git-svn: fix parsing of timestamp obtained from svn
      tests: fix "export var=3Dval"
      Make sure objects/pack exists before creating a new pack
      GIT 1.6.2-rc2

Lars Noschinski (1):
      filter-branch -d: Export GIT_DIR earlier

Linus Torvalds (1):
      Support 'raw' date format

Marc Branchaud (1):
      Docs: Expand explanation of the use of + in git push refspecs.

Marcel M. Cary (2):
      gitweb: Fix warnings with override permitted but no repo override
      gitweb: Hyperlink multiple git hashes on the same commit message =
line

Matthieu Moy (2):
      Document git blame --reverse.
      More friendly message when locking the index fails.

Michael J Gruber (1):
      Fix typo in contrib/examples/git-svnimport.txt

Michael Spang (1):
      Skip timestamp differences for diff --no-index

Pete Wyckoff (1):
      git-p4: avoid syncing duplicate changes

Peter Oberndorfer (1):
      git-svn: read the dcommit url from the config file on a per remot=
e basis

SZEDER G=C3=A1bor (2):
      bash: add missing 'git merge' options
      bash: update 'git svn' options

Thomas Rast (2):
      bash completion: refactor common log, shortlog and gitk options
      bash completion: only show 'log --merge' if merging

Todd Zullinger (1):
      Documentation: Note file formats send-email accepts
